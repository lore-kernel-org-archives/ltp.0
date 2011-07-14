Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <francesco.rundo@st.com>) id 1QhLwT-00018v-Mu
	for ltp-list@lists.sourceforge.net; Thu, 14 Jul 2011 13:27:01 +0000
Received: from eu1sys200aog118.obsmtp.com ([207.126.144.145])
	by sog-mx-2.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QhLwP-0006eh-SR
	for ltp-list@lists.sourceforge.net; Thu, 14 Jul 2011 13:27:01 +0000
Received: from zeta.dmz-eu.st.com (ns2.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 17C05161
	for <ltp-list@lists.sourceforge.net>;
	Thu, 14 Jul 2011 13:26:50 +0000 (GMT)
Received: from mail7.sgp.st.com (unknown [164.129.223.81])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BB9F829BA
	for <ltp-list@lists.sourceforge.net>;
	Thu, 14 Jul 2011 13:26:50 +0000 (GMT)
From: Francesco RUNDO <francesco.rundo@st.com>
Date: Thu, 14 Jul 2011 15:26:23 +0200
Message-Id: <1310649983-28262-1-git-send-email-n>
Subject: [LTP] [PATCH V2] kill05: Added tst_resm() to print the proper error
	code(TPASS) if test exits with EPERM
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

Added "tst_resm()" call to print the proper LTP error code(TPASS)
in case of the testcase exit with expected result.

The testcase didn't call "tst_resm()" in case of 
exit without error i.e. after that EPERM is correctly raised.
The proper LTP error code, in that case, is TPASS as EPERM
is the expected result.

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
