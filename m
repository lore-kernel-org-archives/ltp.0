Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09785C83F17
	for <ltp@archiver.kernel.org>; Tue, 15 Jul 2025 08:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752569200; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=iNL3cR3Gw6FyrC103nbmll7rzD14lAfH02jFzdQcawI=;
 b=fxHb61VJaE2kx310uP5baF9TsjapvNm+Bw6kiWy+xR+Zxkq6tOHqV918H2oNHGL5cQiyV
 1JI1Y3K7gPDfmHlflmXcAiCHAnNx0okzsD1rbOhe6lnoihhxeenz39WEG6MTwoiObDlA4uz
 U+o9KQAlCU5PIHr5p5Is9nhkm8Kt2sA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 57D073CCD18
	for <ltp@archiver.kernel.org>; Tue, 15 Jul 2025 10:46:40 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C1443CCC51
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 10:46:19 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D0B511A00A22
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 10:46:18 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-455fdfb5d04so16371495e9.2
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 01:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752569178; x=1753173978; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U19n+nm+o1HhQMUD8p26yuOwT9r+hHgl1FzpvMtx3OY=;
 b=SeDQSpKH6QeVTKUp0GRuhbAzfB8VWNIICghccEqLo7oEZdz5Oisw06QABjPEKuUB6s
 u8kObK0dJhrnHgIuZO1i09IA4wvRYRrVxJVZvQ1V89HCdvi8wEgUJOe8STmjbDaLzj8+
 ieXq2IZOsa5rTdd3mFgvqasTK+M87kVcj08H+zJsA16Yshra1DWCSpjQ4eSl8vI17Bt/
 sH/KnOEyRCMHIpuNrC7u+yNGKhNVIID/zmuTuJB+Jk6kvGJiZX8k/hw/odB86Pr1K/ui
 CeEcOQKsWr17Occh8cMkjY1ZkX7mMiHoZC6Ldivxvz9+8B93mTqdeVD3UKQTUkuvOZQO
 KBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752569178; x=1753173978;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U19n+nm+o1HhQMUD8p26yuOwT9r+hHgl1FzpvMtx3OY=;
 b=FOKLC7STRoqCfdreyYjNHsFmVzRIhmVEiWBaUFLYiJMMeAKCRXIN1HubAUZS2z005+
 rn6Gs3MFE1DIkLRXix5BYIY3Z5LeHkMz4b1ODanmeyAy4o3hNW+rN6+X4Y5Qs6vfhclx
 J1FJ859p3w89f3wjODvfPt2cd7WFjawXzPg4wq/vgN+3DuHTco8awEDnaoIevjiGChCd
 iXuxDPb27u+Jff50GqO4MS0W5xMKHU4BGlfMrUC9QAUthqximcEsouwYSCYYXlnyfqBa
 egtKlGd2EiWfW7xKxW2dctmJXo4881z5TaaY2Woprl46MhRatH4mDR98pcK9l/U7H8CB
 PzMA==
X-Gm-Message-State: AOJu0YxJvv8k0sfp4ADmiOMnDfX66kCF+b0uslRudy5xK4/v/Z5lByS/
 3aPCmuQHwApE7viLEafPr26Y10FWs4RiKDQnYwtb/PZjtsgL/mUlcDr3AElQn+1Nd7HTqcy9g/Z
 aqIFt758=
X-Gm-Gg: ASbGncvwWQYk4Dq6fT8oHXE/CvsNfEltYO3dMrNGtBSrLB7ly0S6w7uWTXE7UBa1aKP
 okNN+GLqLHa9jxH5K/m/oJt6L4z8XEtN/2EB60gLQ5wsGTx903swxxUrL88Pz+OvNmwjCUFc+8K
 h7/gBnzvMYkF0FLyo/xYksR/BFh4pKoH5RDgZM7myVtBcOhNWkAG6ve/29ZvASF5y5o8PiRL1W5
 xtt8/Z3ocN2IiKQK5n+avScCIFVwHFZLH5C0SNmkoqAK4uvDpASRqYBdrWDvwd1AQU94xac/0N7
 KG7BzVRu3cxHw+2KG5wezaF7RFm+FUmrhM3g6mRMkAtacHiH4UjK3HR8a/hRobkvCSv36cX1yME
 /y5FDdgcKaOHBnhCnGhgi33MZB/CfKeYv737ZFaaaBbT/plQtE2lxdcjFC1PARUWsJkBToOujOY
 Fh/L4sl3Ve7k5kXaKcR/C8Sc5p8NMbKcoOK/Tk+R6Ai36QlggVS99psWSLhyuCRg==
