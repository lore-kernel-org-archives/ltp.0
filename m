Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3163FF885A
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 14:05:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 65FA83E6218
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 16:05:27 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CFD9C3E1C3E
 for <ltp@lists.linux.it>; Mon,  4 May 2026 16:05:09 +0200 (CEST)
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com
 [IPv6:2607:f8b0:4864:20::c43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EE81D1400430
 for <ltp@lists.linux.it>; Mon,  4 May 2026 16:05:08 +0200 (CEST)
Received: by mail-oo1-xc43.google.com with SMTP id
 006d021491bc7-688a8e5fe5eso2036649eaf.1
 for <ltp@lists.linux.it>; Mon, 04 May 2026 07:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777903507; x=1778508307; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EJ+NzesqmgSjfDHqjhYxDxkG/unPjvWM7jMGF+2bjFc=;
 b=cJVzb0zN/dkfqR8F4sgSf51ban0TWuUPqkRwcW2a3YbyQ522NWVPif2vJ6tx0MyqS4
 Hh+Vg56a5iig9WLXZw473ZssQY2p8cQJiovIBygB8yphYdQTcVKHs4hDo915U+WvhL9u
 C2yMq/SNnsDd0sJsv/VwEfs8PveEXnnhclw2aGRuklIMNFQqnbGcqbkCOplz3BMbJgWk
 yGj7NdwSuOG9npT+zzlEQ49xsCXAuziA6Fk/vnIps5CUWlxBI6dWev0h2k3kXlflvF5V
 4G9l1XQsNcwn0e9saCzi8An+9O74gg13sB7xh1afTCy/Jg4jTDzDG3By4cvyEhER4qpM
 iY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777903507; x=1778508307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EJ+NzesqmgSjfDHqjhYxDxkG/unPjvWM7jMGF+2bjFc=;
 b=EovvA6CHel3oOcKEmyyr1hIE/BsgEirjdcvq01iiRuIk4xXojjJduRSXtWzc+jcOdz
 dpYNBJxBxoj1+4hppfOzzc7zlwzxmxBob9ctW7ftobP9yKdbZRny+zi91U4BQXqeJ/uT
 HgA2002B3w5hLIl5cFCx+BUDDeNcSPUYe1C/cs8jMdtJt/5vQ4ShqUpvbOG5k5/BkpPN
 yuH/gUNGgxmHCzhJKofR2pPrxomaDnYBBSaqbhU6pDx6ta/oV2kKuYGSujFLEaq+xDOA
 +FWoU5qJYtnhEdorFq7tafe78ULA2h3iKbLIjB7iQ3MyY+YOT5WdPQ/i9ka/yK7Q0M7R
 i1lQ==
X-Gm-Message-State: AOJu0YzD0S/kVflM6/N3SNII+vV0GGHrcSJpjMxt3zdTgQuYk3NtG6mB
 c/W6IRhmDMsb9SSFQPTWhS+nnLXiYlq/kucEP1rQValvu+5DUjncki9a
X-Gm-Gg: AeBDieu4j3LjIjCZlOCDA4dpQbsy2Wf9J3O5wOjaJS5v9l4IKkDClXSruxiWNc6x/jz
 fL7SZPfU4KbZGrVP0cSXyxpkv6uXOZa+EpuhCh/t5qP3YqgPKVT4tSMi4g/ZyRmem3xraVAMPCP
 aoxm63vsu3F2FTy4pwtYyMawXR1G66osmyuD0tCWHA48d4Gk1ljpUZc1rWljkYfKou4lDkhJbIW
 aJsA8M1YJn2FEwkRjeeXbtFXegEySNHEa3KMkG+Z5CyOgc2NJypiec62hccZhOy+OiXz+Hcji3W
 tbqMw3mKNj/zCVp+yPU2miAVG6W5MXyExAl8oETgSuP8Cfoho2hdfqVFS7oyLA+080j3VD9niRR
 P7hJD50Pqs0m4rYse5aPQyK9UDjMrlNOsLecRtxiHd8vP5IBJlao0zkb3iT7vLEHb8u4Bk4lUJg
 SiQZ7SMUMhtgw3IcBm+gzg0ECVdQyHeROlYq+UqO3wI8qVVd8A5+z6toKnrFcJDWFayZQ3pxLsR
 yP2Ki5Jc0EmP0vvj/EOqaGczXG+S/Se680kNYFon69YaK2EVr0=
X-Received: by 2002:a05:6820:4b85:b0:696:1a85:586f with SMTP id
 006d021491bc7-696979e9656mr5181092eaf.18.1777903507413; 
 Mon, 04 May 2026 07:05:07 -0700 (PDT)
Received: from
 runnervmeorf1.b4kmw0z1eoaepjsm11nvbjrwih.ex.internal.cloudapp.net
 ([64.236.153.165]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8fc29a81049sm1156012485a.18.2026.05.04.07.05.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 07:05:07 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon,  4 May 2026 14:05:05 +0000
Message-ID: <20260504140505.3946-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504-fix_nanosleep_pts_get_clock-v1-1-754e299f929d@suse.com>
References: <20260504-fix_nanosleep_pts_get_clock-v1-1-754e299f929d@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] nanosleep: use POSIX runtime detection for CLOCK_MONOTONIC
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

Hi Andrea,

On Mon, 4 May 2026 15:20:18 +0200, Andrea Cervesato wrote:
> nanosleep: use POSIX runtime detection for CLOCK_MONOTONIC

> +static inline clockid_t pts_get_clock(void)
> +{
> +	if (pts_mono_available())
> +		return CLOCK_MONOTONIC;
> +
> +	printf("CLOCK_MONOTONIC unavailable, test may fail due to clock adjustment\n");
> +	return CLOCK_REALTIME;
> +}

Clean fix. Centralising the runtime detection into pts_get_clock() is the
right approach and correctly handles the Linux/glibc case where
_POSIX_MONOTONIC_CLOCK == 0 requires a sysconf() check.

Reviewed-by: LTP AI Reviewer <ltp-ai@noreply.github.com>

---
Note:

Our agent completed the review of the patch. The full review can be
found at: https://github.com/linux-test-project/ltp-agent/actions/runs/25323299867

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
