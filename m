Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE08C369B9
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 09:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744795974; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=buT11RdXKBLoSjqTzKpOcAnFTXCn2zqZPFEkMtSOuNA=;
 b=h4+T/K8Dd6iut/zyv25FIaz8ZDBYg2P/HqeJclse8QDpqvL05bg3mbULmJ/ytK0y5bO59
 vgHiV9r66veA9Jt6roBSJn0MiYDJ109TZPROFiuwyti21905QaRsINS5f5mPdiwm1JYHMr5
 c3sMEW29cxtDSKKgY7NO8URnuNzN5bU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4837D3CB957
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 11:32:54 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A8BB3CA59D
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 11:32:33 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D34991000999
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 11:32:32 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39c266c2dd5so5808621f8f.3
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 02:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1744795952; x=1745400752; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w7g+ZbPYqCFCajchC4Lcj2g8qMSNKoSjwnSI9hQQ+Pw=;
 b=ZByMc+3jverzlFAapPv+7obEtrRCHIw2aWZb7BqsGeWs416ThvL8BObdq8ovDLxNZb
 4FxrmMNu/R6ACzpVkBrRWDHdbR3JR1GDxTbewJ02rgFyWacb2lK33rNsaMNuM35STk9o
 AqCR7Zcg/hDUebFFqA4sCDeXeukRGsbTACibnVlUTKGlnOy2HOjil+EQ04L9ftE9E4X+
 yGBzArQxVg3QmTDko1wHVHexyWtx3Ye3cDMCxTs78D+48KvTBBoYNqPMRHTlLdwPMkzv
 zhCzLE9foEbbTfmdxK3jIuHfvMdzAdxIlKGauZ2h58QEuMbo4Skmm+VBc+Lxx5EfaOMd
 6gBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744795952; x=1745400752;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w7g+ZbPYqCFCajchC4Lcj2g8qMSNKoSjwnSI9hQQ+Pw=;
 b=JBxyRt8z3HqwKK6hq5RXxBauHC/cSPhdiRgbFxA+Stx5Q+LdEBTzwY2ygH5yB6eSO7
 mYGWXdOfm4MYGxyrqrw1gIR3KoDbzQ1iVo+vvzVgRYo4UATD2Fh2cBu9EVncx9sFWKPD
 7HhTrdUVj15KOmS9yCH+FGIVEc9mA5pyDQxjNJXeC04fhoZS88qFb8WZyxkhgqXLe+UH
 g7dnL57Dy/Q3ep+EM7RHt+d0/ZgHyv+bn856Eashinr85pAXnB1Z6CdI1fsXCspaHuoh
 TeAbaaLLBigXao+6NBkeQxJhz1EiTvByA/BKVejSxUyLY+N6rdZ8M9GhE1vtNs7b+l9l
 tLvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfKl2P0sOlmiFGp4c+s9VBrcI9jHfwQIB7taLoDttKwZ8PFFH+s/Lp397DbQJneLI5SZ8=@lists.linux.it
X-Gm-Message-State: AOJu0Yx12GVraHrY6Ag0HumOd0iz+XXMK5sTzkJLEICoSMC+LvlChpNx
 /T+6xansWL+YxppOh7fh7Y4BURTp+punrkcAJbuBKm6nGJoIWsGcWwyXsI/6QEY=
X-Gm-Gg: ASbGncuySRMQwmZlgWrjNMf+hPlws4jDpo97CuIEi++O4VVm8fDz2qmlZIG1xnZf27t
 a7TwTRyyy3jCL2sMilQv1RRPAecpuSksufduB4DHcu1jdlGAbEM8Vn0xuQHs/Iz6Yq4b7pgv/0M
 s2oZSX1gBBkLw7MnyY7OzLCOoOrlxfk/6ncgvbSaHVm+0oB3spgiYTdgRtBQ6Wc7dI2/xl5+e36
 3kZ1DSodcVbmvztH3pc5/QnWCF+T1slRFnNbVAiQ3rCKSyonOkDXXlYAgP+y1OXw+QBZJ9qX3ti
 KfUQddGOSD9y2QJ4/VARd1tNWt9gSjiGK9iSrv9cNjj7azDT+ANybwcoB86Ci3+tXAb61PPJhnj
 toZmHmMCupxhN/XUItyVP0i2JfwQwPkr1Twyp/JWplzJSxdRRY7CiDfzyaRU1RqkVbedAkmyT8N
 e61ww=
