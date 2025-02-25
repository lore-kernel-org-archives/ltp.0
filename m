Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57084C021B8
	for <ltp@archiver.kernel.org>; Tue, 25 Feb 2025 16:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740501708; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=uZALCPZHRRU2pwDSqC2o3di/Ps4KH3qoRx4NuZjU4mA=;
 b=O5Lr4TYKXK2IRub7urRjrmQov+I7DnpfcAsbY8f8TDE98pXZ4OS2lC+tKLIj0X3mbwDXj
 tVF+m++zBojs+tqE0oKoecDrt47k7hkY71P7kxKdPtZTDbQLgYjS8sQj9pGxoTtpgt1D78x
 oQQBnZnOwlH+1dHIbmMULH0W8s63PrM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C702A3C9C81
	for <ltp@archiver.kernel.org>; Tue, 25 Feb 2025 17:41:48 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E185C3C9C59
 for <ltp@lists.linux.it>; Tue, 25 Feb 2025 17:41:20 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7550920B7E2
 for <ltp@lists.linux.it>; Tue, 25 Feb 2025 17:41:20 +0100 (CET)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aaecf50578eso1142377366b.2
 for <ltp@lists.linux.it>; Tue, 25 Feb 2025 08:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1740501680; x=1741106480; darn=lists.linux.it;
 h=in-reply-to:references:to:subject:message-id:date
 :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DPmx4HUMOpadcpL2jjEJNAD6ts6yhmd179h+y2fj+cA=;
 b=GC51RvCrk/ZpCkTy7zWOrCnKdLWAR9pFvnwKSB3TizOuiD1IKkoNULJz/KIGeWSyx/
 m46tY0vahkfugk2DFi5d+O8HHN4CswA6SZkoSTa5pGaOSUyL5o2OASQYmcZhiToOlimo
 Fy+j9Kwg7cdt/O+QjOSKsz6AJepCM2S/ysrtGRZVe6pzsq1/MThDnB4u+qJeRbrmoFJh
 AFi+Xi6HDdL9V7FokfFX1esdPfgeycoEyuOCburMT+B9RSv8VNA3SAhlWmptpVnfRgji
 lTgbXykBN01UCkKSbTEcqnQAcsiSGgCBClSTLXNO+rk+2/B4zvVnOeb9VzKhbWDPWzFb
 FbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740501680; x=1741106480;
 h=in-reply-to:references:to:subject:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DPmx4HUMOpadcpL2jjEJNAD6ts6yhmd179h+y2fj+cA=;
 b=eVbZarJB3SNXsLyZShs68fr+e5TsuLmooBb7YcAIFLKzFSpwjR/qzCaBz6anMmrVF7
 WT7gna41pGrp3HAi/383zqNwaxGWvz0UqutnwUOcyvaQPLD9OCo3tU4aJbel7rErtdeo
 dBjdsYFagMX7tNx6jiYY7XBllMBkpxd7akQFWE/EF4jJUIgSQukpUtB8qdzZTgvEvu64
 q3XG5SkbqICLU8gH/xRfNpok4l0qwVsVUn3OelyyEgVUO9qi6saWmur/VgKF1yqOSjBy
 GlPD7uVLZ3SGXMqEDB830ZCudnstwUH+phLPIqmXfeYDulQeGPYxW4h8t+YejwWrocu6
 e/9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6d4+yer5G1xB7+MicHxarEIjfyjs6wT/fu+pCGS/kBLgh99StD94jDLsr9b1QS9feOYU=@lists.linux.it
X-Gm-Message-State: AOJu0YyBnYUS4NELxOFwaqonqBa4RtvBWLZXhjwwA5WHFTy7xj8RrAY3
 ocNSgcSZXpXxGlp/w4r1dxJXvGXJSjTDCAjdcLti6MAmlefKtHigD+EpyfJrcbvO/VwpDAR1x2F
 W
