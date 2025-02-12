Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36EE3C02198
	for <ltp@archiver.kernel.org>; Wed, 12 Feb 2025 08:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1739348864; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=T9RSO6XiHwnlKOBceU32tCvUbG4JGGxqowcxBclX8Fk=;
 b=UFEt7osen/MTB+wNVQBPxcsb2RQAYhGqnHMSgrPWvO+v4a0qrhSGuvPzZ7UJMqX+axDyt
 vX1YkMMQ/CahSObwWOMFgO2qzhZrVg43VLQnqKqmHBnbp2TU53KrgIh1pVz95QU9/+uGTG7
 +qbLsPs3UwUE3os8kpxzIyZ0lyJldFY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 46F733C98E4
	for <ltp@archiver.kernel.org>; Wed, 12 Feb 2025 09:27:44 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D2933C98E4
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 09:27:22 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 10B4E60E6AE
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 09:27:22 +0100 (CET)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-38dcae0d6dcso2879749f8f.1
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 00:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1739348841; x=1739953641; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7K33y0RG2njfqdMJgefO2fKJq2dEiy7lFgFawh+oExQ=;
 b=fl4aV2Rrt9CdIE3bX877VPmOiGK0RT9CgAQtckNowFpsD5WrATZGusVPKtiolcpNEN
 HRWv0kCs15NdebuWk888qVewXMDlGb5hc+tSKxSkKNn5CX2vfArrD+g+XQfBKVmQr9oB
 pjXYWT8ESm611sw59c6mJ4O3eEpBzR7iAmh6CGJgbtWD30aQGBD7pHBAz802NDpyDYcl
 cG5oZxw2zyVNKF+h75dMWPq1dbtNo/SrLqxC4CuX02uu3uFXamN06XHpYXWnCbzBx6ih
 HE/6NMkM1RoZeB7EOqbA1PCBZ4c5TonBA9faC0DtsvU1W8PfGKekMIAM4rKiwdz6/fn7
 tJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739348841; x=1739953641;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7K33y0RG2njfqdMJgefO2fKJq2dEiy7lFgFawh+oExQ=;
 b=A4yLtxIBeRnCM9llWH16Sa2t6SvQu+ay1tTpVuz7bwJPg+4uc2/+9rGrWHEfjcheOw
 XciwfdBBrHmVfozKg6c/nz9AOwXUF0CKLrCAOUbG3RBd2id8FqmJ8conewY1Oz8B8Y6B
 gjOWFDHR+wBHhENQPTv7FmNiKyGSMdkLEvjGSMlA85tzq0extH46ncF4E5gm4ZZSlu3B
 nCD/VfQoTtMmoNeuxuqhWh9+GnXuM7n8q5cjtEEROyGH+0PoS17GIcySKShZyByGyb/F
 knn8h3MqpBcyyETxUfldhp84siGfVaKpQe8YJTnBeZa+Ouz47QnfuZasRkuPPxQnYnjx
 MzdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBhU+6CWHozMTL6a8CMwbjDxbPhpqx3quEetOCpVQxBFHQX0X1mHgUZyyZlbVfyT3L34Q=@lists.linux.it
X-Gm-Message-State: AOJu0YyT8UUcic7+C8i1fOOnI+4ezJ3RJHvklpxkCqE6QhrjlpuQ/azC
 8CLOpM7HhBce4yt4lm6gdhZMPkh0wcXml73bBK0lRyGJxX9OTjnvbGluT5L6/Xs=
X-Gm-Gg: ASbGnctmjIadKXnzE0S8v/8g0TX9aclpLOm65tBjv7o6gcvzwB++E5O6vDxQ3Z3j/KY
 YKD5QxhqTfdvQ0r9/zh3ZzC7Ges+VvxlYxJ7VSiSPdR30LBjo+C0IYrGSIZ6jReOwFNvI7ycStE
 +XKiAyhZaopMKRwZoc1cTQdeLoItiobIMEzNGYCmg258i0neqL2eCzl0xJ7nVJHyuoqdw+eSYI3
 bw11TYCjxmukLnYc9Zcn+NIkAsDmH/X3eyd0R7ZP/9vew4ANt9brobPyVu9pZmbx14u7XODPMNa
 eSNO0MxaDCyL/qZti+T/AAs9+W6kolFKrXsPbyAV2+7vVDrPR0T/i+W+AUfBGab1MS6GQFh++tp
 1s3dk5ddfc76OBPXCfUainzi1a0yGwzD+ORTZ+kGznC9CqqzWydE=
