Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB025C87FCC
	for <ltp@archiver.kernel.org>; Thu, 31 Jul 2025 11:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753960708; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=OSEIDtZDNE2btnd7sckN22D0uDxAhPYG4UIRsbYmIzM=;
 b=UGnIzEpVVWaMp1JA2VN1qR9vyoAoTh4r1OqUZlBwFfhaBbREurDZ/VA00R2iAv1FxOJgb
 h/eLZTkTJocQrifpyUU8cm8fqv2nIK71zAms5J2Ey85s6m4SKRpz1/SyJ+PtmTGGmL0V2gq
 uJOhlTiwxHSOIy7W38/+DVu3n5Iu2Lo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 627193CBF4E
	for <ltp@archiver.kernel.org>; Thu, 31 Jul 2025 13:18:28 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA1673CB93E
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 13:18:07 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 62A496008AA
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 13:18:06 +0200 (CEST)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3b78d13bf10so246206f8f.1
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 04:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753960686; x=1754565486; darn=lists.linux.it;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FKPD7+83vYlTwDCVSGzly/63BAlQ/nkqyxAe6/+HA0k=;
 b=PFshz+GhRp+fgAmLxe89z8aOr7m6fq6wTG8oYcskQGlYG8Xl40O3RoIcSuqrw2Vna+
 d0sQiW3X0TgTBNRAmWZX7AkeptELeKjqhUfdgwsbYijYk62IUz4OisgnqWPH79Xw0yQc
 mON49bW5p/Z/34bDoFJI6vAa9M9D7c56Tj1Ure3MsODEIlQperz21Jca/zT79DJrd+Mh
 tjbj/Y/0OutNDNH37dgub5bRY++PH/qv48lWunHpt+I/9CdVwU94NVB2qi9yURnww+a6
 x1myaWLQeXS0FO9ICgtbAC8QGv6jwgLOJdKd/icRV7jp7AlCGoPka5GmDYRyIgIgsUyc
 6zxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753960686; x=1754565486;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FKPD7+83vYlTwDCVSGzly/63BAlQ/nkqyxAe6/+HA0k=;
 b=jk97mExyaqHUNQdo8rhONwQKpIqP3JUR0zczyKOuAnokKazUHHwB5hA4lsReJTqwCg
 GTXTm8u3CoM+BgIf5mG4nw4QLAjvSPG6UE4Lc/XPw4vb0MGo0NUJWGgdGzIu9q2lYriO
 vH8O+X9HFuEu9AfJFgDldOMB7h8Uf3F+Qmx6caN1BYF+PMgZa4FkaYO25XzxqbvHC+Tc
 1KuO/IFflQD67AoLh7Zb2LSDwFN3Zx3to1zHj9iUbIwvCUwopm1yOkelibWknV1cSEpH
 c2v7mzGSVW1ehgVTjw97RK51iMdiFQCkgPh8Vh4aaEpKKwVYYk/MG7ZqvBeSUO+eKUT0
 n28A==
X-Gm-Message-State: AOJu0Yyh2b7eh9og8Qi9IvY79EDQPgweZa1y/TpAiqDC0iw3kJUMnFjY
 Lq1HEYgu9PSdlWhdMsY3TUC/xPz+XZT/aQrSFVyb6B5m9zbjgKrnGsAXlFi2t5725qlZRNp6ocQ
 3MtUj
X-Gm-Gg: ASbGncusemUJkix3EQ2X2n+H3KLbd7ff5VRuL03nHcsIW1X9Xd4Qptn6+fTl0MpfTY7
 KBiY9fHDxCV30Y8PRjQFWLk5e4Zllk1Ohdm1A8ySAMQfqd9vZOC3xlEJ81v0eDRfzM/nDogyJ1G
 GGzlbY+r+v2pyjQMpxaBErVdY9v95P8DDWp7E8c4NIpjSkzL/+pe6lfj+eX3gxBM44v4/KHcjXx
 KdzvyLpSqnyODspu9OXTTe2MWXAhPMYgPF8tnUmgFuDBS4cJ7EEnRRtXvmbRqMlMhxSoT9SdLd3
 sZ4Z8bmbXQUVLur/fF4xWJwUHKGyBJfBFWDE8rmfKts0EB04Rckk6P3Xc2oUs+HKPEwUfI6Er2P
 8oLAXKITtK4Vl/H+7L8QF
