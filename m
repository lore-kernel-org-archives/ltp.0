From: Jan Kara <jack@suse.cz>
Date: Thu, 10 Sep 2020 18:11:45 +0200
Subject: [LTP] [PATCH 1/1] fanotify10: Treat ignore mask bug as TCONF
 for < v5.9
In-Reply-To: <CAOQ4uxhshKD-gCuW94cvKee8W==Y6y6TNyEJmxifEagxs1BhOA@mail.gmail.com>
References: <20200910121628.18505-1-pvorel@suse.cz>
 <CAOQ4uxhshKD-gCuW94cvKee8W==Y6y6TNyEJmxifEagxs1BhOA@mail.gmail.com>
Message-ID: <20200910161145.GA17362@quack2.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu 10-09-20 17:14:03, Amir Goldstein wrote:
> On Thu, Sep 10, 2020 at 3:16 PM Petr Vorel <pvorel@suse.cz> wrote:
> >
> > Suggested-by: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > Hi Amir,
> >
> > based on suggestion http://lists.linux.it/pipermail/ltp/2020-September/018891.html,
> > but not really sure if it should be applied, because we loose warning:
> >
> > HINT: You _MAY_ be missing kernel fixes, see:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9bdda4e9cf2d
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2f02fd3fa13e
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=497b0c5a7c06
> >
> 
> I think your change is fine, because this warning would only send poor
> stable kernel maintainers on a quest to find a patch to backport, which IMO
> is not going to end with a fix.
> 
> The situation with ignored mask logic is that it was broken or not properly
> defined from day 1 of fanotify, so people are probably using ignored mask
> only in the very basic combinations.
> 
> Lately, along with FAN_MARK_FILESYSTEM and related work, more
> opportunities for using ignored mask have materialized and many old bugs
> have surfaced.
> 
> But I'm afraid it will not be feasible to backport all the fixes, so
> once the ignored
> logic settles (there are still several bugs left) I will try to
> properly document
> what is expected to work in which kernel and will update the man page
> BUGS section.
> 
> Jan,
> 
> Please let me know if we are on the same page in that regard.

Yeah I agree. We've never heard any real user complaining about broken
ignore masks behavior so backporting of the respective fixes (which is
sometimes rather difficult) is IMHO a wasted effort. I agree that
documentation in the BUGS manpage section would be worthwhile though.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
