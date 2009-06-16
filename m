Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <njoly@pasteur.fr>) id 1MGVMN-00015t-32
	for ltp-list@lists.sourceforge.net; Tue, 16 Jun 2009 09:53:43 +0000
Received: from munster3.sis.pasteur.fr ([157.99.64.214])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MGVL8-0001Il-FJ
	for ltp-list@lists.sourceforge.net; Tue, 16 Jun 2009 09:53:43 +0000
Date: Tue, 16 Jun 2009 11:52:20 +0200
From: Nicolas Joly <njoly@pasteur.fr>
Message-ID: <20090616095220.GA218461@medusa.sis.pasteur.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
Subject: [LTP] Small typo in sgetmask01.c
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


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi,

Here follow a small patch that fix a typo in sgetmask01.c testcase,
where __NR_ssetmask is badly used instead of __NR_sgetmask.

Regards.

-- 
Nicolas Joly

Biological Software and Databanks.
Institut Pasteur, Paris.

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ltp-sgetmask.diff"

Index: testcases/kernel/syscalls/sgetmask/sgetmask01.c
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/syscalls/sgetmask/sgetmask01.c,v
retrieving revision 1.1
diff -u -p -r1.1 sgetmask01.c
--- testcases/kernel/syscalls/sgetmask/sgetmask01.c	21 May 2009 18:35:31 -0000	1.1
+++ testcases/kernel/syscalls/sgetmask/sgetmask01.c	16 Jun 2009 09:45:37 -0000
@@ -141,7 +141,7 @@ int main(int ac, char **av) {
 			for (sig = -3; sig <= SIGRTMAX + 1; sig++){
 				TEST(syscall(__NR_ssetmask,sig));
                 		tst_resm(TINFO,"Setting signal : %d -- return of setmask : %d",sig,TEST_RETURN);     //call sgetmask()
-                     		TEST(syscall(__NR_ssetmask));     //call sgetmask()
+                     		TEST(syscall(__NR_sgetmask));     //call sgetmask()
                      		if(TEST_RETURN != sig) {
         				tst_resm(TINFO,"Oops,setting sig %d, got %d",sig,TEST_RETURN);
                      		} else

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--G4iJoqBmSsgzjUCe--

