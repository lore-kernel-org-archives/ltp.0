Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0447EF9B61D
	for <ltp@archiver.kernel.org>; Wed, 22 Apr 2026 11:12:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 77D763E4A7D
	for <ltp@archiver.kernel.org>; Wed, 22 Apr 2026 13:12:03 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 81BDC3E1B20
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 13:11:43 +0200 (CEST)
Received: from mail-dy1-x1341.google.com (mail-dy1-x1341.google.com
 [IPv6:2607:f8b0:4864:20::1341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CCBD7600683
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 13:11:42 +0200 (CEST)
Received: by mail-dy1-x1341.google.com with SMTP id
 5a478bee46e88-2b6b0500e06so8457888eec.1
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 04:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776856301; x=1777461101; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1B4KG9caQPyAuUlmAFeoHVTKr/D6yylwxirC023kQ3E=;
 b=pg9MkmBNT/9aU0WuzbA5QBbNjrje63NdZm4F8tsiyXbVhdiJF8uOIOPOsLoJpUwxVn
 o7UAPBBbhi/ogK/JPdEfG02ZBhE5gPIFJownjCKcKpXoomdmamtevs/tE4Bgg83IfP3F
 chq8Kkj3dV2KuSZTQMgxja9ZSg5nMxDQwOiLyjuULt+eXPGNhS0hVhlTcFFzJ88umeSz
 rWLi35bZ0Fu3imD6Tf7dieLs+ChYREmaEMnhKJ+othwfcKCmeAKVKaExdbSP+7MAkQyG
 bWoLr9dLuWjki6Jd3QCY5o5jzYKP/BeTjsLM9J/bA1P5bjF/fl0qrfv1EEGyFegnDTwI
 XnHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776856301; x=1777461101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1B4KG9caQPyAuUlmAFeoHVTKr/D6yylwxirC023kQ3E=;
 b=mPnEEtPq1p54di8oU0yaIxbR6cvtU+0kU0lIvJSU7j+gzP4WEWBOKUEtALhlzNH7qT
 k26zROdvTcp6gL1BR+gRSR7GUIBSdf9DpcIgOuAd6gKV4y7uST43D/lVFWbPUejVR6W0
 4Emnct3M5o5TpOfi9wXyiXVMcp+CHdFgRu33iRtNFSkKNvrYmOUPiHSuwVs1TYr66s+h
 10e4KGQNzLaohQuvJGoODPcvQRRzjcIOFmtfEIf/Om4sjFSwMbvKP8btWpeu8CvmrV2N
 MjoiNpf6CMhvcMdkGMKPa7Cz4UNuU8lOApdeVUAsScKZ+/eLkkh9f+3u/c92AqNCjDAS
 A3Gg==
X-Gm-Message-State: AOJu0YzW59jlxAH/Tb5ef0f89q8MOKCu9zWIHKMVx92N55hb4UycihU3
 wPPR6lBhLls/dLYGK0SdWgezrLfOgo5hq7uGrK/+SpXMCAgAQfrHG3ENUV2u2JDl2zI=
X-Gm-Gg: AeBDievKBzeIZ/ZSiogbCJhM/2ORo9eabujrrTvFZtvQd2UW+bWyFCKvbFlQKKhqOnO
 3fN1tXGN2J6QcJV4VDa8erjbCxczwSx/Vc5pdxU9CAoBkbmbwa8bxOPKUUY+5AMA4pqjZxQ6yE1
 X2SPQTogvlhjV51TMQmTe4AS7y9lEr/KFtGzux6dFGvcldHrIB2xWtvKCN/nBD3qBLyhx+tOk34
 HnbENEy4hXCyx9ayrSX46taIGrYGiT/4tTZ+CLMKy1uEqj1nT0rsHJJI5+UnqmnMAfCIsyY7AxH
 GHdeVypZFY+B6hJJDuWtRUmbpKyth2P80CXWvSBnZL7z/uzx9e1iEQsMc4lWib7K30KC+y7b1Qi
 x1hLcFeugATOrBJX9UfVUW+f2l+vDscyL34Aghsj5WF0BO6poIOHTs+L/VTJ9VFUVA1iG3tB3TA
 kx3z3KoaMXssv1hu1QoSFNEA/P5GCJfLBtTLhNBa6GluHNVEeDZfcYZ55cEe6yVhWemqm0XLGan
 bMcZJe36z0JzqQP69nvH2lOYbqg1uxBAcrKNZl2Pcolr3W/gptw
X-Received: by 2002:a05:7300:230c:b0:2d2:c60d:4fe5 with SMTP id
 5a478bee46e88-2e464ea4e10mr10699335eec.6.1776856300992; 
 Wed, 22 Apr 2026 04:11:40 -0700 (PDT)
Received: from
 runnervmeorf1.x4tjlv0jbqcu3pgfkj12tkpfpd.dx.internal.cloudapp.net
 ([172.184.213.165]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e539fa6134sm23384318eec.3.2026.04.22.04.11.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 04:11:40 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Piotr Kubaj <piotr.kubaj@intel.com>
Date: Wed, 22 Apr 2026 11:11:39 +0000
Message-ID: <20260422111139.4036-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260422103542.20933-2-piotr.kubaj@intel.com>
References: <20260422103542.20933-2-piotr.kubaj@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] cpufreq.c: add new test for cpufreq sysfs interface
 validation
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

SGkgUGlvdHIsCgpPbiAyMDI2LTA0LTIyLCBQaW90ciBLdWJhaiB3cm90ZToKPiBjcHVmcmVxLmM6
IGFkZCBuZXcgdGVzdCBmb3IgY3B1ZnJlcSBzeXNmcyBpbnRlcmZhY2UgdmFsaWRhdGlvbgoKPiAr
c3RhdGljIGxvbmcgKnByZXZpb3VzX3NjYWxpbmdfbWF4X2ZyZXEsICpwcmV2aW91c19zY2FsaW5n
X21pbl9mcmVxOwo+ICsKPiArc3RhdGljIHZvaWQgY2xlYW51cCh2b2lkKQo+ICt7Cj4gWy4uLl0K
PiArICAgICAgICAgICAgICAgU0FGRV9GSUxFX1BSSU5URihwYXRoLCAiJWxkIiwgcHJldmlvdXNf
c2NhbGluZ19tYXhfZnJlcVtpXSk7Cj4gWy4uLl0KPiArICAgICAgICAgICAgICAgU0FGRV9GSUxF
X1BSSU5URihwYXRoLCAiJWxkIiwgcHJldmlvdXNfc2NhbGluZ19taW5fZnJlcVtpXSk7CgpCb3Ro
IGFycmF5cyBhcmUgemVyb2VkIGJ5IFNBRkVfQ0FMTE9DIGluIHNldHVwKCkgYW5kIG9ubHkgcG9w
dWxhdGVkCmluc2lkZSBydW4oKS4gSWYgcnVuKCkgYWJvcnRzIGJlZm9yZSByZWFjaGluZyB0aGUg
cGVyLUNQVSBzYXZlIGxvb3BzCihlLmcuIGEgU0FGRV9PUEVOIG9yIFNBRkVfRklMRV9TQ0FORiBm
YWlscyBvbiBhbiBlYXJsaWVyIGNwdWZyZXEgbm9kZSksCmNsZWFudXAoKSB3cml0ZXMgMCB0byBz
Y2FsaW5nX21heF9mcmVxIGFuZCBzY2FsaW5nX21pbl9mcmVxIGZvciBldmVyeQpvbmxpbmUgQ1BV
LCBsZWF2aW5nIHRoZSBzeXN0ZW0gaW4gYW4gaW52YWxpZCBzdGF0ZS4KClJlYWQgdGhlIG9yaWdp
bmFsIHBlci1DUFUgdmFsdWVzIGluIHNldHVwKCkgaW5zdGVhZC4KClByZS1leGlzdGluZyBpc3N1
ZXMgbm90aWNlZCBpbiB0aGUgc3Vycm91bmRpbmcgY29kZSAobm90IGludHJvZHVjZWQKYnkgdGhp
cyBwYXRjaCk6CgotIGNwdWZyZXEuYzoxMTYg4oCUIHN0cnN0cihjb250ZW50cywgInBlcmZvcm1h
bmNlIHBvd2Vyc2F2ZSIpIGFzc3VtZXMKICBhIHNwZWNpZmljIGdvdmVybm9yIG9yZGVyaW5nIHRo
YXQgdGhlIGtlcm5lbCBkb2VzIG5vdCBndWFyYW50ZWUuCi0gY3B1ZnJlcS5jOjE3MCDigJQgc2Ft
ZSBpc3N1ZSBmb3IgInBlcmZvcm1hbmNlIHNjaGVkdXRpbCIuCgotLS0KTm90ZToKCk91ciBhZ2Vu
dCBjb21wbGV0ZWQgdGhlIHJldmlldyBvZiB0aGUgcGF0Y2guCgpUaGUgYWdlbnQgY2FuIHNvbWV0
aW1lcyBwcm9kdWNlIGZhbHNlIHBvc2l0aXZlcyBhbHRob3VnaCBvZnRlbiBpdHMKZmluZGluZ3Mg
YXJlIGdlbnVpbmUuIElmIHlvdSBmaW5kIGlzc3VlcyB3aXRoIHRoZSByZXZpZXcsIHBsZWFzZQpj
b21tZW50IHRoaXMgZW1haWwgb3IgaWdub3JlIHRoZSBzdWdnZXN0aW9ucy4KClJlZ2FyZHMsCkxU
UCBBSSBSZXZpZXdlcgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4
Lml0L2xpc3RpbmZvL2x0cAo=
