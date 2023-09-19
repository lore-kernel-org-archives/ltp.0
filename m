Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96DD9CD54AB
	for <ltp@archiver.kernel.org>; Tue, 19 Sep 2023 09:17:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 75D293CE468
	for <ltp@archiver.kernel.org>; Tue, 19 Sep 2023 11:17:54 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A9EBB3C9274
 for <ltp@lists.linux.it>; Tue, 19 Sep 2023 11:17:43 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9BA9C1BC3D28
 for <ltp@lists.linux.it>; Tue, 19 Sep 2023 11:17:42 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id E119B1FE09;
 Tue, 19 Sep 2023 09:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1695115061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zsDklWd3VkLiNPfez0D/ay3tIZO69R3qerQg6bdl1JM=;
 b=Izv8VcA0V2MNYPdzloMkIx7PmRLLiTNopaVbxGECxOLrIYUopQqb80dIDNUwcG/upzt6nZ
 WnSBtUIkHIEbaIXyzed4339PfrsmHn/dcalzOA0/Dy17OGvNCIgjWbxLTe7IRMNNGLmkH8
 44wZ5CvjLUxo1olG1WEJGdCmg5/YoRU=
Received: from g78.cable.virginm.net (rpalethorpe.tcp.ovpn1.nue.suse.de
 [10.163.17.14]) by relay2.suse.de (Postfix) with ESMTP id 87B4C2C142;
 Tue, 19 Sep 2023 09:17:41 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 19 Sep 2023 10:17:23 +0100
Message-ID: <20230919091723.9278-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PUSHED] zram01.sh: Workaround division by 0 on vfat on
 ppc64le
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
From: Richard Palethorpe via ltp <ltp@lists.linux.it>
Reply-To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Repeatedly read /sys/block/zram*/mm_stat for 1 sec. This should fix bug
on ppc64le on stable kernels, where mem_used_total is often 0.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Li Wang <liwang@redhat.com>
Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

[rpalethorpe: s/loop/check/ suggested by Li]
---

rpalethorpe:
        This may not fix the problem, but it can rule out a simple race
        condition.

 .../kernel/device-drivers/zram/zram01.sh      | 27 +++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/device-drivers/zram/zram01.sh b/testcases/kernel/device-drivers/zram/zram01.sh
index 58d233f91..6bc305f2c 100755
--- a/testcases/kernel/device-drivers/zram/zram01.sh
+++ b/testcases/kernel/device-drivers/zram/zram01.sh
@@ -105,6 +105,26 @@ zram_mount()
 	tst_res TPASS "mount of zram device(s) succeeded"
 }
 
+read_mem_used_total()
+{
+	echo $(awk '{print $3}' $1)
+}
+
+# Reads /sys/block/zram*/mm_stat until mem_used_total is not 0.
+check_read_mem_used_total()
+{
+	local file="$1"
+	local mem_used_total
+
+	tst_res TINFO "$file"
+	cat $file >&2
+
+	mem_used_total=$(read_mem_used_total $file)
+	[ "$mem_used_total" -eq 0 ] && return 1
+
+	return 0
+}
+
 zram_fill_fs()
 {
 	local mem_used_total
@@ -133,9 +153,12 @@ zram_fill_fs()
 			continue
 		fi
 
-		mem_used_total=`awk '{print $3}' "/sys/block/zram$i/mm_stat"`
+		TST_RETRY_FUNC "check_read_mem_used_total /sys/block/zram$i/mm_stat" 0
+		mem_used_total=$(read_mem_used_total /sys/block/zram$i/mm_stat)
+		tst_res TINFO "mem_used_total: $mem_used_total"
+
 		v=$((100 * 1024 * $b / $mem_used_total))
-		r=`echo "scale=2; $v / 100 " | bc`
+		r=$(echo "scale=2; $v / 100 " | bc)
 
 		if [ "$v" -lt 100 ]; then
 			tst_res TFAIL "compression ratio: $r:1"
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
