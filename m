Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B92DC83F09
	for <ltp@archiver.kernel.org>; Tue,  8 Jul 2025 20:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752005591; h=date :
 mime-version : message-id : references : in-reply-to : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=gHxVeLN7dWYNpdkwpmtZWl18eMZL0R83aGbW75ut6xg=;
 b=EkUvdSoCzGDXJrwRpxRMhqLS2AlkU0zcAbOC2ssW6dXJszgkppjz+6Wh2PeU34Khb62ju
 a6DDxW65R4aCz+8NkDkabZWghXLfb5k9PWZGH9244xNwUXgJbiOte24E23FB7t48OY+Xbcf
 NhXc2H23wnomvwIP0mbGA8tw2PVLvtU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C1A153CA61E
	for <ltp@archiver.kernel.org>; Tue,  8 Jul 2025 22:13:11 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 786113CA659
 for <ltp@lists.linux.it>; Tue,  8 Jul 2025 22:12:11 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0B5F52009D6
 for <ltp@lists.linux.it>; Tue,  8 Jul 2025 22:12:11 +0200 (CEST)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a4e742dc97so167201f8f.0
 for <ltp@lists.linux.it>; Tue, 08 Jul 2025 13:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752005530; x=1752610330; darn=lists.linux.it;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9pPlSlO/MHXGJrqUUfcRw+rc1DBeM5kTOjLDYUkPzLc=;
 b=Ob6XRLPSs1FHPsMFj7Cn0ks9YVL3lN9sLXcK4fHXRxxz7r/7ksv1yWsEJUBDgkDY+Y
 k2ABptj0OXb9HMvZowlAay9RSywj/S7i2FLT5YPGgZW+GrBNPev8nGtmqK3/q+RtK6dN
 2JxldHvRQ4XAUvyWlJFFGssOwx8KVLDr955l/tDAVBB6QpwqmZGXH0CgR1zDBTKiUpBa
 yOuZZXgqCLs/W2P3g1dEo1HRC20SUFG6o/qwmTnxdLIAZ2lM2QEDh4ExC3ylVNkiidnF
 TZfeUsha87WdMMwQhlCGg4qtN24RMi5xYDNv1Ik3eRUUaH2Ev0j4YuT5x9afCtgGhwKJ
 gUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752005530; x=1752610330;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9pPlSlO/MHXGJrqUUfcRw+rc1DBeM5kTOjLDYUkPzLc=;
 b=FtlwZ45K9tSsDYc2uTLWFfFpPiNfcEfmaSrt6dKd2pGtWYqwgq0kdmQ0wPcFDRtDs6
 3PBDdk0UuFR/zSVxg/zN2dT0gP+8m6NpxKaoROlZZaAFYKzZ0H6/YJ1fueoLdGUahVau
 D46yAnf1BW1SaaAjktqqHQGmVJmmJciUXx3ak8nHtfik/fq5w3b3adKXUQNM6rGSue4u
 pwzTGOCABmi7ZcBI/P/+FSeKRUg13RwHsAQ8CGwVUC4gxvxiCmVkYlb8iMsupL635sez
 KuFeUacB8VMeAt2HsWUiuY8/jiifk4qSgSb2p2spNzJa7q6gS317iGKoB/o9LLlJ2maX
 NkUw==
X-Gm-Message-State: AOJu0YxKK6y84KuwC6Mvgxkx9vI5Xvi41xKRNEApZ9Pz14FTrmeQ74zQ
 DTL53nYtK577Iib4CU3RXaxxYDayEa3/pg3Q5H6udEDzRzoJCprtYA2qtJo/W8VZL4TO3Bxo/yY
 OcZzs
