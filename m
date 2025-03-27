Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0FC4C36010
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 14:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743085800; h=date :
 mime-version : message-id : references : in-reply-to : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=fBdXyoH3zNXRkxY6XWIkaTaYGKsa2E8XWNRowlyeVOs=;
 b=mncY4cLx5rI+3HlHSdDBUKkF+TXTOSRG9HMJRU0VcWrGrLOON8MV7vrlmfl1KaJoBa4fv
 VbuNWnV5gJYn9/MIzQtLdPNqfutCTnyJgj7tj7Bjl3+33nZC1tjfo+kfsSnuF5O7HlJ7bbB
 cmOwETq0eB0OiGcRI9q9ZAaOoIfV6ks=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7AE5D3C9FA1
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 15:30:00 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 47B313C9FBD
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 15:28:50 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 907D5140043F
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 15:28:49 +0100 (CET)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-39129fc51f8so769177f8f.0
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 07:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1743085729; x=1743690529; darn=lists.linux.it;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZtFPttDuFu/OktWORwg+kWOw2veGmroIjqf0EeCGBOU=;
 b=Hsb5YvnP05fQ9phJdFdkcsa0vVKIuyxPfzI9ghC308KFbbrsPzjEXzR5Op+gJu1/6t
 oI1pWp98DJdZb+fMMQzkb0pWcEX7+upzIWgWcML8DgFxGM3z45siLFPCe3Q+7Frs4haD
 gjwK0Ux833CLO+m95nWaL5JNgluBv9hTRsljFYg/XibhSJ9AnvuktHdiWJhp7wSWNBL0
 ZUj1pPFcbmlggJyYW3Z1SpW1RSeUi2N+pil9Qm1aRfASBFqlyvkUmNG2s7DJWbwyOZYg
 4YxvE5/DCew9XduMYo5IWshy6yG7Mnxt9e2216DcrDi5roW8ZE0mN3CzmT1+mmnA+r1P
 Uuow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743085729; x=1743690529;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZtFPttDuFu/OktWORwg+kWOw2veGmroIjqf0EeCGBOU=;
 b=AU2hhGXp5FRTk38YhzyAJaMf/pj1MbMjpZ1iypBCCAoN/uIyVL9jQ6+Y86PsHI1yQU
 6gIuPtigz6qhkCwzgXgaWf/eC88M9EEsULTiMQEGpazEIpjdSEipg57aqV6k8e+XnFZw
 MSzeQ80O4ZREOS8/lCYFL+yTVtSmI4lDb3FjFi3umm1GlMo1JCc/92BBwz8aPDfclJ3r
 +X08p5RkbzmNBhz9RkD2pyfkmsu1T/VaI3F9Y2AFgz6jAlJY+2l7hpk5pTUixZn1EB0g
 xpyWt/mCDwvV/nKyjROoKNegPtjLG6samd/S+BMD3i1T4t1aZaE9Z36f7g/5y12zaHoH
 vgrQ==
X-Gm-Message-State: AOJu0YzpgLPTzFEHJeQN7AO4xpGhyriMc+N3nw9k4n6X/k4Y+urlLaVk
 hTXqu0X4IzKE9sP2nW4MqfnrLI9tNTn/Jp+104WmelXHVULSTIGQcR5eSUSkl1l/JCLFxeAzPBV
 t
X-Gm-Gg: ASbGncv+Itr/URpFfKyBK7pUTRbdpPWpzf7l7pc80Lpz714lL2jq693CufPHzM4XTcB
 nrLT8UoMgpNkVS52sNVRpVZHlS077lZYHuH3N5+Zng69Cq0j9xvDmEd1juRy0xo95SlvRYFAEy+
 cauVsyRd+AJ6XdF+sigc3KWFZGFbFOX9pqu+4FAEVM9zTVlvC0A2DZslLDWghm5lMSf/3ay8PrX
 qndoSmQ4JWTheDq7OK/x8lvACxMUAHQw//FxlpuWIT/Mj61Hw+MO/i9zrgmiSaMiuJkHFU1Muzw
 zyv5EAms9Zy2rPR8e/uJQtcPxQo5vvX1wQ==
