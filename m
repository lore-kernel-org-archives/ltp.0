Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6364EC83013
	for <ltp@archiver.kernel.org>; Wed,  2 Jul 2025 10:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751451998; h=date :
 mime-version : message-id : references : in-reply-to : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=b+LKljoHQcFkbj9tuoEK9Yp6d7IIuvJzb6uB8TYV16M=;
 b=iMCy6ruGAEbDl6owEPKl3oP88Rq9uO1T0vGDMvtAxOTFrggZmbpuZ9KLvPKfZxDGJA1or
 7T2CdkQEPlzTlw/KXARjBt2fJGDokwFsnOSKIir7FUPcHc6CywyjhhYp66t+bklGUG6SEAQ
 0udrMPJBLfHiG2ia0uDCY6b8UdhIof4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E5EE43C8818
	for <ltp@archiver.kernel.org>; Wed,  2 Jul 2025 12:26:38 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6FC423C8623
 for <ltp@lists.linux.it>; Wed,  2 Jul 2025 12:25:57 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E276110009DD
 for <ltp@lists.linux.it>; Wed,  2 Jul 2025 12:25:56 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a50956e5d3so5566577f8f.1
 for <ltp@lists.linux.it>; Wed, 02 Jul 2025 03:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751451956; x=1752056756; darn=lists.linux.it;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8knxhg5bQRzCDJgGOcEStPxg1e4GV3nEqua33+EhNSM=;
 b=PrLT+l93i+eInS7SDLI/XKP8UsqNta8oLv/ubYDfo5PimsjbiU41opEyr4zOYmw0LQ
 hTlz/BLdCNPcNdFqF27k9Hi0jbEgy3P9ucVmVB2CtN7w5rvxE+LVGPv0BN0q4rqN68Ds
 p3eJOcyA5Y39K+AYzBWQ2Imnz7zxzjHwxdRbPIZoBgpVCEfNub98ZU69cvFXt31m5Cd8
 wVp2bgTlbZoCBanZLY85fjCYG8Qy4Zbs1D96vymUhD+pm6ifANYKnvqkzBFSGAjD1cTh
 3UKkr0IKBRxyNWtbGCrnFK4jDLmKHq7iCZaqNd5fl/I3YiOTN2qTPRI0ImA8JV8N03Sy
 QICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751451956; x=1752056756;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8knxhg5bQRzCDJgGOcEStPxg1e4GV3nEqua33+EhNSM=;
 b=qu26UfROxi7C1kux972qeQkDspYSy1e3sh/JzU9sYojs50+O8RWCyg/yOzNpv2WH54
 HIuDzvzuhrQWlwiEe6kDYgT6R+BVEkY+/LZhH/vayFodcyPI/kJoG/dbwohvLzgialzT
 2g9b4ah8CGaji+M+aIAY/qa8lzOAMD9nIt8yOIk7GpLqQCWuj17LJQ65ldAG0izKbmMO
 sws3Dbu6BUxxc9FIelqogX1cp9xYplJ1b+wzMmA/T47vbnzZCm+INgA8wkmeHeTZjArP
 2HRSAt53tK3jrBNaux1hFrx+/CWKCUP05Kj3wH9QTBmFLb9d1FYEeKMyLLm1CyyllUJb
 ryAw==
X-Gm-Message-State: AOJu0YwyS2b/MzvNqViLRAbyWyDLtfW2PpvG8YVNPPw6LRcQo1vEpO5+
 Opk9xIb7hydHm2LEanoNXFGFg0XGTKuyoEu1eIE8+Y3ONOzCRL1m2kfwmauPBebXL44=
X-Gm-Gg: ASbGnctO9O7oQjzb4XyQ6yBK0AAlObqVSkSpplCRIBLWedjf0LdnwE0zBo5PB8irKy5
 JEt1FhJ+bMxxPVF7Qh5HZBQLL5RBF+hByPd47evM0CIy1/I8uctfc556GDYpH9JzC2oMntDiyGL
 85vVvTI+ZOL/h0LPYpF1plX4bLNt5ERU9FBt/LnMiz1UZWWZMTNQylBhZrm90MgWtbfA/sXOi/w
 ZoKPsdhqrWCkZIzdv6cwf1Vi8mlF4HxD/yX056ueMsu5OmxF3Ps+ewXIwZ0UPBxTuBg04G+s8m+
 2ORJ/AJ6H5zAzIkVmgut2RlJRW7/5JkfMuL4E6T5LClxqGwRqg==
X-Google-Smtp-Source: AGHT+IGKWme39TZNHnfQHzUNH3PvvEImxcgb9pNMdsficsa43vJUH3Ru2rvyGu/G0b5pNmBXYjTKLg==
X-Received: by 2002:a05:6000:4285:b0:3a5:2fae:1348 with SMTP id
 ffacd0b85a97d-3b201201c0dmr1609819f8f.51.1751451956124; 
 Wed, 02 Jul 2025 03:25:56 -0700 (PDT)
