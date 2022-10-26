Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3913C38A2D
	for <ltp@archiver.kernel.org>; Wed, 26 Oct 2022 14:10:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9E4883CA610
	for <ltp@archiver.kernel.org>; Wed, 26 Oct 2022 16:10:24 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 507B93C9E2C
 for <ltp@lists.linux.it>; Wed, 26 Oct 2022 16:10:09 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 88AC31A00CA3
 for <ltp@lists.linux.it>; Wed, 26 Oct 2022 16:10:08 +0200 (CEST)
Received: by mail-ed1-x536.google.com with SMTP id b12so41734180edd.6
 for <ltp@lists.linux.it>; Wed, 26 Oct 2022 07:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gbiHaAOwY+Q0Gqfx2FE1yrv6Val48l4D+3f81SY4DKU=;
 b=Lsb+NlXJhi6FbBq26LtH5REpRNizl8v2ohAlIyn3uNzmYtzIdQMgLFf6kPlZ7WmIqu
 yhBr6RqmfTXesFPZfGKBTI/Mge4m6b2N1I67Ve69PoztAGI73vwTmwuNdOVsTe0dL1yW
 Rv8jLVJtYIUd3lxQ5aw93+Uxv+eo1fCp/xHv3AcEznpKHUh+kn+zqSBXRvyvLQn6gbsT
 N/lVQy0Iz3/JTg9NMM/eyG+uWqTiDO8XMf8LtPYJ4OQrHhFUSMPe2WZJhMtBfn7zn6Jn
 NR2dHsoOSTCxzZ+YtKHLMO5+vjK2MtKmnpv23OkwLri9peWaP4jbC57pm7nSxrbqhmej
 OHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gbiHaAOwY+Q0Gqfx2FE1yrv6Val48l4D+3f81SY4DKU=;
 b=wbNCyAcd4TYrIizOhsEuDcN1IExrkCehkm7PaiHKFJmDKA00oKgLXx36c3WyEHKv5p
 L+qwfwynFLEHs+3Qwu7zsFoCb1QlUZ2E0GRBGVi0Dh+E3ndWvQCPNwGaNbTNZDbUGE++
 x/7rGXb8p0YHn9m0iRV40YV2GqGTNUElwk3h2kaJtiGrSz6o+NTrqm1z5GIPuJZF3ERZ
 sDlh2mN4SB7XoiCS//tWVx+bUNA2sMujj8hpB4ni6XzqNQdKtf7IYPvPqwVRrnJacODP
 hrfZ2b+5xU9/DZv6J/Io3SmR/7jdxmLxNGd0TAXHGNuPRgyFBr/yhdw6Pv5EyT5hzcqj
 HuqA==
X-Gm-Message-State: ACrzQf0+9Fp02V+KlRzbdzl52qvJ3O9n1Wj270T/elNwruVnK4f0n+Ww
 dU7QWGOCQYdaSb9Z0hsN/S8RnaHSW+hFsQ==
X-Google-Smtp-Source: AMsMyM5G5BpO0PzuA+w6EmGuejSI8WTGXzcEhIvKjtbpdoPMQIsfEbRJAikR1zTgDOXT1GjMPXOvFg==
X-Received: by 2002:a05:6402:d06:b0:45a:3ac6:ad26 with SMTP id
 eb6-20020a0564020d0600b0045a3ac6ad26mr41542451edb.195.1666793407701; 
 Wed, 26 Oct 2022 07:10:07 -0700 (PDT)
Received: from lab.hqhome163.com ([194.183.10.152])
 by smtp.googlemail.com with ESMTPSA id
 ka3-20020a170907990300b0073cd7cc2c81sm3022156ejc.181.2022.10.26.07.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Oct 2022 07:10:07 -0700 (PDT)
