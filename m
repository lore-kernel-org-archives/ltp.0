Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B4FC3ABDD
	for <ltp@archiver.kernel.org>; Tue, 20 May 2025 07:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747725675; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=A4KHMqrSEio8CNTPQZ+gwpsTLQx6FK/i896aMw9YFug=;
 b=FR7gI/EbI7dm26ROtLwL22u0mYkifnb3CCBrmLZ1CdbD6Cd3hzG5/M3bm+/KhYARDR0Kj
 SqxIzEa9KgFVkr3vTREp7dcKffixLKdZagaVSPYAXH3G6qa775knFBDUCggS9dyCnb8Vk0k
 cW/NiHjsG10kL8D5PsH0BIzShV3JCz4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 45FED3CC723
	for <ltp@archiver.kernel.org>; Tue, 20 May 2025 09:21:15 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A40B03CA7A9
 for <ltp@lists.linux.it>; Tue, 20 May 2025 09:20:53 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8B6C61021E91
 for <ltp@lists.linux.it>; Tue, 20 May 2025 09:20:52 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a375888297so962082f8f.1
 for <ltp@lists.linux.it>; Tue, 20 May 2025 00:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1747725652; x=1748330452; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ud+YBGHexiFLkj7Q5G8M9OuPMhAHamuLFZWz+qA2Di8=;
 b=Ti+SUKTNAln3W49/qh8oCY9nsD6LvYO1ri0OtCxpbpR+o/jIuph4K5XxxJ4VURjoYC
 /JqznEzJ2a86wFVb0+Hs7KrfLGoUvTc0oRdBHw0gdTFI11I0SjVOYeJtYrZiSWzvk9Jn
 E0TYmWM7LsrRF5o+BNYgbwj/KPx1slumWUPLdJdGxeWsO3wB97PkHROcxGhzyUewYq89
 3wKut6BXNCCTpK/pohL4OqdiUF9PAWnihAsd7Q5f6gTjjQhbHhuiors9uHcD4KO3gJ98
 d4spC17zh55e5CQRKUsmNV8sxOv8o8FW7OvTlMd5DFFB2WzXid980G5h8jsr0OGy5zZW
 Z95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747725652; x=1748330452;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ud+YBGHexiFLkj7Q5G8M9OuPMhAHamuLFZWz+qA2Di8=;
 b=E9MfsLvQhgu3jwbO/UpScpr1tCAFmlnLvoDwTDUYk4i921W2L0GvUIBlhtiK7O3/EC
 NDmSgVhX67GwxldLD8ZHhVd2X1d0fj82/LJIk607MNJv3/Sl+aK29fdnT3kQMnUlivcL
 LRwJPvUB45VQZ+4qAaY/YE6TKTmHB8EkEKSu76w+Dk+wNkO73EBv4xUzmlNM67rQmkuF
 dSOup7eM0c5aa4U3yxCo3Egno1/Y9vXq/TL0MhsL2ueRYQA8lyHeAIEqJAHBV6msWWMR
 jH1YvYB9f85Rqn9V5EqFX8xX0ipf6atWj9HQCPpEVZJYPGZ7rQqcRmGrQicNarIdUv5b
 C5UA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcAwlg1iZmyohvjr/+3gxxWrzUD9nICipkxjPeipgdWBPpAEMIQpbFzoMfRkViqk3wqF4=@lists.linux.it
X-Gm-Message-State: AOJu0Yxupq41iv+Wjtas/8U+GMg3Z33olbrQKcQWcen+Ttr9DfIS36j0
 cKWU3IWh92Em6cMOn/AiPJPINr+ND4qq2aynnLTiul7ipUjI5vzNg90eOt7YjW1NV9M=
X-Gm-Gg: ASbGnct1WwfH+Y6KK+mVNKBO4Hf7FB7hytM9hKq/0vJAG8zKOLEGwhTyvYPSHSCQ1qn
 qJqlMJLU1RWrJsQ+q591uumJ3df5BtqmW9rPQiUPRNI+VbXs6cJin71G7k/OAYdj5oM+8POJFvG
 +qcZ+ADebnKw1r8hIVTzP3lo5GeOLy2aAPvCHQa8JWUuc1NJJBiEIt4lElhWjv1NPmBgkG2gyFq
 Bn5GmQ5knM6KoGkVlY2WCAqK4ur1ETWGaMiFoJQtJVufaakDNmfOiaZLBSPHgqgOrCdxoNySS9t
 qaMqKPomJCd60Yue3hKWIy9RMRdkr+vmpb1UOjqS7PRKVGYHjD369VJisNxmBucoJuj7tfI1n20
 qidSMBGKoo0sYxlqcKDk6mhSTqTUzmF63JaeC4HK8BI1KHAy8+3m6non6Wty56+vn4q/owdRat7
 g9x0qaqPMvdCrmog==
