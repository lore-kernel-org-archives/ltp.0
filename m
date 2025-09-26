Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81EDFCAC5AC
	for <ltp@archiver.kernel.org>; Fri, 26 Sep 2025 07:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1758871962; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=aCxaFuOqZxnw2198nqxiOPQWEM9C7EcjSiEp2K9aA7o=;
 b=KLgKzyflkFNJTXUr+d/aX7JTF/W4nVPTxeQlIy6xw4KxKpq7+mBmoLmpCHlQwPo0Xtmx5
 f9LUoV59BDKWZM53WiZdcCzYnLCpiy8b2KtaSe6nCIx8BpTvuJk1eGh9+8lYlxbzrzyTr8w
 MtwsVN+cLwVyIy+czNUM3oPki1MQXRo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A39AE3CE099
	for <ltp@archiver.kernel.org>; Fri, 26 Sep 2025 09:32:42 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 89B493CA02F
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 09:32:22 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 545AD1A006FC
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 09:32:21 +0200 (CEST)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b33d785db6fso355856266b.2
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 00:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1758871941; x=1759476741; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jg8286Ez+0Rq7Jd7BmNR81ldc9Em/tOlIQIYl5jtMvU=;
 b=TwR7P2aeGQis0W+6XVj53qNaYvxFQ2CiGJITYZRHRs52FIPL/JuN25PZOgaUB9DrMM
 WIbo6IyOtWixDrKaU8BolKQnbsqE9EHdwqAeQNJXE1r0t07vtmS03PmcsN3/4QwYg23V
 s0CCc+d2FwNnXXPIdO2j1hyCs1rxFmVnXsXo+Dp81faK4jCqOE0wksP3pbtiQwC0iZzX
 OO+OI2B3+Qd7ALUDbh4hVfwynaubM0b57XoTDr7z3CB3FcwbZk9kXlr8q6h7TKSgg3Q9
 7XG/hbni8dFGt5BpUmzMo6ZMFa/Kzn1uNHhZLVLVqBK9cuEOHMGSRWVIyhoBHCLox/Wa
 XrzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758871941; x=1759476741;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jg8286Ez+0Rq7Jd7BmNR81ldc9Em/tOlIQIYl5jtMvU=;
 b=q+3Z0midr34Tw6RT+1FVvNraZ63YQe+xZZaW3wenek/a/F63fpGFJl0xheHWAI0pyT
 uEMrntgk5tFKD9Znc7OEjfmOGU0VLb+8SG14CUlbtx89nu9uZLDcjk0w9sa0D9rBOu8M
 CQ2Oyslt/6pB5PsUyIq2IcuJp19IaCptrPH1I57jxRQzXa5zZAEFWByp0s27Bsix9LQv
 ZIgAzBf+8a5ruyxu4MYxGbIkaHeSscPpntC7mb92rLnyO4LznbJoEesqPW5qGmeuxw8B
 m125kOBsPy+hVToEd9pmNXOnOcf+2ysHdvGtBdPC/lypYLt4+1MI78it5cFMaI6wv97l
 ARzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZ+lsDqPrXdZNG/lmuMTmAMekbRb+STwy15+/CvHmK1vWxBHdUx3/opYYi5oiIrdkJ3AM=@lists.linux.it
X-Gm-Message-State: AOJu0YyK+ncZ4q7JWS3NHTeV+ncaLUCRkXfVluWBCENdleei0QqQlYUR
 lGZK2Um58VUJuSh7rwsfNrs1JdVrrHJX6KUwUCK93c1a4SPJKPmhVVuNPaNSZ9R2B2jsAR0olxt
 WuM4HFoc=
