Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ABABCC6B1A
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 08:08:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6714F3E559C
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 10:08:55 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD31C3E2AFC
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 10:08:40 +0200 (CEST)
Received: from mail-vs2-x03.google.com (mail-vs2-x03.google.com
 [IPv6:2a00:1450:4864:3a::3])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 44E121A00A25
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 10:08:40 +0200 (CEST)
Received: by mail-vs2-x03.google.com with SMTP id
 ada2fe7eead31-7c88b82215aso156429137.0
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 01:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791965319; x=1792570119; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Thy+pyq0iQrc4ABFN4L4juqTTeCqf/lkDc5EO3F3yUY=;
 b=cuCgCdkm0Yx7tEyefyltbrkroD+A9b+fFSnPhmlYYOIb2QPjASFoJQu9/8aYU57Lzf
 uIcj7cK1A9zVmwfWbZ7PBOsi+3aD+9zJ2lEFNjKVFD8WNZIATPTx8qwZ7++71c2K2Cki
 iRAV/rvxCCLMta7Al3vhiewEdPSfQGvwr9vJI9H6qwGfPS0OsWIkd3zWRQPp0UYqDOs4
 8viJbmjeSzsszBg8LxV9I5vZ/BOon63BFeaeo/saOWhHIUZVNPI0w602N48KSRr40/1q
 2uwhnvDk1+qeg9YttuV90ooCEWgy3DCpbcbMtSPjuduPLLb5Ff/b4UHuL0h7lVlucN0h
 Nb4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791965319; x=1792570119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Thy+pyq0iQrc4ABFN4L4juqTTeCqf/lkDc5EO3F3yUY=;
 b=aNhuM5Ab9FQBBlDRQn2uD3gH58skas5+dB/h4Ygrhlb+125/8JqZqb3/rduSaN8U+k
 Wu/d/2NbUzhbCwAyChBZxf7WW6/jS29DEW0ZhZyP1fu1acD1NyswjVs2Kc3b/1Rr5dFJ
 drgiy/d4vbadr5dXN2gCE09Db8NQUBJ2slnbBA+TVolCdbSm6ITYckW1J2FcpJrRvajh
 xG5jR8ApfGyHAkzaq803AuqdLaskf49ABDhAaje1MoSkYcLw8YN7dUzngrExlrcPQXBd
 cC+MjH8YuT6x9jVI5S/LoDZL4USpRiWPX1zeO4teJse1qjXLHzs+WGCvXAHQU+blYZlh
 rAaw==
X-Gm-Message-State: AFq9FYIOUtwSoLmN2vWZIawPxdbXsNLLwZ92gIviMXrhipaDzaK1veWt
 sMcfCDFOeYwfvJZV4+4xNMWXgxeRCjcxMvOAkFedC/v0tEWbhW7rARP4ow4cBveqGqw=
X-Gm-Gg: AYBFou1/4FNCcYawCfxf6XNo1brSDLHlEg7pKK8+YrgUCW8OAtl89jpUyTIJ0PZM5Nn
 Ja8pS7IZQCZErJ0PKNmuNV3A6ZWjmMgIYf1usw/pHcZLhnrgzhhAckO1h3TTF6v7XbuyzsJ1Y+e
 ltshDLJ+74kDMF6PP503AnUp1zI01mxNpq3NUM06ftIUopZtr4aJWQAbfGLeAT2KwVwoY5j6CBD
 fzSjexDkw/zA3bOMiPT2odMvL0A5UtOjz4vh/S6vWXwIivQIvqobLASpGA4fmyAtE6UVUmyMRwn
 2nzKsnZbRM5Q/o0/Vgk23DmoDzp4sBxpDDUuLrHowvXJYi4o1mBACTyWRh8dv82O4tUwRZhzm3f
 jrgDzUqvQU0NNFoIbIFL/I15CHnwcyZC4xdspBMHogwy8eArv4PixQVYzvjHSM6ypnZN14ki22K
 t1iQKKDe+Kjud+LytMKl9fDmxIKgCQeOnAdGhrFS3UExeVOm0a/g4WMOqUHQQowNecKm1lxA5z2
 q0vlHNuIijD1/miPwkhRvKYVnmpDElyRkMtSEnMIek/UcpdoXM9MFUxC097NiyYgrNrCQPtFCXj
 v32iN6n85Q==
X-Received: by 2002:a05:6830:b12:b0:82a:8e81:f619 with SMTP id
 46e09a7af769-83094a8b5b6mr15137334a34.8.1791963700253; 
 Wed, 14 Oct 2026 00:41:40 -0700 (PDT)
Received: from
 runnervmmprz5.g2xgy4tnphle5phui2zj3tsuud.jx.internal.cloudapp.net
 ([40.74.231.19]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-83039076dc3sm15794845a34.14.2026.10.14.00.41.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 00:41:39 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Li Wang <li.wang@linux.dev>
Date: Wed, 14 Oct 2026 07:41:38 +0000
Message-ID: <20261014074138.9547-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014061202.56362-2-li.wang@linux.dev>
References: <20261014061202.56362-2-li.wang@linux.dev>
MIME-Version: 1.0
Subject: Re: [LTP] lib: add module is loaded check
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

Hi Li,

On 14 October 2026, Li Wang (Hieco) wrote:
> [PATCH 1/4] lib: add module is loaded check

--- [PATCH 1/4] ---

> diff --git a/include/tst_module.h b/include/tst_module.h
> +bool tst_module_is_loaded(const char *mod_name);

Low: Add kernel-doc for this new public API, including mod_name,
hyphen normalization, the return value, and how an unreadable
/proc/modules is handled.

--- [PATCH 2/4] ---

> diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
> +		tst_modprobe(loaded_modules[i], NULL);
> +	}
> +
> +	modules_loaded = true;

Medium: If one module loads and a later modprobe fails, cleanup sees
modules_loaded == false and leaves the successfully loaded module behind.
Track successful loads incrementally so cleanup also handles partial
failure.

> +		const char *const argv[] = { "modprobe", "-r",
> +						loaded_modules[i - 1], NULL };

High: modprobe -r also removes unused dependencies, including modules
that were loaded before the test; for example, removing can-raw can
also remove a pre-existing can module.
Snapshot the initial module state and unload only modules introduced
by the test, rather than recursively removing untracked dependencies.

--- [PATCH 3/4] ---

> diff --git a/testcases/cve/cve-2025-21756.c b/testcases/cve/cve-2025-21756.c
> +static void restore_privileges(void)
> +{
> +	SAFE_SETEGID(0);
> +	SAFE_SETEUID(0);
> +}

Medium: When root starts with nonzero real/saved group IDs, setegid(0)
fails with permission denied after setup drops the effective uid, adding
a cleanup warning to an otherwise passing test.
Restore the effective uid first and restore the original effective gid,
not an assumed gid of 0.
Alternatively, omit this restoration: module unloading runs in the
still-root framework parent, not this test child.

> +	.needs_root = 1,

Low: Document the new root requirement in the test description: root
loads the modules, then the reproducer drops effective privileges.

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
