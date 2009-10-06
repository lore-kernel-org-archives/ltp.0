Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1Mv6ix-0003Dg-7j
	for ltp-list@lists.sourceforge.net; Tue, 06 Oct 2009 09:52:51 +0000
Received: from fmmailgate02.web.de ([217.72.192.227])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mv6iq-0000HX-Q9
	for ltp-list@lists.sourceforge.net; Tue, 06 Oct 2009 09:52:49 +0000
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id 242CB129FD71F
	for <ltp-list@lists.sourceforge.net>;
	Tue,  6 Oct 2009 11:49:00 +0200 (CEST)
Received: from [83.208.36.163] (helo=debian)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #314) id 1Mv6fD-00048k-00
	for ltp-list@lists.sourceforge.net; Tue, 06 Oct 2009 11:49:00 +0200
Date: Tue, 06 Oct 2009 11:50:02 +0200
From: =?iso-8859-2?B?Smn47SBQYWxl6GVr?= <jpalecek@web.de>
Message-ID: <op.u1dhh1gru2flwt@debian>
MIME-Version: 1.0
Subject: [LTP] [RFC] uClinux vs. Crackerjack tests
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
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hello,

the recently introduced tests from Crackerjack use some subroutines that
use fork(). However, according to the documentation, fork is not available
on uClinux, and LTP seems to support this. Although I haven't noticed any
complaints to the functionality of the tests on uClinux, I wonder whether
they actually work.

I wonder whether simple functions executed in the child process couldn't
be replaced by some shell code, like this, to make them work on uClinux:

diff --git a/testcases/kernel/syscalls/utils/common_j_h.c
b/testcases/kernel/syscalls/utils/common_j_h.c
index c460d85..8e7dbf8 100644
--- a/testcases/kernel/syscalls/utils/common_j_h.c
+++ b/testcases/kernel/syscalls/utils/common_j_h.c
@@ -117,15 +117,25 @@ static void sigterm_handler(int sig)
    */
   pid_t create_sig_proc(unsigned long usec, int sig, unsigned count)
   {
-       pid_t pid, cpid;
+       pid_t pid = getpid(), cpid;
+#ifdef UCLINUX
+       char buffer[256];
+
+       snprintf(buffer, 256, "COUNT=%d TIME=%ld SIG=%d; while [
$(COUNT-=1) -gt 0 ]; do sleep $TIME; kill -$SIG $PPID; done",
+                                        count, (usec+999999)/1000000,
sig);
+       if((cpid = vfork()) == 0) {
+               execlp("sh", "-c", buffer, (void*)0);
+               _exit(1);
+       }

-       pid = getpid();
+#else
          WITH_SIGNALS_BLOCKED(
                          if((cpid = fork()) == 0) {
                                  tst_sig(NOFORK, SIG_DFL, NULL);
                                  signal(SIGTERM, sigterm_handler);
                          }
          );
+#endif
          switch (cpid) {
          case 0:
                  while(count-- > 0) {

It isn't an exact replacement (the sleep interval granularity is 1 second
in the shell version), but this parameter isn't crucial for the function
of the tests that use it. It would save us an extra binary or altering all
the tests that use this function.

Regards
      Jiri Palecek

-- 
Using Opera's revolutionary e-mail client: http://www.opera.com/mail/

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
