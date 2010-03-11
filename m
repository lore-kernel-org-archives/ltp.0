Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <y_yao@ryobi.co.jp>) id 1NpZqx-0002lZ-NN
	for ltp-list@lists.sourceforge.net; Thu, 11 Mar 2010 04:18:31 +0000
Received: from out01.sjc.mx.trendmicro.com ([216.99.131.5])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NpZqw-0003um-9l
	for ltp-list@lists.sourceforge.net; Thu, 11 Mar 2010 04:18:31 +0000
Received: from relay01.sjc.mx.trendmicro.com (unknown [10.30.239.5])
	by out01.sjc.mx.trendmicro.com (Postfix) with ESMTP id 813732397A9
	for <ltp-list@lists.sourceforge.net>;
	Thu, 11 Mar 2010 04:18:23 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay01.sjc.mx.trendmicro.com (Postfix) with ESMTP id DB0D9114B84C
	for <ltp-list@lists.sourceforge.net>;
	Thu, 11 Mar 2010 04:18:22 +0000 (UTC)
Received: from 5108637 ([10.113.10.201]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Mar 2010 13:18:21 +0900
From: "Yuki Yao" <y_yao@ryobi.co.jp>
Date: Thu, 11 Mar 2010 13:18:20 +0900
Message-ID: <001801cac0d1$e273acd0$a75b0670$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] fixing memcg_control
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

Hi,

I found following problem about "memcg_control" test.
---------
/opt/ltp/testcases/bin/memcg_control_test.sh: line 30: [: : integer
expression expected
----------

This happens because of following process. 
[ memcg_control_test.sh: line 30 ]
---------
if [ "$(grep -w memory /proc/cgroups | cut -f4)" -ne "1" ]; then
        echo "WARNING:"
        echo "Either kernel does not support memory resource controller or
feature not ena
bled"
        echo "Skipping all memcg_control testcases...."
        exit 0
fi
---------

"$(grep -w memory /proc/cgroups | cut -f4)" can't comparable with "1"
if "$(grep -w memory /proc/cgroups | cut -f4)" = nothing.

How about fixing like the other "memcg" tests?

Signed-off-by: Yuki Yao<y_yao@ryobi.co.jp>

Index: ./testcases/commands/mail/mail_tests.sh
==============================
---
/home/LTP/ltp-dev-20100311/testcases/kernel/controllers/memcg/control/memcg_
control_test.sh.org	2010-03-11 11:31:07.000000000 +0900
+++
/home/LTP/ltp-dev-20100311/testcases/kernel/controllers/memcg/control/memcg_
control_test.sh	2010-03-11 11:32:21.000000000 +0900
@@ -27,7 +27,7 @@
 ##
##
 
############################################################################
####
 
-if [ "$(grep -w memory /proc/cgroups | cut -f4)" -ne "1" ]; then
+if [ "x$(grep -w memory /proc/cgroups | cut -f4)" != "x1" ]; then
 	echo "WARNING:"
 	echo "Either kernel does not support memory resource controller or
feature not enabled"
 	echo "Skipping all memcg_control testcases...."

Thanks,
-Yuki Yao



------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
