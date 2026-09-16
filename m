Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F37BFC982C9
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 18:19:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ABD6B3C06E3
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 20:19:54 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB9DF3C06E3
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 20:19:37 +0200 (CEST)
Received: from mail-pz2-x09.google.com (mail-pz2-x09.google.com
 [IPv6:2607:f8b0:4864:3b::9])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5E26B20015B
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 20:19:37 +0200 (CEST)
Received: by mail-pz2-x09.google.com with SMTP id
 41be03b00d2f7-cc4b166d0dbso1518491a12.1
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 11:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789582775; x=1790187575; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zFudeUX96EyXOX7bgQ5jcmKGD7Ut+9skQyKURBW/vUY=;
 b=Cn8zhN/GOY1Py7LTkU5DdfUoaryqcpVE9slJSBwUq63ONaFHFSug1Htzy5AowceAnF
 6imLN4SHgC+HuTcH0AisjcyePCZyC3KlnghPT+takgBRHfhNQrLWC9eHBFwwOw0FIrzK
 LIbghl3UPxUN9H0ze5trcBnKy4yjRT4IQdZWrXGPlYowYxP1lBA9TjrKtJMGYelnjIhI
 IcNR7Cm9yUYkIV+X6Q4yJf2KtpfhtiPulJeoCf0IPV6AveFHiakDeQELmC7HY9rfgGK5
 KwF2zDE5ppS9LK0xYX6RD5WGlk6DNo0sTcNFpmM0t8xoFcvrMEggdfqnYYowx6zStYnG
 34OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789582775; x=1790187575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zFudeUX96EyXOX7bgQ5jcmKGD7Ut+9skQyKURBW/vUY=;
 b=vQwqhda9UWh39lf2uhPxPBtgVVL+pEgdtR5AaYs/5tHnvowfozZJrlJyhOdRnPCFqN
 8YTpkyhW5Njagv61iQM5KAu1osGsSH+AGW0UJx89R8sXLwdTrNJkSeP/H71uEPKq42SC
 Ss7F9najSKEaD3o3lx8uKYPZU95YQA24zxrEYBYFc8Gmt56sMdm5rjzKPJGplYWyK28D
 BZLRDDKb1dzVOADllSqqse74CVlK5m5mqMkKNiLiLItNgv4aSNEPz/7wjgpiyKxpVf+d
 cmUn57AUeWFQgWH1bTfG1BeqQUhaeMvMAfIjemN6S6nNKttWOz/+G2+bHXiUZk+i2ltI
 YW+Q==
X-Gm-Message-State: AFuF++lE1OKszBYjSFCcRVOvl9YuDTcRBgLkWn1sx6olK6sb+PBLp9dY
 M5l0o6HU05rJNTbxzC3zeM690sH03iWFwAHxVngU0ikZo3CnEEHKnhH8
X-Gm-Gg: AYBFou2+UWfcLZrbYgAUeku6DvimRBsFedKNbp6Gq7WSqrNmoVF1pd53N4zApS6Zmwg
 rwC8oN80dPguQ5wjBMo+Diou+A6x5GXnKJ72Ex86SaGyaiu6m5c+NB8W/Gb7L/bCIQB2jO4GWkr
 AfIjEIC2JDu11Ddg4+yyc5hBnTltEdkpbj2zDYTrefBI4Iik8UzzpgbRfb4abLC85BaY8rQrHW5
 sG/ULmh3e9nA9zosfg0HXKI49gKv7AraBA7cWTMAFBioi+7F7LqlsWgRZf4S36Cq6lFSuDKJ00d
 Gx8Zih8Rg7hkeckKOMl9dthMoD/O5EqXjNzlO4hzlqe2UzhamZaE5zvFSb20jsyZYY99zjN2Uig
 RgKoEgURMTfFyTUH5FWuntAKhQj7jI9T11tmRAcsN/FYONo9qKbuXYudqtepOM2HB7/G+RbeTou
 Lna46NUTWgV4jIksxKwRqaMl6Ouzp90DCevPo82xDUnrhwuvUpLqdJuaGKBJwx0jb3qe14YLMv0
 ensF2NTRw3Tt7AWFVrt4Km+jYGooY1BQnxFEX5hsmInuhMWxVRvyMQ9IjElUMue5Iu6iFU6NrP1
 e94AwvJeoG4=
X-Received: by 2002:a05:6a20:430a:b0:3da:6bdd:2308 with SMTP id
 adf61e73a8af0-3dd5f5d673emr8356607637.18.1789582775353; 
 Wed, 16 Sep 2026 11:19:35 -0700 (PDT)
