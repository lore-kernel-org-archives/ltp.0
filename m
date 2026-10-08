Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 620BCCA600E
	for <ltp@archiver.kernel.org>; Thu,  8 Oct 2026 10:14:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F2C063E49A1
	for <ltp@archiver.kernel.org>; Thu,  8 Oct 2026 12:14:21 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 31F893C2E60
 for <ltp@lists.linux.it>; Thu,  8 Oct 2026 12:14:07 +0200 (CEST)
Received: from mail-dy2-x07.google.com (mail-dy2-x07.google.com
 [IPv6:2607:f8b0:4864:36::7])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 90886100060F
 for <ltp@lists.linux.it>; Thu,  8 Oct 2026 12:14:06 +0200 (CEST)
Received: by mail-dy2-x07.google.com with SMTP id
 5a478bee46e88-3514af07fb4so1129391eec.1
 for <ltp@lists.linux.it>; Thu, 08 Oct 2026 03:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791454445; x=1792059245; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=51WaVaaYdHkK6OH3ggX5Q/uTtIGCxboCXOD0t/znYbQ=;
 b=T6qGrNuaJGI15wO6vNnGPW4mtbaNCA27ASX69fvUBmagH6rb/eeDzRJGqGviaTqnjg
 cnrVPkAXKpbfnz6FR+QZM+i836M8luR7hPURhdsbXkv2rzoUCj/9d43bUBqk+3E+/YFJ
 8fiWPCR/3Uw/gKJFugf8Pip+C1pjRNgLt5LZf0JIewvoIYkMf0EAtpxyHaOYzmOMqyex
 U8Y003BRkBYJbPP2Eg59/58aaFUmfEALwglLvFC4nypPPnHNhOMUI/0n4W4ncUN6hhfO
 NjiVZiQvbB4UOPUVnwzPy/+x2rLZ4ardtwg7TElNgT9IqPK9c3a/5fpVmP1L4WJEnpYi
 dshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791454445; x=1792059245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=51WaVaaYdHkK6OH3ggX5Q/uTtIGCxboCXOD0t/znYbQ=;
 b=RE8g3VDXg1Gsf5r9QXe8lehDJ+Chg7sjPn3o0QVoSyeV2NfgiMgJISBsPg+rgtHZdX
 qXe708MCVso8up2dl4QILV0NX1sJFq6PhVqJZi+7nqCXTjvGZ0thO6v2gzI5mYxx+obE
 Vj1weHrh3i8RpBgQmoi/gSoSO2IR28JABJq94b+iJyif4nqWo69pk2Pa6zkPUVyOhJdy
 vkNDsMeN7DCUEULRMiQ54BIupyLI/w2NEtAMHc2+NlowJzq9owxlG2pxqwQDK4NNmwAN
 tZrQXTNM67pF69GPTtPPu0dIpzjKpCQBtqIfTMAUaKy5/AanQL835t/yo2UDNVHplQlL
 U6jg==
X-Gm-Message-State: AFuF++kV7C6p6eqosPUsMvRqnrcsQA2+Nv/w642ASe1kyPNCrl1BgdLF
 fuPootWgT2qtVmnWR8Y0qxkl6UxprmFRzSMHMX9cRx9cv6ilBjJ+7zLw
X-Gm-Gg: AYBFou0fzUGvAJE04ge7J1QPXk6K6kJNOsCFaFrzGdFk43Ly761sr56mTYwCgsB5JUV
 8R8IvAoJyf+vN8o2p07a7I7om1iCpghDAuKHQv2dNz+wTcUa2wZja9qA2TEhrHhhAwgF70UDaV9
 QkSFpmGRLFmswwvJ8xNOVPA3v6VsKf5vFOT+Dny+UiqyZURHjBHOiBWImdqAuiCufh90KL72tg4
 HaJ5NG0jNm/D1r3CncK2Ts8o2/zSY4rs6q2DNMtz3suivRtV4jovuueEUasgmHYjQlOFT+fqryd
 Obkkdrt6Yh9FWtqGwaWAloZaw0xQORH6xw1DQqpTJQBx2DRBXeiU71MKU9ckDMnM29dhtt0gvux
 Ca0HEeMcdWMp+F2t49wVQAoHiBh6Oduq+oWwTxH0lhw4PMXF/K+V8UHlAC+MsiSOif6BdeYkfhO
 sfPZfyAIwaljOhN5/lQnvxH1QJLhewG4kFEcnuy/byV6YsxLdF3jWoKCGpqnsdMEO14mMR7LINg
 iO05p/jFgha0AO9v4jZPJBTp+jkg8HYj1Dlo/L28U/Jp60cSkppTCOy+QXIFamhzQR6yV2WuvwJ
 OjPIsZtx9yuxBQ==
