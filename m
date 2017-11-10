From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 10 Nov 2017 02:45:48 -0500 (EST)
Subject: [LTP] [PATCH 2/2] mm: enlarge mmap HIGH_ADDR value for s390 arch
In-Reply-To: <CAEemH2eX=pXhvV04RgAHN7DTnYxkv-9edv-2k1k60WtgOQpEpw@mail.gmail.com>
References: <20171025033006.32463-1-liwang@redhat.com>
 <20171025033006.32463-2-liwang@redhat.com>
 <436712851.37925655.1510128799182.JavaMail.zimbra@redhat.com>
 <CAEemH2eX=pXhvV04RgAHN7DTnYxkv-9edv-2k1k60WtgOQpEpw@mail.gmail.com>
Message-ID: <754021090.38693522.1510299948451.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> On Wed, Nov 8, 2017 at 4:13 PM, Jan Stancek <jstancek@redhat.com> wrote:
> >
> >
> > ----- Original Message -----
> >> The kernel commit 1aea9b3f92 (s390/mm: implement 5 level pages tables)
> >> enlarge the maximum address in the tasks address space from (1UL << 53)
> >> to (-PAGE_SIZE) on s390 platform.
> >>
> >> We have to increase the HIGH_ADDR in ltp testcases accordingly otherwise
> >> that would be failed with succeeded mmap into high region:
> >>
> >> mmap15.c:
> >> mmap15  1  TFAIL  :  mmap15.c:77: mmap into high region succeeded
> >> unexpectedly
> >>
> >> mmapstress03.c:
> >> mmapstress03: errno = 25: really large mmap didn't fail
> >> mmapstress03    0  TINFO  :  uname.machine=s390x kernel is 32bit
> >
> >                                      Isn't this the problem? ^^
> 
> No, It is an misinformation (for s390 platform) from LTP
> tst_kernel_bits() function.

That number is used to calculate size for mmap in mmapstress03.
Are you saying that after commit 1aea9b3f92, mmap for size "(1 << 63) - pagesize"
will succeed?

Regards,
Jan

> 
> ====
> # uname -r
> 3.10.0-514.el7.s390x
> 
> # readelf -h mmapstress03
> ELF Header:
>   Magic:   7f 45 4c 46 02 02 01 00 00 00 00 00 00 00 00 00
>   Class:                             ELF64
>   Data:                              2's complement, big endian
>   Version:                           1 (current)
> ...
> 
> # ./mmapstress03
> mmapstress03    0  TINFO  :  uname.machine=s390x kernel is 32bit
> mmapstress03    1  TPASS  :  Test passed
> 
> 
> 
> I'd suggest to fix this as:
> 
> $ git diff
> diff --git a/lib/tst_kernel.c b/lib/tst_kernel.c
> index fd648b1..6d6fd38 100644
> --- a/lib/tst_kernel.c
> +++ b/lib/tst_kernel.c
> @@ -35,7 +35,8 @@ int tst_kernel_bits(void)
>          * ARM64 (aarch64) defines 32-bit compatibility modes as
>          * armv8l and armv8b (little and big endian).
>          */
> -       if (!strcmp(buf.machine, "armv8l") || !strcmp(buf.machine, "armv8b"))
> +       if (!strcmp(buf.machine, "armv8l") || !strcmp(buf.machine, "armv8b")
> +                       || !strcmp(buf.machine, "s390x"))
>                 kernel_bits = 64;
> 
>         tst_resm(TINFO, "uname.machine=%s kernel is %ibit",
> 
> 
> 
> --
> Li Wang
> liwang@redhat.com
> 
