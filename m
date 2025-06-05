Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC69C5AE59
	for <ltp@archiver.kernel.org>; Thu,  5 Jun 2025 12:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1749128020; h=date :
 mime-version : message-id : references : in-reply-to : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=bdUhWgL9qVYUpSoWO0JTkI8KucZLQQCIRHCBBCXqCL8=;
 b=PgWV7iAF1g7dCRg5rfngJkMG/XYuo/EmgieVKuBmvDx9CLjhEe9QlP8cFXVwzdAyUS0OQ
 ypzR5B/RSE3x0DfGJn1oKKuKPHLeMHRJrC2xA4BB+7gph5RNEdrmvhG94797YMk/4SpSdCG
 7KK54vGHmHRRb7l2QsyaOuSv3T6eOF8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A58B03CA44D
	for <ltp@archiver.kernel.org>; Thu,  5 Jun 2025 14:53:40 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 613A03CA395
 for <ltp@lists.linux.it>; Thu,  5 Jun 2025 14:52:30 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8D2361A009A9
 for <ltp@lists.linux.it>; Thu,  5 Jun 2025 14:52:29 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a36748920cso974080f8f.2
 for <ltp@lists.linux.it>; Thu, 05 Jun 2025 05:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1749127949; x=1749732749; darn=lists.linux.it;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0xx4ET2wXpPmSkBT65jZfikAq5No6PQ4n2WYl5gaeHo=;
 b=ZNP0iKsiPovcta8Mt65wiEUsRii+TOiBflVfxpQi0ri3WWTUcx83fscQ6w9490CtYn
 xLjKQQr0DyS7Wcig6amUQIFyicB6Wn/NRV9jo5lItrS1+/CQ1iScD9nCviKQxe7LuLeL
 XxGOOrvqFByRtC/SbENDfs99kbMzeTt9Y8SKIivFnA7llSBMmpVlK3hXM0S94QMYvMmE
 mvR5r3ffnA+dgLio+4sIbmI9HuCbKRauegpxj+OwuXkLqxxryPMJIHEEaFtQ/KlTiqmS
 95eMESzM/1OLcnRf3DfSvQvfi/UtBCjGZJHf5SCw6NTuGrf5DjDfnsQvgeLuiYEvhV8U
 /xIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749127949; x=1749732749;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0xx4ET2wXpPmSkBT65jZfikAq5No6PQ4n2WYl5gaeHo=;
 b=G8oBqF5NP4mCdAjvTaYnRH86Pfy/BXBTpiHyDBQXxU02IjY+nyqyelj8oICXW7LoIv
 fqT+VECGRr+VGnUFZzsDZK4JoYpTNCvjxFI7o9cVE/BC+bc31QfMw1m3rlGeEeb0wVLl
 sn2/9LMwx1dtQQjYEHuyX7GlOYAIMGeId0VPg2wq9B5RkqGqW7Hhuwy/bd6tJuPtvdTf
 PNETJShABtqh422MfTp15kvA3cZrlkFq0A47/0CyYjkaYU2pRfGxh1raFP8YK9zGGlox
 UjHjEM08nF3Pko301ygUnBJ6JWDOExt22kx1NOjQ9Y+Oerg61fioj+mSgJbVELQfmaD2
 5HYQ==
X-Gm-Message-State: AOJu0YxDDHJAUiI/NTEq9C5iOyF08Kn4F0uyn6bpUYOP6IzruDm8WbDo
 30NGJ6h08Ew1UCoKZiBt8RWIFipZ8EWE6RJ0h60alDSRAGm+XCUnAzgWH2i7GQLIKZo=
X-Gm-Gg: ASbGncuQPAl1RJoqXZCVih+frlJAV/Qu4z5dVUT0O3kosuSIie8LVpmw+QM8ifBVxbG
 oHKqlL2sAJggIVQCsRxATrldvhqG0Fc+i1vc1Ae719YUyjWMkz5baO9IiWdfLAAemx1EyxCoS5V
 QlaSjlJjCor25TMij45sfZtmlC7JrM+p62L6Si3hABXFq+90jcU+WFX7ch3qXOv4ISB7B0XOaPD
 eEkDCNdK/xDlgiSGG7HOF3KIlYLEoDALBHteWDc6jpMbCG8K2/TMrpLtr4ZTW8w4Sk02wrRi2YN
 /T0o4OGngIvJrNGhzQOs6ab43hs1uESv07qAEOiqLpV/kEdwUA==
X-Google-Smtp-Source: AGHT+IHCrBGegtDKjpbFm2iApUlzrbSsPQQ5tcM2vRCONZrnK64tdXVAhWPHFr3INNuq35HzU2tJ2A==
X-Received: by 2002:a5d:584a:0:b0:3a3:6e85:a529 with SMTP id
 ffacd0b85a97d-3a51d978a6emr6147942f8f.51.1749127948858; 
 Thu, 05 Jun 2025 05:52:28 -0700 (PDT)
Received: from localhost ([189.99.237.136])
 by smtp.gmail.com with UTF8SMTPSA id
 71dfb90a1353d-53074aaf24csm12475278e0c.1.2025.06.05.05.52.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 05:52:28 -0700 (PDT)
