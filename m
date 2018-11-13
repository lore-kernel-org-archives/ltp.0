From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 13 Nov 2018 15:02:09 +0100
Subject: [LTP] uclinux support?
In-Reply-To: <CAKdteOZ7Zj_qJA+NFCnCOVi4_K_7MfsVrHY9qJ5iRYjD_p3SSg@mail.gmail.com>
References: <CAKdteOY=B3m0NvOcPuAPbmoVkCgwuXq7PsiJZw-sPAyVdtkDQQ@mail.gmail.com>
 <20181112110151.GA23335@rei.lan>
 <CAKdteObcqQaLfHmSCt5VCSp8KEUsZL7af8gfZPvuZkpa1QNvGA@mail.gmail.com>
 <20181112142240.GA10234@rei.lan> <20181113085615.GD7182@dell5510>
 <CAKdteOZ7Zj_qJA+NFCnCOVi4_K_7MfsVrHY9qJ5iRYjD_p3SSg@mail.gmail.com>
Message-ID: <20181113140209.GA24439@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > FYI LTP compiles under uclibc-ng. Buildroot distribution (which uses glibc,
> > uclibc-ng and musl) disabled it just for musl [1]. It's tested with their
> > autobuild service [2] and currently no build reports are for latest release [3].
> > IMHO it shouldn't be difficult to support musl as well.

> > [1] https://git.busybox.net/buildroot/tree/package/ltp-testsuite/Config.in

> IIUC, it depends on BR2_USE_MMU, which probably means that it
> runs only on targets with an MMU,
Yep.
> which is not my case.
OK, I didn't consider non-MMU system.

> And the "#fork()" comment seems to indicate that otherwise
> LTP fails to build for lack of fork(), which is precisely what I'm seeing.

> Using a brutal -Dfork=vfork helped me go much further,
> and I was actually able to run some of the tests involving pthreads and signals.
I see some vfork support for uclibc in legacy C API (include/old/test.h),
but no support in new C API (as Cyril mentioned).

Good luck.

Kind regards,
Petr
