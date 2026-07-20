Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3426C44520
	for <ltp@archiver.kernel.org>; Mon, 20 Jul 2026 15:55:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 795AA3E9133
	for <ltp@archiver.kernel.org>; Mon, 20 Jul 2026 17:55:39 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D20473E62B4
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 17:55:23 +0200 (CEST)
Received: from mail-qk2-x02.google.com (mail-qk2-x02.google.com
 [IPv6:2607:f8b0:4864:34::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6C40210006B7
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 17:55:23 +0200 (CEST)
Received: by mail-qk2-x02.google.com with SMTP id
 af79cd13be357-92e58c462aeso620064085a.1
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 08:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784562922; x=1785167722; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xou8+8CoHAL/ywY2ckppJK3qvO0kJf77jRo9dCa9qWE=;
 b=rR0+eZRSGRK46/1q66Kdh9amNkn28b0MP4kV33ECozaxewmeFXvyGlrVuLmyGRzwif
 nYbr52MCq2Vru0JspJgNxzjQeApTqXv9mSLlcmKuhfx2TWMroRvEeDYSsSw6rtRYoa3g
 4fn6WIL+TZKGzccriWIErWEmDvz0JMjCDm/MDXk5ao9+7j8Pwgh5bGUihlziMcJY3dQ2
 +DSlpIyyzdolm8hfmvhOsfl0qHvq5E7BGWaDRMAK17c7GtSdGSWPtpFovJdWZpnfP9gN
 VET2OaipSqnbIOu0ifQt/Dtg/S1fmwIVBqqOXP+oazVllxOwZ/D3YFfS5xw1ZmjcKfYb
 shBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784562922; x=1785167722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xou8+8CoHAL/ywY2ckppJK3qvO0kJf77jRo9dCa9qWE=;
 b=TzBkHbm4fnlmV8B3Ft62vBbTSZRrmxUlA0QypVBR/8T0UpMt8j80yFepwDRDDipLUC
 rnObqO3yFiOzQGl4ZKSNAiclB8OC0ViW0CxqBtmV8ngbzSBnAYnqJG6eaCadohXpurJP
 grWbWak3p961o46YKmv6NW5xOJL6/euijXH2k4+ywJ6pkwA6SypO3D4NFiOscxK+iyix
 Ag8yLgHOMAGCAm5qHEqiiqaxEpaR+OvIk0h1z7qBcxyk75MnKw7Bhtx4W6h+yVQxk1HU
 gF6t6Am63V6+F+TcY7XhtbHpHDcAQeWqC6XhRNy5jTjwUTmf1wHiFYi+O69K4LRtsZaL
 ohAw==
X-Gm-Message-State: AOJu0YzM7Cu/1p8wDjO4PL0WLQMibt37oVQ5jbj9xm+SauQFqjkoMUnJ
 bKnF95pTLqirJfRf3TmSAOlwXF7mb41x9EuKcqMlXBaL/uiDQhZUKs3M
X-Gm-Gg: AfdE7cl+pjweLLDWYcOJf6y1+Ysa+vDoqsXbMV+lhO0oPvaGt2xfT3AKPwfiolSi725
 Fg1C7azC64Rf3WjNxKQGkTwfAwxbAtO5LhADRbgWrDwCeMVelnYNqXUAD1Mfn32D9fAHAXEZGUi
 Nwu+yeyAhZ5Ya5QRhrNEejiS97/kL3mqXNXrpKgG9LCSYL70IKD6vdjpgWSyeVRKgz3+EsaGK44
 XdmjKO4EkT4Qn17t4yyHdSU5XbxlCOcj9/mZC/Z+A2/kNlMwO6UP/uy10JqgkxH64eJyOGvnyWG
 Fg0RHmi0SpO2Q2S3ek7X9i6DPVzxGyHzzbw4ZC+ndob83+gsJxEOEPBKFmGCKRlpI3j2iRcfqiw
 5Reyi0NMNEeykkcHtSN3AHx1O/O6HmWrVTw8aGPSq2g+rO+pllmPxD7Rw7P78ywFg5+emYCZKyc
 A3FtLoW6HD55Ob1nicecpbdVGqNhb+xpk0Y6qOPFxjn9Zn/bRTe1y9bWrgPBvi+dpmhltXeQKRy
 9R9gSA9RT3dQXbyGctp
X-Received: by 2002:a05:620a:1a13:b0:92e:541e:632b with SMTP id
 af79cd13be357-930b3eaaa92mr1599898385a.2.1784562922079; 
 Mon, 20 Jul 2026 08:55:22 -0700 (PDT)
Received: from
 runnervm3jd5f.sbo4f4120sjejcpudlippbucbf.ex.internal.cloudapp.net
 ([135.232.208.132]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-930b545e47bsm916741785a.35.2026.07.20.08.55.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 08:55:21 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 20 Jul 2026 15:55:20 +0000
Message-ID: <20260720155520.4013-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260720-fix_cve-2026-46331_enoent-v3-1-9f216efdd661@suse.com>
References: <20260720-fix_cve-2026-46331_enoent-v3-1-9f216efdd661@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] tst_kconfig: add module mappings for
 ingress/matchall/pedit
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

On Mon, Jul 20 2026, Andrea Cervesato wrote:
> tst_kconfig: add module mappings for ingress/matchall/pedit

--- [PATCH 1/2] ---

> Map CONFIG_NET_SCH_INGRESS, CONFIG_NET_CLS_MATCHALL and CONFIG_NET_ACT_PEDIT
> to their kernel modules (sch_ingress, cls_matchall, act_pedit).

The body restates what the subject already says. Is there a sentence
missing that explains what prompted these additions -- e.g. that the
following patch (cve-2026-46331) needs them for the kconfig module
check to work when the features are built as modules?

--- [PATCH 2/2] ---

> +	for (unsigned int i = 0; i < ARRAY_SIZE(mods); i++)
> +		tst_modprobe(mods[i], NULL);
> +
> +	/* Drop privileges so the reproducer runs as an unprivileged user */
> +	pw = SAFE_GETPWNAM("nobody");
> +	SAFE_SETGID(pw->pw_gid);
> +	SAFE_SETUID(pw->pw_uid);

The three modules loaded by tst_modprobe() are never unloaded. cleanup()
has no matching tst_module_unload() calls, so sch_ingress, cls_matchall
and act_pedit remain in the kernel after the test exits.

The constraint is structural: SAFE_SETUID() permanently drops root, so
cleanup() runs as "nobody" and cannot call rmmod even if the call were
added there.

Is the expectation that these modules are present on any system running
this test, making the omission intentional? If so, a short comment in
cleanup() noting that module unload is skipped because privileges have
been dropped would make the intent clear.

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
