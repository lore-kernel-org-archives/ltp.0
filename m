Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18E1606A326
	for <ltp@archiver.kernel.org>; Tue,  3 Nov 2026 10:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BBhgRJkk
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4A5A93C701B
	for <ltp@archiver.kernel.org>; Tue,  3 Nov 2026 11:19:56 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5542B3C701B
 for <ltp@lists.linux.it>; Tue,  3 Nov 2026 11:19:42 +0100 (CET)
Received: from mail-dy2-x09.google.com (mail-dy2-x09.google.com
 [IPv6:2607:f8b0:4864:36::9])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CB00E10009BF
 for <ltp@lists.linux.it>; Tue,  3 Nov 2026 11:19:41 +0100 (CET)
Received: by mail-dy2-x09.google.com with SMTP id
 5a478bee46e88-35adc681e1aso7048864eec.0
 for <ltp@lists.linux.it>; Tue, 03 Nov 2026 02:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793701180; x=1794305980; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PkS7MZ0CE+Pxe1E5nbLqZpp1aa3j71TK5J4Qlh80RpM=;
 b=BBhgRJkkg+jFSRmBgXSjAmgvFxsePWL42vClGCsgtxpL0IRg3tJMaL8K9IuNJgEUNM
 pklFREkgR2B2XjnJo68vR16HLf6YRXpweac3MG19exUT4Nepds+XlhEDun3E4bfVykRl
 RkHbXg2/kS+vOM5V2hY1pYHquzt75uYx4JkkE5KzqzXhzBasz5RvYcFOG0fVwghadT7b
 eF39S9eAlihad8VbjAELc4Y9KS5a0NmwITrAYFUU41bM5MTvOsdfXS23KMihmdqc3PZG
 inKga0hMpVIHAsKQDbgTYWHX9WeuX5uVGsJeGmjzWFG7nQQ1JSRv4z1J4TaghKpOMumQ
 6L+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793701180; x=1794305980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PkS7MZ0CE+Pxe1E5nbLqZpp1aa3j71TK5J4Qlh80RpM=;
 b=kV/EWaxa8MVRxyLDcqckVNgFtaf9gz/0w3nYIdblL7B45hjzwGpbfkHXTmNfpwPCIT
 sKFKXVF9F4Pb6ASp7qdlQGxiY+WAGyu4BZeKWlmL2ML+Lp3nhP+ADkYOZj0VtzQX1iCC
 daluw59tiKDquFq/0VCxGoxwUDCKAmu5xMoady/7SwhKOiV24bFPGTkwzk7MnkJDeDyX
 kDKBUb2Dy7R67JQdxMFq6tAjHxdnvkuxA2njJZKdFC3WC4g6EV5/5QxGhqkHbwvg0JAo
 xv2ZJYsBlRZrtUtENJSvG7aUJUcUBfQ7khhUOqCYxc5WFxmIjnOFNS+LUIpIEeDsvwbR
 fLCw==
X-Gm-Message-State: APuU4Z+Ymyvhn+h2WUWpltBROrcxTF4MShPOK1cbrbMgJmgZu9+kj8y8
 OSszgJGpUZn4ydK7nj49HlTrkJL4eP0u7YqMcSUcU3lT3RIRZP0mIw8W
X-Gm-Gg: AYBFou1/nmviogYC4w5v1chUvGq+M/cij8mT9LobpCF5LErjq41DxXD88NluCIVvC6U
 qgOVag9zVTIq8IFjmKHWGSidLobvLbtrgdWu0C46zM5nWFVLYc+IppDJx8HIUvV2uMWULgBE8Tm
 0aj95WD97kL1mYOX9UAktXZRNBtMcXMIby8C9B0jB8MxwCSYcpXB2uCJDRz3loZVj/ywJup5HZo
 GJVEkEqc+pYHfEEs5sHbegVZr4AcNfu3duHOhVggFHMMKBiL11VTt02qtOrgid1J0JW5aGw4ADr
 I6j4e+B0sJsNx80fp89L0bkGTAgA/p2HQ4jmS1p59XdLKnJ1N2Z/iXc/texV9LmelRGgsUzK/gS
 UCIgoClZBdTyRW4XkliA9kd3gGWHfKhNKzhP+7J/Ky3pRVVuI2AlY8+tapF4dM0+h4AttvaXQc+
 7P+UlDvXrDT21pHXKO2HB2ZzudwEccfyCHvW83mpI/zSyfr5dT5jaEPT7nCLltDyPX1adTscKUm
 fDPvdngemjxmarxJaw/m+AWlrWKlKmORkTe5I4MLKHi9/aka5fVIjy1yGAwP1fOMbrqrdDWb4DD
 6p6JObxrkxsFM1g0Vp47aHP4FpNF7xtBAI6Gt1yG83NAUqS9/Av5h9Ab8Zb5me9dRO8hCValqND
 ooZnumzxL6DI2qgfR5zpVVEn+/4k8PUKVruGwjgfkFdkkTZBv3Ze1if402F40Yw==
