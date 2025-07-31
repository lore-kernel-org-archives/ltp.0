Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2EC2C83F17
	for <ltp@archiver.kernel.org>; Thu, 31 Jul 2025 09:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753955517; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=cFQweSzZRW2I8hA8Vb1qudmZjOKwBvAg7oeKnfxUiSI=;
 b=l8KyfE5jdHn5I82NMd9jaYDvsB1PU3Cl1eJm3f8sTL0okgINcHSrSbJRu3xOgIzTNiBvj
 DH8BTGprkfMuH7o1pYGEnAvZBnM2p8yZ5dqW0IPHYtEYmQ2yzYqu96nuUTXXfCgcS1E5Q3y
 /CytIr7006lScHI7nV/Xs1HzmIiv+BQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E006C3CBC2D
	for <ltp@archiver.kernel.org>; Thu, 31 Jul 2025 11:51:57 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8771C3C0980
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 11:51:38 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C5B8C1A00A45
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 11:51:37 +0200 (CEST)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a54700a46eso423447f8f.1
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 02:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753955497; x=1754560297; darn=lists.linux.it;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WUCh6gDYfLmeogzWlSDTfOaFbD98KPnb0TKsFlXla/g=;
 b=brdwhOQ4FabtUe+JQStfVeeg6a3lKmb5TUanOcgzVQQeA0Z7qQkCiEUaPHCJgeuGFm
 EcEE/OPIyKB6tPuGUuGrcEiCSa5hOiJft1TLeEpLAD09/djaaRooWos5QAe+zUt/Plg8
 6x7/kLgT4UYthJa/ts+prTYl1EQFnOCcC+Gqp6NGVzDtUGb5bGuvxrImiv12fsoxTCMk
 27io6FbE1ZKMj44Nt/BURCU05H/WM9noX/XCl4P/I0Seboo+4a6hX03BIcE3T9Qmk6Xx
 VlkuNX1FYAbs3T4vUKhSxZ6VbbHV5k0B9Y4ODNnnzKjnV2hk4rF/5Boe7ycnkhc0VmkJ
 k/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753955497; x=1754560297;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WUCh6gDYfLmeogzWlSDTfOaFbD98KPnb0TKsFlXla/g=;
 b=X4hvKcN9VtgoBdcwqVGD05WbN+q5WltvGN15PFnTNY5takDcGpteiqXisljTephcmk
 qG8jBRbmQlvh79ofL8vg3kBjvATKojym4U1EEqzOyXOYycpZNIN56jdlk8QD5NRgBM/0
 RUREiVkFYyd8Ta+V4fwwfilPYpcngj0NlCtvhxg1P6bI54PkYFCW+z0amt7yIClSsEQU
 kbUHLto79FJVitPbKhLe3sakHVtAgllS+mOG0Vi29hv4o24d14jwCYCTpqD18GizuZAD
 LQBePxDdwVov+gs9qYxF9ut3y7oPtxOLw4fVKo6u1kUSsPhRdAPPn4pi0qlCw2m7Xuu6
 JBqg==
X-Gm-Message-State: AOJu0YxwRkgb86W18vVRHUXbGvqMDzLiG6R0O2U2+hM+EDHp8J9ADu8x
 iDAbpA+K3esf+UmhpUPgi6hERyGxaUc0TSO0F4FCDdugaQYwHUqNaomdPwd6ReRhh0pX1w878u8
 8ILcS
X-Gm-Gg: ASbGncvg+vzZzpktQ8t0Em8+KluPVqnS5hexvmd/qnk5D0sgE451N7Q3S4ubPIIXGUo
 8TkP0qLKjObbMrXlsuoNYnllwlk0mD5kwFgVZWZk1Pi0IzsU+9lOSw8oRkUoWBygvyXutjN2iYE
 I8G5KlS9+S4Hc7aGuNEkepDLGCha0wV/M7E7Bdoh5r5oFF/mh/GVqxdUVWJ2+xpc/YI8BmdE0ZD
 gZ4YDxiuMT0ABNiiqy7lbbDHCoHvR6/mSrnGH81o7zqriCp+veDM47mYEXlaWfBcpi832h/fm18
 2laRcGkadSlfqty68JuhjHrL83FzI3fTyM/gs5Jwuq3EoqdLFje5i9CfBUU6L4g/49oIG7NbMrT
 TdIvcOID+yecbmsGc77NF
