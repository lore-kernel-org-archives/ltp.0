Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBC8C7115B
	for <ltp@archiver.kernel.org>; Mon, 23 Jun 2025 17:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750700352; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=DJrtQT0I2/Zr+IKW2UlhskZTgAssf5epIAuOWt4fauU=;
 b=AGKezC2RPF11OAb1j95nIwe5+w7NT9kS/2yNb/d8WK6TvxW4ku7t77stTq27j5lIuaVPT
 aa7TP+oTbUjClp1JeytCLQAfmvc/B76T2LLQUYU2/DllGRvhhhnOpyOj8qAHWrHHLt8juxO
 LOsdgJx+iq7bA97YfPR80PI7vQnMdHA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3569A3CCA7C
	for <ltp@archiver.kernel.org>; Mon, 23 Jun 2025 19:39:12 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E2163C9982
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 19:38:50 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 766D2600274
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 19:38:49 +0200 (CEST)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ad883afdf0cso887236366b.0
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 10:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1750700329; x=1751305129; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Gbd678p15xJDH3dZbwI6MkfIuPk9ylT+q7bFx7NMvSc=;
 b=Vnw8n9OylVQzFjvOFIN8UDUP3YHNLVv91R6ccGp0WJL0eNZhOzSZMXjaI/qqmBmOOv
 b6Z6nt0EatrKxywDKgD/A6fv25ljIFgwJ2tHwuaFViYg9NVwgxHv8PnKCBg7Fw4xvHmi
 Ygl+PHbKRgr4v4Q3/YBiBcCrhe3yGx2X2jl+/iF0IMdDz9JdQXWLrUeHla6/zVkWH858
 ELGTGxHIDFjIjEOS0AFVMeHowxwNNf9ddk7T2kdihZbVhVxAufrCOxEKqaYV2wSqTOY5
 bMvAgCDr1ycSYnGfT+611LLJd73SYd1K+hmgpu/h89NcS40dysmeP0yzI8cTs00/JUJ0
 KJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750700329; x=1751305129;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gbd678p15xJDH3dZbwI6MkfIuPk9ylT+q7bFx7NMvSc=;
 b=c/FCxT1Pn7YDqEM8sL5qAx1KRhtDuG555kE7yWWmYXxYW+4KyXNLt72GaBmjwkaQ31
 hf8nSGaB+SuEnPjTciZL2BHpIgrvUot/cmKVm60XvenYs17gdnpjImxuIcJ/quqZ7+K1
 TRsLWEok2L3eyOt7zu0QVB2G4QjSyMt5WurrlnZ7ZrHHN10n+tdcfWo10CDJZQ5zRZfm
 VDqSwj5mnohVgqbwWt8HXL5e5CnAgo4LkLP1hy+VFPyFCT1V3aK7XbWKCzgeSZbWwRh5
 oU++8M2RFLx53fwMMkR7ZgLGfQ/rg9T4tDKt1l2oqtxSj8p2FK03JA2zu/wFh+sL8cgE
 mSNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlgWmjzrBkjwpyChL1OEtZvh8WRYfGuZeooCovdH1uF/+4AmtC0pHJSA0qPq3mC2mIUfA=@lists.linux.it
X-Gm-Message-State: AOJu0YxOFD2XRwuxvAOkxRzxPPA5XkoGe92OBGKB00sn0t2mOAKFWgds
 uecovxk8RzBWcQwOBlcPiUC1RV/kmp3eaFTaV6sQdaxs2tpLQRJSjlyy6zyu80JtkfCvvmhaQUQ
 gmmaEwAl+EA==
