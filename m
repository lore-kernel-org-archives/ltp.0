Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284D0C2D0CD
	for <ltp@archiver.kernel.org>; Wed, 21 May 2025 11:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747827693; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=Eyk+uBM2fQ4NekEGe++VDvDFpq8yqMtRJFvYBqvEiZ8=;
 b=PRPNnTSFidhNG7OO4ujXQIvMaqZjUtNi4RcoHspCrYoQcs29X7n0IK08gciQEh1vqZGse
 qmL2r5Mx9kTA3+55dE+ZXeUpKL0TJC8tv0N6Ay09KlVL4+KPLvxNA1nj9g6B9sWRVyFDh/d
 oboWQGKSUdmt5U3CjM2/ot9ACVPWtt4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B6683CC7D5
	for <ltp@archiver.kernel.org>; Wed, 21 May 2025 13:41:33 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E2D443C9AEC
 for <ltp@lists.linux.it>; Wed, 21 May 2025 13:41:11 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 43F6B601B08
 for <ltp@lists.linux.it>; Wed, 21 May 2025 13:41:11 +0200 (CEST)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a366843fa6so2674899f8f.1
 for <ltp@lists.linux.it>; Wed, 21 May 2025 04:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1747827670; x=1748432470; darn=lists.linux.it;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=R9LhmCvsEnC49d0dLU+mBU4Z8mmbC2RlX2+9yGdjxBU=;
 b=Q/oxAJhaNKH88i1QAiT56wK8VlcctodU87f7SYKnxVNmEmssJyEQ6JROKDxFNUjOkX
 kc1scZmBo3HwxKz08IpJW0UroY9gg34H+TcZEev6rtinM/QzhiVFr2wf7mrz+t/K6P5v
 Q6SydDBZ+H+1KF6IxtAk2ZreMuKgmNu72uYAmIBAO1qd0cqCEfAnAOz/b2HJVTLjLgA9
 ENFZGLTTyz1ZA4zxMWHXTm+kQ6x63n2vEJq1xx9aD6YuvJy7CKPmKDt5T5OcwJUWAXiq
 Yjh/dgkQ4zGkIFk6SHwvJeACeMLQMiR1Wfp9LTJDr4HCazzn9jbEuHN4wOgQNmv0Cf8e
 OUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747827670; x=1748432470;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R9LhmCvsEnC49d0dLU+mBU4Z8mmbC2RlX2+9yGdjxBU=;
 b=O/uiV+LTaBEbBbNWm8cwMpGR9KxN2JO1BTWNzXaDXbpWtptcr4ScaFFQ1TIcESnUJh
 oJqSLw13Pblev6XVqr7mS/Mnhe0ZUENnfAGO/+h10CMEpQsixIqJlH7OFKYX6G/s2jkW
 ihB4VC14TE1budtRdNzj6kVImx1lYfMefur3YpHVqVwW7QFtXdE6qHsnMtACVGikbF5p
 J3+mEiMNoSc9l9zxEHyOM29cf/kRQtSF4l+KlZEWI8L90eQ7hlxbsPib1URes4Mh20th
 HBVwQDDUeTsYVzn7zGJ9vc4ZuE+6dc/oKDdYC76/VP+Bsz8cz4m+PvJ6b87sxFQpy+yn
 5iKQ==
X-Gm-Message-State: AOJu0YxIBFMA3UTm4cCTin8PImG7YWbscJBdb5XIvsL0nEhS5IQJOAMa
 Ff7wK7+wXqqJ4+IouDxZEqk2LLRft2ZUJPKNJU/k6BVtBy6ley0k6bIbj+UQxJ/iTnYOL96ZV5C
 NpQDT
X-Gm-Gg: ASbGncvMDlotmqJpEVkGhxXGk0aCKIVU1m4zBakgZpz7TuRFmsHFRpVptxS4F94K+gc
 fJzqjoSNf0oMayczS4V4Wz9JC5TNV7guEYdPKTiaX5DqFwZAh7nBIYMriOo0nQ2sHB5qku8YSeY
 TF2qJzdFiG+xJCAcIeSjikJrw3eA2yLoDsJPx1f7WLA87+fblGFqAY00e2YUcd19ZhVyY0LyIxD
 ckpNaWqlL5TnZ/M76wFMst9/l2r2AfrnwxSxlBO/A1OFQzDjo1T0DlVGL+IgtE5lWFOfZGUemw+
 YtQJqD1q1PezfxYTBXaHYgyiXarPXvspbqouGCg=
X-Google-Smtp-Source: AGHT+IENOondfp0F7pyAJLO4oLfByij3IdJYbGj2eDFE9oxS7gUX7H5+Py+dJDHeRnS+607bmrUcBA==
X-Received: by 2002:a05:6000:4284:b0:390:df75:ddc4 with SMTP id
 ffacd0b85a97d-3a35ffd2864mr18153967f8f.44.1747827670460; 
 Wed, 21 May 2025 04:41:10 -0700 (PDT)
Received: from localhost ([177.45.162.169])
 by smtp.gmail.com with UTF8SMTPSA id
 a1e0cc1a2514c-87bf9b4f657sm7566592241.2.2025.05.21.04.41.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 04:41:09 -0700 (PDT)