X-Gm-Gg: ASbGncvZqyhOdGTaloXrg1hJkzArItXtTfttF3wBkm5FvA+cM+ElF3oYDbc09blksGT
 9NsSzyZc6/klId/8jUbgHkhKkh2hFxTswY6jzv5zwdGl4HFvSzallibe7RYlf9L1/85+lsWyemp
 f9Sv93YItKM0OAko7Z2AhWA0+jpbe5VKi/1NA1asniJdh2QtMihMeArKZj0FqU2VjBlBaQP7FwD
 cPqPEgZH4pSO+ur6QjjpVhVpJ6mzlzQDpS0EklPevIQ77X58FiauJD4i0vGh4fYoNsTCMHDLrWP
 /6G1JEVMfuKsBVs=
X-Google-Smtp-Source: AGHT+IFTz4IZPpwPOQzyOssJ/WXd1hutSvJUmHAm/ZhEpUvQaM+QmPRFm6aUQMY6g62kiYRmFJ0yEQ==
X-Received: by 2002:a17:906:308b:b0:aba:ec4f:fa4 with SMTP id
 a640c23a62f3a-abc0d993654mr1471639966b.12.1740501679765; 
 Tue, 25 Feb 2025 08:41:19 -0800 (PST)
Received: from localhost ([179.228.215.131])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-2230a01fea2sm16589415ad.96.2025.02.25.08.41.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 08:41:19 -0800 (PST)
Mime-Version: 1.0
Date: Tue, 25 Feb 2025 13:41:17 -0300
Message-Id: <D81OCOB4G1FC.2ZJ6K7JJZWREU@suse.com>
To: "Martin Doucha" <mdoucha@suse.cz>, "Linux Test Project"
 <ltp@lists.linux.it>
X-Mailer: aerc 0.20.1
References: <20250225-disable_virt_other_getrusage04-v2-1-71d91adee359@suse.com>
 <54b990f3-a9a2-4143-ba33-29f770a3a1bb@suse.cz>