X-Gm-Gg: ASbGncsSqypWgQZ3PD5fgmYsmsGKbbq9DmN6fO+2P27Ix8SHRBBPnZdmtQkIAEUWQUJ
 2ETdCCv5llxwZZ1/MD+LQhRMfGvrol7yJsM2NF3ESWdSxCNz/Qp9zseENO2+fA4nVw4NQoMdLl0
 rtOhjRREcGkUegFaIT4Fxq1gLZpfcBchFVcePdGGbftPVpmq5O7+hZ4FgDxZ16Z1FVxS3LmBmvL
 kVEkXOEmColPyjkenZVoqQT46TEomAtIkRbLC6s5RzK7Dn568gwvw5TWve/9geE0P7ki1Nn7x6R
 AUQ1S4/hF0fxUXoW4Wg4+d4N/2PbVKC/B/OecH/HnJt97AE/l7RX8XRRArbvzmmKrOtgBfIhbBK
 Yb1YSYoTJdfrAQvkRvk5M48qm7GyL7t0iL+J6yVfORcZRdvcNkwPXJKUta6e0LUi18Np7MUvAZe
 KvjEbSviqDo6eC3Pv/f+6pRsOipMWNEI0mmxn3WbE/MuWHndfpnySqS17Ma9cUSdw=
