From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 15 Apr 2020 13:08:41 +0200
Subject: [LTP] [RFC PATCH 1/8] lib: Fix linking error multiple TCID
 definitions with -fno-common
In-Reply-To: <20200415104907.GC12705@rei.lan>
References: <20200415092809.20240-1-pvorel@suse.cz>
 <20200415092809.20240-2-pvorel@suse.cz>
 <20200415093038.GA12705@rei.lan> <20200415094932.GA29975@dell5510>
 <20200415104907.GC12705@rei.lan>
Message-ID: <20200415110841.GB29975@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> > In file included from memfd_create01.c:17:
> > memfd_create01.c: In function ???verify_memfd_create???:
> > memfd_create01.c:244:21: error: ???TCID??? undeclared (first use in this function)
> >   244 |  fd = CHECK_MFD_NEW(TCID, MFD_DEF_SIZE, tc->flags);
> >       |                     ^~~~
> > ---

> This one is used as a unique test identifier, we can hardcode something
> as "ltp_memfd_create01" there instead.
+1.

> > In file included from testcases/kernel/mem/include/mem.h:4,
> >                  from overcommit_memory.c:72:
> > overcommit_memory.c: In function ???setup???:
> > overcommit_memory.c:105:33: error: ???TCID??? undeclared (first use in this function)
> >   105 |     "can't support to test %s", TCID);
> >       |                                 ^~~~
> > ---

> > In file included from ima_mmap.c:9:
> > ima_mmap.c: In function ???run???:
> > ima_mmap.c:36:43: error: ???TCID??? undeclared (first use in this function)
> >    36 |   tst_brk(TBROK, "Usage: %s -f filename", TCID);
> >       |                                           ^~~~

> Hmm these two are using the TCID as a test binary name, which kind of
> works by accident. Because:

> 1. The library uses argv[0] to initialize TCID
> 2. Then TCID is used as a prefix for the temporary directory
>    the test has created and also for filename on tmpfs

> There is no guarantee that TCID is equal to argv[0], it's only supposed
> to be unique identifier for a test.

> So I would rather be for removing TCID from these tests. The question is
> if we want to replace it with something that is guaranteed to contain
> the test binary name or remove it completely.

I'd be for just hardcoding the info in overcommit_memory.c as it's name from
kernel.
            access(PATH_SYSVM "overcommit_ratio", F_OK) == -1)
-               tst_brk(TCONF, "The system "
-                        "can't support to test %s", TCID);
+               tst_brk(TCONF, "The system can't support to test overcommit_memory");

But for IMA I'll just remove TCID:
testcases/kernel/security/integrity/ima/src/ima_mmap.c
        if (!filename)
-               tst_brk(TBROK, "Usage: %s -f filename", TCID);
+               tst_brk(TBROK, "missing filename (-f filename)");

Kind regards,
Petr
