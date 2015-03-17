Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <njoly@pasteur.fr>) id 1YXlcO-0001il-Jr
	for ltp-list@lists.sourceforge.net; Tue, 17 Mar 2015 07:08:48 +0000
Received: from mail-interne2.pasteur.fr ([157.99.64.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YXlcM-0003Si-RB
	for ltp-list@lists.sourceforge.net; Tue, 17 Mar 2015 07:08:48 +0000
Date: Tue, 17 Mar 2015 08:08:40 +0100
From: Nicolas Joly <njoly@pasteur.fr>
Message-ID: <20150317070840.GA2801@issan.sis.pasteur.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
Subject: [LTP] [PATCH] Fix unprivileged llseek01 behaviour
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP list <ltp-list@lists.sourceforge.net>


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi,

Running llseek01 testcase as unprivileged user currently fails.

njoly@raya [syscalls/llseek]> ./llseek01
llseek01    1  TPASS  :  Functionality of llseek() on tmp_file successful
llseek01    2  TBROK  :  llseek01.c:223: Cannot reset max. file size using setrlimit
llseek01    3  TBROK  :  llseek01.c:223: Remaining cases broken

This issue comes from cleanup function that tries to restore
previously altered file size limit. But this fails as unprivileged
because it cannot raise the hard limits.

The attached patch make the testcase succeed as unprivileged by
removing the offending setrlimit call.

njoly@raya [syscalls/llseek]> ./llseek01
llseek01    1  TPASS  :  Functionality of llseek() on tmp_file successful

Hope this helps,
Regards.

-- 
Nicolas Joly

Biology IT Center
Institut Pasteur, Paris.

--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ltp-llseekunprivileged.diff"

commit a98d20f5a35ecb09c0185ef7b8be1e46d726c1c9
Author: Nicolas Joly <njoly@pasteur.fr>
Date:   Tue Mar 17 07:51:21 2015 +0100

    syscalls/llseek01: Fix unprivileged behaviour
    
    Kill unneeded setrlimit call from cleanup.
    Only privileged process can increase hard limits.
    
    Signed-off-by: Nicolas Joly <njoly@pasteur.fr>

diff --git a/testcases/kernel/syscalls/llseek/llseek01.c b/testcases/kernel/syscalls/llseek/llseek01.c
index b956dbf..5202d3b 100644
--- a/testcases/kernel/syscalls/llseek/llseek01.c
+++ b/testcases/kernel/syscalls/llseek/llseek01.c
@@ -217,9 +217,4 @@ void cleanup(void)
 	SAFE_CLOSE(NULL, fildes);
 
 	tst_rmdir();
-
-	if (setrlimit(RLIMIT_FSIZE, &rlp_orig) == -1)
-		tst_brkm(TBROK, NULL,
-			 "Cannot reset max. file size using setrlimit");
-
 }

--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--Q68bSM7Ycu6FN28Q--