X-Gm-Gg: ASbGncufLSGntN+tDAxxEvmFh0U9EzaTqTitgBi9ea1qIuAq7geBoffDKJohwVEAZO0
 UFEMUH7fEmEUHMhhXGpoA5lPqCd/rvbMa+MsHDLiUSweit8uoInVCDjkU2FJEeK7jlfgfuGYR8s
 stTJNcsuOiMAJrYO77NqdE+kCAgXReF5Q+IgnW+MabkGUpSDC9zf5gXIqvbf2HQHbKUGvE50s9h
 xYrmupwttOGaH8JWOleCvSY7I4Q2gg0qabgRuSAjaMnuOzwkbyNzVTPeFZpICSXan61IESGk0FC
 RXgUT+KaoNlNmvUtkflzlvXciVwsfejaa7sU/XSeIGZM2jGP5Q==
X-Google-Smtp-Source: AGHT+IES/H+1W1XPqiTws2WpHITT6TwDDXW51rHjBEKRwLVlbAhkkWDqcq5oUDcCLOADyu9aG1kSMQ==
X-Received: by 2002:a05:6000:1acf:b0:3a5:8977:e0fd with SMTP id
 ffacd0b85a97d-3b5ddf56110mr3831836f8f.0.1752005530193; 
 Tue, 08 Jul 2025 13:12:10 -0700 (PDT)
Received: from localhost ([177.45.162.214])
 by smtp.gmail.com with UTF8SMTPSA id
 af79cd13be357-7d5dbe8f844sm829191085a.82.2025.07.08.13.12.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 13:12:08 -0700 (PDT)