X-Google-Smtp-Source: AGHT+IHHlKvRN7jre1riro4utooM9BwoU1cS14S9EM0heVDMkY3mVYrI6uEoZx5C8T1YTGTRgejdHw==
X-Received: by 2002:a17:907:94c7:b0:b2d:804c:f5c with SMTP id
 a640c23a62f3a-b34b684a76bmr779350266b.4.1758871940630; 
 Fri, 26 Sep 2025 00:32:20 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f17:6d00:961b:d261:4569:b9c8?
 (p200300ef2f176d00961bd2614569b9c8.dip0.t-ipconnect.de.
 [2003:ef:2f17:6d00:961b:d261:4569:b9c8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b35446f74fbsm312695466b.51.2025.09.26.00.32.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Sep 2025 00:32:20 -0700 (PDT)
Message-ID: <4d514eb9-cf7e-430e-a0ad-dfffdf947fcc@suse.com>
Date: Fri, 26 Sep 2025 09:32:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jack Morgan <jmorgan@naotchy.com>, ltp@lists.linux.it
References: <20250926040707.671282-1-jmorgan@naotchy.com>
 <20250926040707.671282-2-jmorgan@naotchy.com>
Content-Language: en-US
In-Reply-To: <20250926040707.671282-2-jmorgan@naotchy.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] statmount09.c: Enable mnt_ns_id for
 STATMOUNT_MNT_NS_ID
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

SGkhCgpPbiA5LzI2LzI1IDY6MDcgQU0sIEphY2sgTW9yZ2FuIHdyb3RlOgo+ICsjaWZkZWYgTFRQ
X0hBVkVfU1RSVUNUX1NUQVRNT1VOVF9NTlRfTlNfSUQKPiAgIAlUU1RfRVhQX0VRX0xJKHN0X21v
dW50LT5tbnRfbnNfaWQsIG1udF9uc19pZCk7Cj4gKyNlbHNlCj4gKwl0c3RfcmVzKFRDT05GLCAi
c3RhdG1vdW50Lm1udF9uc19pZCBub3QgYXZhaWxhYmxlIGluIGN1cnJlbnQgaGVhZGVycywgc2tp
cHBpbmcgY2hlY2siKTsKPiArI2VuZGlmCgpUaGUgc3RhdG1vdW50MDkgaXMgdGVzdGluZyBTVEFU
TU9VTlRfTU5UX05TX0lEIGZlYXR1cmUsIHdoaWNoIGlzIApjYXJyeWluZyB0aGUgbW50X25zX2lk
IGFzIHdlbGwsIHNvIHdlIGRvbid0IG5lZWQgdG8gcnVuIHRoaXMgdGVzdCBpZiAKSEFWRV9TVFJV
Q1RfU1RBVE1PVU5UX01OVF9OU19JRCBpcyBub3QgZGVmaW5lZC4KV2UgY2FuIGRvIHNvbWV0aGlu
ZyBsaWtlOgoKZGlmZiAtLWdpdCBhL2NvbmZpZ3VyZS5hYyBiL2NvbmZpZ3VyZS5hYwppbmRleCBk
NGRkMTMwMzMuLjE4OWQ4NzcxZSAxMDA2NDQKLS0tIGEvY29uZmlndXJlLmFjCisrKyBiL2NvbmZp
Z3VyZS5hYwpAQCAtMjY0LDYgKzI2NCw3IEBAIEFDX0NIRUNLX1RZUEVTKFtzdHJ1Y3QgY2FjaGVz
dGF0XSwsLFsjaW5jbHVkZSAKPHN5cy9tbWFuLmg+XSkKIMKgIyBEZWZpbmVkIGluIDxsaW51eC9t
b3VudC5oPiwgYnV0IGluY2x1ZGUvbGFwaS9tb3VudC5oIGluY2x1ZGVzIAo8c3lzL21vdW50Lmg+
ICovCiDCoEFDX0NIRUNLX1RZUEVTKFtzdHJ1Y3QgbW50X2lkX3JlcV0sLCxbI2luY2x1ZGUgPHN5
cy9tb3VudC5oPl0pCiDCoEFDX0NIRUNLX1RZUEVTKFtzdHJ1Y3Qgc3RhdG1vdW50XSwsLFsjaW5j
bHVkZSA8c3lzL21vdW50Lmg+XSkKK0FDX0NIRUNLX01FTUJFUlMoW3N0cnVjdCBzdGF0bW91bnQu
bW50X25zX2lkXSwsLFsjaW5jbHVkZSA8bGludXgvbW91bnQuaD5dKQoKIMKgQUNfQ0hFQ0tfVFlQ
RVMoW3N0cnVjdCBwaWRmZF9pbmZvXSwsLFsjaW5jbHVkZSA8c3lzL3BpZGZkLmg+XSkKIMKgQUNf
Q0hFQ0tfVFlQRVMoW3N0cnVjdCBmaWxlX2F0dHJdLCwsWyNpbmNsdWRlIDxsaW51eC9mcy5oPl0p
CmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N0YXRtb3VudC9zdGF0bW91
bnQwOS5jIApiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc3RhdG1vdW50L3N0YXRtb3VudDA5
LmMKaW5kZXggMjBjNzZiYTI0Li5iNzhjZWM2YjQgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvc3RhdG1vdW50L3N0YXRtb3VudDA5LmMKKysrIGIvdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9zdGF0bW91bnQvc3RhdG1vdW50MDkuYwpAQCAtMTUsNiArMTUsMTEgQEAKIMKg
ICrCoCDCoG5hbWVzcGFjZQogwqAgKi8KCisjaW5jbHVkZSAiY29uZmlnLmgiCisjaW5jbHVkZSAi
dHN0X3Rlc3QuaCIKKworI2lmZGVmIEhBVkVfU1RSVUNUX1NUQVRNT1VOVF9NTlRfTlNfSUQKKwog
wqAjZGVmaW5lIF9HTlVfU09VUkNFCgogwqAjaW5jbHVkZSAic3RhdG1vdW50LmgiCkBAIC03Miwz
ICs3Nyw4IEBAIHN0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKIMKgIMKgIMKgIMKgIH0K
IMKgfTsKCisjZWxzZQorCitUU1RfVEVTVF9UQ09ORigiU1RBVE1PVU5UX01OVF9OU19JRCBzdXBw
b3J0IGlzIHJlcXVpcmVkIik7CisKKyNlbmRpZgoKVGhpcyBjb3VsZCBiZSBkb25lIGJ5IGNoZWNr
aW5nIGlmIFNUQVRNT1VOVF9NTlRfTlNfSUQgZXhpc3RzLCBidXQgc2luY2UgCm1udF9uc19pZCBh
dHRyaWJ1dGUgYW5kIFNUQVRNT1VOVF9NTlRfTlNfSUQgYXJlIGRlZmluZWQgaW4gdGhlIHNhbWUg
CmNvbW1pdCAoMDliMzEyOTVmODMzMDMxYzg4NDE5NTUwMTcyNzAzZDQ1YzU0MDFlMyAtIGZzOiBl
eHBvcnQgdGhlIG1vdW50IApucyBpZCB2aWEgc3RhdG1vdW50KSwgd2UgY2FuIHNhZmVseSB1c2Ug
Y29uZmlndXJlLmFjLgoKLSBBbmRyZWEKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
