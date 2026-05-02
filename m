Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 980C9CD13DA
	for <ltp@archiver.kernel.org>; Sat,  2 May 2026 08:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777709731; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=PSfdWPORP/4S+tUMTjiOvfEyTEsoeerWrlFSqkVI+J4=;
 b=Lvf5cfCsuuDnDBt6nmJ45nLuyuJwNoBQmt2EiIHA6zN+BMnVx6d8lxZV16pKra5wrjzUR
 7KURSEkVVnkaCAgvi4EJtODBp2STbwQ79AepVSo2HgKjHKgj5gVberj63ZYJhxM49GUI8xH
 Phq/SrD8n+GL1yVCZluGEh/5wBmt6Tk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F14C3E24F5
	for <ltp@archiver.kernel.org>; Sat,  2 May 2026 10:15:31 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CFB753CECB5
 for <ltp@lists.linux.it>; Sat,  2 May 2026 10:15:07 +0200 (CEST)
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com
 [IPv6:2607:f8b0:4864:20::449])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3AAA86012B3
 for <ltp@lists.linux.it>; Sat,  2 May 2026 10:15:07 +0200 (CEST)
Received: by mail-pf1-x449.google.com with SMTP id
 d2e1a72fcca58-82f896eb6faso2832009b3a.3
 for <ltp@lists.linux.it>; Sat, 02 May 2026 01:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777709705; x=1778314505; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=X72uZw7lhsX+prQYnKj1oeF1Br5FZ5xlBuQfhk4UprI=;
 b=WF3GXO9RQpY5i58Jf6AiANtlAy/uWE+9tJTDkcxgeoQCCtqSfxSPmrUnxLMvfT23R4
 bb4zrto7kPXfbPQSJ8mr9SzD8TTZ1N4/586V6R27tH3x0BZwXERE7JWZ6a0WXlwQVDpB
 6gwUHPa568o8gFqniEEXE9bpTEnHbjgExJaETqvgVQgcioypFx8kJUibrv94JbjK+zHw
 isgnaALwD+TAnB/YG1ImBu1zHn1R5Pp1WB0/8UdlCMEAhBzaqvFUlm3Q3RKuFkmY/pVg
 ZOZpiSXh/ntSgLnZMo1XIFkArpcqPbJDX2kjfQ45ehHepyCuM/8kyOxiCPXaZ5cud3Ud
 IaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777709705; x=1778314505;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X72uZw7lhsX+prQYnKj1oeF1Br5FZ5xlBuQfhk4UprI=;
 b=GcWge+nFHSkEUMVo2icWNX6/a3PgQFITZwzTbaHP5xdQDtkNAl4YMdfwvUvup7JGqN
 Rv0/kDY1EQX+KXu9feh9tElOfpWroawul4cCiFst8QuscZHx2MtuAjt0EEf3TlWsxlc1
 im5FXAoNnFa3EZNGwJdRYi0ar64I9bys0L1EbW/y6Oj2Yl1Xg4XQJDBEysYqg+WLVfcW
 vnloS24zF+btMXD8xOKYff1CuvzA+AhM3SoVH1NHR9vPEZkt+HSt3ElxFZfw8/Izduv3
 nOrsr/kA/ylwqP4+s9/1kddX0J/EDEx0REFzOaped2G/Nr/9Fmpr6OzEj5FRE6IfUkq8
 MCvQ==
X-Gm-Message-State: AOJu0YxEb9fXrU1TH4BuyaJU5IubeW0mz75bNEfSGzJVgl8mRAQTYj8O
 5hLq+MrIpyrYmUxBRUST3TPKRBybPoOsdRGfO1c28iiaxLFaZ1fdVKjdlKoRT/ISUbbqwCGFY4r
 zWk84i5dV5OROWUMJpzHJAm+GkpPB4vOnQnVjYrI37+siQi0dSplDXKAIr/gEcW8KNfuHLiq3ni
 BGttA/NwMzg9XrNmf007tO52oxBv+FLn76HxSSw6V+CpHRAMg=
X-Received: from pfzz25.prod.google.com ([2002:a05:6a00:1f9:b0:835:38e9:3254])
 (user=chihsheng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3d44:b0:82a:79b8:2049 with SMTP id
 d2e1a72fcca58-8352d218aa1mr2591514b3a.25.1777709705023; 
 Sat, 02 May 2026 01:15:05 -0700 (PDT)
Date: Sat,  2 May 2026 08:14:46 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260502081446.10472-1-chihsheng@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] tst_virt: Add fallback KVM detection via virtio block
 devices
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
From: Darren Chang via ltp <ltp@lists.linux.it>
Reply-To: Darren Chang <chihsheng@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Currently, is_kvm() relies on reading /proc/cpuinfo to find the
"QEMU Virtual CPU" string.

This patch introduces a fallback mechanism to detect KVM environments
by checking for the existence of standard virtio block devices when the
CPU info check fails. Specifically, it probes for:
- /sys/block/vda (Reliable sysfs kernel interface)
- /dev/vda       (Standard Linux device node)
- /dev/block/vda (Android's ueventd device node)

Including "/dev/block/vda" ensures that the detection works seamlessly
within Android emulator environments (such as Cuttlefish),
which use ueventd and place block devices under /dev/block/ instead of
the standard Linux /dev/.

Signed-off-by: Darren Chang <chihsheng@google.com>
---
 lib/tst_virt.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/lib/tst_virt.c b/lib/tst_virt.c
index 109d7a853..ac0aef665 100644
--- a/lib/tst_virt.c
+++ b/lib/tst_virt.c
@@ -44,6 +44,19 @@ static int is_kvm(void)
 	}
 
 	SAFE_FCLOSE(NULL, cpuinfo);
+
+	/* * Fallback check for KVM:
+	 * Android's ueventd creates block devices in /dev/block/
+	 * instead of the standard Linux /dev/, so we check both.
+	 */
+	if (!found) {
+		if (access("/dev/vda", F_OK) == 0 ||
+			access("/sys/block/vda", F_OK) == 0 ||
+			access("/dev/block/vda", F_OK) == 0) {
+			found = 1;
+		}
+	}
+
 	return found;
 }
 
-- 
2.54.0.545.g6539524ca2-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