X-Google-Smtp-Source: AGHT+IEaubUZh5XotdMaepK5Mrlt6gZzrprMVLRmd4m6iAe/KtDoToBUFMmQANWeFKnrx6LAOxkbUQ==
X-Received: by 2002:a05:6000:430e:b0:3b6:a03:f7a8 with SMTP id
 ffacd0b85a97d-3b794ff7948mr5360604f8f.22.1753960685695; 
 Thu, 31 Jul 2025 04:18:05 -0700 (PDT)
Received: from localhost ([177.45.162.214])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-31f63ee4f42sm4481413a91.23.2025.07.31.04.18.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 04:18:05 -0700 (PDT)
Date: Thu, 31 Jul 2025 08:18:01 -0300
MIME-Version: 1.0
Message-Id: <20250731-fixes-munmap04-v2-1-41cfdd2367e5@suse.com>
X-B4-Tracking: v=1; b=H4sIAOhQi2gC/33Oyw7CIBAF0F8xrMXwKNK68j+MC6BTy6KPMC3RN
 P13oS6Mibq8yT1zZyEIwQOS024hAaJHP/QpiP2OuNb0N6C+TpkIJhTToqSNvwPSbu47M7KCMsF
 K6ZRi7mhJQmOArZHM5ZqyNQjUBtO7Np/pDE4QcrH1OA3hsQ1Hnus/NyKnnIIU0HBeq6owZ5wRD
 m7o8qGXkvyrqirlpLS6agDeKj8Wxf9NkTTXJZdSM8M+9LquTx/EQQg4AQAA
