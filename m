Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A09E606A31E
	for <ltp@archiver.kernel.org>; Wed, 25 Nov 2026 10:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mY37x4xD
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8BFF63E91EC
	for <ltp@archiver.kernel.org>; Wed, 25 Nov 2026 11:44:16 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1699D3C02AD
 for <ltp@lists.linux.it>; Wed, 25 Nov 2026 11:44:02 +0100 (CET)
Received: from mail-pj2-x05.google.com (mail-pj2-x05.google.com
 [IPv6:2607:f8b0:4864:39::5])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 912D21A00927
 for <ltp@lists.linux.it>; Wed, 25 Nov 2026 11:44:01 +0100 (CET)
Received: by mail-pj2-x05.google.com with SMTP id
 d9443c01a7336-2f06c2c371aso14348865ad.1
 for <ltp@lists.linux.it>; Wed, 25 Nov 2026 02:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795603440; x=1796208240; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GHovBqFNcfDI6819aLB6FYsXVOv4F23n3gKUUC0jAMc=;
 b=mY37x4xDZ5w5lfLqQtEPsJ+6vhNF812n3ZmG+RjuCrZrB+AYxRNj3vFNqV14VHjCx/
 OyvhitoNnFERhU/uuqGpm2GR4Q90t8OKPhlAcUGQZ/xGOVGwzFvgFTOnvgDcE2NgWs2r
 GyDpnfh30F1/AC6dQFwRitfqT1h0vcMuvLnC4QSsvTJ2J00mo1fa7Vg1vmHb4N1AZA5z
 RjXlngA04Oi/lURpIMmXzMFftBmt3a2y3jktWtp08X/o/0ZIP9ZJdSKk6aKdMyi8ZIlW
 ijO0lPpUo+pD1YDy9CuG2HylUOmaCYtvMDwuovO1baztBv8Xsf6TaFVbGbEFIpqsueEr
 FDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795603440; x=1796208240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GHovBqFNcfDI6819aLB6FYsXVOv4F23n3gKUUC0jAMc=;
 b=TyVq4SukZJrycASXAhzOGaVLyK4ukaazhgrEX22h51CFuyeL6VnE0YMj97ozrEzliu
 CKiudRdqBY3C3HNGHtqbbEUKterTD4v34yXkFSWBhm/523XUaBeNIYZEmHeu8dGiq4qT
 Wxm9R7oFqi8rdkudedJpRjIdctzfLbrVrK+6WrIACZnnt0uPJJr35cCjO9hpv24lLVQb
 8GY/MgnizmzBkzOEdT5HodZijkOfYUhsmlIpHV//IN8xjGrRN0pC3ueVpoiKe/2sCNcq
 8m8Y5CIMc+5oMfuNZb5/rKz//4usohxegPPIza+oF2f4PP1GcY4Qn3mFWBW8RULa1ZaU
 FPHg==
X-Gm-Message-State: APuU4Z/QIRkJEoCQ6PNpn4rUdxFeTEOO4ind+C+OWlBb7C384syDI6+m
 uZjvs+FeBrUQreX7gHQORFcKDae7SxdcsEf7nv7bsw7sjqdx4KB07hyx
X-Gm-Gg: AZFdTZeCnlZT42QMTJIbZcv+BzS7EZG8cjMicSiEOT1efq+V1tACjCGTubtroS0uBdB
 aAEa+B5gqI7+GbW+wih70+QYGmc/t0WiHCmE3BcB1fEOVshlOgbn7xZ74Srjp4IVC6djHUnMZxN
 YaqUoJSmewASkSh3vCCth8EzZwneFMS6/FejzFMVI/Ijr6LbR6wDiDH+vBOekwq2eGmKjGkl/gO
 7KyTsCKwYUYbO0RQVbM9GMfGTlgqYquRwpZYJWXuvhQYPFPfvrYoIPW4MrNBzOoioZ/szaFgxC0
 73iWIHKNrlOO9dAoSq7qjaROgo4qeHAz72Il3YRmVjZhKbIf9XovhO0fPrQzLrbdaRkeExdZKdX
 g9gF43M5xOYR7Kwa2GZEfZwD1WUAkggrDRAZZnIO/HU9yom7DOqK92UwCbHn4vdpisX9B29tyrg
 FWpuemYL6ouPhy2FySbI4v4QkbiiIkcWAoK93XpvuOwaopmOFuMZzmV2jdWv7gN86JAuyd2Nzjz
 H9XgJYcDmUyPb2bRGK96rU0A/BeU+jrhoSlKZ/nKtX6guRFIoyCRhzHMKQKTGSThfi5H7POtesm
 IB2z1AJpwVKY8zkyHnrOQnF398w8bwhDbFG48GGuAOUhr4zqRknZwzPqTZfCuXHfvKcwvttAbwG
 UvnKIChD/NLElCRYqKftIhPhGZRX1eqC1k0YDt0UIhA==
