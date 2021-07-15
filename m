From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 15 Jul 2021 08:52:54 +0200
Subject: [LTP] [PATCH] syscalls/fanotify19: Add test cases for elevated
 reader privileges
In-Reply-To: <CAOQ4uxjjbv996OC_xqAtV1wttK51ytb3dPavS8F28K3QMU6Xzw@mail.gmail.com>
References: <20210713162450.34947-1-amir73il@gmail.com>
 <YO6SFGTvHJkAR5+9@pevik>
 <CAOQ4uxjjbv996OC_xqAtV1wttK51ytb3dPavS8F28K3QMU6Xzw@mail.gmail.com>
Message-ID: <YO/bRs10jHRynMDv@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir,

> On Wed, Jul 14, 2021 at 10:28 AM Petr Vorel <pvorel@suse.cz> wrote:

> > Hi Amir,

> > > Even when event reader has elevated privileges, the information provided
> > > in events is determined by the privileges of the user that created the
> > > fanotify group.

> > > Add test cases for unprivileged listener and privileged event reader.

> > > This is a regression test for kernel commit
> > > a8b98c808eab ("fanotify: fix permission model of unprivileged group")

> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---

> > > Hi Petr,

> > > Added test for a fix in v5.13-rc5.

> > Thanks for your patch, pushed!

> > Things I've found, not related to this patch:

> > TBROK when running with higher number of iterations:
> > ./fanotify19 -i 30
> > ...
> > fanotify19.c:224: TPASS: Received event: mask=2b, pid=11351 fd=-1
> > fanotify19.c:224: TPASS: Received event: mask=b, pid=11351 fd=-1
> > fanotify19.c:224: TPASS: Received event: mask=a, pid=11351 fd=-1
> > fanotify19.c:224: TPASS: Received event: mask=8, pid=11351 fd=-1
> > fanotify19.c:147: TINFO: Test #3 unprivileged lisneter, privileged reader - events by child
> > fanotify19.c:151: TINFO: Running as privileged user, revoking.
> > fanotify19.c:136: TBROK: Child process terminated incorrectly. Aborting

> > Summary:
> > passed   316
> > failed   0
> > broken   1
> > skipped  0
> > warnings 0

> > Could you have look into it?


> Posted fix.
Thanks!

> > very minor nit: checkpatch complains about minor issues. Although all but quoted
> > string split across lines are easily fixable we don't need to bother with it.
> > But could you please use checkpatch for new tests?

> Will do.
Thanks!

> > Also I'd personally join also strings which are below 100 chars, because it
> > helps to grep.

> > > @@ -248,6 +285,10 @@ static struct tst_test test = {
> > >       .needs_root = 1,
> > >       .mount_device = 1,
> > >       .mntpoint = MOUNT_PATH,
> > > +     .tags = (const struct tst_tag[]) {
> > > +             {"linux-git", "a8b98c808eab"},
> > FYI we also support "linux-stable-git", but we mainly use it for stable branch
> > specific patches (something required just for stable), not for regular backports
> > of fixes.


> I did not understand when linux-stable-git should be used or why it applies
> to this case.
I'm sorry for not being clear. It does not apply to this case, just FYI.
It's for commits which are stable branch specific, i.e. no commit in mainline.
Thus we have only two so far.

Example of commits: c4a23c852e80 cac68d12c531.

c4a23c852e80:
No upstream commit, this is a fix to a stable 5.4 specific backport.

cac68d12c531
[ Upstream commits 9392a27d88b9 and ff002b30181d ]

I'm going to send patch to our doc [1] to mention it.

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/wiki/C-Test-API#138-test-tags

> Thanks,
> Amir.
