Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D39FEC55182
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 14:38:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A3873E71C2
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 16:38:42 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 720E53E4B7F
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 16:38:27 +0200 (CEST)
Received: from mail-qk2-x09.google.com (mail-qk2-x09.google.com
 [IPv6:2607:f8b0:4864:34::9])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 03AAC100053B
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 16:38:27 +0200 (CEST)
Received: by mail-qk2-x09.google.com with SMTP id
 af79cd13be357-93497257b7aso24826985a.0
 for <ltp@lists.linux.it>; Mon, 03 Aug 2026 07:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785767906; x=1786372706; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Mm1HxRHv2Xq3sbrHoSNIWDXzY3nKtFInRkdtbZn/0ns=;
 b=rHEUR6CRmhVh2l5k4MVyWayFl7DRmL6tbj8dfvxTlVWVyVX8kv4Q9Jzo35D2ZL/eRD
 TyT3/KbuJ+oLF6j43TsAAxFR/KpM7rcqs4VHT5CBkzEaXOw8dFwrEl8IeMqZTyG4hZH/
 fduIceB5Y2rqAVz/5qtEw7lxugIm4XJcPWB2EInSt43fFU1OMaxB9BkGuRPy+rkYoUnt
 HmZOXD/tdcCNQfeFNKjeFCM6QFzUqevxOPwsBDG1KToWEHb+j86PhJZRtvUpILTfAFJY
 ayElmJhqymAf1IQuXSmm/9zBy5kyObtedssNb70YmMW0V3V5g/PM2j3NoKgOUgRCtVs7
 GzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785767906; x=1786372706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Mm1HxRHv2Xq3sbrHoSNIWDXzY3nKtFInRkdtbZn/0ns=;
 b=I4/f/Ank6uoKTg1YoNlx5bChGKAhoS4LEGc03ZvMiyQnUd65dJnCQpuWPPx8LMy5OO
 tyo8TcZkblM6UcfiV8ccvRj4hQthax31H7HPDnOAfR3GDRulIW20ipuIEe+0px27rIyy
 XK2poNRHqCfd9KAd3aBI2YMGHlT3BRJSg++ZH+z8oyFhY9nAlXml2PxXeg+olAYhDePj
 /xF+pGgXqrIezQyttvQ4gbCtYTy6p5mb4m7+aizlud+sQBmSSnwkmKRaUsbECDcWeatP
 pIDh8iMo12qYe7dufolQHNfDxfcHOSpt5/ktBoCdsJsHi9o0TxM2du4k0Cxp3rfSDuvD
 w4kQ==
X-Gm-Message-State: AOJu0YwBWeMv2wdAn487NKpHouARODavDdh9h5aZjXJQ0lxTb+tg5SY4
 Z6jDTODzxi6DtdnU+t9+WAJKMtkYCeUw80u4VqrYREbP6qbVtmH0RAtf
X-Gm-Gg: AR+sD11UjMLKtpw4V0PpOxX+FDBlgUZFHBqbxyM411Hushd0lt9GG/qHEKehbc8B5qa
 v6AI2p6fxPcXuv6aem3dQZtU3VFxXosvQZqZBbw49zLFpaUBlmSR1XrW4P6Iq/GlB1JQEyWpFNm
 Y1SM1x7hV3y5hKtW9ia4sWxVPAlWWJargVBNR4tWRWSGM/a0bmMWBh1i8x2TI9zsfCjTr29pUm2
 kwO341KYReR2lX6IBIgmNOe8P/jMgPFtcgUwkQNAB7o0nQzbj5axhqgVrfSUvDpvRGkIQwROuHv
 18eyrDN8Tfs9ekSyMBdNlnj6m2nvNBzH1N6HDle+hITw8ljZEQLoMTLrgiG3r4HxccmrUi6BcZ+
 ONrwScI1bLrYjr+dGp6zt0/YUagiaar0e0x2XrhhVfhfMGmgZf1IhOHMgdmGhequzESOBi9KN+a
 +9GNHboHovlLlXIQ5spAaUE4YepghMzlASIviUosr4EeKWWMH9xcz/CY4NK84r+PEFRiQIHl1Ou
 CrqpXyGCsCphmBbfzTK0Cnr5CYDokzxawtk06v/1bL4uj3PxzVEtVuY09FmXPvf2CPhq05+BN2L
 RA==
X-Received: by 2002:a05:620a:961e:b0:931:403:2442 with SMTP id
 af79cd13be357-934a07a1fa8mr1537548685a.18.1785767905669; 
 Mon, 03 Aug 2026 07:38:25 -0700 (PDT)
Received: from
 runnervmvrwv9.asza5amywjqudnrwvdv2p0ydkb.bx.internal.cloudapp.net
 ([20.172.192.243]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9349bc4bb8csm689057685a.12.2026.08.03.07.38.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 07:38:25 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon,  3 Aug 2026 14:38:24 +0000
Message-ID: <20260803143824.9095-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260803-cve-ghostlock-v3-1-cde83fa429b7@suse.com>
References: <20260803-cve-ghostlock-v3-1-cde83fa429b7@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi/prctl: add more fallback definitions
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

On Mon, 3 Aug 2026, Andrea Cervesato wrote:
> lapi/prctl: add more fallback definitions

--- [PATCH 1/2] ---

> +#ifndef PR_SET_MM_MAP
> +# define PR_SET_MM_MAP	14
> +#endif
> +#ifndef PR_SET_MM_MAP_SIZE
> +# define PR_SET_MM_MAP_SIZE	15
> +#endif
> +
> +#if !(HAVE_STRUCT_PRCTL_MM_MAP) && !defined(PR_SET_MM_MAP)

Could this struct guard depend only on HAVE_STRUCT_PRCTL_MM_MAP?

PR_SET_MM_MAP is defined immediately above, so !defined(PR_SET_MM_MAP) is
always false here. Systems missing struct prctl_mm_map therefore skip the
fallback even when HAVE_STRUCT_PRCTL_MM_MAP is false, and the second patch
cannot compile there.

--- [PATCH 2/2] ---

> +	SAFE_PRCTL(PR_SET_MM, PR_SET_MM_MAP_SIZE, (unsigned long)&sz, 0, 0);

Could this test set .min_kver = "3.18", or report TCONF when this operation
is unavailable?

PR_SET_MM_MAP_SIZE was added in Linux 3.18, while
CONFIG_CHECKPOINT_RESTORE predates it. A 3.5 through 3.17 kernel with that
configuration reaches setup(), rejects this operation, and SAFE_PRCTL()
reports TBROK for an unsupported reproducer feature.

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
