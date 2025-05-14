Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35606C3ABDA
	for <ltp@archiver.kernel.org>; Wed, 14 May 2025 10:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747219904; h=date :
 mime-version : message-id : references : in-reply-to : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=7PCDK7KQVM/kQBkppoIYP8z0JV3dK3lW0cEhGdwcP9g=;
 b=IaN9Qk75ICUY0L+bqE4bfARej9PbRue3OSC7uNvuMww9RSQ9VSKPCt9fw09wqddd1QeuG
 Jyxh3l18ulIVljv56Qtnsucmqe60etY2qM0UaKGQiysETTzGt7iW7Tlbe25jnzQV5Qy1K04
 NnhTZiU5B1Eg2MKtX3FtFglem34uQTg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B6CD23CC3B3
	for <ltp@archiver.kernel.org>; Wed, 14 May 2025 12:51:44 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 218673CC3BA
 for <ltp@lists.linux.it>; Wed, 14 May 2025 12:50:18 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BBE20200BC6
 for <ltp@lists.linux.it>; Wed, 14 May 2025 12:50:16 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a0b9625735so3596108f8f.2
 for <ltp@lists.linux.it>; Wed, 14 May 2025 03:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1747219816; x=1747824616; darn=lists.linux.it;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=f5jFO4fAeJxvYsZJeHKeVzy7KGP/jyH3rbFZQLvhP/w=;
 b=M+Gpbh58kMJU6SydqDXbn9VZqPc5OCS0+Lki6fCzIcBsjp79bSjBLwGEvPZXK2FT6h
 2vpDjEDJhTjZXRp45zetsneFve6Y8sSOxBaKl44ACh9LBoiMFsyJSrezAnYFXa92TUob
 +KxCFvHyDHg7PlHxbhMuNw2XMnKiHEs3Vhdko5sfAPOHRjq/TsHxyBfHksiIMKsbUtjc
 T5s5WPS0emVpUVYthcNPdwV8uAh8TZDL2JVduijNvfhVK0l7ha/dJN86aKVgamCGadJP
 vtFyIcndumfwCZ0rL7sUilPzcCLlXSA4dO11LepFkCzbmqCzzb1TDH24h9JTIZEdobSW
 ijSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747219816; x=1747824616;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f5jFO4fAeJxvYsZJeHKeVzy7KGP/jyH3rbFZQLvhP/w=;
 b=IO9qdCAxfmnWtlGqG7aNYDViw3CXjg+uuV8BAYFqswhmoIiWUEr2imEYNf2L07+VXv
 EVYEg0jlLLPQjQWncV33HkMYaOZDzqBut7BTewmAfdcwLs55far9FN8LI7tbD1Ep18pM
 Y+Db+epFhKl8RM7mus7UR11uzuZaqyRa78NJ9SvatxE3iYpUgarkoRZLhd9EjGW1bnAN
 fLI8YOH7xqMhjCbp71K/jym0e6fft/B1Tsj4sShPoLVx5kn2ZWxIRxiChXi1EHY6au72
 xt58VBovK62sDjwDgR15nV4HxapcNZbgJuemqAGwZN6YFFKnfHDEV8bkmVoxf00lhHCH
 wGuQ==
X-Gm-Message-State: AOJu0YwSzc/QTbbrEjK5xK+XqDs78FvGinRGi5oXY/W7VTuPCmPBhvJT
 /KEzUGOPOmjE8KA2e/EqKdqUY68382NB1eISafN8QTs47uLk+GWzOXwTEeXAZAiqKAq0xWriCNK
 B
X-Gm-Gg: ASbGnctydwycFpsetJ5Mn/dVOv0qfEhmFDG+w1aGk+PLU6zcpALtAi25prO4ga4nXf/
 csOXmLljsjoTzY2i7l8kwEPDPe5T1xmITOGwxsLMed2srqF+lXLqbGzlKkeK9cd70s+u1c+tv8S
 qb95Yxoh85ovJB19E2TdjYaw/cnauvDz5qxd/cxneBK+7QqWxWLgl06G1ShVGNGtUb09kFllLRr
 xFV156x3ev+HpjtPck7iTN7QlwpGtOQGWqf+pO5kpCJPPBG4c6yC0ghRqYVPVh3C9/xVrgUCmNC
 pVgqNbVuhCRp7ScHyefiUluO5o0GhSw+PI6ngm4=
X-Google-Smtp-Source: AGHT+IEe3MCPlQXLgpEI0nxBE4/soidmJTPqG7VvBy9Psw/2YYAG3KMSIKvAzs4d221lbcUFahlLrw==
X-Received: by 2002:a05:6000:2283:b0:3a1:f67e:37bc with SMTP id
 ffacd0b85a97d-3a3493dddafmr2761528f8f.0.1747219815873; 
 Wed, 14 May 2025 03:50:15 -0700 (PDT)
