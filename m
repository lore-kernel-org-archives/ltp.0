Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED1DC43458
	for <ltp@archiver.kernel.org>; Fri, 26 Jun 2026 18:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782498033; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=8uY2ZuGb/ut59cfIPH72INM9PXcwk42ZyhR71cM1HN4=;
 b=IRo68m0ZlvaAxF/By9cY8KJkEFpgYdlGgeWRaVvd5gELD5xjflBmSKhkC6kdZC0r19eZA
 ReicL78yUttH70U4gl7D271rso+A2IQWRmJ6ZWBQsdw/Dbwc1Oo9/0/dw6l+7C/KHZTG5FS
 UK6Nk2Yh082guK9Hmf+cO2VbTQcJvD0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 783B83E5313
	for <ltp@archiver.kernel.org>; Fri, 26 Jun 2026 20:20:33 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BEF753CF3D9
 for <ltp@lists.linux.it>; Fri, 26 Jun 2026 20:20:12 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1831E100048A
 for <ltp@lists.linux.it>; Fri, 26 Jun 2026 20:20:11 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 58D064198C
 for <ltp@lists.linux.it>; Fri, 26 Jun 2026 18:20:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EACCC1F000E9;
 Fri, 26 Jun 2026 18:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782498009;
 bh=s0/EpPiYoIuceFvpuMqTK/MKqHXDIrhy6QfSK8SOr2M=;
 h=From:Date:Subject:To:Cc;
 b=Ygg9Y178nkjdB31JtQ02SNJQi1SpZx+XPrhDPZSiUT8KmM6Dy2iGmrs3LXUghvAtt
 ZpVsyn2h29DFnG+doPzeVosy3/uyWi/hBNJK8LjmZDcJ9WXpNAarU/TE/a2Atve2P4
 JPPYqCImKXsTO1tgIj6ayYGtr8535turaCRjLRJmVGTPox4QIVR2jegNxAvuEfQPAE
 JHKCZzdWQRkEsPWyOTiCYw/0tAQdbW9LPVpDZRq6iWcHqjurUR6K8qPL+ZudgQyH/t
 TGJXJyPfY8jDVKMRaPplzddQjS8nLiKn+Gtgm7Uws0MC3OsetJh3IXKKzCyUzdGf2e
 hX3FYWbPwtllA==
Date: Fri, 26 Jun 2026 14:20:01 -0400
MIME-Version: 1.0
Message-Id: <20260626-master-v2-1-d1365499b710@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XMQQ6CMBCF4auQWVtTRtqkrryHYQF0gInakikhG
 tK7W9m6/F9evh0SCVOCa7WD0MaJYyiBpwqGuQsTKfalATVabdGqV5dWEmWMR9e4pu+0hXJehEZ
 +H9C9LT1zWqN8Dnerf+sfsdWqVtSMQ+9Mjxf0twdJoOc5ygRtzvkLZKWPCJ0AAAA=
X-Change-ID: 20260626-master-55d29494ba06
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1943; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Qm5G1nAvu2Ls9fKARaKhuQKxshVHUgL3zr0ge7kjv2s=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqPsLURnC9cvM0p55EULT23IMlJ5yvbnELyspkM
 6NU0YmBg0uJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaj7C1AAKCRAADmhBGVaC
 FQ1MD/0f/b0/75ALY+C4ybqOmjfcXFc+JOuHzo0fanfGKNFsxb9JYBZowWsncuD93sVbnUlzM4C
 PE96bffUGHplk4KpZnBDun0h6woHJ+y1qm/eF7iG6rZyyceRI2xPb/0YyIb0PxO/oEaagMku//n
 JILZ35QKZsorU4CWZn45jZpNDQirU8wZF9oFlMDpenynx6OoO/3BfEY4zgyEto1CNyVpC31pJKW
 hzxIO9/CEiEMHJI1ggwK9C7Ox1YHNVJ0Yhi4CZXU5SyAfcF/vzt02FtFWK8ekRDJ3q0wP0ESHRQ
 hDALgAQwwDVYmH120C0NF8vRW5VI5hh3EmopUpAbbyV6gjL9i1PC5efzfygqPgGBsgwZtOFM7rJ
 6lsQLMak9deQZ2U7K9CXlOOPZjrTUKvlvVdtBJMCHcsyYzt1JR3bomjRL2ULRE4wKeTW4NLhhOW
 eC88OvQakHfbYHnBzE3lXPNqJlDov7xAd67BSdz1uQoSnTC8VeCOUqxJnMuQB0OEUqYsxDJqV5+
 fFkjKkMAM0fBZFlRDIha3D4oDYCtCSr78kVi0QX6c/rb9Jeib2uiwybgTu1Qaxopw74F6a0cBiS
 d2ddO0VWqxjlg/joAN4uwV1FfBuZ2HJkzKpYGNvRtjLuqeB05O7Lqc8afwpS8c+RsfBxBGU08yJ
 Bkxd6iz9qoIXGAA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] ioctl10: fix the sscanf() call to handle 64-bit
 inode on 32-bit arch
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
From: Jeff Layton via ltp <ltp@lists.linux.it>
Reply-To: Jeff Layton <jlayton@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This test started failing recently on arm32, when we switched the
kernel to displaying the full 64-bit inode number in the maps file.
Change the testcase to allow for a full 64-bit inode number on all
arches. The value it's compared to is already 64-bits, so widening
this field is all that is necessary.

Reported-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v2:
- Use SCNu64 instead of %llu in the sscanf() format string
- Link to v1: https://lore.kernel.org/r/20260626-master-v1-1-e4fcb95b232d@kernel.org
---
 testcases/kernel/syscalls/ioctl/ioctl10.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl10.c b/testcases/kernel/syscalls/ioctl/ioctl10.c
index b668c9e93889..8a4f8ae405e6 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl10.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl10.c
@@ -17,6 +17,7 @@
 
 #include "config.h"
 #include <stdlib.h>
+#include <inttypes.h>
 #include <sys/ioctl.h>
 #include <errno.h>
 #include <fnmatch.h>
@@ -35,7 +36,7 @@ struct map_entry {
 	unsigned long vm_pgoff;
 	unsigned int vm_major;
 	unsigned int vm_minor;
-	unsigned long vm_inode;
+	uint64_t vm_inode;
 	char vm_name[256];
 	unsigned int vm_flags;
 };
@@ -68,7 +69,7 @@ static void parse_maps_file(const char *filename, const char *keyword, struct ma
 
 	while (fgets(line, sizeof(line), fp) != NULL) {
 		if (fnmatch(keyword, line, 0) == 0) {
-			if (sscanf(line, "%lx-%lx %s %lx %x:%x %lu %s",
+			if (sscanf(line, "%lx-%lx %s %lx %x:%x %" SCNu64 " %s",
 						&entry->vm_start, &entry->vm_end, entry->vm_flags_str,
 						&entry->vm_pgoff, &entry->vm_major, &entry->vm_minor,
 						&entry->vm_inode, entry->vm_name) < 7)

---
base-commit: 534222c4f3908e9642f913399e37a66fdd266bbe
change-id: 20260626-master-55d29494ba06

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
