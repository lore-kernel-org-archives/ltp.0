Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 986A8C0218F
	for <ltp@archiver.kernel.org>; Fri, 31 Jan 2025 14:17:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B42763C7B27
	for <ltp@archiver.kernel.org>; Fri, 31 Jan 2025 15:17:00 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A900E3C0379
 for <ltp@lists.linux.it>; Fri, 31 Jan 2025 15:16:43 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5C768650638
 for <ltp@lists.linux.it>; Fri, 31 Jan 2025 15:16:43 +0100 (CET)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5db6890b64eso3753131a12.3
 for <ltp@lists.linux.it>; Fri, 31 Jan 2025 06:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738333003; x=1738937803; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kEewHAZNU//+FrDqztvOPs0QMyCHSPWCHLoHXQs5IHg=;
 b=bQ9zShd222M/lrf4cfkMcSeLu/ntg/EH8LfjMeZbKQOM1nN4fYxJrp1AviYG33iqkF
 mXWiMh+F1yUit5RFl7yL0aOTX4QrEz7Hkgto5mHv+0W+N+KJ8t66YgB9mYhRbYoyNsKR
 O74oOFacgIcM48rVF7cdp0149jUNoLpmByJVDR36prn9mYvwP/bpeCSvxEMSFCF2WYr0
 Ftc425G5i+bTNBz8Ly4vO9XmMcA9BScpNqpNfKCpyNvr62Hl4+aa5yNO7FuJF6uklUvO
 DkMxT3dT2GuF3TFaW700vmDYoo00Aensxj4H5Jrad91OWj4xF7INVxL2GCSZOiQvM8vN
 lr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738333003; x=1738937803;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kEewHAZNU//+FrDqztvOPs0QMyCHSPWCHLoHXQs5IHg=;
 b=EYzfiPum0dy2uCrmN8vsE9gzsuYBsT7QWcAvCblW+Jv2nKbnDndEv1ChVABZ8MNMKc
 TMAoEqgO4f4oYlxYMscOV+KZ+MZKR6jNdAo2fDVreru1caTsXKpNLgY6h+0O7qxCWzyQ
 4FUOHuCutLYA8LJoKODEOl9YtHXPAHRKVL5oj+UXrMFGfX1gBvAlqaYFiV47DuOQCRbn
 6E7c5fdj+sfX3ffWbjQ5j1TrXtQENa9D7rdmUeswKmiV3UvlCYKHVySV9QwbCMwS2Pxb
 bF2u8bnPTvkwdIWe2wJ3QhZUMamTMiHBaASpF+jEUyOheVsrIGyCho1fmCDwi2r8sKPg
 3G0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWa0ED0IoodHApZQwKOd14+JNF+8RlNmc/YP/P9A6UXz5pMv2kRKbRUnbE0tOFDlunwLW8=@lists.linux.it
X-Gm-Message-State: AOJu0YxzE5mK+Q9pyz6HSH5TDCNdwO3beLXqma74nB5bw/Zpe+QsB9nj
 5d7W+zvb/yPjNZPpDpi16sH7otysOYbwgOZg3Qby27wmr9HCsjn3BZhIoBDgGqgWDsMD5vYPvgf
 XfoawGhFTl6NtZOk/K1FjiFWoL80=
X-Gm-Gg: ASbGnctsHNTfmil5c4rCX+N/T7h1H0VsjtykrqH0E4HNq4PC51i2IwpPzPD1pQ1kw25
 vw58iDf9vOQvYwQfg6p3N6dK6d0Y3MXGZKJFFXhHLJ/KTuX5okGdVoUg6xMm9siP7gIIzzFK/
X-Google-Smtp-Source: AGHT+IFfNTt69W08/hdeHU3/+LaSUjyl4T8HBtrx5ngt8QPZ6ykGIM07PDimswqtwc8BoBRFh9nv2jVMCfWNBUgN56E=
X-Received: by 2002:a05:6402:5106:b0:5db:ff5f:333 with SMTP id
 4fb4d7f45d1cf-5dc5efec320mr12268870a12.24.1738333002278; Fri, 31 Jan 2025
 06:16:42 -0800 (PST)