From: Alessandro Carminati <alessandro.carminati@gmail.com>
To: ltp@lists.linux.it
Date: Wed, 26 Oct 2022 14:04:07 +0000
Message-Id: <20221026140408.471609-2-alessandro.carminati@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221026140408.471609-1-alessandro.carminati@gmail.com>
References: <[LTP] [PATCH] Fix tst_find_backing_dev when no initramfs>
 <20221026140408.471609-1-alessandro.carminati@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] tst_find_backing_dev: Get dev name from
 /sys/dev/block/*/uevent
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
Cc: Alessandro Carminati <alessandro.carminati@gmail.com>, rpalethorpe@suse.com,
 acarmina@redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SW4gc29tZSBtaW5pbWFsIExpbnV4IHRoZSAvZGV2L3Jvb3QgY2FuIGJlIG1pc3NpbmcuIFRoZSBj
b25zZXF1ZW5jZSBmb3IgdGhpcwppcyB0aGF0IG1vdW50aW5mbyBkb2Vzbid0IGNvbnRhaW4gdGhl
IGNvcnJlY3QgaW5mb3JtYXRpb24uCgpUaGUgdW5ldmVudCBmaWxlIGluIHN5c2ZzIGlzIGFub3Ro
ZXIgbWV0aG9kIHRvIHJldHJpZXZlIGRldmljZSBpbmZvIGdpdmVuwqAKYSBtYWpvci9taW5vci4K
CmJ0cmZzIHN1YnZvbHVtZXMgY2FuIGJlIGFuIGV4Y2VwdGlvbiB0byB0aGlzIHJ1bGUsIGJ1dCB0
aGV5IGFyZSBub3QgZXhwZWN0ZWQKdG8gYmUgdXNlZCBpbiB0aGUgY3VycmVudCB1c2VjYXNlLgoK
VGhpcyBzb2x1dGlvbiByZXF1aXJlcyBzeXNmcyB0byBiZSBtb3VudGVkIGluIC9zeXMsIGJ1dCBj
b25zaWRlcmluZyBtYW55wqAKdGVzdHMgZGVwZW5kcyBvbiB0aGUgc2FtZSwgaW5jbHVkaW5nIHRo
ZSBpb2N0bF9sb29wMDUgdGhhdCB0cmlnZ2VyZWQgdGhpc8KgCnBhdGNoLCB0aGlzIHJlcXVpcmVt
ZW50IGlzIG5vdCB0b28gcmVzdHJpY3RlZCwgYW5kIHRoZSBvbGQgbW91bnRpbmZvIGNhbiBiZcKg
CmRyb3BwZWQgYWx0b2dldGhlci4KCiQgc3VkbyAvdXNyL2xpYi9sdHAtdGVzdHN1aXRlL3Rlc3Rj
YXNlcy9iaW4vaW9jdGxfbG9vcDA1CnRzdF90ZXN0LmM6MTM2MzogVElORk86IFRpbWVvdXQgcGVy
IHJ1biBpcyAwaCAwNW0gMDBzCnRzdF90ZXN0LmM6MTExNTogVElORk86IGV4dDIvZXh0My9leHQ0
IGlzIHN1cHBvcnRlZCBieSB0aGUgdGVzdAp0c3RfZGV2aWNlLmM6OTE6IFRJTkZPOiBGb3VuZCBm
cmVlIGRldmljZSAwICcvZGV2L2xvb3AwJwpsb29wMDogZGV0ZWN0ZWQgY2FwYWNpdHkgY2hhbmdl
IGZyb20gMCB0byAyMDQ4CnRzdF9kZXZpY2UuYzo1NzA6IFRJTkZPOiBEZXZpY2UgbmFtZSByZXRy
aXZlZCB0aHJvdWdoIG1vdW50aW5mbwppb2N0bF9sb29wMDUuYzoxMjY6IFRJTkZPOiBiYWNraW5n
IGRldigvZGV2L3Jvb3QpIGxvZ2ljYWxfYmxvY2tfc2l6ZSBpcyA1MTIKaW9jdGxfbG9vcDA1LmM6
NjI6IFRJTkZPOiBXaXRob3V0IHNldHRpbmcgbG9fb2Zmc2V0IG9yIHNpemVsaW1pdAppb2N0bF9s
b29wMDUuYzo0NTogVElORk86IEluIGRpbyBtb2RlCmlvY3RsX2xvb3AwNS5jOjQ4OiBUUEFTUzog
bG9fZmxhZ3MgaGFzIExPX0ZMQUdTX0RJUkVDVF9JTyBmbGFnCmlvY3RsX2xvb3AwNS5jOjUyOiBU
QlJPSzogRmFpbGVkIHRvIG9wZW4gRklMRSAnL3N5cy9ibG9jay9sb29wMC9sb29wL2RpbycgZm9y
IHJlYWRpbmc6IEVOT0VOVCAoMikKClN1bW1hcnk6CnBhc3NlZCAgIDEKZmFpbGVkICAgMApicm9r
ZW4gICAxCnNraXBwZWQgIDAKd2FybmluZ3MgMAoKVGhlIGV4YW1wbGUgaGVyZSBzaG93cyB3aGF0
IGhhcHBlbiBpZiBzeXNmcyBpcyBub3QgbW91bnRlZCBhbmQgdGhlCm1vdW50aW5mbyBtZXRob2Qg
aXMgdXNlZDogdGhlIHRlc3RzIHRoYXQgZGVwZW5kcyBvbiBzeXNmcyBmYWlsIHdpdGgKYnJva2Vu
IGFuZCBub3QganVzdCB3YXJuLgoKU2lnbmVkLW9mZi1ieTogUmljaGFyZCBQYWxldGhvcnBlIDxy
cGFsZXRob3JwZUBzdXNlLmNvbT4KU2lnbmVkLW9mZi1ieTogQWxlc3NhbmRybyBDYXJtaW5hdGkg
PGFsZXNzYW5kcm8uY2FybWluYXRpQGdtYWlsLmNvbT4KLS0tCiBsaWIvdHN0X2RldmljZS5jIHwg
NDEgKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFu
Z2VkLCAxMCBpbnNlcnRpb25zKCspLCAzMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9saWIv
dHN0X2RldmljZS5jIGIvbGliL3RzdF9kZXZpY2UuYwppbmRleCA4NDE5YjgwYzMuLjRjY2I3MWFj
OCAxMDA2NDQKLS0tIGEvbGliL3RzdF9kZXZpY2UuYworKysgYi9saWIvdHN0X2RldmljZS5jCkBA
IC01MjAsNDggKzUyMCwyNyBAQCB2b2lkIHRzdF9maW5kX2JhY2tpbmdfZGV2KGNvbnN0IGNoYXIg
KnBhdGgsIGNoYXIgKmRldikKIHsKIAlzdHJ1Y3Qgc3RhdCBidWY7CiAJRklMRSAqZmlsZTsKLQlj
aGFyIGxpbmVbUEFUSF9NQVhdOwotCWNoYXIgKnByZSA9IE5VTEw7Ci0JY2hhciAqbmV4dCA9IE5V
TEw7Ci0JdW5zaWduZWQgaW50IGRldl9tYWpvciwgZGV2X21pbm9yLCBsaW5lX21qciwgbGluZV9t
bnI7Ci0JdW5zaWduZWQgaW50IGxlbiwgYmVzdF9tYXRjaF9sZW4gPSAxOwotCWNoYXIgbW50X3Bv
aW50W1BBVEhfTUFYXTsKKwl1bnNpZ25lZCBpbnQgZGV2X21ham9yLCBkZXZfbWlub3I7CisJY2hh
ciB1ZXZlbnRfcGF0aFtQQVRIX01BWF07CisJY2hhciBkZXZfbmFtZVtOQU1FX01BWF07CiAKIAlp
ZiAoc3RhdChwYXRoLCAmYnVmKSA8IDApCiAJCXRzdF9icmttKFRXQVJOIHwgVEVSUk5PLCBOVUxM
LCAic3RhdCgpIGZhaWxlZCIpOwogCisJKmRldiA9ICdcMCc7CiAJZGV2X21ham9yID0gbWFqb3Io
YnVmLnN0X2Rldik7CiAJZGV2X21pbm9yID0gbWlub3IoYnVmLnN0X2Rldik7Ci0JZmlsZSA9IFNB
RkVfRk9QRU4oTlVMTCwgIi9wcm9jL3NlbGYvbW91bnRpbmZvIiwgInIiKTsKLQkqZGV2ID0gJ1ww
JzsKLQotCXdoaWxlIChmZ2V0cyhsaW5lLCBzaXplb2YobGluZSksIGZpbGUpKSB7Ci0JCWlmIChz
c2NhbmYobGluZSwgIiUqZCAlKmQgJWQ6JWQgJSpzICVzIiwKLQkJCSZsaW5lX21qciwgJmxpbmVf
bW5yLCBtbnRfcG9pbnQpICE9IDMpCi0JCQljb250aW51ZTsKIAotCQlwcmUgPSBzdHJzdHIobGlu
ZSwgIiAtICIpOwotCQlwcmUgPSBzdHJ0b2tfcihwcmUsICIgIiwgJm5leHQpOwotCQlwcmUgPSBz
dHJ0b2tfcihOVUxMLCAiICIsICZuZXh0KTsKLQkJcHJlID0gc3RydG9rX3IoTlVMTCwgIiAiLCAm
bmV4dCk7CisJc3ByaW50Zih1ZXZlbnRfcGF0aCwKKwkJIi9zeXMvZGV2L2Jsb2NrLyVkOiVkL3Vl
dmVudCIsIGRldl9tYWpvciwgZGV2X21pbm9yKTsKIAotCQlpZiAobGluZV9tanIgPT0gZGV2X21h
am9yICYmIGxpbmVfbW5yID09IGRldl9taW5vcikgewotCQkJc3RyY3B5KGRldiwgcHJlKTsKLQkJ
CWJyZWFrOwotCQl9CisJaWYgKCFhY2Nlc3ModWV2ZW50X3BhdGgsIFJfT0spKSB7CisJCUZJTEVf
TElORVNfU0NBTkYoTlVMTCwgdWV2ZW50X3BhdGgsICJERVZOQU1FPSVzIiwgZGV2X25hbWUpOwog
Ci0JCWxlbiA9IGNvdW50X21hdGNoX2xlbihwYXRoLCBtbnRfcG9pbnQpOwotCQlpZiAobGVuID4g
YmVzdF9tYXRjaF9sZW4pIHsKLQkJCXN0cmNweShkZXYsIHByZSk7Ci0JCQliZXN0X21hdGNoX2xl
biA9IGxlbjsKLQkJfQorCQlpZiAoZGV2X25hbWVbMF0pCisJCQlzcHJpbnRmKGRldiwgIi9kZXYv
JXMiLCBkZXZfbmFtZSk7CiAJfQogCi0JU0FGRV9GQ0xPU0UoTlVMTCwgZmlsZSk7Ci0KLQlpZiAo
ISpkZXYpCi0JCXRzdF9icmttKFRCUk9LLCBOVUxMLCAiQ2Fubm90IGZpbmQgYmxvY2sgZGV2aWNl
IGZvciAlcyIsIHBhdGgpOwotCiAJaWYgKHN0YXQoZGV2LCAmYnVmKSA8IDApCiAJCXRzdF9icmtt
KFRXQVJOIHwgVEVSUk5PLCBOVUxMLCAic3RhdCglcykgZmFpbGVkIiwgZGV2KTsKIAotLSAKMi4z
NC4xCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
