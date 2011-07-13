Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <francesco.rundo@st.com>) id 1Qh0Q7-00085X-DZ
	for ltp-list@lists.sourceforge.net; Wed, 13 Jul 2011 14:28:11 +0000
Received: from eu1sys200aog118.obsmtp.com ([207.126.144.145])
	by sog-mx-4.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qh0Q3-0001KP-In
	for ltp-list@lists.sourceforge.net; Wed, 13 Jul 2011 14:28:11 +0000
Received: from zeta.dmz-eu.st.com (ns2.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 321CC1AD
	for <ltp-list@lists.sourceforge.net>;
	Wed, 13 Jul 2011 14:27:59 +0000 (GMT)
Received: from mail7.sgp.st.com (unknown [164.129.223.81])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AE6D146A7
	for <ltp-list@lists.sourceforge.net>;
	Wed, 13 Jul 2011 14:27:59 +0000 (GMT)
From: Francesco RUNDO <francesco.rundo@st.com>
Date: Wed, 13 Jul 2011 16:27:31 +0200
Message-Id: <1310567251-20343-1-git-send-email-no>
Subject: [LTP] [PATCH] kill05: Added proper return code (TPASS) if testcase
	exit without errors.
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

From: Francesco Rundo <francesco.rundo@st.com>

	Added kill05 TPASS exit code.

The testcase didn't return any retrun code in case of 
exit without errors i.e. in case of EPERM is correctly 
raised by the system.

Signed-off-by: Francesco Rundo <francesco.rundo@st.com>
Signed-off-by: Carmelo Amoroso <carmelo.amoroso@st.com>
---
 testcases/kernel/syscalls/kill/kill05.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/syscalls/kill/kill05.c b/testcases/kernel/syscalls/kill/kill05.c
index fe34788..23fac0a 100644
--- a/testcases/kernel/syscalls/kill/kill05.c
+++ b/testcases/kernel/syscalls/kill/kill05.c
@@ -126,6 +126,8 @@ int main(int ac, char **av)
 		tst_resm(TBROK|TERRNO, "waitpid failed");
 	else if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
 		tst_resm(TFAIL, "child exited abnormally");
+	else
+		tst_resm(TPASS, "received expected errno(EPERM)");
 	cleanup();
 	tst_exit();
 }
-- 
1.7.4.4


------------------------------------------------------------------------------
AppSumo Presents a FREE Video for the SourceForge Community by Eric 
Ries, the creator of the Lean Startup Methodology on "Lean Startup 
Secrets Revealed." This video shows you how to validate your ideas, 
optimize your ideas and identify your business strategy.
http://p.sf.net/sfu/appsumosfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
