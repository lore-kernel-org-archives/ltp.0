Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DF1606A324
	for <ltp@archiver.kernel.org>; Mon,  2 Nov 2026 08:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cH1ePIOF
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D41BE3E972A
	for <ltp@archiver.kernel.org>; Mon,  2 Nov 2026 09:27:16 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 36E3C3E17E9
 for <ltp@lists.linux.it>; Mon,  2 Nov 2026 09:27:01 +0100 (CET)
Received: from mail-dy2-x0b.google.com (mail-dy2-x0b.google.com
 [IPv6:2607:f8b0:4864:36::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C5C29200741
 for <ltp@lists.linux.it>; Mon,  2 Nov 2026 09:27:00 +0100 (CET)
Received: by mail-dy2-x0b.google.com with SMTP id
 5a478bee46e88-369f126a526so3595272eec.0
 for <ltp@lists.linux.it>; Mon, 02 Nov 2026 00:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793608019; x=1794212819; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TIzHDspUzTdvWYrEaq1GYfeRj2sgG1J5eAqAChOkR+c=;
 b=cH1ePIOFBaskeU18KU6xVJzIVh/6J0mZzK8q5blHmTSGwi1GP7NFJ2ttfP2CoYq7cQ
 +hnzTDg2dLXWe35izXt19dn5EX8CziFUSitNAt7MAa3F1gwoz60mrxrVXjhkY5fLD2Ab
 SvF9kpDwCf29WOF9cd1gWnUuSeqi9xR1SwViG1fqYBkEzAU93P9qoi/qYWqbtjdgGUY7
 YAhU1VkEcdZN29QHCK9HdRhfBqH9o0m6dZMu58G0SzWP7a4E6qdVgcHHZ4OiQSrWMBS5
 I6wAO9DICMr0MbaaKiZqNo8bsLq5Z6GWWboqdUjL2GhEcso09H5Q8P2KZOoTC0pbjjLL
 kr+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793608019; x=1794212819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TIzHDspUzTdvWYrEaq1GYfeRj2sgG1J5eAqAChOkR+c=;
 b=V5+Hv1Yl/nybd4L03lZ62SU3Fv861BU9RlJ+NBsBo4lv6vUDt/d2CIGjesjfJf9nu7
 ZnFcRZWm45ySvzYDOIigQiTFVM1pj5GxIJPhgyb58JNGGlTJoTOTEaWop7MmNldVOy6u
 EPrK+MAsxjtnChLsr6Jtv7+BxRYGPAOSDqeZP6MFPNeQge4n6RBGYVWU3h0tD8EW0ZYf
 d2BPavNRfBUEiinon/o8/yc9j/wHBnh0UKNJfnTpn8mw3rcN3V/MX2+fs9Vq93P8a4AN
 wRVQK1pQQ77FJgXLDkdSOptOqQCzzCZqG7dnnm9EuBLMFu6xoXoFqNBnYMq81vocuuxy
 Q7Gw==
X-Gm-Message-State: APuU4Z/1E+PN/XXbOYhKeDBMRn+4aMqeVwtTanoSVTINTMNOepS/i6ZA
 c8YAiTtVoW/SexyTLwTztskAw6Zg0ASpXHv6+IV7fkHwdv9F1/iK4Hy2Jz6KUhWn6+o=
X-Gm-Gg: AYBFou1etQ11JFomQSo6JMdAmDSlh/ktZOshxbElyQI3Qo529JhhI+RVW2QdsmGas2L
 Ym6U6DJwP/a3WwfxntPnZNuOn9qhAF+fVuOPkt1SZN+xQshP5uIxLfWxK2qisLkeLYlDMMgr0/f
 /b3eQVNcBBatz7dwd1AsHI4btoHMOS+ViNWoJpWGp5c9tpwW3FMOzW3m8JUwL5jKlbEGToPp3Dd
 F8czrlGDiW4ItA5Qy4hltme8DcVGY3JY44uoJGSdMaRdIlRSgyJ05EYrahOulVebXstZIoGRmn/
 SXZhnLcPYjEVDwK3tXirWVHq1MLGf8kPkszl+sWE69zGQx9/B3qI0mXLrEHTV3wpsMqfTVRe88F
 g2+HhYbp2Uzu/DUfuTCsk8PRRTdCJ14X9WPhPKtik5HrU+OB43zHJ+rZnoydUVYf1L7JgF1NnZQ
 WMtxkh9xCw2zPKLcW9AjMPAs/8WsUK+xogSd9PRnce8QDo8t4Kscj1KJWEYNfwRq+we0DKk+Wzc
 x7lVP9/SNLPcGFEL9Ys75ZrYbrWGrbWj4aFzFa0hiLEAcIAxQO+KLnyCxMQt2EY3y4sUaUn/aaV
 mFHmamFp70PgjxHTBcBynChc0JdQeJ5EOXQBQapeT72N0kGVOWlJLuy0l6L4iPudiP1DzcZNwVQ
 vg4BzWdyrlxEdPGgrGT5z0RQybh0XBcp1sJVU0UeGpg==
X-Received: by 2002:a05:693c:4151:20b0:36a:f99:ae79 with SMTP id
 5a478bee46e88-36a4232f3f8mr16485894eec.7.1793608019023; 
 Mon, 02 Nov 2026 00:26:59 -0800 (PST)
Received: from
 runnervmnwato.qvihz0ilh3mutht1j52cuktbpc.phxx.internal.cloudapp.net
 ([20.171.14.81]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42935b4asm47741716eec.16.2026.11.02.00.26.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 00:26:58 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Li Wang <li.wang@linux.dev>
Date: Mon,  2 Nov 2026 08:26:57 +0000
Message-ID: <20261102082657.3791-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102024328.115105-2-li.wang@linux.dev>
References: <20261102024328.115105-2-li.wang@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
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

On Mon Nov 2 10:43:25 2026 +0800, Li Wang (Hieco) <li.wang@linux.dev> wrote:
> lib: add module is loaded check

--- [PATCH 1/4] ---

> --- a/include/tst_module.h
> +++ b/include/tst_module.h
> @@ -49,5 +49,6 @@ static inline void tst_requires_module_signature_disabled(void)
>  
>  void tst_modprobe(const char *mod_name, char *const argv[]);
>  void tst_module_reload(const char *mod_name, char *const argv[]);
> +bool tst_module_is_loaded(const char *mod_name);

Add a kernel-doc comment (/** ... */) for tst_module_is_loaded() documenting
@mod_name and Return:.

--- [PATCH 2/4] ---

> +static void kconfig_module_record(struct tst_kconfig_var *var)
> +{
> +	unsigned int i;
> +	const char *mod = NULL;
> +
> +	if (var->choice != 'm')
> +		return;
> +
> +	for (i = 0; config_module_maps[i].config; i++) {
> +		if (!strcmp(config_module_maps[i].config, var->id)) {
> +			mod = config_module_maps[i].module_name;
> +			break;
> +		}
> +	}
> +
> +	if (!mod)
> +		return;
> +
> +	if (tst_module_is_loaded(mod))
> +		return;
> +
> +	for (i = 0; i < loaded_module_count; i++) {
> +		if (!strcmp(loaded_modules[i], mod))
> +			return;
> +	}
> +
> +	if (loaded_module_count < MAX_LOADED_MODULES)
> +		loaded_modules[loaded_module_count++] = mod;
> +}

Recording modules into loaded_modules[] inside kconfig_parse_line() happens
even when geteuid() != 0, when tst_kconfig_check() fails with TCONF (e.g.
CONFIG_X509_CERTIFICATE_PARSER=y on a =m kernel), or when tst_kconfig_read()
is called later during the test. Consequently, tst_kconfig_module_unload() in
do_cleanup() attempts to unload modules that were never loaded by
tst_kconfig_module_load(), and fails with EPERM (emitting a spurious TWARN)
when running unprivileged (such as vsock01). Only record modules in the
unload list when tst_kconfig_module_load() actually loads them.

> +		default:
> +			tst_res(TWARN, "Failed to unload module '%s'", name);
> +		}

Use TWARN | TERRNO so the failure reason from delete_module() is printed.

--- [PATCH 3/4] ---

>  static struct tst_test test = {
> +	.needs_root = 1,
> +	.setup = setup,
>  	.test_all = run,

Document why root is required (loading the vsock/vsock_loopback modules) in
the top-level /*\ ... */ test description block.

--- [PATCH 4/4] ---

>  /*\
>   * Test ``KEYCTL_RESTRICT_KEYRING`` builtin_trusted of :manpage:`keyctl(2)`.
>   *
> - * Requires root (CAP_SYS_MODULE) to load the ``x509_key_parser`` module.
> + * * Requires root (CAP_SYS_MODULE) so that the test library can load the
> + * ``x509_key_parser`` module.

Remove the extra asterisk in "* * Requires root", which creates a malformed
reST bullet item. Also update .needs_kconfigs in keyctl23.c from
"CONFIG_X509_CERTIFICATE_PARSER=y" to "CONFIG_X509_CERTIFICATE_PARSER",
otherwise tst_kconfig_check() aborts with TCONF on =m kernels instead of
loading x509_key_parser.

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
