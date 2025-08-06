Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B8DC87FCB
	for <ltp@archiver.kernel.org>; Wed,  6 Aug 2025 21:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1754514528; h=date :
 mime-version : message-id : references : in-reply-to : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=nqzfelptBJjjR8GvZKgAbRFy7lXoqBBo7E0ZUwEwYsw=;
 b=hftJ9bcaBBAc6dC02fxzbqTPhBxO6oNv6xmnabDy7j5tKQYKK3SZaeu9xT0h2AuRA087l
 3WzL+Ldhmb6vXybd3KNwaHUJX992DABQlocpkPOrBdLItKklekCSNmHPd7MmSpWa7aoNlZy
 ZVspUzlFh5VryGW7MBWgDflCJ2qtjTw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 88C203C8CA8
	for <ltp@archiver.kernel.org>; Wed,  6 Aug 2025 23:08:48 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D9C013C8C3D
 for <ltp@lists.linux.it>; Wed,  6 Aug 2025 23:08:06 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3D18B60007C
 for <ltp@lists.linux.it>; Wed,  6 Aug 2025 23:08:06 +0200 (CEST)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3b7920354f9so196724f8f.2
 for <ltp@lists.linux.it>; Wed, 06 Aug 2025 14:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1754514485; x=1755119285; darn=lists.linux.it;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=U9MyYJIVjSs6bGPQ1DyqUKC0WejfLsqZyoropJYAuXI=;
 b=DYQNtp4L1MxUYTceMe0oOsGfq9HVRiGpF3z3dkUz3wouiaVlrN/eHocblAD13sOaN1
 8r9oGdoeVeG/vo36scKfTO+lrNiLolPbgfEjPQFux8r403favOcieCNT1lZvrYx8FTde
 XNsrzZEJvOSV/bvgRaPt8Gpbz6SyJsfs9i2HI4h4GjoApDj8C/N+8MedfIqmfS/H5SnD
 GuwZ1UDBsU1I24xK5neaUZmqZh+83dJuAbIoTaN4QxqSZX+GN2U/0acmFeZafpKRnnHa
 qoI5iB7KBXomjGAlCgcs60M636WGj93Qb64/k+PoTbulRzlCOGWaeAV4ckzk/W/5hFvO
 v62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754514485; x=1755119285;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U9MyYJIVjSs6bGPQ1DyqUKC0WejfLsqZyoropJYAuXI=;
 b=mvZ7FIE6EiRWjvdZaypY9skMm0uBlaLFRBzWe6pmjTt3EfOjpaGiFgH0ISqkp3K4/C
 bFVxMqPhDLkt8XdIrBDscnWtU7RmaQMrEWy68S3Su+ly9vRNpoiVJwyQqM9fxW2LHsdz
 sZ7PSckqSmmtpf1PmvdFMjJsLu1ro4ifkhT6CITk9j2maRV/HcMPhBCM7sSgKLR7Vlfz
 kyIRXefiA2bBRDLfrU9CsppxFl3e9MyGyduJLouYmL67sS9G2qDbn3tT8kBAq4EFWqt+
 Ca2IglpXbffrJ2PrasrMec1ZrYsgBvYbIkUNSTVlUpfvzBLivse3nlQD0muBJCSl8jCV
 d8uw==
X-Gm-Message-State: AOJu0YyqIlLJCz/1mjqr63ywuoFALRvNwYeU6dNq8X0/gbTQXh6bcHJT
 ythfpWeu0dFloqjiwwUqrUbpIgl106XV0epgNblQadZsWbOVVoamjYRG0JEiif50Wl6mdPtqoJ1
 x40B+ofE=