X-Google-Smtp-Source: AGHT+IHjJgVIR5ymxefc+01uQvWWXnIc8GW9JE/6vPoWYJlRuJvNcLJfUBjkgL3vPuew3LO4MTvsKw==
X-Received: by 2002:a05:6000:250c:b0:38f:4acd:975c with SMTP id
 ffacd0b85a97d-39ee5b1cb72mr997881f8f.27.1744795952192; 
 Wed, 16 Apr 2025 02:32:32 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f1a:ea00:b220:7501:321e:5c31?
 (p200300ef2f1aea00b2207501321e5c31.dip0.t-ipconnect.de.
 [2003:ef:2f1a:ea00:b220:7501:321e:5c31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4404352a536sm34664555e9.1.2025.04.16.02.32.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 02:32:31 -0700 (PDT)
Message-ID: <14be2206-74e5-4d29-a43d-3796f83f68b1@suse.com>
Date: Wed, 16 Apr 2025 11:32:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ma Xinjian <maxj.fnst@fujitsu.com>, ltp@lists.linux.it
References: <20250411072309.43689-1-maxj.fnst@fujitsu.com>
Content-Language: en-US
In-Reply-To: <20250411072309.43689-1-maxj.fnst@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mmap18: Fix the doc
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

SGkgTWEsCgpJIG1lcmdlZCB0aGlzwqAgcGF0Y2gsIGFzIHdlbGwgYXMgYWxsIHRoZSBvdGhlcnMg
cmVsYXRlZCB0byB0ZXN0cyAKZGVzY3JpcHRpb24gaW4gUlNUIGZvcm1hdC4KCktpbmQgcmVnYXJk
cywKQW5kcmVhIENlcnZlc2F0bwoKT24gNC8xMS8yNSAwOToyMywgTWEgWGluamlhbiB2aWEgbHRw
IHdyb3RlOgo+IFVzZSA6OiB0byBrZWVwIHRoZSBkZXNjcmlwdGlvbiBvZiBzdGFjayBtZW1vcnkg
bWFwIGFzIG9yaWdpbmFsIHRleHQgd2hlbiB2aWV3ZWQgaW4gUlNUIGZvcm1hdC4KPgo+IFNpZ25l
ZC1vZmYtYnk6IE1hIFhpbmppYW4gPG1heGouZm5zdEBmdWppdHN1LmNvbT4KPiAtLS0KPiAgIHRl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbW1hcC9tbWFwMTguYyB8IDIwICsrKysrKysrKystLS0t
LS0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25z
KC0pCj4KPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tbWFwL21tYXAx
OC5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tbWFwL21tYXAxOC5jCj4gaW5kZXggM2Rl
NTI0ZWNjLi41ZjBlZWU2YmEgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9tbWFwL21tYXAxOC5jCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tbWFwL21t
YXAxOC5jCj4gQEAgLTI4LDE4ICsyOCwxOCBAQAo+ICAgICoKPiAgICAqIEtlcm5lbCBkZWZhdWx0
IGBzdGFja19ndWFyZF9nYXBgIHNpemUgaXMgYDI1NiAqIGdldHBhZ2VzaXplKClgLgo+ICAgICoK
PiAtICogVGhlIHN0YWNrIG1lbW9yeSBtYXAgd291bGQgbG9vayBsaWtlOgo+ICsgKiBUaGUgc3Rh
Y2sgbWVtb3J5IG1hcCB3b3VsZCBsb29rIGxpa2U6Ogo+ICAgICoKPiAtICogfCAgLSAgLSAgLSAg
IHJlc2VydmVkICBzaXplICAgLSAgLSAgLSAgfAo+ICsgKiAgIHwgIC0gIC0gIC0gICByZXNlcnZl
ZCAgc2l6ZSAgIC0gIC0gIC0gIHwKPiAgICAqCj4gLSAqICstLSAtIC0gLSAtLSstLS0tLS0tLS0t
LS0rLS0tLS0tLS0tLS0tLSsKPiAtICogfCAyNTYgcGFnZXMgfCAgdW5tYXBwZWQgIHwgICBtYXBw
ZWQgICAgfAo+IC0gKiArLS0gLSAtIC0gLS0rLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0rCj4g
LSAqICAgICAgICAgICAgICAgICAgICAgICAgICB8IG1hcHBlZCBzaXplIHwKPiAtICogXiAgICAg
ICAgICAgfCAgLSAgLSAgc3RhY2sgc2l6ZSAgLSAgLSAgfAo+IC0gKiBzdGFydAo+IC0gKiAgICAg
ICAgICAgICBeICAgICAgICAgICAgICAgICAgICAgICAgICBeCj4gLSAqICAgICAgICAgICAgIHN0
YWNrIGJvdHRvbSAgICAgICBzdGFjayB0b3AKPiArICogICArLS0gLSAtIC0gLS0rLS0tLS0tLS0t
LS0tKy0tLS0tLS0tLS0tLS0rCj4gKyAqICAgfCAyNTYgcGFnZXMgfCAgdW5tYXBwZWQgIHwgICBt
YXBwZWQgICAgfAo+ICsgKiAgICstLSAtIC0gLSAtLSstLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0t
LSsKPiArICogICAgICAgICAgICAgICAgICAgICAgICAgICAgfCBtYXBwZWQgc2l6ZSB8Cj4gKyAq
ICAgXiAgICAgICAgICAgfCAgLSAgLSAgc3RhY2sgc2l6ZSAgLSAgLSAgfAo+ICsgKiAgIHN0YXJ0
Cj4gKyAqICAgICAgICAgICAgICAgXiAgICAgICAgICAgICAgICAgICAgICAgICAgXgo+ICsgKiAg
ICAgICAgICAgICAgIHN0YWNrIGJvdHRvbSAgICAgICBzdGFjayB0b3AKPiAgICAqCj4gICAgKiAq
KlRlc3QgMioqCj4gICAgKgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo=
