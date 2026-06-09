Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F56ACD8CB9
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 15:59:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6BFEE3E2204
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 17:59:37 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 59A623C230D
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 17:59:21 +0200 (CEST)
Received: from mail-dl1-x1241.google.com (mail-dl1-x1241.google.com
 [IPv6:2607:f8b0:4864:20::1241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F365520174C
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 17:59:20 +0200 (CEST)
Received: by mail-dl1-x1241.google.com with SMTP id
 a92af1059eb24-13809223fd4so5231939c88.1
 for <ltp@lists.linux.it>; Tue, 09 Jun 2026 08:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781020759; x=1781625559; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S9kYUypQgz0ydVoEJRJeK5qLJdRh2MCD2YgbAGaFVKA=;
 b=kzsO5HOJLBUC0RmdPU6LNeQ1TTo/SPPOWaVFFlde5IzBa2M28c6PkdLW7RNotHxhuC
 7+Fv3V2R6Q4OxxhTPXUVH7MiVNMEVEgot4hf+zAZk3npV5xar+s4hsYKumeb92aNA5OF
 ieGjeQ0PTt3J5OzfLZJSJQiyQuc9ENgm/vb13+H1PtoS2Rg8Pzdq2SelTFgkrWB3wvEa
 tc8hX5U0YarXX2xW/VIGd9yAJFNH9LfIJ/wKCv8Jhz8r672PD/8qvPIbSLD5CSkWZ0/4
 VLUKktTn+cFavxTV2WMyXkRqpwcQ3jGgbCPnOWEWA2DmUW7wAsIjpvTLJgZwXHBPznnJ
 FtIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781020759; x=1781625559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S9kYUypQgz0ydVoEJRJeK5qLJdRh2MCD2YgbAGaFVKA=;
 b=nUVPF/9uoSDE/L7FVpSepjzy+hRi3IgVCb7BNSGmLuChHeoWzkHYw1a2h5cTYduH6x
 HsTQI+n9qNDUx99uq810u1aAZqqAG35/pctgVufXBjOQKy3MHdR2TVJOjhS2GcCalf8f
 OQDMUSkgkgYkH/Wtsd55XD1PVzRr49jYC/xL/W1l/fMWoRoOM/S0uaT6hhVgGo5BGkBP
 c4ZKTLOEogdrrdz7C9QHhdaBdYUh3CIeKG7oevCDlFLg1FVXaVAfKOyh0le4lRf8P67o
 VU2pbMqRuuC2HrxdTKh4APlGtFbyH909aMhTTEFukc0olaohz17HT+RFUdZd23IQBb4M
 t6qQ==
X-Gm-Message-State: AOJu0YwmFzYl4oiRg64exKDX3NXRZ0CrGYbsnx3WkxehMqTzbOVRR+Sb
 2GMAGFXUmIceOVXeUKVPAvoTDxBonnbkExwydXuhbkNVT6+p627M2k/TEkPyPWRc
X-Gm-Gg: Acq92OHFdZdBGx68dyotwcfzS6LQZYw4w6UGRvPag7/Kw43TCmrwYtn49qEFJm/ULiH
 uR6x76FW4nfhnXiC+eQkxRoX9vjTWsPjV0B7cf3traumGCWNNfIpWzQOxJAhT5FWm2b0I3lpEuX
 975poLPpxIxvbwrBPk1tD1b6HfHYQc59BhPtR1UtGHjRJuUbcjY9OAfLCC7/2iTfOQpD9XZ7Zry
 m3dYAdxCl+xWo1O0N5bjCxYTuZ/uCNX/iRY9f9eoa9ErqYGEhujONnBcI/aLLZwS6Evpo78na/w
 pMdHb2VyY4qkpFKXjEVX2/6e8VBkF3/ygtt/54wpmqWNk3bWMDmawOfMSt9rrAM6qtPTPf0Lp4N
 W1vGtzi1lq02J38p5Yl3X3DkYakG8NkQu06v0udo5pOTQ2eeRELaiukQ+v1kGwnxl/JcF+wvUFU
 i3QYP32D68waTkcE+kiqHnvtHMqFxJktvZLbIPIZXE9i5+pgKgWg38SolxTi/VH/QPjVBMyONlX
 gWtjrqgCIGb3o42Q7BDyIJQ+4T9ELgTrXyxhaiEWWaQ1UNJog==
X-Received: by 2002:a05:7022:fb04:b0:138:51c:c5bf with SMTP id
 a92af1059eb24-138066c6ab3mr11753156c88.15.1781020759073; 
 Tue, 09 Jun 2026 08:59:19 -0700 (PDT)
Received: from
 runnervm3jyl0.gnhpge5vftzudnp2qhfvddkv4a.dx.internal.cloudapp.net
 ([68.220.58.149]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f549bbefsm16079618c88.4.2026.06.09.08.59.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 08:59:18 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  9 Jun 2026 15:59:17 +0000
Message-ID: <20260609155917.3996-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609143237.1246776-1-chrubis@suse.cz>
References: <20260609143237.1246776-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] tst_test: Add needs_cpu_vendor to struct tst_test
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

Hi Cyril,

On Tue, 9 Jun 2026 16:32:37 +0200, Cyril Hrubis wrote:
> tst_test: Add needs_cpu_vendor to struct tst_test

> This adds a generic implementaiton of needs_cpu_vendor to the tst_test

Typo: "implementaiton" -> "implementation".

> +const char *tst_cpu_vendor(void)
> +{
> +	static char cpu_vendor[16];
> ...
> +	ret = FILE_LINES_SCANF(NULL, "/proc/cpuinfo", "vendor_id : %16s[^\n]", cpu_vendor);

Two issues with the scanf format:

1) The width specifier %16s allows writing up to 16 characters plus
a NUL terminator into a 16-byte buffer, which is a one-byte overflow.
Should be %15s.

2) The [^\n] after %16s is treated as literal text to match, not as a
scanset. It is effectively dead and does not do what it looks like it
should. Either drop it, or if the intent was to match characters
including spaces use %15[^\n] as the conversion specifier (but vendor_id
values are single words so %15s should be fine).

> +	if (tst_test->needs_cpu_vendor && strcmp(tst_test->needs_cpu_vendor, tst_cpu_vendor())) {
> +		tst_brk(TCONF, "Tests needs '%s' CPU to continue have '%s'",
> +			tst_test->needs_cpu_vendor, tst_cpu_vendor());
> +	}

The message has a grammar issue. Something like
"Test needs '%s' CPU, have '%s'" would read better.

> diff --git a/include/tst_cpu.h b/include/tst_cpu.h
> ...
> +
> +
> +
>  #endif	/* TST_CPU_H__ */

Two extra blank lines were added before #endif.

Verdict: Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