In-Reply-To: <54b990f3-a9a2-4143-ba33-29f770a3a1bb@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/getrusage04: Disable for VIRT_ANY
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
Reply-To: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlIEZlYiAyNSwgMjAyNSBhdCAxOjE4IFBNIC0wMywgTWFydGluIERvdWNoYSB3cm90ZToK
PiBIaSwKPiB0aGUgY29tbWl0IG1lc3NhZ2UgaXMgaW5hY2N1cmF0ZSBiZWNhdXNlIHRoZSB0ZXN0
IHdpbGwgZ2V0IGRpc2FibGVkIG9uIAo+IGFsbCBkZXRlY3RlZCB2aXJ0IGVudmlyb25tZW50cy4g
QnV0IHRoZSBwYXRjaCBsb29rcyBnb29kLgo+Cj4gUmV2aWV3ZWQtYnk6IE1hcnRpbiBEb3VjaGEg
PG1kb3VjaGFAc3VzZS5jej4KCkluZGVlZCwgc29ycnkgZm9yIHRoZSBub2lzZSBhbmQgdGhhbmtz
IGZvciB0aGUgaGVscCA6KQoKPgo+IE9uIDI1LiAwMi4gMjUgMTc6MTEsIFJpY2FyZG8gQi4gTWFy
bGnDqHJlIHdyb3RlOgo+PiBGcm9tOiBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29t
Pgo+PiAKPj4gVGhpcyB0ZXN0IGlzIGtub3duIHRvIGJlIHVuc3RhYmxlIHVuZGVyIHNvbWUgdmly
dHVhbGl6ZWQgZW52aXJvbm1lbnRzLAo+PiB0aGVyZWZvcmUgb25seSBhbGxvdyBpdCBmb3IgcmVj
b2duaXplZCBvbmVzLgo+PiAKPj4gU3VnZ2VzdGVkLWJ5OiBNYXJ0aW4gRG91Y2hhIDxtZG91Y2hh
QHN1c2UuY3o+Cj4+IFNpZ25lZC1vZmYtYnk6IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3Vz
ZS5jb20+Cj4+IC0tLQo+PiBDaGFuZ2VzIGluIHYyOgo+PiAtIFVzZSBWSVJUX0FOWSBpbnN0ZWFk
IG9mIFZJUlRfT1RIRVIgZm9yIGZ1dHVyZSBwcm9vZmluZwo+PiAtIExpbmsgdG8gdjE6IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTAyMjQtZGlzYWJsZV92aXJ0X290aGVyX2dldHJ1c2Fn
ZTA0LXYxLTEtYmNiNDMzYWY5NjM1QHN1c2UuY29tCj4+IC0tLQo+PiAgIHRlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvZ2V0cnVzYWdlL2dldHJ1c2FnZTA0LmMgfCA3ICsrKystLS0KPj4gICAxIGZp
bGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+PiAKPj4gZGlmZiAt
LWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0cnVzYWdlL2dldHJ1c2FnZTA0LmMg
Yi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2dldHJ1c2FnZS9nZXRydXNhZ2UwNC5jCj4+IGlu
ZGV4IGIwM2JjNTQ5YmQ4MzViMzNhY2FhMDI2OTM3MDYyNTVlODhjYmU0ZjguLjk4M2RiMjY0OTY5
MGU0MzE4YjYyY2UzMzQwMTkyMTAyY2IxZGFjZjQgMTAwNjQ0Cj4+IC0tLSBhL3Rlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvZ2V0cnVzYWdlL2dldHJ1c2FnZTA0LmMKPj4gKysrIGIvdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy9nZXRydXNhZ2UvZ2V0cnVzYWdlMDQuYwo+PiBAQCAtMTk4LDkgKzE5
OCwxMCBAQCBzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQo+PiAgIHsKPj4gICAJdHN0X3NpZyhOT0ZP
UkssIERFRl9IQU5ETEVSLCBjbGVhbnVwKTsKPj4gICAKPj4gLQlpZiAodHN0X2lzX3ZpcnQoVklS
VF9YRU4pIHx8IHRzdF9pc192aXJ0KFZJUlRfS1ZNKSB8fCB0c3RfaXNfdmlydChWSVJUX0hZUEVS
VikpCj4+IC0JCXRzdF9icmttKFRDT05GLCBOVUxMLCAiVGhpcyB0ZXN0Y2FzZSBpcyBub3Qgc3Vw
cG9ydGVkIG9uIHRoaXMiCj4+IC0JCSAgICAgICAgIiB2aXJ0dWFsIG1hY2hpbmUuIik7Cj4+ICsJ
aWYgKHRzdF9pc192aXJ0KFZJUlRfQU5ZKSkKPj4gKwkJdHN0X2Jya20oVENPTkYsIE5VTEwsCj4+
ICsJCQkgIlRoaXMgdGVzdGNhc2UgaXMgbm90IHN1cHBvcnRlZCBvbiB0aGlzIgo+PiArCQkJICIg
dmlydHVhbCBtYWNoaW5lLiIpOwo+PiAgIAo+PiAgIAlCSUFTX01BWCA9IGd1ZXNzX3RpbWVyX3Jl
c29sdXRpb24oKTsKPj4gICAKPj4gCj4+IC0tLQo+PiBiYXNlLWNvbW1pdDogYTFhZWJmZDRkOTlk
NWRhMTI4MzRkYWU1MjE1ODE1ZmY4ZDgyOTk1Ywo+PiBjaGFuZ2UtaWQ6IDIwMjUwMjI0LWRpc2Fi
bGVfdmlydF9vdGhlcl9nZXRydXNhZ2UwNC1jOWRiMmFhOWU2OWMKPj4gCj4+IEJlc3QgcmVnYXJk
cywKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGlu
Zm8vbHRwCg==
