Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 066A0C021A4
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 16:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740414456; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=HThekTZQuSn9QkhmRFof3ihP2qzHYn3KerAyuTuwLQM=;
 b=b4195682Vu+irL4geLlO+BcZGEVQiXlZrKOHoM19b1WOlT9iBAkq02AuNiSbmO4jOF6zN
 HaeaLgzrawTA9LshAkW8jVuLdGXczfaaFQgzdqgirKBGUrW0r8wMGOFRLk3WP+8Sa29g9xM
 RupoP1Gw70Cqur7mWI/aRymEWDmRjF0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2FDD53C99FD
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 17:27:36 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C7113C98E7
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 17:27:14 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6D71B142036E
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 17:27:13 +0100 (CET)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-abb79af88afso850869566b.1
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 08:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1740414433; x=1741019233; darn=lists.linux.it;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EDyDSAkjq0Nox8ZYtF6J8Ltzq4/Q6P7Bh2/FgJqOnYA=;
 b=Iw4ZV3xDqIUAwnbSEEWxYB0dOfdzhZPHCIiY0uF1lYwo02nRYxtOSfjUhfe7g+TqNz
 Lbg+SJ8Fyah/hdoV/vfQqDdFQtBAju4Pq6TsQteXrwifPPv6Z3eIJ/5nkdW/JlOvzmx0
 qwIx9gUy1dhjGP00bABLVBarpmjgHFqteZ+CnXQmlcvaI6PBOOTiXuBzMB2duVapBT6q
 ejbLts99ujfIsbrvQj+vjtfoxh8vGs4NJ8wa1wwv/IgIq7dF2roR9j5ucnPE3M1oYuLW
 qlDqZVc/8lpinZz+hsb/EuzfFLchuqIrvibCcpXOd6HrijzEKv2IgaPhF2va6z9/eY89
 IMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740414433; x=1741019233;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EDyDSAkjq0Nox8ZYtF6J8Ltzq4/Q6P7Bh2/FgJqOnYA=;
 b=bEWsIndfl/oU+GrGPXyfdbxpr2cI7KJz8ECDll/jSAa6LdZfsZQhs/iSNnciLa1wUp
 FYak7R+aST7DzF8HxRrFs2WyGWtxfa0h2wpWYcidoFwuMCP79hrcbyHnDK42yuivTowL
 94d3metuSR+ojYTbDZOGFzN9EXFhi2BTZn/mVZ1RV8Si1ma0kNEfGEe0MpTVgzIFizQ7
 fI9aPd4EmJUpBV+sHZ/Xj+oMPCs2p3FWalLhA/Uy0H2VN6MSYWcqNOW9FuLaCyNNX1OL
 8/vadeIKzC//IDCfB6YN2B98ErcT5ad/pNx6IJz+isg1qeJZ3yTCNPImZMwrdRRKy7aA
 SsRQ==
X-Gm-Message-State: AOJu0YxpL8pSJWCD+S+xnnV5kXF12ZVUaRAf2vZUX5pOwmYIdXylwOZR
 zaDbo/S5kQhk59lMBfLy+yeJeZ6/Qh+JjLi7szaCbnFg4hjuzcymELLU/RuAyLX9rWlmA826FfN
 x
X-Gm-Gg: ASbGncuuESDGNNk7pOdf1z+dqNBvLC1ZTxWzgJ5G7fmhc1a3mK5OlcpWwXveVhgMS+6
 11uPEFNM8LgRmryMJv0c6F9bCkJpkIImUd1LVgmij845e2qa8+I6ZlksdPA2cbnXjSJYz5nCZ9t
 wH3WG9+neE28je68zKF9UHU0xifNzVzwzKGpxmz5Kd7RS7Zyjyz4S2jeSVVHbxl8RvbADnNV2F+
 Pk3DdnV5/TrEvXQigixkWmrk/wdkK6YbP4/J76F4lbGTqt9arN5Jy3uDWLIJ4nc9kwUbCFR9I9u
 COypcherJ/CX/qg=
