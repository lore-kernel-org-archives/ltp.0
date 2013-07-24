Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <tejaswin@linux.vnet.ibm.com>) id 1V1vNa-0006Pw-NM
	for ltp-list@lists.sourceforge.net; Wed, 24 Jul 2013 09:29:06 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1V1vNY-0002nf-JK
	for ltp-list@lists.sourceforge.net; Wed, 24 Jul 2013 09:29:06 +0000
Received: from /spool/local
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <tejaswin@linux.vnet.ibm.com>;
	Wed, 24 Jul 2013 03:28:59 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 0E0B21FF0044
	for <ltp-list@lists.sourceforge.net>;
	Wed, 24 Jul 2013 03:23:36 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	r6O9SvKn135170
	for <ltp-list@lists.sourceforge.net>; Wed, 24 Jul 2013 03:28:57 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id r6O9Vaoj026952
	for <ltp-list@lists.sourceforge.net>; Wed, 24 Jul 2013 03:31:36 -0600
Received: from localhost.localdomain ([9.124.151.54])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	r6O9VTpQ026819
	for <ltp-list@lists.sourceforge.net>; Wed, 24 Jul 2013 03:31:35 -0600
Message-ID: <51EF9E51.1070208@linux.vnet.ibm.com>
Date: Wed, 24 Jul 2013 14:58:49 +0530
From: Tejaswini <tejaswin@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] Containers test case is hanging at two sub test cases
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

Containers : testcase is preventing runfiv.sh from proceeding. Hangs at

>> two_children_ns and
>> par_chld_ipv6

The function crtchild() in two_children_ns.c and par_chld_ipv6.c is called
with only one parameter while the definition has two parameters: 
crtchild (char *, char *)

Signed-off-by: Tejaswini <tejaswin@linux.vnet.ibm.com>

The patches below fix the issue:

----

--- ltp-full-20130109/testcases/kernel/containers/netns/par_chld_ipv6.c.orig    2013-06-19 16:05:55.866360812 +0530
+++ ltp-full-20130109/testcases/kernel/containers/netns/par_chld_ipv6.c 2013-06-19 16:06:31.975150188 +0530
@@ -45,7 +45,7 @@
  #include "test.h"
  #include "config.h"

-extern int crtchild(char *);
+extern int crtchild(char *, char *);

  char *TCID = "netns_ipv6";
  int TST_TOTAL = 1;
@@ -95,7 +95,7 @@ int main()
  #else
                 tst_resm(TCONF, "System doesn't have unshare support");
  #endif
-               return crtchild(child);
+               return crtchild(child,par);
         } else {

                 //parent

--- ltp-full-20130109/testcases/kernel/containers/netns/two_children_ns.c.orig  2013-06-19 16:04:54.436982114 +0530
+++ ltp-full-20130109/testcases/kernel/containers/netns/two_children_ns.c       2013-06-19 16:05:22.427611441 +0530
@@ -47,7 +47,7 @@
  #include "libclone.h"
  #include "config.h"

-extern int crtchild(char *);
+extern int crtchild(char *, char *);

  char *TCID = "netns_2children";
  int TST_TOTAL = 1;
@@ -109,7 +109,7 @@ int main()
                                 return ret;
                         }
  #endif
-                       return crtchild(child[i]);
+                       return crtchild(child[i], par[i]);
                 } else {
                         //Parent

----

Thanks,
Tejaswini



------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
