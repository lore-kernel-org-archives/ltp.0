From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 10 Sep 2018 21:20:31 +0300
Subject: [LTP] [PATCH] syscalls/fanotify: misc cleanups
In-Reply-To: <87musp5sk7.fsf@rpws.prws.suse.cz>
References: <20180908142453.21532-1-amir73il@gmail.com>
 <87musp5sk7.fsf@rpws.prws.suse.cz>
Message-ID: <CAOQ4uxgDBT4TkkZrHOrfde+uLEQcUPnP8m=s37i1pP27dK2bwg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Sep 10, 2018 at 5:35 PM Richard Palethorpe <rpalethorpe@suse.de> wrote:
>
> Hello Amir,
>
> Amir Goldstein <amir73il@gmail.com> writes:
>
> > * Cleanup backup file descriptor in fanotify03
>
> Please send the fanotify03 changes on their own. It is generally best to
> send the smallest "reasonable" patch set possible to make the feeback and
> correction cycle as fast as possible.
>

ok.

> >
> > * Fix whitespace and indentation
>
> Although it is nice to clean up the whitespace, it doesn't justify
> overwritting the git history (because it makes git-blame less usable)
> and we have to verify that there are no logic changes hidden in the
> whitespace changes. It is better to mix whitespace corrections in with
> actual logic changes where we have to read every line anyway.
>

It's fine by me to drop the whitespace cleanup, although about the
argument of verifying no logic changes, git diff -w is quite useful.

> Also use "checkpatch.pl --no-tree -f" from the kernel when checking
> whitespace and style.
>
> > @@ -262,6 +262,8 @@ static void cleanup(void)
> >  {
> >       if (fd_notify > 0)
> >               SAFE_CLOSE(fd_notify);
> > +     if (fd_notify_backup > 0)
> > +             SAFE_CLOSE(fd_notify_backup);
> >  }
> >
>
> Unless I am mistaken the call to SAFE_DUP may fail leaving fd_notify
> with a valid fd and nothing in fd_notify_backup. So it is probably best
> to check and close both of them.
>

I'm not following.
Isn't "checking and closing both of them" what my fix does??

Thanks,
Amir.
