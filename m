Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E27ACD6E4A
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 08:06:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 801FE3E54DB
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 10:06:31 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 31DF83C4B72
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 10:06:13 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CED366008C9
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 10:06:12 +0200 (CEST)
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-43cce34c881so361818fac.2
 for <ltp@lists.linux.it>; Thu, 04 Jun 2026 01:06:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780560371; cv=none;
 d=google.com; s=arc-20240605;
 b=Y1M1nJA0jJ7zgTeRy0WngdgbWcYn+MbbddNO4YJhSqSOIKFu84j4B/+IR7MK6FiMon
 dAqfo/kLqsDnK41byRVIaeLRRP4D1VKOPCIohKj3Bd/TMUo+bwLuf9Em0KqnIZrusZkn
 AODaME58dEaHqZd2MeiGNsEPdsTHMDRsV4XcohKP6+Wh4XE7qDqaSFmv9w8oWUyS4MED
 MEQJICGAI13FmfIPsaK2kMPLKRKWsqlYU2F7w1U57URfxRfGx1DteVjxoJKgRtddc8dB
 mBRyoz2ABWBxTxMYKKb1hypn/T2lU49hkaWbjwGK3und4kPw/IUy0pgPS69YhLljp+WA
 yVTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tAMeBuujDIY7BvXfJPMOaOPQoWtu+UoU4rkhfZ7t5y0=;
 fh=CtANDuKPIj0v88UI/q53VwcIw+6Tu5LcBkgNvW2iY8U=;
 b=a917YAoiNPrV4PhKXkOy1JVHUw1T0F+NSLuI8TRov4j7jO21R/S5T1LA4v9wDbGXAq
 skbz0effPFnVQP7bgTtMzWI1tL+LrENQY5dm5GfD8+Ya/5X8M4R11s1OK6LUdH1g+EYC
 htciVypd1K3lMAiv3aex02Rv2gBNcPW4MvRuuZ6Up8OQb2zdFcxoG1h1/SvvCaxr9zhb
 JFEnXzirhXLwu4EY0//zGIHMrRob2WjO3DprsTjYfO6weH2dzFQQh5BwxhkW1mSXgGET
 YLXqJGmLFwZrhHLOW5uNiecPMmcgfZnKSd/l5XCEy4bFcG8/VFJsxYuSUXWYPRWsySAE
 BoGQ==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780560371; x=1781165171; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tAMeBuujDIY7BvXfJPMOaOPQoWtu+UoU4rkhfZ7t5y0=;
 b=GvYsNLty1jOZP1CufzExVeEjV8ZCZVeBXndJXjc1pS/+0LOzt9DkSMaTuU9R/d8rNd
 8dPyiN7ZsMqoZElzqk5j8u0fHwcSJss9acvzUKtcV/7Fw2OhIm71w3soDaLwu7znt+YZ
 ffYZZ/4FAFJSkQxKDlWw8SajxOli0tN/bZb21vQsTLsRG2fk/3DSv+A7bc38zCGN3bbb
 qr2uM135fn30NA4Oypm1piKnrRfyEitJ40O+7ML+h/S7Ku/qBiGAw60J19nBuaXtESF5
 nE85DrNSY+L/ypKWOpv+V9aUTcX8xfCxHwVS7U+CQIpM/SQD54CvYun9odtEw7KaOaB4
 KXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780560371; x=1781165171;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tAMeBuujDIY7BvXfJPMOaOPQoWtu+UoU4rkhfZ7t5y0=;
 b=N+rLlA6ILd7jZ+pM2+GxY5lkuJUclCIahd5tyfZbddCnNFbxmmCxWvK/F1scGiJemW
 5M4ejoq9n6cNwdfeuMfd/E7qt1ZTI+0ADe8rJAxh3qoZCXjOt7AvzJWDY0iqX5Hbquru
 oC7jvhZ/sYw16J9YkFtoWhgZyUPPgbV0JLixm0ml6R4TimkNCCS4Xjbc98PcmDGiIXH0
 0GlJJzhTstMAH9837prLqtfjPMg557uKyswWABfV2WZQtWDaT2xJH22uc/w46kaVcncC
 hFSmqHyQTL7ZeOBcunVmTr+RemqwC2YbJrzRX9AkqRWT0OGPxHz/m+P3mvMC5NBm+o4w
 1efQ==
X-Gm-Message-State: AOJu0YzmwQ/+dRWKAfXjwJ3TzLQ1gmYmAiQKrVQzIRX+oi6MwTrV29Jh
 0mIwWgqgBq8BMSdkPVVJv2TjlG/klEq+HZ2Ige9bcPGTM6ndiv343pNkWLanXEi/Ws/YAijvwBE
 T8bfHOq07LFtTOvtHY7bBNUbVcuFVu8TJ/IoVfeU7SQ==
