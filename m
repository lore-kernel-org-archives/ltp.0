From: Christophe Lyon <christophe.lyon@linaro.org>
Date: Tue, 13 Nov 2018 10:25:00 +0100
Subject: [LTP] uclinux support?
In-Reply-To: <20181113085615.GD7182@dell5510>
References: <CAKdteOY=B3m0NvOcPuAPbmoVkCgwuXq7PsiJZw-sPAyVdtkDQQ@mail.gmail.com>
 <20181112110151.GA23335@rei.lan>
 <CAKdteObcqQaLfHmSCt5VCSp8KEUsZL7af8gfZPvuZkpa1QNvGA@mail.gmail.com>
 <20181112142240.GA10234@rei.lan> <20181113085615.GD7182@dell5510>
Message-ID: <CAKdteOZ7Zj_qJA+NFCnCOVi4_K_7MfsVrHY9qJ5iRYjD_p3SSg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, 13 Nov 2018 at 09:56, Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi,
>
> > > > uClinux support in LTP has been broken for years and nobody seemed to
> > > > really care. I even tried to ask if there is someone interesting in
> > > > running LTP on uClinux on the uClinux mailing list but it seems that
> > > > even the list is basically dead at this point. So for a last year or so
> > > > we are slowly getting rid of the uClinux specific bits from the codebase
> > > > in order to simplify the LTP maintenance. You are free to step up and
> > > > restore uClinux support in LTP if you have time for that but unless that
> > > > happens we will continue to stage it out.
>
>
> > > OK understood, I was right to ask :)
>
> > > I'd like to roll back to a point where it was mostly working, any idea
> > > when that would be?
>
> > > I've looked at the history, and tried several commits that seemed to
> > > remove uclinux support,
> > > but I'm still facing similar errors (I'm now back to 2011....)
>
> > Actually I have no idea. But generally the further back you go the more
> > unstable the whole LTP gets. I'm pretty sure you will not be able to
> > even compile 10 years old LTP regardless the uClinux enabled or not.
>
> > Looking at the commit logs it looks like last time anything has been
> > fixed for uClinux was 2009.
>
> > > A point were a subset worked would be nice, I'd like to run tests
> > > involving unwinding and signals.
>
> > You may be better off taking an LTP from 2016 before we added the new
> > LTP test library which is about the time we started to remove uClinux
> > support, i.e. before commit:
>
> > commit bbdb9f78378c7e038f463efa39d2470e1c51ad54
> > Author: Cyril Hrubis <chrubis@suse.cz>
> > Date:   Wed Mar 16 15:53:57 2016 +0100
>
> >     lib: Add new test library API
>
> > And disable tests until it compiles.
>
> FYI LTP compiles under uclibc-ng. Buildroot distribution (which uses glibc,
> uclibc-ng and musl) disabled it just for musl [1]. It's tested with their
> autobuild service [2] and currently no build reports are for latest release [3].
> IMHO it shouldn't be difficult to support musl as well.
>
> [1] https://git.busybox.net/buildroot/tree/package/ltp-testsuite/Config.in

IIUC, it depends on BR2_USE_MMU, which probably means that it
runs only on targets with an MMU, which is not my case.
And the "#fork()" comment seems to indicate that otherwise
LTP fails to build for lack of fork(), which is precisely what I'm seeing.

Using a brutal -Dfork=vfork helped me go much further,
and I was actually able to run some of the tests involving pthreads and signals.

> [2] https://buildroot.org/downloads/manual/manual.html#_analyzing_and_fixing_autobuild_failures
> [3] http://autobuild.buildroot.net/stats/