X-Google-Smtp-Source: AGHT+IFgG8Vz7UA7FDijmEVtme6V037Hbp92xfSV/7aY0fy9bh+NZMhgEJ5igiuwPKjWsDhQIgwq5g==
X-Received: by 2002:a05:6000:184b:b0:38d:b113:eb8 with SMTP id
 ffacd0b85a97d-38dea26ecebmr1437158f8f.20.1739348841378; 
 Wed, 12 Feb 2025 00:27:21 -0800 (PST)
Received: from ?IPV6:2003:ef:2f02:800:9162:c8ad:3b21:a399?
 (p200300ef2f0208009162c8ad3b21a399.dip0.t-ipconnect.de.
 [2003:ef:2f02:800:9162:c8ad:3b21:a399])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd07fa80csm12624637f8f.13.2025.02.12.00.27.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 00:27:21 -0800 (PST)
Message-ID: <e96883c0-42c3-48ff-884f-4971d1c2b726@suse.com>
Date: Wed, 12 Feb 2025 09:27:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20250211233552.1990618-1-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20250211233552.1990618-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] doc/Makefile: Allow to create and use .venv
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCgpUaGlzIHNvbWVob3cgcmVzb2x2ZXMgdGhlIHByb2JsZW0gb2Ygbm90IGV4cGxpY2l0bHkg
dXNpbmcgdmlydHVhbGVudiwgCmJ1dCBJIGhhdmUgdGhlIGltcHJlc3Npb24gdGhhdCBpdCBoYXMg
c29tZSBjcml0aWNhbCBpc3N1ZXMuCnZpcnR1YWxlbnYgaXMgbm90IHBhcnQgb2YgdGhlIGJ1aWxk
c3lzdGVtLCBidXQgaXQncyBhbiBleHRlcm5hbCB0b29sIAp0aGF0IGNvbGxlY3QgcHl0aG9uIHBh
Y2thZ2VzIGFuZCBpdCdzIHVwIHRvIHRoZSBkZXZlbG9wZXIgdXNpbmcgaXQgb3IgCm5vdCwgYW5k
IHRoaXMgbWFrZXMgaXQgb3B0aW9uYWwuwqAgQnkgaW50cm9kdWNpbmcgaXQgaW4gdGhlIE1ha2Vm
aWxlLCB3ZSAKZW5kIHVwIG1peGluZyB0aGluZ3MgYSBsaXR0bGUgYml0LgoKQWxzbywgdGhpcyBw
YXRjaCBjb21wbGljYXRlcyB0aGUgTWFrZWZpbGUsIHNpbmNlIHdlIG1pZ2h0IG5lZWQgb25lIApj
b21tYW5kIGJlZm9yZSBydW5uaW5nICJtYWtlIiAoc291cmNlIG91cl92ZW52L2Jpbi9hY3RpdmF0
ZSkgYW5kIHR3byAKY29tbWFuZHMgb25jZSBpbiBhIHdoaWxlIHRvIGNyZWF0ZSBpdCAodmVudiAr
IHBpcCkuCgpJbiBzaG9ydCwgSSBoYXZlIHRoZSBpbXByZXNzaW9uIHRoZXJlJ3Mgbm8gYWRkaXRp
b25hbCB2YWx1ZSB0byB0aGUgCnBhdGNoLCBidXQgbW9zdGx5IGFuIG92ZXItZW5naW5lZXJlZCBN
YWtlZmlsZSA6LSkKCkFuZHJlYQoKT24gMi8xMi8yNSAwMDozNSwgUGV0ciBWb3JlbCB3cm90ZToK
PiBUaGlzIGlzIGFuIG9wdGlvbmFsIHRhcmdldCAobm90IHJ1biBieSBkZWZhdWx0KS4KPiBJZiAu
dmVudiBleGlzdHMsIGl0J3MgdXNlZCBpbiBvdGhlciB0YXJnZXRzLgo+Cj4gVGhpcyBoZWxwcyB0
byB1c2UgdmlydHVhbGVudiBmb3IgZGV2ZWxvcG1lbnQsIGJ1dCBhdm9pZCB1c2luZyBpdCBieQo+
IGRlZmF1bHQgKHJlYWR0aGVkb2MgdXNlcyBjb250YWluZXIgd2l0aCB2aXJ0dWFsZW52LCBjcmVh
dGluZyBpdCB3b3VsZCBiZQo+IHdhc3RlIG9mIHRpbWUpLgo+Cj4gU2lnbmVkLW9mZi1ieTogUGV0
ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4gLS0tCj4gdjE6IGh0dHBzOi8vcGF0Y2h3b3JrLm96
bGFicy5vcmcvcHJvamVjdC9sdHAvcGF0Y2gvMjAyNTAyMDYxNDM0MjEuMTU3MTkxOC00LXB2b3Jl
bEBzdXNlLmN6Lwo+Cj4gQ2hhbmdlcyB2MS0+djI6Cj4gKiB2aXJ0dWFsZW52IGlzIG9wdGlvbmFs
Cj4gKiB1c2UgdmFyaWFibGVzCj4KPiAgIGRvYy9NYWtlZmlsZSB8IDE4ICsrKysrKysrKysrKysr
Ky0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0p
Cj4KPiBkaWZmIC0tZ2l0IGEvZG9jL01ha2VmaWxlIGIvZG9jL01ha2VmaWxlCj4gaW5kZXggYTA3
ZGYwNGQ1Yy4uOTA5ZDk2ODdiOCAxMDA2NDQKPiAtLS0gYS9kb2MvTWFrZWZpbGUKPiArKysgYi9k
b2MvTWFrZWZpbGUKPiBAQCAtNSwxNCArNSwyNiBAQCB0b3Bfc3JjZGlyCQk/PSAuLgo+ICAgCj4g
ICBpbmNsdWRlICQodG9wX3NyY2RpcikvaW5jbHVkZS9tay9lbnZfcHJlLm1rCj4gICAKPiArUFlU
SE9OIDo9IHB5dGhvbjMKPiArVkVOVl9ESVIgOj0gLnZlbnYKPiArVkVOVl9DTUQgOj0gLiAkKFZF
TlZfRElSKS9iaW4vYWN0aXZhdGUKPiArUlVOX1ZFTlYgOj0gaWYgWyAtZCAkKFZFTlZfRElSKSBd
OyB0aGVuICQoVkVOVl9DTUQpOyBmaQo+ICsKPiArIyBpbnN0YWxsIHNwaGlueCBvbmx5IGlmIG5l
ZWRlZAo+ICtJTlNUQUxMX1NQSElOWCA6PSAkKHNoZWxsICQoUFlUSE9OKSAtYyAiaW1wb3J0IHNw
aGlueCIgMj4vZGV2L251bGwgJiYgZWNobyAiOiIgfHwgZWNobyAicGlwIGluc3RhbGwgc3BoaW54
IikKPiArCj4gKyQoVkVOVl9ESVIpOgo+ICsJJChQWVRIT04pIC1tIHZpcnR1YWxlbnYgJChWRU5W
X0RJUikKPiArCSQoVkVOVl9DTUQpICYmIHBpcCBpbnN0YWxsIC1yIHJlcXVpcmVtZW50cy50eHQg
JiYgJChJTlNUQUxMX1NQSElOWCkKPiArCj4gICAke2Fic190b3BfYnVpbGRkaXJ9L21ldGFkYXRh
L2x0cC5qc29uOgo+ICAgCSQoTUFLRSkgLUMgJHthYnNfdG9wX2J1aWxkZGlyfS9tZXRhZGF0YQo+
ICAgCj4gICBhbGw6ICR7YWJzX3RvcF9idWlsZGRpcn0vbWV0YWRhdGEvbHRwLmpzb24KPiAtCXNw
aGlueC1idWlsZCAtYiBodG1sIC4gaHRtbAo+ICsJJChSVU5fVkVOVik7IHNwaGlueC1idWlsZCAt
YiBodG1sIC4gaHRtbAo+ICAgCj4gICBzcGVsbGluZzoKPiAtCXNwaGlueC1idWlsZCAtYiBzcGVs
bGluZyAtZCBidWlsZC9kb2N0cmVlIC4gYnVpbGQvc3BlbGxpbmcKPiArCSQoUlVOX1ZFTlYpOyBz
cGhpbngtYnVpbGQgLWIgc3BlbGxpbmcgLWQgYnVpbGQvZG9jdHJlZSAuIGJ1aWxkL3NwZWxsaW5n
Cj4gICAKPiAgIGNsZWFuOgo+IC0Jcm0gLXJmIGh0bWwvIGJ1aWxkLyBfc3RhdGljL3N5c2NhbGxz
LnJzdCBfc3RhdGljL3Rlc3RzLnJzdCBzeXNjYWxscy50YmwKPiArCXJtIC1yZiBodG1sLyBidWls
ZC8gX3N0YXRpYy9zeXNjYWxscy5yc3QgX3N0YXRpYy90ZXN0cy5yc3Qgc3lzY2FsbHMudGJsICQo
VkVOVl9ESVIpCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQv
bGlzdGluZm8vbHRwCg==
