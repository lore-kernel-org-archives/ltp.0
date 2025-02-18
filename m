Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51AAAC021AA
	for <ltp@archiver.kernel.org>; Tue, 18 Feb 2025 18:09:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C3A783C1D37
	for <ltp@archiver.kernel.org>; Tue, 18 Feb 2025 19:09:07 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 292C13C2355
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 19:08:01 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DD05422BDDC
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 19:07:59 +0100 (CET)
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21f2339dcfdso717725ad.1
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 10:07:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739902078; x=1740506878;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:dkim-signature:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bh3pZfyd149hWOXALIHauvevsYTm513KReq53AoI9w8=;
 b=pxVbdFmKOiN+JyNI9B/V1LpCldcXDoqjkDUIXVmKyBat8F6WL+x1vRV6ffubnr0lgc
 AOElePLJmLEf292kZ9djB5ch9cpcTzYvCBXMK1G3L9mpp/CGHUkTS5WyTWfz5H+eYFLG
 CgANmiklH1VthmqhO+R3WZIrkI3POaKXwuueaocIuwnW4hXFTKQqNnSrwYog5R2UnayD
 pIAMs0GO1RGPQDJgShxaQxz6goobxl1R9B625Njw+dc/SFvVCJ6gElSNkYfOSOO8ttpG
 I64mbKNUDDVNhsSK6XI1lMSWGxwJ5c4oq4eJEpOUY5U/cLqCksZ6PjgZTsc93bjFls6U
 5UDw==
X-Gm-Message-State: AOJu0Yz2jVGbquzzPh49ZshoGRq8Yt6+4tR2OEd3TblUXlsiwJTEKUkR
 Fjz5sLlGblbQmTuaHcmsaUtRihrz5Ec5xVkeJd2teMRbMORoXrMKaBqnD9nb
X-Gm-Gg: ASbGncutFS32ngN26xbymbcZcLHgHH8qPO6LYYqRP56Nj/OlOPz2RvfZkkgEUKB054W
 MptXRICT78DX9K2t9bpEXcK4TlFHEb3fGYpt6yPmAwmGmmR8BI0SGSS3o+KWapcXHWsxZ/87UL5
 CfpesdUTSd1a3tsFdArpuhMQiMd7Tbw6TLwHd1zb6UbsLgzyNW9NTy5Gu5pCN6nPGFJYS6NYIW5
 2ty3WoUdlKGjDqBHdOpwqo7bQPaSrQLkaNUPaJqg1Whw21iFtg++7+np9UzW5vK64QuTmXaw2eN
 K7mPqSxX6EdyYgLjaKVgmgfXLeJe+eFv
X-Google-Smtp-Source: AGHT+IGvPbENdOyw3MqiDeIFHvl2N6xdvmSqKHNSAITew9byCFLOzlVdApNTJOg2Jt4uJFo5c0ZbmA==
X-Received: by 2002:a17:902:e552:b0:21f:53a5:19e0 with SMTP id
 d9443c01a7336-2216eeaf5a8mr9348515ad.12.1739902077871; 
 Tue, 18 Feb 2025 10:07:57 -0800 (PST)
