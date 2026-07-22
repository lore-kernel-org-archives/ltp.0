Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B061C44536
	for <ltp@archiver.kernel.org>; Wed, 22 Jul 2026 04:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784695696; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=fs0UTgqfFHX3WBvTfiWTDEsV5fpAwrSyQlPG7Fp4BJQ=;
 b=lbIScqUtShkrzgN1iRTTn1SqWau7IpH2emYWP0IiMakb6GAkf09kCBNkeWjN8oXpaRfuk
 Dnlsa2Z/ZUWtxjVZS1dkanFUx71ViKREQXydHCPrtWwIOjzmH2nqE+4+mHiQt93HKPuha9Y
 N5k/Ad50dG6YbHvCRyQztyOa08wlHmU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 790153E1F22
	for <ltp@archiver.kernel.org>; Wed, 22 Jul 2026 06:48:16 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E7C303E1F22
 for <ltp@lists.linux.it>; Wed, 22 Jul 2026 06:47:39 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0AD10600AE6
 for <ltp@lists.linux.it>; Wed, 22 Jul 2026 06:47:39 +0200 (CEST)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4954aff6088so31828135e9.3
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 21:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784695658; x=1785300458; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/ctdw1sXFYoeQuYZRkNZTeEQ9oCOQrE745v5abeNnFA=;
 b=XZQ6n+I/kIagke0haD4EwHZ9B7EZ2IyyQigtHqK/ojsXuTOYvKSSmazbrkZ6j4zLvJ
 cc2Ax3UyZlnDLe6+klhpMXPG9Ea6/ZUxGI1yAdvttgPqh2uf3kbZE8yAOiB0PxoqhY/U
 woEkwEf3RnyPt89781EXivTuJ91ofO6LBTfuTNOp7rdMTKl4gyAJDXnTd5lBwS46uYKZ
 BTEeI+DG/VTA4wmR4iBI14gmlBar3m+/mTZgxOoNYdDIZMYXYzDmewlfwvbtdBykKroS
 M3UDaHp0Kc/uPP45HZw3/hyhO3S1GHXsUF3RZfopiwu0v/307eBxp7uAZ9u8UY2IS4Zc
 0oCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784695658; x=1785300458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/ctdw1sXFYoeQuYZRkNZTeEQ9oCOQrE745v5abeNnFA=;
 b=WKqOzSP5kyT1mjFH6MuDQ44IbTRcxbbiuRZ0Uyz/7MaI6Frx+IV4adUPaOC+awxsH6
 cN9Ddj7xOcbO2dbPNADCivA5N2q3jvjXKgbKBukj6SFrxCuYyhSZc7+iNTQdA7Ntr50J
 TxTUO254VCESv1u6I7tR8VNNQwKRpXdnK6hbgVX6r9gADD67cJGwIL9xzZD7EjlcjKtg
 s8Grx8zO4MvPwnfOAwxvmd6jC9ogWeje1Yk7aNUxfQH6gFdYGjclWninwYMjXNf0fBPk
 TsGoEbJ2HQzaBsXOstyHyrq6+b0DBchwh5GESQbFdYqDRIJYsJ4XKh0ELALg30OLSFqU
 8BqQ==
X-Gm-Message-State: AOJu0YwUNUjX3mmXhZ/xokU6JnCE1xuN9D4JZltL9hQeCEaUmgmZCTR1
 HzrnH2XI7Z/risgi6UOFnq+dwfIKwQUVp8B22vda7fMj/AJvd6LyrMiBhgL3MJ9odtNJIgfDR6Q
 YVdI=
X-Gm-Gg: AR+sD13Ak/Tin3gDCsn0hjPrxNH8JRwq1sv6AVnvORNAPE5lcwAzVpzVs8xZF7V/2LN
 tVLdwDxtndvOILwy9qacLPb6d0IcyqOFV4GwKQGxeqim6jTj+XkGbv8c78pVUhRITVWCF18NDJC
 jINNsiOp5MxjtI403flTOwnwA7iMiJr+idLtsgMz+Nk3fg8MkiyPCFLRbETSmhbJAHPNYGwtOrD
 hWPICcgYpQbHi+V+y+N3TOBY5EE8H1iOQF04DAcr7Zf/U39iDe5wTGwAMuFDkIx2M5fQAXnbnuW
 bRn2Xog9pRzTqfFD9gfhQJ9F+sNXIpGEQSM6BmG6KfV6NnZFg69lkDoa+iy7g44EZ+6nEKziyAv
 Ov2pcZmXXTL+R9G65iViJLtJCN+XQlfLp2tM2q56vjDrf7bT4c63lg9rCuk+g62vPqA==
X-Received: by 2002:a05:600c:4ed0:b0:493:c634:952 with SMTP id
 5b1f17b1804b1-4954a3d0872mr233478425e9.7.1784695658515; 
 Tue, 21 Jul 2026 21:47:38 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-47f85b9a5a2sm2447378f8f.7.2026.07.21.21.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 21:47:37 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 22 Jul 2026 04:47:27 +0000
Message-ID: <20260722044732.3547-2-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722044732.3547-1-wegao@suse.com>
References: <20260722044732.3547-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v12 1/3] lib/tst_uid: Remove spurious TERRNO from
 tst_get_free_gid success path
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

tst_get_free_gid_() prints the found GID when it succeeds, but it
incorrectly includes TERRNO in tst_res_(). This prints whatever value
happens to be in errno (often 0 or a stale value) which is confusing in
a success path.

Remove the spurious TERRNO flag from the tst_res_() success message.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 lib/tst_uid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tst_uid.c b/lib/tst_uid.c
index af4ef8cf7..b0b087362 100644
--- a/lib/tst_uid.c
+++ b/lib/tst_uid.c
@@ -24,7 +24,7 @@ gid_t tst_get_free_gid_(const char *file, const int lineno, gid_t skip)
 			continue;
 
 		if (errno == 0 || errno == ENOENT || errno == ESRCH) {
-			tst_res_(file, lineno, TINFO | TERRNO,
+			tst_res_(file, lineno, TINFO,
 				"Found unused GID %d", (int)ret);
 			return ret;
 		}
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
