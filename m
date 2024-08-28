Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80AF4C5472D
	for <ltp@archiver.kernel.org>; Wed, 28 Aug 2024 06:45:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9DEBC3D2779
	for <ltp@archiver.kernel.org>; Wed, 28 Aug 2024 08:45:51 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3FA3C3D273C
 for <ltp@lists.linux.it>; Wed, 28 Aug 2024 08:45:35 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=free.fr
 (client-ip=2a01:e0c:1:1599::10; helo=smtp1-g21.free.fr;
 envelope-from=rpeuvergne@free.fr; receiver=lists.linux.it)
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 471EB208FA4
 for <ltp@lists.linux.it>; Wed, 28 Aug 2024 08:45:34 +0200 (CEST)
Received: from pof-builder.fr (unknown [31.32.198.145])
 (Authenticated sender: rpeuvergne@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id A4DE0B0037C;
 Wed, 28 Aug 2024 08:45:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1724827532;
 bh=0UV4b6ovxdqGUFhLV6Leq+2l5UcApxXTWkrTiKhOwt8=;
 h=From:To:Cc:Subject:Date:From;
 b=oBEy1CRY0xLjcs3KP13kdIs9aH8VHnzCfjrPehnmXEimusftzSaekRvtYKMeeSO84
 UI4AQDKdJcBCt1LklEqtGh2rdLwhaiKkE0Xy6eA1+vD9o5VK3VQdr3IFU+lX0/Em7c
 9aWRIZa+T7NTJYRR5zUeBwEFTZuoIcqAReQKOTvpiSKfe05GoCAXOIeFJ4t3CU1qie
 q8rjt92rJCm4rcordb4p8eLNwClr5D2UL1LOBvnbXtphoY+1TUFBCuRn6pthdITxzC
 x7zGid40wQaALj6Jw62Es81J3jA6tTq6FuQasBWa610H0jMB164qylhQIsDPxAc40T
 B8Fk4ndp4fYfg==
From: Remi Peuvergne <rpeuvergne@free.fr>
To: ltp@lists.linux.it
Date: Wed, 28 Aug 2024 08:45:26 +0200
Message-Id: <20240828064526.235050-1-rpeuvergne@free.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] HTML report: Fix row coloring depending on test status
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
Cc: Remi Peuvergne <remi.peuvergne@kaizen-solutions.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Remi Peuvergne <remi.peuvergne@kaizen-solutions.net>

The "state machine" was broken and the overall test status was
obtained *after* if was used (in the get_background_colour_column
function).
Fix this with a change for flag4, which now increases only when
we know test status.

Signed-off-by: Remi Peuvergne <remi.peuvergne@kaizen-solutions.net>
---
 tools/genhtml.pl | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/genhtml.pl b/tools/genhtml.pl
index d8f52663b..5a9256500 100644
--- a/tools/genhtml.pl
+++ b/tools/genhtml.pl
@@ -162,6 +162,7 @@ foreach my $file (@ARGV) {
                                               "<td><p><strong>$termination_id_value[1]</strong></p></td>\n"  .
                                               "<td><p><strong>$corefile_value[1]</strong></p></td>\n";
                                   $row_line =~ s/<tr>/<tr\ bgcolor=$background_colour>/;
+                                  $flag4++;
                              }
                              if ( $flag4 == 3 ) {
                                   @variable_value_pair    = split(/\ /, $line);
@@ -170,7 +171,6 @@ foreach my $file (@ARGV) {
                                   $row_line = $row_line . "<td><p><strong>$cutime_value[1]</strong></p></td>\n" .
                                               "<td><p><strong>$cstime_value[1]</strong></p></td></tr>\n";
                              }
-                             $flag4++;
                         }
                         if ( $line =~ /$execution_tag/ ) {
                              $flag2 = 0;
@@ -186,18 +186,23 @@ foreach my $file (@ARGV) {
 			 	 if ($line =~ "termination_id=1" ) {
 					 $detected_fail = 1;
 					 $failed_test_counter++;
+					 $flag4 = 2;
 				 } elsif ($line =~ "termination_id=2" ) {
 					 $detected_brok = 1;
 					 $brok_test_counter++;
+					 $flag4 = 2;
 				 } elsif ($line =~ "termination_id=4" ) {
 					 $detected_warn = 1;
 					 $warn_test_counter++;
+					 $flag4 = 2;
 				 } elsif ($line =~ "termination_id=32" ) {
 					 $detected_conf = 1;
 					 $conf_test_counter++;
+					 $flag4 = 2;
 				 } elsif ($line =~ "termination_id=0" ) {
 					 $detected_pass = 1;
 					 $test_passed++;
+					 $flag4 = 2;
 				 }
 			 }
                         if ( $line =~ /$output_tag/ ) {
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