Received: from localhost ([177.45.162.169])
 by smtp.gmail.com with UTF8SMTPSA id
 ada2fe7eead31-4dea857f6b6sm8152159137.6.2025.05.14.03.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 03:50:15 -0700 (PDT)
Date: Wed, 14 May 2025 07:49:56 -0300
MIME-Version: 1.0
Message-Id: <20250514-conversions-kill-v1-3-cd633e941e8b@suse.com>
References: <20250514-conversions-kill-v1-0-cd633e941e8b@suse.com>
In-Reply-To: <20250514-conversions-kill-v1-0-cd633e941e8b@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=864; i=rbm@suse.com;
 h=from:subject:message-id; bh=4Mhlf7GgNnuSaeqYqKmcodX11pjb/NAX33CnCNC0kR0=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBoJHVajslFT050CbQMYAOA0R3LgNcpoQOE3xodo
 VUpTxnwZ5iJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaCR1WgAKCRDJC4p8Y4ZY
 pmFCD/kB6yDLoivCTYuZ7qG3v6sbx9g1dskj4zqB+GClS7FWyRLSVIVe1SQ/NEmQ5b8Y+RXQ6+C
 rlkUimQTzzLWZUptt26csVdGd/cuvcm+mJWywdRzmc5tjXD7rJXflKMnu0xPNi43+D22YGNBmUP
 5+DS6Hne0uY9wPe9oF21GZUUiIxDP/e2rvyIfQwseC8Rki5PmCzIpZQrVQ6zXZqyleSQ4ZrtQzf
 xTZEtdo/d4L+H6g1E+kv3o1pb25KJ5u4JSYSBwnzxUeaoJSMj61XY9Vk89CKWP8g3BdUEN0dIDN
 aYF6qaeE5S4Z1Ybdy4hCvxUurCep4M/0ltQPXJXplNHmgaHpacWgZgtzBOURWxagTKDHBVoO6c9
 zsfx6ZE1/a2F7XD46Y2HMmNhMKo3HoTKFn7FSY+89Cpo6Uo/VR2EevlVXfFK6kXpvGNOZUvw5Xi
 bcJoIt/4RMEAsmV5nu9j0nbTkvfcAYavYY8zPxz1tkWJFAg1bCj/zeAQZItAjtj6y5KEpX4WCV1
 nUm5hqI0eW5aZeU8LKCHE+5dXrEagvXdYigvWI8ktrU9+nwlnGkTG5XMbNZo12lSlMffK6Lt5Vj
 y8DUtCvx60ndDpiWm1inmk57pIaj72bXVigTvrSugYnK/0gCsV1Lv9eLiv6jPSK4TRVFwd6cbSq
 yo91ud2Dr5fy6RA==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/6] syscalls/kill06: Fix test description metadata
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
bC9zeXNjYWxscy9raWxsL2tpbGwwNi5jIHwgOCArKysrLS0tLQogMSBmaWxlIGNoYW5nZWQsIDQg
aW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL2tpbGwva2lsbDA2LmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2tp
bGwva2lsbDA2LmMKaW5kZXggNDIwMDNhNjg0YWVjZDlhYWY5NzVmYzNkN2U2NDdlZmQ0ZjViNGVj
Yi4uMTM4NmUxYjc3M2RkMWFhNjA5ZWJiNzQ3YzY2YjM1ZTBiMGFjODBlMyAxMDA2NDQKLS0tIGEv
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9raWxsL2tpbGwwNi5jCisrKyBiL3Rlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMva2lsbC9raWxsMDYuYwpAQCAtMSwxMiArMSwxMiBAQAogLy8gU1BEWC1M
aWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKIC8qCiAgKiBDb3B5cmlnaHQgKGMp
IEludGVybmF0aW9uYWwgQnVzaW5lc3MgTWFjaGluZXMgIENvcnAuLCAyMDAxCi0gKgorICoJMDcv
MjAwMSBQb3J0ZWQgYnkgV2F5bmUgQm95ZXIKKyAqLworCisvKlwKICAqIFRlc3QgY2FzZSB0byBj
aGVjayB0aGUgYmFzaWMgZnVuY3Rpb25hbGl0eSBvZiBraWxsKCkgd2hlbiBraWxsaW5nIGFuCiAg
KiBlbnRpcmUgcHJvY2VzcyBncm91cCB3aXRoIGEgbmVnYXRpdmUgcGlkLgotICoKLSAqIEhJU1RP
UlkKLSAqCTA3LzIwMDEgUG9ydGVkIGJ5IFdheW5lIEJveWVyCiAgKi8KIAogI2luY2x1ZGUgPHN5
cy90eXBlcy5oPgoKLS0gCjIuNDkuMAoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9s
aXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