Date: Tue, 08 Jul 2025 17:11:56 -0300
MIME-Version: 1.0
Message-Id: <20250708-conversions-mremap-v1-2-aa043b0182fc@suse.com>
References: <20250708-conversions-mremap-v1-0-aa043b0182fc@suse.com>
In-Reply-To: <20250708-conversions-mremap-v1-0-aa043b0182fc@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2521; i=rbm@suse.com;
 h=from:subject:message-id; bh=d7vUQZ0i2k1P16QGIlRuqX/wstGDEie7jab2sGk0Ync=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBobXuLwL97iRofspX6HWp9yBTk9JxysEw+dDs2f
 lPInW23/UiJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaG17iwAKCRDJC4p8Y4ZY
 pgIYD/4+Z4LIsCI627N8fiVo2kU1XgbAxssJ2+zY3Au/vaIvEyJxtsXlNPSlIhUxIAPkNhoG/Ep
 bwH7EFWNH83w6kWQ5BcMUaGWLbwUKqRBOpVXCZXrZ7VSAmG6z+pW7RS9fUW5R2qT/Bvwiz6OkXc
 UlQLUK0pdIFQ8cuWjBO2JH+5wLRdmyTN6N34cc61ErBn0kUJKaR5LdQkzR1m6bvkMcjzfvdmZQ9
 PyzKOXM3B+7CZ3BS48Uxiig94FmAaMgvhVKC4OD9eExH2m+A3J5ZgF+/W4jT9Y8I9lMIwy6stGU
 PeoVvmwJDJjWaVJvFXUFS4NbNoYEBrS6nzy/LrhSmC9ibzlT+NuQ4GAOxWImMqqvu5tnDbdQ+Mj
 z2BzX5oH5hC/W3WKlhWaK9zWFdQ2HI0lGD9iuB947nrOADca00DGBP7uFscb2AsdqVOp3fWVbEL
 FGmT6MkoEIIn2qoRlgFHotn4LedMtZM5HADzPEBMfR7SyqTk2E/Ag8yyHJ1abawZmnlzu44qfYo
 LYiCtVZvBmxYen8n9+ye+xwUoxGVZK5FNX3Fko+whLW0+TmKyV32OukCStN0V+FBgJfSlacN3Ax
 QbiTm2G3MOtr/qxYiNzYZc4Yt6gvWshGULigiKy9Wljjz455+lFRvgfBIWU3qtBmqicIu4HVqN0
 uW2U996xmfMkaBg==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/7] lib: safe_macros: Add SAFE_MREMAP
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

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KClNpZ25lZC1vZmYtYnk6
IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Ci0tLQogaW5jbHVkZS9zYWZlX21h
Y3Jvc19mbi5oICB8ICAyICsrCiBpbmNsdWRlL3RzdF9zYWZlX21hY3Jvcy5oIHwgIDQgKysrKwog
bGliL3NhZmVfbWFjcm9zLmMgICAgICAgICB8IDE2ICsrKysrKysrKysrKysrKysKIDMgZmlsZXMg
Y2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvc2FmZV9tYWNy
b3NfZm4uaCBiL2luY2x1ZGUvc2FmZV9tYWNyb3NfZm4uaAppbmRleCBkMjU2MDkxYjc2YWQxMGIw
NmIyOWUzZmQ1ZmFkODg1M2ZhYTE0YzA4Li40ODkyNzA2ZmEzMTFhZTIzMTMxY2QxYmEzZDM2ZThl
YjMyNTdkOWM0IDEwMDY0NAotLS0gYS9pbmNsdWRlL3NhZmVfbWFjcm9zX2ZuLmgKKysrIGIvaW5j
bHVkZS9zYWZlX21hY3Jvc19mbi5oCkBAIC02OSw2ICs2OSw4IEBAIGludCBzYWZlX21rZGlyKGNv
bnN0IGNoYXIgKmZpbGUsIGNvbnN0IGludCBsaW5lbm8sCiBpbnQgc2FmZV9ybWRpcihjb25zdCBj
aGFyICpmaWxlLCBjb25zdCBpbnQgbGluZW5vLAogICAgICAgICAgICAgICAgdm9pZCAoKmNsZWFu
dXBfZm4pKHZvaWQpLCBjb25zdCBjaGFyICpwYXRobmFtZSk7CiAKK3ZvaWQqIHNhZmVfbXJlbWFw
KGNvbnN0IGNoYXIgKmZpbGUsIGNvbnN0IGludCBsaW5lbm8sIHZvaWQgKCpjbGVhbnVwX2ZuKSh2
b2lkKSwKKwkJdm9pZCAqb2xkX2FkZHJlc3MsIHNpemVfdCBvbGRfc2l6ZSwgc2l6ZV90IG5ld19z
aXplLCBpbnQgZmxhZ3MpOwogCiBpbnQgc2FmZV9tdW5tYXAoY29uc3QgY2hhciAqZmlsZSwgY29u
c3QgaW50IGxpbmVubywKICAgICAgICAgICAgICAgICB2b2lkICgqY2xlYW51cF9mbikodm9pZCks
IHZvaWQgKmFkZHIsIHNpemVfdCBsZW5ndGgpOwpkaWZmIC0tZ2l0IGEvaW5jbHVkZS90c3Rfc2Fm
ZV9tYWNyb3MuaCBiL2luY2x1ZGUvdHN0X3NhZmVfbWFjcm9zLmgKaW5kZXggMTk1MDRiZWI1N2Fk
Mzc5YzgzNWExM2VkNWQzNWZlMDZlNDJhNmVkNi4uOWNhNzAzMTlmMDg2ZGVhNDM3NDY3Yzc3NWRk
OWNiNDhiOTU2NTgzZSAxMDA2NDQKLS0tIGEvaW5jbHVkZS90c3Rfc2FmZV9tYWNyb3MuaAorKysg
Yi9pbmNsdWRlL3RzdF9zYWZlX21hY3Jvcy5oCkBAIC05Myw2ICs5MywxMCBAQCB2b2lkICpzYWZl
X3JlYWxsb2MoY29uc3QgY2hhciAqZmlsZSwgY29uc3QgaW50IGxpbmVubywgdm9pZCAqcHRyLCBz
aXplX3Qgc2l6ZSk7CiAjZGVmaW5lIFNBRkVfUk1ESVIocGF0aG5hbWUpIFwKIAlzYWZlX3JtZGly
KF9fRklMRV9fLCBfX0xJTkVfXywgTlVMTCwgKHBhdGhuYW1lKSkKIAorI2RlZmluZSBTQUZFX01S
RU1BUChvbGRfYWRkcmVzcywgb2xkX3NpemUsIG5ld19zaXplLCBmbGFncykgICAgICAgICAgICAg
IFwKKwlzYWZlX21yZW1hcChfX0ZJTEVfXywgX19MSU5FX18sIE5VTEwsIChvbGRfYWRkcmVzcyks
IChvbGRfc2l6ZSksIFwKKwkJICAgIChuZXdfc2l6ZSksIChmbGFncykpCisKICNkZWZpbmUgU0FG
RV9NVU5NQVAoYWRkciwgbGVuZ3RoKSBcCiAJc2FmZV9tdW5tYXAoX19GSUxFX18sIF9fTElORV9f
LCBOVUxMLCAoYWRkciksIChsZW5ndGgpKQogCmRpZmYgLS1naXQgYS9saWIvc2FmZV9tYWNyb3Mu
YyBiL2xpYi9zYWZlX21hY3Jvcy5jCmluZGV4IDU3YmMwYmM3NDk3MTJmMWI4OTA1OTQxMjNiNmI5
ZjNjYWJjZTgyMWEuLjRiYjRjNzAwZjFkMjVlOTUyMGUzZDVhMmY5OTY5YmZlY2FmZDI1Y2MgMTAw
NjQ0Ci0tLSBhL2xpYi9zYWZlX21hY3Jvcy5jCisrKyBiL2xpYi9zYWZlX21hY3Jvcy5jCkBAIC0y
MTUsNiArMjE1LDIyIEBAIGludCBzYWZlX3JtZGlyKGNvbnN0IGNoYXIgKmZpbGUsIGNvbnN0IGlu
dCBsaW5lbm8sIHZvaWQgKCpjbGVhbnVwX2ZuKSAodm9pZCksCiAJcmV0dXJuIChydmFsKTsKIH0K
IAordm9pZCAqc2FmZV9tcmVtYXAoY29uc3QgY2hhciAqZmlsZSwgY29uc3QgaW50IGxpbmVubywg
dm9pZCAoKmNsZWFudXBfZm4pKHZvaWQpLAorCQl2b2lkICpvbGRfYWRkcmVzcywgc2l6ZV90IG9s
ZF9zaXplLCBzaXplX3QgbmV3X3NpemUsIGludCBmbGFncykKK3sKKwl2b2lkICpydmFsOworCisJ
cnZhbCA9IG1yZW1hcChvbGRfYWRkcmVzcywgb2xkX3NpemUsIG5ld19zaXplLCBmbGFncyk7CisK
KwlpZiAocnZhbCA9PSBNQVBfRkFJTEVEKSB7CisJCXRzdF9icmttXyhmaWxlLCBsaW5lbm8sIFRC
Uk9LIHwgVEVSUk5PLCBjbGVhbnVwX2ZuLAorCQkJICAibXJlbWFwKCVwLCV6dSwlenUsJWQpIGZh
aWxlZCIsIG9sZF9hZGRyZXNzLCBvbGRfc2l6ZSwKKwkJCSAgbmV3X3NpemUsIGZsYWdzKTsKKwl9
CisKKwlyZXR1cm4gcnZhbDsKK30KKwogaW50IHNhZmVfbXVubWFwKGNvbnN0IGNoYXIgKmZpbGUs
IGNvbnN0IGludCBsaW5lbm8sIHZvaWQgKCpjbGVhbnVwX2ZuKSAodm9pZCksCiAgICAgICAgICAg
ICAgICAgdm9pZCAqYWRkciwgc2l6ZV90IGxlbmd0aCkKIHsKCi0tIAoyLjUwLjAKCgotLSAKTWFp
bGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