X-Change-ID: 20250728-fixes-munmap04-02083c550c6b
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1747; i=rbm@suse.com;
 h=from:subject:message-id; bh=f/v4XAGBfm6DWKXUXJw4/yZ0ZpY9FL5maPKgtpb6FQI=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBoi1Dq/v86/1zKo2j82qxAY+vrurx0S+uFXk1G6
 mJnHn8WTJGJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaItQ6gAKCRDJC4p8Y4ZY
 pshvEACu1h/7hWRiucMvJ7V6LcO3gIHwt1yr7cGpkx7sfXxUzgKsny2H0OI8Rdi7ijyR8NXFXQW
 QQAv93ylD8HqOfDGkKASh6nCNWrtKHioHibGTnqorCojIRwhhzpGupgjcQ+AeWd7LJ3OmV8MouD
 cRn+IabS3HwVV7gkI7+oOLjCyg0fez+WXq/m01eIW47yVai3bkE7/g/t4s0q5npcqSUhSX0kvil
 Fnpxazn5hwAIqjoPQx4Su2o5qM4/VrvLx+WTivVrRWjvnqR1WJ95n0kUQZyz7dF61CV/1am0+PA
 XfxDbK0fDBP+byovrkuNBQZk7U3gelAbGd8c8PeYxwEl7Pw0HnThEIaLbgFWx6AEv4MpBvTNDzi
 XT5ww7wMLHYcnzjxx0cgzF0KFZSYKKgPiBvucT+TtC8CjB/8Ob97pA+C5EaKaqx/Ic0a5rn6Zdd
 VopYATtR6XIy68gWtvGe3K97ryUZoAott3IkW6VeACL7giiip18TetT7zzH38TsjRawP8MGM0I5
 16XS1mOajrP7OBMxuGwW6Pes/q4tZbTDJBPhElmTdqIn532HdsH9IjB0gJcoagLa9R7W+6AOYGy
 S0dypGreSKHT762EjR8wxnQZsUvQkLxrfpgDo9DDrL1jsL4XmVMaN3ZuWDiETdGkyRmawTpPZDJ
 aqfk/OnbHaaZmvw==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls/munmap04: Increase target map address in
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
b20+Ci0tLQpDaGFuZ2VzIGluIHYyOgotIFVzZSBgZ290b2AgaW5zdGVhZCBvZiBgY29udGludWVg
LgotIExpbmsgdG8gdjE6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTA3MzEtZml4ZXMt
bXVubWFwMDQtdjEtMS05OTVjMzNiNzlmZWVAc3VzZS5jb20KLS0tCiB0ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL211bm1hcC9tdW5tYXAwNC5jIHwgOCArKysrKystLQogMSBmaWxlIGNoYW5nZWQs
IDYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL211bm1hcC9tdW5tYXAwNC5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9tdW5tYXAvbXVubWFwMDQuYwppbmRleCBhZWI5MDUyODZlOWQ0MjE0YWM2NDIzZWYyNmU5
NTcwNjc0YjYwNTMwLi45ODdhN2M3ZTdhOTVlMTU2MjJlOTFkYzNjNzc3YjA2MDcwNzM2MTQ1IDEw
MDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL211bm1hcC9tdW5tYXAwNC5jCisr
KyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbXVubWFwL211bm1hcDA0LmMKQEAgLTI4LDYg
KzI4LDggQEAgc3RhdGljIHZvaWQgcnVuKHZvaWQpCiAKIHN0YXRpYyB2b2lkIHNldHVwKHZvaWQp
CiB7CisJdWludHB0cl90IGFkZHIgPSBiYXNlOworCiAJcGFnZV9zeiA9IFNBRkVfU1lTQ09ORihf
U0NfUEFHRVNJWkUpOwogCXZtYV9zaXplID0gTUVNU0laRSAqIHBhZ2Vfc3o7CiAKQEAgLTM2LDE1
ICszOCwxNyBAQCBzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQogCQltYXBzW2ldID0gTlVMTDsKIAog
CXdoaWxlICgxKSB7Ci0JCXZvaWQgKnAgPSBtbWFwKCh2b2lkICopKGJhc2UgKyBQQUQgKiB2bWFf
c2l6ZSAqIG1hcF9jb3VudCksCisJCXZvaWQgKnAgPSBtbWFwKCh2b2lkICopIGFkZHIsCiAJCQkg
ICAgIHZtYV9zaXplLCBQUk9UX05PTkUsCiAJCQkgICAgIE1BUF9QUklWQVRFIHwgTUFQX0FOT05Z
TU9VUyB8IE1BUF9GSVhFRF9OT1JFUExBQ0UsCiAJCQkgICAgIC0xLCAwKTsKIAkJaWYgKHAgPT0g
TUFQX0ZBSUxFRCAmJiBlcnJubyA9PSBFRVhJU1QpCi0JCQljb250aW51ZTsKKwkJCWdvdG8gbmV4
dF9hZGRyOwogCQlpZiAocCA9PSBNQVBfRkFJTEVEKQogCQkJYnJlYWs7CiAJCW1hcHNbbWFwX2Nv
dW50KytdID0gcDsKK25leHRfYWRkcjoKKwkJYWRkciArPSBQQUQgKiB2bWFfc2l6ZTsKIAl9CiAK
IAlpZiAobWFwX2NvdW50ID09IE1BUF9NQVhfQ09VTlQpCgotLS0KYmFzZS1jb21taXQ6IDkxZmE0
MTNlYjUyMWZkZTgwZDU3Yzc5YmQzZDJmYjVjYmU0YWQzZjQKY2hhbmdlLWlkOiAyMDI1MDcyOC1m
aXhlcy1tdW5tYXAwNC0wMjA4M2M1NTBjNmIKCkJlc3QgcmVnYXJkcywKLS0gClJpY2FyZG8gQi4g
TWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+CgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczov
L2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