Received: from localhost ([177.45.162.214])
 by smtp.gmail.com with UTF8SMTPSA id
 d75a77b69052e-4a7fc57cd2dsm88941801cf.59.2025.07.02.03.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 03:25:54 -0700 (PDT)
Date: Wed, 02 Jul 2025 07:25:41 -0300
MIME-Version: 1.0
Message-Id: <20250702-conversions-lchown-v1-1-ac7adb3af51d@suse.com>
References: <20250702-conversions-lchown-v1-0-ac7adb3af51d@suse.com>
In-Reply-To: <20250702-conversions-lchown-v1-0-ac7adb3af51d@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2536; i=rbm@suse.com;
 h=from:subject:message-id; bh=ITC8krn3WTjSVNcrr5f8MeCl2XXaTAh/5zOswzqiMGM=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBoZQkpAEsJKwgrTa2uXdqWQk1SaJrzoqbdVvCn5
 VSCKAodOluJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaGUJKQAKCRDJC4p8Y4ZY
 pkEcD/9o6cQxQBJerfNddDZnNd3+Y+zAPKbPvoTWGrJBLm3w2W6eWkBdKxwB29RiUXI0dEQVU2r
 pKX3SZTu9+rzlEaOql0z3WBhQqQx6ZzMnPhG0AqgCtfDTYGhr6i0BmU025ekZkuPi/0lWU43dGX
 p3iaQB50PaDl9EFCplIuTjoy9YkjnUR1MTB9n2PHi1fflSZ4mxCtAsFJEHDovFsmeU1wX/50ePG
 m21LC+3uR5Dia33RXUGPMoRCQjmGdhfDdAcY3SpyEeG7VO4YvRTBSJiC4VXk5YVTuFmZpj8Id4k
 QY+poOWKvg4744+L6qX6F1fQJAvxC4hpPwS5P1AuWX26DiWnzXj3Q4Db6x9yYT8qzkE7v/+agRk
 ZXWct8DHCIi84v5uX3VoL+6vaS1ril//3ftqtoKFEpup3FO7j/az0Jzwgg1+nXrPxeP24AFTkvg
 ddF0r3uaxksBGPVASfKqc9lNF5yVii4LuEuwzRZbZv2IFDW7Td9awEQMXavzzmV9F141AMwObqw
 C5Xvc9fHNdVee48s/nSTusjD+a4601tH27hOzToIm2dgt7eEmlFFBvX21XfiYnEuHKyMRD6ca2h
 14bVd9U57RWuEnNdBZWK63nlMVVhRelXfSJSNsdeegYAR8uyVs4AWccYpomiNKAfws0tdIZ9X4E
 vry5q4gMVAqepCw==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/4] lib: Add SAFE_LCHOWN
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
Y3Jvc19mbi5oICB8ICAzICsrKwogaW5jbHVkZS90c3Rfc2FmZV9tYWNyb3MuaCB8ICAzICsrKwog
bGliL3NhZmVfbWFjcm9zLmMgICAgICAgICB8IDE5ICsrKysrKysrKysrKysrKysrKysKIDMgZmls
ZXMgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvc2FmZV9t
YWNyb3NfZm4uaCBiL2luY2x1ZGUvc2FmZV9tYWNyb3NfZm4uaAppbmRleCBkMjU2MDkxYjc2YWQx
MGIwNmIyOWUzZmQ1ZmFkODg1M2ZhYTE0YzA4Li4wNzczMjk1N2Y0YjdiMDM3ZTNmMTlkMmE1YTli
ZGU1M2UyMWZiZDM4IDEwMDY0NAotLS0gYS9pbmNsdWRlL3NhZmVfbWFjcm9zX2ZuLmgKKysrIGIv
aW5jbHVkZS9zYWZlX21hY3Jvc19mbi5oCkBAIC0xNTEsNiArMTUxLDkgQEAgaW50IHNhZmVfY2hv
d24oY29uc3QgY2hhciAqZmlsZSwgY29uc3QgaW50IGxpbmVubywgdm9pZCAoY2xlYW51cF9mbiko
dm9pZCksCiBpbnQgc2FmZV9mY2hvd24oY29uc3QgY2hhciAqZmlsZSwgY29uc3QgaW50IGxpbmVu
bywgdm9pZCAoY2xlYW51cF9mbikodm9pZCksCiAgICAgICAgICAgICAgICAgaW50IGZkLCB1aWRf
dCBvd25lciwgZ2lkX3QgZ3JvdXApOwogCitpbnQgc2FmZV9sY2hvd24oY29uc3QgY2hhciAqZmls
ZSwgY29uc3QgaW50IGxpbmVubywgdm9pZCAoY2xlYW51cF9mbikodm9pZCksCisgICAgICAgICAg
ICAgICBjb25zdCBjaGFyICpwYXRoLCB1aWRfdCBvd25lciwgZ2lkX3QgZ3JvdXApOworCiBwaWRf
dCBzYWZlX3dhaXQoY29uc3QgY2hhciAqZmlsZSwgY29uc3QgaW50IGxpbmVubywgdm9pZCAoY2xl
YW51cF9mbikodm9pZCksCiAgICAgICAgICAgICAgICAgaW50ICpzdGF0dXMpOwogCmRpZmYgLS1n
aXQgYS9pbmNsdWRlL3RzdF9zYWZlX21hY3Jvcy5oIGIvaW5jbHVkZS90c3Rfc2FmZV9tYWNyb3Mu
aAppbmRleCAxOTUwNGJlYjU3YWQzNzljODM1YTEzZWQ1ZDM1ZmUwNmU0MmE2ZWQ2Li40MWQxN2Ix
Y2E0NTkwNDU4Y2Y2NTFhNTlhNmUzNzdjMjE1NzI3MDk0IDEwMDY0NAotLS0gYS9pbmNsdWRlL3Rz
dF9zYWZlX21hY3Jvcy5oCisrKyBiL2luY2x1ZGUvdHN0X3NhZmVfbWFjcm9zLmgKQEAgLTIyMCw2
ICsyMjAsOSBAQCBpbnQgc2FmZV9nZXRncm91cHMoY29uc3QgY2hhciAqZmlsZSwgY29uc3QgaW50
IGxpbmVubywgaW50IHNpemUsIGdpZF90IGxpc3RbXSk7CiAjZGVmaW5lIFNBRkVfRkNIT1dOKGZk
LCBvd25lciwgZ3JvdXApIFwKIAlzYWZlX2ZjaG93bihfX0ZJTEVfXywgX19MSU5FX18sIE5VTEws
IChmZCksIChvd25lciksIChncm91cCkpCiAKKyNkZWZpbmUgU0FGRV9MQ0hPV04ocGF0aCwgb3du
ZXIsIGdyb3VwKSBcCisJc2FmZV9sY2hvd24oX19GSUxFX18sIF9fTElORV9fLCBOVUxMLCAocGF0
aCksIChvd25lciksIChncm91cCkpCisKICNkZWZpbmUgU0FGRV9XQUlUKHN0YXR1cykgXAogCXNh
ZmVfd2FpdChfX0ZJTEVfXywgX19MSU5FX18sIE5VTEwsIChzdGF0dXMpKQogCmRpZmYgLS1naXQg
YS9saWIvc2FmZV9tYWNyb3MuYyBiL2xpYi9zYWZlX21hY3Jvcy5jCmluZGV4IDY5NDZjYzViY2I5
NDIwMmE2N2ZjYjk4NmE1MDRlNzdhYjBhMjc3MzguLmU5NzFlNWQ5MGZjMTYyNTk1Njk0MGY3YjUw
MWE4ZGI0NGVmOTE2ZGMgMTAwNjQ0Ci0tLSBhL2xpYi9zYWZlX21hY3Jvcy5jCisrKyBiL2xpYi9z
YWZlX21hY3Jvcy5jCkBAIC03NzUsNiArNzc1LDI1IEBAIGludCBzYWZlX2ZjaG93bihjb25zdCBj
aGFyICpmaWxlLCBjb25zdCBpbnQgbGluZW5vLCB2b2lkIChjbGVhbnVwX2ZuKSh2b2lkKSwKIAly
ZXR1cm4gcnZhbDsKIH0KIAoraW50IHNhZmVfbGNob3duKGNvbnN0IGNoYXIgKmZpbGUsIGNvbnN0
IGludCBsaW5lbm8sIHZvaWQgKGNsZWFudXBfZm4pKHZvaWQpLAorCQkJY29uc3QgY2hhciAqcGF0
aCwgdWlkX3Qgb3duZXIsIGdpZF90IGdyb3VwKQoreworCWludCBydmFsOworCisJcnZhbCA9IGxj
aG93bihwYXRoLCBvd25lciwgZ3JvdXApOworCisJaWYgKHJ2YWwgPT0gLTEpIHsKKwkJdHN0X2Jy
a21fKGZpbGUsIGxpbmVubywgVEJST0sgfCBURVJSTk8sIGNsZWFudXBfZm4sCisJCQkibGNob3du
KCVzLCVkLCVkKSBmYWlsZWQiLCBwYXRoLCBvd25lciwgZ3JvdXApOworCX0gZWxzZSBpZiAocnZh
bCkgeworCQl0c3RfYnJrbV8oZmlsZSwgbGluZW5vLCBUQlJPSyB8IFRFUlJOTywgY2xlYW51cF9m
biwKKwkJCSJJbnZhbGlkIGxjaG93biglcywlZCwlZCkgcmV0dXJuIHZhbHVlICVkIiwgcGF0aCwK
KwkJCW93bmVyLCBncm91cCwgcnZhbCk7CisJfQorCisJcmV0dXJuIHJ2YWw7Cit9CisKIHBpZF90
IHNhZmVfd2FpdChjb25zdCBjaGFyICpmaWxlLCBjb25zdCBpbnQgbGluZW5vLCB2b2lkIChjbGVh
bnVwX2ZuKSh2b2lkKSwKICAgICAgICAgICAgICAgICBpbnQgKnN0YXR1cykKIHsKCi0tIAoyLjUw
LjAKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGlu
Zm8vbHRwCg==
