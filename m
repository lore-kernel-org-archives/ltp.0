Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 995B5CA9EBE
	for <ltp@archiver.kernel.org>; Sat, 10 Oct 2026 09:38:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 766193E2DEE
	for <ltp@archiver.kernel.org>; Sat, 10 Oct 2026 11:38:54 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4B4453CE2C2
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 11:38:39 +0200 (CEST)
Received: from mail-oo2-x02.google.com (mail-oo2-x02.google.com
 [IPv6:2607:f8b0:4864:31::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BDCEA1400075
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 11:38:38 +0200 (CEST)
Received: by mail-oo2-x02.google.com with SMTP id
 46e09a7af769-824f3901d55so389358a34.1
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 02:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791625117; x=1792229917; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+3CGq/8rOF1tnd1rybLJW64CstL8wiPtuBKAkLrRcOc=;
 b=OCWpGwwrQ9jrbcQtH72HdarsHXq/zVseNfqiWeBeWve0GyAooVzH4WlaH23P50b5sw
 zYL6CJff+1ztegQUwK29M1fT3rB5lJ1/9cQpsMZ0mxBFU7wpIOCwQWtGrqd69C3WmMg0
 plAJXrSl/hmI8R0zqKPfTqSbvd26ep+rgPG/zKOqd+bY0UT3Sk/dyEpD+RSQ40sp67Bn
 /oA+rv46uMvJYrt1huAoX/93Vi86DBoDPUPI/ZJugVkKZF8L3reg1kzS8zNNTK/zLZMN
 9NL4nlpOREnuRDGDlULfoQ3m9Dm/z892wTBaIxToejzXXs5Zi6ZL91WGsWTkW6gRFcHB
 jDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791625117; x=1792229917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+3CGq/8rOF1tnd1rybLJW64CstL8wiPtuBKAkLrRcOc=;
 b=xW7ZDU6wOLM6XZTb8XLxrNjeKV8pw18MFCOIQI6wdGk5TnG4ABLMOUDT0KW9jqBP2w
 GfWTP5An+5dh7KNeAZdpZmOo7pcIy+W4wnvJl0gnmdiDWNtq/5ZGJs7CIsCXdLTBEQjX
 NYQTOnt+lfUxv0gxsN4KKh8OUafPenMsakmwKlqYunro8Cp5eHFfedX2DktKwE7qrTby
 2aTvUglX3aLlPtPCZRTP2fiDpRQXcmFU4swN8gfrh8c0YZqrfQNiinMqL6kmVeuAgd2O
 Wn1yLorRmGg+83H6cczedRW1larC3th6S20x+bEdt66i9UVzZ7F0Gbak2ImDj120QPhU
 QIQQ==
X-Gm-Message-State: AFq9FYKo3Pun58yF/zbADC2bOgPRdapVvBXT9XoZ9wLndc8zJoLure9g
 0izIgIWfDWPUoY4A9KOME9JXxvvACDwqhsZnIs54ES9iqyg6Z5HD08WT
X-Gm-Gg: AYBFou0uRO1Ld5q0KD1SWoCKqGoXcFZzfdnmVqSS9e72VEwKzFYDcl3npL9dwxhEuQI
 vHeWpErofQyEyYHg7RLUmnNntkHHVPCh/O+NzdpNNkx2NAtDR45gslFpzqcFrmt+ELClFv5Q5jl
 gwYFA5x6UmxZV0hgoSzDOnhM8owxt2e9BdvD7ozdxrl7vmiq1DYsQyQ9T1D9/qNFqVYToOW08Jj
 qKUwHno7pb3T1Yz/IITchpzmrF7eXyIrEpvaMivDRJe7Q7N3OC3dEv08QHY/AZObI1ras+sO9uk
 FtTZlchmJjk24VyRzTk/XVcbwNHLejFgStcbv1WYWo8vOxETxCzMw6ovUPhAS8zZpYa8J6WQ0WC
 H/ku6I8M4pKLFl4Oy3sw/zslxfkqGeBpDzOg2R66ErmrvsJP7t52CNVPsBAHsoo5beyCoUSHuew
 soZVUd3u3I7AnRfePFcGsJt02T6L3bdBGzRTA5GRr7VEnHDK/XfMrpSMBCFCAFA73rjjTClJQ2i
 CIlZo+DUz6Iwch2nZXXQ6m+MPLXa1ZGtx4Oth05Ya3M2ZZFSz7Ovuix3qz1VKRBu85RTDARZd48
 XTIOGBiQM/QqDr+4V2DV3m+f
X-Received: by 2002:a05:6820:1508:b0:6e1:d890:3825 with SMTP id
 006d021491bc7-6ef0cf39d5cmr2970377eaf.18.1791625116726; 
 Sat, 10 Oct 2026 02:38:36 -0700 (PDT)
Received: from
 runnervmmprz5.00bfzilhbqpu5jaih4rtw2a2mc.jx.internal.cloudapp.net
 ([172.215.146.224]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a2a86317a5sm3952900fac.17.2026.10.10.02.38.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 02:38:36 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Li Wang <li.wang@linux.dev>
Date: Sat, 10 Oct 2026 09:38:35 +0000
Message-ID: <20261010093835.9399-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261010033622.68927-2-li.wang@linux.dev>
References: <20261010033622.68927-2-li.wang@linux.dev>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
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

On 10 October 2026, Li Wang wrote:
> lib: add module is loaded check

--- [PATCH 1/4] ---

> diff --git a/include/tst_module.h b/include/tst_module.h
> +bool tst_module_is_loaded(const char *mod_name);

Low: The new public helper has no kernel-doc comment. Document mod_name,
hyphen normalization, return values, and whether built-in modules count
as loaded.

--- [PATCH 2/4] ---

> diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
> +	for (i = 0; i < loaded_module_count; i++) {
> +		tst_res(TDEBUG, "Loading module '%s'", loaded_modules[i]);
> +		tst_modprobe(loaded_modules[i], NULL);
> +	}
> +
> +	modules_loaded = true;

High: If a later modprobe fails, tst_modprobe() aborts before modules_loaded
becomes true, so cleanup skips modules already loaded successfully.
Track each successful load separately and make partial-load cleanup
available before invoking the next modprobe.

> +		const char *const argv[] = { "modprobe", "-r",
> +						loaded_modules[i - 1], NULL };

High: modprobe -r also removes unused dependencies, including modules
loaded before the test and excluded from this list. For example, removing
can-raw can remove a pre-existing can module; snapshot dependency ownership
and remove only modules loaded by this test.

> +		tst_cmd(argv, "/dev/null", "/dev/null", TST_CMD_PASS_RETVAL);
> +	}
> +
> +	loaded_module_count = 0;

Medium: Every removal error is discarded, both output streams are
suppressed, and the ownership list is then cleared. Keep teardown nonfatal,
but report failed removals with TWARN and the module name instead of
silently leaving new modules loaded.

--- [PATCH 3/4] ---

> diff --git a/testcases/cve/cve-2025-21756.c b/testcases/cve/cve-2025-21756.c
> +	.needs_root = 1,

Low: Document the new root requirement in the test description: root is
needed to load the VSOCK modules, while the reproducer runs as nobody.
The commit message explains this, but the exported test description does
not.

Verdict - Needs revision

Pre-existing issue (not a patch finding):

The description in testcases/cve/sctphantom.c says to run modprobe sctp
manually, although setup() already loaded it before this series.

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
