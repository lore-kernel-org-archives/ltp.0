Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 649B9CC6B2F
	for <ltp@archiver.kernel.org>; Thu, 15 Oct 2026 09:02:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F7E73E62AC
	for <ltp@archiver.kernel.org>; Thu, 15 Oct 2026 11:02:25 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DAE453E1D5D
 for <ltp@lists.linux.it>; Thu, 15 Oct 2026 11:01:51 +0200 (CEST)
Received: from mail-dl2-x08.google.com (mail-dl2-x08.google.com
 [IPv6:2607:f8b0:4864:38::8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4FFD210004A2
 for <ltp@lists.linux.it>; Thu, 15 Oct 2026 11:01:51 +0200 (CEST)
Received: by mail-dl2-x08.google.com with SMTP id
 a92af1059eb24-1379d236149so721461c88.1
 for <ltp@lists.linux.it>; Thu, 15 Oct 2026 02:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792054909; x=1792659709; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1foD37Npubmoy5AbnQeS5oV2bMoypmHaKbuB0xkK9i8=;
 b=GGQFkosgtdInc8C0hH0y10QGk7UmoJmQGev6QLRce02XHnvr11XwDviPE8WrfXg0Q9
 YOyMA5skFIVlPd9Ag78DHecYIkufWvGMyQYXiE4ohacZRDE3jB0zWbIL76cIuCzCzraC
 kQBDXDR8aDwFtcn10czneOIwAKtTNFg27FtLw7CQAbwNmRaqvwDM/ZCCY2WX2Li/9AuE
 dWRmWh8CvsoD8ua8KMRNwBnrpU4323I79LgN/Cme4V0gZwIV1m3eZNX1pCLoJopHOPaT
 JQwqoUudfYMOdayX+GHYx21yPeWIPHMKhetjj76dabgW3e11089iLUXE/s7IVmSLZVXE
 JGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792054909; x=1792659709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1foD37Npubmoy5AbnQeS5oV2bMoypmHaKbuB0xkK9i8=;
 b=tkqhh8WxtTlpPBPhliXJ/EaKRqhkbgNjm/igDToPitGRlrk6iSXAavvRWdOZMpFFV3
 w/HVxSU8CB7mFJSCMKeYlDM4DrMwyQRPV25dQvrv48mpzMTdi5p09NHN8kW2Sz2cxm7j
 kKnQPa88jeNk+AgFTFSId2ctK0xMEig/m5FR1T/7P8ogpYPJloPgIk/kLqXdI5zQ0Oir
 j+AldE/QSB66Axyu9letqlYkWVrFFt97pVv34Qe1ErwzaJzcDo/U/TP8a8Ui5w/Esums
 8XKus+zCtrp8U1EuPGaqbvmM1WU/2UKysEdyw9Tn1OhtfkUW/q13oKwozdzmH8romdOo
 momw==
X-Gm-Message-State: AFq9FYJh3CI6RI4u9fNDf9Thru0kQnptb++/ZR0HlxqXydsPFTihzjbi
 PuQmCTg0UlOiQJCe/KhqmBq6uhpOdjLixEtBFE4fL3ZRCyrAWcts7S2k
X-Gm-Gg: AYBFou1aGQvecy4BVMKr1PC5zCtCngvXOoqjWLWxacoJQhIJ4m9rYzE27JUfCQp3/++
 EVkTE/ip3ZXDhbGCw18UYouPMdGF4nOPRUdT7TWvV2EnMuAqFViCxKeta88xq6rYgHG62OS6IkP
 szo6YWmn78tAQJ7GIDOmPhuftXm5GooPlUTk6XVBXgVDR4ZGjyC7KuFCfTMLa5oLU+HEqxEY+PV
 7ExByPrw668J92f4pFnGg8PESgj3VanJcduKlF7oSj0rZskTcdg5rVkvCBlwj48L5kulssQFrrg
 yWosmNZtoM1FP1t6poCAoL0rzLMK34zxQVM3iJcfsQpsahMI1d8Dx5VzaYJYk7m8IcbWSqtx8Q0
 X1mkCYtNicQ8qEINiYWnyHc1c7eLuAv1UQiu0npzHOZxSFUG0n8JYE2Hzwv33CkcFFaOLPGLX6g
 kiVBp0j3nIuhxx8VPiHNdg0CgJDrnyJWBZblK19b9oikiWGGZtzVWloT9oGS9BzlEqOs35jF857
 J/0LmuY/fxfAVYdLo9ydVYa2xwPpSqKrn46Y59jQ3r3vEM59ZkYKmQ1E+E5+vCyMIhqOxA5fYrO
 emOGtIyLX52gEYsfcB1fslY=
X-Received: by 2002:a05:701b:230c:b0:14a:51c8:ea06 with SMTP id
 a92af1059eb24-16a5fe7c17dmr26993716c88.29.1792054909133; 
 Thu, 15 Oct 2026 02:01:49 -0700 (PDT)
Received: from
 runnervm8k3b6.vlhbw3y3jgde1kfjxwvs020s1b.yx.internal.cloudapp.net
 ([52.161.182.114]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a1becefdsm53961788c88.7.2026.10.15.02.01.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 02:01:48 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Li Wang <li.wang@linux.dev>
Date: Thu, 15 Oct 2026 09:01:47 +0000
Message-ID: <20261015090147.9591-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015075812.184811-2-li.wang@linux.dev>
References: <20261015075812.184811-2-li.wang@linux.dev>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
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

On 15 October 2026, Li Wang (Hieco) wrote:
> lib: add module is loaded check

--- [PATCH 1/4] ---

> diff --git a/include/tst_module.h b/include/tst_module.h
> +bool tst_module_is_loaded(const char *mod_name);

Low: Add kernel-doc for this new public helper, documenting mod_name,
hyphen/underscore normalization, and its return semantics, including
built-in modules and failure to open /proc/modules.

--- [PATCH 2/4] ---

> diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
> +	for (i = 0; i < loaded_module_count; i++) {
> +		tst_res(TDEBUG, "Loading module '%s'", loaded_modules[i]);
> +		tst_modprobe(loaded_modules[i], NULL);
> +	}
> +
> +	modules_loaded = true;

High: If a later tst_modprobe() aborts, modules_loaded is still false, so
do_cleanup() skips unloading earlier successfully loaded modules. Track
successful loads incrementally and make that prefix eligible for cleanup
before attempting the next load.

> +		const char *const argv[] = { "modprobe", "-r",
> +						loaded_modules[i - 1], NULL };

High: modprobe -r also removes unused dependencies, including pre-existing
ones: if can is already loaded and this run loads can-raw, cleanup can
remove both. Track ownership of dependencies and use targeted removal so
cleanup preserves modules that were loaded before the test.

> diff --git a/include/tst_kconfig.h b/include/tst_kconfig.h
> + * Called from do_test_cleanup() so that the modules are released when

Low: The call is in do_cleanup() in the library parent, not
do_test_cleanup() in the test child. Correct this comment and the same
statement in the commit message.

--- [PATCH 3/4] ---

> diff --git a/testcases/cve/cve-2025-21756.c b/testcases/cve/cve-2025-21756.c
> +	.needs_root = 1,
> +	.setup = setup,

Low: Document the new root requirement in the test's description block:
root preloads the vsock modules, then setup drops privileges before running
the reproducer.

--- [PATCH 4/4] ---

> diff --git a/testcases/kernel/syscalls/keyctl/keyctl23.c b/testcases/kernel/syscalls/keyctl/keyctl23.c
> - * Requires root (CAP_SYS_MODULE) to load the ``x509_key_parser`` module.
> - *

Low: Remove keyctl23's remaining .needs_root = 1 alongside this explanation
and the load call. Its CONFIG_X509_CERTIFICATE_PARSER=y requirement means
the automatic loader has no parser module to load, and the remaining
operations act on the caller's own keyrings.

> All four tests already declare the matching configs in

Low: The list and diff contain five tests, not four.

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
