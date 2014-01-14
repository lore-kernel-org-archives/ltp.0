Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1W35YZ-0005Hh-1d
	for ltp-list@lists.sourceforge.net; Tue, 14 Jan 2014 15:05:31 +0000
Date: Tue, 14 Jan 2014 16:05:05 +0100
From: chrubis@suse.cz
Message-ID: <20140114150505.GB21469@rei>
References: <52CFC6D1.4060006@oracle.com>
	<1389605723-17937-2-git-send-email-stanislav.kholmanskikh@oracle.com>
	<20140113173855.GD1945@rei> <52D4F37C.4050409@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52D4F37C.4050409@oracle.com>
Subject: Re: [LTP] [PATCH 2/2] setregid02, setresuid03: inval_user fix
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
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> > Hmm, the setresuid03 did not fail because the EPERM check kicks in even
> > before the check for correct uid/gid. Which should probably be fixed
> > because there does not seem to be a setresuid test for invalid values
> > that would actually excercise such checks, but that can be fixed after
> > the release.
> 
> Hmm. I took a brief look at setregid() and setresuid() syscalls sources.
> And it seems that the only thing they care about is not "validity" or 
> "invalidity" of uid/gid. It's the process permission (capabilities).
> 
> Given enough permission we can change real, effective or saved uid 
> values with setresuid() to arbitrary values. If we don't have such 
> permission we can change our uids only to the one of the current real, 
> effective or saved uid values, in the other case we will receive EPERM. 
> Actually, man setresuid states that :-[
> 
> setresuid() may return EINVAL, but I don't think we can raise it by 
> passing an unused uid value to setresuid() (if we have permission 
> setresuid() returns 0 if we don't - it returns EPERM).

I was under an impression that there are some checks (possibly in libc)
because the test comments talks about invalid uids and gids, but
thinking about it this behavior makes more sense (and checking both
kernel source and libc source indeed proves this). Sorry for the
confusion.

Note that the uid_valid() and gid_valid() checks are defined in
include/linux/uidgid.h and can fail only if the value is ((kgid_t)-1) so
as far as I can see the EINVAL cannot be triggered at all. And the same
goes for uid.

> So it's not bad that we are introducing tst_get_unused_uid, 
> tst_get_unused_gid functions and setting inval_user in a more formal way.
> But It looks like passing inval_user value is the same as passing
> any other uid != real|effective|saved uid of the current process....
> 
> Since we have in setresuid03 a full set for nobody uid:
> 	setresuid(nobody, -1, -1)
> 	setresuid(-1, -1, nobody)
> 	setresuid(-1, nobody, -1)
> what do you think about adding setresuid(inval_user, -1, -1) to the test 
> case? Just in case...
> 
> Related to setregid02.
> Even that test_data contains EINVAL for the last two members, setregid() 
> doesn't return EINVAL for them. It returns EPERM for all the test cases.
> 
> You said that on SUSE setregid02 fails. I added a group with 65533 gid 
> and executed setregid02 (current git version) and it passed. Could you 
> check it again in your environment?

I looked again at setregid02 it sets it's uid and gid (actually all of
them because it uses setuid() and setgid() as a root) to nobody's uid
and gid before the test starts and by a coincidence these are set to
65534 and 65533 on SUSE. Which explains the failure.

The setresuid03 uses bin user instead.

Now let's keep the code as it is for the release, it works good enough
and fix these a better way after it. One of the options is to set all
three uids/gids to known values and loop on all possible uids/gids and
expect EPERM on everything but the ones we set previously.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
