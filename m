Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 349A3C4332F
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 03:17:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D3C163CACF2
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 04:17:08 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B8B393C130F
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 04:16:56 +0100 (CET)
Received: from mailgw.kylinos.cn (unknown [124.126.103.232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id ED24B2002DF
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 04:16:49 +0100 (CET)
X-UUID: ab026bd4dd71430b931e496cee90a377-20221129
X-CPASD-INFO: a4bcdae236f64738a318e04ecc508429@qoScg5GTk2JfVqiCg3p-coFkYWiVXFS
 0pZ1VYGZkXlmVhH5xTV5nX1V9gnNXZF5dXFV3dnBQYmBhXVJ3i3-XblBgXoZgUZB3sHacg5SPlQ==
X-CLOUD-ID: a4bcdae236f64738a318e04ecc508429
X-CPASD-SUMMARY: SIP:-1, APTIP:-2.0, KEY:0.0, FROMBLOCK:1, OB:0.0, URL:-5,
 TVAL:190.
 0, ESV:0.0, ECOM:-5.0, ML:0.0, FD:0.0, CUTS:111.0, IP:-2.0, MAL:-5.0, PHF:-5.0,
 PHC:-5
 .0, SPF:4.0, EDMS:-5, IPLABEL:4480.0, FROMTO:0, AD:0, FFOB:0.0, CFOB:0.0, SPC:0,
 SIG:-
 5, AUF:43, DUF:9417, ACD:155, DCD:155, SL:0, EISP:0, AG:0, CFC:0.258,
 CFSR:0.091, UAT:0
 , RAF:0, IMG:-5.0, DFA:0, DTA:0, IBL:-2.0, ADI:-5, SBL:0, REDM:0, REIP:0, ESB:0,
 ATTNUM: 0,EAF:0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: ab026bd4dd71430b931e496cee90a377-20221129
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1
X-UUID: ab026bd4dd71430b931e496cee90a377-20221129
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain.localdomain [(112.64.161.44)] by mailgw
 (envelope-from <zenghongling@kylinos.cn>) (Generic MTA)
 with ESMTP id 1721779190; Tue, 29 Nov 2022 11:16:45 +0800
From: zenghongling <zenghongling@kylinos.cn>
To: ltp@lists.linux.it,
	zenghongling@kylinos.cn
Date: Tue, 29 Nov 2022 11:17:11 +0800
Message-Id: <1669691831-23456-1-git-send-email-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] mkfs: relax size check
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Number of total data blocks in filesystem reported by statfs
may be less than current formula of 90%. For example ext4 will
subtract "s_first_data_block plus internal journal blocks".

With recent change to e2fsprogs, overhead calculated in user-space
increased slightly and LTP test started failing:
  tytso/e2fsprogs

mkfs01 1 TPASS: 'mkfs -t ext4  /dev/loop0 ' passed.
mkfs01 2 TFAIL: 'mkfs -t ext4  /dev/loop0 16000' failed, not expected.

Since there's no strict rule how much the overhead will be,
as rule of thumb relax the condition to 70%.

Signed-off-by: zenghongling <zenghongling@kylinos.cn>
---
 testcases/commands/mkfs/mkfs01.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/commands/mkfs/mkfs01.sh b/testcases/commands/mkfs/mkfs01.sh
index 263aa47..a964774 100755
--- a/testcases/commands/mkfs/mkfs01.sh
+++ b/testcases/commands/mkfs/mkfs01.sh
@@ -66,11 +66,11 @@ mkfs_verify_size()
 	# 1k-block size should be devided by this argument for ntfs verification.
 	if [ "$1" = "ntfs" ]; then
 		local rate=1024/512
-		if [ $blocknum -lt "$(($2/$rate*8/10))" ]; then
+		if [ $blocknum -lt "$(($2/$rate*7/10))" ]; then
 			return 1
 		fi
 	else
-		if [ $blocknum -lt "$(($2*8/10))" ]; then
+		if [ $blocknum -lt "$(($2*7/10))" ]; then
 			return 1
 		fi
 	fi
-- 
2.1.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
