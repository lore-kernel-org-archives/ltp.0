Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F3D606A31B
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 19:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MGoNd6cq
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 273ED3E9ACA
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 21:02:26 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B9E83E7500
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 21:02:08 +0200 (CEST)
Received: from mail-qk2-x0a.google.com (mail-qk2-x0a.google.com
 [IPv6:2607:f8b0:4864:34::a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F1BE81400B6C
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 21:02:07 +0200 (CEST)
Received: by mail-qk2-x0a.google.com with SMTP id
 d75a77b69052e-5365ff8db40so7581cf.1
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 12:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792522926; x=1793127726; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WROg+3+Z95nWztkudBPBh+RIXiS/MeKtSM5EgUnnGnI=;
 b=MGoNd6cqXpQV3eU5jTH+pcRhvpSsBW67Lm5OUTS8F//cvYQptibFHXS+xCpO0hDsIc
 CQvKH0JEZzLHEHME93d0hPIAEnN0tWH4gDXgrVI8/hwExztWIDFIRP67Az/QpWlL2JeT
 L53GyaRgW46izPzn3kjwgrsQobxEgSLh3gKoBz3TiOLqIbhEIQA3oHWx2/qUQzM78OgS
 tjo1/jC69Geu9VkMqpGalvo4JldgTvGvftzlF/7zQ7fUhlXg5BESbGKwiDNqBnEbWjoK
 3mSzTulokroNJNLARnVbgwqcy0AUnwocnXyg+HGW7XJq/qbFCP9pRSTeXcZ92fqDhR3v
 Md0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792522926; x=1793127726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WROg+3+Z95nWztkudBPBh+RIXiS/MeKtSM5EgUnnGnI=;
 b=wNakhYM5az2OQ9tIKKa0NdWEU5zK5vRmmrPWFgOTqkngb8G+LJ0Kq0IGSxXGmtt/k3
 0akhkFHaitFlSpZRRHa/2Sx76GhgBbr08CjJGAl3yCLWQMIIBKhsFuFhk3JSGr0Z6D4K
 aPzP425LXBZ6a72bKOCUJUtcGM59mrmC+DZK2Z3DPP90pbY0ygRRZ3kZi9Ynh0HquToj
 v2mWbyYjEFmTnrP+0LRxUDfuES3qX8Wo3pVYt7V+wrw8zhiD+hu19XMKhH7LpuTPZR8Q
 FM6LbYMwZ2IVZg9i5aQttayUBssukLoNJIg6zrV5v4zjaxYXU8sStGpfc1O0AgoL3/s2
 W9Bw==
X-Gm-Message-State: AFq9FYK4I7IyIh6SS04CxE0ihvxPYXwaINLKAm8liproTZJ11QVGgcEM
 XhP6E0WBAf9ZXyArtyZcozp3i4xSEe3ebw7Y84RKH/NAUL3azydwaexgghKKEc05+YM=
X-Gm-Gg: AYBFou0afPd/HKR5kkqpQdKH3QA4cAbKkPLBCgxl+KzDWwBo0v/tVC6ej+IRNsDeta0
 bentNrp6msOPC5dH+eixt9kt8bYSwplX2SnWfa67srn8P4R2vNZQiLQx5InjP0fo+wK5JJN620e
 oSprNldWq+laLluktO5wRGkv6K7Uu9b2fU7AwTtK8O1XqhnUOW8/9+CJH8ue0055Pg8CEqhHOH8
 RyyBe++VqAQaUyV+z4sWcPVAhKI6VleTyDbQBnRdz1Bo4Y7mxFCUx3t2dMVbg5TtqEDcfDbbFgv
 Ww8E/nyAavuD+iBLaNJx0BeC0KBtqtHpRX/UnKttZSXvGCMsatbchD37+d9r/m341eO1hXbAw/N
 n8f1XOSEzPfKeHjUhD/q0TfBBHjI+VQUHkxvf8j7oN+dyfqZkXHd8p51219lEkBoaab1WdS4ayt
 SnRC6eujKYiO/efMpnV6CFZ8FXG8mBh7Q7iYyFeddYmGON1zYTZLnIftJ3bbq/IGI4Fagy8jsuT
 /lCf+23WH3FkTscHOT2r3DvJ43Hs/Ncb2SdMg2ijsNovXSy5llZTfpKEgPm4GRi9eLs3lTEnDrA
 h/PCbEBRcg==
X-Received: by 2002:a05:622a:1f16:b0:533:2ef6:d98a with SMTP id
 d75a77b69052e-53645fd03afmr181000081cf.29.1792522912625; 
 Tue, 20 Oct 2026 12:01:52 -0700 (PDT)
Received: from
 runnervmxehtw.kq3a3bje330unktw3o5pvf4ash.bx.internal.cloudapp.net
 ([20.55.47.115]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53698bd5b4fsm2849751cf.26.2026.10.20.12.01.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 12:01:52 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 20 Oct 2026 19:01:51 +0000
Message-ID: <20261020190151.9420-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261020-pwnescape-v2-1-f0669e990410@suse.com>
References: <20261020-pwnescape-v2-1-f0669e990410@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] cve: add pwnescape reproducer
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

Hi Andrea,

On Tue, 20 Oct 2026, Andrea Cervesato wrote:
> cve: add pwnescape reproducer

> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "6785011f8b16"},
> +		{}
> +	},

Add {"CVE", "2026-99999"} to .tags in testcases/cve/pwnescape.c.
Without it, metadata extraction assigns only the regression group, so
CVE-based metadata selection and the generated CVE catalog omit this test;
the runtest/cve entry does not populate that metadata.

Runtime verification was blocked by unshare(CLONE_NEWUSER) returning
EPERM in this environment, before the forwarding behavior was exercised.

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