X-Google-Smtp-Source: AGHT+IG6LKbbcWayLg/jzkjfmaM7sbWp4U5hnNLOUxOAm5x9v5ojp0UGkNCvrnwzF1sdLFzyHzwfUQ==
X-Received: by 2002:a05:6000:26c2:b0:3a5:2ec5:35ba with SMTP id
 ffacd0b85a97d-3b5f18b3d1emr12212652f8f.30.1752569178198; 
 Tue, 15 Jul 2025 01:46:18 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454dd43912dsm157143535e9.2.2025.07.15.01.46.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 01:46:17 -0700 (PDT)
Message-ID: <fef71466-54df-4561-a19f-e904c6f79c3b@suse.com>
Date: Tue, 15 Jul 2025 10:46:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Florian Schmaus <florian.schmaus@codasip.com>
References: <775c5a55-6079-44f3-9af4-11587bcec468@codasip.com>
 <b7694ccf-6efd-40fd-8918-89a26f51f6f3@suse.com>
 <88c6d73e-8d1b-4f95-be17-06f9fe6d35c8@codasip.com>
Content-Language: en-US
In-Reply-To: <88c6d73e-8d1b-4f95-be17-06f9fe6d35c8@codasip.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sigrelse01: Fix out-of-bounds read when invoking
 write()
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Ck9uIDcvMTUvMjUgMTA6MjAgQU0sIEZsb3JpYW4gU2NobWF1cyB3cm90ZToKPiBPbiAxNS8wNy8y
MDI1IDEwLjE3LCBBbmRyZWEgQ2VydmVzYXRvIHdyb3RlOgo+PiBbWW91IGRvbid0IG9mdGVuIGdl
dCBlbWFpbCBmcm9tIGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20uIExlYXJuIHdoeSAKPj4gdGhp
cyBpcyBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZp
Y2F0aW9uIF0KPj4KPj4gSGkhCj4KPiBIaSBBbmRyZWEsCj4KPgo+PiBjYW4geW91IHBsZWFzZSBj
aGVjayB3aHkgdGhpcyBwYXRjaCBpcyBub3QgYXBwbHlpbmcgZmlyc3Q/Cj4KPiBTb21ldGhpbmcg
YWRkZWQgYW4gYWRkaXRpb25hbCBsaW5lIGJyZWFrIGFsb25nIHRoZSB3YXkgdG8geW91LiBUaGUg
Cj4gImRpZmYgLS1naXQgYS90ZXN0Y2FzZXMv4oCmIiBzaG91bGQgYmUgb25lIGxpbmUgaW5zdGVh
ZCBvZiB0d28uIFNlZSBteSAKPiBwcmV2aW91cyByZXBseSB0byBXZWkgYXQKPgo+IGh0dHBzOi8v
bGlzdHMubGludXguaXQvcGlwZXJtYWlsL2x0cC8yMDI1LUp1bHkvMDQ0MzQ1Lmh0bWwKPgo+IC0g
Rmxvcmlhbgo+Ckkgc2VlLCBJIGd1ZXNzIGl0IHdpbGwgbmVlZCB0byBiZSB0YWtlbiBpbnRvIGFj
Y291bnQsIG90aGVyd2lzZSB3ZSBjYW4ndCAKcGFzcyB0aGUgcGF0Y2ggZHVlIHRvIENJIGZhaWx1
cmUuIENhbiB5b3UgcGxlYXNlIHNlbmQgYSBuZXcgcGF0Y2ggd2l0aCAKdGhlIHByb3BlciBmb3Jt
YXQ/CgpUaGFua3MsCkFuZHJlYQoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9saXN0aW5mby9sdHAK