X-Google-Smtp-Source: AGHT+IHNtETSE7uZ91Mj7AJiTHNF0QJxqoEMp5vcGbceKUJgupaQE5q7OiG3kOpdCiWA6xd7/J88Gg==
X-Received: by 2002:a5d:64c9:0:b0:39e:cbca:74cf with SMTP id
 ffacd0b85a97d-3a35ca76738mr14611722f8f.6.1747725651821; 
 Tue, 20 May 2025 00:20:51 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f16:9a00:bba9:aeb9:310b:cc0d?
 (p200300ef2f169a00bba9aeb9310bcc0d.dip0.t-ipconnect.de.
 [2003:ef:2f16:9a00:bba9:aeb9:310b:cc0d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca4d26esm15564836f8f.13.2025.05.20.00.20.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 May 2025 00:20:50 -0700 (PDT)
Message-ID: <1eb8683a-b0fc-4e24-a0bc-8975089ce26f@suse.com>
Date: Tue, 20 May 2025 09:20:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250512-fixes-modify_ldt-v2-1-eaef5577e44e@suse.com>
Content-Language: en-US
In-Reply-To: <20250512-fixes-modify_ldt-v2-1-eaef5577e44e@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] ldt.h: Add workaround for x86_64
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

SGkhCgpPbiA1LzEyLzI1IDEyOjA1LCBSaWNhcmRvIEIuIE1hcmxpw6hyZSB2aWEgbHRwIHdyb3Rl
Ogo+IEZyb206IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Cj4KPiBUaGUgY29t
bWl0IGJlMGFhY2EyZjc0MiAoInN5c2NhbGxzL21vZGlmeV9sZHQ6IEFkZCBsYXBpL2xkdC5oIikg
bGVmdCBiZWhpbmQKPiBhbiBpbXBvcnRhbnQgZmFjdG9yIG9mIG1vZGlmeV9sZHQoKTogdGhlIGtl
cm5lbCBpbnRlbnRpb25hbGx5IGNhc3RzIHRoZQo+IHJldHVybiB2YWx1ZSB0byB1bnNpZ25lZCBp
bnQuIFRoaXMgd2FzIGhhbmRsZWQgaW4KPiB0ZXN0Y2FzZXMvY3ZlL2N2ZS0yMDE1LTMyOTAuYyBi
dXQgd2FzIHJlbW92ZWQuIEFkZCBpdCBiYWNrIHRvIHRoZSByZWxldmFudAo+IGZpbGUuCj4KPiBS
ZXBvcnRlZC1ieTogTWFydGluIERvdWNoYSA8bWRvdWNoYUBzdXNlLmN6Pgo+IFNpZ25lZC1vZmYt
Ynk6IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Cj4gLS0tCj4gQ2hhbmdlcyBp
biB2MjoKPiAtIEFkZGVkIFRCUk9LIGZvciBhbnkgcmV0ICE9IDAgaW4gbW9kaWZ5X2xkdCBjYWxs
IGluIGN2ZS0yMDE1LTMyOTAuYwo+IC0gTGluayB0byB2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvci8yMDI1MDUwNy1maXhlcy1tb2RpZnlfbGR0LXYxLTEtNzBhMjY5NGNmZGRjQHN1c2UuY29t
Cj4gLS0tCj4gICBpbmNsdWRlL2xhcGkvbGR0LmggICAgICAgICAgICB8IDIyICsrKysrKysrKysr
KysrKysrKysrKy0KPiAgIHRlc3RjYXNlcy9jdmUvY3ZlLTIwMTUtMzI5MC5jIHwgIDggKysrKysr
Ky0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkK
Pgo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xhcGkvbGR0LmggYi9pbmNsdWRlL2xhcGkvbGR0LmgK
PiBpbmRleCA2YjVhMmQ1OWNiNDFiZmMyNGViNWFjMjZjM2Q0N2Q0OWZiOGZmNzhmLi4xNzMzMjFk
ZDlhYzM0YmE4N2VmZjBlZWU5NjA2MzVmMzBkODc4OTkxIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUv
bGFwaS9sZHQuaAo+ICsrKyBiL2luY2x1ZGUvbGFwaS9sZHQuaAo+IEBAIC0zMSw3ICszMSwyNyBA
QCBzdHJ1Y3QgdXNlcl9kZXNjIHsKPiAgIHN0YXRpYyBpbmxpbmUgaW50IG1vZGlmeV9sZHQoaW50
IGZ1bmMsIGNvbnN0IHN0cnVjdCB1c2VyX2Rlc2MgKnB0ciwKPiAgIAkJCSAgICAgdW5zaWduZWQg
bG9uZyBieXRlY291bnQpCj4gICB7Cj4gLQlyZXR1cm4gdHN0X3N5c2NhbGwoX19OUl9tb2RpZnlf
bGR0LCBmdW5jLCBwdHIsIGJ5dGVjb3VudCk7Cj4gKwlsb25nIHJ2YWw7Cj4gKwo+ICsJZXJybm8g
PSAwOwo+ICsJcnZhbCA9IHRzdF9zeXNjYWxsKF9fTlJfbW9kaWZ5X2xkdCwgZnVuYywgcHRyLCBi
eXRlY291bnQpOwo+ICsKPiArI2lmZGVmIF9feDg2XzY0X18KPiArCS8qCj4gKwkgKiBUaGUga2Vy
bmVsIGludGVudGlvbmFsbHkgY2FzdHMgbW9kaWZ5X2xkdCgpIHJldHVybiB2YWx1ZQo+ICsJICog
dG8gdW5zaWduZWQgaW50IHRvIHByZXZlbnQgc2lnbiBleHRlbnNpb24gdG8gNjQgYml0cy4gVGhp
cyBtYXkKPiArCSAqIHJlc3VsdCBpbiBzeXNjYWxsKCkgcmV0dXJuaW5nIHRoZSB2YWx1ZSBhcyBp
cyBpbnN0ZWFkIG9mIHNldHRpbmcKPiArCSAqIGVycm5vIGFuZCByZXR1cm5pbmcgLTEuCj4gKwkg
Ki8KPiArCWlmIChydmFsID4gMCAmJiAoaW50KXJ2YWwgPCAwKSB7Cj4gKwkJdHN0X3JlcyhUSU5G
TywKPiArCQkJIldBUk5JTkc6IExpYmMgbWlzaGFuZGxlZCBtb2RpZnlfbGR0KCkgcmV0dXJuIHZh
bHVlIik7Cj4gKwkJZXJybm8gPSAtKGludCllcnJubzsKPiArCQlydmFsID0gLTE7Cj4gKwl9Cj4g
KyNlbmRpZiAvKiBfX3g4Nl82NF9fICovClRoaXMgY29kZSBpcyBjb3JyZWN0LCBidXQgY2hlY2sg
Y29tbWVudCBiZWxvdy4uCj4gKwo+ICsJcmV0dXJuIHJ2YWw7Cj4gICB9Cj4gICAKPiAgIHN0YXRp
YyBpbmxpbmUgaW50IHNhZmVfbW9kaWZ5X2xkdChjb25zdCBjaGFyICpmaWxlLCBjb25zdCBpbnQg
bGluZW5vLCBpbnQgZnVuYywKPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2N2ZS9jdmUtMjAxNS0z
MjkwLmMgYi90ZXN0Y2FzZXMvY3ZlL2N2ZS0yMDE1LTMyOTAuYwo+IGluZGV4IDhlYzFkNTNiYmI1
YTlmM2U3NzYxZDM5ODU1ZDM0ZjU5M2UxMThhMjguLmU3MDc0MmFjYzg3YzM5MDg4OTUzZTAyZjE2
MTQ2YjdiNThhNzVmZDEgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2N2ZS9jdmUtMjAxNS0zMjkw
LmMKPiArKysgYi90ZXN0Y2FzZXMvY3ZlL2N2ZS0yMDE1LTMyOTAuYwo+IEBAIC0xOTcsNyArMTk3
LDEzIEBAIHN0YXRpYyB2b2lkIHNldF9sZHQodm9pZCkKPiAgIAkJLnVzZWFibGUJID0gMAo+ICAg
CX07Cj4gICAKPiAtCVNBRkVfTU9ESUZZX0xEVCgxLCAmZGF0YV9kZXNjLCBzaXplb2YoZGF0YV9k
ZXNjKSk7Cj4gKwlURVNUKG1vZGlmeV9sZHQoMSwgJmRhdGFfZGVzYywgc2l6ZW9mKGRhdGFfZGVz
YykpKTsKPiArCWlmIChUU1RfUkVUID09IC0xICYmIFRTVF9FUlIgPT0gRUlOVkFMKSB7Cj4gKwkJ
dHN0X2JyayhUQ09ORiB8IFRURVJSTk8sCj4gKwkJCSJtb2RpZnlfbGR0OiAxNi1iaXQgZGF0YSBz
ZWdtZW50cyBhcmUgcHJvYmFibHkgZGlzYWJsZWQiKTsKPiArCX0gZWxzZSBpZiAoVFNUX1JFVCAh
PSAwKSB7Cj4gKwkJdHN0X2JyayhUQlJPSyB8IFRURVJSTk8sICJtb2RpZnlfbGR0Iik7Cj4gKwl9
CldoYXQgYWJvdXQgaGFuZGxpbmcgdGhpcyBpbiBzYWZlX21vZGlmeV9sZHQsIHNvIGFsbCB0ZXN0
cyB1c2luZyAKU0FGRV9NT0RJRllfTERUKCkgd2lsbCB1c2UgaXQ/Cj4gICB9Cj4gICAKPiAgIHN0
YXRpYyB2b2lkIHRyeV9jb3JydXB0X3N0YWNrKHVuc2lnbmVkIHNob3J0ICpvcmlnX3NzKQo+Cj4g
LS0tCj4gYmFzZS1jb21taXQ6IGIwNzBhNTY5MmUwMzVlYzEyYzNkM2M3YTdlOWU5N2MyNzBmZDRk
N2QKPiBjaGFuZ2UtaWQ6IDIwMjUwNTA3LWZpeGVzLW1vZGlmeV9sZHQtZWJjZmRkMmE3ZDMwCj4K
PiBCZXN0IHJlZ2FyZHMsCi0gQW5kcmVhCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
