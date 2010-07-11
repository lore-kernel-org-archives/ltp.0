Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <njoly@pasteur.fr>) id 1OY5Vp-0005iP-JA
	for ltp-list@lists.sourceforge.net; Sun, 11 Jul 2010 23:00:41 +0000
Received: from mail-interne3.pasteur.fr ([157.99.64.82])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OY5Vo-0002jt-8u
	for ltp-list@lists.sourceforge.net; Sun, 11 Jul 2010 23:00:41 +0000
Date: Mon, 12 Jul 2010 00:41:54 +0200
From: Nicolas Joly <njoly@pasteur.fr>
Message-ID: <20100711224154.GA496240@medusa.sis.pasteur.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
Subject: [LTP] clock_getres01: remove TERRNO flag for overall test result
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
To: LTP list <ltp-list@lists.sf.net>


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi,

The attached patch remove the TERRNO flag for the overall
clock_getres01 test status. It is wrong because, if one of the test
fails, the reported errno will always be the one from the last case05
test (even 0 if this one was successful).

Upon failure, the output will be:

[...]
clock_getres01    0  TINFO  :  (case05) START
EXPECT: return value(ret)=(N >= 0) errno=0 (Success)
RESULT: return value(ret)=       0 errno=0 (Success)
clock_getres01    6  TPASS  :  (case05) END
clock_getres01    7  TFAIL  :  clock_getres01 failed

But previously:

[...]
clock_getres01    0  TINFO  :  (case05) START
EXPECT: return value(ret)=(N >= 0) errno=0 (Success)
RESULT: return value(ret)=       0 errno=0 (Success)
clock_getres01    6  TPASS  :  (case05) END
clock_getres01    7  TFAIL  :  clock_getres01 failed: errno=???(0): Success

Signed-off-by: Nicolas Joly <njoly@pasteur.fr>

Regards.

-- 
Nicolas Joly

Biological Software and Databanks.
Institut Pasteur, Paris.

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ltp-clock_getres01.diff"

diff --git a/testcases/kernel/syscalls/clock_getres/clock_getres01.c b/testcases/kernel/syscalls/clock_getres/clock_getres01.c
index 412ffa5..7df8c71 100644
--- a/testcases/kernel/syscalls/clock_getres/clock_getres01.c
+++ b/testcases/kernel/syscalls/clock_getres/clock_getres01.c
@@ -327,7 +327,7 @@ int main(int ac, char **av) {
 				break;
 
 			default:
-		 	   	tst_resm(TFAIL | TERRNO, "%s failed", TCID);
+		 	   	tst_resm(TFAIL, "%s failed", TCID);
 				RPRINTF("NG\n");
 				cleanup();
 				tst_exit();

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--rwEMma7ioTxnRzrJ--

