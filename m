Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D63D0E9A02C
	for <ltp@archiver.kernel.org>; Mon, 23 Feb 2026 10:56:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 50B093D0EF9
	for <ltp@archiver.kernel.org>; Mon, 23 Feb 2026 11:56:22 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC1F93C2746
 for <ltp@lists.linux.it>; Mon, 23 Feb 2026 11:56:04 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3B0436002AC
 for <ltp@lists.linux.it>; Mon, 23 Feb 2026 11:56:04 +0100 (CET)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4836f4cbe0bso31233995e9.3
 for <ltp@lists.linux.it>; Mon, 23 Feb 2026 02:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771844163; x=1772448963; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MV6Jm6v8R4oDOkfOdkVl5O91nP8olqpsyJrq9T3M/Ao=;
 b=ThhVkfm/0r5dmiZTdaBxe21SAOT+VlMvrtnHHnjW3nNQHPFqVOgCxGYW4ZaqDLlpex
 rjV8DGzVpe29ppZK2X5c3qniQXGFMAklvlIZkg4fy7Obb+VxU98iM9Chj6AAxZV/FZSP
 Bb3A802wNwP0UZdU1f6OIJ0yUxx4PFsRJGPh9rUTPA+NFYz9ym966nhwsA52EsXQwC5H
 UeIFACVW9rfaqiDph9/zv7d04lHpqDJ9tR8sr4qin4/jV4Wntt12/d14+s4VWsOpBTB1
 FDAkGyHuqg2zgXdq68gCi/SQAnYgh+1L1bWuIPPonwS1KS0oKyUof64FhEnOwrsz0NLO
 csXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771844163; x=1772448963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MV6Jm6v8R4oDOkfOdkVl5O91nP8olqpsyJrq9T3M/Ao=;
 b=eOZhKlvOxhoZPlbD/y2UKh+iIxHST6RVQXJokBoLTBJbTVOXXVPCSYO/mowoJQoqH0
 dPNEoNAkNFN8t8YEofDlJGZAhqxnVWkO6Q6toNO7dxoTF9Ms3ieQpgacfrbXxp267nVw
 /55Ka2/Tl6N88M91zdTSxn3X6CMfX/YgzA1KJ9KjTCYZfubnKoN9FeJeu1hccHbbLUNG
 z1t46GNlsVoX3p+zchTJu4zyQHsMrE/GLQ6h2KLfJVh/0nk9ryo7uwuZqcF6s7gLxtUs
 8t6ilWbxB78amBUtXaVFLRJ8p2o3HWJDX0GXfIsofLUJJ0KekqdV6Dqs/eFiFj7+juxF
 6z9A==
X-Gm-Message-State: AOJu0YyPhYgsvYQtYNcQFVidBqP3siqWMN0FrKMlGM8Z2+XljdNBUZiJ
 MbO13GBtfl/8Rb4pZznFoof+h9WacT9OhSrTj015v9SHQwgC7/0PzizQ9auBHw==
X-Gm-Gg: AZuq6aKqXu6ot8zooTtYv/WsmMmZRDYuilLvRV0SLC++uym52XwVZydk6N3XBO8Z7M7
 tWlgMKorKWVugeqLcCfQxVVDLH2etXBEYcuRje7lrCqy2IQ9zvNsVoROJWJtcg3ISMqNVTHJC/f
 YuP9bw26l/JySZ4+5ZcPYvl2Z9Zy4HKHjNC2kwHO0i7+uF4tsdY9awkh80JZdfzZAaWAiZQiHti
 gCFESFVaIiNZjx1wnYdJqjlOLTOzk/ZP/pqMpHXG8gs/4VFIolakNmJilVupZE+ZaP8VSCQezi5
 tu0UU1u0fiY6Fzb2azHf/wqoxWwQxOOMs4qEkfcCfbpcAST6n5eCcKPDJDCPsGWADaa1kPVnQoX
 fyocWzCgxPXmeIPPlCx0oCumsqsCE/sOkxTAro4pcQUAxOexnf4/Te1YrEJg3/vC8pi0o7oSVTF
 vv7LcBg/AXic/XMgj5JFsCbuf9BuZdalUoRZ3faeSzrEuem7F8qAI5yFoubSCB2GhqCL4=
X-Received: by 2002:a05:600c:4749:b0:480:69b6:dfed with SMTP id
 5b1f17b1804b1-483a95e5ab8mr138837735e9.24.1771844163327; 
 Mon, 23 Feb 2026 02:56:03 -0800 (PST)
Received: from localhost.suse.org ([37.109.160.5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a3dd3391sm166241515e9.1.2026.02.23.02.56.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 02:56:02 -0800 (PST)
From: Sebastian Chlad <sebastianchlad@gmail.com>
X-Google-Original-From: Sebastian Chlad <sebastian.chlad@suse.com>
To: ltp@lists.linux.it
Date: Mon, 23 Feb 2026 11:55:56 +0100
Message-ID: <20260223105556.31129-1-sebastian.chlad@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CAJCsO8eTiS5Z1Upon-gUj6R9f=TW3BJaRqmDwdxEwSMyvnwB1A@mail.gmail.com>
References: <CAJCsO8eTiS5Z1Upon-gUj6R9f=TW3BJaRqmDwdxEwSMyvnwB1A@mail.gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] nfs: Adapt the lib to allow to test in 2-host mode
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
Cc: Sebastian Chlad <sebastian.chlad@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

nfs_lib.sh checked key server_side prerequisites on the system under test.
In 2_host setup this incorrectly required server_side tools on lhost.

Switch exportfs and rpc.mountd/rpc.statd checks in nfs_setup() to
tst_rhost_run(). This aligns netns and 2-host handling in one path and
keeps 2-host checks on rhost.

Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
---
 testcases/network/nfs/nfs_stress/nfs_lib.sh | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
index 1ac8bd657..8bff3f23a 100644
--- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
+++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
@@ -45,7 +45,7 @@ TST_SKIP_FILESYSTEMS="exfat,ext2,ext3,fuse,ntfs,vfat,tmpfs"
 TST_MOUNT_DEVICE=1
 TST_FORMAT_DEVICE=1
 TST_NEEDS_ROOT=1
-TST_NEEDS_CMDS="$TST_NEEDS_CMDS mount exportfs mount.nfs"
+TST_NEEDS_CMDS="$TST_NEEDS_CMDS mount mount.nfs"
 TST_SETUP="${TST_SETUP:-nfs_setup}"
 TST_CLEANUP="${TST_CLEANUP:-nfs_cleanup}"
 TST_NEEDS_DRIVERS="nfsd"
@@ -186,9 +186,13 @@ nfs_setup()
 		tst_brk TCONF "Cannot run nfs-stress test on mounted NFS"
 	fi
 
-	if tst_cmd_available pgrep; then
+	tst_rhost_run -c "command -v exportfs >/dev/null" ||
+		tst_brk TCONF "'exportfs' not found on rhost"
+
+	if tst_rhost_run -c "command -v pgrep >/dev/null"; then
+		tst_res TINFO "checking rpc.mountd/rpc.statd on rhost"
 		for i in rpc.mountd rpc.statd; do
-			pgrep $i > /dev/null || tst_brk TCONF "$i not running"
+			tst_rhost_run -c "pgrep $i > /dev/null" || tst_brk TCONF "$i not running on rhost"
 		done
 	fi
 
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