MIME-Version: 1.0
References: <20250122172440.506677-1-amir73il@gmail.com>
 <20250122205023.GA48906@pevik>
 <Z5NveZVCczMxwDpP@yuki.lan> <20250130200731.GA513192@pevik>
In-Reply-To: <20250130200731.GA513192@pevik>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 31 Jan 2025 15:16:31 +0100
X-Gm-Features: AWEUYZnX8NACgofYwmCjrjjppHmjjZ0UdHtm_H8_rPB3WC-C9wAzuQnRhvyrbbw
Message-ID: <CAOQ4uxjDwVaoqWu1ix1_sv5YbkKQ8Ve+R-u37gfB4hXemNVhaQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/5] LTP fanotify tests for v6.13
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBKYW4gMzAsIDIwMjUgYXQgOTowN+KAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IEhpIGFsbCwKPgo+ID4gSGkhCj4gPiA+IFdlIGhhdmUgZ2l0IGZyZWV6
ZSBiZWZvcmUgbmV3IHJlbGVhc2UuIEJ1dCBJTUhPIHRoaXMgc2hvdWxkIGdvIGluLgo+ID4gPiBJ
dCB3b3JrcyB3ZWxsIG9uIHY2LjEzLCBJJ2xsIHJldGVzdCBpdCBvbiBTTEVTIGtlcm5lbHMuCj4K
PiA+IFdlIGFyZSBnb2luZyB0byByZWxlYXNlIExUUCBuZXh0IHdlZWssIEkgd291bGQgc2F5IHRo
YXQgaXQncyBub3QgZW5vdWdoCj4gPiB0aW1lIHRvIHByb3Blcmx5IHRlc3QgdGhlc2UgY2hhbmdl
cyBhbmQgdGhhdCB0aGUgdGltaW5nIHdhcyB0b28KPiA+IHVuZm9ydHVuYXRlIHRoaXMgdGltZS4g
SSB3b3VsZCBkZWZmZXIgbWVyZ2luZyBhZnRlciB0aGUgcmVsZWFzZS4KPgo+IExUUCB3YXMgcmVs
ZWFzZWQsIHRoZXJlZm9yZSBtZXJnaW5nIHRoZSB0ZXN0cy4gVGhhbmtzLCBBbWlyIQo+CgpUaGFu
a3MhCgo+IEknbSBub3Qgc3VyZSBpZiB5b3UgcGxhbiB0byBzcGxpdCB0aGUgdGVzdHMgKGhvcGVm
dWxseSB5b3UgZ290IGVub3VnaCBpbmZvIGFib3V0Cj4gdGhlIGdvYWwpLiBJZiBub3QsIEkgb3Ig
TWFydGluIHNob3VsZCBkbyBpdC4KCkkgd2Fzbid0IHBsYW5uaW5nIHRvIHNwbGl0IHRoZSB0ZXN0
cy4KSU1PIHNwbGl0dGluZyB0aGUgdGVzdHMgcHJvcGVybHkgdG8gYXZvaWQgdG9vIG11Y2ggY29k
ZSBkZWR1cGUKcmVxdWlyZXMgYSBsb3Qgb2YgcmVmYWN0b3JpbmcsIHdoaWNoIEkgaGF2ZSBubyB0
aW1lIGZvciByaWdodCBub3cuCgpCdXQgcGxlYXNlIGZlZWwgZnJlZSB0byBzcGxpdCB3aXRoIG9y
IHdpdGhvdXQgY29kZSBkZWR1cGUgYW5kIENDIG1lCmZvciB0aGUgcmV2aWV3LgoKVGhhbmtzLApB
bWlyLgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