X-Gm-Gg: ASbGncsANlVXAPQkmdlLE+ZsniQD9cJE33KNqowa4kwXLN9hGC1ncvnm9Dd2dqbVBqY
 YN4l57p3aoep5UfAoJ5inepqRr8ksIEoD+Jma7U6Tk58KB0OulGeKIgztgH9mGwDqDJ4Fg8S9sO
 BUvEIrPkU4vcxiSXvlbOJb1XXalFv5LGL6SFaXjTvDXaxShDr83yqKsu12Xh8b2tkNsh0HhSL1H
 mtNhzsr52XCYAH1op0GrZ/8OxkfIE3oSC1K7qLpA5OeNB0icX9N2a/ASUzs7Tg5MGtdM0K9TK7V
 GoDyWM5C69arnxL8M9+KuJSf9PMdEatLihdgEwJ7rRo4wNjnnxgkSoYYvfox2u4y/nMdeSgZNYQ
 dttXf3HmtXg==
X-Google-Smtp-Source: AGHT+IEm0KdahJXouVJtWiXcuJ3ArP2oZElI1P1Cm/5I58RSCtdAB8q+k5cwvD4BJRwlreOob1207Q==
X-Received: by 2002:a5d:5d10:0:b0:3b7:83c0:a9ab with SMTP id
 ffacd0b85a97d-3b8f41bf22cmr4014674f8f.55.1754514485350; 
 Wed, 06 Aug 2025 14:08:05 -0700 (PDT)
Received: from localhost ([177.94.120.255])
 by smtp.gmail.com with UTF8SMTPSA id
 a1e0cc1a2514c-88e0268c86dsm9690241.1.2025.08.06.14.08.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 14:08:04 -0700 (PDT)
