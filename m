Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <francesco.rundo@st.com>) id 1QgYal-0001eo-7z
	for ltp-list@lists.sourceforge.net; Tue, 12 Jul 2011 08:45:19 +0000
Received: from eu1sys200aog116.obsmtp.com ([207.126.144.141])
	by sog-mx-4.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QgYai-0000qR-Ri
	for ltp-list@lists.sourceforge.net; Tue, 12 Jul 2011 08:45:19 +0000
Received: from zeta.dmz-eu.st.com (ns2.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 272BC103
	for <ltp-list@lists.sourceforge.net>;
	Tue, 12 Jul 2011 08:45:09 +0000 (GMT)
Received: from mail7.sgp.st.com (mail7.sgp.st.com [164.129.223.81])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 82CF914C0
	for <ltp-list@lists.sourceforge.net>;
	Tue, 12 Jul 2011 08:45:09 +0000 (GMT)
From: Francesco RUNDO <francesco.rundo@st.com>
Date: Tue, 12 Jul 2011 10:45:00 +0200
Message-Id: <1310460300-15247-1-git-send-email-y>
Subject: [LTP] [PATCH] Added proper return code (TPASS) in case of exit
	without errors.
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

The "kill05" testcase checks if EPERM is correctly raised by the system.
The testcase manages the error exit codes correctly while it didn't return
any exit code in case of no errors occured i.e. the system has raised EPERM.
The correct exit-code "TPASS" has been added in case of the test works fine without
errors.

Signed-off-by: Francesco Rundo <francesco.rundo@st.com>
Reviewed-by: Carmelo Amoroso <carmelo.amoroso@st.com>
---
 testcases/kernel/syscalls/kill/kill05.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/syscalls/kill/kill05.c b/testcases/kernel/syscalls/kill/kill05.c
index fe34788..2a75a2a 100644
--- a/testcases/kernel/syscalls/kill/kill05.c
+++ b/testcases/kernel/syscalls/kill/kill05.c
@@ -126,6 +126,7 @@ int main(int ac, char **av)
 		tst_resm(TBROK|TERRNO, "waitpid failed");
 	else if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
 		tst_resm(TFAIL, "child exited abnormally");
+	else tst_resm(TPASS, "received expected errno(EPERM)");
 	cleanup();
 	tst_exit();
 }
-- 
1.7.4.4


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