X-Gm-Gg: ASbGncuC3u1bswFtAAQBFRc5plI/r3of8GUsH48QTBQyFxoGbJEtxgd65x5wAT2+UKU
 LC1mrAyZLYySPWZV4pye3uwI8zjp2UDOxfc1RkmsTQ2TYaTNDjqM1VoHy5ghRpRWxI9fKoLdcWk
 LMhZtgby2qqu6Z3akdJQeWSqByINyqteqXP758yHpJ5o+j+X0u0DxxNHJ+hYLkmm/hV/m+yH+Gg
 zOYtph3Ai8NoIJ+izlbkmDJ0SRkwekr4csEkHqhP4cV3LRun5SyrgPmeGR67ieEzK6Bf4KcA0xq
 vDU+EgFvJNlDV48SGJcrcUV6d34kgzng0jmUvpUwnSDD0MzT6mNqVFulLs81YKvZjDR1CRI+G16
 CO/DiRkHciXGKDWbRwmWUPcXtUmrTSaMjcTb4K93yCYPR6bwWQNCI/DWBpKBcPCgmkzbzALR4US
 KpZ7MTZds3udcZDsvFRgQTsTU6eg==
X-Google-Smtp-Source: AGHT+IGL5BMg9Wilg7XKIm9UPVnLXUxSDe5dfRiyQMmHPxcNwwemxukpeQcxu/ZOOx9d5V+nGgk1SA==
X-Received: by 2002:a17:907:72d5:b0:ad8:9e80:6bb8 with SMTP id
 a640c23a62f3a-ae0578d850bmr1265594966b.6.1750700328815; 
 Mon, 23 Jun 2025 10:38:48 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae054209349sm741675466b.152.2025.06.23.10.38.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 10:38:48 -0700 (PDT)
Message-ID: <ec0768c5-f313-4e86-b79d-033bccf0c4f6@suse.com>
Date: Mon, 23 Jun 2025 19:38:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250623-conversions-shmt-v4-1-5d877da3ecea@suse.com>
Content-Language: en-US
In-Reply-To: <20250623-conversions-shmt-v4-1-5d877da3ecea@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] mem: Convert shmt02 to new API
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

SGkhCgpNZXJnZWQgd2l0aCBhIHNtYWxsIGNoYW5nZSBiZWNhdXNlIEkgcmVhbGl6ZWQgbXkgc3Vn
Z2VzdGlvbiB0byB1c2UgClRTVF9FWFBfRVFfU1RSTigpIHdhcyBub3QgbWF0Y2hpbmcgTFRQIHN0
YW5kYXJkcyAoZGF0YSAhPSBzdHJpbmdzKS4KCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVs
L21lbS9zaG10L3NobXQwMi5jIApiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL3NobXQvc2htdDAyLmMK
aW5kZXggMDIwMDc0ZDNlLi4xNmQ5OWFjN2EgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwv
bWVtL3NobXQvc2htdDAyLmMKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0vc2htdC9zaG10MDIu
YwpAQCAtMzQsNyArMzQsMTIgQEAgc3RhdGljIHZvaWQgcnVuKHZvaWQpCgogwqDCoMKgwqDCoMKg
wqAgU0FGRV9TSE1DVEwoc2htaWQsIElQQ19STUlELCBOVUxMKTsKCi3CoMKgwqDCoMKgwqAgVFNU
X0VYUF9FUV9TVFJOKGNwLCB0c3RfcmFuZF9kYXRhLCBTSE1TSVpFKTsKK8KgwqDCoMKgwqDCoCBp
ZiAobWVtY21wKGNwLCB0c3RfcmFuZF9kYXRhLCBTSE1TSVpFKSAhPSAwKSB7CivCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHRzdF9yZXMoVEZBSUwsICJDb3BpZWQgZGF0YSBjaGFuZ2VkIGFm
dGVyIElQQ19STUlEIik7CivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybjsKK8Kg
wqDCoMKgwqDCoCB9CisKK8KgwqDCoMKgwqDCoCB0c3RfcmVzKFRQQVNTLCAiQ29waWVkIGRhdGEg
aGFzIGJlZW4gcmVhZCBiYWNrIik7CiDCoH0KCiDCoHN0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVz
dCA9IHsKCi0gQW5kcmVhCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo=
