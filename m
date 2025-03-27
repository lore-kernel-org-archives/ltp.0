Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 324AFC3600B
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 21:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743112647; h=date :
 mime-version : message-id : references : in-reply-to : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=fvmeip4yEoTxrhjAPEgFuzIyGKXZemA9dDhDaECz9W8=;
 b=gwAGs+TJTYduqiySsm01Z0EoqEoipbeJ7C7WKL8an0Yr/uYhV2OF1cclDEM/yjuF8wR/j
 DQW3K/JoI0oum1xdzJwExS5ldaeKuqIRrjJsDKmo2G+Auqp1MxS0pOXVo/MrmIarsiObGHp
 MQhcFIys3HvJtOMHtS2aypzOj6wvBIU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B62F83CA144
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 22:57:27 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 998F43CA11A
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 22:56:44 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BC3CB601BA3
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 22:56:43 +0100 (CET)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cf257158fso11040925e9.2
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 14:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1743112603; x=1743717403; darn=lists.linux.it;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zxhza5ZgWzPjEDylzkcP0FbSI+RWon94GB0jVrZyLmk=;
 b=WnoSDfspTVPOC/Zz7o3ukIemVh6BXZB0pYuBdj1uxxbgGYoNAB9M3un/kn7mHrfovz
 BEUaV8uj++m8Pz44uDwzTsbcuqdrK//zsfsi6B98YrPc1D9YAPBN/2cIAw1sNuYADQw4
 RpOALi/HvZd5SM2ZcKSvuPJ4BStQ0gaM6dDPwZkRvRHLQSW01X2A94BadL4R/fLnWYhc
 SOX6d+yx1CMLkiOv0jRSGSZEeS8j64ih0kx+PE/GqgMCpYKTjAkihtybOGlEh005u2Cp
 bchhVwdQ98g3dvdBnwD7E7RqaEeWyFAX2D+0/ynqqqWMkoH8c5VRgSwSLN+pbyb4O+XR
 RA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743112603; x=1743717403;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zxhza5ZgWzPjEDylzkcP0FbSI+RWon94GB0jVrZyLmk=;
 b=l8f+7LjZwOSw5Hnf4KYbv15lL2+W2GyikLCo7lTAEFlzSlMoZvtA8cw2b7cuwyhVyW
 i9D+/5LF+rckWAguvyhmbkXQenD4UyNHfy4UbDuVqm+2QNqD/1uVi7UM/6GOioPb6TWl
 4vY2sxJaCNVuXHypZ2VEOs81fOx/qw8E7WqNlhNrbJssNRdlXZZ3JEDjlzszkI2R8kQU
 nFpMVXxyN1bT44xHMx3dKdxJGof8gTmTQPThC74qKLrVGMSSgz2ywsFViHFgdxfxuEtY
 D7SzOJWC56hP5pnnAeBSHC2XqooXblNkkZi37Dp8rXq0L7onAzztE3nh0zfQwvBjUd1Q
 Tkqg==
X-Gm-Message-State: AOJu0Yyj4SIHEGOnEVL2AYMFlpMCmyyQeYzVQYj2jz1A28ccgR0ignrh
 jeqjY5+B0xcPshg0BIR3lvY1c+aHlHtESx1bJJZlmsLY252G+LWToqJvW6Yddko=
X-Gm-Gg: ASbGncuCOcktt6TnjATqPHjMzcu7ZWJS2bVHRmoCdmU55HIU8e+dj8AUfzyvgNFseA4
 PBDM6Tt+LkQ7KJaWvZbqqUo7pXgy7j2PUn+oLrhbLL/SJUzfv/ZoCKF8B4bHXm9unmPdKvB9UzP
 iVl29pLY32syIQznaFgJvj2Ct2J44wmxe5rWUdIhAdkSgl9mt93MVk9PF0DtQ7AzRL1WODGXoFH
 v1ZQtV32PADmML3VjVdbbPKNWsFLKaN2C5mQTCAUiazyiw9k5IVLGL3+AE+bGwXMwA6Mkch6UZj
 QhPwH8YiUstLEni9dAzOFuVCP5x7fsy4jA==
X-Google-Smtp-Source: AGHT+IFL0FEM0LbxlvA3i0c0jQMopdOJgVOeoW+MgYITJ7i4nSF6n70lMQhm/412Twqyddf4IB09rg==
X-Received: by 2002:a05:6000:1863:b0:390:e7c1:59d3 with SMTP id
 ffacd0b85a97d-39ad1740be0mr4343894f8f.2.1743112603049; 
 Thu, 27 Mar 2025 14:56:43 -0700 (PDT)
