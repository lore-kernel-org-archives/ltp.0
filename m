Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <penght@cn.fujitsu.com>) id 1PfpRE-0002fl-MI
	for ltp-list@lists.sourceforge.net; Thu, 20 Jan 2011 08:00:12 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PfpRD-0000gL-4Z
	for ltp-list@lists.sourceforge.net; Thu, 20 Jan 2011 08:00:12 +0000
Message-ID: <4D37EB92.3060901@cn.fujitsu.com>
Date: Thu, 20 Jan 2011 16:00:18 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] mprotect02: fix error of the case need sighandler()
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi Garrett,

The case expect the signal "SIGSEGV", so should add sighandler().

Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>

---
 testcases/kernel/syscalls/mprotect/mprotect02.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/syscalls/mprotect/mprotect02.c b/testcases/kernel/syscalls/mprotect/mprotect02.c
index ebc4bcc..36c41de 100644
--- a/testcases/kernel/syscalls/mprotect/mprotect02.c
+++ b/testcases/kernel/syscalls/mprotect/mprotect02.c
@@ -198,12 +198,21 @@ int main()
 
 #endif /* UCLINUX */
 
+void sighandler(int sig)
+{
+	tst_resm(TINFO, "received signal: %d", sig);
+	if (sig == SIGSEGV)
+		exit(1);
+	else
+		tst_brkm(TBROK, 0, "Unexpected signal %d received.", sig);
+}
+
 /*
  * setup() - performs all ONE TIME setup for this test
  */
 void setup()
 {
-	tst_sig(FORK, DEF_HANDLER, NULL);
+	tst_sig(FORK, sighandler, NULL);
 
 	TEST_PAUSE;
 
-- 
1.7.3.1

-- 
Best Regards,
Peng Haitao


------------------------------------------------------------------------------
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand 
malware threats, the impact they can have on your business, and how you 
can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
