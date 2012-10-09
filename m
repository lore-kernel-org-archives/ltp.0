Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liuhangbin@gmail.com>) id 1TLb7D-0005sK-CR
	for ltp-list@lists.sourceforge.net; Tue, 09 Oct 2012 14:48:59 +0000
Received: from mail-pa0-f47.google.com ([209.85.220.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1TLb79-0002cH-NQ
	for ltp-list@lists.sourceforge.net; Tue, 09 Oct 2012 14:48:59 +0000
Received: by mail-pa0-f47.google.com with SMTP id fa11so5307157pad.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 09 Oct 2012 07:48:49 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Tue,  9 Oct 2012 22:48:36 +0800
Message-Id: <1349794116-5016-1-git-send-email-liuhangbin@gmail.com>
Subject: [LTP] [PATCH] testscripts: add appl test in networkstress.sh
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

We have network_stress.appl in runtest dir. But we didn't include this test in
networkstress.sh. Add a new parameter to support appl test.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 testscripts/networkstress.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/testscripts/networkstress.sh b/testscripts/networkstress.sh
index e04a143..68673f4 100755
--- a/testscripts/networkstress.sh
+++ b/testscripts/networkstress.sh
@@ -59,6 +59,7 @@ usage () {
     echo "---------------------------------------------------------"
     echo -e "\033[31m $0 [options] \033[0m "
     echo "---------------------------------------------------------"
+    echo " -A|a: Stress test for appl"
     echo " -E|e: Stress test for interface"
     echo " -I|i: Stress test for ICMP protocol"
     echo " -T|t: Stress test for TCP/IP"
@@ -76,9 +77,10 @@ usage () {
     exit 1
 }
 
-while getopts EeTtIiUuRrMmSsWwBbVvN:n:D:d: OPTION
+while getopts AaEeTtIiUuRrMmSsWwBbVvN:n:D:d: OPTION
 do
     case $OPTION in
+	A|a) TEST_CASE="network_stress.appl";;
 	E|e) TEST_CASE="network_stress.interface";;
 	B|b) TEST_CASE="network_stress.broken_ip";;
 	I|i) TEST_CASE="network_stress.icmp";;
-- 
1.7.7.6


------------------------------------------------------------------------------
Don't let slow site performance ruin your business. Deploy New Relic APM
Deploy New Relic app performance management and know exactly
what is happening inside your Ruby, Python, PHP, Java, and .NET app
Try New Relic at no cost today and get our sweet Data Nerd shirt too!
http://p.sf.net/sfu/newrelic-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