X-Received: by 2002:a05:693c:608f:b0:34b:34cc:bcf9 with SMTP id
 5a478bee46e88-3515da5dc72mr6382026eec.3.1791454444473; 
 Thu, 08 Oct 2026 03:14:04 -0700 (PDT)
Received: from
 runnervmmprz5.c5dam0qjnfsefkc3bjzldlum2d.dx.internal.cloudapp.net
 ([52.159.247.183]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3515b01ea9csm15441510eec.27.2026.10.08.03.14.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 03:14:04 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Li Wang <li.wang@linux.dev>
Date: Thu,  8 Oct 2026 10:14:02 +0000
Message-ID: <20261008101402.9651-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008052141.129763-2-li.wang@linux.dev>
References: <20261008052141.129763-2-li.wang@linux.dev>
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

On Thu, 8 Oct 2026, Li Wang wrote:
> lib: add module is loaded check

--- [PATCH 1/4] ---

> diff --git a/include/tst_module.h b/include/tst_module.h
> +bool tst_module_is_loaded(const char *mod_name);

Low: Add kernel-doc for this new public API, including mod_name and the
return value. Document normalization, built-in modules, and the current
false return when /proc/modules cannot be read.

--- [PATCH 2/4] ---

> diff --git a/include/tst_kconfig.h b/include/tst_kconfig.h
> + * Called from do_test_cleanup() so that the modules are released when
> + * the test finishes, regardless of the test result.

Low: The actual caller is do_cleanup(), in the library parent process,
not do_test_cleanup(), which invokes the test's cleanup callback.
Correct the lifecycle description.

> diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
> +#define MAX_LOADED_MODULES 16
> +	if (loaded_module_count < MAX_LOADED_MODULES)
> +		loaded_modules[loaded_module_count++] = mod;

Medium: This commit already has 19 mappings, so a valid requirement list
with all 19 available as modules passes the config check but queues only
16, silently omitting three required loads. Size the storage from the
mapping table or allocate enough space instead of discarding entries.

>  				kconfig_module_check(&vars[i]);
> +				kconfig_module_record(vars[i].id);

Medium: kconfig_module_check() can change choice to 'n' for an uninstalled
module, but this still queues it. For CONFIG_MMU | CONFIG_CAN_RAW with
MMU=y and an uninstalled CAN_RAW=m, the expression succeeds, then loading
can-raw aborts the otherwise runnable test. Queue only configs that
remain enabled after checking, without making optional branches mandatory.

> +	for (i = 0; i < loaded_module_count; i++) {
> +		tst_res(TDEBUG, "Loading module '%s'", loaded_modules[i]);
> +		tst_modprobe(loaded_modules[i], NULL);
> +	}
> +
> +	modules_loaded = true;

High: If one modprobe succeeds and a later one aborts, modules_loaded is
still false, so the cleanup helper returns without unloading the earlier
module. Track each successful load immediately and let abort cleanup
unload that successful prefix, not unattempted entries.

> +		const char *const argv[] = { "rmmod", loaded_modules[i - 1], NULL };
> +		tst_cmd(argv, "/dev/null", "/dev/null", TST_CMD_PASS_RETVAL);

Medium: modprobe also inserts dependencies, but this removes only the
explicitly recorded names. With CONFIG_CAN=m and CONFIG_CAN_RAW=m,
loading can-raw also loads can; removing can-raw leaves the newly loaded,
unused can module behind. Track newly loaded dependencies and remove
only test-owned modules in dependency order.

--- [PATCH 3/4] ---

> The test also needs root to load the modules and to run as the
> vsock_loopback transport is not available from an unprivileged user
> namespace.
> diff --git a/testcases/cve/cve-2025-21756.c b/testcases/cve/cve-2025-21756.c
> +	.needs_root = 1,

Low: Root is needed for module insertion, but loopback VSOCK on
nonprivileged ports in the initial namespaces does not require root;
an ordinary nonroot process is not an unprivileged user namespace.
Correct the commit message and document the loading-only requirement in
the test description. Drop privileges for the reproducer after the
framework has loaded the modules.

Verdict - Needs revision

Pre-existing issue: sctphantom's description requests manual module
preloading, although its setup already loaded sctp before this series.

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
