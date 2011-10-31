Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <carmelo.amoroso@st.com>) id 1RKo3z-00038u-Iq
	for ltp-list@lists.sourceforge.net; Mon, 31 Oct 2011 09:21:51 +0000
Received: from eu1sys200aog109.obsmtp.com ([207.126.144.127])
	by sog-mx-4.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RKo3y-00088R-3V
	for ltp-list@lists.sourceforge.net; Mon, 31 Oct 2011 09:21:51 +0000
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5C3961AF
	for <ltp-list@lists.sourceforge.net>;
	Mon, 31 Oct 2011 09:21:38 +0000 (GMT)
Received: from mail7.sgp.st.com (mail7.sgp.st.com [164.129.223.81])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C97D51CF4
	for <ltp-list@lists.sourceforge.net>;
	Mon, 31 Oct 2011 09:21:38 +0000 (GMT)
From: Carmelo AMOROSO <carmelo.amoroso@st.com>
Date: Mon, 31 Oct 2011 10:21:24 +0100
Message-Id: <1320052884-11475-1-git-send-email-carmelo.amoroso@st.com>
Subject: [LTP] [PATCH] runltp: fix printing of LTP Version
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

Fix function 'version_of_ltp' to reference Version in the correct path
Fix Version's path when settign version_date

Signed-off-by: Carmelo Amoroso <carmelo.amoroso@st.com>
---
 runltp |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/runltp b/runltp
index 4ef8b38..244cd2f 100755
--- a/runltp
+++ b/runltp
@@ -97,7 +97,7 @@ setup()
 
 version_of_ltp()
 {
-    cat "$LTPROOT/Version"
+    cat "$LTPROOT/testcases/bin/Version"
     exit 0
 }
 
@@ -209,7 +209,7 @@ main()
 
     local scenfile=
 
-    version_date=$(cat "$LTPROOT/Version")
+    version_date=$(cat "$LTPROOT/testcases/bin/Version")
 
     while getopts a:c:C:d:D:f:F:ehi:K:g:l:m:M:Nno:pqr:s:S:t:T:w:x:b:B: arg
     do  case $arg in
-- 
1.7.4.4


------------------------------------------------------------------------------
Get your Android app more play: Bring it to the BlackBerry PlayBook 
in minutes. BlackBerry App World&#153; now supports Android&#153; Apps 
for the BlackBerry&reg; PlayBook&#153;. Discover just how easy and simple 
it is! http://p.sf.net/sfu/android-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
