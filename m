Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC49EC3ABD9
	for <ltp@archiver.kernel.org>; Wed, 14 May 2025 10:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747219930; h=date :
 mime-version : message-id : references : in-reply-to : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=/5iXOhfs/QpyFKPcd1ynX1TfvJ9wCsa6Yig88ZcV22k=;
 b=Bo1GXMbgsvnpIevPeMdW+BqkZUpMSXnh3Rcv9Y7jQ+pUQmAmNNSrvGV1yhCvrgAZ5yBd6
 p+euNX+Cta8xTvDRLdRFOqEFvMT/1cLmJoZFOl8r2PsrfXdCnu3ZA1K8TrkJf4DDYAK5rGe
 nITeydhMcOu2eXymys+PtPTGkH6L+rA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 26B6D3CC3AE
	for <ltp@archiver.kernel.org>; Wed, 14 May 2025 12:52:10 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A6EFC3CC3B7
 for <ltp@lists.linux.it>; Wed, 14 May 2025 12:50:19 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2AB881A009A2
 for <ltp@lists.linux.it>; Wed, 14 May 2025 12:50:19 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a108684f90so4078933f8f.1
 for <ltp@lists.linux.it>; Wed, 14 May 2025 03:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1747219818; x=1747824618; darn=lists.linux.it;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CbIK4taBpZHnx8vL5f+WhaMnltnRlXnb7TyuIqoN4ZE=;
 b=FxJnmQggrkU8ZF1Ech+1lf+/68asj+gppdtoelza0VgZj5KF7EJc0j40nF/3vomwzg
 E5PJV22FfLpfDkj/8OvcXEDfThMWSXpdWlUGQXHpd7TLpAKw3l3FzazeE6qVQVs9ccnj
 23wlnVot2eB7phVEcY2PU+XNp0SW1ewNArvG3MCE0nH04ZspzSJitSRye8tcCKWR6q/I
 uRWfMK+LEq4VUjfwZgVdWcedLCwd00G+p6SZ9SdJw+1hgHBhvGmVbSL7161HGAWjYslm
 sllxg0xHEVUt5IPdElSX5jswTGGzQmqPKKfFQV5lrXIjwpZW1oOmZ2xoUnlorhuOt26+
 l+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747219818; x=1747824618;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CbIK4taBpZHnx8vL5f+WhaMnltnRlXnb7TyuIqoN4ZE=;
 b=d1ebW00ZJqOwqvFpP/8FdAPDojbDUbmh4Rbr0LeTWxa3zagjntF3JmNW2t86RJFmls
 S3D1lMfp9IlD+aYzkPGHNXdDswGUEPxi4JByW1LW5AfgbPrhFQ2TvmqAZvKTCX9gu4UM
 8BPI5SZGYz02jmNlPOE7NMJrCXfWRN7Usf+RKqUfLxVJ/kE7KWoRrONVzxQrFLKQocVA
 wOxuckiNs01xkaIeRdhypYNWQSJ3Bi3G4XEsJshHfeM5sdcabcXMeDMeL4ZsSTcF6QXu
 7WVF6pPH3NmpvoNd8PPeM5QTcKZHi2pn7XdFZYZSu5kurGMBRIRedQM7ixFDcAnllmtg
 OSxA==
X-Gm-Message-State: AOJu0Yz54kIdA+oF6ApwnROYBVeP2B2zdzGKan258dvUd/qbGclcdPVv
 HM0w1kOZc+YKgatNgv+5pEa5jknWH1i+kfBhjfaMqESVQUtBP5unEzWLT/MdjtGsrJ/dEaec+Sx
 2
X-Gm-Gg: ASbGncvUv/WF7emN9rU9tm4m36z6BBX3QeQKiwt9VOfQ45QMyNhARVy4DfK2paf390a
 /vfeiSalVVxQYyB5ABEnf2IV6LXAtg9wSK9cCyzhWYwf3eJPlzHX9fN2atTvlauMz0nbKCo3gu+
 Wn597wLNhEM81CZtvSvGDyUTGeC+YVNf3DO7kRzuQNX05fj/8BXF4ovJBbUpvPulSjuRtsrmdHW
 52vT+YLoxI4PGmWU+9kf0M1Hm8fUZ7xxpbS5wL9t2H9CNYasEp5xaUGwOrhztER76BRfObUqB2F
 81DHZ4YOAZFdkOo3mSZZihsJhTQp13fMrgPY0Ms=
X-Google-Smtp-Source: AGHT+IFP1wUnFhSUPyVYFgYQnGXdPqjkuvlU5idMURHpBSO9RZNSIaFtoT93jxzmXsSFJA3l0ty6wg==
X-Received: by 2002:a05:6000:2207:b0:3a1:1227:149f with SMTP id
 ffacd0b85a97d-3a349695c44mr2420772f8f.2.1747219818358; 
 Wed, 14 May 2025 03:50:18 -0700 (PDT)
Received: from localhost ([177.45.162.169])
 by smtp.gmail.com with UTF8SMTPSA id
 71dfb90a1353d-52c53726493sm9154550e0c.16.2025.05.14.03.50.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 03:50:18 -0700 (PDT)
