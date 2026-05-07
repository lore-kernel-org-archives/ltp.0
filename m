Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CCA4CD3442
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 09:39:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F1E313E6146
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 11:39:00 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2D9553E2493
 for <ltp@lists.linux.it>; Thu,  7 May 2026 11:38:44 +0200 (CEST)
Received: from mail-dl1-x1241.google.com (mail-dl1-x1241.google.com
 [IPv6:2607:f8b0:4864:20::1241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A25B41000603
 for <ltp@lists.linux.it>; Thu,  7 May 2026 11:38:43 +0200 (CEST)
Received: by mail-dl1-x1241.google.com with SMTP id
 a92af1059eb24-12dbd0f7ecaso1515212c88.0
 for <ltp@lists.linux.it>; Thu, 07 May 2026 02:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778146722; x=1778751522; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SgPafXop8qkEvS45TbzdmT6mouF+ZolJ+TyWsdFf1GM=;
 b=gvEigODTaF7SCd4J7K5+CWNxYWK2Ey3zlTYaKNmIwAI1T3FnrZTlztNDPyU86j4yYk
 A2R6RsNSUw32ufriccDb1IOoq12FpvntT7Ho33+UDRNJqU6hkndUbQ3LdRyzYUuZ/p6M
 U11i5EzfJ0cAvx6KRI2G4H2aLY0d+8+tm6e4/pIeqxOIpu2dozZP8XYm/SJtA8j/qDh+
 9mTqrT6vdfNUQk3pG+EerdIW2uvCrRJreEdRj2mURinWbyA1dLGsVTpR4vUwQCKOAsXM
 2ogci/NakvHANepapFKgHIxU2UGcckVrkCf7lXxerfBNIyUQE7OOaAdnmAxDqx2xIyUz
 NKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778146722; x=1778751522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SgPafXop8qkEvS45TbzdmT6mouF+ZolJ+TyWsdFf1GM=;
 b=i3Gi7LbC1I3N0Ek5geDJerKUEaNzReu3rc2BhSJdAJjR4Pgq4rdmlBQWfv1JwAcNFv
 2HnEmnuoSpUhWAXvRGsrpZ1VZYaQBaChG2Gf+xez0qpU75yTxxB5GT0DjgBrqTbSspCn
 eILqG17RlVqJy7ZPnT0pinw085eXaybnlghIalBErR7koXI55z6oCadWYqWqhdVmM2MW
 MHJpifo4rEvEjld7dne1fafUYume8eoc6qMx6Jenc58NdHz2EeZAICirOOrbFdamwpfj
 IdKkV/HukWB2I2hzWGSBpBz9N35jOx0bUrRdm/udWiGXnj/v4S5Qf6gF9gpE7fA+n6kf
 GJdg==
X-Gm-Message-State: AOJu0YxEuDe+87F6OfLnal79zyeP46RdKTH23r47GacR+h9Gan/orKQo
 eH7oLNxI9W60pFoTdA7bDcjbnsKhQlW4WUa3vJgqmzf8zpYJ/duIj9YOfagBPRoBa+VkPA==
X-Gm-Gg: AeBDievCHsJCEcmLU75mGyYqM2RWpHQ/lBTKVQd1OMhLK3TR4NVO9s10lMCiBZqloDE
 c8yHqfjtztgc18057QI8BbI3QLWDiWr//neSQ0tX+nbBZNYYE4g6dH//rQGJOatpOnTy66Phf3X
 Pep4t11Idn0o3WEzSI4i5XcYx7yVx4aPd8n56CVWkW+4XZbjJdtO5h5jUC5VcW/2C3AVuT4xKn7
 vn4zveymDAFPSqXnUn9eeiskJDard6CJ6uLJNeoIN1ReA1RDlb3XtYpBeUrk0DYubk17qmSWXvc
 nqzFxcz49OikOvqzJt/6puVVX7XGjbOVQ+ovblEV3++1e9KHU1bbkZCRCAtMEZ+GRWfrtHLjQnz
 jmwCPcqHH16MDu6eJZXL1WBaoqrV000rT2p9OMUzZ03m08PUz5dVX7D14EhL7d9sDabDzoRqsXD
 tmfFGbn2aTvxWFk/+8+ESJ1DQ4W4CM/zwNMrYEkkLP3MUJ1jt9jyPuYW9r4Nycb5YC34ZJY6nj/
 047mdot9qgoDN8lBuxudeIZfz+k/MQYSE1yDw4vimSVswXVt8feoG6brNYg2hw=
X-Received: by 2002:a05:7022:ea22:b0:130:a479:7995 with SMTP id
 a92af1059eb24-1319cd3ec60mr3932168c88.33.1778146721932; 
 Thu, 07 May 2026 02:38:41 -0700 (PDT)
Received: from
 runnervmeorf1.zdtlsx14orjuhm1vjuybvnhl4d.yx.internal.cloudapp.net
 ([172.215.231.121]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13202db27bfsm7078151c88.10.2026.05.07.02.38.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:38:41 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Piotr Kubaj <piotr.kubaj@intel.com>
Date: Thu,  7 May 2026 09:38:40 +0000
Message-ID: <20260507093840.3898-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507072238.102543-2-piotr.kubaj@intel.com>
References: <20260507072238.102543-2-piotr.kubaj@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] high_freq_hwp_cap_cppc.c: new test
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

Hi Piotr,

On 2026-05-07, Piotr Kubaj wrote:
> high_freq_hwp_cap_cppc.c: new test

> +	mismatch = SAFE_MALLOC(nproc, sizeof(int));

SAFE_MALLOC takes a single size argument. This will not compile.
Use SAFE_CALLOC(nproc, sizeof(int)) instead.

---
Note:

Our agent completed the review of the patch. The full review can be
found at: https://github.com/linux-test-project/ltp-agent/actions/runs/25487767963

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
