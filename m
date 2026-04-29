Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC34FF8867
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 12:26:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B1B9D3E2D98
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 14:26:34 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 41AE43CB251
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 14:26:14 +0200 (CEST)
Received: from mail-dy1-x1342.google.com (mail-dy1-x1342.google.com
 [IPv6:2607:f8b0:4864:20::1342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B5B981400C6B
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 14:26:13 +0200 (CEST)
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-2d96243c91fso20481984eec.1
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 05:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777465572; x=1778070372; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TN4/5+Yg45F/V2QpwFVkPUcsG788Do51T9tx25Pyefs=;
 b=MP9sa/vhLFkl8H5RcCohJH9GlixKuJX6WArPgJN7cytcjD4HcCtsyYxcY/HNSXQSJV
 0AQI9M2UAGPb3JrJ19y5Xv0d5nsiTJGJpVVhA9ynuo3Ilf65NFhdKYNo3N4MMwf84q1c
 Hf9hIcsuOVLomNMYsH3b3RgGBJbbUIoJUdBBWpn0z8YLlboKJUfuoc/VOerNd3vTTuvq
 BK65y91VnVGRCkf+AslxdjVrKf+IyZ53oYAN45/KORBPr2kpC7tHPXf7o8P7YYRqPrb/
 MVV8dl3iO0hYYvXxIQaIkgDWf+WtipC6FxTBpuTjai1KbsHETaioDs3pEaV0GGKjtwnd
 Z92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777465572; x=1778070372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TN4/5+Yg45F/V2QpwFVkPUcsG788Do51T9tx25Pyefs=;
 b=U5E2a7R0BesjsuQBLkSJYxjpaD6CfCV0tHMZLaI8wVyp5/+vdhlSW4vmOoK4Ld/CIW
 Y5xOobscOxL+eDK5OZu+aFX4prCTfNTBizHViOtJk33zMAJekcbbhX4Kv/N+6I7eoGCv
 bVBOtDApEbkBqfZ/yDXziNctNavDIyEV9lO64bbOO4SG6zR2hwOYow9Y9kazgSgyUUFo
 WXYc8XO6K71oW1AXSsrdbur8qrkhwMFCm2UWSNg+8uk2GAAPj2qyICALDfFCLiTKv6ut
 QsEnGxuEg/W+OetM+KBy+k+0kX142v1sYiYXWFpBPCOpORPUYVsvhsLQNYS3uKw6ViPO
 1U0Q==
X-Gm-Message-State: AOJu0Yy4Hud68rud9exHIjVEoTjs6o3Uul8echxkhxzRcQeIOcSfKTk6
 M9kBfyoZR9qx7ly57imaXMcfS03cTXW8sPv8hAywkzNiTtmfxwxg/hiL
X-Gm-Gg: AeBDietT9BsC35P7kxLxXqjUubQMmZxynQ6wcsi1c12dfHl8Zwr0wPd/X+r8WQEqZ/U
 s8WuO0gA74KgUZ6WmA+LEVDU7aCNNLo6h5VBrd0/K31aELAamhA0x+HD0x4g7xjiCiFw9lHz6MJ
 C/czBOoq0M+uujOsZhJAZuyLZ2l5nh+wTXNPCkpmI10Xw7IKjHzhckn+ZtT54QOatSTKgLXYB4I
 JjvqC86FCih4X1F0ueQpaC3MrbuXEwqUruD8K1rLFPRmq9FFHHegAhexrgfzinrcwmL3Ofgg84p
 lD7xnbjUo0HXfz4QoxUuUfCGRgRBk1gRipZ5kRyOq9Kk4ZK0AybFdiR3Qi+M8w1L+tLjI4t3ZSv
 GSSE5n7TanZ/LbOA0B07sfvNLEdBsvXAOkVJcIopqtKIAWHB9IAEqE3wUFFb85MTR6nXwSJcRAc
 wd49HoHN0XkhmNEiL/aJQjdWId+uPDUFg5KB+NSQ178iVp9KGrw0eMSu8Ruk2cd2zh/o08Ph3o5
 q96FY3/84uvA4OZ3a9XCDehZa8Bwh7kUXy8dISRCPiZZ/j4Yg==
X-Received: by 2002:a05:7300:2141:b0:2d1:299f:521a with SMTP id
 5a478bee46e88-2ed0a1871a7mr3327881eec.26.1777465571913; 
 Wed, 29 Apr 2026 05:26:11 -0700 (PDT)
Received: from
 runnervmeorf1.aemngpi4zd0ubehhx3cejhsp4e.dx.internal.cloudapp.net
 ([52.190.141.35]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1c0e9a89sm2568560eec.31.2026.04.29.05.26.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 05:26:11 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 29 Apr 2026 12:26:10 +0000
Message-ID: <20260429122610.4065-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429121129.21911-1-mdoucha@suse.cz>
References: <20260429121129.21911-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] icmp_rate_limit01: Fix rate limit change on older kernels
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

SGkgTWFydGluLAoKT24gV2VkLCAyOSBBcHIgMjAyNiAxNDoxMToyNyArMDIwMCwgTWFydGluIERv
dWNoYSB3cm90ZToKPiBpY21wX3JhdGVfbGltaXQwMTogRml4IHJhdGUgbGltaXQgY2hhbmdlIG9u
IG9sZGVyIGtlcm5lbHMKCj4gKwlpZiAoIWFjY2VzcygiL3Byb2Mvc3lzL25ldC9pcHY0L2ljbXBf
bXNnc19idXJzdCIsIEZfT0spKQo+ICsJCVNBRkVfRklMRV9QUklOVEYoIi9wcm9jL3N5cy9uZXQv
aXB2NC9pY21wX21zZ3NfYnVyc3QiLCAiNTAiKTsKClNBRkVfQUNDRVNTKCkgZXhpc3RzIGluIHRz
dF9zYWZlX21hY3Jvcy5oLCBidXQgc2luY2UgaXQgY2FsbHMgdHN0X2JyaygpCm9uIGZhaWx1cmUg
aXQgY2Fubm90IGJlIHVzZWQgaGVyZSDigJQgZmlsZSBhYnNlbmNlIGlzIHRoZSBleHBlY3RlZCBj
YXNlIG9uCnByZS12Ni4xMiBrZXJuZWxzIGFuZCBoYW5kbGluZyBpdCBncmFjZWZ1bGx5IGlzIHRo
ZSB3aG9sZSBwb2ludC4gSXMgcmF3CmFjY2VzcygpIGFjY2VwdGFibGUgZm9yIHRoaXMgZmVhdHVy
ZS1wcm9iZSBwYXR0ZXJuLCBvciBzaG91bGQgYSBkaWZmZXJlbnQKaWRpb20gYmUgdXNlZD8KClBy
ZS1leGlzdGluZyBpc3N1ZXMgbm90aWNlZCBpbiB0aGUgc3Vycm91bmRpbmcgY29kZSAobm90IGlu
dHJvZHVjZWQKYnkgdGhpcyBwYXRjaCk6CgotIHRlc3RjYXNlcy9jdmUvaWNtcF9yYXRlX2xpbWl0
MDEuYzoyMDMg4oCUIHNsZWVwKDIpIGluIHBhY2tldF9iYXRjaCgpCiAgdXNlZCB0byB3YWl0IGZv
ciBJQ01QIHJlc3BvbnNlczsgY29uc2lkZXIgYSBwb2xsLWJhc2VkIGFwcHJvYWNoLgoKLS0tCk5v
dGU6CgpPdXIgYWdlbnQgY29tcGxldGVkIHRoZSByZXZpZXcgb2YgdGhlIHBhdGNoLgoKVGhlIGFn
ZW50IGNhbiBzb21ldGltZXMgcHJvZHVjZSBmYWxzZSBwb3NpdGl2ZXMgYWx0aG91Z2ggb2Z0ZW4g
aXRzCmZpbmRpbmdzIGFyZSBnZW51aW5lLiBJZiB5b3UgZmluZCBpc3N1ZXMgd2l0aCB0aGUgcmV2
aWV3LCBwbGVhc2UKY29tbWVudCB0aGlzIGVtYWlsIG9yIGlnbm9yZSB0aGUgc3VnZ2VzdGlvbnMu
CgpSZWdhcmRzLApMVFAgQUkgUmV2aWV3ZXIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6
Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