X-Google-Smtp-Source: AGHT+IHo8uwe45CA82peuCw+yaRj3TKK5H6pQl6cavqtLae1TEdq5fkssVIoiqhs5d1HsNAg+kCEsA==
X-Received: by 2002:a17:907:1c07:b0:aa6:7a81:3077 with SMTP id
 a640c23a62f3a-abc09e394a1mr1262076366b.54.1740414432778; 
 Mon, 24 Feb 2025 08:27:12 -0800 (PST)
Received: from localhost ([179.228.215.131])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-7325f063782sm18552573b3a.148.2025.02.24.08.27.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 08:27:11 -0800 (PST)
Date: Mon, 24 Feb 2025 13:26:59 -0300
MIME-Version: 1.0
Message-Id: <20250224-disable_virt_other_getrusage04-v1-1-bcb433af9635@suse.com>
X-B4-Tracking: v=1; b=H4sIANKdvGcC/x3N0QoCIRBA0V9Z5jnBZAvsVyJk1EkHyo0ZW4Jl/
 z3r8bzcu4GSMClcpg2EVlZe2sDxMEGq2AoZzsPgrDtZ52aTWTE+KKwsPSy9koRCXd6Khexsks/
 RIXo6+wQj8hK68+c/uN6GIyqZKNhS/WWfqJ0E9v0LkIsYookAAAA=
