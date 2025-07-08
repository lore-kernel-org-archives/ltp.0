Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691DEC8303C
	for <ltp@archiver.kernel.org>; Tue,  8 Jul 2025 20:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752005568; h=date :
 mime-version : message-id : references : in-reply-to : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=6gEY5lw51Iekcf2p8TF0tr2YtrxY3yo4KKUwIDm2tVE=;
 b=pac6wsQC5Qkl0esB7MQqAQWxMFAqlinOmjd2B4z0SFPpaL6rq7yEs/jpql5asc4tXH6bk
 jEjXIass8JOY3eLSR7RCdHUiLfcyfyQjkJt2AIeuHSO/FxlncG/F0u8w0satHhWSYPsTI5t
 CrPzb7FoOR8mcDoanSf1Arveo/BgYI0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 390D53CA666
	for <ltp@archiver.kernel.org>; Tue,  8 Jul 2025 22:12:48 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3566D3CA650
 for <ltp@lists.linux.it>; Tue,  8 Jul 2025 22:12:07 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B9CB2600812
 for <ltp@lists.linux.it>; Tue,  8 Jul 2025 22:12:06 +0200 (CEST)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a531fcaa05so2886038f8f.3
 for <ltp@lists.linux.it>; Tue, 08 Jul 2025 13:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752005526; x=1752610326; darn=lists.linux.it;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=t+9W3Zq1oaKqtHH2vPOe4wUOfpO1aCJDW3kN++c1qu4=;
 b=gy/RdtF5RCXBYGejn84CWD8rJT+nNlddPYPkThPlCm93+vyIoa23jEeA73NZk6YiI9
 W5K+GEqGwehJH4O/+E6647bZ0eHAuhXhvokhBtTiM0gSaCtQx9L6jXyKBivA2kS7OTHE
 6YyDgHQQasO0uszIe02nlFnwTwYjXS29sgrLAtDN2FKGLOcN8ebf1hEjirtF9IxQrTad
 yub5XODLMqd++ddhJhQoa1ptnmi7BPdd+3+0QCyhiwclby2CjpwblHmughxrynvHOGWL
 AFOTjdKLw0eK26r6jSXZzC8TL7zeL8LaHdMjb53CrZ6pYUwACsUucfO6VWftN7PgnZKv
 +mOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752005526; x=1752610326;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t+9W3Zq1oaKqtHH2vPOe4wUOfpO1aCJDW3kN++c1qu4=;
 b=E9bhl4vSOdscPadMkV2XmenQrbdproVY5V2oHZK9Q7mCx16OGKMAa59Tl/uaY7JOJ1
 4jkbsV8NocWcA9PlLFXeVgktWTyhsqkdEy5DzN+rdxY4EWBdg96+uYAEfBHC3U5wzgKg
 qe6cOOV4OiJvabDGtei8Jvt7ojGOR9ynqGJXwb8c8XOEWzj1YVdua5A1TgCEeUByNKYC
 vIFWqW0Y8Cm8hdvfiqRitwzTil1vCYG/4QMXqOLwfPOPK+6ivbjTEAM4iHiFRsqHg34F
 dB2AeNYeE1YfyPRBjgHJb86w7Xdlb9+69n98dxVIUtSLAe3KLs/OZ1rbhrymc2sjLAYy
 02XA==
X-Gm-Message-State: AOJu0YwivP1t5SrWJF+yx9F0Iazx63Uv6KdYZZL6YCFaBnUCgy1bdA47
 mr8YR5+Y3KxT5kJZVMBgX9baW36Wq7OKUNMG+MwvAUTm3YMUmYDnH53GrjFv76ARgt0Zmv4wXC7
 Itc8W
X-Gm-Gg: ASbGnctvYw+1hdxohLe9MkxAAYP13H2BF5/LYIWdFzez/0g8EYESZ5gMoxFHzOtx+fN
 YkiW+OqIav3ymtn0+H9YkBwDrYmhIICege5x0yRl9CrzDnyLJXdVwfwPLDwlH3XU5irwH08kpPB
 223oJSip4hYYUCKRXWPKlIQiGr6f0uJTXuEPV+Vbsf5WUhJIEuiquQDUBcEgdk/EmLBXA7zMQ1r
 6R64+Myjwb2dgt+Fi+EcJH7E+vXKlOsK054GYtYPxz/7ejk9NnoMbzow+wefC+vnumpSkjY5qZr
 n8HsZUG+1vrzmQXTO/SnksDP59kq8QYomzu9XmxeF21pASDC+Q==
