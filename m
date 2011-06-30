Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanpai.chen@gmail.com>) id 1QcAd3-00063g-Kg
	for ltp-list@lists.sourceforge.net; Thu, 30 Jun 2011 06:21:33 +0000
Received: from mail-gx0-f175.google.com ([209.85.161.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1QcAd2-0003gJ-PX
	for ltp-list@lists.sourceforge.net; Thu, 30 Jun 2011 06:21:33 +0000
Received: by gxk3 with SMTP id 3so1005483gxk.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 29 Jun 2011 23:21:27 -0700 (PDT)
From: Andrew Chen <yanpai.chen@gmail.com>
Date: Thu, 30 Jun 2011 14:19:42 +0800
Message-Id: <1309414787-2022-2-git-send-email-yanpai.chen@gmail.com>
In-Reply-To: <1309414787-2022-1-git-send-email-yanpai.chen@gmail.com>
References: <1309414787-2022-1-git-send-email-yanpai.chen@gmail.com>
Subject: [LTP] [PATCH 2/7] testcases: cgroup: correct wrong variable used in
	the testscript
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
 .../controllers/cgroup/cgroup_regression_test.sh   |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/ltp-full-20101031/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh b/ltp-full-20101031/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
index 5527afc..c7ce791 100755
--- a/ltp-full-20101031/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
+++ b/ltp-full-20101031/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
@@ -254,7 +254,7 @@ test_5()
 	subsys1=`tail -n 1 /proc/cgroups | awk '{ print $1 }'`
 	subsys2=`tail -n 2 /proc/cgroups | head -1 | awk '{ print $1 }'`
 
-	mount -t cgroup -o $subsys1,$subsys xxx cgroup/
+	mount -t cgroup -o $subsys1,$subsys2 xxx cgroup/
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "mount $subsys1 and $subsys2 failed"
 		failed=1
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
