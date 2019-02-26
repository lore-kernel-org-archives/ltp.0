From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 26 Feb 2019 15:45:55 +0200
Subject: [LTP] [PATCH 1/5] syscalls/fanotify03: defined additional tcase
 members for added control
In-Reply-To: <20190226133156.GA3281@rei.lan>
References: <20190122223526.GA32694@lithium.mbobrowski.org>
 <20190221164234.GD17813@rei.lan>
 <CAOQ4uxhbWmS2_jOjenZA11jk_TNwBE8KNUs+Na-vC13gPt+_2g@mail.gmail.com>
 <20190226133156.GA3281@rei.lan>
Message-ID: <CAOQ4uxiN-szCCxuNYCEEKcXYRESJKwddys_j4_gVnTJYZ08MuA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Feb 26, 2019 at 3:32 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > I see the problem.
> > It is based on an older version of
> > syscalls/fanotify03: add test for FAN_MARK_FILESYSTEM permission events
> >
> > You removed support_perm_events on commit or maybe I sent another
> > version based on your review - not sure.
> >
> > Attached the missing prerequisite patch.
> >
> > You may choose to drop support_perm_events again or add a test
> > for kernel permission events support in setup(), but we do need to
> > distinguish between support_exec_events (which comes in a later patch)
> > and FAN_MARK_FILESYSTEM support, as exec events may be backported
> > to distro stable kernels and FAN_MARK_FILESYSTEM is less likely to be
> > backported.
>
> Unfortunately that did the trick only for the first patch, the rest is
> still broken :-(.
>

Here is my branch with Matthew's patches, rebased on master
and tested:
https://github.com/amir73il/ltp/commits/fanotify_exec

Thanks,
Amir.
