Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A4E4F436A1
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 13:27:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EB5A33E594E
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 15:27:12 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C5213E1B53
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 15:26:54 +0200 (CEST)
Received: from mail-dl1-x1242.google.com (mail-dl1-x1242.google.com
 [IPv6:2607:f8b0:4864:20::1242])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BD050600631
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 15:26:53 +0200 (CEST)
Received: by mail-dl1-x1242.google.com with SMTP id
 a92af1059eb24-12c555f886dso587144c88.0
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 06:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776432412; x=1777037212; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5RdRbN8Br8awMWc9RsDeLspQLyqD6+eMJYgu9h1qO20=;
 b=N9Te93XV7DBGjrdtTH/X8mbEL47p4Am+XPyqloGgv6Ym0RM5afq8g1N6ZPsKQDs/DG
 5/lbwRdknojvajbNfq92+nnTgmDsvd2jmyHil2CKkYUO0OKASZ8ZPE9yKYrH4/tmfj1Y
 2N8TDr1JcUUJyinSwMCaXdTTDMUfcSsstepHHD4u/AmFK+q8JizLNXxi6YLLeFfQbcDc
 +SILPKByFNhWD3JYtpNxr0v76yYsQqbesdHm6mWIYl6fL8w55SsiDTfqlf184M/crzQP
 mXZmEO8APUUhsOzzb/2bGVTPOyBjyTlXWWa704PgJaOEY8WgkDKRvIZIBrFXWHGKq+8j
 lozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776432412; x=1777037212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5RdRbN8Br8awMWc9RsDeLspQLyqD6+eMJYgu9h1qO20=;
 b=aoHM3nKC3Ii+o+GUhNAaNwy123QZp4hWpIuiQtIDXSeRlkkWKW/2g1zh6XGdakrHSV
 DMJMq9pR5mnMZe+H6cZWU+Dz64QIDs+lzOhy/FpsfxwD/6lHVeuJKvSayrsACc4jqmFi
 T65RENMsrlRvrQTK/A25unOARXhf57lyRtFU0Mb0vT496hqHvbIXCJRWJtVG0D9zgdpU
 1tRZDzuc55w2HI8libqn12812fpcEDSdd+IngQ8x+zIfLAzyrCGZYr8QLhgD3KFHSwMv
 I3TBicrjduS+W3AOidItiI9a5bghyUpUt3hfVX60cqtCNoJQKzbtKmjeBr1FN903kbYr
 6JXQ==
X-Gm-Message-State: AOJu0YzeZt5gMFcoghRHCpYFGUK3tyU3SKRumMYymrRFb2y1RT1wEvjd
 S62d2h/JGtpioJU4L/CPLE4DqJsacw1p2ayTlHOHol06ux0hKRI5t5bo/NN17HwYfFuzmA==
X-Gm-Gg: AeBDieskpnSWHHIuegf9uDL+wKQRUt+wzO37H/wkzxY7FmGBSMIHRXWiQ18Z7ftBn+a
 VhZvIG31ZuJbI5T+/l4zzASNMge+fRzaGCSINOvtI4RAkb4WFzodguayWwSYAlUSKwSh6xEvLAK
 omKTfTzW7m0EITuYsGHtp3hnNOwN3UcKj6pb31djK7EGorvHCENuyO8UZlFkU+4ShObKrEGMKSe
 RFofUUH2C3HOtPvwZ+BSzbmQbcY38aEM7ZVlPb1fU3EF4Xu09Rn5wgHMCjFjMW1pyAVqLqt/mcz
 9ZyhENZZTB2/85nvxRl7qu11LmHRlZNP3TrV5scGFs8IFGMW1d5RaRP+PNLEqJ+OS88ZRm4nXBg
 sPRMGEsahOJCyDApglrwy1K1MMXYTgFBJLrC8KEOZaJKP7TXXGkSbK07y4PzRs7IN9TEniUS7nE
 QRGNHpu7NoWEbIHWsrXaFPw/jwmRv1ngPVC9DZppT891QkiuYc7H+v9+9UDsjihA0xEz4mrASFH
 Qnf/ZtwyJhxtSLAjq9IGjPkHHuoN8BiX/i9tYJz/wCgl6uM4Jw=
X-Received: by 2002:a05:7022:6889:b0:11b:1c7e:27d0 with SMTP id
 a92af1059eb24-12c73e28127mr1570840c88.0.1776432411871; 
 Fri, 17 Apr 2026 06:26:51 -0700 (PDT)
Received: from
 runnervmeorf1.amq2aokpdqoubhi1rrhh5bwnsg.yx.internal.cloudapp.net
 ([128.24.160.246]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c749dc86bsm2690078c88.8.2026.04.17.06.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 06:26:51 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Fri, 17 Apr 2026 13:26:49 +0000
Message-ID: <20260417132649.3984-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417122804.23890-1-wegao@suse.com>
References: <20260417122804.23890-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] mremap07.c: New test for mremap() with MREMAP_DONTUNMAP
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
Cc: ltp@lists.linux.it, LTP AI Reviewer <ltp-ai@noreply.github.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

On 2026-04-17, Wei Gao wrote:
> mremap07.c: New test for mremap() with MREMAP_DONTUNMAP

> +static void *fault_handler_thread(void *arg LTP_ATTRIBUTE_UNUSED)
> +{
> +	struct uffd_msg msg;
> +	struct uffdio_copy uffdio_copy;
> +
> +	TST_CHECKPOINT_WAIT(0);
> +
> +	struct pollfd pollfd;
> +
> +	int nready = poll(&pollfd, 1, -1);

Nit: declare all variables at the top of the block, before any statements
(struct pollfd and int nready should move above TST_CHECKPOINT_WAIT(0)).

[...]

Reviewed-by: LTP AI Reviewer <ltp-ai@noreply.github.com>

---
Note:

Our agent completed the review of the patch. The full review can be
found at: <review_url>

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