Date: Wed, 21 May 2025 08:41:05 -0300
MIME-Version: 1.0
Message-Id: <20250521-fixes-modify_ldt-v1-1-1fe46dfd7b89@suse.com>
X-B4-Tracking: v=1; b=H4sIANC7LWgC/x3M0QqDMAyF4VeRXC/MFkS6VxljtDZqYLYjEdkQ3
 32Zlx+c/+ygJEwKt2YHoY2VazG4SwPDHMtEyNkMvvVd23mHI39IcamZx+/zlVcMlEKIyfWOMlj
 2Fjo3Vt0f5hSVMEksw/w/qsITl+sSdSWB4/gBVR+Po4IAAAA=
X-Change-ID: 20250521-fixes-modify_ldt-9eb99ab171ed
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=865; i=rbm@suse.com;
 h=from:subject:message-id; bh=GAewZxbca3cwtvcEuyD3zCjJR/i3PsN3ILPeAImvLbI=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBoLbvSYCxZG46d/8i2mNKccZHgqrRhFozQjCzKF
 vuY4E4wkGSJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaC270gAKCRDJC4p8Y4ZY
 pmbsEACpeZPK5zx4ThiRoaZg9DyIOb9xhb4XYMVOpG2C9oovzE4En15ToRS7SCToMTvLnNYGo5O
 QXUuFGluKjZ4buZ+B2+bceBUe2xYOevrYbvPMSlcdz1BstkhmI2BG30qX26jn1xoNv14lQEKASi
 Tg8lafHYo0jiLSKAULef4HIPnacNEUVRg2nWE2IvRcT147ehplTBrGFOHo/QP97uEOgQjGukrP3
 0E+7jvYpoe9eSlJv8hOZUaQ2WeWTcr/+em20onrulKYO7z+6UTVhDOOYjEBLTWRiAqstQKp2bsx
 jgvn7pCHZAFY9R5omUQ7rW+VWfGS4dnVlLSGWFfAP4RaNDaDRC0137XQJPzkkpE0c2mQCdwqt43
 DqhU7BNc5A6tcbn0eQh9qGrfnd3D9lRygxbnoZ+WLRgAEze7wUS0IvExi7D8n6Ne1tPK3BLjzu5
 IRHypdA3S201ctbCoDF9nfa+sWI+nPCFO53ZFmW/F5xE4M/vRxIVext3qbXS1SDHd6wz7Cpek+b
 b9YZ9Y/OsXN81sNH4IzxgoW+PNIeBIIq1RqZI3cc4bzeqnBKg5ebvznf1FvSryyD00Q7zz8DQAC
 Kwa2dJZGDO3bWE1g9bIzy4BfTjC4x2Yqf2zMcKB8t9s4go8aLvR/QbVBWKKC5J/AvLpl0Pp4fFZ
 VY7AWRl8P3vB1zA==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] ldt.h: Fix typo in modify_ldt()
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

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KCkZpeGVzOiA1ZDhjYjVh
M2VmMzcgKCJsZHQuaDogQWRkIHdvcmthcm91bmQgZm9yIHg4Nl82NCIpClNpZ25lZC1vZmYtYnk6
IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Ci0tLQogaW5jbHVkZS9sYXBpL2xk
dC5oIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
CgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9sYXBpL2xkdC5oIGIvaW5jbHVkZS9sYXBpL2xkdC5oCmlu
ZGV4IDE3MzMyMWRkOWFjMzRiYTg3ZWZmMGVlZTk2MDYzNWYzMGQ4Nzg5OTEuLjMzMWYyNWI0NDRh
NDhjNGM3ZjE4MzNjMzc2ZmI2OTQwNDAyOTg0NmMgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGFwaS9s
ZHQuaAorKysgYi9pbmNsdWRlL2xhcGkvbGR0LmgKQEAgLTQ2LDcgKzQ2LDcgQEAgc3RhdGljIGlu
bGluZSBpbnQgbW9kaWZ5X2xkdChpbnQgZnVuYywgY29uc3Qgc3RydWN0IHVzZXJfZGVzYyAqcHRy
LAogCWlmIChydmFsID4gMCAmJiAoaW50KXJ2YWwgPCAwKSB7CiAJCXRzdF9yZXMoVElORk8sCiAJ
CQkiV0FSTklORzogTGliYyBtaXNoYW5kbGVkIG1vZGlmeV9sZHQoKSByZXR1cm4gdmFsdWUiKTsK
LQkJZXJybm8gPSAtKGludCllcnJubzsKKwkJZXJybm8gPSAtKGludClydmFsOwogCQlydmFsID0g
LTE7CiAJfQogI2VuZGlmIC8qIF9feDg2XzY0X18gKi8KCi0tLQpiYXNlLWNvbW1pdDogNWQ4Y2I1
YTNlZjM3NDllYjI2ZWUyMmQ5NmM5NjU0YmZkZTQzMDMwZgpjaGFuZ2UtaWQ6IDIwMjUwNTIxLWZp
eGVzLW1vZGlmeV9sZHQtOWViOTlhYjE3MWVkCgpCZXN0IHJlZ2FyZHMsCi0tIApSaWNhcmRvIEIu
IE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6
Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
