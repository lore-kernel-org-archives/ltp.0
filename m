Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A6CC021A4
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 18:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740423318; h=date :
 mime-version : message-id : references : in-reply-to : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=iQRVdXjr3y01EQrYf49ugywR/Xrr73WiekQwdB/476U=;
 b=b5bUj5lOGbmtz6UJrGjhG2/Uiw+qxGhJdzOYZO114lp9t0JL49g7QD9O4s8tFSicC211A
 cdyze9ANhIa/l0dvy/uyDUcjR4/eI+rkAIHfIumWmmDaxwcnncsEARXeU0AO3B0CyRNYeJF
 bQ8WcNvVIOEmhalPANuzNJBELn6whXQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A00733C9A02
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 19:55:18 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E190D3C9A18
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 19:53:28 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5C06E1BC9178
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 19:53:28 +0100 (CET)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-abb86beea8cso854253366b.1
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 10:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1740423208; x=1741028008; darn=lists.linux.it;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YgWRTzf0nHLmD5/2PvzaEM/oOylyrVtp01tqHhb/Hao=;
 b=Jg3HbZg1KOBWG3n30WYaMTZHHd7lG8GWYB2gFGpr04fMzhNYbhGn1sSVgWmuQ9OVXC
 8koBqn7MkJ6IAw+RbOcHPR3rnl8mJIUG59irWjUd2kCPMA2yKij7X6990O7PI4N2EWt5
 JrZVx7Fg09SOBTcz+7LdZnyg/mIl3u5Jubt+LTH0n87xMIMP/zGQklZu2aVfX6htMoxs
 nKwfecebOTcf7k0ZNaD669Gqko9wqXlmQZqWzpPyKHt0KDlfwzTWISXLLk/fHlNdZlg6
 w+4y+xd+yBSzze6mwqMxz6+Na7EPCs2w4G94Qn+fFodd8ftbkblXtNapESgL7Mr09XhV
 ewkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740423208; x=1741028008;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YgWRTzf0nHLmD5/2PvzaEM/oOylyrVtp01tqHhb/Hao=;
 b=YECGEItCN77cHt0ZljNn8UJ6LfFjuxVT9jSor9rhx5JEycnF1ZEjc+PaeNUp5062CU
 gFEBgPbRsbiy0QFrs0zCQSn1lfgkPqF2TBIfKBl/gBHejTAQdiaKidqtLbcomyxy2srn
 SFn/ONOyRxG9jjWg77y6O2nKx3dCn4VE6fkMvYe6pHZPPB1osmJ9BWqvav88yDm9kzfr
 t1HDuHOiCOvz16KJDUEQWjX2IXxOpPgDoN44rBVbZ9DQ+aQJt0Q+q9s1LiOkwWFa1RoX
 NW3DOipO9Dfdbwjt6KkiID23ULjpDY3Qk53TduwOnzDTobXXFj7JFA/xV2Lzi6cVDDUv
 dHQg==
X-Gm-Message-State: AOJu0YylLiA8icWXkYhk3b43yZskTm9tmq899nZluw1ZjKpzcL5dsopS
 4sNq4Pjpfoc3H8HD1mVxxfklVgFwBsMz3bo/NN9NASbKOTv0QMzPwL8Jwgnv6C8=
X-Gm-Gg: ASbGnctLBHKPHukw9QgUVDayV0F+o7x6zpbjjnF5175VTACOm9CBQSC/2tpdsyJTUgt
 O778gU2YXd9OHyEMrAo8P4i4uAjrBqyq86GjE37OaNjOQ7cXMO7a6VV6CtRpYI5sH4rvMp+uUTH
 FJ5vjolCU8DId6cptnRqnrIeHCYOhsi8NH2DA8IkvVqZ7r5x4PKQgx0UVPm3bjCc+E9rp57NbeN
 M8kAUuFevoBUFmmMFooKy0+89c1n5EVqukVD3j13O2o57Uj1PrKAWPMIxUVMbcbRZsHDkU5zGPG
 22NbrvTnFx3JKpM=
