Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5709DCD3436
	for <ltp@archiver.kernel.org>; Fri,  8 May 2026 10:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778235525; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=O/EKhJPyo0z16V+X3jyGjsaU41s4pIKJZRBlTWlDSbQ=;
 b=ZYzJZeRp+AIN7UiJghRYuAI/CfhlzZE24zHO+fXXW7aGBLwmwpJHB+amvZrts3FN3UpBc
 5GHRvUf7xfRUq4TEPdzKzbLgNXhIL61WTcXEMHaNxvB4lLmFizVAbz3VN5cwY0zx2pGdkZJ
 m5SYgzjbz5+rvMA+Xc9hK4CWksBGHbk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DEF443E2C2A
	for <ltp@archiver.kernel.org>; Fri,  8 May 2026 12:18:45 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 81DBE3E246A
 for <ltp@lists.linux.it>; Fri,  8 May 2026 12:18:21 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 02EFE1A00A54
 for <ltp@lists.linux.it>; Fri,  8 May 2026 12:18:20 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48a7fe4f40bso19782775e9.0
 for <ltp@lists.linux.it>; Fri, 08 May 2026 03:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778235500; x=1778840300; darn=lists.linux.it;
 h=in-reply-to:references:to:cc:subject:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kcJWdKyHt9KybaVuPNh68Ona6M4FzoajFJJnfjsHGYc=;
 b=Q1SkS9OOW79m3vuTNTzgZXQLUdtYcevSViZuCcxN4LLCqtEKnKJUnlbFf9Y1E1sbn6
 c1X7HMZK5zjvA8hbW/s/UJWLTN/0c+kjhzt7Y1ABw8iGQmBAsRPDVJBzdD6baGtwfmwj
 GvJwTX96Nbq+hJZDALKkQNpyerl+YKPH9YQcrsC0Vd5pizSf7RH8DoB2xtNnXjr1K/Et
 gTR2wuy78fAa5u4MZSlBBEppcSDRZCwIjB+iWBYcbb0ALcI/hy5SB5X1qWnCw8jQnSzN
 /AkCTvZRIioZ9UoVQ6zSc+r7WIF5uYtS8YNjoUgHkOjpfZ6yfXUxifg765STMk8eEh1z
 KYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778235500; x=1778840300;
 h=in-reply-to:references:to:cc:subject:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kcJWdKyHt9KybaVuPNh68Ona6M4FzoajFJJnfjsHGYc=;
 b=nwuRMFzOYmE3w2GcIbDYVemw7TOSS09pvgHa+p+aGqdvr5z/0Uoavcs1TIT3gxZMK+
 /AdKlztam5jwu+sUr6RbJVtCAnc0Y5Ve8QnKV50Ip1ow3HFSsOX3Yx4/kTXimq2kuR1Q
 fpSKZBuMWrOXl0npqpPc9GwmrLV+9G8h7p0Nd5hBEw95LmQAl3tOtqJpieOpbnpCeJ/h
 V2+C+o8QmUzfY1ZK3A9mgtfF/yUy85i/nN59ydxm6Si72xM5gM56QZ34MseYKTQohdiS
 cmHIl6WAYK4B+XW+k7ph2iaYrAnCfn+eiVWC0xSQG3dFzUtDOH9EZQTVO9brc5/CERbC
 +5Sg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/b50zuroTpAnszkpAIIq012ZVzCv1CAmpe+VQOiUSAZfbl/qhNBLdSQ4Aeu/qSuN5R3zY=@lists.linux.it
X-Gm-Message-State: AOJu0Yx5I+fBpsUBQsOeuvLwSlbcx1op0lK7fHzHBAakVwmuhEN6C6WL
 LSqsFMBeHSBia7HzRuGrCmR55xghyDEpdTMdQ8ox22FrsqFznSq6zN9JpqG5Tpk1kKOe4ZGJdRO
 EFQ4L1tc=
