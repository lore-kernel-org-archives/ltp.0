Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mmarhefk@redhat.com>) id 1XP8hd-0004vz-8f
	for ltp-list@lists.sourceforge.net; Wed, 03 Sep 2014 11:26:17 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XP8hc-0005fQ-3H
	for ltp-list@lists.sourceforge.net; Wed, 03 Sep 2014 11:26:17 +0000
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s83BQ9GZ015473
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 3 Sep 2014 07:26:09 -0400
Received: from cc-vtoe10.lab.eng.brq.redhat.com
	(cc-vtoe10.lab.eng.brq.redhat.com [10.34.74.245])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id s83BQ8ll031064
	for <ltp-list@lists.sourceforge.net>; Wed, 3 Sep 2014 07:26:08 -0400
From: Matus Marhefka <mmarhefk@redhat.com>
Date: Wed,  3 Sep 2014 13:26:03 +0200
Message-Id: <1409743563-15081-1-git-send-email-mmarhefk@redhat.com>
Subject: [LTP] [PATCH] containers: fixed libclone/libclone.c
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

* fixed issue in do_plain_tests() function, where "return" was
  used in child instead of "exit(3)" which caused that child executed
  code from parent

Signed-off-by: Matus Marhefka <mmarhefk@redhat.com>
---
 testcases/kernel/containers/libclone/libclone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/containers/libclone/libclone.c b/testcases/kernel/containers/libclone/libclone.c
index ebaac43..239674f 100644
--- a/testcases/kernel/containers/libclone/libclone.c
+++ b/testcases/kernel/containers/libclone/libclone.c
@@ -97,7 +97,7 @@ int do_plain_tests(int (*fn1) (void *arg), void *arg1,
 		return -1;
 	}
 	if (pid == 0)
-		return fn1(arg1);
+		exit(fn1(arg1));
 	if (fn2)
 		ret = fn2(arg2);
 	return ret;
-- 
1.8.3.1


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
