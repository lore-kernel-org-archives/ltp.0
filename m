Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16890C8302F
	for <ltp@archiver.kernel.org>; Mon, 30 Jun 2025 13:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751289245; h=date :
 mime-version : message-id : references : in-reply-to : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=tQ6DxkIyEOb6DX02N2lqZ3t/03xPc2Umv/qMLkBH6wY=;
 b=rH+fxwRI9nQdfSKTepvT/n9CA7UIg+8ApkGez6yuUC9p4pcpbPgEpjzXtZtptmYEdMN1U
 fuCAiZQCRz1PVk9kERw+7TP/HLPUpT2Uyx38+YE8WzEUkSrOG/T7+UyAjFz5fVm//NUNRUr
 Ac6wI1VxtluZVnhyFZshlDYQBhAwckc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 814FC3C5EA3
	for <ltp@archiver.kernel.org>; Mon, 30 Jun 2025 15:14:05 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 715263C5AD6
 for <ltp@lists.linux.it>; Mon, 30 Jun 2025 15:13:25 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 40066600B3E
 for <ltp@lists.linux.it>; Mon, 30 Jun 2025 15:13:24 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a57c8e247cso1650421f8f.1
 for <ltp@lists.linux.it>; Mon, 30 Jun 2025 06:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751289204; x=1751894004; darn=lists.linux.it;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GKyxgn/NA3hCUmWfD27Zzf1mzIerIc0qERxV7ZiAvDk=;
 b=FZomLDpQM75T1td0vBRXKoAn6P7WTNz+EGJ6YTPS09NaEgKfQYZ3U4J5Ho+K9CxMlv
 jKKb4URqOOwTlhmlwPIv1tzMc2C8QbL3QLmIIbC3ISmutjfOpH7yDxXRmTkkjLiFXrGQ
 BlC6Oh9AT54AySRO1TJnSEYrfUgblwqIcOS+ulMq3C1ssVrU3np9c3T6RjwcH5j8LoW3
 emJcjrTRccQXdq50m7CzigYTZeTRaVb9A7sdpKT2XfgKD6esQlppUkb1lC+r8sl6SPVr
 Pf1GuBxuYVzCaL2N090+9PySgK/Dw4IbChU+58qYCum7xOSqswPlqSeajgMe2Ow4Aow1
 77ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751289204; x=1751894004;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GKyxgn/NA3hCUmWfD27Zzf1mzIerIc0qERxV7ZiAvDk=;
 b=M7za+pEKh+0JciU/jropS1vkmZ3voIa/7yRA2DZcxRJCS4ouEPQpfL2D6Vxp/VREnk
 8FYZU4Ej4P60qRGSDbtXg2lpFljAhbe0qgvPyLGS+gT9acxE0rFsiqcqhkfYB2QnmJno
 OgjJZGNMzNwEzBTX3qUHzBZjoUdKL1LxR3gmqQiOtvJBG4JJBDskMBLtgz/PsJ2E5wym
 VPWU/93MzjKKo4ZfOFZhe/YXQtp9dfIJRCNjegNqcPDYR1maYzrVKJ0xJhq+d5rBFYXk
 7va1dPuJYORpIVMEHP0EdkSn3HiT4TUs085GhSowgXYQEvmbGKBvFuG/t/SX36ExWtoU
 76YQ==
X-Gm-Message-State: AOJu0YxfKKTdMTDs88krWMCAPBkVR6KktDPQBckvbT5Ds0BD6fzhlpes
 Vg+wDJQWHgsEZbS1FAnNwtdsw0V/rCbPLjQY64S8bego2b4IFIiIhSJT0/xa92dBOm/ADBGMPXT
 J9rSI
X-Gm-Gg: ASbGncvE3tReB2NEXdaEdpPkoWOUr29AUrdvD0VAOQDAz+giPjR95Wu9vpe/onBnPoH
 fO/fNd36jA3wLBJ5XK5mNWLdJnjmG3xH758/YlxVyAoksAUjfYuv/P4/Vrl8aGAeAWsqP9CoHNU
 aQhgiVspYWvHhT7BfwYs661jvVs0xiQa9LxIj1cJGR1SmR6+HH6SeWTKTLGAzJmwA9FrBksqiQm
 3aeEXcMz6sl8x2l0nDrUanOfkMP5WKTogwAtlRBVNb6L9PQ6+fyeqOczO1YF5qN/vJbQClpoVqX
 WQQVhIY0oq51HMM1FjRiJA93G/Ggpgd9M9NWIcSH9WqvY89x2A==
