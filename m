Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Jin.Li@windriver.com>) id 1Rsnmm-0004iZ-JK
	for ltp-list@lists.sourceforge.net; Thu, 02 Feb 2012 03:56:36 +0000
Received: from mail1.windriver.com ([147.11.146.13])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Rsnml-00005y-NL
	for ltp-list@lists.sourceforge.net; Thu, 02 Feb 2012 03:56:36 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q123uTmY009423
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Wed, 1 Feb 2012 19:56:29 -0800 (PST)
From: Jin Li <jin.li@windriver.com>
Date: Thu, 2 Feb 2012 11:56:23 +0800
Message-ID: <1328154984-1484-1-git-send-email-jin.li@windriver.com>
MIME-Version: 1.0
Subject: [LTP] Fix for msgctl test case msgctl11 on the target with more
	than 4G memory
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
To: ltp-list@lists.sourceforge.net
Cc: jin.li@windriver.com


Hi Cyril 

This is the version 2 patch.

According to your advice, I made the following change :

1. use the checkpatch.pl to improve the code style.

2. use fprintf to simplify the function  set_max_pids and return 0 for ok.

3. add prototype for set_max_pids

This fix actully increase the maximum pids value for the targets with more than
4G memory.

In theses target, the test case need at least 8192 *2 pids to create message
queue write/read child process and want to make sure that there is enought pids
, as twice as pids value to creat message queue read/write, to be used.

So the fix will increase the max pids value and re-set once the test finish.

Thanks,

Jin


------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
