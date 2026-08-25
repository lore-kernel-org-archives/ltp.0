Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF75C5DF9C
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 02:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787624990; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=i70qFCt7bEWxEE8uIV2r3XFxH0NKwWP2vr1CF3qXjqY=;
 b=YIn21hf6xr6W9xr4sPwD2TN1tNwTlNApmQF4+XMM2ySPX/1U1B5wVagLkgww6bB/89FQH
 ZRw4C7pC2w4vrg/3W43Q7fdVHP84hJ/SiVxhjJXW4ZcAo3f2qHZqP2Iuyvlxf5zjGiWe7J9
 Yg5Y6NUQVpn9qwZloe/wHC66wuMyTk0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 266C63C2C93
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 04:29:50 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F5E03C93DF
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 04:29:30 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7DE81600834
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 04:29:29 +0200 (CEST)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c15cd3fd760so510127766b.2
 for <ltp@lists.linux.it>; Mon, 24 Aug 2026 19:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787624969; x=1788229769; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VSnz4L+40w4IG0ugJr7f8H14pLxHOdj6KuhbLlPbpWU=;
 b=ILwGeIyuDpbAUIJpiBk4CsuUYhbQZYcDZ4Rb6U1RNmhD9WMjrFG58nxQCVXeMLxIQQ
 CrGrXPk+nKYx1aCsAGgJD7vOFl3J5FHrk0KgxcwFPPYtonzYY+vM4uW9fohqmwYZEacr
 am3NMwDT1g/I8KmqzVPRtRgFoVV4Z83Zqu59XryyG565s+ruk8uYvR4f07aQmA4zGWiM
 j8qxEeMiTk9NeYattmEoA7E9kUUnMcH/k9ZLHIsxrNz5ykmWQoOJm+rM547281GeYf3/
 SnYWQy+Ih6SaXJr0CGGtSP6CbLyEBNEP0fBnCfCFg+KKxzeotm5EfKjbr/RSV/NhVxB5
 CNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787624969; x=1788229769;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VSnz4L+40w4IG0ugJr7f8H14pLxHOdj6KuhbLlPbpWU=;
 b=YxmmwqwLURqI5Lm1SuXzfN7alHhpERza4wwEzsjCNU8thP9PgsFFhWVCn/w0J+g9We
 6NoZTd1spll+sjyE+lzJNDzT2sj6fD1Sl7HNV9YN9bmOPUI5lbqeUJ1Np7q7m2Pc4U+7
 5uAX0kFdIHEulAoCL8xOCFZ96LiWKOHk3YTDpqf7Dca1aOfvkfk7S0mjIvKxZDvCX3q2
 BMGxmnKOADNMyFEGnYLye5ULWUIuow92BucIDgEv36Lxk3c1MwivKCyhrCVLhddrXU/t
 RQ/N3MYEm98bVCAKxpxeYeG6H8aTBIx6aMxK/RBL7PXY51t7McG89f8A4rOxuxlqBY5c
 L9zA==
X-Gm-Message-State: AFuF++ljkqDksfM8jxpxWS4hGNIOUsLXDtoeHEPILdkUOKTr0QSYKKfA
 9OYS1pNJS6hvgeEZ3BxH4+oVJTotSbFEy02oWHngkoiwWXahIShxsxo3+uml3Xbfz/yBD9/YPK8
 Ukgo=
X-Gm-Gg: AR+sD10JkPRBzrikPiDyWIDTE3NJE7XQP4hDANBnCMqjKsRxg7F9jRC6smm5z6+4p4K
 gscnytlh6/kqasQSM5xx+6ZaVFCfzFhVOo7vJCcVGXJeytKbDfbmAjY6B513pH5mWVbQxe/JSNY
 /YS5L7+FKzRsNucqD0TDxMvS2pVpMa8RshuEwFGIWSA8KESR4rdnu/zVL44Eo/f/Px4QunZ4med
 but0mMXj5CXn7adLMa+0+eHNKq9EPCcWcGaEV6RW2jZNFilzlvWJrkw3a3oiAi1Ep3B6Cz+OQgv
 hCa8vmbdYDTLDsM7m9ZoH1ffvSu2cihosGXlxFo/tCGUiMnurbqVoEQbJmFJG18UkGP+cSvOl8W
 vaAMzfoWpm3FGYYylVxEWZmR5uPYDumpx8svkVcTL8vCKuFBEAL2OBxWDmKQ3TI7NEGPcSWR7aj
 XV3eDR4I0p3SVQ08GbCIKjU8A4i1N1oDBhS10xr2Ui+dThJlt9sKllQsJKoaD0DcgyPKNlNjLfv
 Mf3ct3IvPyOIgYUnyL0YT80zOgX5vuW
X-Received: by 2002:a17:906:7311:b0:c24:8af3:c92 with SMTP id
 a640c23a62f3a-c249257bc04mr2438184066b.3.1787624968948; 
 Mon, 24 Aug 2026 19:29:28 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-c2496738e7esm1698168966b.46.2026.08.24.19.29.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 19:29:28 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 25 Aug 2026 02:13:06 +0000
Message-ID: <20260825022926.9649-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] mmapstress06: Rate limit page-dirtying loop to
 prevent MemCG OOM-kills
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reduce the throttling interval from 2 MB to 64 KB (usleep for 200us
every 64 KB) in the page-dirtying loop. This smooths out allocation
spikes and gives asynchronous swap writeback time to catch up under
slower VM storage environments, avoiding unexpected MemCG OOM-kills.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/mem/mmapstress/mmapstress06.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/mem/mmapstress/mmapstress06.c b/testcases/kernel/mem/mmapstress/mmapstress06.c
index 4e6023399..2813ef185 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress06.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress06.c
@@ -57,10 +57,14 @@ static void run_test(void)
 
 		tst_res(TINFO, "Dirtying %zu bytes in child", map_size);
 
+		/*
+		 * Yield periodically to space out allocation spikes and allow
+		 * asynchronous swap writeback to catch up on slower VM disks.
+		 */
 		for (size_t i = 0; i < map_size; i += page_size) {
 			mmapaddr[i] = 'a';
-			if ((i % (2 * 1024 * 1024)) == 0)
-				usleep(1000);
+			if ((i % (64 * 1024)) == 0)
+				usleep(200);
 		}
 
 		SAFE_CG_SCANF(cg_child, "memory.swap.current", "%lu", &cg_swap_after);
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
