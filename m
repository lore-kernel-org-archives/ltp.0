Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <zliu@redhat.com>) id 1PL9iJ-0006Kn-2A
	for ltp-list@lists.sourceforge.net; Wed, 24 Nov 2010 07:24:23 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PL9iH-0003RR-L7
	for ltp-list@lists.sourceforge.net; Wed, 24 Nov 2010 07:24:23 +0000
Date: Wed, 24 Nov 2010 02:24:15 -0500 (EST)
From: Zhouping Liu <zliu@redhat.com>
Message-ID: <2244893.326841290583455690.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1438985307.326821290583410077.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_17847_1189044017.1290583455689"
Subject: [LTP]  [PATCH] fix maximum seconds of -I option
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

------=_Part_17847_1189044017.1290583455689
Content-Type: multipart/alternative; 
	boundary="----=_Part_17848_1927458384.1290583455689"

------=_Part_17848_1927458384.1290583455689
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

> From: caiqian@redhat.com 
> To: "ltp-list" <ltp-list@lists.sourceforge.net> 
> Sent: Monday, November 15, 2010 9:30:40 PM GMT +08:00 Beijing / Chongqing / Hong Kong / Urumqi 
> Subject: [LTP] maximum seconds of -I 
> 
> Hi, I am wondering if there is a limitation of seconds you can specify 
> in standard command-line options for, 
> 
> -I x Execute test for x seconds 
> 
> I noticed that when given a value like 3600, the test returned 
> immediately like, 
> 
> ./hugemmap04 -I 3600 -H /var/hugetlbfs 
> 
> Is this expected? 
> 
> CAI Qian 
> 
Hi,all 
I fixed the -I options, and now it support a very large number such as 360000000000 or larger than. 

-- 
Name: Zhouping Liu 


------=_Part_17848_1927458384.1290583455689
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html><head><style type='text/css'>p { margin: 0; }</style></head><body><div style='font-family: Times New Roman; font-size: 12pt; color: #000000'>&gt; From: caiqian@redhat.com<br>&gt; To: "ltp-list" &lt;ltp-list@lists.sourceforge.net&gt;<br>&gt; Sent: Monday, November 15, 2010 9:30:40 PM GMT +08:00 Beijing / Chongqing / Hong Kong / Urumqi<br>&gt; Subject: [LTP] maximum seconds of -I<br>&gt;<br>&gt; Hi, I am wondering if there is a limitation of seconds you can specify<br>&gt; in standard command-line options for,<br>&gt; <br>&gt; -I x&nbsp;&nbsp;&nbsp; Execute test for x seconds<br>&gt; <br>&gt; I noticed that when given a value like 3600, the test returned<br>&gt; immediately like,<br>&gt; <br>&gt; ./hugemmap04 -I 3600 -H /var/hugetlbfs<br>&gt; <br>&gt; Is this expected?<br>&gt; <br>&gt; CAI Qian<br>&gt; <br>Hi,all<br>I fixed the -I options, and now it support a very large number such as 360000000000 or larger than.<br><br>-- <br>Name: Zhouping Liu<br><br></div></body></ht!
 ml>
------=_Part_17848_1927458384.1290583455689--

------=_Part_17847_1189044017.1290583455689
Content-Type: text/x-patch; name=0001-Enable-the-I-options-such-as.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=0001-Enable-the-I-options-such-as.patch

From 73272825b8597e1f1bbba7428d1f3f7ffd2e69b4 Mon Sep 17 00:00:00 2001
From: Zhouping Liu <zliu@redhat.com>
Date: Wed, 24 Nov 2010 14:50:01 +0800
Subject: [PATCH] 	Enable the '-I' options, such as
 	./testcases/kernel/mem/hugetlb/hugemmap/hugemmap04 -I 360000 -H /var/hugetlbfs/
 	Add a line in order to avoid the 'SEGBUS' error.

---
 lib/parse_opts.c                                   |    6 +++---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c |    3 ++-
 2 files changed, 5 insertions(+), 4 deletions(-)

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
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
index 485b465..11d0188 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
@@ -143,7 +143,8 @@ main(int ac, char **av)
 		}
 		/* Reset Tst_count in case we are looping. */
 		Tst_count=0;
-
+		/* force to allocate page and change HugePages_Free */
+		write(fildes,"Write some words to the TEMPFILE\n",40);
 		/* Note the number of free huge pages BEFORE testing */
 		freepages = getfreehugepages();
 		beforetest = freepages;
-- 
1.7.2.3


------=_Part_17847_1189044017.1290583455689
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
------=_Part_17847_1189044017.1290583455689
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_17847_1189044017.1290583455689--

