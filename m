Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41822C3600B
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 21:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743112700; h=date :
 mime-version : message-id : references : in-reply-to : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=amR7uuKEZ4kclwfvOQ+YdUxEiV7gcfq2rbGpJVoismY=;
 b=knYtmjdns6cQSJ3OOI2gJYD9Tmy9DsNU29w4IdNM6ge1hQZX63yYm9jhJRLDTiA6VWv2K
 JwkXQF1+NSJ8scEcxUtsFv+m0w07vSmiyLlXK9oWwyoWCwZ67lH579zGkQgH/4QU1SeCLMG
 cIl/ZA6aJgpBJaym1QYdVIhGajDevQo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A9BDB3CA173
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 22:58:20 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB7B43CA176
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 22:56:50 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5800D1A010F3
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 22:56:50 +0100 (CET)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3997205e43eso1230675f8f.0
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 14:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1743112610; x=1743717410; darn=lists.linux.it;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pniLzToqIwZ4Kmf4mbk96C7bzznxv3KUuwaPeNu2S7Y=;
 b=I1ofIraPWqTmV1IkXqfQazPdDvzgOpOJRwnHf+tGqvuX72Kuoali/+4+j0UF2k+IJb
 AwITBiqzWF8x/kT35Wdd2WeF6f+QWD8npuMUbLFu7/i18G4vY6MwrW85gh1EDrQBCvIz
 oBp39CtIPXWXFanwuId1p0o8OX3FUCw08wyFOlrhquuoSkH/9rYJBn+0iCxfxJ+rNycS
 XW0mX5cgQCsUuPliepoL7gkJpjVIENHb0u717hW6pP+OM+D+T8xTWalkN11TzQa4pjyC
 vq9j7ReerLsDrMOWdK1lKWI6qWfV20xBSBJeD/KiPghdfIAOIMv3UdQErpYajTfnc0MA
 Jkmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743112610; x=1743717410;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pniLzToqIwZ4Kmf4mbk96C7bzznxv3KUuwaPeNu2S7Y=;
 b=s47Im8/MpfT7t0RrQdFOnwHQ5NXr5GoCxJuoYtcJHm4kLs7kPEaDu3w5PNhEmb4Ezw
 LggmHvD1SW/aeZdnnfSu6j0xpGlBXlP7XgACS2Ba6MK2BAxVzJoVz5n5ciprJWMjmI2B
 anVS3RhthflDkEEP9Q9gMcdIquVgdl0EZpi+rDxANvPXmGp6h06RjSxqFVtpQvdjk6YG
 HbnOvnNfup3hv8SSd9vvR8P0pKFFyBRkKPKqQQjnI7Rh2O8Ze7TMtzNVdxB3RxxyaACA
 KMyrcG9bf5JrIWFA+iFMYZGfhac3UfnVAvqO1KuKjNXHCJ1UCSiN7NQ+ofvwxQxJfbin
 pzDQ==
X-Gm-Message-State: AOJu0YwMmBqEFXmoqhkYqiOIjSC59uWGeaXMS4LtBTaDApUlDWXmkrbk
 5Vu8F2T0QLs8wIaVbGo69CYw3IcxEM0iXc1pnbcDl33aS8PymiZZkWaBHy0A5ts=
X-Gm-Gg: ASbGncsgo4vNmikw1bwNEKAc/8UJYmUF/OMu6yMRaMAVqq0oF+FPbkmGzRBPcB46Mym
 QH7EDeayfB9UzTNcVud45emGfCaXChAfUHgZ9i2WIpe1aqSaHu5NkQIniJQiC6F//o3oMpg4LzU
 j44PlSbVECzX+66ZHeD0ncfyLDaXJ9Ql9+Z9yfR7I4jCCDx8jEvFE/vXZm3HsFGpRoH7dHVlC9w
 q3IVzxFh/3nlPSk8f7icTjMTRh9hoRQFH8Hi8icYQmDhBNRLy/CtadFqrIHrAYmqs9iYe/4Dr5e
 LkITson+SD93kLTlbaVb1ROEQ9Pq2vu94Q==
X-Google-Smtp-Source: AGHT+IHMcqY/m4/1UX2MG5wiR8wInBV4UJo57nAT9YMkQEK+QEVjc3ZU50jn8PjcVn/VkmrQopONyg==
X-Received: by 2002:a05:6000:40e0:b0:39a:cb5b:78fe with SMTP id
 ffacd0b85a97d-39ad1784929mr4281835f8f.34.1743112609735; 
 Thu, 27 Mar 2025 14:56:49 -0700 (PDT)
