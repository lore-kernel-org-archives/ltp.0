Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8943C369C2
	for <ltp@archiver.kernel.org>; Fri, 25 Apr 2025 18:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1745604450; h=date :
 mime-version : message-id : references : in-reply-to : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=QABWMDrsW1y9FPHjVDYHMUqwpquRTZwI2cUlyDf3UuY=;
 b=hVfInqVbxZ70Gn4Hqqr9nR71NmalnxX/YGH072i2HnHW9h40OKwiKKdELcqaT694vYYjl
 H1Cl02x85FuOiBGZnP1dQNUExQnhHXYB9/0iIzAlyaNrC+7AWVdJXA5FxhdvekZRGwZ+Cor
 G2IZEhDDIqnJ25y6MfcypZu5ZEuT98U=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C25973CBA77
	for <ltp@archiver.kernel.org>; Fri, 25 Apr 2025 20:07:30 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 80DEE3CBA39
 for <ltp@lists.linux.it>; Fri, 25 Apr 2025 20:06:18 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D9A251400527
 for <ltp@lists.linux.it>; Fri, 25 Apr 2025 20:06:17 +0200 (CEST)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-39ac56756f6so2500197f8f.2
 for <ltp@lists.linux.it>; Fri, 25 Apr 2025 11:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1745604376; x=1746209176; darn=lists.linux.it;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uqOnhmICvJNwWlaGvCLaLbzPDHfHBSeup2FG4GGDIwI=;
 b=AEjLr0Vb6sXNW5XeQmFkJLqLD+9bKgZUdDjgNwmloRBBP9nK9NvWNmqI6XDcetRB0O
 NVrmu+86wOBjHGXkfRIIgz9Z0XqT6pXEDKERTVYOs1vWr4iQ0p+H6VB1RUXjUjxpZO52
 G2wYmoxbrntYPc8SQFHDpE4vvV2oLScyHSy4SkGa6yo2vUR+/De2a6gy/uuG8orUMGn8
 Yg2WFbbm31o9cpUl+Fr2BosKIm2u1KgZR/sumq6QOZ1I0xGD/qE1dKKcug/o+C6t/64T
 6DwddyL0Pnq/prJrEwhym1KWOz6oES3igxKYqRR6hTpz4xQv5BaX1TXcEUO7Kk/BjhXQ
 +iAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745604376; x=1746209176;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uqOnhmICvJNwWlaGvCLaLbzPDHfHBSeup2FG4GGDIwI=;
 b=T4mhBG51m3qrbjd1N+RhEcjjwmrzzEXEnU6lNrJO0OOrdi1ij1W2E73AM4mav081yJ
 An6/16V0GMO4TM7SByymI0FwzMicVn5wkqG0Ys5YvAGPlTb7xKG31r+SOdPyJ6fwqYQT
 JuZ5dhLZf5DwWQhY/Jg6ZSbzvcOj7QyXOzx8SvpgN5LKuAGr2Q8JnawAI2Qs9M6PcOLA
 NDOL/nK4MCsuXNHJRr18izGUsjrV1t1qTpiCsBG1vuSj4mX3yFa/0w9xrCNC+Y4zewP0
 U8eCuYZ+hggIJ/E4Fbc0ZxLWleJdYfCkfl9zQs2Er8+17EkvkV3nVX7Q3cA4KY4cRNN7
 CGxQ==
X-Gm-Message-State: AOJu0YyHIisiibtMagK26EYPXaWZVpu/eC4Ql6kuFrffJ/izpWWbIrv7
 fzbGuno212R5ZrAjx8SATy2qQVfm4rtmEfW/k6wcuuWCHOErb06Dx7stAgI3aOO+xC2dkjzT0GC
 c
X-Gm-Gg: ASbGnctJshU5hnLJVC/dL0fuseYQWLTqzrqDuGJeyZ+tdQEyx5i922Whu3Arl0wc2Er
 IYR863K3gjKG22m6uMnNnCcO4uc/xvkftkSKpSUlm3lxW/RkZsjCupC7xnqMkg6zTDUVnDZEj2b
 8osQygcKQpcbHkvY36gHnqpbjHXij1W95mklW5+h81HGhattLFQJFGzE7KWlNmc2be/4CaxKiGQ
 570zS4G4swBEY2YuBr/32uZFM/qE3xjSj5xipqZUllSTUVwmYkbsDQyyew17HvkqSBiuJrI0jfd
 idfgWJBl+sF6BZQO23DOZkA9MGkVUA==
X-Google-Smtp-Source: AGHT+IFDBxdcMiHuO7gvYg+0co2LRukbnBPdpo/HxIU1hVZ4Gkvp+TJE2L+ONtbw72EMRN4lv+53LQ==
X-Received: by 2002:a5d:5f96:0:b0:39c:30cd:352c with SMTP id
 ffacd0b85a97d-3a07aa5fdf7mr222075f8f.8.1745604376533; 
 Fri, 25 Apr 2025 11:06:16 -0700 (PDT)
