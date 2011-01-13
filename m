Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <penght@cn.fujitsu.com>) id 1PdHvw-0006ML-Q9
	for ltp-list@lists.sourceforge.net; Thu, 13 Jan 2011 07:49:24 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PdHvv-0002ds-8W
	for ltp-list@lists.sourceforge.net; Thu, 13 Jan 2011 07:49:24 +0000
Message-ID: <4D2EAE87.9030607@cn.fujitsu.com>
Date: Thu, 13 Jan 2011 15:49:27 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] Fix a building error at fork cases.
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
To: yanegomi@gmail.com
Cc: ltp-list@lists.sourceforge.net

Hi Garrett,

Fix building error of fork cases.

Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>

---
 .../conformance/interfaces/fork/21-1.c             |    3 +--
 .../conformance/interfaces/fork/7-1.c              |    3 ++-
 .../conformance/interfaces/fork/8-1.c              |    3 +--
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/fork/21-1.c b/testcases/open_posix_testsuite/conformance/interfaces/fork/21-1.c
index 70f29d1..ef75ce9 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/fork/21-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/fork/21-1.c
@@ -99,7 +99,6 @@ void * threaded(void * arg)
 	}
 
 	if (*(pid_t *) arg != getpid())
->>>>>>> origin
 	{
 		FAILED("The thread is executing in the child process");
 	}
@@ -201,4 +200,4 @@ int main(int argc, char * argv[])
 
 #endif
 	PASSED;
-}
\ No newline at end of file
+}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/fork/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/fork/7-1.c
index 09f229e..dfa80ce 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/fork/7-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/fork/7-1.c
@@ -117,6 +117,7 @@ int main(int argc, char * argv[])
 		}
 
 		ret = system("gencat "MESSCAT_OUT" "MESSCAT_IN);
+	}
 
 	if (messcat == -1)
 	{
@@ -161,4 +162,4 @@ int main(int argc, char * argv[])
 	output("Test passed\n");
 #endif
 	PASSED;
-}
\ No newline at end of file
+}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/fork/8-1.c b/testcases/open_posix_testsuite/conformance/interfaces/fork/8-1.c
index 086dc33..6e73919 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/fork/8-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/fork/8-1.c
@@ -170,7 +170,6 @@ int main(int argc, char * argv[])
 			}
 		}
 		while ((child_tms.tms_utime + child_tms.tms_stime) <= 0);
->>>>>>> origin
 
 		/* We're done */
 		exit(PTS_PASS);
@@ -226,4 +225,4 @@ int main(int argc, char * argv[])
 #endif
 
 	PASSED;
-}
\ No newline at end of file
+}
-- 
1.7.0.4

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