X-Gm-Gg: Acq92OGo8b7QJI/LJJ4Xm+91dJEgkq2wJZptGeMyrH8bpYILjgtsggwD2OhYR+nM298
 pH0BRf20nQd+s0EFof9zjTy4I6ESKGrqp9N9iU+mjWzWtMTtBWyd2QemXizb04q1fp8LxsHScg9
 Lc6srkFzlFGcCXj4fzsPVMXI7k4lx9sa7hAcvjkhSqBmEzMzxWb6NvkgRgNgGbseSOCTXrECfCj
 0e+ES1RSDxAsMj3VyiMXvWeb+Vtv35JcFmL5Wn5BuUuLAvulXHz06TFnipiTmzGDIZNZu8SOsBT
 PwGtK0xHScTWWek1WJhoSss9QCMITzgov0REoO1iEJXWeg8=
X-Received: by 2002:a05:6871:2218:b0:439:f6c7:586c with SMTP id
 586e51a60fabf-440dba78078mr4615413fac.25.1780560371342; Thu, 04 Jun 2026
 01:06:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260602064442.718507-1-wxl18715129466@gmail.com>
 <ah_65vifTFw0LNy0@yuki.lan>
In-Reply-To: <ah_65vifTFw0LNy0@yuki.lan>
From: xl wu <wxl18715129466@gmail.com>
Date: Thu, 4 Jun 2026 16:05:59 +0800
X-Gm-Features: AVHnY4IKSIFMzghewD3dt1cmMiCum0RNO_a3a9uUYyHDwYRtC5NMJh1qHaFfLCQ
Message-ID: <CANJThoG6kuQ7tAqMr3JVMuu7qu8QZXMqDTU27skohpB37k8xJg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] syscalls/unlink09: report unsupported inode flags
 as TCONF
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

ICBIaSAsCgogIHllcywgdGhpcyB3YXMgdHJpZ2dlcmVkIG9uIG50ZnMzIGluIG15IHRlc3Rpbmcu
CgogIElmIHRoZSBza2lwbGlzdCBjaGFuZ2UgbWFrZXMgdGVzdHMgdGhhdCBza2lwIG50ZnMgc2tp
cCBudGZzMyBhcyB3ZWxsLAogIHRoZW4gdGhpcyBwYXJ0aWN1bGFyIGZhaWx1cmUgd291bGQgYmUg
Y292ZXJlZC4KCiAgSSBzdGlsbCB3b25kZXIgaWYgdW5saW5rMDkgc2hvdWxkIHRyZWF0IEVOT1RU
WSBmcm9tIEZTX0lPQ19HRVRGTEFHUyBhcwogIFRDT05GIGluIGdlbmVyYWwsIHRob3VnaC4gVGhh
dCB3b3VsZCBjb3ZlciBhbnkgZmlsZXN5c3RlbSB3aGVyZSBpbm9kZQogIGZsYWdzIGFyZSBub3Qg
c3VwcG9ydGVkLCBub3QganVzdCBudGZzMy4KCiAgVGhhbmtzLAogIFhpYW9MZWkKCkN5cmlsIEhy
dWJpcyA8Y2hydWJpc0BzdXNlLmN6PiDkuo4yMDI25bm0NuaciDPml6XlkajkuIkgMTc6NTnlhpnp
gZPvvJoKCj4gSGkhCj4gPiBJZiBGU19JT0NfR0VURkxBR1MgZmFpbHMgd2l0aCBFTk9UVFksIHRo
ZSBmaWxlc3lzdGVtIGRvZXMgbm90IHN1cHBvcnQKPiA+IGlub2RlIGZsYWdzLiBUaGlzIGlzIGFu
IHVuc3VwcG9ydGVkIHRlc3QgY29uZmlndXJhdGlvbiByYXRoZXIgdGhhbiBhCj4gPiBicm9rZW4g
dGVzdCBzZXR1cCwgc28gcmVwb3J0IFRDT05GIGluc3RlYWQgb2YgVEJST0suCj4KPiBUaGlzIGhh
cHBlbnMgb24gbnRmczMgYXMgd2VsbCByaWdodD8KPgo+IEkgc3VwcG9zZSB0aGF0IHRoaXMgd2ls
bCBiZSBmaXhlZCBpZiB3ZSBoYWQgdGhlIGNoYW5nZSBJJ3ZlIHByb3Bvc2VkIGZvcgo+IHRoZSB0
ZXN0IGxpYnJhcnkgaW4gdGhlIHNraXBsaXN0IGhhbmRsaW5nIGZvciB0aGUgb3RoZXIgcGF0Y2gu
Cj4KPiAtLQo+IEN5cmlsIEhydWJpcwo+IGNocnViaXNAc3VzZS5jego+CgotLSAKTWFpbGluZyBs
aXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
