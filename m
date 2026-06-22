Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90BB7CDB46F
	for <ltp@archiver.kernel.org>; Mon, 22 Jun 2026 09:58:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B71693E6998
	for <ltp@archiver.kernel.org>; Mon, 22 Jun 2026 11:58:13 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D0B543E53B0
 for <ltp@lists.linux.it>; Mon, 22 Jun 2026 11:57:56 +0200 (CEST)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8A3E0600132
 for <ltp@lists.linux.it>; Mon, 22 Jun 2026 11:57:56 +0200 (CEST)
Received: by mail-qv1-xf43.google.com with SMTP id
 6a1803df08f44-8dd94941c21so39407236d6.1
 for <ltp@lists.linux.it>; Mon, 22 Jun 2026 02:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782122275; x=1782727075; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A6iCMqEzb+kPG9WseVraF7DI0ln7Xqzy5g6E4AKWpXw=;
 b=i+MxwhtRc9zltSoyGfkP/ta1R8ojR5oDu/KLSezKi7vAUAXZOyhHrdTZpEmWYGlade
 bzGzvf+rG1DR0gpdrbt2UjVLeQ9FjPGLeuxmSKc9hzYeNWR8VgdDXh7u8JKD1VKcI9LU
 Cybqpj7AB5+bhJLuHRJUQYGv6tjbq5EaNSesJgbYrHBGNqIwK+dZov2Qe8uwDDqsepUf
 kRCCR38BrKe1J1KP22Zryf7zJ7XbkpANXwoc5siVcyPpVqX2WPYOezkMWoP5hdsTRVrQ
 urpIDCIErsP+paII8D6fd6QtAll7Q/brRe33ZK93cNDoFqjj59+F7J9F4NgIlST8B2a9
 lYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782122275; x=1782727075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A6iCMqEzb+kPG9WseVraF7DI0ln7Xqzy5g6E4AKWpXw=;
 b=B5IGF0gPvDci7gZEromNMchMCdGKClwd5bzOOFHJnaxsRUsdemTxzchXDrIvF2UeOV
 wSGFXJrxJhVb+BjgmplK1JfaMd6mQnBKM7GIPmrDqqXp/0xbWxltCU5Abp7zknELtNtY
 l8qjeVH27kfZ7YA/1bfV9K7uHef4ynh+iot8OVRqUw8d1h1He4ikqLn9HGewDCONL74S
 x94mSwV6DjQppz5bz9DZ47E7ZZmbY2k2BRrmSxI2zN1/d3mkDpdVj/sEMa5Ilow+Yc2h
 VqEh9KKVlWwhLR6SfDjf1lUwqx6xt4Y5J2fUOvYE0P6Va+i6ffupcF7umYRuULQaDi0n
 mokA==
X-Gm-Message-State: AOJu0YzfEYHMDlvlXyftcGimZShDQKWoah54HmYU5aMfPD4o2ywFZZ9b
 FpkSvN1icxNf7Nsw4mrkVlWoltVCpyid4+tXx+6RYuv68T6uTgke6UGZ
X-Gm-Gg: AfdE7cnqSJY0lRneeJ/kbVYkSMNJ35kQGU2PC+XYTCdAFRA3e/wlk3se0jpnabpPHZx
 bYLbRkD8OYPoMT2CIwgJTrh9ly8S0+2WH023Kz2tBU6/hE9UDRLxiiD0aHE1L1yVkBdo7nqytsW
 FGRkn6PSPUB9FYXRqI+vqg9/xwPa+uy3LgWv1LJWpR5oWZidz8pTvk+KTDC5piHoDe8pLPsrnha
 HKKWkQYyolDfJ5yKomWPxX97BgVQAKcrlL3tr7Iaqv/JgSOnX7sbf9kKRwMhJkVnZbUqn+dXaLh
 h5Bdgm5bnSGasn4tEwjleir8xH8R1gyARmtjRkocexYWhuflrKUlJokPueILHYVk09ReQBYqdnY
 fTSIGlhU4lTVLNNj7TpSHwqop8NdR9FUdo9VWZholCOJBVxc+iYilNOZwg2ioVqU6TGM4/QnWLl
 Rdfxhcv0hK7bHUHfpRAtobE+nKFi5nmY44vFk0vsPH4HZvBuaFYVDnQ1Nup64F+v0cIKFbIO0Jl
 vj51jH9lBRqeJXqye4yWujudbSpIg==
X-Received: by 2002:a05:6214:4a86:b0:8e1:aa1b:1b20 with SMTP id
 6a1803df08f44-8e1aa1b1e72mr76833306d6.4.1782122275314; 
 Mon, 22 Jun 2026 02:57:55 -0700 (PDT)
Received: from
 runnervm7b5n9.aznx32dfifrebbvbfxy54ejxre.ex.internal.cloudapp.net
 ([64.236.133.136]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8df8268ef00sm89068636d6.40.2026.06.22.02.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 02:57:55 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 22 Jun 2026 09:57:53 +0000
Message-ID: <20260622095753.3979-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622-metadata_groups-v3-1-45651d685c3c@suse.com>
References: <20260622-metadata_groups-v3-1-45651d685c3c@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] metadata: add tests grouping support
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

On Mon, 22 Jun 2026, Andrea Cervesato wrote:
> metadata: add tests grouping support

--- [PATCH 1/2] ---

> +static int parse_groups(struct data_node *groups, char *line)
> +{
> +	s += sizeof(GROUPS_TAG) - 1;
> +	if (*s && *s != ' ' && *s != '\t') {
> +		WARN("Empty @group");
> +		return 1;
> +	}

Two things here:

The warning says "@group" (singular) but the tag is "@groups". More
importantly, this condition fires when "@groups" is immediately followed
by a non-whitespace character (e.g. "@groupsfoo"), which is not an
empty tag but a word that happens to share a prefix with the tag. The
message should probably say something like "invalid @groups suffix".

Separately, a truly empty "@groups" line (tag followed by nothing or
only whitespace) falls through to strtok which produces zero tokens and
returns 1 silently. Should that also warn?

> +	/* inside the testcases/ folder we will always have at least one group */
> +	data_node_hash_add(res, "groups", groups);

The comment is not accurate. A file like testcases/kernel/foo.c with
no @groups tags produces zero groups since "kernel" is the only parent
directory and is explicitly skipped.

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