X-Google-Smtp-Source: AGHT+IFDYBHx1riUvLqHyT9+Qdnscn4ZAvu83mj/wpmGqxMeqkvsbrSq3rcX8ddiTXpBWKOFoiPjQQ==
X-Received: by 2002:a05:6000:2484:b0:3b7:8c83:db1e with SMTP id
 ffacd0b85a97d-3b794fe92cdmr5491060f8f.33.1753955496857; 
 Thu, 31 Jul 2025 02:51:36 -0700 (PDT)
Received: from localhost ([177.45.162.214])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-241e89769absm13579015ad.80.2025.07.31.02.51.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 02:51:36 -0700 (PDT)
Date: Thu, 31 Jul 2025 06:51:33 -0300
MIME-Version: 1.0
Message-Id: <20250731-fixes-munmap04-v1-1-995c33b79fee@suse.com>
X-B4-Tracking: v=1; b=H4sIAKQ8i2gC/32NsQ7CIBRFf8Uwi3lAsdXJ/zAOlL5aBmjDa4mm6
 b8LnVx0PMk5966MMDokdj2sLGJy5MaQQRwPzA4mPJG7LjOTIDXUsuG9eyFxvwRvJqg4SGiU1Rr
 suWU5miLuRm7uj8ytIeRtNMEOZcYbmjEWcXA0j/G9HydR9J8fSXDBUUnshej0pTI3WghPdvSsX
 CT5v5a5FnUjlKrBAOJXvW3bB5IX+fcCAQAA