Received: from localhost ([179.228.213.210])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-2291eee11acsm4974085ad.83.2025.03.27.14.56.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Mar 2025 14:56:49 -0700 (PDT)
Date: Thu, 27 Mar 2025 18:56:36 -0300
MIME-Version: 1.0
Message-Id: <20250327-fix_make_clean-v1-3-8b9ed2a8d96a@suse.com>
References: <20250327-fix_make_clean-v1-0-8b9ed2a8d96a@suse.com>
In-Reply-To: <20250327-fix_make_clean-v1-0-8b9ed2a8d96a@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1989; i=rbm@suse.com;
 h=from:subject:message-id; bh=Ei+evLU48qztqPcbsYDKdGFkvRD2DzfTGpEsg4wlybA=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBn5cmTGExF9GfaxhuzHDW/EPPlSy1VRQSilpJOY
 eCduOVkiniJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ+XJkwAKCRDJC4p8Y4ZY
 ptUMD/wL9e7wf4cMTyFKAmb/dX1CKgsQvmeFv4IE+cD66ujuFR0SITVe6MU7WgErj8znHu/d7zZ
 YL/p4KUor2G12y7UvItiJLuonq2ObBGTYbEI7ENfKGqNrU3Q0tmhB6dywiUqpBFDnvbQ6yGS+RD
 95+PR3UbsyByXNuIfP4RZ2FQIDll40ezF+n7iAYoDHEI5D3LLuVxaIoAa5DokDkkt8smFZyeVsL
 xgbIRqsW0fd01GqdW0T2iAfS+Rfdn4ZKaa0oRneApVioLqJ+mlYxYBEGI2diNoNVFjvH4j5ccnd
 9sZk6vrK9h4Zopl9TzVneVzS+k4NIdbCuC3SuwoXItG86XoF9UfckDLfhAX4V+xsNFCv2yT98CE
 JaVEScaEWe2B7AL4OBpKGhPTCgEZGZuAyOpSHBjDbGvysHNc9B+HW9H3ZO/2h7SxJKBtZmDR3Q5
 YDu0XhB1fWlqbJlY75A/NY+sM6j4QMZ2peGy5G0QpIPRor0NNJsxR/VkB8Khu+U4/+baG/KN3NA
 d4MzKzXfYJEWmsfdRRlHqUHG9PiHtloBIeF3QdXYDfrcb9uCxo1WJ3jHxiw4NblcZO9AIkraYPi
 Bv+abyYR6UHep41FEpTSeaVv1NAJoU4KHo019L2zBqJJiaFL9td7qSpQySvBfWhkaQqjvTkiRfF
 9FIkFHbi9IfaEaw==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/4] include/Makefile: Fix cleaning targets
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

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KCkFkZCBhYy1jbGVhbiB0
YXJnZXQgYXMgZGVwZW5kZW5jeSBvZiBhYy1tYWludGFpbmVyLWNsZWFuIGFuZCBhZGQgbWlzc2lu
ZwpmaWxlcyB0byB0aGUgcmVtb3ZhbCBsaXN0LiBUaGlzIHdheSB0aGUgcHJvamVjdCB0b3AgbGV2
ZWwgTWFrZWZpbGUgY2xlYW5pbmcKdGFyZ2V0cyBjYW4gbWFrZSB1c2Ugb2YgaXQuCgpDYzogQW5k
cmVhIENlcnZlc2F0byA8YW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbT4KRml4ZXM6IDgxN2Q4MDk1
ZmJmZSAoIlJlbmFtZSBsaW51eF9zeXNjYWxsX251bWJlcnMuaCB0byBsYXBpL3N5c2NhbGxzLmgi
KQpTaWduZWQtb2ZmLWJ5OiBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgotLS0K
IGluY2x1ZGUvTWFrZWZpbGUgICAgICAgfCA0ICsrLS0KIGluY2x1ZGUvbWsvYXV0b21ha2UubWsg
fCA0ICsrLS0KIDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvTWFrZWZpbGUgYi9pbmNsdWRlL01ha2VmaWxlCmluZGV4
IDI1ZTk2ZGY5YjhjZGQ3ZDFkN2U2ZjE5OTI1YmYyMTYwZDY4MmYwZDkuLjZiMzFiMDQ2ZTQ1MmU3
MWFmYjUwOTdjYzNmYWRmOGFmMDEyODI2MjkgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvTWFrZWZpbGUK
KysrIGIvaW5jbHVkZS9NYWtlZmlsZQpAQCAtMTgsOCArMTgsOCBAQCBNQUtFX1RBUkdFVFMJCTo9
CiBkaXN0Y2xlYW46OiBjbGVhbiBhYy1kaXN0Y2xlYW4KIG1haW50YWluZXItY2xlYW46OiBkaXN0
Y2xlYW4gYWMtbWFpbnRhaW5lci1jbGVhbgogYWMtY2xlYW4gYWMtZGlzdGNsZWFuOjoKLQkkKFJN
KSAtZiBjb25maWcuaAotYWMtbWFpbnRhaW5lci1jbGVhbjo6CisJJChSTSkgLWYgY29uZmlnLmgg
bGFwaS9zeXNjYWxscy5oIHN0YW1wLWgxCithYy1tYWludGFpbmVyLWNsZWFuOjogYWMtY2xlYW4K
IAkkKFJNKSAtZiBjb25maWcuaC5pbgogCiB2cGF0aCAlLmggJChhYnNfc3JjZGlyKQpkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9tay9hdXRvbWFrZS5tayBiL2luY2x1ZGUvbWsvYXV0b21ha2UubWsKaW5k
ZXggM2RmM2I0YmE5OWNhODY1Y2FhODkzODg5OTllNTNjYmM1MDA2MTVkYy4uZDk2ZGE4MzEzZGM4
ZGM0ZjRkNmQ3MjhkYjcyYjBmNzQ5ZDI2OWJmZSAxMDA2NDQKLS0tIGEvaW5jbHVkZS9tay9hdXRv
bWFrZS5taworKysgYi9pbmNsdWRlL21rL2F1dG9tYWtlLm1rCkBAIC00NSw3ICs0NSw3IEBAIG00
L2x0cC12ZXJzaW9uLm00OiBWRVJTSU9OCiAJc2VkIC1uICcxe3M6TFRQLTptNF9kZWZpbmUoW0xU
UF9WRVJTSU9OXSxbOjtzOiQkOl0pOjtwO3F9JyAkPCA+ICRACiAKIC5QSE9OWTogYXV0b21ha2UK
LUFVVE9NQUtFX0ZJTEVTIDo9IGNvbmZpZy5ndWVzcyBjb25maWcuc3ViIGluc3RhbGwtc2ggbWlz
c2luZyBzdGFtcC1oMQorQVVUT01BS0VfRklMRVMgOj0gY29uZmlnLmd1ZXNzIGNvbmZpZy5zdWIg
aW5zdGFsbC1zaCBtaXNzaW5nCiBhdXRvbWFrZTogYWNsb2NhbCAkKEFVVE9NQUtFX0ZJTEVTKQog
JChBVVRPTUFLRV9GSUxFUyk6IG00L01ha2VmaWxlLmluCiBtNC9NYWtlZmlsZS5pbjogbTQvTWFr
ZWZpbGUuYW0gYWNsb2NhbC5tNApAQCAtNTUsOCArNTUsOCBAQCBtNC9NYWtlZmlsZS5pbjogbTQv
TWFrZWZpbGUuYW0gYWNsb2NhbC5tNAogYWMtY2xlYW46OgogCSQoUk0pIC1yZiBhdXRvbTR0ZS5j
YWNoZQogCSQoUk0pIC1mIGNvbmZpZy5sb2cgY29uZmlnLnN0YXR1cwotCSQoUk0pIC1mIGluY2x1
ZGUvY29uZmlnLmggaW5jbHVkZS9zdGFtcC1oMQogCSQoUk0pIC1mIG00L01ha2VmaWxlIG00L2x0
cC12ZXJzaW9uLm00CisJJChNQUtFKSAtQyAiJCh0b3Bfc3JjZGlyKS9pbmNsdWRlIiAkQDsKIAlm
b3IgZCBpbiAkKEFVVE9DT05GRURfU1VCRElSUyk7IGRvIFwKIAkgICAgJChNQUtFKSAtQyAiJCh0
b3Bfc3JjZGlyKS8kJGQiICRAOyBcCiAJZG9uZQoKLS0gCjIuNDkuMAoKCi0tIApNYWlsaW5nIGxp
c3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