X-Google-Smtp-Source: AGHT+IG5tCG0aCmEjFlB4kOSBjAbptjhLsAmFSCfz4HKkB9Vmwvf6NIwBaPLoO2+tKVHUNQYrHM/WQ==
X-Received: by 2002:a17:906:3f86:b0:abb:b760:e2dc with SMTP id
 a640c23a62f3a-abc09ab56b0mr1231430366b.27.1740423207730; 
 Mon, 24 Feb 2025 10:53:27 -0800 (PST)
Received: from localhost ([179.228.215.131])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-220d55960ecsm182528365ad.253.2025.02.24.10.53.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 10:53:27 -0800 (PST)
Date: Mon, 24 Feb 2025 15:53:05 -0300
MIME-Version: 1.0
Message-Id: <20250224-conversions-pause-v3-4-5e3989d37f1d@suse.com>
References: <20250224-conversions-pause-v3-0-5e3989d37f1d@suse.com>
In-Reply-To: <20250224-conversions-pause-v3-0-5e3989d37f1d@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3803; i=rbm@suse.com;
 h=from:subject:message-id; bh=WPDL9r6G99IUsdiX9TI0TvMBSAQczSGrj6a5QmiqnJY=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBnvMARRVGbQB8iDeWaO5mg03WcWVZyzDUIxQsHc
 AoAV5KCejuJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ7zAEQAKCRDJC4p8Y4ZY
 poXwD/wIesYYfuTdTzLg8OpwRhj6IlmtXdqH3Ek6iDBHZEj/NRQep9Y+Ga03+bhyfK/BnJ8UWT+
 mzXpi/36M3J+uBOya0QfomCca9wJAX9kTjBDybJRpqlxeRP7OrBUjl/bktINm672BX+YDSeBfB8
 HuKXYXHTcpfvVfB4pCRt1fxx+M/pBj0Fh4ssx0S2A3N3cacfBM1F7BzEHQegNHM7rG5XUZFS3RZ
 xcZ/V4MJELaR0AZvp2ak04gorb+eNwDoocav0BPioskGK5qnCP7VK8qtPLWBi45JIoJDp5FUFTu
 jrgeo6ic0gnMa+RZ21R4b+Gzp6vzvoYGLmmzSnvW5/AHQcF1+0xpl8kdKt8GpqK5Ay5lsxSRQ6Y
 fvcJp9+c6Xx/myQF67LaQBcReGz0RnJ77DQrtxvgNl8P5mALmdkQWttAsqCTG2ULE348Zd2ASoC
 R8BJTUZyZ+e/6Ln72Jx6uK9SWLWEpy21/ORch4zu0BbdCDZeBIKeyKVec1IUSbz6swOYaUbg+Jr
 pJpnw3+has3WU27VrVcD0pVEncYu5PKBzaf0W6s/Yis2WYusBzmeZuCMP/HD6sGNtun3Grq2Lmi
 7pVLCA+Qg0C4KMfaCEbKQrhWlboJWUD4HzkVbxgSJtfy/+5H4anpylbpAkWRkmtXLmjfXbQ+3rz
 9z228qhU7ap88cw==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 4/5] syscalls/pause03: Refactor into new API
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
IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Ci0tLQogdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9wYXVzZS9wYXVzZTAzLmMgfCAxMjAgKysrKysrKystLS0tLS0tLS0tLS0tLS0t
LS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygrKSwgODkgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9wYXVzZS9wYXVzZTAzLmMg
Yi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3BhdXNlL3BhdXNlMDMuYwppbmRleCA0NTkyMjIw
NDVjMDhkYzFmYzQ4MDRlZmQyZWNlMDIzMTZmZTU1YTBlLi45ZDdmZWUxZTg5YmJiN2YzZGY1MmU5
MWI5MDQwZTNmYjJkOGQ5MTZhIDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L3BhdXNlL3BhdXNlMDMuYworKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3BhdXNlL3Bh
dXNlMDMuYwpAQCAtMSwxMDQgKzEsNDYgQEAKKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBH
UEwtMi4wLW9yLWxhdGVyCiAvKgogICogQ29weXJpZ2h0IChjKSBJbnRlcm5hdGlvbmFsIEJ1c2lu
ZXNzIE1hY2hpbmVzICBDb3JwLiwgMjAwMQotICogIDA3LzIwMDEgUG9ydGVkIGJ5IFdheW5lIEJv
eWVyCi0gKgotICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7ICB5b3UgY2FuIHJlZGlz
dHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5Ci0gKiBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdO
VSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieQotICogdGhlIEZyZWUgU29m
dHdhcmUgRm91bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24gMiBvZiB0aGUgTGljZW5zZSwgb3IKLSAq
IChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24uCi0gKgotICogVGhpcyBwcm9ncmFt
IGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsCi0gKiBi
dXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7ICB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFu
dHkgb2YKLSAqIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVS
UE9TRS4gIFNlZQotICogdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRl
dGFpbHMuCi0gKgotICogWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05V
IEdlbmVyYWwgUHVibGljIExpY2Vuc2UKLSAqIGFsb25nIHdpdGggdGhpcyBwcm9ncmFtOyAgaWYg
bm90LCB3cml0ZSB0byB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLAotICogSW5jLiwgNTEg
RnJhbmtsaW4gU3RyZWV0LCBGaWZ0aCBGbG9vciwgQm9zdG9uLCBNQSAwMjExMC0xMzAxIFVTQQor
ICogMDcvMjAwMSBQb3J0ZWQgYnkgV2F5bmUgQm95ZXIKKyAqIENvcHlyaWdodCAoYykgMjAyNSBS
aWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgogICovCi0vKgotICogVGVzdCBEZXNj
cmlwdGlvbjoKLSAqICBwYXVzZSgpIGRvZXMgbm90IHJldHVybiBkdWUgdG8gcmVjZWlwdCBvZiBT
SUdLSUxMIHNpZ25hbCBhbmQgc3BlY2lmaWVkCi0gKiAgcHJvY2VzcyBzaG91bGQgYmUgdGVybWlu
YXRlZC4KLSAqLwotI2luY2x1ZGUgPHVuaXN0ZC5oPgotI2luY2x1ZGUgPGVycm5vLmg+Ci0jaW5j
bHVkZSA8ZmNudGwuaD4KLSNpbmNsdWRlIDxzeXMvd2FpdC5oPgotCi0jaW5jbHVkZSAidGVzdC5o
IgotI2luY2x1ZGUgInNhZmVfbWFjcm9zLmgiCi0KLXN0YXRpYyBwaWRfdCBjcGlkOwotCi1jaGFy
ICpUQ0lEID0gInBhdXNlMDMiOwotaW50IFRTVF9UT1RBTCA9IDE7Ci0KLXN0YXRpYyB2b2lkIGRv
X2NoaWxkKHZvaWQpOwotc3RhdGljIHZvaWQgc2V0dXAodm9pZCk7Ci1zdGF0aWMgdm9pZCBjbGVh
bnVwKHZvaWQpOwotCi1pbnQgbWFpbihpbnQgYWMsIGNoYXIgKiphdikKLXsKLQlpbnQgbGM7Ci0J
aW50IHN0YXR1czsKLQotCXRzdF9wYXJzZV9vcHRzKGFjLCBhdiwgTlVMTCwgTlVMTCk7Ci0KLQlz
ZXR1cCgpOwotCi0JZm9yIChsYyA9IDA7IFRFU1RfTE9PUElORyhsYyk7IGxjKyspIHsKLQkJdHN0
X2NvdW50ID0gMDsKLQotCQlpZiAoKGNwaWQgPSB0c3RfZm9yaygpKSA9PSAtMSkKLQkJCXRzdF9i
cmttKFRCUk9LIHwgVEVSUk5PLCBOVUxMLCAiZm9yaygpIGZhaWxlZCIpOwotCi0JCWlmIChjcGlk
ID09IDApCi0JCQlkb19jaGlsZCgpOwotCi0JCVRTVF9QUk9DRVNTX1NUQVRFX1dBSVQoY2xlYW51
cCwgY3BpZCwgJ1MnKTsKIAotCQlraWxsKGNwaWQsIFNJR0tJTEwpOwotCi0JCVNBRkVfV0FJVChO
VUxMLCAmc3RhdHVzKTsKLQotCQlpZiAoV0lGU0lHTkFMRUQoc3RhdHVzKSAmJiBXVEVSTVNJRyhz
dGF0dXMpID09IFNJR0tJTEwpIHsKLQkJCXRzdF9yZXNtKFRQQVNTLCAicGF1c2UoKSBkaWQgbm90
IHJldHVybiBhZnRlciBTSUdLSUxMIik7Ci0JCQljb250aW51ZTsKLQkJfQotCi0JCWlmIChXSUZT
SUdOQUxFRChzdGF0dXMpKSB7Ci0JCQl0c3RfcmVzbShURkFJTCwgImNoaWxkIGtpbGxlZCBieSAl
cyB1bmV4cGVjdGVkbHkiLAotCQkJICAgICAgICAgdHN0X3N0cnNpZyhXVEVSTVNJRyhzdGF0dXMp
KSk7Ci0JCQljb250aW51ZTsKLQkJfQotCi0JCXRzdF9yZXNtKFRGQUlMLCAiY2hpbGQgZXhpdGVk
IHdpdGggJWkiLCBXRVhJVFNUQVRVUyhzdGF0dXMpKTsKLQl9Ci0KLQljbGVhbnVwKCk7Ci0JdHN0
X2V4aXQoKTsKKy8qXAorICogVmVyaWZpZXMgdGhhdCBwYXVzZSgpIGRvZXMgbm90IHJldHVybiBh
ZnRlciBwcm9jY2VzcyByZWNlaXZlcyBhIFNJR0tJTEwgc2lnbmFsLgorICovCiAKLX0KKyNpbmNs
dWRlICJ0c3RfdGVzdC5oIgogCiB2b2lkIGRvX2NoaWxkKHZvaWQpCiB7Ci0JVEVTVChwYXVzZSgp
KTsKLQotCXRzdF9yZXNtKFRGQUlMLCAiVW5leHBlY3RlZCByZXR1cm4gZnJvbSBwYXVzZSgpIik7
Ci0KLQlleGl0KDApOworCVRTVF9DSEVDS1BPSU5UX1dBS0UoMCk7CisJVFNUX0VYUF9QQVNTKHBh
dXNlKCkpOwogfQogCi12b2lkIHNldHVwKHZvaWQpCit2b2lkIHJ1bih2b2lkKQogewotCXRzdF9z
aWcoRk9SSywgREVGX0hBTkRMRVIsIGNsZWFudXApOworCWludCBzdGF0dXM7CisJcGlkX3QgcGlk
OwogCi0JVEVTVF9QQVVTRTsKLX0KKwlwaWQgPSBTQUZFX0ZPUksoKTsKKwlpZiAoIXBpZCkgewor
CQlkb19jaGlsZCgpOworCQlleGl0KDApOworCX0KIAorCVRTVF9DSEVDS1BPSU5UX1dBSVQoMCk7
CisJVFNUX1BST0NFU1NfU1RBVEVfV0FJVChwaWQsICdTJywgMTAwMDApOworCVNBRkVfS0lMTChw
aWQsIFNJR0tJTEwpOworCVNBRkVfV0FJVFBJRChwaWQsICZzdGF0dXMsIDApOwogCi12b2lkIGNs
ZWFudXAodm9pZCkKLXsKLQlraWxsKGNwaWQsIFNJR0tJTEwpOworCWlmIChXSUZTSUdOQUxFRChz
dGF0dXMpICYmIFdURVJNU0lHKHN0YXR1cykgPT0gU0lHS0lMTCkKKwkJdHN0X3JlcyhUUEFTUywg
InBhdXNlKCkgZGlkIG5vdCByZXR1cm4gYWZ0ZXIgU0lHS0lMTCIpOworCWVsc2UKKwkJdHN0X3Jl
cyhURkFJTCwgIkNoaWxkICVzIiwgdHN0X3N0cnN0YXR1cyhzdGF0dXMpKTsKIH0KKworc3RhdGlj
IHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0geworCS50ZXN0X2FsbCA9IHJ1biwKKwkubmVlZHNfY2hl
Y2twb2ludHMgPSAxLAorCS5mb3Jrc19jaGlsZCA9IDEsCit9OwoKLS0gCjIuNDguMQoKCi0tIApN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
