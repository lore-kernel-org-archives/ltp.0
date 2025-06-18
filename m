Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1C9C7115A
	for <ltp@archiver.kernel.org>; Wed, 18 Jun 2025 11:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750247235; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=8ADcnMv+Z46DwmXyZecrfAzLgiNIdmMUxVwBqD5TUig=;
 b=FpCBgvY/jA/kNMteqhzzLKB+W5WHhsKfY7uVLH0Qwutm9YQEbXnwGqfMJD4mEFqRDjhAt
 dOvH2YPkqRxE+c6JH7ZaVuaIYHp4RIqc6ka5V33aurr4LuvYQBEuNqR3COrpkPxMqh8ZEkJ
 xrzExHpopkDwzQ2L89BSmm45yGdMawI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6BAD93CC4A0
	for <ltp@archiver.kernel.org>; Wed, 18 Jun 2025 13:47:15 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E48C43CC214
 for <ltp@lists.linux.it>; Wed, 18 Jun 2025 13:46:54 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2ABA9200919
 for <ltp@lists.linux.it>; Wed, 18 Jun 2025 13:46:53 +0200 (CEST)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a4f72cba73so429494f8f.1
 for <ltp@lists.linux.it>; Wed, 18 Jun 2025 04:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1750247212; x=1750852012; darn=lists.linux.it;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xpDus5iJpC5auOM4/TfDXthyFitcQbJsvSeQbPxHn94=;
 b=GagO7emoYP1LU9h5bwMT3M+N66xDw/DPTVuCvvhjOoN7Dtb+po4QC3CW49M3Wx64NF
 424nqYabWtJ3T6yEAl/Jwd3hZrFxJq+eLJ8/VYIFrRHsF3mXigv5uEuJcTrtGKfbP0ol
 ZOdmusFJAWxOgFenS2c+PB2FnjbGO0Ad09T5kAqfC3tGwYTOS7GOJ8bK7vsLU2mFGJuY
 N9ftgLLTS1ZqZpx4++gXkT7UE8P5ISWSWdd/rFUj8mwYgF4oiS/oEC9eFnqI3Ro9/om7
 8Ae2yu1dS/MHwY165eoGUWmifevNaSNsKZdD1uhV1BIUovJZZQiqlcJuJ5Qu38Gj7eJe
 dtWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750247212; x=1750852012;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xpDus5iJpC5auOM4/TfDXthyFitcQbJsvSeQbPxHn94=;
 b=L+ANwerfGesVwfqP07zsAwtS7Zz6DGL7uLUaRkxSShFKAcHE0lgxH/azH0HubHVk7G
 qc/rDG2SD8lRnFSrKHhcqvcByjkLlqC3K07nSTedQKtevGVqqbwdVuBMWg4avhjI/sU7
 +WywmjdM+3oGzygZPvSFawl3d2RF0vrPLMCcD4DF9ffjNNLYM4va3gx6xaynQ4d7j3K3
 pN9Lz5tzuo97xOBgSxJheP8CN7+yIZ5F0nPBR6pV+Nz8ftavXV8RQgLUCUGWQGDivy7k
 5JpUozYWbaKsEhSyVqIJ0M968tDw801ZG1s1ZMKbjG/cs9KZ/iHjEM4YeN1ugFycbNHR
 t9Xw==
X-Gm-Message-State: AOJu0Yxpqw71fhUJejWhw+qmsMme3gL/+p+s8zUfUUnFa8J5tZ2EySC/
 oCycjVUP4St2u27h/a1oiNYtOezwTtJLoaaseXKAeQe3rLC8y3yDjbExY8fVR5gxAEwgTtO0//7
 YK058
X-Gm-Gg: ASbGncvBn9t8mba4NdrLxpBBto0M7xIkylUtMFTJkedpXnYG9MRPXSV9d0eV0Jdw3Ym
 Bm9prCiBWWGFhuO3YASKuadGaWBPgmKU9I7s+7Gj+feGW3Siut5s7T9SpxyqCUnarfNbOGr7lJ3
 +a1jGTxugs9IGTxsrd9wsfFE/DzOrxC8I74f5UY0PKm8hT7DwjkhiST/uJwBSsdcw26TFGuZ9qJ
 B/DvhcrZ4qRCwmz8x4dGfookB6NuHoOh06yNbovyqUftXRzv3j1hUcD2NGCNh3pE73LA/p7BhvV
 T8dDF9DoJGJywFunl4fnurFkWOvsP5qqwmmeimAlDf4sDRQIwDyFlp0nKF0=
