Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <salvatore.cro@st.com>) id 1RSloz-0001H2-9w
	for ltp-list@lists.sourceforge.net; Tue, 22 Nov 2011 08:35:17 +0000
Received: from eu1sys200aog103.obsmtp.com ([207.126.144.115])
	by sog-mx-1.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RSlov-0003Ys-81
	for ltp-list@lists.sourceforge.net; Tue, 22 Nov 2011 08:35:17 +0000
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9FB9410C
	for <ltp-list@lists.sourceforge.net>;
	Tue, 22 Nov 2011 08:35:06 +0000 (GMT)
Received: from mail7.sgp.st.com (mail7.sgp.st.com [164.129.223.81])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 49C2F1ABE
	for <ltp-list@lists.sourceforge.net>;
	Tue, 22 Nov 2011 08:35:06 +0000 (GMT)
From: "Salvatore CRO'" <salvatore.cro@st.com>
Date: Tue, 22 Nov 2011 09:34:48 +0100
Message-Id: <1321950888-11346-1-git-send-email-salvatore.cro@st.com>
Subject: [LTP] [PATCH] testcases: exit from signal handler in setrlimit01
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
Cc: Salvatore Cro <salvatore.cro@st.com>

From: Salvatore Cro <salvatore.cro@st.com>

Signal hanlder is installed using default tst_sig function
which sets sa_flags = SA_RESTART for sigaction. In this
conditions the child gets stuck because at any SIGSEGV
caught the hanlder ends-up restarting the function which
raised the signal.
Signal handler must give the child the chance to exit.

Signed-off-by: Salvatore Cro <salvatore.cro@.st.com>
---
 testcases/kernel/syscalls/setrlimit/setrlimit01.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit01.c b/testcases/kernel/syscalls/setrlimit/setrlimit01.c
index 077c13b..4acf62c 100644
--- a/testcases/kernel/syscalls/setrlimit/setrlimit01.c
+++ b/testcases/kernel/syscalls/setrlimit/setrlimit01.c
@@ -326,6 +326,7 @@ void sighandler(int sig)
 	if (sig != SIGSEGV && sig != SIGXFSZ) {
 		tst_brkm(TBROK, NULL, "caught unexpected signal: %d", sig);
 	}
+	tst_exit();
 }
 
 /*
-- 
1.7.4.4


------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure 
contains a definitive record of customers, application performance, 
security threats, fraudulent activity, and more. Splunk takes this 
data and makes sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-novd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
