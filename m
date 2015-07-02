Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liuhangbin@gmail.com>) id 1ZAaCg-0004JO-Hw
	for ltp-list@lists.sourceforge.net; Thu, 02 Jul 2015 08:50:42 +0000
Received: from mail-pd0-f172.google.com ([209.85.192.172])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZAaCf-0001RF-Ln
	for ltp-list@lists.sourceforge.net; Thu, 02 Jul 2015 08:50:42 +0000
Received: by pdbep18 with SMTP id ep18so41625080pdb.1
	for <ltp-list@lists.sourceforge.net>;
	Thu, 02 Jul 2015 01:50:36 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Thu,  2 Jul 2015 16:50:19 +0800
Message-Id: <1435827019-7831-1-git-send-email-liuhangbin@gmail.com>
Subject: [LTP] [PATCH] network/stress/ssh: tcp_fastopen test must be run
	with kernel 3.7 or newer
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
To: LTP List <ltp-list@lists.sourceforge.net>

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 testcases/network/stress/ssh/ssh-stress | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/network/stress/ssh/ssh-stress b/testcases/network/stress/ssh/ssh-stress
index 7960627..3ff2367 100644
--- a/testcases/network/stress/ssh/ssh-stress
+++ b/testcases/network/stress/ssh/ssh-stress
@@ -126,6 +126,9 @@ test02()
 
 test03()
 {
+	tst_kvercmp 3 7 0 && \
+		tst_brkm TCONF "Test must be run with kernel 3.7 or newer"
+
 	tst_resm TINFO "Forwarding TCP traffic with $NS_TIMES requests"
 
 	# Run a TCP traffic server
-- 
1.9.3


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
