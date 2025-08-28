Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D53C8303F
	for <ltp@archiver.kernel.org>; Thu, 28 Aug 2025 10:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1756376677; h=date :
 mime-version : message-id : references : in-reply-to : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=GvX1BtcAISuS72Te3E8XgEDIoJHM+cKR8mouiOQL1b4=;
 b=ERbCwkD1/mSQWeQgrJnH+VDZdNr5u7iam6EU87aFbCe43TMVC/eBBepQJFAaoT+Dfn7c+
 5tyxQyID8JpNLvYfKdHDygwqxtBFS0qInJfrE+ns+2B/f/DOggMlFQk0MKN7bS6a1PXHYVZ
 N2HSlCa4XaD8DT7MQQNKHvXlAOeV0A0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 791E33CB923
	for <ltp@archiver.kernel.org>; Thu, 28 Aug 2025 12:24:37 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C2563CCFDE
 for <ltp@lists.linux.it>; Thu, 28 Aug 2025 12:23:58 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BC89E1000601
 for <ltp@lists.linux.it>; Thu, 28 Aug 2025 12:23:57 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3c7aa4ce85dso569292f8f.3
 for <ltp@lists.linux.it>; Thu, 28 Aug 2025 03:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1756376637; x=1756981437; darn=lists.linux.it;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AYmj/f0D4XFSfy0994FYMO45cRxJKOQcTC+JrJ07v8I=;
 b=fBf8Vn0Ux+otn9Jrn1A9nFFKK3pJW/DTEieJSbIfRtD8++2lsxHSP/h3B3K5p+udSv
 3PnjDk0nFcnevJjeIjoaOhbeR+p1PtM77pqg4T65OR+UxArCe4VC5sMPd0vsr+DC5nSO
 Ms+rJnmPhQsQ3KyRjgJ89i82aBQXiczbxElpP5kYN0twYju0mJS6oPRqITjQocr05z6R
 fTUcbEfu9ca3ijdi0ejN4U3B1q/GwmrwoerksAxVxwWRk0K6jgToEXsfNr+A34yw3lrW
 zpfO2RFPa/I19u6CQ0G0+ZH8jqAt+H1GW9VDO27SHUS6hLNb8mrIJmQGaB7euyzTAxyq
 KtEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756376637; x=1756981437;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AYmj/f0D4XFSfy0994FYMO45cRxJKOQcTC+JrJ07v8I=;
 b=afcvcy75y2n8j3RApQQCvZQx3iHI4OfeEz0l6gUolmQF+XCriSh+KfIjqC+Gxs9QiR
 5UgMHTVQAGItlR2M3A9orBTdD6J2rVX7G+Q255P6sJfwu0dmBRafpvKNAPIRWVIpejTw
 XC0Mt1U72UljespaNpt0XC/ZrS2gc3H7gbAzzq3+Y0scCOXq2/XGzRkAOj4jmNebohAk
 wukdqnzLydiX1DyH8zNA9p0SlNhrpCUEPAUmzsVkUdHaTOrzh3jldJzoZ0vutRYH8Oup
 noHy/yJTAH+4kYPahKUHgMRNGDQ/QFu/4PwnG84GuygtD4AgL/CUD4SYxTpNtvQSYx7F
 wmWw==
X-Gm-Message-State: AOJu0YyeoRtr2EHKyYLX0LTt4hWxRvSKb1fuEtByeP1JcZO43n4/nK1S
 mc5Ju7kh69DN97/EppCJ25SOw0NTzmmB/Qaz2/5XCNQXN3qhYuXUf/89od207i8BhwszO1gchP1
 77zPM5eg=
