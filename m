From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 28 Sep 2018 10:39:40 +0300
Subject: [LTP] [PATCH] syscalls/fanotify03: Cleanup backup file
	descriptor
In-Reply-To: <87bm935hdc.fsf@rpws.prws.suse.cz>
References: <20180911145602.18106-1-amir73il@gmail.com>
 <87bm935hdc.fsf@rpws.prws.suse.cz>
Message-ID: <CAOQ4uxjuHr7DAhn-By7ZxhFR4SmpF2S_7jNZYngi30bZp4NjOw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Sep 12, 2018 at 10:01 AM Richard Palethorpe <rpalethorpe@suse.de> wrote:
>
> Hello,
>
> Amir Goldstein <amir73il@gmail.com> writes:
>
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
> > Cyril,
> >
> > As requested by Richard, here is the fanotify03 minor fix separated from
> > whitespace cleanup.

FYI, I submitted a github pull request for the cleanup series:
https://github.com/linux-test-project/ltp/pull/400

Including an alternative fix to fanotify03 that was Acked-by Jan.

This mostly (but not only) whitespace cleanup is more easy to review on github
or by git diff -w, so not posting patches on mail to reduce the noise.

I added to the cleanup SPDX tags and some fixes to printed messages.

This cleanup is the base for adding test cases for new feature, which I aim
to post after the next kernel merge window.

Thanks,
Amir.
