From: Pengfei Xu <pengfei.xu@intel.com>
Date: Sun, 29 Sep 2019 14:34:55 +0800
Subject: [LTP] [PATCH] umip_basic_test.c: update umip basic test for new
 kernel v5.4
In-Reply-To: <CAEemH2dGOcpSmD=BkvQZW=JTtbpkoUSN+tqffkDu+jV=vJsUqA@mail.gmail.com>
References: <20190927034635.28521-1-pengfei.xu@intel.com>
 <CAEemH2dGOcpSmD=BkvQZW=JTtbpkoUSN+tqffkDu+jV=vJsUqA@mail.gmail.com>
Message-ID: <20190929063455.ympb34kmlmrgxbl2@xpf-desktop>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li Wang,

  My feedback is as below, thanks!

On 2019-09-29 at 11:47:21 +0800, Li Wang wrote:
> On Fri, Sep 27, 2019 at 11:39 AM Pengfei Xu <pengfei.xu@intel.com> wrote:
> 
> > After linux kernel v5.4 mainline, 64bit SGDT SIDT SMSW will return
> > dummy value and not trigger SIGSEGV due to kernel code change.
> > For detailed kernel update info, you could check v5.4 commit:
> > x86/umip: Add emulation (spoofing) for UMIP covered instructions in
> > 64-bit processes as well
> >
> > Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
> > ---
> >  testcases/kernel/security/umip/umip_basic_test.c | 25
> > ++++++++++++++++++++++--
> >  1 file changed, 23 insertions(+), 2 deletions(-)
> >
> > diff --git a/testcases/kernel/security/umip/umip_basic_test.c
> > b/testcases/kernel/security/umip/umip_basic_test.c
> > index 37850ef9f..278ae92f6 100644
> > --- a/testcases/kernel/security/umip/umip_basic_test.c
> > +++ b/testcases/kernel/security/umip/umip_basic_test.c
> > @@ -21,6 +21,7 @@
> >  #include <string.h>
> >  #include <sys/wait.h>
> >  #include <signal.h>
> > +#include <linux/version.h>
> >
> >  #include "tst_test.h"
> >  #include "tst_safe_stdio.h"
> > @@ -112,11 +113,31 @@ static void verify_umip_instruction(unsigned int n)
> >
> >         SAFE_WAITPID(pid, &status, 0);
> >
> > +       switch (n) {
> > +       case 0:
> > +       case 1:
> > +       case 3:
> > +               /* after linux kernel v5.4 mainline, 64bit SGDT SIDT SMSW
> > will return
> > +                  dummy value and not trigger SIGSEGV due to kernel code
> > change */
> > +               #if LINUX_VERSION_CODE >= KERNEL_VERSION(5,4,0)
> > +                       tst_res(TINFO, "Linux kernel version is after than
> > v5.4");
> > +                       if (WIFSIGNALED(status) && WTERMSIG(status) ==
> > SIGSEGV) {
> > +                               tst_res(TFAIL, "Got SIGSEGV\n\n");
> > +                               return;
> > +                       }
> > +                       tst_res(TPASS, "Didn't receive SIGSEGV, child
> > exited with %s\n\n",
> > +                               tst_strstatus(status));
> > +                               return;
> > +               #else
> > +                       tst_res(TINFO, "Linux kernel version is before
> > than v5.4");
> >
> 
> Thank you for fixing this.
> 
> My concern is that if an LTS distro backports the patch(commit e86c2c8b93),
> then it will break this hardcode kernel-version comparing.
> 
> 
  Ok, let's wait to confirm umip patch merged into Linux kernel main line,
  and then merge the patch into LTP. :)
  Thanks for your advice!

> 
> > +               #endif
> > +       }
> > +
> >         if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV) {
> > -               tst_res(TPASS, "Got SIGSEGV");
> > +               tst_res(TPASS, "Got SIGSEGV\n\n");
> >
> 
> Why we need two '\n' here?
> 
  Because it could help to split umip cases in LTP, there are 5 umip cases
  in LTP tests, and we could check each umip case easily in LTP log,
  like as below:
  
"
 # ./umip_basic_test
 tst_kconfig.c:62: INFO: Parsing kernel config '/lib/kernel/config-5.3.0-xsuper+'
 tst_test.c:1118: INFO: Timeout per run is 0h 05m 00s
 umip_basic_test.c:160: INFO: cpuinfo contains umip, CPU supports umip
 umip_basic_test.c:41: INFO: TEST sgdt, sgdt result save at [0x7fff930bda8e]
 umip_basic_test.c:132: INFO: Linux kernel version is before v5.4
 umip_basic_test.c:137: PASS: Got SIGSEGV


 umip_basic_test.c:51: INFO: TEST sidt, sidt result save at [0x7fff930bda8e]

 umip_basic_test.c:132: INFO: Linux kernel version is before v5.4
 umip_basic_test.c:137: PASS: Got SIGSEGV


 umip_basic_test.c:60: INFO: TEST sldt, sldt result save at [0x7fff930bda80]

 umip_basic_test.c:137: PASS: Got SIGSEGV


 umip_basic_test.c:69: INFO: TEST smsw, smsw result save at [0x7fff930bda80]

 umip_basic_test.c:132: INFO: Linux kernel version is before v5.4
 umip_basic_test.c:137: PASS: Got SIGSEGV
"
Thanks! :)
> 
> >                 return;
> >         }
> > -       tst_res(TFAIL, "Didn't receive SIGSEGV, child exited with %s",
> > +       tst_res(TFAIL, "Didn't receive SIGSEGV, child exited with %s\n\n",
> >                 tst_strstatus(status));
> >  }
> >
> > --
> > 2.14.1
> >
> >
> > --
> > Mailing list info: https://lists.linux.it/listinfo/ltp
> >
> 
> 
> -- 
> Regards,
> Li Wang
