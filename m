Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A930606A882
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 12:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B3rvrW7K
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB3553EA9D4
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 13:11:17 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6664F3C1924
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 13:11:03 +0100 (CET)
Received: from mail-dy2-x06.google.com (mail-dy2-x06.google.com
 [IPv6:2607:f8b0:4864:36::6])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EA39E60068B
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 13:11:02 +0100 (CET)
Received: by mail-dy2-x06.google.com with SMTP id
 5a478bee46e88-37fba8391faso45039eec.1
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 04:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794831061; x=1795435861; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p6wOWOCESCXB/0ZA4PzLE2oWgRCcW4aNxCm+qAtZkD4=;
 b=B3rvrW7KGlSTYKH61C+St+nKmP5HhAUronV2knRE3kqpmHBQUpCElI7M++/89C3m8w
 2D4vSkRYAuB3NZktKLflGdkljgR/PeEDROYIJauw2DbGx6/rKhZ44GMSKZ10qbFm9cBI
 QYN+hlLIbOSp9PAeQexpuL/D03X9qwSEQIsXQ/+nCTYc+S5waEJymPp5+qb5+GPRCPl1
 fH+CTureMuPMGvZUcszoD9hHsSAL1xGHYdUDxO2PKKA6LR5TGl2G8JUDMLuSo8+tA61H
 UI9IY3Dgu/vJKfL1ZE9VQhrkMduWAj1EnTAAdd8Fw2bfUmBCO6bCS41D+AoEodk9RflT
 ld3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794831061; x=1795435861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=p6wOWOCESCXB/0ZA4PzLE2oWgRCcW4aNxCm+qAtZkD4=;
 b=DAB8VSkLehhyTdVfjMRjkMzCPEPKZV1qMd1ku01wjBVJuMLeP+QdApeembLs4zOkch
 3O752ZDwBK6u5R90bgm42AXaWaZTYkaBClJXSVt5MmyTCaCxRJgIlAHpPCnvgFKksMO8
 dYJp064C7xOBfNnnray0XgaN4esvy86b7xnSWi1oYv+r+iaLX5VwEgNKuUaHZQGdPC7P
 J/fVwKrvP7yDTQXzye55Sv9cr2kS57YNnVmRHwTxg22n0g00gGi2m3GhHDDAVyjsqSZy
 PCj/EXInr/9M8uqPfMHA/AlcxpQvr50vtKh9+Xv9R3GG1wUNMB9M1zSgRKanmbz/aCEc
 guTw==
X-Gm-Message-State: APuU4Z+d1JiKgpIlD4ny8MXCDQG72b+zqVSr8a/KK7HcOwqU1FbciMPg
 Vw2n+jwsVQZhzAnRnS6eL0inpnlJ6sILh76A7uGmoLeFdtCxOTVJsPfRAA63UGIzz+g=
X-Gm-Gg: AYBFou0fgQF6Bm/yQ+5iu22TrpFUv2uWDTimA3V5LjanrR3SRBwedQhRSL0EBLx5pzp
 5PkQrJcXt4COEdh+8c/20yJztc+3whpJ5iI0vOEPCHLwK71bgWYChZzThb8BJdxaA6ivKFtK+rh
 SDaysiWoVSVqo3hPgx750dPoBqGvTS4KaOXfNNS4hm5QJjLWoB+7Cri7kqwDIyj2OokU+5Z2CXV
 aNRJRG73UEgw1OXAKYa0AtpS3K3U9kzyOBie8QvPmVUI9uinniI7Xjnd3KAV0+D2eOwRvaivUNs
 vVrwbeUrh0v49YPowY+wAABEoepWwsDfgqGZArf/SOIcUEzW6eCUpoEkgSHBOm2h3WdvcOgsOJN
 rSRFCs+D60AJFlBzScIsBsg1Rce8TFpMiL1sCjIAYKofXVrQ25u8Qp/eyDoIyTpedHId4vkPq80
 b6Y+PdWIVIrCB2u8861NtKjRGwv71PaExGkY7Ab3HG3TG9WVAUKyFclBPmoAxG0N2dcQ7q9P1UL
 +tQRUZRHTLGBQin8AvSpcHSMoAaYtb3Sc8axjz/I0R9uljt7esAMKoR2MZngnzQqqSiyjCmB6CO
 W5apLf3goLHvYEu6FdJiK9i6diUNSvxvSYPcrOsyBcsOX5FbbiCmhLNRA4JkkzekCdbZUS1DfZZ
 LTcwKj7DfWkz/EHWdYGpEwIp2yQpaCTl3kv2rCkA6nL+U
X-Received: by 2002:a05:693c:639a:20b0:36c:fdba:ee36 with SMTP id
 5a478bee46e88-37966e3a566mr9782455eec.12.1794831061061; 
 Mon, 16 Nov 2026 04:11:01 -0800 (PST)
Received: from
 runnervmccnms.5sfwnsx2grouxla1jo1p4lze5g.phxx.internal.cloudapp.net
 ([20.169.110.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37956bad134sm41543887eec.27.2026.11.16.04.10.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 04:10:59 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Huaisheng Ye <yehuaisheng@open-hieco.net>
Date: Mon, 16 Nov 2026 12:10:58 +0000
Message-ID: <20261116121058.4147-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116101559.93229-1-yehuaisheng@open-hieco.net>
References: <20261116101559.93229-1-yehuaisheng@open-hieco.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugemmap10: Add linux-git tag for NUMA fix
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Huaisheng,

On Mon, Nov 16, 2026 at 06:15:59PM +0800, Huaisheng Ye wrote:
> hugemmap10: Add linux-git tag for NUMA fix

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
