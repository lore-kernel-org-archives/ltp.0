Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 956C8C5DF66
	for <ltp@archiver.kernel.org>; Mon, 17 Aug 2026 15:41:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 09A353CB6FE
	for <ltp@archiver.kernel.org>; Mon, 17 Aug 2026 17:41:38 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 704613C0224
 for <ltp@lists.linux.it>; Mon, 17 Aug 2026 17:41:23 +0200 (CEST)
Received: from mail-pj2-x02.google.com (mail-pj2-x02.google.com
 [IPv6:2607:f8b0:4864:39::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 890DF14004FD
 for <ltp@lists.linux.it>; Mon, 17 Aug 2026 17:41:22 +0200 (CEST)
Received: by mail-pj2-x02.google.com with SMTP id
 d9443c01a7336-2cb3f5bb19aso17960415ad.1
 for <ltp@lists.linux.it>; Mon, 17 Aug 2026 08:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786981279; x=1787586079; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=k6SelVxydms53X8rcTabvsrqM19DrFyar1Aqs0XMpS4=;
 b=A4oi9Z6+9iREsOtaviC3jfelTjfdSlfLQi4H35OVgWzbUEUCdCuBjDqgRKALgaiOKi
 5B4Ib1OkRu/r+jdC488V/f3ZVYvhtACo4WQVXxj/AOxSV6WqlZKsK13x4I3Ddm1t4opL
 7+Q/WMZZZyx4AS4fyZFYGfIJJZgpZHiV5EvGCsIUvaBGOVmTOmw3dXIz9kk2uvzn3JfF
 tjzhfadzYZY9koMvso4NUbSotwECN63JrYdJYGH+a/OgWBOFAeEu5/FD/+yNi5fncNql
 CQjY5EG5ACyxL6DWg3TYgSPc190AuvDyXdqCIO63vdMvWXSCbzR5+T378wNyVFLmlUmn
 I8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786981279; x=1787586079;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=k6SelVxydms53X8rcTabvsrqM19DrFyar1Aqs0XMpS4=;
 b=M46YzXQ4q1THWBahJgmGAefEsZsR/3pT/H/ry6WrzLMD10PNdhNOCXpf4dwSpWykDK
 wCbVktDi6U/Sosd0HTSCmkcWAx0lrJzlZytN+V0E80RAXbNLTjbEtbZe5qVNSg9bLxdX
 OUYO1xIOYg4f66xl7WbkRPqOkCyDaWChS2bPknmuST74q48kBzPXlkxhAk3EeKALT4hp
 AftZf1MJTckAjoG+ahxq/8oR7ydLSbGMekf73HkCl9JG0WsxJmtFjAQOmf+NK49pexcl
 i0jKvtbDNwso5zcGxviTKCbAyhbKcWqfTKdjl/PQICAWEGoiTQaYfibMwHrFAu6S9wBF
 xe2w==
X-Gm-Message-State: AOJu0Yzx7WeSOL7doIl/ZZ9vxUeOPV3sApBYh9h4wCIvz939XBl3qDi/
 OGdXQZ0fqhsqDtYFDrYkvL6DwrgRq3wcXGkmiFmlZ8j1U/ejYu5kvc1yFoJ3InCowQ==
X-Gm-Gg: AR+sD13btU3kU7laeKT8yLIoD3dUv1HdBJeHSI7x0cY9VimDuUELX5sATODWlFLUcnX
 1vpkLyZDxJpxXP4UybtKXbq9j/SvpeSA+DHfmqaBL/8naBmdlK30NntL3Dd64OhAyApRsSJUQl7
 V6V7wD0B8JexuhEoBZWzFMhJh0ZYasAB/+sewLKJqpikSzfPe+uvJxb8ixHYyESZaSqWRIk4ex+
 1rdSd3ouj2lSDg3PLRic2C3dmZkbkU+IyWotuz+G9OpfFSBAKE0lt8S3aDzHpcIW3h+qoADHIYO
 Mc8GyhxlJGrF9+eojJjWiXouPF9ZCu/DQVRP6ovnU8FeAOoai+rJ+bwgQ9JGJq5P8GbZgRrA/H6
 thrkS0yyGqUaX4WF+PqJt/zfja/II4lZ73VGJxkWKuiiPqacXgk7/SiFLlx7uKCPZdpB3tzNgfD
 SQhGFf6jKiRHYcJxO7nyLke+sMoQklh1gNdlZVfm10FDxMeSZeJusDaqsUx2P3ksTXuPyG8yUHV
 1EDy2S3JA==
X-Received: by 2002:a17:902:da82:b0:2cc:777f:d67c with SMTP id
 d9443c01a7336-2d3b0d5ed01mr259684685ad.13.1786981278998; 
 Mon, 17 Aug 2026 08:41:18 -0700 (PDT)
Received: from localhost.localdomain ([211.196.223.197])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d5c1e54330sm5340455ad.44.2026.08.17.08.41.17
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 08:41:18 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it
Date: Tue, 18 Aug 2026 00:40:44 +0900
Message-ID: <20260817154048.3854-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 1/2] fsx-linux: Fix reference buffer corruption in
 op_map_read()
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

op_map_read() copied mmapped memory to file_buff before comparison,
overwriting the reference data. Drop the invalid memcpy().

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
 testcases/kernel/fs/fsx-linux/fsx-linux.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/testcases/kernel/fs/fsx-linux/fsx-linux.c b/testcases/kernel/fs/fsx-linux/fsx-linux.c
index 2e0f17a5e..21390c58c 100644
--- a/testcases/kernel/fs/fsx-linux/fsx-linux.c
+++ b/testcases/kernel/fs/fsx-linux/fsx-linux.c
@@ -219,8 +219,6 @@ static int op_map_read(void)
 		file_desc,
 		(off_t)pos.offset);

-	memcpy(file_buff + pos.offset, addr, pos.size);
-
 	int ret = memory_compare(
 		addr,
 		file_buff + pos.offset,
--
2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
