Return-Path: <ltp-list-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Sun, 13 Feb 2011 19:40:35 -0800
Message-ID: <AANLkTinXiKJkgw2-uiVKpYWD55C1EvnybPGaB3a6NaBW@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] Sourceforge backend for hooks to ltp-commits list is dead
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
To: LTP list <ltp-list@lists.sourceforge.net>
Cc: ltp-commits@lists.sourceforge.net

    sendmail is no longer on the same server where git pushes are sent to:

Counting objects: 3, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (2/2), 245 bytes, done.
Total 2 (delta 1), reused 0 (delta 0)
vz-git-2.sog
ls: /usr/sbin/sendmail: No such file or directory
hooks/post-receive: line 593: /usr/sbin/sendmail: No such file or directory
error: cannot run hooks/post-receive: No such file or directory
To ssh://yaberauneya@ltp.git.sourceforge.net/gitroot/ltp/ltp
   bc7f47d..5e2b3c6  master -> master

    I'm not a project admin or maintainer, so I'm not even going to
bother fixing it because I've already done enough. Will someone who's
SUPPOSED to be a project admin / maintainer contact sourceforge and
get it fixed please?
Thanks,
-Garrett

------------------------------------------------------------------------------
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