Received: from
 runnervmlun5p.meshoxyzvolejg1lfo2a0p1fje.dx.internal.cloudapp.net
 ([68.220.61.209]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c011378f1sm6842426eec.29.2026.09.16.11.19.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 11:19:34 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Wed, 16 Sep 2026 18:19:33 +0000
Message-ID: <20260916181933.4928-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916140402.1797325-6-pvorel@suse.cz>
References: <20260916140402.1797325-6-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
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

On Wed, 16 Sep 2026 16:03:27 +0200, Andrea Cervesato <andrea.cervesato@suse.com> wrote:
> lapi/keyctl.h: Add fallback definitions for extended ops

--- [PATCH 1/36] ---

> +#ifndef HAVE_STRUCT_KEYCTL_DH_PARAMS
> +struct keyctl_dh_params {
> +	int32_t priv;
> +	int32_t prime;
> +	int32_t base;
> +};
> +#endif

HAVE_STRUCT_KEYCTL_DH_PARAMS_PRIV is probed in m4/ltp-keyutils.m4 for Leap
42.2 compatibility but is never handled here. When
HAVE_STRUCT_KEYCTL_DH_PARAMS is defined without
HAVE_STRUCT_KEYCTL_DH_PARAMS_PRIV, accessing dh_params->priv causes a build
failure. Add an alias:

#if defined(HAVE_STRUCT_KEYCTL_DH_PARAMS) && \
	!defined(HAVE_STRUCT_KEYCTL_DH_PARAMS_PRIV)
# define priv private
#endif

--- [PATCH 2/36] ---

> +	if (rval == -1) {
> +		tst_brk_(file, lineno, TBROK | TERRNO,
> +			 "add_key(%s, '%s', %p, %ld, %d) failed",
> +			 type, desc, payload, size, keyring);
> +	} else if (rval < -1) {
> +		tst_brk_(file, lineno, TBROK | TERRNO,
> +			 "Invalid add_key(%s, '%s', %p, %ld, %d) return value %d",
> +			 type, desc, payload, size, keyring, rval);
> +	}

The size parameter has type size_t, but %ld is used in the format strings.
Use %zu instead.

> +#define SAFE_ADD_KEY(type, desc, payload, size, keyring) \
> +	safe_add_key(__FILE__, __LINE__, \
> +                            (type), (desc), (payload), (size), (keyring))

Use tabs instead of spaces for indentation.

--- [PATCH 4/36] ---

> +#define SAFE_NEW_RING(desc) \
> +	safe_add_key(__FILE__, __LINE__, "keyring", (desc), NULL, 0, KEY_SPEC_PROCESS_KEYRING)
> +
> +#define SAFE_NEW_USER_KEY(desc, payload, plen, ring) \
> +	safe_add_key(__FILE__, __LINE__, "user", (desc), (payload), (plen), (ring))

The SAFE_* prefix is reserved for LTP core library headers in include/.
Rename these macros without the SAFE_ prefix (e.g. NEW_RING and
NEW_USER_KEY) or move them to include/lapi/keyctl.h.

--- [PATCH 9/36] ---

> +	rc = SAFE_KEYCTL(KEYCTL_GET_SECURITY, key, (unsigned long)buf, sizeof(buf), 0);
> +
> +	if (buf[0] != '\0')
> +		tst_res(TFAIL, "empty label is not NUL terminated");

Checking buf[0] != '\0' unconditionally fails on systems where an LSM
(such as SELinux or Smack) is active and returns a non-empty security label.
Check buf[rc - 1] != '\0' instead to verify NUL-termination, or only check
buf[0] == '\0' when rc == 1.

--- [PATCH 14/36] ---

> +static void run(void)
> +{
> +	SAFE_KEYCTL(KEYCTL_LINK, key_a, ring_a, 0, 0);
> +	TST_EXP_PASS(keyctl(KEYCTL_MOVE, key_a, ring_a, ring_b, 0));
> +
> +	TST_EXP_EQ_LI(keyctl(KEYCTL_SEARCH, ring_b, "user", KEY_DESC), key_a);
> +}

When running multiple iterations (-i), key_excl is displaced from ring_b
in the first iteration and is never re-linked to ring_b. Subsequent
iterations therefore do not test displacement. Re-link key_excl to ring_b
in run() before moving key_a.

--- [PATCH 17/36] ---

> 		case 'i':
> -			iterations = SAFE_STRTOL(optarg, 0, INT_MAX);
> +			tst_test->iterations = SAFE_STRTOL(optarg, 0, UINT_MAX);

Passing UINT_MAX to SAFE_STRTOL() breaks on 32-bit architectures because
safe_strtol() takes signed long, where UINT_MAX (0xFFFFFFFF) converts to
-1L. This makes safe_strtol() reject any positive iteration count as out of
range 0 to -1. Use SAFE_STRTOUL(optarg, 0, UINT_MAX) or keep INT_MAX.

--- [PATCH 35/36] ---

> +	.ulimit = (const struct tst_ulimit_val []) {
> +		{RLIMIT_NOFILE, 524288},
> +		{}
> +	},

Setting .ulimit requires .needs_root = 1 when raising limits above the
current maximum. Without root privileges, safe_setrlimit() fails with
EPERM and aborts the test with TBROK. Either drop .ulimit or add
.needs_root = 1.

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
