Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1T6hhx-0002tZ-PE
	for ltp-list@lists.sourceforge.net; Wed, 29 Aug 2012 12:49:21 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1T6hhr-000896-Vm
	for ltp-list@lists.sourceforge.net; Wed, 29 Aug 2012 12:49:21 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q7TCn9gm028841
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 29 Aug 2012 08:49:10 -0400
From: Zhouping Liu <zliu@redhat.com>
Date: Wed, 29 Aug 2012 20:43:59 +0800
Message-Id: <92b6d1dd1bba3ce81f5f51612e99a23ed2409b7e.1346244062.git.zliu@redhat.com>
In-Reply-To: <cd572cfe7fb9a357ce92149957ed2a3779c542d3.1346244062.git.zliu@redhat.com>
References: <cd572cfe7fb9a357ce92149957ed2a3779c542d3.1346244062.git.zliu@redhat.com>
Subject: [LTP] [PATCH 3/3] tunable/min_free_kbytes: add 32-bit system limit
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
To: LTP list <ltp-list@lists.sourceforge.net>

in 32-bit system, one process only allocate 3Gb memory at
least, even though there are enough memory and setting
overcommit_memory=1, the porcess always exit when it arrives
in 3Gb memory.

the patch use '__WORDSIZE' macro to avoid the incorrect 'TFAIL'
without the patch:
 ---- snip ----
 min_free_kbytes    0  TINFO  :  set overcommit_memory to 1
 min_free_kbytes    0  TINFO  :  set min_free_kbytes to 3794
 memfree is 15478420 kB before eatup mem
 memfree is 12333408 kB after eatup mem
 min_free_kbytes    3  TFAIL  :  child unexpectedly failed: 0
 min_free_kbytes    0  TINFO  :  set min_free_kbytes to 7588
 ---- snip ----

after applying the patch:
 ---- snip ----
 min_free_kbytes    0  TINFO  :  set overcommit_memory to 1
 min_free_kbytes    0  TINFO  :  set min_free_kbytes to 3794
 memfree is 15478420 kB before eatup mem
 memfree is 12333408 kB after eatup mem
 min_free_kbytes    0  TINFO  :  Child can't allocate >3Gb memory in 32bit system
 min_free_kbytes    0  TINFO  :  set min_free_kbytes to 7588
 ---- snip ----

Reported-by: Shuang Qiu <shuang.qiu@oracle.com>
Signed-off-by: Zhouping Liu <zliu@redhat.com>
---
 testcases/kernel/mem/tunable/min_free_kbytes.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c b/testcases/kernel/mem/tunable/min_free_kbytes.c
index dde182c..873b807 100644
--- a/testcases/kernel/mem/tunable/min_free_kbytes.c
+++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
@@ -158,8 +158,19 @@ static void test_tune(unsigned long overcommit_policy)
 				    "child unexpectedly failed: %d", status);
 		} else if (overcommit_policy == 1) {
 			if (!WIFSIGNALED(status) || WTERMSIG(status) != SIGKILL)
+#if __WORDSIZE == 32
+			{
+				if (total_mem < 3145728UL)
+#endif
 				tst_resm(TFAIL,
 				    "child unexpectedly failed: %d", status);
+#if __WORDSIZE == 32
+	/* in 32-bit system, a process allocate about 3Gb memory at most */
+				else
+					tst_resm(TINFO, "Child can't allocate "
+					    ">3Gb memory in 32bit system");
+			}
+#endif
 		} else {
 			if (WIFEXITED(status)) {
 				if (WEXITSTATUS(status) != 0) {
-- 
1.7.11.2


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