X-Gm-Gg: ASbGncsdks5CC/RLPasgb1nH3eX1cu4SFe9lBvTwCFhGjlDWlkt86HrFjKlZMR/JYpV
 oTZ2IfpI3p7er7iX5fNdIsXIyLWd8/uyrrWHFhtSL0BTMGmkx0+zuBIXnL15Ejb1oziGI8mNUQP
 Yeb5L9sVdcg5ZNRZkKg1fRTf+pc38wQD5PKECY16YSsRQiL4x3MMV9fhvLCOYrLh5nPK6xpxRDN
 fK61naeC93VALaVI8YvKaYe0jFu4BU5ieq5BicKOJ8bT+M3/Q4gfqXsPXjMAdC8w3UBITECMSbc
 0VW8L3t2n8JmulwGJqrX3bjlR+tpoNj1z3BZnscSSHSQgbzWcQCeLCk+hQYbtIyL4CTuPGPuejH
 uX/DwZKCo3N01i0NU0tgJ
X-Google-Smtp-Source: AGHT+IGhz+Xk6xnrwBG26lim8CKIgVlvwOmBFlEP3/lj+shmwUil4ooUUxno/Z2uf36h6WvMn8FzQg==
X-Received: by 2002:a05:6000:2909:b0:3cd:b952:1dd8 with SMTP id
 ffacd0b85a97d-3cdb9521e69mr2222593f8f.20.1756376636825; 
 Thu, 28 Aug 2025 03:23:56 -0700 (PDT)
Received: from localhost ([177.94.120.255])
 by smtp.gmail.com with UTF8SMTPSA id
 a1e0cc1a2514c-89419cb74b5sm1995794241.21.2025.08.28.03.23.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 03:23:55 -0700 (PDT)
