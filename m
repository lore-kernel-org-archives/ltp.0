Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PYcO3-0006zy-1D
	for ltp-list@lists.sourceforge.net; Fri, 31 Dec 2010 10:39:07 +0000
Date: Fri, 31 Dec 2010 11:54:34 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101231105434.GA20612@saboteur.suse.cz>
References: <4D1824C1.1070306@cn.fujitsu.com>
	<20101230143141.GA23205@saboteur.suse.cz>
	<DA7098EA-157A-40A1-A734-F33B67C7E912@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DA7098EA-157A-40A1-A734-F33B67C7E912@gmail.com>
Subject: Re: [LTP] [PATCH]Do some cleanup for tst_brkloop
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> 	*facepalm* git and I really don't get along. I tried to merge the change from ltp-broom, that pulled in a bunch of stuff I didn't want, reset via reset --hard, then checked out the one file from ltp-broom, which worked, and when I pushed everything -- it pushed all of my changes from ltp-broom back to master. So I suppose the question now is to continue with things as-is, or revert the commit. I'm guessing folks will want the latter, but I'm unfamiliar enough with merging and reverting with git because it's user friendliness that I'm concerned about doing more harm than good trying to fix things.

Just now we need to get git to some sane state so that patches created
against latest git could be merged later. But I'm not sure if reseting
back is better than fixing the problems created by merge. If all the
problems are created by merging files that were changed in both master
and ltp-broom then IMHO fixing these would be better way to go.

FYI: just now compilation dies with:

gcc   -L../../../../lib  test_arch.o   -o test_arch_debug
test_arch.o: In function `main':
/home/metan/Work/git/ltp-dev/testcases/commands/ade/objdump/test_arch.c:17:
undefined reference to `tst_exit'
collect2: ld returned 1 exit status
make[4]: *** [test_arch_debug] Error 1
make[4]: Leaving directory
`/home/metan/Work/git/ltp-dev/testcases/commands/ade/objdump'
make[3]: *** [all] Error 2
make[3]: Leaving directory
`/home/metan/Work/git/ltp-dev/testcases/commands/ade'
make[2]: *** [all] Error 2
make[2]: Leaving directory
`/home/metan/Work/git/ltp-dev/testcases/commands'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/home/metan/Work/git/ltp-dev/testcases'
make: *** [testcases-all] Error 2

> 	I need to go back home (where I don't have internet via my laptop right now and won't for the next couple of days), but I'll continue to work on verifying everything and fix regressions if and when I find them, and I'll try to pop over to work whenever possible to push code back to the git repo.

I hope that lack of the internet connection in your home is only
temporary, as so far you did the commits and there is a already some
backlog of waiting patches. I know that it's holidays now but I'm
allready starting to lose track of the issues waiting for commit.

If you need some help with that, don't hesitate to ask.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
