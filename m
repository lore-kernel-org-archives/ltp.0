Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F0DDCCA470
	for <ltp@archiver.kernel.org>; Tue, 30 Sep 2025 23:30:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4522D3CE2D2
	for <ltp@archiver.kernel.org>; Wed,  1 Oct 2025 01:30:24 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2EEC63CD1C1
 for <ltp@lists.linux.it>; Wed,  1 Oct 2025 01:30:06 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CA82F600685
 for <ltp@lists.linux.it>; Wed,  1 Oct 2025 01:30:04 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3f0308469a4so3708161f8f.0
 for <ltp@lists.linux.it>; Tue, 30 Sep 2025 16:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759275004; x=1759879804; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WKocoFyhYs5voJ1j0rINOqN8fPDxe4oLJZbuE7DLMzA=;
 b=YR557VqPO0u2Kpc0m/57Pw/k6DdWXaS772bSgBYw87mAmJcAYOhLfMIBvGg+osBErw
 9lwZa3qgFfwYknwk6mqE3Zjbm/MIdbkeaLlgwRcZhQ+0dvgV7tC0+XWm4W5cKdYykL8Q
 yoSedfEHif0Ip/r963ijzNMyOR50u6HRbM2CkGouSocVAWGB3alrKST8rV3nbwrNPkxG
 fW7zRF/HJebho8A6K4JV2IXDhQu55csMw86XAGq5pE4HF616PeR6YntPFtKQItQ0ExBd
 Ffb8bnz/rJwM5Jlh5aQ3AiTuzQCfGWyJhsfjeh2A4BLUKP4jcWNY3jKNGeT+CcGJzin1
 9yMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759275004; x=1759879804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WKocoFyhYs5voJ1j0rINOqN8fPDxe4oLJZbuE7DLMzA=;
 b=LfRFTPlleWTVLWBV9kRRm0usMhpsyonNbbt7POnG7Hvu9EGmKAX8ZsiJac5hzkapSM
 O/omVNdDHQXnuqK06gcV2xbe74+kTPhUh2fhagW6xerO+Po9MsjTA58vJX0Wou2keRMf
 dHLbLcJ/5giBeGSt8nIJ+HZ3JP72dYmfexl+fufNwz7UaTiwwhugxuljRFB1sF/wHVAP
 FkDj4NyDejt54+qfSfx1o8c6SK4dRG6zQJpZ4zf8SlFAD5Sj7sBsRskaMTySbHQkfWy2
 1nVrPSNs9UCE5AIHlXEKgAb6K/g0eKC66RAAnu7wV36G/VvRVi9r7XdCZ+GQKLcqIuS2
 8y2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdolWC/3VmWWk0rzS+6RuwAT6ymxnzDaTXJfyTbxiLxrh68ey5lqNnScwDRTfyqvKcCL4=@lists.linux.it
X-Gm-Message-State: AOJu0Yw2Z27qYJ9vy7mQe4kKmiiwP8XsWxskJLRAz0NnFtq0gpOVIxcs
 y8hmXHNC14M/iXhfrJSSSawAqCS/+IGti6QLY2VfJYjs8sgnaNce6qbo
X-Gm-Gg: ASbGncsN4XvmP6/fyxrHt5EwnDE71AaH5dp6gnwUxdUv7D8EpVpt7MFCQX2F2BVS+Jd
 j0BORMVtGdo2NT2tZ3AxGNR8KKG/0rjTM4+VZ97BqTKppFZxkF7New5Rd/Ano90ZBtzJHKl066o
 lq8aH0BKEciFM7tqVn6ygRtckveO1+ZShPBxrMVte17QX4KVJujMWe44Tm3cN5S6Wv/Wkjyd9Cy
 yYmDb/tMgCg5mp5wARkz0M6P0rrRkAX0UYTOTOXKCeONdES7hg6p7X8k3uMFBkobRccrwxfXFve
 O0xJX4YTFeguOZ3Df00jkt7THd8zlRXcIZiOtqvplilmZlZpg3BAWyc3epWqYyP1tTuFFKtq0+N
 O1pGv9TYOHZ1WEeyiWVVhlRuwSry9xl959cM+R9a6i5BF9vRy02D1MO00Fe9NHJpjtXFf0O2XlH
 EP21//RJ4J/ITCuyzwPEmYtQ==
X-Google-Smtp-Source: AGHT+IGrlrBcqkdbjFn8gHHNIH9V5H/OJUSkp8w+fjG+KJIkz3Qh/I+P4TAxPxRIKI9Oo1ZDCt+OuA==
X-Received: by 2002:a05:6000:2381:b0:3ec:e0d0:60e5 with SMTP id
 ffacd0b85a97d-425577f0a74mr1070502f8f.15.1759275003933; 
 Tue, 30 Sep 2025 16:30:03 -0700 (PDT)
Received: from f.. (cst-prg-21-74.cust.vodafone.cz. [46.135.21.74])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb72fb2eesm25156984f8f.12.2025.09.30.16.30.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 16:30:03 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Date: Wed,  1 Oct 2025 01:29:57 +0200
Message-ID: <20250930232957.14361-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <202509301450.138b448f-lkp@intel.com>
References: <202509301450.138b448f-lkp@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] f2fs: don't call iput() from f2fs_drop_inode()
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
Cc: Mateusz Guzik <mjguzik@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, oe-lkp@lists.linux.dev,
 oliver.sang@intel.com, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

iput() calls the problematic routine, which does a ->i_count inc/dec
cycle. Undoing it with iput() recurses into the problem.

Note f2fs should not be playing games with the refcount to begin with,
but that will be handled later. Right now solve the immediate
regression.

Fixes: bc986b1d756482a ("fs: stop accessing ->i_count directly in f2fs and gfs2")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202509301450.138b448f-lkp@intel.com
Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 2619cbbd7d2d..26ec31eb8c80 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1769,7 +1769,7 @@ static int f2fs_drop_inode(struct inode *inode)
 			sb_end_intwrite(inode->i_sb);
 
 			spin_lock(&inode->i_lock);
-			iput(inode);
+			atomic_dec(&inode->i_count);
 		}
 		trace_f2fs_drop_inode(inode, 0);
 		return 0;
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