Received: from localhost ([179.228.213.210])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-22db5100aa7sm35448915ad.161.2025.04.25.11.06.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 11:06:16 -0700 (PDT)
Date: Fri, 25 Apr 2025 15:06:02 -0300
MIME-Version: 1.0
Message-Id: <20250425-conversions-mknod-v4-2-222e0d2e7ef1@suse.com>
References: <20250425-conversions-mknod-v4-0-222e0d2e7ef1@suse.com>
In-Reply-To: <20250425-conversions-mknod-v4-0-222e0d2e7ef1@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1071; i=rbm@suse.com;
 h=from:subject:message-id; bh=X5h5mk+IgbMJdWQ6bkAL3Wf14QQb+iicBskD93XmEJM=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBoC88NOV6GwffyC1aSdTuYiuRSPhpGliS6sQzW1
 Xi7GbVM1umJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaAvPDQAKCRDJC4p8Y4ZY
 pi1HEACZjmBa4EQ9D4CL1jtOzxbO70rQ7fMsoWfM0r+/Icn8orhmwVMuGgJTZLgeb4EZNbq424g
 JAY6QbqzyaH3Kua21o25hxaGddV2JxXgAVFE2zJZxnK16g6i2xFIPIqejSmcLaaI+Ht9IKlOBu3
 UFHU+cte7QB6uTdaBEl+vcJpvsUPGEFGFHub8wpvcNoV5tQhzxJwa5iqZTiYKJMM09lX07AvQ7c
 0CmQTNQ985VmEhOGZyF1C1pK8y6eDgI9ZQXWudsgHvOsB0rlmzAoU9bru/nqRZzus1tGs4ntbsC
 BGrUCP/jgwDznpyvtCjmdCYm31WrSfIOsGYX7rLceyHNrEat0g5hbNTLVYjZI1ITx5AmSrYLoyq
 YjRCEa7eyzS0qCmhXCaH+zAXencOL5JQ4pbPObvLTIkTDuWhsJwEtGakFd003+/ThhDh0Io48y7
 QaeRI769mJg5+AFRwVHQ6rucFm4lVYGeNho3FFd1XXgA7bso/JP3X1PBepcl9IL8ICxZknqLeuu
 Co/kE+q9oYJjw8VY6zZifudFyI/gkjinBLH3GPnn4z4/9cvRGYgTgzAIQxPi3R0XjmfgkMOHXGl
 71A9uql3HGEGLBgVUya5YGSmyycWmK+dNPOqKF5wQ0PJGVfY9sV7sE5F7OdlePzzkEC7keQFhTC
 DQPDzab8OrgwAsA==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/8] syscalls/mknod02: Use relative path to avoid
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
ZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KU2lnbmVkLW9mZi1ieTogUmljYXJkbyBCLiBNYXJs
acOocmUgPHJibUBzdXNlLmNvbT4KLS0tCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21rbm9k
L21rbm9kMDIuYyB8IDQgKy0tLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAzIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbWtub2Qv
bWtub2QwMi5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9ta25vZC9ta25vZDAyLmMKaW5k
ZXggODlkZDFkODc0MDIzNGI3ODg1NTRlNjI1ZTY5MzY5M2I5NTQ0NDBjYy4uYmQ0NzZmZmY3OWNk
ZGU5MDczZGQ0OTY2NGY2ZmQzMjAzMWY5ZDk2NiAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9ta25vZC9ta25vZDAyLmMKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9ta25vZC9ta25vZDAyLmMKQEAgLTIwLDcgKzIwLDcgQEAKICNkZWZpbmUgTU9ERV9TR0lECTAy
MDAwCiAKICNkZWZpbmUgVEVNUF9ESVIgInRlc3RkaXIiCi0jZGVmaW5lIFRFTVBfTk9ERSAidGVz
dG5vZGUiCisjZGVmaW5lIFRFTVBfTk9ERSBURU1QX0RJUiAiL3Rlc3Rub2RlIgogCiBzdGF0aWMg
c3RydWN0IHN0YXQgYnVmOwogc3RhdGljIHN0cnVjdCBwYXNzd2QgKnVzZXJfbm9ib2R5OwpAQCAt
MzcsMTQgKzM3LDEyIEBAIHN0YXRpYyB2b2lkIHNldHVwKHZvaWQpCiAKIHN0YXRpYyB2b2lkIHJ1
bih2b2lkKQogewotCVNBRkVfQ0hESVIoVEVNUF9ESVIpOwogCVRTVF9FWFBfUEFTUyhta25vZChU
RU1QX05PREUsIE1PREUxLCAwKSwgIm1rbm9kKCVzLCAlbywgMCkiLCBURU1QX05PREUsIE1PREUx
KTsKIAogCVNBRkVfU1RBVChURU1QX05PREUsICZidWYpOwogCVRTVF9FWFBfRVFfTEkoYnVmLnN0
X2dpZCwgMCk7CiAKIAlTQUZFX1VOTElOSyhURU1QX05PREUpOwotCVNBRkVfQ0hESVIoIi4uIik7
CiB9CiAKIHN0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKCi0tIAoyLjQ5LjAKCgotLSAK
TWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