X-Gm-Gg: AeBDievmXCEzdVY4xCtTPJc3vtza0XsYtM1o0fS3oOqbU4/ETkvbhs4FDHwzEDK2YRu
 D2zl3RyCD1WBdF/8MxvQPtUYT+0WFYyK+1at6pgvTK607CaS4NMTv1lU/f/5hFnMZf7c0Y51kXb
 EpubvL/FGEO1RPwQjKadALrf2XL7I6MMfvT3/golacSUf68ELWYMWLV+wY7sNmDJZplUGLf2u3B
 tATN9i7gd/HyIXWUK8/Kvi1vkXzAPniEGJwcvOKeJxDYQida7emhe+gYPrbKD27BTbruOZ906P3
 a5NUCeVcK80Z3I8jpnQmBA4XMiB9EdUGDwRlR3ZqCwe6MJk5/5uF62bzXmB5wwj1gvL/n1YXZO/
 b5wLb76X/ZBNyNAQdh7GEgb33fXhe+r/OER+h+/dFH4F8U+eFrul2RA51i4A2X5PcgCJxe3CEXJ
 Yl+Kz8uodjKwM=
X-Received: by 2002:a05:600c:8211:b0:489:c57:7836 with SMTP id
 5b1f17b1804b1-48e51f40ecemr213037625e9.27.1778235500328; 
 Fri, 08 May 2026 03:18:20 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:1294:2ecf:67ff:fe81:9da0])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8859eb4b7sm1613966eec.2.2026.05.08.03.18.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 03:18:19 -0700 (PDT)
Mime-Version: 1.0
Date: Fri, 08 May 2026 07:18:17 -0300
Message-Id: <DID7VHRJFPN1.36I4Y0RDBQS0W@suse.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>, "Linux Test Project"
 <ltp@lists.linux.it>
X-Mailer: aerc 0.21.0-146-g87073a0460e3
References: <20260508-cve-2026-43284-v1-0-bf2549d2430d@suse.com>
In-Reply-To: <20260508-cve-2026-43284-v1-0-bf2549d2430d@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/3] cve-2026-43284 reproducer
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
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_via_ltp?= <ltp@lists.linux.it>
Reply-To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: ltp <ltp-bounces+ricardo=marliere.net@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpIE1heSA4LCAyMDI2IGF0IDY6MTcgQU0gLTAzLCBBbmRyZWEgQ2VydmVzYXRvIHdyb3Rl
Ogo+IFNpZ25lZC1vZmYtYnk6IEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNhdG9Ac3Vz
ZS5jb20+CgpGb3IgdGhlIHNlcmllcywKClJldmlld2VkLWJ5OiBSaWNhcmRvIEIuIE1hcmxpw6hy
ZSA8cmJtQHN1c2UuY29tPgpUZXN0ZWQtYnk6IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3Vz
ZS5jb20+CgpUaGFua3MhCgo+IC0tLQo+IEFuZHJlYSBDZXJ2ZXNhdG8gKDMpOgo+ICAgICAgIGxh
cGk6IGZhbGxiYWNrIFNQTElDRV9GX01PUkUKPiAgICAgICBsYXBpOiBmYWxsYmFjayBVRFBfRU5D
QVAgYW5kIFVEUF9FTkNBUF9FU1BJTlVEUAo+ICAgICAgIG5ldHdvcmsvc29ja2V0czogQWRkIHhm
cm0gRVNQIHBhZ2UgY2FjaGUgY29ycnVwdGlvbiB0ZXN0Cj4KPiAgaW5jbHVkZS9sYXBpL3NwbGlj
ZS5oICAgICAgICAgICAgICAgIHwgICA0ICsKPiAgaW5jbHVkZS9sYXBpL3VkcC5oICAgICAgICAg
ICAgICAgICAgIHwgICA4ICsrCj4gIHJ1bnRlc3QvY3ZlICAgICAgICAgICAgICAgICAgICAgICAg
ICB8ICAgMSArCj4gIHRlc3RjYXNlcy9uZXR3b3JrL3NvY2tldHMvLmdpdGlnbm9yZSB8ICAgMSAr
Cj4gIHRlc3RjYXNlcy9uZXR3b3JrL3NvY2tldHMveGZybTAxLmMgICB8IDI0NiArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKwo+ICA1IGZpbGVzIGNoYW5nZWQsIDI2MCBpbnNlcnRp
b25zKCspCj4gLS0tCj4gYmFzZS1jb21taXQ6IGQ4NTU0ZWY4NDI2MWFkN2U3NmE4NmQ4YTQ3Y2Zl
NzgwNzY3NmU3NGYKPiBjaGFuZ2UtaWQ6IDIwMjYwNTA4LWN2ZS0yMDI2LTQzMjg0LTQ3NWM4NmNj
YTVjYgo+Cj4gQmVzdCByZWdhcmRzLAoKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
