Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89AB2C5B56A
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 16:06:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B31F23CF77A
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 18:06:14 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 18E083CA9F0
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 18:05:59 +0200 (CEST)
Received: from mail-qk2-x02.google.com (mail-qk2-x02.google.com
 [IPv6:2607:f8b0:4864:34::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B4B7B20020D
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 18:05:58 +0200 (CEST)
Received: by mail-qk2-x02.google.com with SMTP id
 af79cd13be357-92e51e6879fso3292885a.1
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 09:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786464357; x=1787069157; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bizKQTf152w1StUAb92aVjZemlh1QDpbtf2pIgUmwq4=;
 b=T0HTOuP2LVn7rf43qPUDWAg3RQFCGhXtERVbGS1wRWEKOv+FSk15mx0QrUSRbUTM93
 ow3eEuiymSGsOsZ5SZ5gVeJ1t/IIJZM+HoCx7PoIwE0L/C8ZiAgLDYqMGHhPiMO9thQ9
 3MVJk/py6hOfyAXSitUAr5eVfB6OeWvgYLBLF6/s4jPuVDwY0YRXPfe+8D0cbX9NvE6V
 uCm1Mea7nYhTp6yoEs7Dc34vFJLF8+raO3JiCQRKMz0JM9pgPKU29tJ0m4FaHmFBJa7D
 wLMU14prtpI3oe09Y70UiQ9GgNItCDtHKC3EJa9+E/Sl+webTUgtYgk5zAZpy9t35ae3
 hohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786464357; x=1787069157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bizKQTf152w1StUAb92aVjZemlh1QDpbtf2pIgUmwq4=;
 b=KPhpLUXa6iYRaW+5xplFX9yJcI3P6wqU8Tmz5JPAy/MMFm6YO/ubEYWesvRxIf6euI
 5hxFyYkCJ6Yeg3j79t7qYs7ngdzIcUJzJ0oHQ2CXIJm6Nl2BjIrj2cw+al6XYCQ6G52w
 ezAsLgbCokXOe63uFxzwwLJLwUXMaC7qBVTOBlg1criCVE4q6g4huj7/zg2dWFDEz3b+
 C0Z3H8WMmRz4w5qPiimelwfABwrcrfmP8m4yF58KXukzD9ndnpVS6qZX3tYlUdO4JJRY
 gvln0bwIMOSialg/7HOc9+Mm5aCJwVgqVE/97bgPyLoJ7N/xpEpu2c+gkf4qC+xP392y
 ymLQ==
X-Gm-Message-State: AOJu0Yy4Pn6pW6h2A9yXF90JfNwe15zxnTfdZHAnjMkab74IxhvviJJ7
 CLgshsVSusfUz5mcXMR6KR9N1f9r+6kLrrSkNzwrXJeCjmepkHAI+vZs
X-Gm-Gg: AR+sD138sbNETCRu+VYHVqXYYs+S5xvPIkLWMz7V9W3VdfGeemSSE4LDulnStGd1K7r
 xndn/UcazMohhqwMf/pyc+rTZeDoeLFUSgeu9Lb/9ikY5EqVADK9akpnLKp0Yj2y2MJQoNsn4r3
 3mm0IQarxFf+GuvkAZkpLeJjh2m7vQsr4CoDnJgpX1SSL785EERXs/BJX1e4/wLeodYn01Kkskq
 1u0kJiMnVTZUAqJZG2xKTR+sdih7C2WSaWgMlUHcILsBPBjx/BhfYAED2i02gpiFypDkzS9kDk1
 7axNMvH0EryFq8qa8MXdwLcjTKzkAPacdBsfW/eTB5o+Wo6r/YQWccMlFW0BUVTqF5NxcenM4n2
 0wqPM3EJnLUSmR/mz1f+dWShxE1vnANk5/QbPISsaHcbgfOu89M8l+EzAX2Jsj/x48pzcV1EbF9
 CsMZqow7g+81o+WoKAq4TUWE3XYh4PtA7bbmRFWLWa81cIKuNYGKvUhV/CXoQGpOMaxyS2ricyb
 OnQ5szE4PJY+DMmbFaG4Mu6zWlE3iYJU5h2tJ82nW/4S/ukR/3dyQBFihROYIqz3UYB0BAhIyEk
 6A==
X-Received: by 2002:a05:620a:a409:20b0:934:9fe8:6b54 with SMTP id
 af79cd13be357-936a8f75f4emr296356485a.31.1786464357104; 
 Tue, 11 Aug 2026 09:05:57 -0700 (PDT)
Received: from
 runnervmvrwv9.iamlbuy3v1luthk2jn4vllyqrc.bx.internal.cloudapp.net
 ([20.119.103.10]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-936a85fab4bsm138022685a.41.2026.08.11.09.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 09:05:56 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 11 Aug 2026 16:05:55 +0000
Message-ID: <20260811160555.9333-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811155202.1744316-2-pvorel@suse.cz>
References: <20260811155202.1744316-2-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] test macros: Fix TST_EXP_FD_OR_FAIL()
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

Hi Petr,

On Tue, 11 Aug 2026, Petr Vorel wrote:
> test macros: Fix TST_EXP_FD_OR_FAIL()

--- [PATCH 3/4] ---

> +	TST_EXP_PASS_OR_FAIL(finit_module(fd, "status=valid", 0), err);
>  	if (!TST_PASS)
>  		return;

Could this return when err is nonzero as well?  An expected EKEYREJECTED
sets TST_PASS, so the signature-enforcement path continues to
tst_module_unload() even though the module was never loaded.  The rmmod
retries then end the test with TBROK.  The same issue is present in
init_module01.c.

> +	TST_EXP_FD_OR_FAIL(fd = open(FILE_TRUNCATE, O_WRONLY | O_TRUNC, PERM_MODE), exp_err);
> +	if (fd != -1) {
> +		TST_EXP_PASS_OR_FAIL(ftruncate(fd, 10), exp_err);
> +		SAFE_CLOSE(fd);
>  	}
> +
> +	TST_EXP_FD_OR_FAIL(fd = open(FILE_TRUNCATE, O_WRONLY | O_TRUNC, PERM_MODE), exp_err);

Could the first open keep O_WRONLY without O_TRUNC?  In the
LANDLOCK_ACCESS_FS_WRITE_FILE-only variant, O_TRUNC is denied, fd remains
-1, and the ftruncate() check is skipped.  The next identical open then
tests O_TRUNC twice.

--- [PATCH 4/4] ---

> diff --git a/lib/newlib_tests/test_macros04.c b/lib/newlib_tests/test_macros04.c
> deleted file mode 100644

Could the test_macros04 entry be removed from lib/newlib_tests/.gitignore
along with the deleted test?

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
