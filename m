Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1NFbpe-0000rO-8S
	for ltp-list@lists.sourceforge.net; Tue, 01 Dec 2009 23:08:30 +0000
Received: from fmmailgate01.web.de ([217.72.192.221])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NFbpY-0000MM-1E
	for ltp-list@lists.sourceforge.net; Tue, 01 Dec 2009 23:08:30 +0000
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 9267213EE3622
	for <ltp-list@lists.sourceforge.net>;
	Wed,  2 Dec 2009 00:08:18 +0100 (CET)
Received: from [90.180.172.144] (helo=debian)
	by smtp07.web.de with asmtp (WEB.DE 4.110 #314) id 1NFbMv-0005V0-00
	for ltp-list@lists.sourceforge.net; Tue, 01 Dec 2009 23:38:50 +0100
Date: Tue, 01 Dec 2009 23:35:26 +0100
From: "Jiri Palecek" <jpalecek@web.de>
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.u396i80jcfnueu@debian>
Subject: [LTP] [PATCH] Remove the use of bash arrays from memcg_stress_test
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
Message-ID: <20091201223526.6MRi7yi9oWziIFJPDHUTTYSt_dxx48955tDo1LeAc1w@z>

Hello,

this patch removes the use of bash arrays from memcg_stress_test.sh, thus making the script more POSIX friendly. I changed the array into a series of variables, read and written using eval.

Regards
    Jiri Palecek

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 .../controllers/memcg/stress/memcg_stress_test.sh  |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
index 6c9cd75..7244a16 100755
--- a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
+++ b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
@@ -70,22 +70,22 @@ run_stress()
 	do
 		mkdir /dev/memcg/$i 2> /dev/null
 		./memcg_process_stress $2 $3 &
-		pid[$i]=$!
+		eval pid$i=$!
 
-		echo ${pid[$i]} > /dev/memcg/$i/tasks
+		eval echo \$pid$i > /dev/memcg/$i/tasks
 	done
 
 	for i in $(seq 0 $(($1-1)))
 	do
-		/bin/kill -s SIGUSR1 ${pid[$i]} 2> /dev/null
+		eval /bin/kill -s SIGUSR1 \$pid$i 2> /dev/null
 	done
 
 	sleep $4
 
 	for i in $(seq 0 $(($1-1)))
 	do
-		/bin/kill -s SIGINT ${pid[$i]} 2> /dev/null
-		wait ${pid[$i]}
+		eval /bin/kill -s SIGINT \$pid$i 2> /dev/null
+		eval wait \$pid$i
 
 		rmdir /dev/memcg/$i 2> /dev/null
 	done
-- 
1.6.4.3




------------------------------------------------------------------------------
Join us December 9, 2009 for the Red Hat Virtual Experience,
a free event focused on virtualization and cloud computing. 
Attend in-depth sessions from your desk. Your couch. Anywhere.
http://p.sf.net/sfu/redhat-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
