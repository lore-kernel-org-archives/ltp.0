Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE84C5AD55
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 13:10:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 08D5E3CF918
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 15:10:34 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C8B6B3CEF0D
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 15:10:17 +0200 (CEST)
Received: from mail-qk2-x08.google.com (mail-qk2-x08.google.com
 [IPv6:2607:f8b0:4864:34::8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 879A014004EB
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 15:10:17 +0200 (CEST)
Received: by mail-qk2-x08.google.com with SMTP id
 af79cd13be357-9349a22b22fso34308385a.1
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 06:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786367416; x=1786972216; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QBSkHyoGoIl/dgffvtuXY0oSR1lmn84vsvlU214oCbk=;
 b=OGM9ShPyiDeXo/TLppyhO6nNKJlHj/U16+kxh6Bbg3R0TEEeDI4AxZY1iH5QvuDS5t
 0j+NV7kIK/g/cBpjqY8vONP+hlMELwAnvg3rhbtagcDPxyZmgZxuB/oBOExIGYo2QRqY
 chQpOnz/rTFKw09vctx8XanpIvgwHzKTetsGIGIZbuv0YM7M8nHhRF6DkjkVXk5gi9d5
 mvxewSCwT0MzQE3LUpgLug1or4vVudtQBc9FPM52GCObqzM4JGWpAQNtUnGRk6DLpIlA
 Fa1WLlf+b1YgOvv7QJWh+OUunfRnPP/bgvkyQE+9S1/LNnZSoP0R+IK9pyRyMIkxzpMG
 UiHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786367416; x=1786972216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QBSkHyoGoIl/dgffvtuXY0oSR1lmn84vsvlU214oCbk=;
 b=G2FU2IRb3ApGKVst2Y33fm3Z6Wq2U4nr0HVPzwnGxzgwW4IZ8kt4QZB/eVGfuWtuMN
 TD4G1TKFqAMP/8mo38yefoNKgH0JD8AybJnn8JvC1VODq1MAwQgaFgVkRNxQZk3KrJw+
 Cwb9ugSYS4+nGSmj100HbJLMSvQsMrTPKHmmnZnKp6UkfdzP5K/ldcYs9w61x3KwUKU5
 os8FFzIk0xkAVhD0wSvSlGQQzOHhrTNxWb3pDFpXy4cAaKT4ncrueogfwXTufoZAkMsW
 3L+4bWSojI8/MeWwXnLTDOgrEP2lMDxtjnZAFOiJCMglSZnMETzZW8i+78GNqVsLn1ZD
 9nGg==
X-Gm-Message-State: AOJu0YzSRyUj+J5BV9n/G9LKLh4IapKNMEMCLmakhnhLfdVODdyFICC7
 h5BCAMi0byudAmL0nyx9HlDd2krVuC8VQjPFKho0J/ggkCg7T54invXW
X-Gm-Gg: AR+sD13Zfjiy3PdzWDHLISHosfkoIq18MiNlVcGxe9kGYWGOYZ/IYg9m96AFZY8y7Hb
 QBSwyirmpVbwIXf8UWRaeoM3Jib/lvBXEDYz1451/GXrLheke4lJslqmCRFQgK3kAUURKHJ05y1
 1SMo8X6d9kd0liwt6J8lQSBDy1f5vFLmIHo73XkyoJ1SGpgTz+fpbZac16VxC9Uxkm+oOHRqslh
 5qxMchc/YCIqfJQoWB/bYbEh81t5919bTV63L1va33+dJV5n9zUBmze0NOaiSAi7qcJL+I9nHVC
 uoq8qo+UjpITP9/1F3bYshhfUKXcdZimot0MNql7c+vHdmru2jtmTmzBixDAhNkBSjxOup+omPF
 0TCmwr1AB0QLm1vfdA+qwmrmwUTDPLpCldQ7CWdgqEcc77mDYZJtXre5i1XFa9CqPXUWPW33fNp
 cfF9FGWwGF1Hc9n1hpnyC1r4cc2W0WUuORHwzuuNlDjTqnbpJiPXsQSzbdPUg+9We3ahbn8eyi5
 lKwnEHryfzSSZyrqVgW8YMaDy4XLbpohJu7wVD/7svvAwREzyN9fTM6Ygr8jTeTEcsnskqk+rBW
 N64=
X-Received: by 2002:a05:622a:406:b0:528:38b1:b547 with SMTP id
 d75a77b69052e-52ce5f63df0mr433070151cf.8.1786367415791; 
 Mon, 10 Aug 2026 06:10:15 -0700 (PDT)
Received: from
 runnervmvrwv9.o5uvs2yvdcze3ixmawegsz4hpa.bx.internal.cloudapp.net
 ([172.172.205.208]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9366e03230esm782156285a.5.2026.08.10.06.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 06:10:15 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 10 Aug 2026 13:10:14 +0000
Message-ID: <20260810131014.85243-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260810-shell_oom_protection-v4-1-4dac0dbb0414@suse.com>
References: <20260810-shell_oom_protection-v4-1-4dac0dbb0414@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] shell: enable OOM protection by default
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

On Aug 10, 2026, Andrea Cervesato wrote:
> shell: enable OOM protection by default

> +	if ! echo "$value" > "$path"; then
> +		tst_res TWARN "Can't adjust score"
> +	fi

Could this avoid reporting TWARN when CAP_SYS_RESOURCE is absent, as
tst_memutils.c does? Lowering oom_score_adj requires that capability, so
every unprivileged shell test now gets a warning result. The new self-test
itself reports TCONF but exits 36 because this TWARN remains counted.

> +	(
> +		TST_CHILD=1
> +		_tst_disable_oom_protection
> +		trap '_tst_cleanup_timer; _tst_write_results' EXIT
> +
> +		if [ "$TST_ALL_FILESYSTEMS" = 1 ]; then
> +			_tst_run_tcases_per_fs
> +		else
> +			_tst_run_iterations
> +		fi
> +	) &
> +
> +	wait $!
> +	ret=$?

How can the protected parent perform cleanup if this child is OOM-killed
or times out? TST_DO_CLEANUP and TST_MOUNT_FLAG are set only in the
subshell. On an abnormal child exit, the parent therefore reports TBROK
without calling TST_CLEANUP or unmounting a device mounted by
_prepare_device(), leaving external test state behind.

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