Date: Wed, 14 May 2025 07:49:57 -0300
MIME-Version: 1.0
Message-Id: <20250514-conversions-kill-v1-4-cd633e941e8b@suse.com>
References: <20250514-conversions-kill-v1-0-cd633e941e8b@suse.com>
In-Reply-To: <20250514-conversions-kill-v1-0-cd633e941e8b@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1132; i=rbm@suse.com;
 h=from:subject:message-id; bh=oyi+CiosfPvLj4uVSBxGIsasmkhFUxLTAkFgg2nUo0M=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBoJHVa/nnVZEYTtntEjlUGhikEQSpnWaWiZ6cGJ
 tc6Pg9hSB+JAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaCR1WgAKCRDJC4p8Y4ZY
 pn4WEACdHLfhnn42XVvvHq022gIAVunMwHeVjHLk5gYTo/xB1mO9LVvMlBOWI3fr/37EmCoym8Z
 DqBmo/QFaqHB3lv1xMMWscFj2d3edj5UY7OgY1on5/J4SW4B8eNePZQGyH+9FC/DWe+djNHlx6T
 3HRbEPniIECwmvqFnSWj3DyzbAtausuzFH6Yv3wxE3LD6XqYQolioIS6Lm4lE1HujlAFZIMDUEu
 lNYveweevmQNXVVGDMER8NqQrknq3MXSXbcjfo53oVTJB7Q6cYTCrZGUjplTvXSF4zmUDerr0Ik
 eqy08UHBo9GwkUERYGTIvoiaUBi56NI1AUmlSKxxKfEzxcg3kb+dbNI9C06yRBHPkWNGlAB2e+j
 Ctc/lLhh5neHFfxO0+S5G7pA6jJCUllmhbGpRbJsj5tq3MwSiOrai7bFK9g4d8nBs/CSvE3M+/c
 cWHD/zDvqRRy2kl1GfJJaEVM7Uk3koh886CB4oDXfuNxl/tERSJ9VRi2tXMpfC900n+IZV/TxdX
 QZ7tGdO3GgaVlfFZvNoBfkwsHGPxLz69n5fDh+hI2DXozM1ny5IGNxDl5p7A112nWMr7f5dAJ3y
 /avzWeqSKg9X2cOkiK3TXAcTlVXcbBHCAlHXace3QWFxwABbPLx99s7biElurSES+JDM30aWJ6v
 tIJNgdf+mRl+zYw==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/6] syscalls/kill11: Fix test description metadata
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
bC9zeXNjYWxscy9raWxsL2tpbGwxMS5jIHwgOSArKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA1
IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9raWxsL2tpbGwxMS5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9r
aWxsL2tpbGwxMS5jCmluZGV4IDkxOGYxN2YyMjEwMWVlMjY4M2Y5ZDkwZDVhNTMwZTJhNTA0MDNj
MWIuLjNjZjYyZmVhZWQ3NzdjNzZkOWZkMzlhNDhiMjU1YmYyZGE5Mjc3MTYgMTAwNjQ0Ci0tLSBh
L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMva2lsbC9raWxsMTEuYworKysgYi90ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL2tpbGwva2lsbDExLmMKQEAgLTYsMTUgKzYsMTYgQEAKICAqICAgQ29w
eXJpZ2h0IChjKSBJbnRlcm5hdGlvbmFsIEJ1c2luZXNzIE1hY2hpbmVzICBDb3JwLiwgMjAwMgog
ICogICBDb3B5cmlnaHQgKGMpIEN5cmlsIEhydWJpcyA8Y2hydWJpc0BzdXNlLmN6PiAyMDE0CiAg
KgotICogVGVzdCBjaGVja3MgdGhhdCB3aGVuIGEgY2hpbGQgaXMga2lsbGVkIGJ5IGl0cyBwYXJl
bnQgd2l0aCBzaWcsIGl0Ci0gKiByZXR1cm5zIHRoZSBjb3JyZWN0IHZhbHVlcyhzaWcgYW5kIGNv
cmUgZHVtcCBiaXQpIHRvIHRoZSB3YWl0aW5nIHBhcmVudC4KLSAqCiAgKiBSRVNUUklDVElPTlMK
ICAqIFRoZSB1bGltaXQgZm9yIGNvcmUgZmlsZSBzaXplIG11c3QgYmUgZ3JlYXRlciB0aGFuIDAu
CiAgKi8KIAorLypcCisgKiBUZXN0IGNoZWNrcyB0aGF0IHdoZW4gYSBjaGlsZCBpcyBraWxsZWQg
YnkgaXRzIHBhcmVudCB3aXRoIHNpZywgaXQKKyAqIHJldHVybnMgdGhlIGNvcnJlY3QgdmFsdWVz
KHNpZyBhbmQgY29yZSBkdW1wIGJpdCkgdG8gdGhlIHdhaXRpbmcgcGFyZW50LgorICovCisKICNk
ZWZpbmUgX0dOVV9TT1VSQ0UKLSNpbmNsdWRlIDxlcnJuby5oPgogI2luY2x1ZGUgPHN5cy90eXBl
cy5oPgogI2luY2x1ZGUgPHNpZ25hbC5oPgogI2luY2x1ZGUgPHN0ZGxpYi5oPgoKLS0gCjIuNDku
MAoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5m
by9sdHAK
