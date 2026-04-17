Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DCDAF43683
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 09:20:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3F7B93E4ACD
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 11:20:58 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C3C13E196A
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 11:20:38 +0200 (CEST)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2BA681A009A6
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 11:20:38 +0200 (CEST)
Received: by mail-qk1-x742.google.com with SMTP id
 af79cd13be357-8d7e7f48499so56582885a.1
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 02:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776417637; x=1777022437; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oGhF9tAKOReC+q2spB2IvpiYWHws0K52iYYas8A+aS4=;
 b=axDrrh8QlSdI0COBJqAAN0YfC+E2O8rTlRjmSWOuR7zgVzmNK9cLJQgqiuPQiKikPX
 8s5pTM2sqUtF+Q7IDJkhVXszC5uSR0hDk4ofvBCHykWwpaU8CAtB3hjXBEdDgo+RlZJj
 p//KZDabdfdBYAiZnl4F7CytNppOArubJqQIHP3evonS8KtMSvJHP/IRoeJWP4YQWlbc
 WBmhFDSmeyrk5LZvZ3IDixHJDzP92mql0rtMosdH3j5ZhTX629Yjzfa45Ab0+JTi77vx
 DoZsXWcDqN+9cjPtRqZ7vJGyT5DwiIsLIGMlaxOzxVH4jqwWV3O0fAxiWeRkOcLTe2q4
 12Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776417637; x=1777022437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oGhF9tAKOReC+q2spB2IvpiYWHws0K52iYYas8A+aS4=;
 b=Eja2GE40AtIbAI8KyvgEjza08w57AxkhbnytfO0SYds/rCAnIFxJIcsj3KVERUJRFr
 jr82bDun1vYns4LORaV3WNYAE/IbM2JB0WnhtsH62gxaUVYv3rnSyXwLb+EcXdM9CSlp
 NX4wKrZEKYFXWoc0w+SzA2fCXoVqgAEboVCEHnnne6yPw9xG/y2pIWkMQptt2vhicEGP
 5ERGWBqcASfZAUEyPXZ4xb+EAeDA2pF1PeKS/VXZKSr4ZZtVO8ZGvAmlTQx4t3zxx1mF
 ibdxvc7VDNFwb3OMeAkpf3nfL3wQ1zUGL2fbdNqFWBeHSfHSAoUDwQc8C/9OZs1ZUElH
 snZA==
X-Gm-Message-State: AOJu0YzoeJw96njX+tav56nwHm7B7n0s1VzyvBHifg4DmwKjv1Dmrfmq
 h+UchQzJeni9mPSwgnKsM8Qd+xx62HjG7RaePZZr5/SeyqFLSxHD4gv2
X-Gm-Gg: AeBDiesvafzgLIiU8cC1hDJ2qQDblTIKelrSVW3wpXHoda1Nt9FBwE2YSzKFRfFYudO
 4bt3OCXDe7CdAbYyjI6Rton3xRxNQVkOZWwYCP5oIgZl+3anVGDmXKOIXXt/9h5QuC6a6bU+ToJ
 KrYLJMbDvSw1vCSPZEzQjJ+2Ukhvs0rsyTtfVXZKS3AQxwXxSW9/p2LHqOz9BpYZAPqqamWhett
 NhZve0cGGUoKcSLPgs1MSDjcpvAB/cWV1stmdAZDN0+hjTk96UcnoUqoyySjm2A6jvccxrH93Qe
 8GSP6mTt6zGV+oH4myF5u3OmfiqxS8CF7sO/sH28T0AizFMlkBz4lTUofEzFZm7r5Xy/z3Eer8L
 2VMIUt9WFv87Kehih4W/0PCmjHZMrb7aef2JmP4RvLHAPm7610WPGGoGRio3gsEb7XIjx5ucTtU
 H0IajmhH/QmSpRr32HNuhWrIfhFWkYQMve1udyW8eOi3xsEJV50Dlu/pidCBnjRU0r1U7opRndR
 LCDkWJaORw9vz6ql+k87CSxh+6Ak32AvaLLQrPiSDiGndxMU7k=
X-Received: by 2002:a05:620a:17ab:b0:8cd:b2e9:8190 with SMTP id
 af79cd13be357-8e78fc25accmr241940885a.18.1776417636974; 
 Fri, 17 Apr 2026 02:20:36 -0700 (PDT)
Received: from
 runnervm35a4x.acrcebrcupsetj21tpkunvq0he.ex.internal.cloudapp.net
 ([20.102.223.151]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e7d69ae320sm82586785a.20.2026.04.17.02.20.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 02:20:36 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Fri, 17 Apr 2026 09:20:35 +0000
Message-ID: <20260417092035.3771-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417085931.331281-1-pvorel@suse.cz>
References: <20260417085931.331281-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ci: doc: Replace Ubuntu bionic with noble
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

Hi Petr,

On Fri, 17 Apr 2026, Petr Vorel wrote:
> ci: doc: Replace Ubuntu bionic with noble

> -          - container: "ubuntu:bionic"
> +          - container: "ubuntu:noble"

> -    * - Ubuntu 18.04 LTS bionic
> -      - 4.15
> -      - 2.27
> -      - 7.3.0
> -      - \-

Clean fix. bionic removal from both the workflow and the doc table is correct.

Reviewed-by: LTP AI Reviewer <ltp-ai@noreply.github.com>

---
Note:

Our agent completed the review of the patch. The agent can sometimes
produce false positives although often its findings are genuine. If you
find issues with the review, please comment this email or ignore the
suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