Received: from localhost ([179.228.213.210])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-2291f1ded84sm4667175ad.170.2025.03.27.14.56.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Mar 2025 14:56:42 -0700 (PDT)
Date: Thu, 27 Mar 2025 18:56:34 -0300
MIME-Version: 1.0
Message-Id: <20250327-fix_make_clean-v1-1-8b9ed2a8d96a@suse.com>
References: <20250327-fix_make_clean-v1-0-8b9ed2a8d96a@suse.com>
In-Reply-To: <20250327-fix_make_clean-v1-0-8b9ed2a8d96a@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1419; i=rbm@suse.com;
 h=from:subject:message-id; bh=m73s3Y+c9v4Epxow5tCOdyrHQh0pmDySSj/a1PyFsC8=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBn5cmTQb5bFZNBC2S9nV/8Jz8P0Ih51KaRfD6MV
 e0vNTr0Dl+JAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ+XJkwAKCRDJC4p8Y4ZY
 pmyxD/9h++1KGP7fN1fOCKYn2hSNJB/5I6Yk7nCJjk5M65IgCliosU3r7c4uphXNTVn5waE3l0I
 Dk30NUZawVyzLtJn/YxpSiPtsXEXUIQjkqAj08tP5A/t+l9ifkAmXi0VIjPaUC3dh0P/2PxxKiq
 8nXoujt0P/wOnwC8lfxPvqPbdqqrGyK3XXcRChq+mgdfsWj1nB6aVH3LNgIp45Kyv0FfKqCzxpN
 Ns3QiyXJRYiS274JTd2yAbiZPYgS9HmE7dnsc+34ya39ecSXdISglH+blRHAI+MWmqzduAKuBg7
 WUwl+mn/7n6pSTNvFqkX4Zljib7PbfFw4l5S5oY0udfX69zeKHPo4Z5BVNrUON+nNOd+gAD6nC4
 G973hnkjtW8/bfC8vGms+vPXJKtdemASVZF93N5PIgd9p013/6tYWnigpk8weSh9pK6j9QZsqAi
 XWvh2q5xy3lbaqXRiFQhdmMS2IQG3tAxDHdwsOol78+0XLpIMpL3yLRIBFSzTSCDHcGuqGb/Chs
 YktgiC4prOm758D9m6x37EQG9pGQEk2O8R3tDvRS7I4vGe2VAv9saR2Rj+b2/iEPaBI/Fpe8mNH
 7L8LKGcNgQjR/UF9xob7IL2JR0eEQMkWKiCChbz6m6yhkE5JRMxSnkD6FLSOxh9FkPslefJRTZt
 eqMlyOVcPMMyAFw==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/4] configure: Add missing
 include/mk/config-openposix.mk reference
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

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KClRoZSBmaWxlIGluY2x1
ZGUvbWsvY29uZmlnLW9wZW5wb3NpeC5tayBzaG91bGQgYmUgYWRkZWQgdG8gdGhlCkFVVE9HRU5F
UkFURURfRklMRVMgYXJyYXkgaW4gaW5jbHVkZS9tay9hdXRvbWFrZS5tayBzbyB0aGF0IGl0IGNh
biBiZQpjbGVhbmVkIGluIHRoZSBjbGVhbmluZyB0YXJnZXRzLiBBbHNvLCBhZGQgYSBzbWFsbCBj
b21tZW50IGluIGNvbmZpZ3VyZS5hYwpzbyBpdCBkb2VzIG5vdCBoYXBwZW4gYWdhaW4uCgpDYzog
Q3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1c2UuY3o+CkZpeGVzOiA2M2I2NTMyZmYxNTAgKCJvcGVu
X3Bvc2l4X3Rlc3RzdWl0ZTogUHJvcGFnYXRlIGNvbmZpZ3VyZSBwYXJhbXMiKQpTaWduZWQtb2Zm
LWJ5OiBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgotLS0KIGNvbmZpZ3VyZS5h
YyAgICAgICAgICAgfCAyICsrCiBpbmNsdWRlL21rL2F1dG9tYWtlLm1rIHwgMSArCiAyIGZpbGVz
IGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2NvbmZpZ3VyZS5hYyBiL2Nv
bmZpZ3VyZS5hYwppbmRleCA2NzEwNzlmM2FhNDhjNzI4NjZmNjllN2M1NDVkMzQyOGJhODdmOTMx
Li5kZGIxZjZlNGUwNzg3ZmU0YmM0ZDk3Mjk0NzBlNTIyMzc5MzBhMTIwIDEwMDY0NAotLS0gYS9j
b25maWd1cmUuYWMKKysrIGIvY29uZmlndXJlLmFjCkBAIC03LDYgKzcsOCBAQCBBQ19DT05GSUdf
QVVYX0RJUihbLl0pCiBBTV9JTklUX0FVVE9NQUtFCiBBQ19DT05GSUdfSEVBREVSUyhbaW5jbHVk
ZS9jb25maWcuaF0pCiBBQ19DT05GSUdfTUFDUk9fRElSKFttNF0pCisKKyMgQWRkaW5nIGZpbGVz
IGhlcmU/IFBsZWFzZSB1cGRhdGUgaW5jbHVkZS9tay9hdXRvbWFrZS5tawogQUNfQ09ORklHX0ZJ
TEVTKFsgXAogICAgIGluY2x1ZGUvbWsvY29uZmlnLm1rIFwKICAgICBpbmNsdWRlL21rL2NvbmZp
Zy1vcGVucG9zaXgubWsgXApkaWZmIC0tZ2l0IGEvaW5jbHVkZS9tay9hdXRvbWFrZS5tayBiL2lu
Y2x1ZGUvbWsvYXV0b21ha2UubWsKaW5kZXggNzlmODNhNWEyZWRmMmE0YTEwYjc1ODdhMzZlNzky
Mzk3Y2ZiNWQ2NC4uM2RmM2I0YmE5OWNhODY1Y2FhODkzODg5OTllNTNjYmM1MDA2MTVkYyAxMDA2
NDQKLS0tIGEvaW5jbHVkZS9tay9hdXRvbWFrZS5taworKysgYi9pbmNsdWRlL21rL2F1dG9tYWtl
Lm1rCkBAIC03Niw2ICs3Niw3IEBAIGFjLW1haW50YWluZXItY2xlYW46OiBhYy1kaXN0Y2xlYW4K
ICMKIEFVVE9HRU5FUkFURURfRklMRVMJPSBcCiAJCQlpbmNsdWRlL21rL2NvbmZpZy5tawlcCisJ
CQlpbmNsdWRlL21rL2NvbmZpZy1vcGVucG9zaXgubWsgXAogCQkJaW5jbHVkZS9tay9mZWF0dXJl
cy5tawlcCiAJCQlsaWIvbHRwLnBjCQlcCiAJCQltNC9NYWtlZmlsZQoKLS0gCjIuNDkuMAoKCi0t
IApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
