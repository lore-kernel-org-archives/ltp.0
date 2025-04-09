Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CADE3C36002
	for <ltp@archiver.kernel.org>; Wed,  9 Apr 2025 16:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744216676; h=date :
 mime-version : message-id : references : in-reply-to : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=rYlaQxGc+sWdkG3479/fIKnzdNF6/8mqNKXg7xeCazQ=;
 b=gW2eSI4OBunW1SitwWpw+QKottHI0IPSyz+5HBJm0br+fS4JFXxGoouE9i3OMLIDFtj0m
 /yYgMaAciBnPot8yYzC6M4AElGkd4oY0bQSX5ExmvpAujjsLkg3kC/0v/za2A8lxVOZ5Ekv
 Jm/Q16yWOcdr6bDgWVDcZ73SY0qlUdw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 96FFC3CB41D
	for <ltp@archiver.kernel.org>; Wed,  9 Apr 2025 18:37:56 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 227783CB417
 for <ltp@lists.linux.it>; Wed,  9 Apr 2025 18:37:13 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AA6B414010C7
 for <ltp@lists.linux.it>; Wed,  9 Apr 2025 18:37:12 +0200 (CEST)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43d0782d787so48063775e9.0
 for <ltp@lists.linux.it>; Wed, 09 Apr 2025 09:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1744216632; x=1744821432; darn=lists.linux.it;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fo3FYIDUIoqM69l4imG2Kx1aLahWPrTnGIJw775TLTk=;
 b=RIrQjR27DdNVM7kltH3nLFZkq45nFZhgfElmEoOc9+UdbYLm8+a4HdxEKuloTHfKO7
 SsTAuHKAfl3v2yDADWGfccE+YAdEo5wWGj+SXNhU5bBkwPL0wZtlinJIAgZaXNolXHAU
 2CGZ5DAAi6oSFtKQJW5x/pNiwalTbDRCj2CToYIqNMEBudLI/djEO8GQrr8f7s8oiC05
 J0tTGdqd977GDR2vtbXl8bErGTiZ1E9fmQIAGRuBKKSYh+SChnuzsbPNXFPKw7bA+UOa
 Zr3S9VQ5Ro6OatNSEHX3h3xTW6Vf2EiHfXA3o6S3Ejl12ErjVH2pJ6et9/eRhab+TJBy
 KsfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744216632; x=1744821432;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fo3FYIDUIoqM69l4imG2Kx1aLahWPrTnGIJw775TLTk=;
 b=Ijur6RdtYzWM8WaOEjZLwAO6bp6u2+fhqj8CzuD2xLGvceG6JXWk4Oh5bkpSS4P+CU
 jJcBqj9J5+Qk8jcYAD6aUsGyVU+LW//M0cA8hHbVmwRvWQi6TCsASnGy6sUbcI0YLcy/
 CHs0GKfQ++wry9SoPWlHLPBrWnHEjTm45dGn5flZdZEBfV2AwqkHazV3C83qvJapjIp1
 dBOKt9eFY107P0iRCXaooSjIbl5eRYUPISU5S92bG7c5O20ec0qLUZK5j5SSH+tsFDyD
 unALA0rRUNgZfbPM9+sKWRhQQzHPCH/fAcdkKXyCkHHbaIr4ZvKkntfRrJdXmFoBF1iO
 9Dvw==
X-Gm-Message-State: AOJu0YwVWL2tvq9TOAGfv5RTX0LrvEYGO2HC/N48MNPspWjaYUcz5y4M
 1utfdJJ+bBp9oS7V+cZo1JoqL6kEjgZV6BDq3RhURiB7BpBQ1Auaa9HR8m8Igw4GVeOf5mT8uJ3
 r
X-Gm-Gg: ASbGncvsEMYj7+miv6+4MPfk6YrwgwyUgcIrzXGg4aZuqsFykcl7AtIob+eYzSmLE1n
 dSnnirPFIwQezDgyqW0zR8qJlwAfd9Pwf4U5LGpIj6onitwjlAwubjNIfutPgAjmUjsHNn9+W8z
 GIs8Huugs0Ts/As2TCH6YPqH2WlRSC++cZhMjaTcngMvtuTINaDLSK1vEyuzN9MdQ3zscYP/LsQ
 oX3NkwD/c66mbCFYgG51eF5noTsEu/ADQ1OjW/vEtADgnEwGT9h9A6r/73pv8cNvobV4BXUVzkn
 rczJSXXsE4W/toHe4SQXtCTrerDOtA==
