Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D9DC624D3
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 14:08:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9AE703E93AD
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 16:08:05 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 52D393E2FCD
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 16:07:51 +0200 (CEST)
Received: from mail-pj2-x02.google.com (mail-pj2-x02.google.com
 [IPv6:2607:f8b0:4864:39::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8647E1000412
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 16:07:50 +0200 (CEST)
Received: by mail-pj2-x02.google.com with SMTP id
 98e67ed59e1d1-3896ccc93b5so342121a91.1
 for <ltp@lists.linux.it>; Wed, 02 Sep 2026 07:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788358069; x=1788962869; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vOQ5dHK2prckAk7/8hvGHLh2PCgcOUAWll3Z37Ji6uc=;
 b=rMLY8XFFP9SOThPVJ7g0nSwjO0Tb6S1/c+fQn8IBEl3HqeZJANkqppr2+yyNf8Kkbz
 0qKygAkDaNSXXuISPz8id7O75uObZPcll+LDUSHgabSaMZzGw0FOfbDHtKdpmdzEqW1T
 EBnpVYf5Ek+cmWka29i06Dz75GDEQD9+jedvhbuqENemyUBVehVgMGnuiPy9cqRNYZss
 qSJQJt0jfHUL4SCCG09Uhsa/xuBi49h0LbfgXsGBYL5QD7rDKk36PWKiK7Q7UmW0dBEI
 V5Ye1OnUMlSEeTvCVrSy0IjvCbBB9cJwLjaKtqGlG0kfE+apEqMbi6xa0hmZzvwIBH7o
 D75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788358069; x=1788962869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vOQ5dHK2prckAk7/8hvGHLh2PCgcOUAWll3Z37Ji6uc=;
 b=qmo3oGnQZkJ+cjc1rDQpGZY0uOw5H7qJHwIkRUb9K0I5oMbmsx2k3c/YOTKsxRJ0dz
 JiCOAWUfVexyMXxGLfQLf5esV4WHiod50zT7kvzdK+UOZAiHQfsWl0frvcMioaAlTA6o
 FbdcBzZotrdFBXcKYzdxWSJWouf0EY70rrSh1vVVRkYIlRFxmpBCbeQ8r8MNmU0soTRd
 gc6uOMhc7/7Gvrnfp+hTP1IzQLBtfMvk7sT26dsNLJ/UGs9uKejHZfD1KzT2VmfHV2mW
 l32HjNMdPlupDPpwGVPH9AYgsZ0Zsl3I60vbQ4M3y2UvwXQls3Nli3V3Y7r2kSGa6KyV
 OXSw==
X-Gm-Message-State: AFuF++nPR1jMlcTAKDTD/zzBuonW9wQ4SFz0Es6rsqRqD3JaxUNdvHbo
 HWx/mmRYdgXuCRLYdQvuMPj2oysEVYj6zmtFxdu0llBSoiiNrGOa+RV9
X-Gm-Gg: AYBFou3vSC2IyH9QInh67J+O2GnFLCepspA8N+ynZP4jIKtR5YuRexoBP91q3rJZVNn
 8pX/4Ahjnj4XO1u2Rnvue359xbIAgjGn7Jj5/Rl+QqbEhmqPyxj2maEdrI6Cx8EKlTjME4wy63x
 Tct5v9hueZCJkRCTPNZmUDertuJVdDBmWRhuRMfud8HvLbqucBn3ApLdHMII5lURVWQRidqCzky
 TZK7Gg5aq/g3WrOt/EWvcCKGSMVnO8iTGC9PgcQyfk0sUGLYcmuM//ssBI6YwWMyh+xaXZpqnE7
 27leIaJFrml1QM3+bNx/++0s/xtb69wx5OdsAu33sncZr7S3Cr2trcxjxKObRfZmdbqFE2chdIX
 bPvoZ9bnnGsWgPFfNCVJvJEbKoglUuv6F8HUJjuLNqJiPRLlKpWPpkWhtspe+NtjaxZnkXrdoeK
 gS0USHF36PVtO+XHuPrRGAo0/2w2cvUZYgSeVr3ein89VKchlwQqnsfT87MwmXDXuBiuVzTHjeH
 AFa5PUUSQfPcTJNC+3v22VtQ0Df7JnPL+XTTHuk7QD7s+0r4e+XEbXvcklKW9m0amd2duUZHc46
 F0vN/F5uFAo=
X-Received: by 2002:a17:90b:3b8d:b0:398:c292:ac80 with SMTP id
 98e67ed59e1d1-39aedf55732mr7305270a91.10.1788358068414; 
 Wed, 02 Sep 2026 07:07:48 -0700 (PDT)
Received: from
 runnervmgx7h7.mjz10em2rcmehnadcvryxgeikc.yx.internal.cloudapp.net
 ([52.161.69.171]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-331d6eaeb06sm3415756eec.9.2026.09.02.07.07.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 07:07:47 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed,  2 Sep 2026 14:07:45 +0000
Message-ID: <20260902140745.6150-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902-keyctl_coverage-v1-2-d29dfa2ebcef@suse.com>
References: <20260902-keyctl_coverage-v1-2-d29dfa2ebcef@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi/keyctl.h: Add fallback definitions for extended ops
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

Hi Andrea,

On Wed, 02 Sep 2026 13:04:16 +0200, Andrea Cervesato wrote:
> lapi/keyctl.h: Add fallback definitions for extended ops

--- [PATCH 1/33] ---

> +#if !defined(HAVE_KEYUTILS_H) && !defined(HAVE_LINUX_KEYCTL_H)
> +struct keyctl_dh_params {

This block sits in the #else branch of
"defined(HAVE_KEYUTILS_H) && defined(HAVE_LIBKEYUTILS)", so <keyutils.h>
is never included on this path and only <linux/keyctl.h> can declare the
structs. With keyutils.h present (HAVE_KEYUTILS_H, configure.ac:59) but
libkeyutils not linkable (m4/ltp-keyutils.m4) and linux/keyctl.h absent,
the guard is false and nothing declares keyctl_dh_params /
keyctl_kdf_params, breaking keyctl25..keyctl28. Use
"#ifndef HAVE_LINUX_KEYCTL_H". The same guard is reused for
keyctl_pkey_query / keyctl_pkey_params in patch 21/33.

> +#ifndef KEYCTL_RESTRICT_KEYRING
> +# define KEYCTL_RESTRICT_KEYRING 29
> +#endif

Commands 29 and 30 are appended after KEYCTL_WATCH_KEY (32), and patches
21/33 and 27/33 then insert 24..28 and 31 after those. The rest of the
list is in ascending command order.

--- [PATCH 2/33] ---

> +	TEST(keyctl(KEYCTL_DESCRIBE, key, (unsigned long)NULL, 0, 0));
> +	if (TST_RET < 0)
> +		tst_brk(TBROK | TTERRNO, "KEYCTL_DESCRIBE failed");
> +
> +	desc_len = TST_RET;

safe_keyctl() already treats a negative KEYCTL_DESCRIBE return as a
failure, and the previous line in the same function uses SAFE_KEYCTL().
This is a setup precondition, not the tested call, so the "subject
syscall" exception does not apply:

	desc_len = SAFE_KEYCTL(KEYCTL_DESCRIBE, key, 0, 0, 0);

Same in keyctl11, keyctl12, keyctl16, keyctl34, keyctl35 and keyctl36.

> +	if (strcmp(type, "user")) {
> +		tst_res(TFAIL, "wrong key type '%s', expected 'user'", type);
> +		return;
> +	}

Use TST_EXP_EQ_STR(type, "user") instead of strcmp() + tst_res(). Same
for the strcmp() against KEY_DESC below.

--- [PATCH 3/33] ---

> +	memset(buf, 0, desc_len);
> +	TST_EXP_EQ_LI_SILENT(keyctl(KEYCTL_DESCRIBE, key, (unsigned long)buf,
> +				    desc_len, 0), desc_len);
> +	if (!TST_PASS)
> +		return;
> +
> +	if (buf[desc_len - 1] != '\0') {
> +		tst_res(TFAIL, "description is not NUL terminated");

buf is zeroed immediately before the call, so buf[desc_len - 1] is
already '\0' and this check cannot fail even if the kernel copied
nothing. Nothing verifies the content either. Poison the buffer
(memset(buf, 'x', desc_len)) and assert
strlen(buf) + 1 == (size_t)desc_len, as keyctl12 already does with 0xAA.

> +	TST_EXP_EQ_LI_SILENT(keyctl(KEYCTL_DESCRIBE, key, (unsigned long)buf,
> +				    desc_len, 0), desc_len);

TST_EXP_EQ_*() compare two plain values and do not go through TEST(), so
errno is lost on failure. For syscall return values use
TST_EXP_VAL()/TST_EXP_VAL_SILENT(), or TST_EXP_PASS()/
TST_EXP_PASS_SILENT() when 0 is expected. Recurs in keyctl12, keyctl16,
keyctl18, keyctl19, keyctl20, keyctl25, keyctl27 and keyctl29..keyctl36.

--- [PATCH 7/33] ---

> +	memset(buf, 0, sizeof(buf));
> +
> +	TEST(keyctl(KEYCTL_GET_SECURITY, key, (unsigned long)buf, sizeof(buf), 0));
...
> +	if (TST_RET == 1) {
> +		if (buf[0] != '\0') {
> +			tst_res(TFAIL, "empty label is not NUL terminated");
...
> +	tst_res(TPASS, "security label returned, full length %ld", TST_RET);

Same tautology as keyctl11: buf is zeroed first, so buf[0] == '\0'
always holds. The TST_RET > 1 branch reports TPASS without inspecting
buf at all. Poison buf and assert strlen(buf) + 1 == (size_t)TST_RET
whenever TST_RET <= sizeof(buf); that covers both branches.

--- [PATCH 14/33] ---

> +	TEST(keyctl(KEYCTL_RESTRICT_KEYRING, ring_reject, 0, 0, 0));
> +	if (TST_RET == 0)
> +		tst_res(TPASS, "KEYCTL_RESTRICT_KEYRING with NULL type and restriction passed");
> +	else if (TST_RET == -1 && TST_ERR == EEXIST)
> +		tst_res(TPASS, "KEYCTL_RESTRICT_KEYRING reject-all already active");

Restricting a keyring is one-shot (keyring_restrict() returns -EEXIST
once restrict_link is set), so this branch only exists to survive -i N,
but it also accepts EEXIST on the first iteration where the keyring has
never been restricted. Move the restriction into setup(), which the
framework calls once, and keep run() to the EPERM assertions. Same
pattern in keyctl23.

--- [PATCH 15/33] ---

> +	TST_EXP_FAIL(keyctl(KEYCTL_LINK, user_key, ring_builtin, 0, 0),
> +		     EOPNOTSUPP,
> +		     "KEYCTL_LINK of non-asymmetric key on builtin_trusted restricted keyring");
> +
> +	TST_EXP_FAIL2(add_key("asymmetric", "cert", untrusted_cert,
> +			      sizeof(untrusted_cert), ring_builtin), ENOKEY,

EOPNOTSUPP and ENOKEY come from restrict_link_by_signature(), which is
only reachable with CONFIG_SYSTEM_TRUSTED_KEYRING=y. Without it,
include/keys/system_keyring.h does
"#define restrict_link_by_builtin_trusted restrict_link_reject", both
calls return EPERM and the test reports two TFAILs instead of skipping.
The restriction still installs in that configuration, so the existing
EOPNOTSUPP TCONF branch never fires. Add:

	.needs_kconfigs = (const char *[]) {
		"CONFIG_SYSTEM_TRUSTED_KEYRING=y",
		NULL
	},

Note certs/Kconfig makes SYSTEM_TRUSTED_KEYRING depend on
X509_CERTIFICATE_PARSER=y, so whenever modprobe actually loads
x509_key_parser as a module the option is off and the test always fails.

> +	TEST(keyctl(KEYCTL_RESTRICT_KEYRING, ring_builtin,
> +		    (unsigned long)"asymmetric", (unsigned long)"bogus", 0));
> +	asym_supported = (TST_RET != -1 || TST_ERR != ENODEV);

KEYCTL_RESTRICT_KEYRING resolves the type through keyring_restrict() ->
key_type_lookup(), which returns ENOKEY for an unregistered type; ENODEV
is what add_key() returns (security/keys/key.c:830), as
add_asymmetric_key_or_tconf() correctly assumes in patch 22/33. With a
registered type the probe gets EINVAL from "bogus", so asym_supported is
always 1 and the TCONF branch is dead code. Compare against ENOKEY.

--- [PATCH 16/33] ---

> +	asym_supported = (TST_RET != -1 || TST_ERR != ENODEV);

Same wrong errno as keyctl23. Here the dead TCONF branch also turns two
tcases into spurious TFAILs on a kernel without CONFIG_ASYMMETRIC_KEY_TYPE:
"asymmetric with invalid restriction string" expects EINVAL and
"self-referencing key_or_keyring chain" expects EDEADLK, but both receive
ENOKEY.

> +	keyctl(KEYCTL_UNLINK, probe_ring, KEY_SPEC_PROCESS_KEYRING, 0, 0);

These housekeeping unlinks are not the tested call and must succeed. Use
SAFE_KEYCTL(); as written a failure is silently discarded. Same for the
fresh_ring unlink in verify_negative().

--- [PATCH 17/33] ---

> +/* RFC 7919 2048-bit FFDHE Group parameters (ffdhe2048) */
> +static const unsigned char dh_prime[] = {
> +	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xc9, 0x0f, 0xda, 0xa2, 0x21, 0x68, 0xc2, 0x34,

This prime is the RFC 3526 2048-bit MODP group (Group 14 / modp2048),
not RFC 7919 ffdhe2048 - ffdhe2048 continues 0xad 0xf8 0x54 0x58 after
the leading 0xff bytes. The commit message repeats the claim. The vector
itself is correct: pow(dh_base, dh_priv, dh_prime) reproduces
dh_expected_secret byte for byte. The header is reused by
keyctl26..keyctl28, so fix the comment and the commit message.

--- [PATCH 28/33] ---

> +	TEST(keyctl(KEYCTL_CAPABILITIES, (unsigned long)caps, sizeof(caps), 0, 0));
> +	if (TST_RET < 0)
> +		tst_brk(TBROK | TTERRNO, "KEYCTL_CAPABILITIES failed");

Patch 27/33 adds "case KEYCTL_CAPABILITIES" to safe_keyctl(), and patch
21/33 adds the five KEYCTL_PKEY_* cases, but no test in the series ever
calls SAFE_KEYCTL() with any of them. Either use SAFE_KEYCTL() here and
in keyctl35/keyctl36, or drop the unused cases.

--- [PATCH 32/33] ---

> +	.ulimit = (const struct tst_ulimit_val []) {
> +		{RLIMIT_NOFILE, 524288},
> +		{}
> +	},

set_ulimit_() (lib/tst_test.c:1330) raises rlim_max when rlim_cur exceeds
it, which needs CAP_SYS_RESOURCE, and safe_setrlimit() aborts with
TBROK | TERRNO on failure. The test does not set .needs_root, so on any
host whose hard RLIMIT_NOFILE is below 524288 an unprivileged run ends in
TBROK before a single assertion runs - reproduced here with a hard limit
of 65536, where the same getrlimit/setrlimit sequence returns EPERM. The
test holds one watch at a time, so the default soft limit already
suffices; keyctl39 exercises the same code with no .ulimit at all.

> +	TST_EXP_PASS(keyctl(KEYCTL_WATCH_KEY, key, pipefd[0], 1),
> +		     "KEYCTL_WATCH_KEY add watch on key");

The keyctl() helper in lapi/keyctl.h unconditionally reads four variadic
arguments (arg2..arg5); only three are passed here, which is undefined
behaviour. Append an explicit 0, as every other call site in this series
does. Same in keyctl39.

> +	TEST(pipe2(pipefd, O_NOTIFICATION_PIPE));
> +	if (TST_RET < 0) {
> +		if (TST_ERR == ENOPKG)
> +			tst_brk(TCONF | TTERRNO, "CONFIG_WATCH_QUEUE is not set");

This block plus the IOC_WATCH_QUEUE_SET_SIZE call duplicates
wqueue_watch() in testcases/kernel/watchqueue/common.h:100-116.

Verdict - Needs revision

Pre-existing issues:

include/lapi/keyctl.h already fails checkpatch on master with one ERROR
("open brace '{' following function definitions go on the next line",
keyctl_join_session_keyring()) and two CHECKs (multiple blank lines,
missing blank line after a declaration).

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
