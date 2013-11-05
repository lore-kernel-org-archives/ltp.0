Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VdjmX-0002H7-M9
	for ltp-list@lists.sourceforge.net; Tue, 05 Nov 2013 16:47:09 +0000
Date: Tue, 5 Nov 2013 17:46:45 +0100
From: chrubis@suse.cz
Message-ID: <20131105164645.GB21812@rei.suse.cz>
References: <1383285427-6049-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<20131104152621.GA11545@rei> <5278CF8E.7020104@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5278CF8E.7020104@oracle.com>
Subject: Re: [LTP] [PATCH] prot_hsymlinks: explicitly close file descriptors
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net, alexey.kodanev@oracle.com

Hi!
> >> This test case does not need to keep the file descriptors
> >> open after doing creat() on them. So we close them right after
> >> SAFE_CREAT.
> >>
> >> Otherwise on NFS it outputs:
> >>
> >> TWARN  :  tst_rmdir: rmobj(/tmpdir/ltp-vdIWJBmrkz/provfaUSg) failed: remove(/tmpdir/ltp-vdIWJBmrkz/provfaUSg/tmp_root/hsym) failed; errno=66: Directory not empty
> >>
> >> or:
> >> TWARN  :  tst_rmdir: rmobj(/mnt/proXZmq0T) failed: unlink(/mnt/proXZmq0T/root/.nfs00000000000008470000015e) failed; errno=16: Device or resource busy
> >>
> >> The same idea as for 8c200cb8e843724afb49fa6617fceec09ac826a5.
> >>
> >> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
> >> ---
> >>   .../security/prot_hsymlinks/prot_hsymlinks.c       |    2 +-
> >>   1 files changed, 1 insertions(+), 1 deletions(-)
> >>
> >> diff --git a/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c b/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c
> >> index 558681a..4c05e3f 100644
> >> --- a/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c
> >> +++ b/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c
> >> @@ -414,7 +414,7 @@ static void ufiles_add(int usr, char *path, int type)
> >>   	struct user_file *ufile = &users[usr].file[file];
> >>   
> >>   	if (type == IS_FILE)
> >> -		SAFE_CREAT(cleanup, path, 0644);
> >> +		close(SAFE_CREAT(cleanup, path, 0644));
> >>   	else
> >>   		SAFE_MKDIR(cleanup, path, 0755);
> >>   
> > There is quite a lot of places in LTP where we do creat() and then
> > close(), what about adding SAFE_TOUCH() with touch(1) sematics to the
> > safe_file_ops.h in LTP lib?
> I'm ok with that, but I have two little questions:
> 
> 1. About the semantics.
> We use creat() with a 'mode' parameter. Should it just be passed to 
> open() (with O_CREAT) or should we explicitly call chmod(mode) after 
> open()/close()?
> In other words, should SAFE_TOUCH try to change the permissions if the 
> file exists?

I would go for changing the permissions if the file exists.

> At the moment I think about the following prototype:
> void safe_touch(const char *file, const int lineno,
>                            void (*cleanup_fn)(void),
>                            const char *pathname,
>                            mode_t mode, const struct timespec *times)

The timespec is used for specifying creation time?

> 2. Maybe move SAFE_TOUCH to safe_macros.h ?

I was thinking of safe_file_ops because safe_macros contains wrappers
around various libcalls and touch is not really libcall of any kind. But
that is minor.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
November Webinars for C, C++, Fortran Developers
Accelerate application performance with scalable programming models. Explore
techniques for threading, error checking, porting, and tuning. Get the most 
from the latest Intel processors and coprocessors. See abstracts and register
http://pubads.g.doubleclick.net/gampad/clk?id=60136231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