Received: from mail.marliere.net (marliere.net. [24.199.118.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2210005641dsm63393365ad.210.2025.02.18.10.07.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 10:07:57 -0800 (PST)
From: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
 s=2025; t=1739902076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bh3pZfyd149hWOXALIHauvevsYTm513KReq53AoI9w8=;
 b=ln0VzjkrG8ersZmnzQbbqcWfil5dGxEFBR/fNzHsrLHQqiZstd+YEvUcUmb7+v4VdA9WLU
 E5duFa2/VMgjeu3OY7kWFwmiBcflPPsrc2N6H+bAIPLp6sZlixrYA/797f9a5648DSQTB+
 X9Z0+RjkiSUP6DnMIoRn+w3wW2TSLhtZJhZyl1FqLM15bGVw1J4yhTWkkPWuHdU1WpuCat
 5OJ0G7kkhXnLHKqsuWQNVx4mjBXt7gcodcOLWE/4NQvTXId2hNXZRJYRyZpTrk8Er/LLr5
 AqKSZAgf4Y8PD9bsnkApjidtT2vNJhUrFpl6ciCu62vWckM6kslEVzHHshIJXw==
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 18 Feb 2025 15:07:19 -0300
MIME-Version: 1.0
Message-Id: <20250218-conversions-pause-v2-3-8c72960fe1ec@suse.com>
References: <20250218-conversions-pause-v2-0-8c72960fe1ec@suse.com>
In-Reply-To: <20250218-conversions-pause-v2-0-8c72960fe1ec@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3749; i=rbm@suse.com;
 h=from:subject:message-id; bh=JRU4WMTzZdSmfgmtZO2PPjXquz9aDzJ5VT+talexNDc=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBntMxswFnK7xokTKf/FAPT/kj6BGNTS0HJCe8G3
 cpcmkGqRI+JAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ7TMbAAKCRDJC4p8Y4ZY
 pso7D/46V6SLtJDUk+jeY25F4bKMQR/t/Pbmjew4uyzOuhRuaR3P9e9YZcCy50D1/8HgGMVLCo5
 6q/7CS8wh78vh+Q4E1BZjEBAUfhH16H7UykAe3jPU076L9inCoglY7Arwx0sv1fWL1YlYtk5L1v
 GDU8EXR5oiUKHX5xRXOW+BmKLOv/OmQIDbopf2qASOM/WcolkIGVdqZt2d2u+wjhqPS3lLhltIs
 lZ4OFtRrbW3HwKB6AF2x9y5OnKesvXiYGZQxWMCt8ToSlveIYaf5JypGRP/algntSSkUJ6EMyqf
 wA7gZn/Qg1N8fOKKyHWVnyR7GpUc4IZ7JMlX53TtogWuK+I/v7nsLx0TJslLFhWO/eE53Zu+Z72
 Yqqbg0cGRaveh3wMReajdADL7QPJ9DCTsGeh7ekO4JAE8TNo91cc6Pvhmv2t6Zv0ikQ93eKzVUJ
 wIRAsbMdIJQTidU2gGg33/pU5t4B13BnMLk2nGFs0xhJjNllVcBH0ErQO2+aH4d8ncvhIVJSZq+
 vv57bYJapm7PBen/RTrkumRJQI+1vyqkhxOF/UpxgPnEIsFC67FcwMjNb5yFugVUeNSWNhfGyu0
 9TfYNBaI9IdrQxFsl1PPBieCqjwAUtKmG9O4xrfm7Hndywtze3D3GA8vcaEE0TN1WAbJAWDcsc2
 qtFQoS//S2YqKmQ==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/3] syscalls/pause03: Refactor into new API
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
Cc: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KClNpZ25lZC1vZmYtYnk6
IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Ci0tLQogdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9wYXVzZS9wYXVzZTAzLmMgfCAxMTUgKysrKysrKy0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgOTAgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9wYXVzZS9wYXVzZTAzLmMg
Yi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3BhdXNlL3BhdXNlMDMuYwppbmRleCA0NTkyMjIw
NDVjMDhkYzFmYzQ4MDRlZmQyZWNlMDIzMTZmZTU1YTBlLi44NWMzYzE4YjE5ZDYzMzQzYzY1ZmE1
NTNhNjVlY2I2ZjlmMGMwNzAwIDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L3BhdXNlL3BhdXNlMDMuYworKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3BhdXNlL3Bh
dXNlMDMuYwpAQCAtMSwxMDQgKzEsMzkgQEAKKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBH
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
IgotI2luY2x1ZGUgInNhZmVfbWFjcm9zLmgiCi0KLXN0YXRpYyBwaWRfdCBjcGlkOwogCi1jaGFy
ICpUQ0lEID0gInBhdXNlMDMiOwotaW50IFRTVF9UT1RBTCA9IDE7CisvKlwKKyAqIFRoaXMgdGVz
dCB2ZXJpZmllcyB0aGF0IHBhdXNlKCkgZG9lcyBub3QgcmV0dXJuIGFmdGVyIHJlY2VpdmluZyBh
IFNJR0tJTEwKKyAqIHNpZ25hbCwgYXQgd2hpY2ggcG9pbnQgdGhlIHByb2Nlc3Mgc2hvdWxkIGJl
IHRlcm1pbmF0ZWQuCisgKi8KIAotc3RhdGljIHZvaWQgZG9fY2hpbGQodm9pZCk7Ci1zdGF0aWMg
dm9pZCBzZXR1cCh2b2lkKTsKLXN0YXRpYyB2b2lkIGNsZWFudXAodm9pZCk7CisjaW5jbHVkZSAi
dHN0X3Rlc3QuaCIKIAotaW50IG1haW4oaW50IGFjLCBjaGFyICoqYXYpCit2b2lkIHJ1bih2b2lk
KQogewotCWludCBsYzsKIAlpbnQgc3RhdHVzOworCXBpZF90IHBpZDsKIAotCXRzdF9wYXJzZV9v
cHRzKGFjLCBhdiwgTlVMTCwgTlVMTCk7Ci0KLQlzZXR1cCgpOwotCi0JZm9yIChsYyA9IDA7IFRF
U1RfTE9PUElORyhsYyk7IGxjKyspIHsKLQkJdHN0X2NvdW50ID0gMDsKLQotCQlpZiAoKGNwaWQg
PSB0c3RfZm9yaygpKSA9PSAtMSkKLQkJCXRzdF9icmttKFRCUk9LIHwgVEVSUk5PLCBOVUxMLCAi
Zm9yaygpIGZhaWxlZCIpOwotCi0JCWlmIChjcGlkID09IDApCi0JCQlkb19jaGlsZCgpOwotCi0J
CVRTVF9QUk9DRVNTX1NUQVRFX1dBSVQoY2xlYW51cCwgY3BpZCwgJ1MnKTsKLQotCQlraWxsKGNw
aWQsIFNJR0tJTEwpOwotCi0JCVNBRkVfV0FJVChOVUxMLCAmc3RhdHVzKTsKLQotCQlpZiAoV0lG
U0lHTkFMRUQoc3RhdHVzKSAmJiBXVEVSTVNJRyhzdGF0dXMpID09IFNJR0tJTEwpIHsKLQkJCXRz
dF9yZXNtKFRQQVNTLCAicGF1c2UoKSBkaWQgbm90IHJldHVybiBhZnRlciBTSUdLSUxMIik7Ci0J
CQljb250aW51ZTsKLQkJfQotCi0JCWlmIChXSUZTSUdOQUxFRChzdGF0dXMpKSB7Ci0JCQl0c3Rf
cmVzbShURkFJTCwgImNoaWxkIGtpbGxlZCBieSAlcyB1bmV4cGVjdGVkbHkiLAotCQkJICAgICAg
ICAgdHN0X3N0cnNpZyhXVEVSTVNJRyhzdGF0dXMpKSk7Ci0JCQljb250aW51ZTsKLQkJfQotCi0J
CXRzdF9yZXNtKFRGQUlMLCAiY2hpbGQgZXhpdGVkIHdpdGggJWkiLCBXRVhJVFNUQVRVUyhzdGF0
dXMpKTsKKwlwaWQgPSBTQUZFX0ZPUksoKTsKKwlpZiAoIXBpZCkgeworCQlUU1RfRVhQX1BBU1Mo
cGF1c2UoKSk7CisJCWV4aXQoMCk7CiAJfQogCi0JY2xlYW51cCgpOwotCXRzdF9leGl0KCk7CisJ
VFNUX1BST0NFU1NfU1RBVEVfV0FJVChwaWQsICdTJywgMTAwMDApOworCVNBRkVfS0lMTChwaWQs
IFNJR0lOVCk7CisJU0FGRV9XQUlUUElEKHBpZCwgJnN0YXR1cywgMCk7CiAKKwlpZiAoV0lGU0lH
TkFMRUQoc3RhdHVzKSAmJiBXVEVSTVNJRyhzdGF0dXMpID09IFNJR0tJTEwpCisJCXRzdF9yZXMo
VFBBU1MsICJwYXVzZSgpIGRpZCBub3QgcmV0dXJuIGFmdGVyIFNJR0tJTEwiKTsKKwllbHNlCisJ
CXRzdF9yZXMoVEZBSUwsICJDaGlsZCBleGl0ZWQgd2l0aCAlaSIsIFdFWElUU1RBVFVTKHN0YXR1
cykpOwogfQogCi12b2lkIGRvX2NoaWxkKHZvaWQpCi17Ci0JVEVTVChwYXVzZSgpKTsKLQotCXRz
dF9yZXNtKFRGQUlMLCAiVW5leHBlY3RlZCByZXR1cm4gZnJvbSBwYXVzZSgpIik7Ci0KLQlleGl0
KDApOwotfQotCi12b2lkIHNldHVwKHZvaWQpCi17Ci0JdHN0X3NpZyhGT1JLLCBERUZfSEFORExF
UiwgY2xlYW51cCk7Ci0KLQlURVNUX1BBVVNFOwotfQotCi0KLXZvaWQgY2xlYW51cCh2b2lkKQot
ewotCWtpbGwoY3BpZCwgU0lHS0lMTCk7Ci19CitzdGF0aWMgc3RydWN0IHRzdF90ZXN0IHRlc3Qg
PSB7CisJLnRlc3RfYWxsID0gcnVuLAorCS5mb3Jrc19jaGlsZCA9IDEsCit9OwoKLS0gCjIuNDgu
MQoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5m
by9sdHAK
