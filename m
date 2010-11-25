Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <zliu@redhat.com>) id 1PLY3e-0002XU-DQ
	for ltp-list@lists.sourceforge.net; Thu, 25 Nov 2010 09:24:02 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PLY3d-0007dN-88
	for ltp-list@lists.sourceforge.net; Thu, 25 Nov 2010 09:24:02 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id oAP9Nt06023000
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Nov 2010 04:23:55 -0500
Date: Thu, 25 Nov 2010 04:23:55 -0500 (EST)
From: Zhouping Liu <zliu@redhat.com>
Message-ID: <1193684080.447321290677035326.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <177873625.447271290676929182.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_24698_348469051.1290677035324"
Subject: [LTP] [PATCH v2]extend the -I option value
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

------=_Part_24698_348469051.1290677035324
Content-Type: multipart/alternative; 
	boundary="----=_Part_24699_531434788.1290677035324"

------=_Part_24699_531434788.1290677035324
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi,all 
I found it just support a small value for -I option. 
when I run '#./hugemmap04 -I 3600 -H /var/hugetlbfs',the test returned immediately. 
the -I option details : 
-I x Execute test for x seconds 
And if you give a much bigger value to -I option such as 3600 or larger, you will find the -I option disabled, 
so I changed the lib/parse_opts.c file, and just modified the stop_time variable type from 'int' to 'double', 
after changed, it can support a very bigger value for -I option. 


v2: modified the patch's format 

Signed-off-by: Zhouping Liu <zliu@redhat.com> 
--- 


------=_Part_24699_531434788.1290677035324
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html><head><style type='text/css'>p { margin: 0; }</style></head><body><div style='font-family: Times New Roman; font-size: 12pt; color: #000000'>Hi,all <br>
I found it just support a small value for -I option. <br>
when I run '#./hugemmap04 -I 3600 -H /var/hugetlbfs',the test returned immediately. <br>
the -I option details : <br>
-I x Execute test for x seconds <br>
And if you give a much bigger value to -I option such as 3600 or larger, you will find the -I option disabled, <br>
so I changed the lib/parse_opts.c file, and just modified the stop_time variable type from 'int' to 'double', <br>
after changed, it can support a very bigger value for -I option. <br><br><br>
v2: modified the patch's format<br>
<br>
Signed-off-by: Zhouping Liu &lt;zliu@redhat.com&gt;<br>
---<br>
<br></div></body></html>
------=_Part_24699_531434788.1290677035324--

------=_Part_24698_348469051.1290677035324
Content-Type: text/x-patch; name=0001-extend-the-I-options-value.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=0001-extend-the-I-options-value.patch

From 509e6f97180ce0702112d201af58e85142f9a20f Mon Sep 17 00:00:00 2001
From: Zhouping Liu <zliu@redhat.com>
Date: Thu, 25 Nov 2010 17:00:17 +0800
Subject: [PATCH] extend the I options value


Signed-off-by: Zhouping Liu <zliu@redhat.com>
---
 lib/parse_opts.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/parse_opts.c b/lib/parse_opts.c
index e4de709..da75df5 100644
--- a/lib/parse_opts.c
+++ b/lib/parse_opts.c
@@ -699,7 +699,7 @@ usc_test_looping(counter)
 int counter;
 {
     static int first_time = 1;
-    static int stop_time = 0;	/* stop time in rtc or usecs */
+    static double stop_time = 0;	/* stop time in rtc or usecs */
     static int delay;		/* delay in clocks or usecs  */
     int hertz=0;			/* clocks per second or usecs per second */
     int ct, end;		/* current time, end delay time */
@@ -724,7 +724,7 @@ int counter;
 
 	if ( STD_LOOP_DURATION) {
 	    ct=get_current_time();
-	    stop_time=(int)((float)hertz * STD_LOOP_DURATION) + ct;
+	    stop_time = (double)hertz * (double)STD_LOOP_DURATION + (double)ct;
 	}
 
 	/*
@@ -769,7 +769,7 @@ int counter;
 	keepgoing++;
     }
 
-    if ( STD_LOOP_DURATION != 0.0 && get_current_time() < stop_time ) {
+    if ( STD_LOOP_DURATION != 0.0 && (double)get_current_time() < stop_time ) {
 	keepgoing++;
     }
 
-- 
1.7.2.3


------=_Part_24698_348469051.1290677035324
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
------=_Part_24698_348469051.1290677035324
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_24698_348469051.1290677035324--

