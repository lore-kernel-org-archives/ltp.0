Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <salvatore.cro@st.com>) id 1RxGB4-0007Qp-Pm
	for ltp-list@lists.sourceforge.net; Tue, 14 Feb 2012 11:04:06 +0000
Received: from eu1sys200aog114.obsmtp.com ([207.126.144.137])
	by sog-mx-4.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RxGB0-0001SY-Gt
	for ltp-list@lists.sourceforge.net; Tue, 14 Feb 2012 11:04:06 +0000
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 78D7C17C
	for <ltp-list@lists.sourceforge.net>;
	Tue, 14 Feb 2012 11:03:55 +0000 (GMT)
Received: from mail7.sgp.st.com (mail7.sgp.st.com [164.129.223.81])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3598123BA
	for <ltp-list@lists.sourceforge.net>;
	Tue, 14 Feb 2012 11:03:55 +0000 (GMT)
Message-ID: <4F3A3F98.6000808@st.com>
Date: Tue, 14 Feb 2012 12:03:52 +0100
From: "Salvatore CRO'" <salvatore.cro@st.com>
MIME-Version: 1.0
References: <1329215581-26357-1-git-send-email-salvatore.cro@st.com>
In-Reply-To: <1329215581-26357-1-git-send-email-salvatore.cro@st.com>
Subject: [LTP] Fwd: [PATCH] clone06: legitimate zero as sprintf return value
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

To be honest I don't see any reason to have the sprintf at all.
I will refine my patch to directly evaluate string var to getenv...

-------- Original Message --------
Return-Path: 	<salvatore.cro@st.com>
Received: 	from localhost (lxmcdt5.ctn.st.com [164.130.129.175]) by 
mail7.sgp.st.com (MOS 4.3.3-GA) with ESMTP id ALM11201 (AUTH cros); Tue, 
14 Feb 2012 11:33:12 +0100
From: 	Salvatore CRO' <salvatore.cro@st.com>
To: 	ltp-list@lists.sourceforge.net
Cc: 	Salvatore Cro <salvatore.cro@st.com>
Subject: 	[PATCH] clone06: legitimate zero as sprintf return value
Date: 	Tue, 14 Feb 2012 11:33:01 +0100
Message-Id: 	<1329215581-26357-1-git-send-email-salvatore.cro@st.com>
X-Mailer: 	git-send-email 1.7.4.4



A return value of 0 for sprintf is acceptable as
it means zero byte read.
Indeed errno is not set in this case thus no warning
messages must be issued.

Signed-off-by: Salvatore Cro<salvatore.cro@st.com>
---
  testcases/kernel/syscalls/clone/clone06.c |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/syscalls/clone/clone06.c b/testcases/kernel/syscalls/clone/clone06.c
index 5db183b..8ba7c13 100644
--- a/testcases/kernel/syscalls/clone/clone06.c
+++ b/testcases/kernel/syscalls/clone/clone06.c
@@ -199,7 +199,7 @@ int child_environ(void)
  		tst_brkm(TBROK|TERRNO, cleanup, "close(pfd[0]) failed");
  	}

-	if ((sprintf(var, "%s", getenv("TERM") ? : ""))<= 0) {
+	if ((sprintf(var, "%s", getenv("TERM") ? : ""))<  0) {
  		tst_resm(TWARN|TERRNO, "sprintf() failed");
  	}

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