X-Google-Smtp-Source: AGHT+IH+6H/DHA638IHFLea1hmZUhkDwpGnUcsNI2s4qTAFj9/VaF9J9QHO7Qj4SbbY1KJSVivdGwA==
X-Received: by 2002:a5d:5f46:0:b0:39c:13fd:e50e with SMTP id
 ffacd0b85a97d-39d87aa55ccmr3222258f8f.10.1744216632137; 
 Wed, 09 Apr 2025 09:37:12 -0700 (PDT)
Received: from localhost ([179.228.213.210])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-22ac7ccb32esm14120195ad.232.2025.04.09.09.37.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 09:37:11 -0700 (PDT)
Date: Wed, 09 Apr 2025 13:36:55 -0300
MIME-Version: 1.0
Message-Id: <20250409-fix_make_clean-v3-1-a33a84b2be05@suse.com>
References: <20250409-fix_make_clean-v3-0-a33a84b2be05@suse.com>
In-Reply-To: <20250409-fix_make_clean-v3-0-a33a84b2be05@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1854; i=rbm@suse.com;
 h=from:subject:message-id; bh=7gIkitv5zZy5NCsCtbo2dV75SQdtvRZdLx6OgWC08JA=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBn9qIxqejt95m/ChIDGZQE/uIJ5+evBZtYhdPX4
 6/FfRHcXX6JAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ/aiMQAKCRDJC4p8Y4ZY
 prQ7EACO7RqD4KX3lvU9mrKXJHsXGnKfkCL8U+SxjuFaB6Y+B0Hk30+Y0P1vSSN4bb4+AUJqcBz
 N/g8fFOvix7eFAz48tpUFWa6butaUS5riB1UqPHwLpBrYgglkgic5Izt5K6LCtrBRLMbAPrQcrO
 ju0W7tADhGaU/WHwCVQUtQ4X9mMSEl56azrflbO9QskcFO2BLKVsPeMytcZASNkYLXzLteuDwBO
 XSuWZ8Y8U1GvWD3u5SqHuMuPPG4Wos7kN3cYGVjYl1urdCE7+PaDOrXL7apNCTY1MSMomtSvhqr
 aS2XNf3X36LgCM3l6mpypb1Iwb9fFN2K0fldtMzP/CXKzlP5IlQp5ibSoizyP02+xcKRzyR7sie
 ObXLqsVam+hb8h0PzLFshCNYii8nCe7suV1NTKSiIFKvTmIzp6Ad1DBSn3d443Yu2t76fU2HVjA
 rhok8onfFXmps7JRHEu43cK6Sp3jqDMsi4mSKCkaDDJExZc7EdZhcv62hpZibqI/EFSW8Bt1hu5
 lWiIdRBiAYTJh9qeCHicq3PtUV0FkATCxzMB8Icwu5Is58EoCpRvlUKwVqllFpU7U8OVdWAohLJ
 xqDwFJg5fgEPrzsBA6X6WCb98IlcEQDKx6o0AS9i8jaKiyRUfw9bcVXNzOVa+mY3ynrxkF6s7sI
 RT/a4DT6vvQrDeg==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] openposix: Makefile: Add the standard
 "maintainer-clean" target
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

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KClRoZSBpbmNsdWRlL21r
L2F1dG9tYWtlLm1rIGZpbGUgZGVmaW5lIHRoZSBzdGFuZGFyZCAibWFpbnRhaW5lci1jbGVhbiIg
YW5kCiJhYy1tYWludGFpbmVyLWNsZWFuIiB0YXJnZXRzIGFuZCB0aGVyZWluIGl0IGNhbGxzIHRo
ZSBzYW1lIHRhcmdldHMgdW5kZXIKZWFjaCBBVVRPQ09ORkVEX1NVQkRJUlMsIGJ1dCBpbiB0aGUg
Y2FzZSBvZiB0aGUgb3BlbnBvc2l4IHRlc3Qgc3VpdGUsIHRoZXkKZG9uJ3QgZXhpc3QuIEFkZCB0
aGVtIGFuZCBhbHNvIHJlbW92ZSBzb21lIGRhbmdsaW5nIGZpbGVzIGluIGFjLWNsZWFuLgoKVGhp
cyBmaXhlcyB0aGUgZm9sbG93aW5nIGVycm9yIHdoZW4gY2FsbGluZyBgbWFrZSBtYWludGFpbmVy
LWNsZWFuYCBmcm9tCnRoZSBwcm9qZWN0J3MgdG9wIGxldmVsIGRpcmVjdG9yeToKCm1ha2VbMV06
IEVudGVyaW5nIGRpcmVjdG9yeSAnLi90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUnCm1h
a2VbMV06ICoqKiBObyBydWxlIHRvIG1ha2UgdGFyZ2V0ICdhYy1tYWludGFpbmVyLWNsZWFuJy4g
IFN0b3AuCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5ICcuL3Rlc3RjYXNlcy9vcGVuX3Bvc2l4
X3Rlc3RzdWl0ZScKbWFrZTogKioqIFsuL2luY2x1ZGUvbWsvYXV0b21ha2UubWs6Njg6IGFjLW1h
aW50YWluZXItY2xlYW5dIEVycm9yIDIKClJldmlld2VkLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxA
c3VzZS5jej4KU2lnbmVkLW9mZi1ieTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNv
bT4KLS0tCiB0ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvTWFrZWZpbGUgfCAxMCArKysr
KysrKystCiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpk
aWZmIC0tZ2l0IGEvdGVzdGNhc2VzL29wZW5fcG9zaXhfdGVzdHN1aXRlL01ha2VmaWxlIGIvdGVz
dGNhc2VzL29wZW5fcG9zaXhfdGVzdHN1aXRlL01ha2VmaWxlCmluZGV4IDhiNGM4YzBhMjRiODMz
ZmEwZmIyMWNlM2UyNTM2MjlmMzU4ZjE4MDAuLmMwY2NkNDk5YjhiOWM5M2U0NTEzM2Y1YjNmMTg5
ZWRhN2QwOWJlYjMgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9vcGVuX3Bvc2l4X3Rlc3RzdWl0ZS9N
YWtlZmlsZQorKysgYi90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvTWFrZWZpbGUKQEAg
LTMxLDExICszMSwxNiBAQCBBVVRPR0VORVJBVEVEX0ZJTEVTID0gaW5jbHVkZS9tay9jb25maWcu
bWsKIAogLlBIT05ZOiBhYy1jbGVhbgogYWMtY2xlYW46IGNsZWFuCisJJChSTSkgLXJmIGF1dG9t
NHRlLmNhY2hlCisJJChSTSkgLWYgY29uZmlnLmxvZyBjb25maWcuc3RhdHVzCisKKy5QSE9ORTog
YWMtbWFpbnRhaW5lci1jbGVhbgorYWMtbWFpbnRhaW5lci1jbGVhbjoKKwkkKFJNKSAtZiBjb25m
aWd1cmUKIAogLlBIT05ZOiBjbGVhbgogY2xlYW46CiAJJChSTSkgLWYgJChMT0dGSUxFKSoKLQkk
KFJNKSAtZiBjb25maWcubG9nIGNvbmZpZy5zdGF0dXMKIAlAZm9yIGRpciBpbiAkKFNVQkRJUlMp
IHRvb2xzOyBkbyBcCiAJCSQoTUFLRSkgLUMgJCRkaXIgY2xlYW4gPi9kZXYvbnVsbDsgXAogCWRv
bmUKQEAgLTUxLDYgKzU2LDkgQEAgZGlzdGNsZWFuLW1ha2VmaWxlczoKIAkJJChNQUtFKSAtQyAk
JGRpciAkQDsgXAogCWRvbmUKIAorLlBIT05ZOiBtYWludGFpbmVyLWNsZWFuCittYWludGFpbmVy
LWNsZWFuOiBkaXN0Y2xlYW4tbWFrZWZpbGVzIGFjLW1haW50YWluZXItY2xlYW4KKwogJChBVVRP
R0VORVJBVEVEX0ZJTEVTKTogJCh0b3BfYnVpbGRkaXIpL2NvbmZpZy5zdGF0dXMKIAkkKFNIRUxM
KSAkXgogCgotLSAKMi40OS4wCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3Rz
LmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
