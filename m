Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDCCFCDE001
	for <ltp@archiver.kernel.org>; Thu, 25 Jun 2026 15:44:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3894C3E6137
	for <ltp@archiver.kernel.org>; Thu, 25 Jun 2026 17:44:18 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F3B583C5680
 for <ltp@lists.linux.it>; Thu, 25 Jun 2026 17:44:03 +0200 (CEST)
Received: from mail-dy1-x1342.google.com (mail-dy1-x1342.google.com
 [IPv6:2607:f8b0:4864:20::1342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2C2371000938
 for <ltp@lists.linux.it>; Thu, 25 Jun 2026 17:44:03 +0200 (CEST)
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-30b9e755555so12896eec.1
 for <ltp@lists.linux.it>; Thu, 25 Jun 2026 08:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782402241; x=1783007041; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q5sTg3m/MQSzUCwtbfH6QpyZcpHs7+TlXDrDgvN3LEA=;
 b=ACp1cgG/ZFYIqQ67QLWNRyK15gyRvKes5xm626SLwSblZFel6+BdmM5D8AuOvuZrmH
 +Fgut7Azj+vh6qhnVSvdYSZL6ROD8B4wCZKPRZe4hUP+39rUhUm7mo4pHY3nGz39nXOD
 K7QlUCwOVgbGk8KqZdeOJyDV2QwrU00wBvsRwsjs73ftPNtoW90JaLSx1+vAFpuLPbHo
 5deIlrGKPFPJuQWGe+pHeWcOCwtsnIn0W4h4p9LoSdIvTMSA6FRJfmw5Rjqs/YYhAPH8
 SwNFH1Mh0y6LBgDnNaDP+ZWrwQGRyBWwXm4AjnVGjOksIL/QOLxQsOP0PuMpeQXNlbM3
 QK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782402241; x=1783007041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q5sTg3m/MQSzUCwtbfH6QpyZcpHs7+TlXDrDgvN3LEA=;
 b=fLIh80zLkjW1emFAYxndury/pn2Owc2Vk3nglVxn0mtv0xWvmKRoFBerxjBiDm/jO9
 pgHTDQqolgvGVHHgfGTh9q85zmHOScjODEPO9OtcpZVrNWvpgMkRwG5gHl1NQ0w5166F
 0AWjYLllFchYlH6xaQ4MGd953D+0ap5A4t+d6yo1leroNOGWBI7oNVwyrxZCE/ekiVuf
 kKHs4u4LjnXByfI1zkFytw83y/yD2scEY6UmHGZQf809TVwM9LmcgJWzo5vbJ4nWTwap
 +i6j3SXic2kwHPel2NkLAw6efo/taw3bsfE9JfvR06JQIHEBd7+BBSB6Z5Ao5shvjThU
 f2Ww==
X-Gm-Message-State: AOJu0Yw5FBt4ptNvYgmpn0uNnRiynnal6DgJwVC3yUzMSM6ioAM9TU9T
 URVmsZIBqeXasQvafAdQlMx4D5BfqqXALeYyqiBRYoSeK0vaAAKm7AjM
X-Gm-Gg: AfdE7cng6AMX6sD1rGe9nEVzTnmywxTIPhlT4Xp9zZSKnLRPfBouq5sTFJGXUj0JEyR
 AlZ6Cr6AQaYD4eJyR+MDkP1QW7ZGq61VslKyYj/Xfxw2nk9hlg0rIqh7sTGVQAR35mWtMJZ90n+
 S9KtRCNnF+nKG9i7HYe9gwuT3qV9jtOGjUFmzd9pYMVhahGngryUO4F36kUPV2gzNApvQTirqmB
 CAa780VWoLpmEa0A9K3ruK4y2SU2MzrAbZ3XoyPzuXM2q/mkSOtxBnmzsWezqnVitY/IbY1f+L+
 rnHmgks5mM2atRBanIq45hV1Y1dS3GlCdDB2bq1krzw4YPm54VzqbESKaFT4gc8uxNK0eJ6H4Q/
 cnFrdmfYnyJXwmhKFrnkcDzy42yQ0gdhOMTrEoGVu8VV+z3pFY8xxWsnhtvYA1RBUDyfLV7dGGu
 epwa+y9lfqcMR18fVlIlr8jWInSN9Fu0o/jNcwE3JCf6XumhphybuTAamPFF5sagxlWgiVcm7ip
 SLhAf1LVKAIbDsmizpN0ZbuLkhaQQ==
X-Received: by 2002:a05:7022:f512:b0:139:beb9:fccc with SMTP id
 a92af1059eb24-139dbb49550mr1802168c88.26.1782402241325; 
 Thu, 25 Jun 2026 08:44:01 -0700 (PDT)
Received: from
 runnervmmklqx.mmi2fnf01etepo0d1tf1o4mopb.dx.internal.cloudapp.net
 ([52.190.182.116]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d912197bsm14957309c88.15.2026.06.25.08.44.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 08:44:00 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 25 Jun 2026 15:43:59 +0000
Message-ID: <20260625154359.4083-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625-metadata_linter-v3-1-a1bd491eb506@suse.com>
References: <20260625-metadata_linter-v3-1-a1bd491eb506@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] metadata: add linter for JSON file
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

On Thu, 25 Jun 2026, Andrea Cervesato wrote:
> metadata: add linter for JSON file

> +"""
> +Lint semantic consistency of generated metadata/ltp.json.
> +
> +  * CVE tag values must use a valid bare 20YY-NNNN[...] identifier. With
> +    --check-cve-exists, every CVE is verified against the official CVE
> +    Services API (https://cveawg.mitre.org).

The docstring refers to --check-cve-exists but the actual argparse flag
is --check-cve-online:

> +    parser.add_argument(
> +        "--check-cve-online",

Should the docstring say --check-cve-online instead?

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