X-Received: by 2002:a05:7022:170c:b0:1b0:166c:6a94 with SMTP id
 a92af1059eb24-1b0166c6be4mr11017272c88.28.1793701179827; 
 Tue, 03 Nov 2026 02:19:39 -0800 (PST)
Received: from
 runnervmnwato.prajoiou5htenajwodrmzf4tne.dx.internal.cloudapp.net
 ([68.220.60.6]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b23f20d36csm5768371c88.11.2026.11.03.02.19.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 02:19:39 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Li Wang <li.wang@linux.dev>
Date: Tue,  3 Nov 2026 10:19:38 +0000
Message-ID: <20261103101938.4207-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103075722.181317-2-li.wang@linux.dev>
References: <20261103075722.181317-2-li.wang@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
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

On Mon Apr 13 15:25:17 2026 +0800, Li Wang <liwang@redhat.com> wrote:
> lib: add module is loaded check

--- [PATCH 1/4] ---

> diff --git a/include/tst_module.h b/include/tst_module.h
> index e55321d19..9b789e289 100644
> --- a/include/tst_module.h
> +++ b/include/tst_module.h
> @@ -49,5 +49,6 @@ static inline void tst_requires_module_signature_disabled(void)
>  
>  void tst_modprobe(const char *mod_name, char *const argv[]);
>  void tst_module_reload(const char *mod_name, char *const argv[]);
> +bool tst_module_is_loaded(const char *mod_name);

New public library functions in include/ should have a kernel-doc
(/** ... */) comment describing @mod_name and Return:.

--- [PATCH 3/4] ---

> diff --git a/testcases/cve/cve-2025-21756.c b/testcases/cve/cve-2025-21756.c
> index 4245a4c95..b49950045 100644
> --- a/testcases/cve/cve-2025-21756.c
> +++ b/testcases/cve/cve-2025-21756.c
> @@ -85,8 +95,15 @@ static void run(void)
>  }
>  
>  static struct tst_test test = {
> +	.needs_root = 1,
> +	.setup = setup,

The reason .needs_root = 1 is required (loading the vsock and
vsock_loopback modules before dropping privileges in setup()) should also
be documented in the test's /*\ ... */ doc comment.

--- [PATCH 4/4] ---

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
> @@ -89,8 +89,6 @@ static void setup(void)
>  {
>  	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
>  
> -	tst_modprobe("x509_key_parser", NULL);
> -
>  	ring_builtin = SAFE_NEW_RING("ltpkeyctl23_builtin");

keyctl23.c still has "CONFIG_X509_CERTIFICATE_PARSER=y" in .needs_kconfigs
instead of "CONFIG_X509_CERTIFICATE_PARSER", so tst_kconfig_check() aborts
with TCONF when the option is =m before tst_kconfig_module_load() is
called, and never loads a module when it is =y. Drop =y from
"CONFIG_X509_CERTIFICATE_PARSER=y" in .needs_kconfigs (matching keyctl29.c)
so CONFIG_X509_CERTIFICATE_PARSER=m is accepted and x509_key_parser is
loaded automatically.

Verdict - Needs revision

Pre-existing issues:
- testcases/cve/sctphantom.c: the doc comment at lines 46-48 still says the
  test reports TCONF if the sctp module is not loaded ("run modprobe sctp
  first"), and the sysctls saved via tst_sys_conf_save() in setup() could
  now use .save_restore in struct tst_test since do_setup() loads the module
  before .save_restore and do_cleanup() unloads it after
  tst_sys_conf_restore().

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