X-Change-ID: 20250224-disable_virt_other_getrusage04-c9db2aa9e69c
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1525; i=rbm@suse.com;
 h=from:subject:message-id; bh=mLmgx0qW4/dBWiKrQaJgYcwcAxu/KMQciRHBynv3W98=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBnvJ3dp+J9RW7ycgWXQgJEU2AiWbcR24XorCDHH
 tHU3lgOLqqJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ7yd3QAKCRDJC4p8Y4ZY
 pkr3D/41bp/G8oajUIijiZybiCMHtQn1gI7UgZRrfTk7UZRwiBg1rzOkILhbkpkqvxr7xvMtC6O
 Pre7K93ql7qniOe2fR2f/oosp8NCQT0D2YS027e5Peb63gBMXp1Jl5CadzDH05iiFbJl++caLsF
 8RJdVI/NCxZ8qwf63FD8qFNJZRMDzWQ9UoirwQak8lJcrAnJKasoWoeJiRQbVLPqgQ67ZUIgGQ6
 UDRUMErYk0MjT2jmFoiIJ6p3Hw51VL7WDXtKqjpFbT9N3bJPkSA8uqYyq/D8viQqS9FcGpvCDgJ
 SlxKVvs0Avs5ehn519XaGhab48vZ2oyjg3z2tXLTD8WHQf82oMg/8gz2kZyD3IrfeZaEmH25eOS
 rghEkq3fKGnfThA1FTGJwd67Fa7nuNa3Z8wwA5kEXwafFhashn/RR32la5t2OPT1vNAjoyU5i2f
 mMoMq88uhsKs4vi0fMZN0kkWdPlf27j8j/dpvZ3ZQRcRI9BkLX8eaMwWJGlXTT2Tw0JUr9YM1Pq
 qhCIFQPeRBu3+5fBErgUACd1PJE/IkR0Y6hwCHGtBEYJ+J7K1mLgJTknuWnff+3uh5j+4J8R5fT
 7c+uaY0gcjUIqDKBn15E13lX3pXCuanb1Fz9ukD9WoMw9+hGxVsCwzSaXU8+dLl0gFJHSpRKuv7
 Lie+qeTfJriBtxg==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/getrusage04: Disable for VIRT_OTHER
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

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KClRoaXMgdGVzdCBpcyBr
bm93biB0byBiZSB1bnN0YWJsZSB1bmRlciBzb21lIGVudmlyb25tZW50cyBzdWNoIGFzIGluIHRo
ZQpjb250ZXh0IG9mIGEgY2xvdWQgaW5zdGFuY2Ugd2l0aGluIEFXUyAoYW5kIG90aGVyIHByb3Zp
ZGVycyBhcyB3ZWxsKSwgd2hpY2gKb3V0cHV0cyAiYW1hem9uIiBmb3IgYHN5c3RlbWQtZGV0ZWN0
LXZpcnRgIGFuZCB0aGVyZWZvcmUgZmFsbHMgaW50byB0aGUKVklSVF9PVEhFUiBjYXRlZ29yeS4K
ClN1Z2dlc3RlZC1ieTogTWFydGluIERvdWNoYSA8bWRvdWNoYUBzdXNlLmN6PgpTaWduZWQtb2Zm
LWJ5OiBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgotLS0KIHRlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvZ2V0cnVzYWdlL2dldHJ1c2FnZTA0LmMgfCA4ICsrKysrLS0tCiAxIGZp
bGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0cnVzYWdlL2dldHJ1c2FnZTA0LmMgYi90ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL2dldHJ1c2FnZS9nZXRydXNhZ2UwNC5jCmluZGV4IGIwM2Jj
NTQ5YmQ4MzViMzNhY2FhMDI2OTM3MDYyNTVlODhjYmU0ZjguLjBlMjJlMmVlOWRhZGZiMWMwNWRm
NDQyNWM2NWIwNGIyNTc5ZTE2NDkgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvZ2V0cnVzYWdlL2dldHJ1c2FnZTA0LmMKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9nZXRydXNhZ2UvZ2V0cnVzYWdlMDQuYwpAQCAtMTk4LDkgKzE5OCwxMSBAQCBzdGF0aWMgdm9p
ZCBzZXR1cCh2b2lkKQogewogCXRzdF9zaWcoTk9GT1JLLCBERUZfSEFORExFUiwgY2xlYW51cCk7
CiAKLQlpZiAodHN0X2lzX3ZpcnQoVklSVF9YRU4pIHx8IHRzdF9pc192aXJ0KFZJUlRfS1ZNKSB8
fCB0c3RfaXNfdmlydChWSVJUX0hZUEVSVikpCi0JCXRzdF9icmttKFRDT05GLCBOVUxMLCAiVGhp
cyB0ZXN0Y2FzZSBpcyBub3Qgc3VwcG9ydGVkIG9uIHRoaXMiCi0JCSAgICAgICAgIiB2aXJ0dWFs
IG1hY2hpbmUuIik7CisJaWYgKHRzdF9pc192aXJ0KFZJUlRfWEVOKSB8fCB0c3RfaXNfdmlydChW
SVJUX0tWTSkgfHwKKwkgICAgdHN0X2lzX3ZpcnQoVklSVF9IWVBFUlYpIHx8IHRzdF9pc192aXJ0
KFZJUlRfT1RIRVIpKQorCQl0c3RfYnJrbShUQ09ORiwgTlVMTCwKKwkJCSAiVGhpcyB0ZXN0Y2Fz
ZSBpcyBub3Qgc3VwcG9ydGVkIG9uIHRoaXMiCisJCQkgIiB2aXJ0dWFsIG1hY2hpbmUuIik7CiAK
IAlCSUFTX01BWCA9IGd1ZXNzX3RpbWVyX3Jlc29sdXRpb24oKTsKIAoKLS0tCmJhc2UtY29tbWl0
OiBhMWFlYmZkNGQ5OWQ1ZGExMjgzNGRhZTUyMTU4MTVmZjhkODI5OTVjCmNoYW5nZS1pZDogMjAy
NTAyMjQtZGlzYWJsZV92aXJ0X290aGVyX2dldHJ1c2FnZTA0LWM5ZGIyYWE5ZTY5YwoKQmVzdCBy
ZWdhcmRzLAotLSAKUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KCgotLSAKTWFp
bGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