X-Google-Smtp-Source: AGHT+IHDJIyp8EEhB0ic6LWqmVN7xytNDhUOP26NsqkyV4adjEA225xzWhcg5ztelyFPM303s1Su6Q==
X-Received: by 2002:a05:6000:2c0d:b0:3a4:dc3b:5a3b with SMTP id
 ffacd0b85a97d-3a58e14587bmr1800950f8f.10.1750247212425; 
 Wed, 18 Jun 2025 04:46:52 -0700 (PDT)
Received: from localhost ([189.99.236.25]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-313c1bd9a31sm12493930a91.13.2025.06.18.04.46.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 04:46:51 -0700 (PDT)
Date: Wed, 18 Jun 2025 08:46:47 -0300
MIME-Version: 1.0
Message-Id: <20250618-conversions-shmt-v1-1-5b935f7859ad@suse.com>
X-B4-Tracking: v=1; b=H4sIACanUmgC/x3MwQrCQAyE4VcpORtoCxHxVcRDdh3dHLqVpBSh9
 N279fjBzL9RwA1B924jx2phc20YLh3lovUDtlczjf0o/XW4cZ7rCj9nwVGmhQUqKkgQAbXb1/G
 23z/5eDYnDXByrbmcoUljgdO+H6dr3w97AAAA
X-Change-ID: 20250618-conversions-shmt-5ea5a5ebe55e
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4490; i=rbm@suse.com;
 h=from:subject:message-id; bh=prUcnYyEi6ueOR1OOJNzj/HuupjbbUML8CV11t2kxxE=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBoUqcoLMYTRn4+p4Vx/obXcdxpQkH7T/9l4AORX
 xxRXgdJeNOJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaFKnKAAKCRDJC4p8Y4ZY
 pkE0D/4qMGoKR3sJ9lOzpbLJ57p6IYjQ3YbH3PD2S9hV3F7QyB2cZ9jVVC0pW9rpnnN0tWgGJp7
 nDvYd3iUpc7gV9W3sCuUFQ0Nmd8d4wFEUOEDJFyIE3IeIm5t/WWxkrxCd41qa4Qw3QAUK1p1MMp
 ui+1InzLW3Isqs5YciMC0GgRHT4rRmFzzBfr3QLsXyUz2LDAKLGU/0FZ096UevrTruhoWpCAnl0
 leldEFgG8hD6g3i7QiMjs0gTby6GZ6TigQAlpLNNJNuRzX8MS7rwonsPb80tbHpRSOx2aZv1cnG
 PiGMMZ6qrrtUaPQp/zX65ooVgVZ7aBVFFYTzYSPcppulfHt9fqSbsARuB1WxZ1qSwvRqS9YtCsN
 VdxXXQD8vq2W69d774Aq1TTEq7tPS1bq9RwXheP/N87EapK6GEhBSqakCmlQMPXDreB2pUg7p7x
 po+CXwc8XJvVEzee2E7HboR/RQ/KamEAABE+dTAQs1xyfrWa0v1gKjGSVhSOC9Vhyt7Q5mmsfvv
 bgEX84ZGlqAjZQfqj18wYyqjoFHheuYFnqEGAA6EzUmzhRVF6jbAFAiWUarqe1iXRzi6zlSDUO1
 5uE6tHZgtmbokQpc+zlSIIccJPlvlsTWeRVW9j2eMRurEVI4KJhfKWJDrq4JmSeCyZS2z5IIV0V
 JQ3Oigp4jtHUBRg==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] mem: Convert shmt02 to new API
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
bC9tZW0vc2htdC9zaG10MDIuYyB8IDExOCArKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgOTcgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0vc2htdC9zaG10MDIuYyBiL3Rlc3Rj
YXNlcy9rZXJuZWwvbWVtL3NobXQvc2htdDAyLmMKaW5kZXggYjMzYTA0MmY5MzYyNWNmNDRhZjFj
M2RlNjM1NDI0ODkxOWYyMTUyMi4uZjFkZmVjNTAyOGFmYjExNmY1MzkzZmY0YjQ4NjlhN2VhMzA5
OTA3MSAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0vc2htdC9zaG10MDIuYworKysg
Yi90ZXN0Y2FzZXMva2VybmVsL21lbS9zaG10L3NobXQwMi5jCkBAIC0xLDEyMCArMSw0NCBAQAor
Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKIC8qCi0gKgotICog
ICBDb3B5cmlnaHQgKGMpIEludGVybmF0aW9uYWwgQnVzaW5lc3MgTWFjaGluZXMgIENvcnAuLCAy
MDAyCi0gKgotICogICBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgIHlvdSBjYW4gcmVk
aXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkKLSAqICAgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRo
ZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkKLSAqICAgdGhlIEZy
ZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24gMiBvZiB0aGUgTGljZW5zZSwg
b3IKLSAqICAgKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4KLSAqCi0gKiAgIFRo
aXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNl
ZnVsLAotICogICBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7ICB3aXRob3V0IGV2ZW4gdGhlIGlt
cGxpZWQgd2FycmFudHkgb2YKLSAqICAgTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEg
UEFSVElDVUxBUiBQVVJQT1NFLiAgU2VlCi0gKiAgIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGlj
ZW5zZSBmb3IgbW9yZSBkZXRhaWxzLgotICoKLSAqICAgWW91IHNob3VsZCBoYXZlIHJlY2VpdmVk
IGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UKLSAqICAgYWxvbmcgd2l0
aCB0aGlzIHByb2dyYW07ICBpZiBub3QsIHdyaXRlIHRvIHRoZSBGcmVlIFNvZnR3YXJlCi0gKiAg
IEZvdW5kYXRpb24sIEluYy4sIDUxIEZyYW5rbGluIFN0cmVldCwgRmlmdGggRmxvb3IsIEJvc3Rv
biwgTUEgMDIxMTAtMTMwMSBVU0EKKyAqIENvcHlyaWdodCAoYykgSW50ZXJuYXRpb25hbCBCdXNp
bmVzcyBNYWNoaW5lcyAgQ29ycC4sIDIwMDIKKyAqCTEyLzIwLzIwMDIJUG9ydCB0byBMVFAJcm9i
Ymlld0B1cy5pYm0uY29tCisgKgkwNi8zMC8yMDAxCVBvcnQgdG8gTGludXgJbnNoYXJvZmZAdXMu
aWJtLmNvbQorICogQ29weXJpZ2h0IChjKSAyMDI1IFNVU0UgTExDIFJpY2FyZG8gQi4gTWFybGnD
qHJlIDxyYm1Ac3VzZS5jb20+CiAgKi8KIAotLyogMTIvMjAvMjAwMgkJIFBvcnQgdG8gTFRQCQkg
cm9iYmlld0B1cy5pYm0uY29tICovCi0vKiAwNi8zMC8yMDAxCQkgUG9ydCB0byBMaW51eAkJIG5z
aGFyb2ZmQHVzLmlibS5jb20gKi8KLQotLyoKLSAqIE5BTUUKLSAqCQkgc2htdDAyCi0gKgotICog
Q0FMTFMKLSAqCQkgc2htY3RsKDIpIHNobWdldCgyKQotICoKLSAqIEFMR09SSVRITQorLypcCiAg
KiBDcmVhdGUgYW5kIGF0dGFjaCBhIHNoYXJlZCBtZW1vcnkgc2VnbWVudCwgd3JpdGUgdG8gaXQK
LSAqIGFuZCB0aGVuIHJlbW92ZSBpdC4JCSAgVmVyaWZ5IHRoYXQgdGhlIHNoYXJlZCBtZW1vcnkg
c2VnbWVudAorICogYW5kIHRoZW4gcmVtb3ZlIGl0LiBWZXJpZnkgdGhhdCB0aGUgc2hhcmVkIG1l
bW9yeSBzZWdtZW50CiAgKiBpcyBhY2Nlc3NpYmxlIGFzIGxvbmcgYXMgdGhlIHByb2Nlc3MgaXMg
c3RpbGwgYWxpdmUuCi0gKgogICovCiAKLSNpbmNsdWRlIDxzdGRpby5oPgotI2luY2x1ZGUgPHN5
cy90eXBlcy5oPgotI2luY2x1ZGUgPHN5cy9pcGMuaD4KLSNpbmNsdWRlIDxzeXMvc2htLmg+Ci0j
aW5jbHVkZSA8c3lzL3V0c25hbWUuaD4KLSNpbmNsdWRlIDxlcnJuby5oPgotCi0vKiogTFRQIFBv
cnQgKiovCi0jaW5jbHVkZSAidGVzdC5oIgotCi1jaGFyICpUQ0lEID0gInNobXQwMiI7CQkvKiBU
ZXN0IHByb2dyYW0gaWRlbnRpZmllci4gICAgKi8KLWludCBUU1RfVE9UQUwgPSAzOwkJLyogVG90
YWwgbnVtYmVyIG9mIHRlc3QgY2FzZXMuICovCi0KLS8qKioqKioqKioqKioqKi8KKyNpbmNsdWRl
ICJ0c3Rfc2FmZV9zeXN2X2lwYy5oIgorI2luY2x1ZGUgInRzdF90ZXN0LmgiCiAKLSNkZWZpbmUg
S18xIDEwMjQKLQotc3RhdGljIGludCBybV9zaG0oaW50KTsKLQotaW50IG1haW4odm9pZCkKK3N0
YXRpYyB2b2lkIHJ1bih2b2lkKQogewogCXJlZ2lzdGVyIGludCBzaG1pZDsKIAljaGFyICpjcDsK
IAlrZXlfdCBrZXk7CiAKIAllcnJubyA9IDA7Ci0Ja2V5ID0gKGtleV90KSBnZXRwaWQoKTsKLQot
LyotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tKi8KLQotCWlmICgoc2htaWQgPSBzaG1nZXQoa2V5LCAxNiAqIEtfMSwgSVBDX0NS
RUFUIHwgMDY2NikpIDwgMCkgewotCQlwZXJyb3IoInNobWdldCIpOwotCQl0c3RfYnJrbShURkFJ
TCwgTlVMTCwKLQkJCSAic2htZ2V0IEZhaWxlZDogc2htaWQgPSAlZCwgZXJybm8gPSAlZCIsCi0J
CQkgc2htaWQsIGVycm5vKTsKLQl9CisJa2V5ID0gKGtleV90KWdldHBpZCgpOwogCi0JdHN0X3Jl
c20oVFBBU1MsICJzaG1nZXQiKTsKLQotLyotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKi8KLQotCWNwID0gc2htYXQoc2htaWQs
IE5VTEwsIDApOwotCi0JaWYgKGNwID09IChjaGFyICopLTEpIHsKLQkJcGVycm9yKCJzaG1hdCIp
OwotCQl0c3RfcmVzbShURkFJTCwgInNobWF0IEZhaWxlZDogc2htaWQgPSAlZCwgZXJybm8gPSAl
ZCIsCi0JCQkgc2htaWQsIGVycm5vKTsKLQkJcm1fc2htKHNobWlkKTsKLQkJdHN0X2V4aXQoKTsK
LQl9CisJc2htaWQgPSBTQUZFX1NITUdFVChrZXksIDE2ICogMTAyNCwgSVBDX0NSRUFUIHwgMDY2
Nik7CiAKKwljcCA9IFNBRkVfU0hNQVQoc2htaWQsIE5VTEwsIDApOwogCSpjcCA9ICcxJzsKIAkq
KGNwICsgMSkgPSAnMic7CiAKLQl0c3RfcmVzbShUUEFTUywgInNobWF0Iik7Ci0KLS8qLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LSovCi0KLQlybV9zaG0oc2htaWQpOworCVNBRkVfU0hNQ1RMKHNobWlkLCBJUENfUk1JRCwgTlVM
TCk7CiAKLQlpZiAoKmNwICE9ICcxJyB8fCAqKGNwICsgMSkgIT0gJzInKSB7Ci0JCXRzdF9yZXNt
KFRGQUlMLAotCQkJICJFcnJvciBpbiBzaGFyZWQgbWVtb3J5IGNvbnRlbnRzOiBzaG1pZCA9ICVk
IiwKLQkJCSBzaG1pZCk7Ci0JfQorCWlmICgqY3AgIT0gJzEnIHx8ICooY3AgKyAxKSAhPSAnMicp
CisJCXRzdF9yZXMoVEZBSUwsICJFcnJvciBpbiBzaGFyZWQgbWVtb3J5IGNvbnRlbnRzOiBzaG1p
ZCA9ICVkIiwKKwkJCXNobWlkKTsKIAotCXRzdF9yZXNtKFRQQVNTLCAiQ29ycmVjdCBzaGFyZWQg
bWVtb3J5IGNvbnRlbnRzIik7Ci0KLS8qLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKi8KLQotCXRzdF9leGl0KCk7CisJdHN0
X3JlcyhUUEFTUywgIkNvcnJlY3Qgc2hhcmVkIG1lbW9yeSBjb250ZW50cyIpOwogfQogCi1zdGF0
aWMgaW50IHJtX3NobShpbnQgc2htaWQpCi17Ci0JaWYgKHNobWN0bChzaG1pZCwgSVBDX1JNSUQs
IE5VTEwpID09IC0xKSB7Ci0JCXBlcnJvcigic2htY3RsIik7Ci0JCXRzdF9icmttKFRGQUlMLAot
CQkJIE5VTEwsCi0JCQkgInNobWN0bCBGYWlsZWQgdG8gcmVtb3ZlOiBzaG1pZCA9ICVkLCBlcnJu
byA9ICVkIiwKLQkJCSBzaG1pZCwgZXJybm8pOwotCX0KLQlyZXR1cm4gKDApOwotfQorc3RhdGlj
IHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0geworCS50ZXN0X2FsbCA9IHJ1biwKK307CgotLS0KYmFz
ZS1jb21taXQ6IGRmNTkxMTEzYWZlYjMxMTA3YmM0NWJkNWJhMjhhOTliNTU2ZDEwMjgKY2hhbmdl
LWlkOiAyMDI1MDYxOC1jb252ZXJzaW9ucy1zaG10LTVlYTVhNWViZTU1ZQoKQmVzdCByZWdhcmRz
LAotLSAKUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KCgotLSAKTWFpbGluZyBs
aXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
