Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <zohar@linux.vnet.ibm.com>) id 1MscCI-0005f7-P3
	for ltp-list@lists.sourceforge.net; Tue, 29 Sep 2009 12:52:50 +0000
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MscC7-0000hg-GJ
	for ltp-list@lists.sourceforge.net; Tue, 29 Sep 2009 12:52:45 +0000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Tue, 29 Sep 2009 08:52:25 -0400
Message-Id: <1254228745.3843.10.camel@dyn9002018117.watson.ibm.com>
Mime-Version: 1.0
Subject: [LTP] IMA tcb policy
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
To: ltp-list <ltp-list@lists.sf.net>

Dependency section update.

Signed-off-by: Mimi Zohar <zohar@us.ibm.com>

Index: ltp-full-20090831/testcases/kernel/security/integrity/ima/README
===================================================================
--- ltp-full-20090831.orig/testcases/kernel/security/integrity/ima/README
+++ ltp-full-20090831/testcases/kernel/security/integrity/ima/README
@@ -46,11 +46,13 @@ CONFIG_IMA_LSM_RULES=y
 
 Dependency
 ----------
-The testsuite is dependent on the default policy being enabled, which
+The testsuite is dependent on the default TCB policy being enabled, which
 measures all executables, all files mmapped for execute and all files
-open for read by root. If the default policy has been replaced, loading
-another measurement policy will fail, as the policy may only be replaced
-once per boot. Some of the policy dependency tests might also fail as well.
+open for read by root.  For kernels 2.6.31 and greater, enable the
+trusted computing base(TCB) policy using the ima_tcb=1 boot parameter.
+If the TCB policy has been replaced, loading another measurement
+policy will fail, as the policy may only be replaced once per boot.
+Some of the policy dependency tests might also fail as well.
 
 ima_tpm.sh: test02, verifying the PCR-10 value, requires a hard reboot.
 [On Ubuntu, before running the ltp tests, disable /etc/init.d/kexec-load



------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
