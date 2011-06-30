Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanpai.chen@gmail.com>) id 1QcAdB-00064b-Sv
	for ltp-list@lists.sourceforge.net; Thu, 30 Jun 2011 06:21:41 +0000
Received: from mail-yi0-f47.google.com ([209.85.218.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1QcAdA-0004AL-Tv
	for ltp-list@lists.sourceforge.net; Thu, 30 Jun 2011 06:21:41 +0000
Received: by yib18 with SMTP id 18so1018474yib.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 29 Jun 2011 23:21:35 -0700 (PDT)
From: Andrew Chen <yanpai.chen@gmail.com>
Date: Thu, 30 Jun 2011 14:19:44 +0800
Message-Id: <1309414787-2022-4-git-send-email-yanpai.chen@gmail.com>
In-Reply-To: <1309414787-2022-1-git-send-email-yanpai.chen@gmail.com>
References: <1309414787-2022-1-git-send-email-yanpai.chen@gmail.com>
Subject: [LTP] [PATCH 4/7] testcases: memcg_function: set hugepage size to
	zero when no hugepage support
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
Cc: ypchen@faraday-tech.com

From: Andrew Chen <ypchen@faraday-tech.com>


Signed-off-by: Andrew Chen <ypchen@faraday-tech.com>
---
 .../memcg/functional/memcg_function_test.sh        |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/ltp-full-20101031/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh b/ltp-full-20101031/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
index 56010ad..c504ed6 100755
--- a/ltp-full-20101031/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
+++ b/ltp-full-20101031/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
@@ -45,6 +45,7 @@ FAIL=1
 
 PAGESIZE=`./memcg_getpagesize`
 HUGEPAGESIZE=`grep Hugepagesize /proc/meminfo | awk '{ print $2 }'`
+[ -z $HUGEPAGESIZE ] && HUGEPAGESIZE=0
 HUGEPAGESIZE=$(( $HUGEPAGESIZE * 1024 ))
 
 cur_id=0
-- 
1.6.5


------------------------------------------------------------------------------
All of the data generated in your IT infrastructure is seriously valuable.
Why? It contains a definitive record of application performance, security 
threats, fraudulent activity, and more. Splunk takes this data and makes 
sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-d2d-c2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
