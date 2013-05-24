Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1UfsZf-0002Rt-NT
	for ltp-list@lists.sourceforge.net; Fri, 24 May 2013 14:02:27 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UfsZZ-00020A-Ry
	for ltp-list@lists.sourceforge.net; Fri, 24 May 2013 14:02:27 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4OE2F3u015755
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 24 May 2013 10:02:16 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with
	ESMTP id r4OE2ExQ020040
	for <ltp-list@lists.sourceforge.net>; Fri, 24 May 2013 10:02:15 -0400
Message-ID: <519F72E6.3090403@redhat.com>
Date: Fri, 24 May 2013 16:02:14 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090106090001020609090205"
Subject: [LTP] proc01 hang with 3.10.0-0.rc1/rc2
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------090106090001020609090205
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

proc01 hangs on read from /proc/self/net/rpc/use-gss-proxy.

I'm attaching a patch if anyone runs rc kernels and is hitting it too,
it's not meant for inclusion to LTP. At least not yet, since the issue
exists only in -rc kernels.

Regards,
Jan

--------------090106090001020609090205
Content-Type: text/x-patch;
	name="0001-proc01-skip-proc-self-net-rpc-use-gss-proxy.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-proc01-skip-proc-self-net-rpc-use-gss-proxy.patch"

From 77b14e19e319c3b59ef068805abf00d19af008d8 Mon Sep 17 00:00:00 2001
Message-Id: <77b14e19e319c3b59ef068805abf00d19af008d8.1369401766.git.jstancek@redhat.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 24 May 2013 15:21:18 +0200
Subject: [PATCH] proc01: skip /proc/self/net/rpc/use-gss-proxy

It blocks even with O_NONBLOCK, which causes this test to hang.
This patch also converts WARN to INFO, since there are supposed
to be known failures.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/fs/proc/proc01.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/fs/proc/proc01.c b/testcases/kernel/fs/proc/proc01.c
index f2aa483..c9979ab 100644
--- a/testcases/kernel/fs/proc/proc01.c
+++ b/testcases/kernel/fs/proc/proc01.c
@@ -137,6 +137,8 @@ static const char lsm_should_work[][PATH_MAX] = {
    the test while being read. */
 static const char error_nonblock[][PATH_MAX] = {
 	"/proc/xen/xenbus",
+	"/proc/self/net/rpc/use-gss-proxy",
+	"/proc/[0-9]*/net/rpc/use-gss-proxy",
 	""
 };
 
@@ -363,8 +365,9 @@ static long readproc(const char *obj)
 
 		/* Skip files does not honor O_NONBLOCK. */
 		for (i = 0; error_nonblock[i][0] != '\0'; i++) {
-			if (!strcmp(obj, error_nonblock[i])) {
-				tst_resm(TWARN, "%s: does not honor "
+			if (!strcmp(obj, error_nonblock[i]) ||
+				!fnmatch(error_nonblock[i], obj, FNM_PATHNAME)) {
+				tst_resm(TINFO, "%s: skip, does not honor "
 					 "O_NONBLOCK", obj);
 				return 0;
 			}
-- 
1.7.1


--------------090106090001020609090205
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
--------------090106090001020609090205
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------090106090001020609090205--

