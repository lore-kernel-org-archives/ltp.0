From: Li Wang <liwang@redhat.com>
Date: Thu, 16 May 2019 17:49:22 +0800
Subject: [LTP] Oldest still supported kernel
In-Reply-To: <20190516090705.GA21814@rei.lan>
References: <20190516073826.GA14532@dell5510>
 <1051593197.23090826.1557995723298.JavaMail.zimbra@redhat.com>
 <20190516090705.GA21814@rei.lan>
Message-ID: <CAEemH2dj3Txm=otnF+UEg2eJY70wTC-5tbT2R1VfrB0qAxtqmQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, May 16, 2019 at 5:07 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > > Is it the oldest version we want to support or even something older?
> >
> > I'd like minimum to be at least 3.10.0 / glibc-2.17 (RHEL7).
>

This minimum looks good to me.


> >
> > Older distros use LTP mostly for regression tests, so it might be
> acceptable
> > for users to switch to older release tag, rather than always latest
> master.
>

I think so. To switch to older release is a better option in that situation.

> >
> > There's also an option, we create a "legacy" branch for old distros,
> > and accept only critical fixes (no new tests, rewrites, etc.). It would
> > be unsupported, but provide place where legacy users can cooperate.
>
> I was trying to avoid having several active branches for LTP for several
> reasons. Mainly to avoid people running old LTP on reasonably modern
> kernels because they were under an impression that older release is more
> stable. Hence I would like to avoid having this if possible.
>

Yes, to maintain an old LTP branch will also cost more energy, I agree to
avoid do that too.

But one more question, if a person posts a patch to fix an older issue
which conflicts with the new kernel stuff, what should we do for that?

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190516/3c50bc3d/attachment.html>