X-Change-ID: 20250728-fixes-munmap04-02083c550c6b
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1645; i=rbm@suse.com;
 h=from:subject:message-id; bh=DsKazJ4eb+JJL8G8vaQd0/RhbWVGBgTZSyzT5UW30tA=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBoizylzI1mwNexpTloJ3pAjHbq1wpnHWkBTNM/8
 0CGPWW/+8mJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaIs8pQAKCRDJC4p8Y4ZY
 phxRD/9LdqJFy0p0MmgTyaVtXu+KIlY3+K3ePyCVd8jYvAXECAkJug1w43S/aRfCpJhTDhlTNBs
 uGdQGmVWCCajvx7GpLHSapj9kJ1SOSdChz/KU654Hhr8Bd3krkrpthspgeOxmK+rURhxZGzAppP
 r15qAmiuyZW+DG8nKmBt3MqIOPszBP5SYZdsaDL9heQ0jZCflMtomcJnBxR34iDIxZ8hHWVAhDP
 +Js+XucjPpDraAABPqOwb2+O91MPFrlUSB5MApxuNRnomfykCeYXvWvmYOVvXR8Dy0JwxgXRa0B
 3ckfqWZ2BySklbdG1BPmaL9ZEKgosroVVQ4AWmvj9TdE9pXEgJDyiYRQDPEMLB2/YIZi+DMYFdl
 XZm+sMUnr4E19NCu8EJqae4lXHeXibIWHj3Wa7JTZter9nSQsgArF2DlzA+ftgfjDOtom8PLnYS
 7850EfEmcs1XV1nM3qW/zRLWXlAL3jK167mAPQG8iPzE/fLpc9ocT8XA3edoGw2MOUvrfTjL4Jc
 tt5vgCLmyfB8Ql7VQ9EoP6dRbS+UcngEJVpW8AK3HlrF/D95dgTM6e/5mGHUxdcPH/bdVbT+6Ky
 +iLf6T6b0HOcCee6gJy/UipyAS8ZRGo9IAzBk6KgXxdagBbBNehKy7CjAQzTZq7Rb+WRPSezP93
 vyqgQ1H9ryzkqpg==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/munmap04: Increase target map address in
 case of EEXIST
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

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KCldoaWxlIHRyeWluZyB0
byBleGhhdXN0IHRoZSBhbW91bnQgb2YgVk1BcywgdGhlIHRlc3Qgc2hvdWxkIGJ1bXAgdGhlCmFk
ZHJlc3MgZm9yIHRoZSBuZXh0IHRyeSBpbiBjYXNlIG9mIEVFWElTVC4gT3RoZXJ3aXNlLCBpdCBt
aWdodCB0aW1lb3V0IGluCmFuIGluZmluaXRlIGxvb3AuCgpGaXhlczogN2Y3MGRiMzllYzQ1ICgi
c3lzY2FsbHMvbXVubWFwMDQ6IENoZWNrIGVycm5vIHdoaWxlIHRyeWluZyB0byBleGhhdXN0IFZN
QSBjb3VudCIpClNpZ25lZC1vZmYtYnk6IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5j
b20+Ci0tLQogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tdW5tYXAvbXVubWFwMDQuYyB8IDkg
KysrKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbXVubWFwL211bm1hcDA0
LmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL211bm1hcC9tdW5tYXAwNC5jCmluZGV4IGFl
YjkwNTI4NmU5ZDQyMTRhYzY0MjNlZjI2ZTk1NzA2NzRiNjA1MzAuLjEwNmY5OWUyN2Y4MTMxMzA1
NThmNWY1MTcwNzY0MmYyMmIxODkyZTIgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvbXVubWFwL211bm1hcDA0LmMKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9t
dW5tYXAvbXVubWFwMDQuYwpAQCAtMjgsNiArMjgsOCBAQCBzdGF0aWMgdm9pZCBydW4odm9pZCkK
IAogc3RhdGljIHZvaWQgc2V0dXAodm9pZCkKIHsKKwl1aW50cHRyX3QgYWRkciA9IGJhc2U7CisK
IAlwYWdlX3N6ID0gU0FGRV9TWVNDT05GKF9TQ19QQUdFU0laRSk7CiAJdm1hX3NpemUgPSBNRU1T
SVpFICogcGFnZV9zejsKIApAQCAtMzYsMTUgKzM4LDE4IEBAIHN0YXRpYyB2b2lkIHNldHVwKHZv
aWQpCiAJCW1hcHNbaV0gPSBOVUxMOwogCiAJd2hpbGUgKDEpIHsKLQkJdm9pZCAqcCA9IG1tYXAo
KHZvaWQgKikoYmFzZSArIFBBRCAqIHZtYV9zaXplICogbWFwX2NvdW50KSwKKwkJdm9pZCAqcCA9
IG1tYXAoKHZvaWQgKikgYWRkciwKIAkJCSAgICAgdm1hX3NpemUsIFBST1RfTk9ORSwKIAkJCSAg
ICAgTUFQX1BSSVZBVEUgfCBNQVBfQU5PTllNT1VTIHwgTUFQX0ZJWEVEX05PUkVQTEFDRSwKIAkJ
CSAgICAgLTEsIDApOwotCQlpZiAocCA9PSBNQVBfRkFJTEVEICYmIGVycm5vID09IEVFWElTVCkK
KwkJaWYgKHAgPT0gTUFQX0ZBSUxFRCAmJiBlcnJubyA9PSBFRVhJU1QpIHsKKwkJCWFkZHIgKz0g
UEFEICogdm1hX3NpemU7CiAJCQljb250aW51ZTsKKwkJfQogCQlpZiAocCA9PSBNQVBfRkFJTEVE
KQogCQkJYnJlYWs7CiAJCW1hcHNbbWFwX2NvdW50KytdID0gcDsKKwkJYWRkciArPSBQQUQgKiB2
bWFfc2l6ZTsKIAl9CiAKIAlpZiAobWFwX2NvdW50ID09IE1BUF9NQVhfQ09VTlQpCgotLS0KYmFz
ZS1jb21taXQ6IDkxZmE0MTNlYjUyMWZkZTgwZDU3Yzc5YmQzZDJmYjVjYmU0YWQzZjQKY2hhbmdl
LWlkOiAyMDI1MDcyOC1maXhlcy1tdW5tYXAwNC0wMjA4M2M1NTBjNmIKCkJlc3QgcmVnYXJkcywK
LS0gClJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+CgoKLS0gCk1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
