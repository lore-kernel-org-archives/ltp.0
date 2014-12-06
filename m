Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hanpt@linux.vnet.ibm.com>) id 1Xx7b6-0008Tr-El
	for ltp-list@lists.sourceforge.net; Sat, 06 Dec 2014 05:08:00 +0000
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Xx7b5-00050G-G9
	for ltp-list@lists.sourceforge.net; Sat, 06 Dec 2014 05:08:00 +0000
Received: from /spool/local
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <hanpt@linux.vnet.ibm.com>;
	Fri, 5 Dec 2014 22:07:53 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
	(b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
	by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id B5E5C3E4003D
	for <ltp-list@lists.sourceforge.net>;
	Fri,  5 Dec 2014 22:07:51 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id sB657piw21954632
	for <ltp-list@lists.sourceforge.net>; Fri, 5 Dec 2014 22:07:51 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP
	id sB657ptS023404
	for <ltp-list@lists.sourceforge.net>; Fri, 5 Dec 2014 22:07:51 -0700
Received: from localhost.localdomain ([9.125.6.247])
	by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
	sB657oEU023314
	for <ltp-list@lists.sourceforge.net>; Fri, 5 Dec 2014 22:07:50 -0700
Date: Sat, 6 Dec 2014 09:24:22 +0800
From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Message-ID: <20141206012422.GA3352@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] questions about getrusage04
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

Hey,

I cannot understand why udelta/sdelta > "1000+(BIAS_MAX*factor_nr)" is a
problem. Could any expert give me a explain, please?

And looks like with this patch applied, it works well on powerpc:

diff --git a/testcases/kernel/syscalls/getrusage/getrusage04.c b/testcases/kernel/syscalls/getrusage/getrusage04.c
index 3640295..f118288 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage04.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage04.c
@@ -92,7 +92,7 @@ int main(int argc, char *argv[])
        if (msg != NULL)
                tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);

-#if (__powerpc__) || (__powerpc64__) || (__s390__) || (__s390x__)
+#if (__s390__) || (__s390x__)
        tst_brkm(TCONF, NULL, "This test is not designed for current system");
 #endif

although the initial git comment said that "accuracy on powerpc 
and s390x systems is always 10ms".


Thanks in advance!


------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
