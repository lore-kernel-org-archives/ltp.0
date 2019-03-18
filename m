From: Li Wang <liwang@redhat.com>
Date: Mon, 18 Mar 2019 14:39:16 +0800
Subject: [LTP] [PATCH v2 1/3] syscalls/tgkill01: add new test
In-Reply-To: <20190315113343.GD5383@rei>
References: <1552457573-1354-1-git-send-email-sumit.garg@linaro.org>
 <1552457573-1354-2-git-send-email-sumit.garg@linaro.org>
 <20190314122232.GA17823@rei.lan>
 <CAFA6WYPFiJArJvcDGLmxF5XK-q_6Yu24o=st10LE0Lz7d1Lesg@mail.gmail.com>
 <20190314135837.GA2536@rei.lan>
 <CAEemH2fHQ2Jq1o3UxbmD=Qxtwbob48aVeXnMNJWZrVS-jKWX7Q@mail.gmail.com>
 <CAFA6WYPx3fZ8Q2gR1wKi9=i0ML0JT8oPVebzaL03TFbxgxKiTg@mail.gmail.com>
 <20190315100824.GA5383@rei>
 <CAEemH2dS08E+au5RJSDe_PFehvMMFQqPUt3SWyty7X6uzLSOfw@mail.gmail.com>
 <20190315113343.GD5383@rei>
Message-ID: <CAEemH2fz+e4cMC7i3ZfTw2Kgup-xpVhiM2UioJhDX9Z1Zg0kzg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Mar 15, 2019 at 7:34 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > > > I am not sure if this warning message is desired for test-cases which
> > > > needs to wait on checkpoints irrespective of signals like this
> > > > tgkill01 test-case.
> > >
> > > Agreed, it's not an error condition, it's just a coincidence that most
> > > of the tests does not get signals when they sleep on futex, otherwise
> > > thing would crash and burn. So I would argue that retrying on EINTR is
> > > actually a bug fix rather than anything else.
> > >
> >
> > Okay, here I'm not insist to print the warning. But it's only use for
> hint
> > on that worst situation which you were mentioned. If the checkpoint got
> > signal leads to never timeout and test eventually killed by test lib.
> That
> > would hard to know what happened at that moment. My concern is the
> > situation is hard to reproduce later so just want to print more useful
> > messeges:).
>
> As for now that's only a hypotetical corner case, someone would have to
> send signals to such process sleeping on the checkpoint in a loop for
> that to happen. The problem is that printing any messages when
> checkpoint was interrupted by signal would lead to even greater
> confusion for tests that actually have to send signals to such
> processes.
>

That's true. I'm ok to withdraw my suggestion.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190318/0369cce3/attachment.html>
