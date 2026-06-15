Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C95E4CD98C7
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 11:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781522061; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=9jhbS1p407fpKQdrexOWI4LziySrrYjkTZ1oyKOhzSU=;
 b=QDKKAaf8AsXLTZ4xjO06nRea3+XszqbhO3T3GplrvT8wia/jXnbTVCD2NeQ3C6WbPDKFb
 CuulZlPZk5SNwsxFdfnFhWsq0P3qj1J5wXsR+/yEgRyl6PfsD6k5jRP5avS6URCCjqkEj5N
 7082IGeqPet+PuPTeDusHBUBBF8+viw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3850E3E5C13
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 13:14:21 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D72C93C5AED
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 13:14:00 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5071C200908
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 13:14:00 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-490ace40f4bso30520915e9.3
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 04:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781522040; x=1782126840; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Iz791bxzKWhAPHgnzthkWYTUv7OWMKODOicruYjR4Zo=;
 b=ZNldtPr9v6KH8dHyD9rWY8Go0k4HXtfb15Hp6BKKEDTCbwxR3aHEN3q4I4LT42Y7kM
 cJEFgq5msBA4GCaMYb6+EiCDrQAoQWp7cx0RRStb8RYHptx5exZi0PuRrvjatCBbWzF6
 9/WWxLicD+RUSj8sLfaiGjSgmRPkwsVRIO4lJ+076Vi58dAuhfFvquyyutEvh29y5N/8
 +mjKJvZBzsLjOGVrYYmVVM9LHPqi/SMBpjvdTr+DXG4ueTZPnxwW2E3uFsfR7NgLutb+
 RuJC9AUrEbfx0d3nzE/LFjBBJndhvR/kS/r5pXDSe7PKWcSyh+FsJpuN/A+2cAVzDXyj
 gcMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781522040; x=1782126840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Iz791bxzKWhAPHgnzthkWYTUv7OWMKODOicruYjR4Zo=;
 b=bj6DM40xObGdoaBX3hbnHmsv9mabTIxVLFyPLqcjuHSF6SBdpPOzvmZ7sUBzVKJ7dA
 7LakWG5nw0up9C6NStV+LB7qa2sZyIiiJtuJ9BuOM5WofgfbZx+fPh8XbHCDR43nk/0z
 9kRjBnw90S4FPSraLFvsZCvl23tvrH6DtOf2k78rVqXZONtD9+IWBqX6etIVOXmKp+zu
 FFKawX/uiJNNjeUOvYmlIglOgWbuy/Urh0Ld9LPK7VMafkwLb22ymbweG0Rfii8xmKKn
 bknDITP46u1YsA6WT/z8BBPBqffRz99qHCCzc/nYAMY3SJPFkeZECYHz1nHT+IbX9SO6
 7tSQ==
X-Gm-Message-State: AOJu0YxIYcBEKBuKKf4HMsxVKF7Kd7Rmn9+wwGPtKncSum9eR8VKKHan
 k0p+RbMxGDNWbSRoJtK9LpOYm/J035a0KKyZ0ifceuzzHe3cTTz1QOF4GFEnn1KD1li+rpsA2ab
 t6FE6R9s=
X-Gm-Gg: Acq92OEHYhSd9vOY851vGpnr6uCJmsVVvss35h04dB8lvuep1ZMvVllbqBZI5jAjZo7
 GvP5zyoFQJ7XVXOikLhxqoN9a/ZRVvHtRcSV+IrK1IVIpBbY6iUOBuq9Iz3JC/r6vPHErSvj20D
 D9yswhldHOd9REEdRw0BSwmBT9feoAbLlQxznQ7bVAlYOgiU4HsXS5krMvR8yVQAJAn3/J/LKIE
 z+iwGWcmWlx3hNXCK9o4mbHkfDHP4CmvZtXKPhS8RzITHLN7BIHJWGIvXseRSRUeYFQ9PcuRbIV
 53IbNh6FMJXYHBXUbP/EVXBM05U8Bc8yChh47YcHqBhYUihp8f0ymtSZKdciXxF8+pFDtVe4Fn6
 uLhmaS7mZW1BwDaKGGj4Lhczd8yV3ydMJjJYR740sxOe5Dl75ejRjD0LayGmfI60zLd57z5ZMhw
 YxFiOpLpDeCw==
X-Received: by 2002:a05:600c:8b16:b0:490:ab8b:1bb3 with SMTP id
 5b1f17b1804b1-492200db664mr130383155e9.18.1781522039574; 
 Mon, 15 Jun 2026 04:13:59 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492202e5cbasm222700115e9.2.2026.06.15.04.13.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 04:13:59 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 15 Jun 2026 13:13:57 +0200
Message-ID: <20260615111358.73462-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612190750.3946-1-linuxtestproject.agent@gmail.com>
References: <20260612190750.3946-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] tst_security.sh: Use enforce toggle to trigger
 SELinux measurement
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
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Upstream kernel commit
644132a48f4e ("selinux: prune /sys/fs/selinux/checkreqprot") [0]
removed the selinux_ima_measure_state() call from the checkreqprot
write handler.
This broke tst_update_selinux_state() which relied on writing to
checkreqprot to trigger IMA measurements of SELinux state.

Switch to toggling the enforce value instead, which still triggers
selinux_ima_measure_state() on all kernel versions >= 5.12.

[0] https://github.com/torvalds/linux/commit/644132a48f4e28a1d949d162160869286f3e75de
Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 testcases/lib/tst_security.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/testcases/lib/tst_security.sh b/testcases/lib/tst_security.sh
index 820736c72..8c23bc5a0 100644
--- a/testcases/lib/tst_security.sh
+++ b/testcases/lib/tst_security.sh
@@ -142,10 +142,13 @@ tst_get_enforce()
 
 tst_update_selinux_state()
 {
-	local val
+	local val orig_val
 	local dir=$(tst_get_selinux_dir)
 	[ -n "$dir" ] || return 1
 
-	val=$(cat $dir/checkreqprot)
-	echo $val > $dir/checkreqprot
+	# Toggle enforce to trigger SELinux state measurement
+	orig_val=$(cat $dir/enforce)
+	val=$((1 - orig_val))
+	echo $val > $dir/enforce
+	echo $orig_val > $dir/enforce
 }
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
