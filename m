Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <carmelo.amoroso@st.com>) id 1RnX4L-00023T-HM
	for ltp-list@lists.sourceforge.net; Wed, 18 Jan 2012 15:04:57 +0000
Received: from eu1sys200aog116.obsmtp.com ([207.126.144.141])
	by sog-mx-3.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RnX4G-0001KS-1w
	for ltp-list@lists.sourceforge.net; Wed, 18 Jan 2012 15:04:57 +0000
From: Carmelo AMOROSO <carmelo.amoroso@st.com>
Date: Wed, 18 Jan 2012 16:04:36 +0100
Message-Id: <1326899076-19591-1-git-send-email-carmelo.amoroso@st.com>
Subject: [LTP] [PATCH 2/2] buildsys: use short format for git describe
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
To: ltp-list@lists.sf.net

Suppress long format, only showing the closest tag, when creating
the Version file under git

Signed-off-by: Carmelo Amoroso <carmelo.amoroso@st.com>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 90f171e..fe244d9 100644
--- a/Makefile
+++ b/Makefile
@@ -174,7 +174,7 @@ SRCDIR_INSTALL_TARGETS	:= $(SRCDIR_INSTALL_SCRIPTS) $(SRCDIR_INSTALL_READONLY)
 .PHONY: Version
 Version:
 	if git describe &> /dev/null; then \
-		git describe > "$@"; \
+		git describe --abbrev=0 > "$@"; \
 	else \
 		cp VERSION "$@"; \
 	fi
-- 
1.7.4.4


------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