Date: Thu, 05 Jun 2025 09:52:18 -0300
MIME-Version: 1.0
Message-Id: <20250605-conversions-mknod-v5-2-0b5cff90c21c@suse.com>
References: <20250605-conversions-mknod-v5-0-0b5cff90c21c@suse.com>
In-Reply-To: <20250605-conversions-mknod-v5-0-0b5cff90c21c@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1130; i=rbm@suse.com;
 h=from:subject:message-id; bh=pOak0xrIw3kdzx6ueL0QW0WQMCocZ7CPotm831eSIAU=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBoQZMC8BDFqsFuNfB6w9zfTCrZcGv1VBZBigQQ6
 yHjqxrIatyJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaEGTAgAKCRDJC4p8Y4ZY
 ppDGD/9BbvXos70NUYyoo6ej58+/9ssFeFF2O4I336mWBOVD4vWAWkxJKmjXBiBC01eIAYJpvr9
 evfOO+ecFw6CkItb0brG1/ZC4YA9lKosLtMIeVKMXvMB4FLzsggZmB5fis+bLm3U9f5KfbKhNzG
 dstUWp8BpX2IF5k1P8/j+6aLQD0+UiNdrIDOaR5Q1wmY0QgjNfhvNhVQMmBLIWN4J5uRxFzR1dM
 YMZrvaH+DfODG32Wl5ekvKcBbuHQR9jS56vNmrOSwIlAUXvvUs2m+EpHp5fLZxXfa9yupAdw9Xe
 OiG1tNTbiI4k+j5vOC0a5Mvj7MLWSTc3T81fx+66bZR0cUQSqmHwF1mCILYuPYls8fqt5sv3I6J
 tc1eMtmxYiDjUMHjXWdsVYLR9V1EKOa1oJTNKeY/Y4y6MDR8p9433Bz7uUMJcyH7BtlK1md+Fk+
 WpBq8Ku1MUDrYrNyFTwHycXGqODQdKomHxutkaqpGxoXysU6PG80cQ7TKqM1QSTNhHLGb+NA1sl
 Mf9TQoO4evlkK17reYxnuzhCLHtwprurCPoXToE5xmKO91Tn8/TyrnaKU0Je6RZrHLp7PhUoqFQ
 nC9Uj9Yx1NgBte0VRRUDz3qMGexS5B37vSEdU+fdxdYO8sEp1wQe9zARkrIZxLQLG7VqDQGthk0
 0OmZNgfimajjvPw==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 2/8] syscalls/mknod02: Use relative path to avoid
 use of SAFE_CHDIR
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

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KClJldmlld2VkLWJ5OiBQ
ZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KUmV2aWV3ZWQtYnk6IEFuZHJlYSBDZXJ2ZXNhdG8g
PGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20+ClNpZ25lZC1vZmYtYnk6IFJpY2FyZG8gQi4gTWFy
bGnDqHJlIDxyYm1Ac3VzZS5jb20+Ci0tLQogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9ta25v
ZC9ta25vZDAyLmMgfCA0ICstLS0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMyBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21rbm9k
L21rbm9kMDIuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbWtub2QvbWtub2QwMi5jCmlu
ZGV4IDg5ZGQxZDg3NDAyMzRiNzg4NTU0ZTYyNWU2OTM2OTNiOTU0NDQwY2MuLmJkNDc2ZmZmNzlj
ZGRlOTA3M2RkNDk2NjRmNmZkMzIwMzFmOWQ5NjYgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvbWtub2QvbWtub2QwMi5jCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvbWtub2QvbWtub2QwMi5jCkBAIC0yMCw3ICsyMCw3IEBACiAjZGVmaW5lIE1PREVfU0dJRAkw
MjAwMAogCiAjZGVmaW5lIFRFTVBfRElSICJ0ZXN0ZGlyIgotI2RlZmluZSBURU1QX05PREUgInRl
c3Rub2RlIgorI2RlZmluZSBURU1QX05PREUgVEVNUF9ESVIgIi90ZXN0bm9kZSIKIAogc3RhdGlj
IHN0cnVjdCBzdGF0IGJ1ZjsKIHN0YXRpYyBzdHJ1Y3QgcGFzc3dkICp1c2VyX25vYm9keTsKQEAg
LTM3LDE0ICszNywxMiBAQCBzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQogCiBzdGF0aWMgdm9pZCBy
dW4odm9pZCkKIHsKLQlTQUZFX0NIRElSKFRFTVBfRElSKTsKIAlUU1RfRVhQX1BBU1MobWtub2Qo
VEVNUF9OT0RFLCBNT0RFMSwgMCksICJta25vZCglcywgJW8sIDApIiwgVEVNUF9OT0RFLCBNT0RF
MSk7CiAKIAlTQUZFX1NUQVQoVEVNUF9OT0RFLCAmYnVmKTsKIAlUU1RfRVhQX0VRX0xJKGJ1Zi5z
dF9naWQsIDApOwogCiAJU0FGRV9VTkxJTksoVEVNUF9OT0RFKTsKLQlTQUZFX0NIRElSKCIuLiIp
OwogfQogCiBzdGF0aWMgc3RydWN0IHRzdF90ZXN0IHRlc3QgPSB7CgotLSAKMi40OS4wCgoKLS0g
Ck1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
