From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 12 Jan 2017 12:00:58 -0500 (EST)
Subject: [LTP] [PATCH 4/4] mmapstress03: Fix 32bit test on 64bit kernel
In-Reply-To: <374582327.1951599.1484239285415.JavaMail.zimbra@redhat.com>
References: <1484227419-16955-1-git-send-email-chrubis@suse.cz>
 <1484227419-16955-4-git-send-email-chrubis@suse.cz>
 <1342382447.1910370.1484232088575.JavaMail.zimbra@redhat.com>
 <20170112150550.GA5381@rei.lan>
 <374582327.1951599.1484239285415.JavaMail.zimbra@redhat.com>
Message-ID: <1021356862.1960613.1484240458508.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Jan Stancek" <jstancek@redhat.com>
> To: "Cyril Hrubis" <chrubis@suse.cz>
> Cc: ltp@lists.linux.it
> Sent: Thursday, 12 January, 2017 5:41:25 PM
> Subject: Re: [LTP] [PATCH 4/4] mmapstress03: Fix 32bit test on 64bit kernel
> 
> 
> 
> 
> 
> ----- Original Message -----
> > From: "Cyril Hrubis" <chrubis@suse.cz>
> > To: "Jan Stancek" <jstancek@redhat.com>
> > Cc: ltp@lists.linux.it
> > Sent: Thursday, 12 January, 2017 4:05:51 PM
> > Subject: Re: [LTP] [PATCH 4/4] mmapstress03: Fix 32bit test on 64bit kernel
> > 
> > Hi!
> > > >  	/* Ask for a ridiculously large mmap region at a high address */
> > > > -	if (mmap((void*) (1UL << (POINTER_SIZE - 1)) - pagesize,
> > > > -		 (size_t) ((1UL << (POINTER_SIZE - 1)) - pagesize),
> > > > +	if (mmap((void*) (1UL << (kernel_bits - 1)) - pagesize,
> > > 
> > > Since this has same range as below, shouldn't it be also 1ULL?
> > > Entire series looks OK to me.
> > 
> > Hmm, that produces warnings in case that sizeof(void) == 4 and with
> > 64bit kernel since the value is truncated. I guess that the addres
> > should be generated accordingly to the binary and not kernel after all
> > because of address space limitations.
> > 
> > Something as (((uintptr_t)1) << ((sizeof(void*)<<3) - 1) - pagesize)
> 
> Wouldn't this crash same as original?
> 
> On 32 bit, it seems that as soon as mmap touches "stack"
> we crash. On 64-bit I'm guessing map area is so high, that
> we get rejected immediately with ENOMEM.

Most likely here (for 64-bit case):

get_unmapped_area()
...
        if (len > TASK_SIZE)
                return -ENOMEM;

#define TASK_SIZE_MAX   ((1UL << 47) - PAGE_SIZE)
and our len is almost half of address space.


> 
> Example of lowering size to 1M and targeting stack (32bit on 64bit kernel):
> 
> # uname -r
> 4.8.0-1.el7.test.x86_64
> 
> Address           Kbytes     RSS   Dirty Mode  Mapping
> 0000000008048000      56      56      56 r-x-- mmapstress03
> 0000000008048000       0       0       0 r-x-- mmapstress03
> 0000000008056000       4       4       4 r---- mmapstress03
> 0000000008056000       0       0       0 r---- mmapstress03
> 0000000008057000       4       4       4 rw--- mmapstress03
> 0000000008057000       0       0       0 rw--- mmapstress03
> 0000000008058000      12       0       0 rw---   [ anon ]
> 0000000008058000       0       0       0 rw---   [ anon ]
> 00000000f7519000       4       4       4 rw---   [ anon ]
> 00000000f7519000       0       0       0 rw---   [ anon ]
> 00000000f751a000    1756     920       0 r-x-- libc-2.17.so
> 00000000f751a000       0       0       0 r-x-- libc-2.17.so
> 00000000f76d1000       4       0       0 ----- libc-2.17.so
> 00000000f76d1000       0       0       0 ----- libc-2.17.so
> 00000000f76d2000       8       8       8 r---- libc-2.17.so
> 00000000f76d2000       0       0       0 r---- libc-2.17.so
> 00000000f76d4000       4       4       4 rw--- libc-2.17.so
> 00000000f76d4000       0       0       0 rw--- libc-2.17.so
> 00000000f76d5000      12       8       8 rw---   [ anon ]
> 00000000f76d5000       0       0       0 rw---   [ anon ]
> 00000000f76e7000     124     120       0 r-x-- ld-2.17.so
> 00000000f76e7000       0       0       0 r-x-- ld-2.17.so
> 00000000f7706000       4       4       4 rw---   [ anon ]
> 00000000f7706000       0       0       0 rw---   [ anon ]
> 00000000f7707000       4       4       4 r---- ld-2.17.so
> 00000000f7707000       0       0       0 r---- ld-2.17.so
> 00000000f7708000       4       4       4 rw--- ld-2.17.so
> 00000000f7708000       0       0       0 rw--- ld-2.17.so
> 00000000ff873000     132       8       8 rw---   [ stack ]
> 00000000ff873000       0       0       0 rw---   [ stack ]
> ---------------- ------- ------- -------
> total kB            2132    1148     108
> 
> ...
> mmap2(0xff800000, 1048576, PROT_READ|PROT_WRITE,
> MAP_SHARED|MAP_FIXED|MAP_ANONYMOUS, 0, 0) = 0xffffffffff800000
> --- SIGSEGV {si_signo=SIGSEGV, si_code=SEGV_MAPERR, si_addr=0} ---
> +++ killed by SIGSEGV +++
> Segmentation fault
> 
> 
> > 
> > --
> > Cyril Hrubis
> > chrubis@suse.cz
> > 
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
