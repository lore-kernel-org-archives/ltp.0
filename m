From: Li Wang <liwang@redhat.com>
Date: Wed, 21 Mar 2018 14:53:00 +0800
Subject: [LTP] [bug?] Access was denied by memory protection keys in
 execute-only address
In-Reply-To: <20180320215828.GA5825@ram.oc3035372033.ibm.com>
References: <CAEemH2f0LDqyR5AmUYv17OuBc5-UycckDPWgk46XU_ghQo4diw@mail.gmail.com>
 <871sguep4v.fsf@concordia.ellerman.id.au>
 <20180308164545.GM1060@ram.oc3035372033.ibm.com>
 <CAEemH2czWDjvJLpL6ynV1+VxCFh_-A-d72tJhA5zwgrAES2nWA@mail.gmail.com>
 <20180320215828.GA5825@ram.oc3035372033.ibm.com>
Message-ID: <CAEemH2eewab4nsn6daMRAtn9tDrHoZb_PnbH8xA17ypFCTg6iA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Wed, Mar 21, 2018 at 5:58 AM, Ram Pai <linuxram@us.ibm.com> wrote:

> On Fri, Mar 09, 2018 at 11:43:00AM +0800, Li Wang wrote:
> >    On Fri, Mar 9, 2018 at 12:45 AM, Ram Pai <[1]linuxram@us.ibm.com>
> wrote:
> >
> >      On Thu, Mar 08, 2018 at 11:19:12PM +1100, Michael Ellerman wrote:
> >      > Li Wang <[2]liwang@redhat.com> writes:
> >      > > Hi,
> >      > >
> >      > > ltp/mprotect04[1] crashed by SEGV_PKUERR on ppc64(LPAR on P730,
> >      Power 8
> >      > > 8247-22L) with kernel-v4.16.0-rc4.
> >      > >
> >      > > 10000000-10020000 r-xp 00000000 fd:00 167223
>  mprotect04
> >      > > 10020000-10030000 r--p 00010000 fd:00 167223
>  mprotect04
> >      > > 10030000-10040000 rw-p 00020000 fd:00 167223
>  mprotect04
> >      > > 1001a380000-1001a3b0000 rw-p 00000000 00:00 0          [heap]
> >      > > 7fffa6c60000-7fffa6c80000 --xp 00000000 00:00 0 ​
> >      > >
> >      > > ​&exec_func = 0x10030170​
> >      > >
> >      > > ​&func = 0x7fffa6c60170​
> >      > >
> >      > > ​While perform ​
> >      > > "(*func)();" we get the
> >      > > ​segmentation fault.
> >      > > ​
> >      > >
> >      > > ​strace log:​
> >      > >
> >      > > -------------------
> >      > > ​mprotect(0x7fffaed00000, 131072, PROT_EXEC) = 0
> >      > > rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
> >      > > --- SIGSEGV {si_signo=SIGSEGV, si_code=SEGV_PKUERR,
> >      si_addr=0x7fffaed00170}
> >      > > ---​
> >      >
> >      > Looks like a bug to me.
> >      >
> >      > Please Cc linuxppc-dev on powerpc bugs.
> >      >
> >      > I also can't reproduce this failure on my machine.
> >      > Not sure what's going on?
> >
> >      I could reproduce it on a power7 lpar.  But not on a power8 lpar.
> >
> >      The problem seems to be that the cpu generates a key exception if
> >      the page with Read/Write-disable-but-execute-enable key is executed
> >      on power7. If I enable read on that key, the exception disappears.
> >
> >    After adding read permission on that key, reproducer get PASS on my
> power8
> >    machine too.​
> >    ​(​mprotect(..,PROT_READ | PROT_EXEC))​
> >
> >
> >      BTW: the testcase executes
> >      ​​mprotect(..,PROT_EXEC).
> >      The mprotect(, PROT_EXEC) system call internally generates a
> >      execute-only key and associates it with the pages in the
> address-range.
> >
> >      Now since Li Wang claims that he can reproduce it on power8 as
> well, i
> >      am wondering if the slightly different cpu behavior is dependent on
> the
> >      version of the firmware/microcode?
> >
> >    ​I also run this reproducer on series ppc kvm machines, but none of
> them
> >    get the FAIL.
> >    If you need some more HW info, pls let me know.​
>
> Hi Li,
>
>    Can you try the following patch and see if it solves your problem.
>

​It only works on power7 lpar machine.

But for p8 lpar, it still get failure as that before, the thing I wondered
is
that why not disable the pkey_execute_disable_supported on p8 machine?

I tried to modify your patch and get PASS with the mprotect04 test on
power8 lpar machine.

--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -105,7 +105,9 @@ int pkey_initialize(void)
         * The device tree cannot be relied to indicate support for
         * execute_disable support. Instead we use a PVR check.
         */
-       if (pvr_version_is(PVR_POWER7) || pvr_version_is(PVR_POWER7p))
+       if (pvr_version_is(PVR_POWER7) || pvr_version_is(PVR_POWER7p) \
+               || pvr_version_is(PVR_POWER8E) ||
pvr_version_is(PVR_POWER8NVL) \
+               || pvr_version_is(PVR_POWER8))
                pkey_execute_disable_supported = false;
        else
                pkey_execute_disable_supported = true;
@@ -395,7 +397,7 @@ int __arch_override_mprotect_pkey(struct vm_area_struct
*vma, int prot,
         * The requested protection is execute-only. Hence let's use an
         * execute-only pkey.
         */
-       if (prot == PROT_EXEC) {
+       if (prot == PROT_EXEC && pkey_execute_disable_supported) {
                pkey = execute_only_pkey(vma->vm_mm);
                if (pkey > 0)
                        return pkey;




>
>
> diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
> index c269817..184a10a 100644
> --- a/arch/powerpc/mm/pkeys.c
> +++ b/arch/powerpc/mm/pkeys.c
> @@ -421,7 +421,7 @@ int __arch_override_mprotect_pkey(struct
> vm_area_struct *vma, int prot,
>          * The requested protection is execute-only. Hence let's use an
>          * execute-only pkey.
>          */
> -       if (prot == PROT_EXEC) {
> ​​
> +       if (prot == PROT_EXEC && pkey_execute_disable_supported) {
>                 pkey = execute_only_pkey(vma->vm_mm);
>                 if (pkey > 0)
>                         return pkey;
>
>
> Thanks
> RP
>
>


-- 
Li Wang
liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180321/62336474/attachment-0001.html>
