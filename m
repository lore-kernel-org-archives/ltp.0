Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1N3ulv-0004y3-3Y
	for ltp-list@lists.sourceforge.net; Fri, 30 Oct 2009 16:56:19 +0000
Received: from fmmailgate01.web.de ([217.72.192.221])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N3ulm-00080Q-IG
	for ltp-list@lists.sourceforge.net; Fri, 30 Oct 2009 16:56:17 +0000
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 22407134F4BA5
	for <ltp-list@lists.sourceforge.net>;
	Fri, 30 Oct 2009 17:55:14 +0100 (CET)
Received: from [83.208.36.163] (helo=debian)
	by smtp05.web.de with asmtp (WEB.DE 4.110 #314) id 1N3ukp-00034q-00
	for ltp-list@lists.sourceforge.net; Fri, 30 Oct 2009 17:55:11 +0100
Date: Wed, 21 Oct 2009 13:36:39 +0200
From: "Jiri Palecek" <jpalecek@web.de>
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.u2mj58qgcfnueu@debian>
Subject: [LTP] [PATCH] Use a saner variant for computing the number of
 groups in cpuctl tests
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
Sender: ltp-list-bounces@lists.sourceforge.net
Errors-To: ltp-list-bounces@lists.sourceforge.net
Cc: ltp-list@lists.sourceforge.net
Message-ID: <20091021113639.7wmtddJkfATUNfjqA5gz8UgbAF-EyxppEqKQBLsi0z4@z>

Hello,

this patch changes the calculation of numer of groups in cpuctl test.

The new code doesn't need bc, and is more comprehensible IMHO

Regards
    Jiri Palecek

---
 testcases/kernel/controllers/cpuctl/parameters.sh |   11 +----------
 1 files changed, 1 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/controllers/cpuctl/parameters.sh b/testcases/kernel/controllers/cpuctl/parameters.sh
index a23dbe5..502944e 100755
--- a/testcases/kernel/controllers/cpuctl/parameters.sh
+++ b/testcases/kernel/controllers/cpuctl/parameters.sh
@@ -61,16 +61,7 @@ set_def_group() #default group spinning a task to create ideal scenario
 
 get_num_groups()        # Number of tasks should be >= number of cpu's (to check scheduling fairness)
 {
-        num_grps=$(echo "$NUM_CPUS * 1.5"|bc)   # temp variable num_grps
-        int_part=`echo $num_grps | cut -d"." -f1`
-        dec_part=`echo $num_grps | cut -d"." -f2`
-
-        if [ $dec_part -gt 0 ]
-        then
-                NUM_GROUPS=$(echo "$int_part + 1"|bc)
-        else
-                NUM_GROUPS=$int_part;
-        fi
+        NUM_GROUPS=$(( (NUM_CPUS*3 + 1)/2 ))
 }
 
 	# Write the cleanup function
-- 
1.6.4.3




------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