X-Google-Smtp-Source: AGHT+IF2QaxkmqVGDadweO/vUMR9kwqqWVVoL3iiczGrteVV7+9qyqc63ChCbyLyre53N0ZE2gXKVA==
X-Received: by 2002:a05:6000:18a5:b0:3a5:2182:bce2 with SMTP id
 ffacd0b85a97d-3b4964c0a9fmr17123003f8f.17.1752005525899; 
 Tue, 08 Jul 2025 13:12:05 -0700 (PDT)
Received: from localhost ([177.45.162.214])
 by smtp.gmail.com with UTF8SMTPSA id
 af79cd13be357-7d5dbe7ece9sm832761085a.71.2025.07.08.13.12.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 13:12:04 -0700 (PDT)
Date: Tue, 08 Jul 2025 17:11:55 -0300
MIME-Version: 1.0
Message-Id: <20250708-conversions-mremap-v1-1-aa043b0182fc@suse.com>
References: <20250708-conversions-mremap-v1-0-aa043b0182fc@suse.com>
In-Reply-To: <20250708-conversions-mremap-v1-0-aa043b0182fc@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=609; i=rbm@suse.com;
 h=from:subject:message-id; bh=MzsQn8dSgj1DvNddFckW3ajpwGgX5vnv/UfO5PuZtB0=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBobXuLuF/3qMR11MtXWv+01UjKkxNoX5RwH9gvb
 adFB2lP9DWJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaG17iwAKCRDJC4p8Y4ZY
 przbD/9tgUECmUgPdbwjsbqv7oRXDxs8DJnAyDe3x4+0xz2XCO0ZLuRk5mPh7fI0JjOeLuhgmd9
 hrLlG+GLzCuyJeQLPxXKWb8zB9eaj99Y1diXh+UHmKpmQVqMwsetuoZ1z9Mw+tdLY28rEviqIEe
 B6NG5MA4N9HCmM0UW92LYmEQvAJB5O08Iw40PVCa/7hWU0RSRiQ0HRKLzR/0Gw8AmiB+9uNnPcl
 F+ignZt83RoZQJmWMg6h/6e6Yh2fzmwE0n3bp6EkqiL2+DMfxIiwdlelZIy9NSRAKymxGjg88YO
 dk66lBs1zI5lAs5WBBW5cBmwZ179rusd1DIvOcD2mVWaqamyGJiqvsV6c9tufwo7LgyW3mSb5Ko
 tkutC3o7PD6bfJJjO3hxwIgfivo0porAe+Sl337V6WLbBPiGPWCW9sk+PcLol24IOSc/IVNzlvZ
 uBq5h0KzycfEcZ5g5zTHuBGFG/Ak+7FyNfmEPz0KfP/m8r9P9w1J5sJTiDQicYIXLCdqvNqJr/m
 aNBUif+atmGPlg0ugKG4R9ruaawUwAcQ0eJXB/dCFnVviPIyOATn+MO/BwEbcGcshHX2Hv97+AU
 Bgdyix562BphVrpojAqLga4vjy4vP/VshGhSlgWwwhwajsY/H6l3ioAQAQTi6MODgpE1EeAgkZU
 I5EDSJA9YloyeFA==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/7] lib: safe_macros: Fix memalign() failure error
 format
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
IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Ci0tLQogbGliL3NhZmVfbWFjcm9z
LmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkK
CmRpZmYgLS1naXQgYS9saWIvc2FmZV9tYWNyb3MuYyBiL2xpYi9zYWZlX21hY3Jvcy5jCmluZGV4
IDY5NDZjYzViY2I5NDIwMmE2N2ZjYjk4NmE1MDRlNzdhYjBhMjc3MzguLjU3YmMwYmM3NDk3MTJm
MWI4OTA1OTQxMjNiNmI5ZjNjYWJjZTgyMWEgMTAwNjQ0Ci0tLSBhL2xpYi9zYWZlX21hY3Jvcy5j
CisrKyBiL2xpYi9zYWZlX21hY3Jvcy5jCkBAIC04MjEsNyArODIxLDcgQEAgdm9pZCAqc2FmZV9t
ZW1hbGlnbihjb25zdCBjaGFyICpmaWxlLCBjb25zdCBpbnQgbGluZW5vLAogCiAJaWYgKHJ2YWwg
PT0gTlVMTCkgewogCQl0c3RfYnJrbV8oZmlsZSwgbGluZW5vLCBUQlJPSyB8IFRFUlJOTywgY2xl
YW51cF9mbiwKLQkJCSJtZW1hbGlnbigpIGZhaWxlZCIpOworCQkJIm1lbWFsaWduKCV6dSwlenUp
IGZhaWxlZCIsIGFsaWdubWVudCwgc2l6ZSk7CiAJfQogCiAJcmV0dXJuIHJ2YWw7CgotLSAKMi41
MC4wCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
