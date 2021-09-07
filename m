Return-Path: <SRS0=JaEE=OF=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222AAC433F5
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 08:25:55 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C78561185
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 08:25:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7C78561185
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B63AF3C8999
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 10:25:51 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 414B13C231C
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 03:44:09 +0200 (CEST)
Received: from unicom146.biz-email.net (unicom146.biz-email.net
 [210.51.26.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 60097201026
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 03:44:05 +0200 (CEST)
Received: from ([60.208.111.195])
 by unicom146.biz-email.net ((LNX1044)) with ASMTP (SSL) id IAG00059
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 09:43:59 +0800
Received: from localhost.localdomain (10.200.104.119) by
 jtjnmail201603.home.langchao.com (10.100.2.3) with Microsoft SMTP Server id
 15.1.2308.14; Wed, 15 Sep 2021 09:44:00 +0800
From: songkai <songkai01@inspur.com>
To: <ltp@lists.linux.it>
Date: Tue, 7 Sep 2021 19:57:46 -0400
Message-ID: <20210907235746.112665-1-songkai01@inspur.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Originating-IP: [10.200.104.119]
tUid: 2021915094359bfdc9f88e381e67e47b2e42262fafab6
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 15 Sep 2021 10:25:42 +0200
Subject: [LTP] [PATCH] Fix the statistical number of results in the html
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: wangkaiyuan@inspur.com, songkai01@inspur.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210907235746.4szQDbZHaKfhou38Z3vyXtBtxsQgt0YLE7tl0zXPloE@z>

From: wangkaiyuan <wangkaiyuan@inspur.com>

According to the statistical method of ltp-pan on TFAIL TBROK TCONF
TPASS..., the statistical method of the ltp test result type in 
genhtml.pl is modified to ensure that the .log format of the ltp 
result is consistent with the test result in the .html format.

The original statistical method policy expression "/\ TFAIL\ /" in 
the original genhtml.pl for the test result type cannot match the 
"TFAIL:" in the normal test result, causing problems in the 
calculation result. At the same time, the statistical method in 
genhtml.pl cannot guarantee that each test item has only one test 
result, because the output of a test item may include TFAIL, TCONF,
and TPASS at the same time.

Signed-off-by: wangkaiyuan <wangkaiyuan@inspur.com> 
               Chunsing.dey <daichx@inspur.com>
---
 tools/genhtml.pl | 52 ++++++++++++++++++++----------------------------
 1 file changed, 22 insertions(+), 30 deletions(-)
 mode change 100644 => 100755 tools/genhtml.pl

diff --git a/tools/genhtml.pl b/tools/genhtml.pl
old mode 100644
new mode 100755
index 7e9bdd471..1f440b4fa
--- a/tools/genhtml.pl
+++ b/tools/genhtml.pl
@@ -50,6 +50,7 @@ my $retr_test_counter       = 0;
 my $retr_test_counter_flag  = 0;
 my $conf_test_counter       = 0;
 my $conf_test_counter_flag  = 0;
+my $test_passed = 0;
 
 my $detected_fail = 0;
 my $detected_pass = 0;
@@ -115,7 +116,7 @@ foreach my $file (@ARGV) {
 		if ($line =~ /$end_tag/) {
                         print "$row_line";
 			$process_line  = 0;
-                        $flag  = 0;             $flag2 = 0;            $flag3 = 0;            $flag4 = 0;
+                        $flag  = 0;             $flag2 = 0;            $flag3 = 0;            $flag4 = 0;            $flag5 = 0;
                         $detected_fail = 0;     $detected_pass = 0;    $detected_warn = 0;    $detected_brok = 0;    $detected_retr = 0;    $detected_conf = 0;
                         $background_colour = 0; $failed_test_counter_flag = 0; $brok_test_counter_flag = 0; $warn_test_counter_flag = 0; $retr_test_counter_flag = 0; $conf_test_counter_flag = 0;  $row_line= "";
 		}
@@ -175,39 +176,31 @@ foreach my $file (@ARGV) {
                              $flag2 = 0;
                              $flag3 = 1;
                              $flag4 = 1;
+			     $flag5 = 1;
                              $row_line = $row_line . "</strong></pre></td>";
                         }
-                        if ( $flag2 == 1 ) {
+			if ( $flag2 == 1 ) {
 			    $row_line = $row_line . "$line \n";
-			    if ($line =~ /\ TFAIL\ / ) {
-				$detected_fail = 1;
-				if ( $failed_test_counter_flag == 0 ) {
-				    $failed_test_counter++;
-				    $failed_test_counter_flag=1;
-				}
-			    } elsif ($line =~ /\ TBROK\ / ) {
-				$detected_brok = 1;
-				if ( $brok_test_counter_flag == 0 ) {
-				    $brok_test_counter++;
-				    $brok_test_counter_flag=1;
-				}
-			    } elsif ($line =~ /\ TWARN\ / ) {
-				$detected_warn = 1;
-				if ( $warn_test_counter_flag == 0 ) {
-				    $warn_test_counter++;
-				    $warn_test_counter_flag=1;
-				}
-			    } elsif ($line =~ /\ TCONF\ / ) {
-				$detected_conf = 1;
-				if ( $conf_test_counter_flag == 0 ) {
-				    $conf_test_counter++;
-				    $conf_test_counter_flag=1;
-				}
-                             } else {
+			}
+                        if ( $flag5 == 1 ) {
+                            if ($line =~  "termination_id=1" ) {
+                                $detected_fail = 1;
+                                $failed_test_counter++;
+                            } elsif ($line =~ "termination_id=2" ) {
+                                $detected_brok = 1;
+                                $brok_test_counter++;
+                            } elsif ($line =~ "termination_id=4" ) {
+                                $detected_warn = 1;
+                                $warn_test_counter++;
+                            } elsif ($line =~ "termination_id=32" ) {
+                                $detected_conf = 1;
+                                $conf_test_counter++;
+                            } elsif ($line =~ "termination_id=0" ) {
                                  $detected_pass = 1;
-                             }
+                                 $test_passed++;
+                            }
                         }
-                        if ( $line =~ /$output_tag/ ) {
+			if ( $line =~ /$output_tag/ ) {
                              $flag2 = 1;
                              $row_line = $row_line . "<td><pre><strong>";
                         }
@@ -233,7 +226,6 @@ print "<tr><td><strong>Output/Failed Result</strong></td><td><a href=\"file://$E
 print "<tr><td><strong>Total Tests</strong></td><td><strong>";
 $test_counter--;
 print "$test_counter                         </strong></td></tr>\n";
-$test_passed=$test_counter-$failed_test_counter-$brok_test_counter-$warn_test_counter-$retr_test_counter-$conf_test_counter;
 print "<tr><td><strong>Total Test TPASS:</strong></td><td><strong> $test_passed </strong></td></tr>\n";
 print "<tr><td><strong>Total Test TFAIL:</strong></td><td><strong> $failed_test_counter </strong></td></tr>\n";
 print "<tr><td><strong>Total Test TBROK</strong></td><td><strong> $brok_test_counter </strong></td></tr>\n";
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
