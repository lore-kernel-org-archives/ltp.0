Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF94EC021A4
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 18:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740423343; h=date :
 mime-version : message-id : references : in-reply-to : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=M2mSeGgNM0HLjfun39WpAJzkclf165ofwqFWtVDF0vw=;
 b=ehYp1NgsOEuu8nehh/KO1Ss83/fWgbq+vpbhb2OyzjwscNcyt4KxsIKu9LKIYxGfoaq0j
 6iukN+ETMvBGVdO6oGHO++ONlPrUUK7L4lzN+3TbF0rLkeh8je2rnDvlc+HyD6MzOLUrDdp
 F0efHoF8x0VAbd4SqXXVc/28ty3dnlE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 333A73C9A15
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 19:55:43 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2047F3C9A18
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 19:53:32 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9A7AD62DC4E
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 19:53:31 +0100 (CET)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-abb79af88afso879195066b.1
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 10:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1740423211; x=1741028011; darn=lists.linux.it;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ltaTv4tNlhMQTu5+0qYGTi4iAkWkkfGJ9KPNkEIiFqo=;
 b=RJ0aV57toC52GYnr97nAwTwD4yXCuCMImrFQxRBp4DxhNUkjBSVNc9X8mywa3+7DUh
 tgBDk13jK7oqbeDB+3mQ1oKZZwAENWCLa+Hy6i1VvsMUlV+05jzbjv0XpZSUVh6bEXbq
 ajrt7uPrXP4/zmtaoATzHBp2iLej80SWoLupej9bOta5KJ+4GlO6mU3qKx2FZGetxDjs
 Kug5lrlH6rcwuKZYVULrkJUmVgUE5r4JRDFp0oTymdiHhRaBqdgDT+WzF9+kI+9F1wbc
 ROGz6Q2cJwv63HglkcdgsXNjqscucDWKJCX0OlUavj8BzJd0N8AffVluLVUXvCkHcl8U
 S/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740423211; x=1741028011;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ltaTv4tNlhMQTu5+0qYGTi4iAkWkkfGJ9KPNkEIiFqo=;
 b=teXLmdJkARl0VIm/iGCdbOqDq+7oIFlchqLaSVjIzCsmMQuXVlc03UX6SxPkS93wuO
 aOvupTuz5lwCxbY5A8NrGw6zSwDkuEIScyh6zL2CVbxKuT4Fx54cA+uk5/UHNLLxHqHe
 D+PxZfJBVgejeJKHwBPrJF81/ENEx1X2AzH+n7SySDXUAQ4viW2NMH59cmc+LWCduMmj
 1xSASM0DGWwHQkVzASLWLghxt02cJM0Z0iFw/KQv/ZOQ/TDbP7hQ0INqmmApSGz9Nwbm
 bHjIwQHol5Rtg1D8xoP8uFXk6OZmu6BC3KI4G7zO+6QwI7u7F7O5W1CYRv6lXAyzRD8W
 QJnA==
X-Gm-Message-State: AOJu0YxCZYpitrPNLoadAnAJeXRALFYIt7JOutwtCmSDsM/Awm3pJs8s
 nBo0daSpnQsJhSV8DalfE1D8zxjAdDmOtuLecDk7I34LEGlf7Nr+/kwydNLo+m93EMUw9kS4FRK
 W
X-Gm-Gg: ASbGnctf/I2Dk67Xk9JWfS4uFy6VoUp2mjh9ik5VjSezjBgMz089sJ21z5AT5YHp6ae
 MRoU8RHVOrl2XAiR3/t2F5JAn/iPTKJ3sBGIAOWNfrRMxJPO3xJO5NUVTsnTSaAWeXr3qbyvMIO
 270EqnRSeIqe7Dhd8FDwnH/uTIT0NbIGTh5l6r0+Wx/tg7znS+nlbWkdcVptQoytSKnBDCFEas9
 IO2gJnd6gCRlt60uaJesMU9kf7H53u0iQgOszZ8OaugEIxQcA4Xgo+iwpb9NqDS9Vy6QkW66pSa
 X5mRN2UGx4tksWA=
X-Google-Smtp-Source: AGHT+IHIAnFK04EvUpJGE7z7xlMsllXDptI0F61wmVGPFYyIkAssFz3RBRSs+DYcBtNeITLO1tryjw==
X-Received: by 2002:a17:906:6a19:b0:abb:6e95:b272 with SMTP id
 a640c23a62f3a-abc09a8091emr1455095966b.30.1740423210968; 
 Mon, 24 Feb 2025 10:53:30 -0800 (PST)
