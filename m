Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1NYL2v-0004x7-OA
	for ltp-list@lists.sourceforge.net; Fri, 22 Jan 2010 15:03:37 +0000
Received: from fmmailgate02.web.de ([217.72.192.227])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NYL2u-0005E0-9v
	for ltp-list@lists.sourceforge.net; Fri, 22 Jan 2010 15:03:37 +0000
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id 7164A14C547CD
	for <ltp-list@lists.sourceforge.net>;
	Fri, 22 Jan 2010 12:27:43 +0100 (CET)
Received: from [90.180.172.144] (helo=debian)
	by smtp06.web.de with asmtp (WEB.DE 4.110 #314) id 1NYHfw-0005md-00
	for ltp-list@lists.sourceforge.net; Fri, 22 Jan 2010 12:27:40 +0100
Date: Fri, 22 Jan 2010 13:27:38 +0100
From: "Jiri Palecek" <jpalecek@web.de>
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.u6xow5oycfnueu@debian>
Subject: [LTP] [PATCH] Fix a probable typo in mc_commo,
 causing attempts to run nonexistent binaries
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
Message-ID: <20100122122738.r12_b0CJzH6xHCwcL2gMBF8x-fspJBdOCpxzxD_r_8s@z>

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 testcases/network/multicast/mc_commo/mc_commo |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/network/multicast/mc_commo/mc_commo b/testcases/network/multicast/mc_commo/mc_commo
index 1dad35a..1ea7e59 100755
--- a/testcases/network/multicast/mc_commo/mc_commo
+++ b/testcases/network/multicast/mc_commo/mc_commo
@@ -128,7 +128,7 @@ do_test ()
       do
          echo "Running on $HOST mc_send $GROUP_ADDR $HOST $PORT $TTL"
 
-         rsh -n -l root $HOST "$LTPROOT/testcases/bin$REMOTE_EXEC" $GROUP_ADDR \
+         rsh -n -l root $HOST "$LTPROOT/testcases/bin/$REMOTE_EXEC" $GROUP_ADDR \
 	 $HOST $PORT $TTL >/dev/null &
          sleep 10
 	rsh -n -l root $HOST "ps -ewf | grep mc_send | grep -v grep"
-- 
1.6.4.3




------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