X-Google-Smtp-Source: AGHT+IFnfNhCKzVCdG6JFZKtfTp3kNExIq5xwWKrvD10oO0p+Gk5p40BAvAGe0vPTJf+1edEAR/3Ow==
X-Received: by 2002:a5d:4705:0:b0:3a9:de4:851e with SMTP id
 ffacd0b85a97d-3a90de485c4mr9846520f8f.45.1751289203574; 
 Mon, 30 Jun 2025 06:13:23 -0700 (PDT)
Received: from localhost ([177.45.162.214])
 by smtp.gmail.com with UTF8SMTPSA id
 6a1803df08f44-6fd772dd5aasm66633166d6.58.2025.06.30.06.13.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 06:13:22 -0700 (PDT)
Date: Mon, 30 Jun 2025 10:13:08 -0300
MIME-Version: 1.0
Message-Id: <20250630-conversions-shmt-v2-1-6bb1bf315cce@suse.com>
References: <20250630-conversions-shmt-v2-0-6bb1bf315cce@suse.com>
In-Reply-To: <20250630-conversions-shmt-v2-0-6bb1bf315cce@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1800; i=rbm@suse.com;
 h=from:subject:message-id; bh=/llUtbIGJO9IIMeR8w7Q7tcVOz0uM3Osmyn+f53cr/0=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBoYo1qJPW71/tRBMo/W8bkL9jr2afsUzvIXAllK
 wJcHN7P5CiJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaGKNagAKCRDJC4p8Y4ZY
 phKWEACXss949iYk76Pido3tAClv3/Lk73Vk3aczwjapqOMMrpBpoyOkM/qzWrBoUohtEiDWXq6
 6OUBNxzWNe80CetyZ5nqxVUyx3qaZ0j4pVyZf6NgapWcKfPr1D2Dz+GwBgN+tC9k5gpfqI67SNz
 cVjfzKdrgRQjvpaIAgy6tYfp/4g1awAubWxwDGMLig0XiHa/V9/JKyxipzWk00iCVtBJywnbequ
 NTtcuf7lQ89Bg6lDP8tHG+U+plK++kzXh/DD79xOgxi2PjM+n3gI0gl+jk6rg8S8G4FwWh40HZv
 eyTcIluJh26SpE1HPX+wM9yhHWLL8cac1xir1Mo9PVbDEVpN2G93w6c9X3kZ5AdZ0LnpmJT9PNI
 mrMuALW9cwWd+il5sjfDhNjXqb+v9niYZ+T+RwiiUFa7JifitPEMq9ofYHqEP9Hfxu8RAPuBRGp
 dQUEd+PvEQ6rgrGQx5ARv4zOTmZDAl64RZnWjJ1YpWimH2u4PIN3veuquRFIxD9ybdEfFxyn1q1
 zABv81s4pWBBGl+jDpyZ0b1xvciKR5v/cbAVYuAKnmdib3a2IZpelJq5/QF1SZu/1KcRD9kXmmB
 /5nduXFUtLtMU7sjAlaaDXE1yoxI11CtkRZd0h+s+ZAgG5c5PFzdqIN69FZF3/nuN8u9jjN6dHs
 K9Ik+FabccNDSeA==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/9] mem: shmt02: Make sure memory is no longer
 accessible after child exits
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

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KClRoZSB0ZXN0IGRlc2Ny
aXB0aW9uIHN0YXRlczogIlZlcmlmeSB0aGF0IHRoZSBzaGFyZWQgbWVtb3J5IHNlZ21lbnQgaXMK
YWNjZXNzaWJsZSBhcyBsb25nIGFzIHRoZSBwcm9jZXNzIGlzIHN0aWxsIGFsaXZlIi4gTWFrZSBz
dXJlIHRvIHZlcmlmeSB0aGF0CnRoZSBzZWdtZW50IGlzIG5vdCBhY2Nlc3NpYmxlIGFmdGVyIHRo
ZSBjaGlsZCBwcm9jZXNzIGV4aXRzLgoKRml4ZXM6IDFlODUxNjc5MDA2MyAoIm1lbTogQ29udmVy
dCBzaG10MDIgdG8gbmV3IEFQSSIpClN1Z2dlc3RlZC1ieTogQW5kcmVhIENlcnZlc2F0byA8YW5k
cmVhLmNlcnZlc2F0b0BzdXNlLmRlPgpTaWduZWQtb2ZmLWJ5OiBSaWNhcmRvIEIuIE1hcmxpw6hy
ZSA8cmJtQHN1c2UuY29tPgotLS0KIHRlc3RjYXNlcy9rZXJuZWwvbWVtL3NobXQvc2htdDAyLmMg
fCAyNSArKysrKysrKysrKysrKystLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0
aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9t
ZW0vc2htdC9zaG10MDIuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL3NobXQvc2htdDAyLmMKaW5k
ZXggMTZkOTlhYzdhNzgxYzQyY2MyODJkZDgxYWY4ODk1MDk3YjQwNDQzNS4uNTIxNDVhZjcyOGFl
MzU3YTJlYWUzMTk1ZGJkNzc4NGE3NjY2NmUxMSAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL2tlcm5l
bC9tZW0vc2htdC9zaG10MDIuYworKysgYi90ZXN0Y2FzZXMva2VybmVsL21lbS9zaG10L3NobXQw
Mi5jCkBAIC0yNywyMSArMjcsMjYgQEAgc3RhdGljIHZvaWQgcnVuKHZvaWQpCiAKIAlrZXkgPSBH
RVRJUENLRVkoKTsKIAotCXNobWlkID0gU0FGRV9TSE1HRVQoa2V5LCBTSE1TSVpFLCBJUENfQ1JF
QVQgfCAwNjY2KTsKKwlpZiAoIVNBRkVfRk9SSygpKSB7CisJCXNobWlkID0gU0FGRV9TSE1HRVQo
a2V5LCBTSE1TSVpFLCBJUENfQ1JFQVQgfCAwNjY2KTsKKwkJY3AgPSBTQUZFX1NITUFUKHNobWlk
LCBOVUxMLCAwKTsKKwkJbWVtY3B5KGNwLCB0c3RfcmFuZF9kYXRhLCBTSE1TSVpFKTsKKwkJU0FG
RV9TSE1DVEwoc2htaWQsIElQQ19STUlELCBOVUxMKTsKKwkJVFNUX0VYUF9FUV9MSShtZW1jbXAo
Y3AsIHRzdF9yYW5kX2RhdGEsIFNITVNJWkUpLCAwKTsKKwkJVFNUX0NIRUNLUE9JTlRfV0FLRSgw
KTsKKwkJX2V4aXQoMCk7CisJfQogCisJVFNUX0NIRUNLUE9JTlRfV0FJVCgwKTsKKwl0c3RfcmVh
cF9jaGlsZHJlbigpOworCXNobWlkID0gU0FGRV9TSE1HRVQoa2V5LCBTSE1TSVpFLCBJUENfQ1JF
QVQgfCAwNjY2KTsKIAljcCA9IFNBRkVfU0hNQVQoc2htaWQsIE5VTEwsIDApOwotCW1lbWNweShj
cCwgdHN0X3JhbmRfZGF0YSwgU0hNU0laRSk7Ci0KKwlUU1RfRVhQX0VYUFIobWVtY21wKGNwLCB0
c3RfcmFuZF9kYXRhLCBTSE1TSVpFKSA8IDApOwogCVNBRkVfU0hNQ1RMKHNobWlkLCBJUENfUk1J
RCwgTlVMTCk7Ci0KLQlpZiAobWVtY21wKGNwLCB0c3RfcmFuZF9kYXRhLCBTSE1TSVpFKSAhPSAw
KSB7Ci0JCXRzdF9yZXMoVEZBSUwsICJDb3BpZWQgZGF0YSBjaGFuZ2VkIGFmdGVyIElQQ19STUlE
Iik7Ci0JCXJldHVybjsKLQl9Ci0KLQl0c3RfcmVzKFRQQVNTLCAiQ29waWVkIGRhdGEgaGFzIGJl
ZW4gcmVhZCBiYWNrIik7CiB9CiAKIHN0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKIAku
dGVzdF9hbGwgPSBydW4sCisJLm5lZWRzX2NoZWNrcG9pbnRzID0gMSwKKwkuZm9ya3NfY2hpbGQg
PSAxLAogfTsKCi0tIAoyLjUwLjAKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlz
dHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