Received: from localhost ([179.228.215.131])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2fcbab3157fsm12066348a91.1.2025.02.24.10.53.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 10:53:30 -0800 (PST)
Date: Mon, 24 Feb 2025 15:53:06 -0300
MIME-Version: 1.0
Message-Id: <20250224-conversions-pause-v3-5-5e3989d37f1d@suse.com>
References: <20250224-conversions-pause-v3-0-5e3989d37f1d@suse.com>
In-Reply-To: <20250224-conversions-pause-v3-0-5e3989d37f1d@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=921; i=rbm@suse.com;
 h=from:subject:message-id; bh=YDNkQnT1Nx9OkdiezWQ3BJUlq8jOCmrTG0NyLgV0zmI=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBnvMASCMUSOVCvGywc5xOUWXxkORSBbGTQlO0Mv
 hZIFZNr8YGJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ7zAEgAKCRDJC4p8Y4ZY
 pg0KD/9usS2TMuid86owOe0TOqtNJ1MO1yi9XgCcK8h5P9NHAARRyr+0Fr+koSVeoQ8ZRAay1FN
 rCH1uFHLUQpYIV6HSJePA8axGfsRof+hMN0HMqrO/4kiIWTyLAbJxUpoALnp5pDk0zpXN7x+Trm
 i9v2TRRxIcyKzjoNHAw4TwvuITNbOsmNR/8MLloxcCcSzTm6kunaNmfpBWTmmNYUktzfsh2Y+mP
 WsKKzRb94QJ6nz/IIFDSaT0ps8GsgpJS1wb6hcm0PEzgPshVeCfaa4g9mR4bKYXplMFaN4xICfy
 RTp/1EmBhoT20vrnkDHvHVlu4UvVeDcPcywoswUiSFoqdykIA3rCNDdwoOb84oU82d8Fi5x6I3I
 QRA8uQeJjeYF8NfJv4xKGixXY0n8Ho4nYzq2jDeGt7lvwoJ8DG1oNQgGbvDPvS1+xnBbqN/V+v5
 N63fxmg90cwVDI05QVYLMo3IJXIFc75H7TxFohjmnzYmd7DK8oCUkrWsg2xTInTTqaTioU+UeEt
 OiwuOO59vhdqjMF+fKgRC1FqgJMVkrjQfNihki1H8Ibeykc8K7lfsNkY6jqg1jw/5Ynu774QnKy
 mxCFa80LqCwZs/jhGP/90wfRTJuW/OmPaIhvLwvIU4S9lgFPS5UoHzht3yQD6GpP9BN7ACuhoRr
 MbVu61WkVBjC99Q==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 5/5] syscalls/pause03: Rename to pause02
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

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KCk5vdyB0aGF0IHBhdXNl
MDIgaGFzIGJlZW4gcmVtb3ZlZCwgcmVuYW1lIHBhdXNlMDMuCgpTaWduZWQtb2ZmLWJ5OiBSaWNh
cmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgotLS0KIHJ1bnRlc3Qvc3lzY2FsbHMgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMiArLQogdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9wYXVzZS97cGF1c2UwMy5jID0+IHBhdXNlMDIuY30gfCAwCiAyIGZpbGVz
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvcnVu
dGVzdC9zeXNjYWxscyBiL3J1bnRlc3Qvc3lzY2FsbHMKaW5kZXggNjZlYmYyMGQyYWE5ZGZhMzZj
YTliYzVlNTU1MzZmNWE5ZGMwZTgzZi4uZDNlOGQxNmQyZmZiMWIzZTFjOWVjNWM4YjdjMzZmMWU4
ODZiZGRhNiAxMDA2NDQKLS0tIGEvcnVudGVzdC9zeXNjYWxscworKysgYi9ydW50ZXN0L3N5c2Nh
bGxzCkBAIC0xMDEwLDcgKzEwMTAsNyBAQCBwYXRoY29uZjAxIHBhdGhjb25mMDEKIHBhdGhjb25m
MDIgcGF0aGNvbmYwMgogCiBwYXVzZTAxIHBhdXNlMDEKLXBhdXNlMDMgcGF1c2UwMworcGF1c2Uw
MiBwYXVzZTAyCiAKIHBlcnNvbmFsaXR5MDEgcGVyc29uYWxpdHkwMQogcGVyc29uYWxpdHkwMiBw
ZXJzb25hbGl0eTAyCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3BhdXNl
L3BhdXNlMDMuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcGF1c2UvcGF1c2UwMi5jCnNp
bWlsYXJpdHkgaW5kZXggMTAwJQpyZW5hbWUgZnJvbSB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L3BhdXNlL3BhdXNlMDMuYwpyZW5hbWUgdG8gdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9wYXVz
ZS9wYXVzZTAyLmMKCi0tIAoyLjQ4LjEKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
