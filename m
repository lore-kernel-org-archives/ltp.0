Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67EACC79F80
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 09:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788513326; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=zup75Uj8D8YNuW4GC9wPnT5irwnmlZK4RINIDKzQUcg=;
 b=XfS+yTayVnlR2cTnH4n+yQ4dzItR/qsVMw5l8SzH+Tp8bSI47IAy95+CNCm6MF0ZkZcs1
 DXswPeAAYO+bscHxoyOdTAA30kj6ITYflYcBMcoNYuEpngA5+mbmFp8IzYuKTd2xoMqsJwn
 IR/qAxmHM1DN2K7BAWpBGnFyk54V53k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA7193E1CFD
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 11:15:26 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5FA573E1CFD
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 11:15:07 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8EE7D600637
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 11:15:06 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-49b96837ca3so5107735e9.3
 for <ltp@lists.linux.it>; Fri, 04 Sep 2026 02:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788513306; x=1789118106; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RGDxATOQE6f41iYLe084u7QtJGg6+bifwWZEPDusHuk=;
 b=Hi80v/tOAAa67wKIVM55EPOuOv1H2lCWRIE46Z69oZDjRnKdpsr4IB7SugAm+zBZ8X
 JdLLJ0GJn/LiGADtT3Vhuktt9mkkPepRmp7iwZrjRPL0HBDyAnroYVgfaN5aeCCcfWDD
 DY0BtPLih5POAazUlGxuyoZfbd5f1Xr+h9dCvjuiMWeNF1xFc2tuWKO9qFy15qbFsEWj
 /BlFrlGFlTEcrAAp7xf5nPZX3DJeYE4YFBrdJW+Sbt86YTIVHGqea2wMUzUBJ/ctekbF
 UUXU4GAN+i1hAOFcA4Nzb5dU8xYsBbcv7dC4BI+P6y9uQhRHcaFDJIcfmqYOZgE83sVJ
 2dnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788513306; x=1789118106;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RGDxATOQE6f41iYLe084u7QtJGg6+bifwWZEPDusHuk=;
 b=HuPfVp8IWp0cJRXdiE1P4Liyx6psNJi+2wlfDmEMxsw9JrQYjNsr2YdT2M3Ds5L7e4
 6OtonqWYVwojooN0UF4pey0khuA8Ru/ZJkX7fJm1sD6m10PWW0UZTPLszmRSafpxQ/57
 s38//AzIz68Ch70onCAeoCp8Bv8ZrVst3FNKWmteUquRz2rbTQDhfSODXH4KIwAkkAVG
 cFkbmOB5G7MdXtAmPgBdQeEvOoHwomUFXVMY1ab8gUiXGew1SPdapapRUXbrRmcUNkVt
 bPq5QyDdHRaEcrCfmWPkEjeQ5+o4DsvNIZaJeLtUI9Pc4qUWMIsyN3tfDnOQaAn/WgY1
 Dzfw==
X-Gm-Message-State: AFuF++m4SCNxmaKJM/zEKmdT8n+ZLjjlz1ZGwDsvF9AoOEiNNRjESAx2
 82Z/3/zOyhyGKU8qNQNS6yOjCPUyZ7vsJHAL5n25fx0JVxUv0/zDw2yPul6ik3A0AhO58lH3fgH
 XtXp3uT6/tQ==
X-Gm-Gg: AYBFou2l5wR/gq6i7FMfe4/UehE4x4Wki6y4lT9nPzs1WsCXcp7sdG48TmRMfvCwDcA
 91JYPtWh8oM8cCVUAvsm7O4tYLdxDHzZyL+Iu9kz0IEA50LI26iXO9WdRvRsB6eXkuEyuQ6zJZe
 gGgaJQFQnwthVcU5Se+mXVtzQvLQ1AfnnQ9aX/qrIlLueW9aVccpn5VxD8hZDSOjsF+2R4qt58w
 ItY3Wocgsjjn9GGHQ7ZHmQ9opj/SD+8mSXv7PZyzb3X8gV9gQBx/o5U7yub9/Jr2PUezx1ZlNCR
 CpREp9b/q9U8T59ApsNC8vneNi3wQ0Dye2kjV6fFmykZk97/pBElsufGAY4k+mjqSLS5x9hTHzS
 UrORlBArQ09YeaJnEZgQc5fnc8j+5mTW7IGN8bP1fpvV70aIjJXqO3TnU8nUc002MvMz8z37/ij
 o/M7oKwa1E6gAqTaO3hvF8cpcDAg6T+LDLp+/YJTwarrC62NxWZnX2pLyLvX0v7SULFCOoNxP47
 vgi0uuom1kG
X-Received: by 2002:a05:600c:6748:b0:49c:fc6c:bdfa with SMTP id
 5b1f17b1804b1-49cfc6cbfa2mr17849265e9.17.1788513305742; 
 Fri, 04 Sep 2026 02:15:05 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf7739b7asm51450605e9.13.2026.09.04.02.15.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 02:15:05 -0700 (PDT)
Message-ID: <6a9a8c19.6fb78de1.549f1.a8ee@mx.google.com>
To: "Victor Cheng-Yen Yang" <cyyang772@andestech.com>
In-Reply-To: <20260824082350.70245-1-cyyang772@andestech.com>
Date: Fri, 04 Sep 2026 09:15:04 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] hugemmap24: Exclude RISC-V from the powerpc slice
 layout
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Vitor,

> Exclude RISC-V with the same way loongarch is excluded from the powerpc
> 1TB slices branch.
> 
> Signed-off-by: Victor Cheng-Yen Yang <cyyang772@andestech.com>
> ---
>  testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c
> index 0de44d58a..882752792 100644
> --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c
> @@ -28,7 +28,8 @@ static int init_slice_boundary(int fd)
>  	unsigned long slice_size;
>  	void *p, *heap;
>  	int i;
> -#if defined(__LP64__) && !defined(__aarch64__) && !defined(__loongarch__)
> +#if defined(__LP64__) && !defined(__aarch64__) && !defined(__loongarch__) && \
> +	!defined(__riscv)

This is getting bigger. We can change it by inverting the exclusion.

Instead of expanding a blacklist of non-PowerPC architectures, invert the check
to whitelist the only architecture where 1 TB slices actually exist: 64-bit
PowerPC (similar to how hugemmap07.c checks #ifdef __powerpc64__).

WDYT?

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c
index 0de44d58a..1d141e6ce 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c
@@ -28,11 +28,11 @@ static int init_slice_boundary(int fd)
 	unsigned long slice_size;
 	void *p, *heap;
 	int i;
-#if defined(__LP64__) && !defined(__aarch64__) && !defined(__loongarch__)
+#if defined(__powerpc64__) || (defined(__powerpc__) && defined(__LP64__))
 	/* powerpc: 1TB slices starting at 1 TB */
 	slice_boundary = 0x10000000000;
 	slice_size = 0x10000000000;
 #else
-	/* powerpc: 256MB slices up to 4GB */
+	/* powerpc (32-bit) and other arches: 256MB slices up to 4GB */
 	slice_boundary = 0x00000000;
 	slice_size = 0x10000000;
 #endif

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
