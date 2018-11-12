From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 12 Nov 2018 12:01:51 +0100
Subject: [LTP] uclinux support?
In-Reply-To: <CAKdteOY=B3m0NvOcPuAPbmoVkCgwuXq7PsiJZw-sPAyVdtkDQQ@mail.gmail.com>
References: <CAKdteOY=B3m0NvOcPuAPbmoVkCgwuXq7PsiJZw-sPAyVdtkDQQ@mail.gmail.com>
Message-ID: <20181112110151.GA23335@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I wanted to try to run at least some of the LTP tests on a uclinux
> system for arm (arm-uclinuxfdpiceabi), as I am in the process of
> upstreaming the toolchain support for the FDPIC ABI for ARM.
> 
> I've tried this:
> $ make autotools
> $ configure CC=~XXX/bin/arm-none-uclinuxfdpiceabi-gcc
> CXX=~XXX/bin/arm-none-uclinuxfdpiceabi-g++ --host
> arm-none-uclinuxfdpiceabi
> $ make all
> XXX/lib/gcc/arm-none-uclinuxfdpiceabi/9.0.0/../../../../arm-none-uclinuxfdpiceabi/bin/ld:
> ../../lib/libltp.a(tst_test.o): in function `fork_testrun':
> XXX/ltp/lib/tst_test.c:1104: undefined reference to `fork'
> XXX/lib/gcc/arm-none-uclinuxfdpiceabi/9.0.0/../../../../arm-none-uclinuxfdpiceabi/bin/ld:
> ../../lib/libltp.a(tst_test.o): in function `safe_fork':
> XXX/ltp/lib/tst_test.c:395: undefined reference to `fork'
> XXX/lib/gcc/arm-none-uclinuxfdpiceabi/9.0.0/../../../../arm-none-uclinuxfdpiceabi/bin/ld:
> ../../lib/libltp.a(tst_res.o): in function `tst_fork':
> XXX/ltp/lib/tst_res.c:421: undefined reference to `fork'
> 
> config.h has:
> #define UCLINUX 1
> /* #undef HAVE_FORK */
> #define HAVE_VFORK 1
> 
> so it looks like confgure correctly detected the target system.
> 
> Am I missing something?

uClinux support in LTP has been broken for years and nobody seemed to
really care. I even tried to ask if there is someone interesting in
running LTP on uClinux on the uClinux mailing list but it seems that
even the list is basically dead at this point. So for a last year or so
we are slowly getting rid of the uClinux specific bits from the codebase
in order to simplify the LTP maintenance. You are free to step up and
restore uClinux support in LTP if you have time for that but unless that
happens we will continue to stage it out.

-- 
Cyril Hrubis
chrubis@suse.cz
