Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <gomuthuk@linux.vnet.ibm.com>) id 1MO3T2-0005Hz-3X
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 05:43:48 +0000
Received: from e28smtp03.in.ibm.com ([59.145.155.3])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MO3Su-0006DQ-Hs
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 05:43:48 +0000
Message-ID: <4A52E085.5070706@linux.vnet.ibm.com>
Date: Tue, 07 Jul 2009 11:13:33 +0530
From: gowrishankar <gomuthuk@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090109000207000708020102"
Subject: [LTP] [PATCH] realtime: fix parameter name clash in pi-test7 due to
 memlock option added
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sf.net

This is a multi-part message in MIME format.
--------------090109000207000708020102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Subrata,
Please accept the patch below.

Apologies to resend it as I forgot to tag subject with [PATCH] previously :)

Thanks,
Gowri
---
realtime: fix parameter name clash in pi-test7 due to memlock option added

Below patch just renames the parameter name for number of mid priority threads
in pi-test7 from -m to -x. Original one clashes with our common memlock option
used across all RT tests.

Also, pi-test7 is already disabled in our default run profile, so this patch
can silently update the test without any impact on any other test.

Testing Informations:
Tested pi-test7 binary with the patch for the changes.

Signed-off-by: Gowrishankar <gowrishankar.m@in.ibm.com>
Tested-by: Gowrishankar <gowrishankar.m@in.ibm.com>
Acked-by: Sripathi Kodi <sripathik@in.ibm.com>
---

--------------090109000207000708020102
Content-Type: text/x-patch;
 name="pi-test-7.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pi-test-7.patch"

Index: ltp-full-20090630/testcases/realtime/func/pi-tests/testpi-7.c
===================================================================
--- ltp-full-20090630.orig/testcases/realtime/func/pi-tests/testpi-7.c	2009-07-03 14:34:13.000000000 +0530
+++ ltp-full-20090630/testcases/realtime/func/pi-tests/testpi-7.c	2009-07-03 14:38:14.000000000 +0530
@@ -80,7 +80,7 @@
 	printf("testpi-7 specific options:\n");
 	printf("  -i#     #: number of iterations\n");
 	printf("  -f      #: Use flag mutex\n");
-	printf("  -m#     #:number of mid priority threads\n");
+	printf("  -x#     #:number of mid priority threads\n");
 }
 
 int parse_args(int c, char *v)
@@ -96,7 +96,7 @@
                 case 'i':
                         iterations = atoi(v);
                         break;
-                case 'm':
+                case 'x':
                         med_threads = atoi(v);
                         break;
                 default:
@@ -246,11 +246,11 @@
 	int i,numcpus;
 	setup();
 
-	rt_init("hfi:m:", parse_args, argc, argv);
+	rt_init("hfi:x:", parse_args, argc, argv);
 
 	if (!med_threads) {
 		printf("This test requires that at least NRCPUS medium priority threads run\n");
-		printf("If it is run bound to a single CPU, you can specify -m 1\n");
+		printf("If it is run bound to a single CPU, you can specify -x 1\n");
 		printf("No User input , using default value for NRCPUS");
 		numcpus = sysconf(_SC_NPROCESSORS_ONLN);
 		med_threads = numcpus;

--------------090109000207000708020102
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have 
the opportunity to enter the BlackBerry Developer Challenge. See full prize 
details at: http://p.sf.net/sfu/blackberry
--------------090109000207000708020102
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------090109000207000708020102--

