Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78590F8A179
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 13:45:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 287533E2DE7
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 15:45:28 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D00D3E2928
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 15:45:08 +0200 (CEST)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C1BDE6008AA
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 15:45:07 +0200 (CEST)
Received: by mail-qt1-x843.google.com with SMTP id
 d75a77b69052e-50d7c12e48eso6240311cf.1
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 06:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776347106; x=1776951906; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pWNYZLqsS5ALkE960tFGHXGTM/F4BVT64ItzDLcG3Rs=;
 b=BJvS3nySeA8Q8qxg/G5YoOXnrJTITBEypYCiTuWXtT98cvEhQEOIpDEqf/MpbyOpiy
 GzbvEXoK18P0u/TA4B7/lCz8ybbna5L3C2w/aitiU5Y+k+PNbb4wE78TAjBTRbCX7ADi
 hPlB7G8F8tBUwdmkXAqCY/ldWqEKJgbBqNcu6CNJtYwJyQFouXT9r0KwlLFjY683Ws2F
 kc6fGr8S9oKOh2C/KwRF++9aZQKX00kocLF211mHAEsoBLNrR/v9lbBveOKNqJzUn7LX
 aww65j/HA1Te8+UIniq2O3KQc9OCgKzSdYA5ZNc2bKJnPN5CoHbxY/tSOqjAYb4VvgTI
 VidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776347106; x=1776951906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pWNYZLqsS5ALkE960tFGHXGTM/F4BVT64ItzDLcG3Rs=;
 b=RjYYnAiBUMOqQhDtvDAr0LIVKlarEaOhpC/WD9AJCrFqHZxfmZ7kqmPT4ccU3rksVF
 ZQgHsiEj90V1f/A2SSNgd7bp+jMRcN9KRCu6rpb/jIqLnEv8wbojZa4g8dMd4g5k+3zS
 tukIygCrBIK/32wxFHhoTI1fpiV6bymFE28slNo1vgsNo001u4EOBexWxEnf7K7WObkj
 dg647DibydpdIi7pPp7hZlO2X/QVBUknzGYRji53R4lvvufbCWopM7k9cjhF/CRp2LOG
 FHXMFP3wkRG5eQ2exZIlZDaPoijgT7w+JiLdDSXxG3n8BbHUetaSAi8D3zGkU/34FpSg
 C1pA==
X-Gm-Message-State: AOJu0YzGCbcEVe78WBMqY3hpZ3PVxMclrLL2tMy+biFAs7R0wbl4E+jv
 HJ4eGcSjU/ZvK0F/cJ272FnAqkOFYiyeNTUFdjqCWisn0cUsSwRS68sBCD5+NjMHMDA=
X-Gm-Gg: AeBDiet2p23rq67JosY4+/je+LGD3ouWoAeBpoqu/JGWDSDqaPCThidc53+aZwIu/Ie
 3UqSrBk9kyFsk7T0paGx0Ksws+KO+EaUmf+1XQnv7QU3lO7hoG1C3mFIopuh3k5gvQA5hBTxGTI
 WmhCEDMqCe8fLFkotfdsFZjbEZHmtFrnVdglN5HmcTldVIhmJQPcOO+SRbLinkENGlEndy3EVM8
 8s1+bMpYnH0pijfsjDxaYIE0qXp9GNjWzd6+ADOwo8+uFwyzk+YEA8+Rl46CPf312upAnpD8ATU
 aBqdFc4TSr2i2muXH2FD2LQ3T/HCWTsYUDijAk0gua9p7NxfXcWhcUtqtJfhUoA3VLUQD4nFhFA
 4pBd1U/6FmI4qKWmx87OOvB9lso/7zpIdZQB8KLzF0CXL82FhCkPWfSgkc2bCeIqfLqDjScOdc2
 l8PrPK3U1HJJaXxNNaw+RDZEFRQiBLu2Sgy4dUbRQdRYgZHhE75HDexmyFTxNfv2FbO4x3yjUsl
 X1VYEr0hld6WwQVIcui1/stzCbX6R+Wr1CqNw95
X-Received: by 2002:a05:622a:5a17:b0:50d:7632:ddb2 with SMTP id
 d75a77b69052e-50e24ae4d5emr51479851cf.12.1776347105561; 
 Thu, 16 Apr 2026 06:45:05 -0700 (PDT)
