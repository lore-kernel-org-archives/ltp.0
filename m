Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1MJH8W-0000dG-Pz
	for ltp-list@lists.sourceforge.net; Wed, 24 Jun 2009 01:18:52 +0000
Received: from fmmailgate02.web.de ([217.72.192.227])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MJH8U-0000Tz-EA
	for ltp-list@lists.sourceforge.net; Wed, 24 Jun 2009 01:18:52 +0000
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id 08E97104AAFB6
	for <ltp-list@lists.sourceforge.net>;
	Wed, 24 Jun 2009 02:17:24 +0200 (CEST)
Received: from [83.208.36.163] (helo=debian)
	by smtp06.web.de with asmtp (WEB.DE 4.110 #277) id 1MJGB1-0006Mp-00
	for ltp-list@lists.sourceforge.net; Wed, 24 Jun 2009 02:17:23 +0200
Date: Wed, 10 Jun 2009 13:05:17 +0200
From: "Jiri Palecek >" <"<jirka"@suse.de>(none)
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.uvz5wwoglwynca@debian>
Subject: [LTP] [PATCH] Use custom prompt in the telnet test,
 to avoid timeouts in case the user's prompt doesn't contain hostname
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
Sender: ltp-list-bounces@lists.sourceforge.net
Errors-To: ltp-list-bounces@lists.sourceforge.net
Cc: ltp-list@lists.sourceforge.net
Message-ID: <20090610110517.n1rPa2w9UEQVni7QsE9hhB4nWM_t9R1ERpjNNU_LTvc@z>

Hello,

this patch makes the telnet test avoid timeouts when the remote users prompt doesn't contain hostname, or is somehow irregular. It works by explicitly setting the prompt in the remote shell (see the PROMPT variable). Note that setting literal value as a prompt works even when the remote shell is not bash (the classic bash placeholders do not).

Regards
    Jiri Palecek

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 testcases/network/tcp_cmds/telnet/telnet01 |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/testcases/network/tcp_cmds/telnet/telnet01 b/testcases/network/tcp_cmds/telnet/telnet01
index a4b37d3..24cfd11 100755
--- a/testcases/network/tcp_cmds/telnet/telnet01
+++ b/testcases/network/tcp_cmds/telnet/telnet01
@@ -41,6 +41,7 @@ set TC telnet
 set TCtmp "/tmp"
 set SLEEPTIME 3
 set TESTLOG "$TCtmp"
+set PROMPT "Alpha Bravo"
 
 if [info exists env(RUSER)] {
    set RUSER $env(RUSER)
@@ -83,20 +84,21 @@ while {$count < $LOOPCOUNT} {
       # telnet to the host
       spawn telnet $HOST
       expect -re "login:"
-      sleep 1
+
       send "$RUSER\r"
       expect -re "Password:"
-      sleep 1
+
       send "$PASSWD\r"
 
+      send "PS1=\"$PROMPT\"\r"
       # Wait for shell prompt
-      expect -re "$RUSER@" 
+      expect "$PROMPT" 
 
       # Run passwd command - and respond to its prompts
       send "LC_ALL=C ls -l /etc/hosts | wc -w > $TESTLOG/$RUSER.$HOST \r" 
       # When shell prompt comes back, logout
 
-      expect -re "$RUSER@"
+      expect "$PROMPT"
       exp_send "logout\r"
 
       send_user "CHECKING TELNET STATUS\n"
-- 
1.6.3.1




------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
