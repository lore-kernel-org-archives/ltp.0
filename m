Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1O7EWY-0002mp-2k
	for ltp-list@lists.sourceforge.net; Wed, 28 Apr 2010 21:10:26 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O7EWU-0002Qa-6R
	for ltp-list@lists.sourceforge.net; Wed, 28 Apr 2010 21:10:26 +0000
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e31.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o3SL0WB3005110
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Apr 2010 15:00:32 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o3SLA8QJ123838
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Apr 2010 15:10:10 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o3SEA6Vq021304
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Apr 2010 08:10:07 -0600
Date: Wed, 28 Apr 2010 16:10:09 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20100428211009.GC20642@us.ibm.com>
References: <20100428210906.GA20572@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100428210906.GA20572@us.ibm.com>
Subject: [LTP] [PATCH 4/4] mqns04.c: don't exit strangely in clone case
 (please read)
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
To: Garrett Cooper <yanegomi@gmail.com>, Matt Helsley <matthltc@us.ibm.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

The child spawned by mqns04.c terminates by calling tst_exit().
tst_exit() basically calls exit(0).  In the case where the child
was spawned with fork+unshare that's fine, but in the case where
it was spawned by clone() it is not:  it causes the parent to see
the exit status as 4, as in:

posixmq_namespace_04    1  TFAIL  :  Child did not exit normally (status 4)

This patch simply makes the child do _exit(0) on success, and that
works fine.  I wonder if there is some way we can generically do
the right thing at txt_exit()?

Note that other tests have the same problem:
pid_namespace1    0  TWARN  :  child exited with signal 4
pid_namespace4    2  TFAIL  :  Container init pid got killed by signal 4
pidns20     1  TBROK  :  parent: cinit is terminated by 4

Should we just do this same "fix" in those testcases?

Signed-off-by: Serge Hallyn <serue@us.ibm.com>
---
 testcases/kernel/containers/mqns/mqns_04.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/containers/mqns/mqns_04.c b/testcases/kernel/containers/mqns/mqns_04.c
index 98d4e39..6f4bb8f 100644
--- a/testcases/kernel/containers/mqns/mqns_04.c
+++ b/testcases/kernel/containers/mqns/mqns_04.c
@@ -78,6 +78,7 @@ int check_mqueue(void *vtest)
 	write(p2[1], "go", 3);
 	read(p1[0], buf, 3);
 
+	_exit(0);
 	tst_exit();
 }
 
-- 
1.7.0


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
