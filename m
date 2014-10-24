Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gary.robertson@linaro.org>) id 1Xhi9o-0001oB-3J
	for ltp-list@lists.sourceforge.net; Fri, 24 Oct 2014 16:56:08 +0000
Received: from mail-oi0-f50.google.com ([209.85.218.50])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Xhi9m-0003ks-Bo
	for ltp-list@lists.sourceforge.net; Fri, 24 Oct 2014 16:56:08 +0000
Received: by mail-oi0-f50.google.com with SMTP id i138so622943oig.37
	for <ltp-list@lists.sourceforge.net>;
	Fri, 24 Oct 2014 09:56:00 -0700 (PDT)
From: "Gary S. Robertson" <gary.robertson@linaro.org>
Date: Fri, 24 Oct 2014 11:47:32 -0500
Message-Id: <1414169252-19374-3-git-send-email-gary.robertson@linaro.org>
In-Reply-To: <1414169252-19374-1-git-send-email-gary.robertson@linaro.org>
References: <90019386.14686839.1414156011036.JavaMail.zimbra@redhat.com>
	<1414169252-19374-1-git-send-email-gary.robertson@linaro.org>
Subject: [LTP] [PATCH] Realtime tests: Use correct PI conditional in testpi-5
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
To: jstancek@redhat.com
Cc: ltp-list@lists.sourceforge.net, mike.holmes@linaro.org

From: "Gary S. Robertson" <gary.robertson@linaro.org>

testcases/realtime/func/pi-tests/testpi-5.c
referenced a non-existent autoconf configuration setting variable.
Replaced the invalid variable name with the variable actually created
by autoconf.

Signed-off-by: Gary S. Robertson <gary.robertson@linaro.org>
---
 testcases/realtime/func/pi-tests/testpi-5.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/realtime/func/pi-tests/testpi-5.c b/testcases/realtime/func/pi-tests/testpi-5.c
index a1d93cc..a524864 100644
--- a/testcases/realtime/func/pi-tests/testpi-5.c
+++ b/testcases/realtime/func/pi-tests/testpi-5.c
@@ -69,7 +69,7 @@ int do_test(int argc, char **argv)
 	pthread_mutexattr_t mutexattr;
 	int retc, protocol;
 
-#if HAS_PTHREAD_MUTEXATTR_PROTOCOL_FUNCTIONS
+#if HAS_PRIORITY_INHERIT
 
 	if (pthread_mutexattr_init(&mutexattr) != 0)
 		printf("Failed to init mutexattr\n");
-- 
1.7.9.5


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