X-Google-Smtp-Source: AGHT+IGVHfkxbIgAXMdST8ocKu+97TanPMXTpeSeTHb1hiy0MceQYQw/b5CHCUvUy0mpcSJxru1OVw==
X-Received: by 2002:a5d:5f8c:0:b0:38f:2413:2622 with SMTP id
 ffacd0b85a97d-39ad1760877mr3013821f8f.47.1743085728850; 
 Thu, 27 Mar 2025 07:28:48 -0700 (PDT)
Received: from localhost ([179.228.213.210])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-73905fab1dcsm14351417b3a.4.2025.03.27.07.28.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Mar 2025 07:28:48 -0700 (PDT)
Date: Thu, 27 Mar 2025 11:28:25 -0300
MIME-Version: 1.0
Message-Id: <20250327-conversions-modify_ldt-v2-2-2907d4d3f6c0@suse.com>
References: <20250327-conversions-modify_ldt-v2-0-2907d4d3f6c0@suse.com>
In-Reply-To: <20250327-conversions-modify_ldt-v2-0-2907d4d3f6c0@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3461; i=rbm@suse.com;
 h=from:subject:message-id; bh=4ZZ6fw989x5Qq+48BPlzmvjZUVDyr6uG7f7SmLDUSZA=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBn5WCX+AFCsvINBwncm63qdg+U6fpW95XcD2n7A
 6W/OKOrTpSJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ+VglwAKCRDJC4p8Y4ZY
 puitD/sEfVs8KcFJkL5kzOpZnWpNuQkUvfWOqYCT8c3FNKEWHn2Wmvm4UBqEE/e1C/XUkaXoxtY
 WnBPG6y7OgZIaNyjm8gS5JKPUzU3KeRs4vwAHY3XOv1rb+1r8TDDZ/0/IkbuS14seSX+OHQxH29
 O/Q4wufDN94MaNpF9KgQUgY4IWBAlpliOgtAAVFpDXUZOzFLuvXlCIn64XhWpaXw9YIUVHR8f97
 o3YVbcbLPoJ2HLg1TGmETcteKnsPPmdu87FGoKlyCFI0YIQCFQYOfu9mWBGx0zaMyftU1fKOOj5
 VyAKtI6++C2/QNLY7AiAPFLpOlU4CXClYgzDXlbk72lyqt2i2QTo2ptn/o/w3OonFbS3h6AjhF8
 ohI5hy5mArmadofS3YKeXCv3tIYkQ1II7pD2oVbm8IJM7LP9k6gSLJDmIM7sG4XW3rtemlF1bbU
 G67YkGyCv3dMu8Ob+Grn9R6t6n04CMx8JQIvOqHcBvLUYc38xFTMVu6yoJsrYH7fwpN920/W7A1
 G5C6qGdStO7g+Zix6SqvchheSJusPbLA5v5l/Qmuov33o4JY0uAoC4NyJOzR0FVkN9HyOuIS14W
 EYl/WVFZkA0PhoJOjwrxHee8tIcsk5FU42ztNGvnHP7WUNpce4z5aq4U2XOvFvHoEkEIAyaJUgc
 +VNjWd3r3gOaDQg==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/6] syscalls/modify_ldt03: Refactor into new API
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
From: "Ricardo B. Marliere via ltp" <ltp@lists.linux.it>
Reply-To: rbm@suse.com
Cc: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KClNpZ25lZC1vZmYtYnk6
IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Ci0tLQogLi4uL2tlcm5lbC9zeXNj
YWxscy9tb2RpZnlfbGR0L21vZGlmeV9sZHQwMy5jICAgICAgfCAxMTggKysrKystLS0tLS0tLS0t
LS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwgOTQgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tb2RpZnlfbGR0L21vZGlm
eV9sZHQwMy5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tb2RpZnlfbGR0L21vZGlmeV9s
ZHQwMy5jCmluZGV4IDAxNzMwZTBlMTRhZTk4YTkzNGU3YjY2YzkwNTg0NTQ1MDZiYmUwNjQuLmFk
ZGM3ZDBlMGMyZWFlYzQ1NjRiOWEyMGJlMDVlOGYwNjM4YmQxNzUgMTAwNjQ0Ci0tLSBhL3Rlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvbW9kaWZ5X2xkdC9tb2RpZnlfbGR0MDMuYworKysgYi90ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL21vZGlmeV9sZHQvbW9kaWZ5X2xkdDAzLmMKQEAgLTEsMTA1
ICsxLDM1IEBACisvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgor
CiAvKgotICogQ29weXJpZ2h0IChjKSAyMDE0IEZ1aml0c3UgTHRkLgotICogQXV0aG9yOiBaZW5n
IExpbmdnYW5nIDx6ZW5nbGcuanlAY24uZnVqaXRzdS5jb20+Ci0gKgotICogVGhpcyBwcm9ncmFt
IGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkg
aXQKLSAqIHVuZGVyIHRoZSB0ZXJtcyBvZiB2ZXJzaW9uIDIgb2YgdGhlIEdOVSBHZW5lcmFsIFB1
YmxpYyBMaWNlbnNlIGFzCi0gKiBwdWJsaXNoZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRh
dGlvbi4KLSAqCi0gKiBUaGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhh
dCBpdCB3b3VsZCBiZSB1c2VmdWwsIGJ1dAotICogV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhv
dXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZgotICogTUVSQ0hBTlRBQklMSVRZIG9yIEZJ
VE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLgotICoKLSAqIFlvdSBzaG91bGQgaGF2ZSBy
ZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFsb25nCi0g
KiB3aXRoIHRoaXMgcHJvZ3JhbS4KLSAqLwotLyoKLSAqIERFU0NSSVBUSU9OCi0gKglCYXNpYyB0
ZXN0IGZvciBtb2RpZnlfbGR0KDIpIHVzaW5nIGZ1bmM9MCBhcmd1bWVudC4KKyAqIENvcHlyaWdo
dCAoYykgMjAxNCBGdWppdHN1IEx0ZC4gWmVuZyBMaW5nZ2FuZyA8emVuZ2xnLmp5QGNuLmZ1aml0
c3UuY29tPgorICogQ29weXJpZ2h0IChjKSAyMDI1IFNVU0UgTExDIFJpY2FyZG8gQi4gTWFybGnD
qHJlIDxyYm1Ac3VzZS5jb20+CiAgKi8KIAotI2luY2x1ZGUgImNvbmZpZy5oIgotI2luY2x1ZGUg
InRlc3QuaCIKLQotY2hhciAqVENJRCA9ICJtb2RpZnlfbGR0MDMiOwotaW50IFRTVF9UT1RBTCA9
IDE7Ci0KLSNpZiBkZWZpbmVkKF9faTM4Nl9fKSAmJiBkZWZpbmVkKEhBVkVfTU9ESUZZX0xEVCkK
LQotI2lmZGVmIEhBVkVfQVNNX0xEVF9ICi0jIGluY2x1ZGUgPGFzbS9sZHQuaD4KLSNlbmRpZgot
ZXh0ZXJuIGludCBtb2RpZnlfbGR0KGludCwgdm9pZCAqLCB1bnNpZ25lZCBsb25nKTsKLQotI2lu
Y2x1ZGUgPGFzbS91bmlzdGQuaD4KLSNpbmNsdWRlIDxzdHJpbmcuaD4KLSNpbmNsdWRlIDxzeXMv
d2FpdC5oPgotI2luY2x1ZGUgPGVycm5vLmg+Ci0jaW5jbHVkZSAic2FmZV9tYWNyb3MuaCIKLQot
I2lmZGVmIEhBVkVfU1RSVUNUX1VTRVJfREVTQwotIyBkZWZpbmUgU0laRSBzaXplb2Yoc3RydWN0
IHVzZXJfZGVzYykKLSNlbHNlCi0jIGRlZmluZSBTSVpFIDE2Ci0jZW5kaWYKLQotc3RhdGljIGNo
YXIgYnVmW1NJWkVdOwotc3RhdGljIHZvaWQgY2xlYW51cCh2b2lkKTsKLXN0YXRpYyB2b2lkIHNl
dHVwKHZvaWQpOwotCi1pbnQgbWFpbihpbnQgYWMsIGNoYXIgKiphdikKLXsKLQlpbnQgbGM7Ci0K
LQl0c3RfcGFyc2Vfb3B0cyhhYywgYXYsIE5VTEwsIE5VTEwpOwotCi0Jc2V0dXAoKTsKLQotCWZv
ciAobGMgPSAwOyBURVNUX0xPT1BJTkcobGMpOyBsYysrKSB7Ci0KLQkJdHN0X2NvdW50ID0gMDsK
LQotCQlURVNUKG1vZGlmeV9sZHQoMCwgYnVmLCBTSVpFKSk7Ci0KLQkJaWYgKFRFU1RfUkVUVVJO
IDwgMCkgewotCQkJdHN0X3Jlc20oVEZBSUwgfCBUVEVSUk5PLAotCQkJCSAibW9kaWZ5X2xkdCgp
IGZhaWxlZCB3aXRoIGVycm5vOiAlcyIsCi0JCQkJIHN0cmVycm9yKFRFU1RfRVJSTk8pKTsKLQkJ
fSBlbHNlIHsKLQkJCXRzdF9yZXNtKFRQQVNTLCAibW9kaWZ5X2xkdCgpIHRlc3RlZCBzdWNjZXNz
Iik7Ci0JCX0KLQl9CisvKlwKKyAqIFZlcmlmeSB0aGF0IGEgc2ltcGxlIHJlYWQgKGZ1bmM9MCkg
d29ya3Mgd2hlbiBjYWxsaW5nIG1vZGlmeV9sZHQuCisgKi8KIAotCWNsZWFudXAoKTsKLQl0c3Rf
ZXhpdCgpOwotfQorI2luY2x1ZGUgInRzdF90ZXN0LmgiCiAKLXN0YXRpYyB2b2lkIHNldHVwKHZv
aWQpCi17Ci0JdHN0X3NpZyhOT0ZPUkssIERFRl9IQU5ETEVSLCBjbGVhbnVwKTsKKyNpZmRlZiBf
X2kzODZfXworI2luY2x1ZGUgImxhcGkvbGR0LmgiCiAKLQlURVNUX1BBVVNFOwotfQorc3RhdGlj
IGNoYXIgKmJ1ZjsKIAotc3RhdGljIHZvaWQgY2xlYW51cCh2b2lkKQordm9pZCBydW4odm9pZCkK
IHsKKwlUU1RfRVhQX1BPU0lUSVZFKG1vZGlmeV9sZHQoMCwgYnVmLCBzaXplb2YoYnVmKSkpOwog
fQogCi0jZWxpZiBIQVZFX01PRElGWV9MRFQKK3N0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9
IHsKKwkudGVzdF9hbGwgPSBydW4sCisJLmJ1ZnMgPQorCQkoc3RydWN0IHRzdF9idWZmZXJzW10p
eworCQkJeyAmYnVmLCAuc2l6ZSA9IHNpemVvZihzdHJ1Y3QgdXNlcl9kZXNjKSB9LAorCQkJe30s
CisJCX0sCit9OwogCi1pbnQgbWFpbih2b2lkKQotewotCXRzdF9icmttKFRDT05GLAotCQkgTlVM
TCwgIm1vZGlmeV9sZHQgaXMgYXZhaWxhYmxlIGJ1dCBub3QgdGVzdGVkIG9uIHRoZSBwbGF0Zm9y
bSB0aGFuICIKLQkJICJfX2kzODZfXyIpOwotfQotCi0jZWxzZSAvKiBpZiBkZWZpbmVkKF9faTM4
Nl9fKSAqLwotCi1pbnQgbWFpbih2b2lkKQotewotCXRzdF9yZXNtKFRJTkZPLCAibW9kaWZ5X2xk
dDAzIHRlc3Qgb25seSBmb3IgaXg4NiIpOwotCXRzdF9leGl0KCk7Ci19Ci0KLSNlbmRpZiAvKiBp
ZiBkZWZpbmVkKF9faTM4Nl9fKSAqLworI2Vsc2UKK1RTVF9URVNUX1RDT05GKCJUZXN0IHN1cHBv
cnRlZCBvbmx5IG9uIGkzODYiKTsKKyNlbmRpZiAvKiBfX2kzODZfXyAqLwoKLS0gCjIuNDkuMAoK
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