Date: Wed, 06 Aug 2025 18:07:46 -0300
MIME-Version: 1.0
Message-Id: <20250806-conversions-lchown-v2-1-345590fefaae@suse.com>
References: <20250806-conversions-lchown-v2-0-345590fefaae@suse.com>
In-Reply-To: <20250806-conversions-lchown-v2-0-345590fefaae@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2583; i=rbm@suse.com;
 h=from:subject:message-id; bh=MFXubNIZ+J4QTy452u7Y9TVoLr7LqgruxtM/tDMrLCc=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBok8QuW9ZxRwAttO6+sFtGp1BaYBLziC/g9j8Kb
 aGyOAw8oTWJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaJPELgAKCRDJC4p8Y4ZY
 piD9D/9PuLhoxSLpcDgbVDgR3xA72hcsItegGwd7Q+jE2Tqmxd133nr5M5owwVkOrS/Gh76wBhU
 vuxIRuKUaCUuA6TYYfNeMXQPw2PS0ccaEy31VUcQZrrQw4wmP/O2Xn5vBCKo5uryukyAG2AsJvv
 2OS2rL25GVChLrRpfB+CbNQFCALrisU9Ft/qZe2UuQ6c5b1j0v0W7VT/CpL9USLT3FQirseCTFL
 nTFPsrpvSMwv3TFnQPA2QMD/zXbERYUFgZ0I8QSuzt2DoijJscRUOMS/e55UVzw44O9Vbl8k64H
 hLylZLQo9EpbvKmUFlUvoqUcToNHqhIbbbY1GA18m+b9GpVPNt88b7+Rt/aFRAyI5tXvfQv4AIP
 11cvq/Nj+ZhkTjJCJl0AdJGXhPhbAOEJucWbf2qvx9zg6DZfWrSbebmzoehU10qnwJ+uAzhzbyO
 NbF5FT94dCdYoIeHM+CHhJr9ATUG9cSUNvieVGJJIU7oZQJx35Qr1qN987Dy3inNxWsdemnATKZ
 GCVQjvp4CprbHsygHvA+SsbDKevKgmFO+7jhpA8lvvsk30LCRRgEgKXPC/QENh0YCyeeZ2tJW+Q
 EmoKdgpr5AwCSM8zeZZkw9FWEvyRB1WhL3X3r+d6BV2Qx/h0+UTr0Ca6lEx2HwGv/fYMzE+Lzet
 6XY4U9sb/xKnZbA==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/4] lib: Add SAFE_LCHOWN
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
bmRyZWEgQ2VydmVzYXRvIDxhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPgpTaWduZWQtb2ZmLWJ5
OiBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgotLS0KIGluY2x1ZGUvc2FmZV9t
YWNyb3NfZm4uaCAgfCAgMyArKysKIGluY2x1ZGUvdHN0X3NhZmVfbWFjcm9zLmggfCAgMyArKysK
IGxpYi9zYWZlX21hY3Jvcy5jICAgICAgICAgfCAxOSArKysrKysrKysrKysrKysrKysrCiAzIGZp
bGVzIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9pbmNsdWRlL3NhZmVf
bWFjcm9zX2ZuLmggYi9pbmNsdWRlL3NhZmVfbWFjcm9zX2ZuLmgKaW5kZXggZDI1NjA5MWI3NmFk
MTBiMDZiMjllM2ZkNWZhZDg4NTNmYWExNGMwOC4uMzc5OTg3M2EyNDhmMzZlMGZmMzFjODYyZGUy
NzAzYTEzZmVlMWJmZCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9zYWZlX21hY3Jvc19mbi5oCisrKyBi
L2luY2x1ZGUvc2FmZV9tYWNyb3NfZm4uaApAQCAtMTUxLDYgKzE1MSw5IEBAIGludCBzYWZlX2No
b3duKGNvbnN0IGNoYXIgKmZpbGUsIGNvbnN0IGludCBsaW5lbm8sIHZvaWQgKGNsZWFudXBfZm4p
KHZvaWQpLAogaW50IHNhZmVfZmNob3duKGNvbnN0IGNoYXIgKmZpbGUsIGNvbnN0IGludCBsaW5l
bm8sIHZvaWQgKGNsZWFudXBfZm4pKHZvaWQpLAogICAgICAgICAgICAgICAgIGludCBmZCwgdWlk
X3Qgb3duZXIsIGdpZF90IGdyb3VwKTsKIAoraW50IHNhZmVfbGNob3duKGNvbnN0IGNoYXIgKmZp
bGUsIGNvbnN0IGludCBsaW5lbm8sIHZvaWQgKCpjbGVhbnVwX2ZuKSh2b2lkKSwKKwkJY29uc3Qg
Y2hhciAqcGF0aCwgdWlkX3Qgb3duZXIsIGdpZF90IGdyb3VwKTsKKwogcGlkX3Qgc2FmZV93YWl0
KGNvbnN0IGNoYXIgKmZpbGUsIGNvbnN0IGludCBsaW5lbm8sIHZvaWQgKGNsZWFudXBfZm4pKHZv
aWQpLAogICAgICAgICAgICAgICAgIGludCAqc3RhdHVzKTsKIApkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS90c3Rfc2FmZV9tYWNyb3MuaCBiL2luY2x1ZGUvdHN0X3NhZmVfbWFjcm9zLmgKaW5kZXggMTk1
MDRiZWI1N2FkMzc5YzgzNWExM2VkNWQzNWZlMDZlNDJhNmVkNi4uNDFkMTdiMWNhNDU5MDQ1OGNm
NjUxYTU5YTZlMzc3YzIxNTcyNzA5NCAxMDA2NDQKLS0tIGEvaW5jbHVkZS90c3Rfc2FmZV9tYWNy
b3MuaAorKysgYi9pbmNsdWRlL3RzdF9zYWZlX21hY3Jvcy5oCkBAIC0yMjAsNiArMjIwLDkgQEAg
aW50IHNhZmVfZ2V0Z3JvdXBzKGNvbnN0IGNoYXIgKmZpbGUsIGNvbnN0IGludCBsaW5lbm8sIGlu
dCBzaXplLCBnaWRfdCBsaXN0W10pOwogI2RlZmluZSBTQUZFX0ZDSE9XTihmZCwgb3duZXIsIGdy
b3VwKSBcCiAJc2FmZV9mY2hvd24oX19GSUxFX18sIF9fTElORV9fLCBOVUxMLCAoZmQpLCAob3du
ZXIpLCAoZ3JvdXApKQogCisjZGVmaW5lIFNBRkVfTENIT1dOKHBhdGgsIG93bmVyLCBncm91cCkg
XAorCXNhZmVfbGNob3duKF9fRklMRV9fLCBfX0xJTkVfXywgTlVMTCwgKHBhdGgpLCAob3duZXIp
LCAoZ3JvdXApKQorCiAjZGVmaW5lIFNBRkVfV0FJVChzdGF0dXMpIFwKIAlzYWZlX3dhaXQoX19G
SUxFX18sIF9fTElORV9fLCBOVUxMLCAoc3RhdHVzKSkKIApkaWZmIC0tZ2l0IGEvbGliL3NhZmVf
bWFjcm9zLmMgYi9saWIvc2FmZV9tYWNyb3MuYwppbmRleCA2OTQ2Y2M1YmNiOTQyMDJhNjdmY2I5
ODZhNTA0ZTc3YWIwYTI3NzM4Li5lOTcxZTVkOTBmYzE2MjU5NTY5NDBmN2I1MDFhOGRiNDRlZjkx
NmRjIDEwMDY0NAotLS0gYS9saWIvc2FmZV9tYWNyb3MuYworKysgYi9saWIvc2FmZV9tYWNyb3Mu
YwpAQCAtNzc1LDYgKzc3NSwyNSBAQCBpbnQgc2FmZV9mY2hvd24oY29uc3QgY2hhciAqZmlsZSwg
Y29uc3QgaW50IGxpbmVubywgdm9pZCAoY2xlYW51cF9mbikodm9pZCksCiAJcmV0dXJuIHJ2YWw7
CiB9CiAKK2ludCBzYWZlX2xjaG93bihjb25zdCBjaGFyICpmaWxlLCBjb25zdCBpbnQgbGluZW5v
LCB2b2lkIChjbGVhbnVwX2ZuKSh2b2lkKSwKKwkJCWNvbnN0IGNoYXIgKnBhdGgsIHVpZF90IG93
bmVyLCBnaWRfdCBncm91cCkKK3sKKwlpbnQgcnZhbDsKKworCXJ2YWwgPSBsY2hvd24ocGF0aCwg
b3duZXIsIGdyb3VwKTsKKworCWlmIChydmFsID09IC0xKSB7CisJCXRzdF9icmttXyhmaWxlLCBs
aW5lbm8sIFRCUk9LIHwgVEVSUk5PLCBjbGVhbnVwX2ZuLAorCQkJImxjaG93biglcywlZCwlZCkg
ZmFpbGVkIiwgcGF0aCwgb3duZXIsIGdyb3VwKTsKKwl9IGVsc2UgaWYgKHJ2YWwpIHsKKwkJdHN0
X2Jya21fKGZpbGUsIGxpbmVubywgVEJST0sgfCBURVJSTk8sIGNsZWFudXBfZm4sCisJCQkiSW52
YWxpZCBsY2hvd24oJXMsJWQsJWQpIHJldHVybiB2YWx1ZSAlZCIsIHBhdGgsCisJCQlvd25lciwg
Z3JvdXAsIHJ2YWwpOworCX0KKworCXJldHVybiBydmFsOworfQorCiBwaWRfdCBzYWZlX3dhaXQo
Y29uc3QgY2hhciAqZmlsZSwgY29uc3QgaW50IGxpbmVubywgdm9pZCAoY2xlYW51cF9mbikodm9p
ZCksCiAgICAgICAgICAgICAgICAgaW50ICpzdGF0dXMpCiB7CgotLSAKMi41MC4xCgoKLS0gCk1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