Date: Thu, 28 Aug 2025 07:23:44 -0300
MIME-Version: 1.0
Message-Id: <20250828-conversions-lchown-v4-1-60dd9a0145f3@suse.com>
References: <20250828-conversions-lchown-v4-0-60dd9a0145f3@suse.com>
In-Reply-To: <20250828-conversions-lchown-v4-0-60dd9a0145f3@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2625; i=rbm@suse.com;
 h=from:subject:message-id; bh=J235ZcXgHbW4w+/P+PgF1AXH3z1pyEofIb5Kp0hh394=;
 b=owEBiQJ2/ZANAwAIAckLinxjhlimAcsmYgBosC4yOfZ9TH6qX6+lLzbaxgtgXTYpTNcwvM+0H
 98msaFZCA6JAk8EAAEIADkWIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaLAuMhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQyQuKfGOGWKaaKg//ZKPL3uYc1UNXxK7W+24JWT79hXCsj+8
 x0tRKrW6ju0lOCRZhKx2f4y4LOMmmdTftCknZUZEpN8gmVP9d8N0hzavs+337OlzcvuOBgcrMSV
 PiS86DGpmmVz2uI/XBeyL8ADtuunLklk3YTBEriRY15nMs+ZqJxsHNPh36QhIq8+JQYZGfJPxrb
 1Ocy6jpSpuwdG0ZELBpuZWDBt71n74c7HN8AJuroTmUAUfZ7xA9nM7/0D7N/dpKwhzNaRyguS/r
 ltNV0mD0V52l2B05+uREPSG4L/YVetxnxzYGL6nVmGil0m0pD95a8D+kGg9VRIbek3QLvVl72A0
 1elFVhSJH5/gP/TSiMCs8pTsjrgGAlVareO7yw3TKqWWYRxmUHQsd8vGfn59BN7oqzqAKlyaPa5
 sFWCwb3p0TRHThtwEnu0/gFSwTSB/HTFlCqtLHq6Cc7H1LZw81eerAu9jcpcR1O6INgYEh8TNGz
 4A6P0t+Lg0ovq3Lhnbqfr3N9DaPzvArKOSeVcZ8YWzk7pk37x3Y2cA00L+6UANOcb8DpQ+3TryI
 XhR1qR9ntGyxYs7A3/oogHNAoiaOnqi2JRytKrWkgdTXbjIlKGz/KwBPkPoPu4xXZUaCLD6Yi2F
 mqy49VDeRMhP2mXpxHbY6heUg1NH/9y3dhXBfYIAwRy2WhQ2hTjg=
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/4] lib: Add SAFE_LCHOWN
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
Cc: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KClJldmlld2VkLWJ5OiBB
bmRyZWEgQ2VydmVzYXRvIDxhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPgpSZXZpZXdlZC1ieTog
TGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+ClNpZ25lZC1vZmYtYnk6IFJpY2FyZG8gQi4gTWFy
bGnDqHJlIDxyYm1Ac3VzZS5jb20+Ci0tLQogaW5jbHVkZS9zYWZlX21hY3Jvc19mbi5oICB8ICAz
ICsrKwogaW5jbHVkZS90c3Rfc2FmZV9tYWNyb3MuaCB8ICAzICsrKwogbGliL3NhZmVfbWFjcm9z
LmMgICAgICAgICB8IDE5ICsrKysrKysrKysrKysrKysrKysKIDMgZmlsZXMgY2hhbmdlZCwgMjUg
aW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvc2FmZV9tYWNyb3NfZm4uaCBiL2lu
Y2x1ZGUvc2FmZV9tYWNyb3NfZm4uaAppbmRleCBkMjU2MDkxYjc2YWQxMGIwNmIyOWUzZmQ1ZmFk
ODg1M2ZhYTE0YzA4Li4zNzk5ODczYTI0OGYzNmUwZmYzMWM4NjJkZTI3MDNhMTNmZWUxYmZkIDEw
MDY0NAotLS0gYS9pbmNsdWRlL3NhZmVfbWFjcm9zX2ZuLmgKKysrIGIvaW5jbHVkZS9zYWZlX21h
Y3Jvc19mbi5oCkBAIC0xNTEsNiArMTUxLDkgQEAgaW50IHNhZmVfY2hvd24oY29uc3QgY2hhciAq
ZmlsZSwgY29uc3QgaW50IGxpbmVubywgdm9pZCAoY2xlYW51cF9mbikodm9pZCksCiBpbnQgc2Fm
ZV9mY2hvd24oY29uc3QgY2hhciAqZmlsZSwgY29uc3QgaW50IGxpbmVubywgdm9pZCAoY2xlYW51
cF9mbikodm9pZCksCiAgICAgICAgICAgICAgICAgaW50IGZkLCB1aWRfdCBvd25lciwgZ2lkX3Qg
Z3JvdXApOwogCitpbnQgc2FmZV9sY2hvd24oY29uc3QgY2hhciAqZmlsZSwgY29uc3QgaW50IGxp
bmVubywgdm9pZCAoKmNsZWFudXBfZm4pKHZvaWQpLAorCQljb25zdCBjaGFyICpwYXRoLCB1aWRf
dCBvd25lciwgZ2lkX3QgZ3JvdXApOworCiBwaWRfdCBzYWZlX3dhaXQoY29uc3QgY2hhciAqZmls
ZSwgY29uc3QgaW50IGxpbmVubywgdm9pZCAoY2xlYW51cF9mbikodm9pZCksCiAgICAgICAgICAg
ICAgICAgaW50ICpzdGF0dXMpOwogCmRpZmYgLS1naXQgYS9pbmNsdWRlL3RzdF9zYWZlX21hY3Jv
cy5oIGIvaW5jbHVkZS90c3Rfc2FmZV9tYWNyb3MuaAppbmRleCAxOTUwNGJlYjU3YWQzNzljODM1
YTEzZWQ1ZDM1ZmUwNmU0MmE2ZWQ2Li40MWQxN2IxY2E0NTkwNDU4Y2Y2NTFhNTlhNmUzNzdjMjE1
NzI3MDk0IDEwMDY0NAotLS0gYS9pbmNsdWRlL3RzdF9zYWZlX21hY3Jvcy5oCisrKyBiL2luY2x1
ZGUvdHN0X3NhZmVfbWFjcm9zLmgKQEAgLTIyMCw2ICsyMjAsOSBAQCBpbnQgc2FmZV9nZXRncm91
cHMoY29uc3QgY2hhciAqZmlsZSwgY29uc3QgaW50IGxpbmVubywgaW50IHNpemUsIGdpZF90IGxp
c3RbXSk7CiAjZGVmaW5lIFNBRkVfRkNIT1dOKGZkLCBvd25lciwgZ3JvdXApIFwKIAlzYWZlX2Zj
aG93bihfX0ZJTEVfXywgX19MSU5FX18sIE5VTEwsIChmZCksIChvd25lciksIChncm91cCkpCiAK
KyNkZWZpbmUgU0FGRV9MQ0hPV04ocGF0aCwgb3duZXIsIGdyb3VwKSBcCisJc2FmZV9sY2hvd24o
X19GSUxFX18sIF9fTElORV9fLCBOVUxMLCAocGF0aCksIChvd25lciksIChncm91cCkpCisKICNk
ZWZpbmUgU0FGRV9XQUlUKHN0YXR1cykgXAogCXNhZmVfd2FpdChfX0ZJTEVfXywgX19MSU5FX18s
IE5VTEwsIChzdGF0dXMpKQogCmRpZmYgLS1naXQgYS9saWIvc2FmZV9tYWNyb3MuYyBiL2xpYi9z
YWZlX21hY3Jvcy5jCmluZGV4IDcyNmM5YWU4ZWU1Mzc1OWJhOTgzMzM5NjYyYTZiNDFlOTRlYWNk
N2EuLjYwZDI4YjViZGYyYmQ2ZmRkMzQ4ZmFkNTBiZTQ1Y2E2NmZiMTU5YTEgMTAwNjQ0Ci0tLSBh
L2xpYi9zYWZlX21hY3Jvcy5jCisrKyBiL2xpYi9zYWZlX21hY3Jvcy5jCkBAIC03NzUsNiArNzc1
LDI1IEBAIGludCBzYWZlX2ZjaG93bihjb25zdCBjaGFyICpmaWxlLCBjb25zdCBpbnQgbGluZW5v
LCB2b2lkIChjbGVhbnVwX2ZuKSh2b2lkKSwKIAlyZXR1cm4gcnZhbDsKIH0KIAoraW50IHNhZmVf
bGNob3duKGNvbnN0IGNoYXIgKmZpbGUsIGNvbnN0IGludCBsaW5lbm8sIHZvaWQgKGNsZWFudXBf
Zm4pKHZvaWQpLAorCQkJY29uc3QgY2hhciAqcGF0aCwgdWlkX3Qgb3duZXIsIGdpZF90IGdyb3Vw
KQoreworCWludCBydmFsOworCisJcnZhbCA9IGxjaG93bihwYXRoLCBvd25lciwgZ3JvdXApOwor
CisJaWYgKHJ2YWwgPT0gLTEpIHsKKwkJdHN0X2Jya21fKGZpbGUsIGxpbmVubywgVEJST0sgfCBU
RVJSTk8sIGNsZWFudXBfZm4sCisJCQkibGNob3duKCVzLCVkLCVkKSBmYWlsZWQiLCBwYXRoLCBv
d25lciwgZ3JvdXApOworCX0gZWxzZSBpZiAocnZhbCkgeworCQl0c3RfYnJrbV8oZmlsZSwgbGlu
ZW5vLCBUQlJPSyB8IFRFUlJOTywgY2xlYW51cF9mbiwKKwkJCSJJbnZhbGlkIGxjaG93biglcywl
ZCwlZCkgcmV0dXJuIHZhbHVlICVkIiwgcGF0aCwKKwkJCW93bmVyLCBncm91cCwgcnZhbCk7CisJ
fQorCisJcmV0dXJuIHJ2YWw7Cit9CisKIHBpZF90IHNhZmVfd2FpdChjb25zdCBjaGFyICpmaWxl
LCBjb25zdCBpbnQgbGluZW5vLCB2b2lkIChjbGVhbnVwX2ZuKSh2b2lkKSwKICAgICAgICAgICAg
ICAgICBpbnQgKnN0YXR1cykKIHsKCi0tIAoyLjUxLjAKCgotLSAKTWFpbGluZyBsaXN0IGluZm86
IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
