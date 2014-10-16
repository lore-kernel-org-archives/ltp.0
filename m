Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XekVy-0007sv-2c
	for ltp-list@lists.sourceforge.net; Thu, 16 Oct 2014 12:50:46 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XekVv-0006zZ-74
	for ltp-list@lists.sourceforge.net; Thu, 16 Oct 2014 12:50:45 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s9GCoa9B016385
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Thu, 16 Oct 2014 08:50:36 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id s9GCoZw8007081
	for <ltp-list@lists.sourceforge.net>; Thu, 16 Oct 2014 08:50:36 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 16 Oct 2014 14:50:34 +0200
Message-Id: <b8054b8185431bf461ab892b87fd647c03b323b8.1413463764.git.jstancek@redhat.com>
Subject: [LTP] [PATCH] doc: document tst_checkpoint_create and
	tst_checkpoint_init
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

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 doc/test-writing-guidelines.txt |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 8aaa8b0..67240c2 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -642,6 +642,22 @@ the same working directory (they use FIFO for synchronization). The checkpoint
 interface provides two pairs of signal and wait functions. One pair to be used
 to signal child from parent and second to signal parent from child.
 
+Checkpoint is represented by 'struct tst_checkpoint', which has to be
+initialized before first usage and FIFO has to be created. This is
+usually done in parent process in single step by calling
+'tst_checkpoint_create()'.
+
+Child processes created via fork() are ready to use tst_checkpoint_*
+synchronization functions, as they inherited already initialized
+'struct tst_checkpoint'.
+
+Child processes started via exec*, or any other process can use already
+created FIFO, provided they initialize 'struct tst_checkpoint' first by
+call to 'tst_checkpoint_init()'. This function does not create any FIFO,
+it relies on fact, that it was already created by some other process.
+Note, that if you use multiple FIFOs in this scenario, these should be
+initialized in same order as in process you are sychronizing against.
+
 For the details of the interface, look into the 'include/tst_checkpoint.h' and
 'lib/tests/tst_checkpoint_*'.
 
-- 
1.7.1


------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
