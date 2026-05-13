Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2719BCD4851
	for <ltp@archiver.kernel.org>; Wed, 13 May 2026 16:23:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 94B3A3C24C2
	for <ltp@archiver.kernel.org>; Wed, 13 May 2026 18:23:20 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C2F933C0D0D
 for <ltp@lists.linux.it>; Wed, 13 May 2026 18:23:01 +0200 (CEST)
Received: from mail-dl1-x1243.google.com (mail-dl1-x1243.google.com
 [IPv6:2607:f8b0:4864:20::1243])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9ABA11A003D4
 for <ltp@lists.linux.it>; Wed, 13 May 2026 18:23:00 +0200 (CEST)
Received: by mail-dl1-x1243.google.com with SMTP id
 a92af1059eb24-1329fc4bf77so4613968c88.1
 for <ltp@lists.linux.it>; Wed, 13 May 2026 09:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778689379; x=1779294179; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hic9nJnArTaYM79CWLT7Tnp7Cy+dAT/B/6wNCbXaiZ0=;
 b=KmWmIJKi0ohDvCxwm6phSEOcrTyTUBWxTrT1XsjbogHcoBW7P8VLra2Khnc2C248c7
 N0s2zKeIS9qZYrscYMvcVOonhg1uezA5Scg5QeJ02sfj/csLK4ISOtiPBUYvQcRP/7XW
 ZnpUbvLL9z+1eY3ghJuIc2CydVCLBgMllGBtUNmPH+THRNlXpV2amAMAk9um2QAnHGc8
 yFHgO0ujXoxEivOPpxUQ4kjfwqUNrUGI0EZo6u+UMFVvmER/iWGru5RHDEU7mYxjS+B9
 H6hLwipaiupS1W9l8b3Bq1hLYl91we+l2ZixYcli7Ty1y/qsrAg4q3xc32wb1yBRc2yQ
 LgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778689379; x=1779294179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hic9nJnArTaYM79CWLT7Tnp7Cy+dAT/B/6wNCbXaiZ0=;
 b=QE7dVckeUH2m8qsCaL9Lu2DgAQIU7u0qhfWbt4eisb4hpLuGTf8Bv3cZqx4QsPiLll
 kXFeYNsm+RLlVauWyepaXy+ASTy16wwk+yT8+oLDHEc41SLiempT8MjvE7P2Ft8IAHrl
 6XRGzCt6Qwxj8vvaBMMaDDxKTplhgepGW8bPvpqSnCq8hEcJc7M7gNTr0PgqAE0DBoiH
 /Awx1ADeM/ARhmSorxhn75VjxSSfaiUr+dp6nw0eVn1TR0nMalkjJ234LVZnHH7RWzvp
 ElvspMkLK8kElsjCJDLObdKw8jYkZomGGK8RJSVPoX93DCiV2SbFm/3J4o/Z2WcULHqs
 de6Q==
X-Gm-Message-State: AOJu0YxquJIRPOC4HCHWZ83zaex2Pu9yII5yhIiCYiX0GucC3wYq6ZUG
 8neNw6WaI3bVHt0hFa8Uk4WYqCtH9ap+UZdKzJm46grw9KbGNDWZvMTk
X-Gm-Gg: Acq92OFswsWLbB39wBQEoImb2RiAh/U529v9jKJidE2onsrYL/IioM8wIt3GoWfz3j6
 XxV4cOp30Xzl2TzcxdY7EC2fkEz67RnXpSz0fqNAG3vJmOWVNqCYk/p92V+spw7f0EYBQtioOks
 /N3CiZm6e698GTyBEonayXQvoLjKwoBRj4UTN6FZKyipK/p7KV9OOQbCGou+tF7LS8Woozrl6rU
 x5l41tXA8Z9zDiYbaHI2YRE4b9Bqer+zo/qTRIMb0TvT4CNI/NGc/Hfz41vir9e0tbJ+5r/nPEl
 5wZIJZaIH3RP1kM/t9fOGV0QHylR7nF0MXeteu2N0WGiOPiW+Z87C2yTpmFBN5cNxD8fSB2LD+N
 W3ErKvkwAnlpSyvkZUtvpczsfs0iWSTPCh7eiKNvXkfwGj7p2JtvixeNkw2CC/6i10paj8bqj6i
 oMW06BthFtvNATb1IKgJpfK31bhuKHP9w0NThqNxYvQY4QUR1zDl38HZ9MonpKAgFAvpXOpQbXq
 UhkXGgzHVxeQjUGbwAkRLdQfCLOvv8d1Sw6HXg=
X-Received: by 2002:a05:7022:439d:b0:128:d34a:320f with SMTP id
 a92af1059eb24-1342ef43ae9mr2872720c88.12.1778689378400; 
 Wed, 13 May 2026 09:22:58 -0700 (PDT)
Received: from
 runnervmeorf1.w42nivuh1ygu3fj3od5gocisve.yx.internal.cloudapp.net
 ([57.151.137.33]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134b4e153dbsm2192841c88.12.2026.05.13.09.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 09:22:58 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Wed, 13 May 2026 16:22:56 +0000
Message-ID: <20260513162256.3968-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513134948.77923-1-pvorel@suse.cz>
References: <20260513134948.77923-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] checkpatch: Pass git root
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

On Wed, 13 May 2026, Petr Vorel wrote:
> checkpatch: Pass git root

> -CHECK_NOFLAGS			?= CHECKPATCH_CONFIG_DIR="$(abs_top_srcdir)" $(abs_top_srcdir)/scripts/checkpatch.pl -f
> +CHECK_NOFLAGS			?= CHECKPATCH_CONFIG_DIR="$(abs_top_srcdir)" $(abs_top_srcdir)/scripts/checkpatch.pl -f  --root $(abs_top_srcdir)

Note: there is a double space between `-f` and `--root`; consider collapsing
to a single space for consistency.

Reviewed-by: LTP AI Reviewer <ltp-ai@noreply.github.com>

---
Note:

Our agent completed the review of the patch.

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