Received: from
 runnervm35a4x.acrcebrcupsetj21tpkunvq0he.ex.internal.cloudapp.net
 ([20.102.223.155]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e21f8eb5csm28347621cf.8.2026.04.16.06.45.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 06:45:05 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 16 Apr 2026 13:45:04 +0000
Message-ID: <20260416134504.3846-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416-fix_nanosleep_include-v2-1-b3147763acb8@suse.com>
References: <20260416-fix_nanosleep_include-v2-1-b3147763acb8@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] nanosleep: use POSIX runtime detection for CLOCK_MONOTONIC
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
Cc: ltp@lists.linux.it, LTP AI Reviewer <ltp-ai@noreply.github.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQW5kcmVhLAoKT24gMjAyNi0wNC0xNiwgQW5kcmVhIENlcnZlc2F0byB3cm90ZToKPiBuYW5v
c2xlZXA6IHVzZSBQT1NJWCBydW50aW1lIGRldGVjdGlvbiBmb3IgQ0xPQ0tfTU9OT1RPTklDCgo+
ICtzdGF0aWMgaW5saW5lIGNsb2NraWRfdCBnZXRfc3VwcG9ydGVkX2Nsb2NrKHZvaWQpCj4gK3sK
PiArI2lmZGVmIF9QT1NJWF9NT05PVE9OSUNfQ0xPQ0sKPiArCWlmIChfUE9TSVhfTU9OT1RPTklD
X0NMT0NLID4gMCkKPiArCQlyZXR1cm4gQ0xPQ0tfTU9OT1RPTklDOwo+ICsKPiArCWlmICghX1BP
U0lYX01PTk9UT05JQ19DTE9DSyAmJiBzeXNjb25mKF9TQ19NT05PVE9OSUNfQ0xPQ0spID4gMCkK
PiArCQlyZXR1cm4gQ0xPQ0tfTU9OT1RPTklDOwo+ICsjZW5kaWYKPiArCj4gKwlwcmludGYoIkNM
T0NLX01PTk9UT05JQyB1bmF2YWlsYWJsZSwgdGVzdCBtYXkgZmFpbCBkdWUgdG8gIgo+ICsJICAg
ICAgICJleHRlcm5hbCBjbG9jayBhZGp1c3RtZW50c1xuIik7Cj4gKwlyZXR1cm4gQ0xPQ0tfUkVB
TFRJTUU7Cj4gK30KCkNvcnJlY3QgUE9TSVggcnVudGltZSBkZXRlY3Rpb24g4oCUIGhhbmRsZXMg
YWxsIHRocmVlIF9QT1NJWF9NT05PVE9OSUNfQ0xPQ0sKc3RhdGVzICg+MCwgPT0wLCB1bmRlZmlu
ZWQpIHByb3Blcmx5LCBhbmQgdGhlIHVuaXN0ZC5oIGluY2x1ZGUgaW4gaGVscGVycy5oCmNsb3Nl
cyB0aGUgc2lsZW50IGZhbGxiYWNrIHRoYXQgYWZmZWN0ZWQgMS0xLmMsIDItMS5jLCBhbmQgMTAw
MDAtMS5jLgoKUmV2aWV3ZWQtYnk6IExUUCBBSSBSZXZpZXdlciA8bHRwLWFpQG5vcmVwbHkuZ2l0
aHViLmNvbT4KCi0tLQpOb3RlOgoKT3VyIGFnZW50IGNvbXBsZXRlZCB0aGUgcmV2aWV3IG9mIHRo
ZSBwYXRjaC4KClRoZSBhZ2VudCBjYW4gc29tZXRpbWVzIHByb2R1Y2UgZmFsc2UgcG9zaXRpdmVz
IGFsdGhvdWdoIG9mdGVuIGl0cwpmaW5kaW5ncyBhcmUgZ2VudWluZS4gSWYgeW91IGZpbmQgaXNz
dWVzIHdpdGggdGhlIHJldmlldywgcGxlYXNlCmNvbW1lbnQgdGhpcyBlbWFpbCBvciBpZ25vcmUg
dGhlIHN1Z2dlc3Rpb25zLgoKUmVnYXJkcywKTFRQIEFJIFJldmlld2VyCgotLSAKTWFpbGluZyBs
aXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
