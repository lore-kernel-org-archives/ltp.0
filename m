From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 15 May 2019 17:50:03 +0300
Subject: [LTP] [PATCH v2 1/3] syscalls/fanotify13: new test to verify
 FAN_REPORT_FID functionality
In-Reply-To: <20190427045341.GA3894@lithium.mbobrowski.org>
References: <cover.1555763787.git.mbobrowski@mbobrowski.org>
 <6639dd7a9ff9929ce79f4f353f3e1db075594ea2.1555763787.git.mbobrowski@mbobrowski.org>
 <20190426152748.GA31769@rei.lan>
 <20190427045341.GA3894@lithium.mbobrowski.org>
Message-ID: <CAOQ4uxh7Ea02UyWeZKP5jJxhHkiTNpChH_H3=bFLNnZG4SU7-g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Sat, Apr 27, 2019 at 7:53 AM Matthew Bobrowski
<mbobrowski@mbobrowski.org> wrote:
>
> On Fri, Apr 26, 2019 at 05:27:48PM +0200, Cyril Hrubis wrote:
> > Hi!
> > I've tried these tests on buildservice to check that there are no
> > problems on slightly older distributions and found two.
> >
> > The first one is that we do define fallback definitions in fanotify.h
> > but then ifdef the whole test code in #if defined(HAVE_SYS_FANOTIFY_H)
> > so that it's efectively disabled on older distros even with fallback
> > definitions in place. Also it's TST_TEST_TCONF() but that is just easy
> > to fix typo. I guess that we can remove the ifdef and sys/fanotify.h
> > include from the test sources since we conditionally include the
> > sys/fanotify.h in the local fanotify.h already.
>
> OK. In that case I can write a patch that is to be applied prior to this series
> which essentially just removes this specific preprocessor conditional directive
> from all the source files. Would you like me to do this?

If I understand the concern correctly, it is not really important
to address now for these new tests that check functionality only available
since kernel v5.1. It could be addressed by followup work.

>
> > The second one is that we fail to compile on older distributions because
> > of missing name_to_handle_at() so we need configure check for that
> > syscall and fallback definition in lapi/ header, or at least configure
> > check and ifdef in the fanotify_get_fid() function. Which should be as
> > easy as adding a name_to_handle_at line to AC_CHECK_FUNCS() in the
> > configure.ac and using the macro from config.h.
>
> Sure. I've gone ahead an updated it to accommodate for this. Prior to
> submitting through another patches series, changes can be found here:
> https://github.com/matthewbobrowski/ltp/commit/54264db0e574d2f90e716a510fcb1da11ee174dc.
>
> I think we can do better and also provide a fallback definition though,
> thoughts? Don't believe that it would take much effort.
>

No reason to do that. Those tests will only be supported on kernel >= v5.1
old distros are less interesting for these tests.

Please post the patches for  fanotify_dirent_3 branch.

Thanks,
Amir.
