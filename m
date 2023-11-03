Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD4BC4332F
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 16:54:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 999823CDCCE
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 17:54:24 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7351A3CAA14
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 17:54:13 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C5BDB602A12
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 17:54:12 +0100 (CET)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40837124e1cso3795e9.0
 for <ltp@lists.linux.it>; Fri, 03 Nov 2023 09:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1699030452; x=1699635252; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tBsX0d2oVFIoY35GyV0myPDiG65zJFOIKIOjlp2Imfs=;
 b=FqTsTrjwS0uCYvHlTKgyyt9pPfT9x0ew1cbccN0HKMGGHnEyWxsgNywDUUoTsaMEa1
 TfguuAlJ3YeqeF4U6Xm4OyWthKmAhe1/ZlTlT+gQt8F0E7csScV1RdRzwyClAXo6hSDT
 I+k4KsHiFWS8bvBPDX18MCqa5fR46xMiYzZ5HNyP7ueFd8NRguWFjRJJJpArMb/i64Nf
 FqVyQiMlaeIlkTtglpcOsdyG5whYziWVcSc6k4SaihHQIkEO5nrYr3Z8MgNEy1W0zE23
 J7YiAB5XFoHPx9P+QoSeZ/GLe7BNDLChxRHyixnKKg57df/hpmPCIoOIZwRsG9dN45dD
 wrmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699030452; x=1699635252;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tBsX0d2oVFIoY35GyV0myPDiG65zJFOIKIOjlp2Imfs=;
 b=JDBy4zMJnI4RVXCPBIc/8Co4Zawq6tiX8BFunPYgUEl0E6xhfPWKaEUtpAyO3v8g4D
 NJDbJKDbQPjhWCSKtR7q7VwvfQzz86ie0eVzF2nq5QUDeU8ZKZwcA5LHy1q8bXwjgUFA
 BE2EC1pZ4FgveIUReyc5OIpHIZ0BZpQy9ZoCV2RX1PHLL4/nwccUg6PMqx3NsyOab4Hf
 dY8Debesbg+G3eJ2POsWTvelIGTlotSunplu/LdYYAiSFnk2VNwqNQzCw9E3tBtIkuHM
 vLoE+evCnl78Uqo6gqSVEl4nnQhzA6L2Vp2hXEKybug3YMsu+HIMkcOgD84uDLWhOlbK
 sK1w==
X-Gm-Message-State: AOJu0YybiiGx4CcQFWQ4PxpnGm60ET4t8cYGNXJs47aOJF5tMKMB4SxZ
 /Rlnj9q51AWupsZ0tGhHNQ/RLvg8XyirDBgjF5Xujw==
X-Google-Smtp-Source: AGHT+IF34+INtFLOyrtJUryyiaE5z4mc/DmK80i/QDOr1FREH228QEOTMIu5a6U6qrXdP0FHOn4m/hdJcRqDwEReOMw=
X-Received: by 2002:a7b:cd95:0:b0:408:3e63:f457 with SMTP id
 y21-20020a7bcd95000000b004083e63f457mr3351wmj.2.1699030451945; Fri, 03 Nov
 2023 09:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231103160350.1096410-1-pvorel@suse.cz>
In-Reply-To: <20231103160350.1096410-1-pvorel@suse.cz>
Date: Fri, 3 Nov 2023 09:53:45 -0700
Message-ID: <CAG4es9UBvDeQr6Rm-XU_t=O14OTudTT3yeZQDMexqv98B8cbZA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] lib/tst_module.c: Replace "rmmod" with
 "modprobe -r"
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: ltp@lists.linux.it, Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGksCgoKCk9uIEZyaSwgTm92IDMsIDIwMjMgYXQgOTowM+KAr0FNIFBldHIgVm9yZWwgPHB2b3Jl
bEBzdXNlLmN6PiB3cm90ZToKPgo+ICJtb2Rwcm9iZSAtciIgd2lsbCByZW1vdmUgYWxzbyB0aGUg
ZGVwZW5kZW5jaWVzIGxvYWRlZCBmb3Iga2VybmVsCj4gbW9kdWxlcy4KPgo+IFN1Z2dlc3RlZC1i
eTogQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1c2UuY3o+Cj4gU2lnbmVkLW9mZi1ieTogUGV0ciBW
b3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4gLS0tCj4gIGxpYi90c3RfbW9kdWxlLmMgfCAyICstCj4g
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAt
LWdpdCBhL2xpYi90c3RfbW9kdWxlLmMgYi9saWIvdHN0X21vZHVsZS5jCj4gaW5kZXggOWJkNDQz
NjIzLi5lNTJiYjZlMDAgMTAwNjQ0Cj4gLS0tIGEvbGliL3RzdF9tb2R1bGUuYwo+ICsrKyBiL2xp
Yi90c3RfbW9kdWxlLmMKPiBAQCAtMTA1LDcgKzEwNSw3IEBAIHZvaWQgdHN0X21vZHVsZV91bmxv
YWRfKHZvaWQgKGNsZWFudXBfZm4pKHZvaWQpLCBjb25zdCBjaGFyICptb2RfbmFtZSkKPiAgewo+
ICAgICAgICAgaW50IGksIHJjOwo+Cj4gLSAgICAgICBjb25zdCBjaGFyICpjb25zdCBhcmd2W10g
PSB7ICJybW1vZCIsIG1vZF9uYW1lLCBOVUxMIH07Cj4gKyAgICAgICBjb25zdCBjaGFyICpjb25z
dCBhcmd2W10gPSB7ICJtb2Rwcm9iZSIsICItciIsIG1vZF9uYW1lLCBOVUxMIH07Cj4KPiAgICAg
ICAgIHJjID0gMTsKPiAgICAgICAgIGZvciAoaSA9IDA7IGkgPCA1MDsgaSsrKSB7Cj4gLS0KPiAy
LjQyLjAKPgoKVGhpcyBpcyBmaW5lIHdpdGggYWxsIHRoZSBzdXBwb3J0ZWQgdmVyc2lvbnMgb2Yg
QW5kcm9pZCBHS0kuClJldmlld2VkLWJ5OiBFZHdhcmQgTGlhdyA8ZWRsaWF3QGdvb2dsZS5jb20+
CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8v
bHRwCg==