X-Received: by 2002:a05:6a20:9183:b0:3fa:db87:fc48 with SMTP id
 adf61e73a8af0-40146119185mr19537485637.0.1795603439599; 
 Wed, 25 Nov 2026 02:43:59 -0800 (PST)
Received: from
 runnervm0hi8g.jew00n1lzpyu1c04tn2rghylee.dx.internal.cloudapp.net
 ([20.57.214.155]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c87334890csm8845360b3a.33.2026.11.25.02.43.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 02:43:59 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Li Wang <li.wang@linux.dev>
Date: Wed, 25 Nov 2026 10:43:57 +0000
Message-ID: <20261125104357.4174-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125030529.907385-2-li.wang@linux.dev>
References: <20261125030529.907385-2-li.wang@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: add module is loaded check
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

Hi Li,

On Wed Nov 25 11:05:26 2026 +0800, Li Wang (Hieco) <li.wang@linux.dev> wrote:
> lib: add module is loaded check

--- [PATCH 2/4] ---

> diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
> index f055c2e5f..8b4d0e2ef 100644
> --- a/lib/tst_kconfig.c
> +++ b/lib/tst_kconfig.c
> @@ -178,6 +186,12 @@ static void kconfig_module_check(struct tst_kconfig_var *var)
>  		if (strcmp(config_module_maps[i].config, var->id))
>  			continue;
>  
> +		if (strchr(config_module_maps[i].module_name, '-')) {
> +			tst_brk(TBROK, "config_module_maps[]: module '%s' "
> +					"must use '_' instead of '-'",
> +					config_module_maps[i].module_name);
> +		}

config_module_maps[] still contains {"CONFIG_CAN_RAW", "can-raw"} and
{"CONFIG_CAN_BCM", "can-bcm"} with hyphens. When either option is set to =m,
tests listing CONFIG_CAN_RAW or CONFIG_CAN_BCM in .needs_kconfigs (such as
can_filter, can_rcv_own_msgs, and can_bcm01) will now abort with TBROK here.
Update those two entries in config_module_maps[] to "can_raw" and "can_bcm".

--- [PATCH 4/4] ---

> diff --git a/testcases/cve/sctphantom.c b/testcases/cve/sctphantom.c
> index 83834b848..bdbe40286 100644
> --- a/testcases/cve/sctphantom.c
> +++ b/testcases/cve/sctphantom.c
> @@ -205,8 +204,6 @@ static void setup(void)
>  	};
>  	const struct tst_path_val *sysctl;
>  
> -	tst_modprobe("sctp", NULL);
> -
>  	for (sysctl = sysctls; sysctl->path; sysctl++)
>  		tst_sys_conf_save(sysctl);

Now that the sctp module is loaded in do_setup() before .save_restore is
processed, move sysctls[] to .save_restore in struct tst_test; calling
tst_sys_conf_save() inside setup() runs in the forked test child process, so
do_cleanup() in the library process never restores those sysctls if sctp was
already loaded. Also update the top-level doc comment in sctphantom.c, which
still instructs the user to run "modprobe sctp" first.

> diff --git a/testcases/kernel/syscalls/keyctl/keyctl23.c b/testcases/kernel/syscalls/keyctl/keyctl23.c
> index cf90210d2..adfb1197a 100644
> --- a/testcases/kernel/syscalls/keyctl/keyctl23.c
> +++ b/testcases/kernel/syscalls/keyctl/keyctl23.c
> @@ -6,7 +6,8 @@
>  /*\
>   * Test ``KEYCTL_RESTRICT_KEYRING`` builtin_trusted of :manpage:`keyctl(2)`.
>   *
> - * Requires root (CAP_SYS_MODULE) to load the ``x509_key_parser`` module.
> + * Requires root (CAP_SYS_MODULE) so that the test library can load the
> + * ``x509_key_parser`` module.
>   *
>   * [Algorithm]
>   *
> @@ -16,7 +17,6 @@
>   */
>  
>  #include "keyctl_common.h"
> -#include "tst_module.h"
>  
>  #define PAYLOAD		"payload"
>  
> @@ -89,8 +89,6 @@ static void setup(void)
>  {
>  	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
>  
> -	tst_modprobe("x509_key_parser", NULL);
> -
>  	ring_builtin = SAFE_NEW_RING("ltpkeyctl23_builtin");

keyctl23.c sets "CONFIG_X509_CERTIFICATE_PARSER=y" in .needs_kconfigs, which
rejects CONFIG_X509_CERTIFICATE_PARSER=m with TCONF before
tst_kconfig_module_load() is reached. Change the entry in .needs_kconfigs to
"CONFIG_X509_CERTIFICATE_PARSER" so modular x509_key_parser is accepted and
loaded, or drop .needs_root = 1 and the x509_key_parser module comment if =y
is required.

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
