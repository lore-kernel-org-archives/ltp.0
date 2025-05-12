Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE048C3ABC3
	for <ltp@archiver.kernel.org>; Mon, 12 May 2025 10:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747044339; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=An2RSQMmPcbMJBvK9MX7Jd1GbhAtsYZ+vR/IFDUvU+0=;
 b=IFj5biIrQhHVXyHrM7LWWkwTVnfzQIXmMan1lMmuvJUvR0DPlfdh2ndmcZ9b/MWABvrDQ
 aVnueai+38LeF/7Md0vR2YpsqahFD5gLESSBCO/86TW8Be541nYPqE54FXVU3RW7delYI9l
 +DOhUI9WOxnKbeyKoSc6cHe+rzgI3Xk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5F3073CC2B1
	for <ltp@archiver.kernel.org>; Mon, 12 May 2025 12:05:39 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8A6033CBCD4
 for <ltp@lists.linux.it>; Mon, 12 May 2025 12:05:17 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9F7AF60070D
 for <ltp@lists.linux.it>; Mon, 12 May 2025 12:05:16 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a0b9625735so2148017f8f.2
 for <ltp@lists.linux.it>; Mon, 12 May 2025 03:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1747044316; x=1747649116; darn=lists.linux.it;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aeXYS71bPLx4EaYmMsnFeLyhRk6vX255wRcOd9ScPEg=;
 b=JKd2Tk35sXj5jOSWSkWJKI92CgrMzCaeXLsG4jXqIM5j+CNDOhfbRfrNoyHuOfa9jx
 AkBiDENiPWe536JpGnSiNJKUVwq1HPFP642EeEye4OQB1agCxVyxaZJZts4Mz3ntzY18
 YhO1lNpN+F3IpkT4cRxKVzL/sBIT+2EDjq2k1V5Tu4lxbIQECF9QrF4dJA/6DHm80UdP
 47JcHE71EjRPw/GdDBe4zOJ+TIMdbxGXL+smymULZ6TJo5i6S1i899Bdr7ZG+d9NVs05
 F0y9586aY6lDGCljz5KZX+hysC2VeHkNwYr1WmRU7d6KOqSIAy88gMOVf87uXPxp14IY
 XcyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747044316; x=1747649116;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aeXYS71bPLx4EaYmMsnFeLyhRk6vX255wRcOd9ScPEg=;
 b=ljVChWon3k2nsq8asWuE3WCHM6XFGUdsnyI058vTfvwxQzve5fCkSgSv/NDOukwHsp
 2TD2HhzM3mC4eFvA7BaAOt91iWGzTLAxpGyQmFxZVCwBccXSlXFJ7GFHJTThZSfB/CEd
 ncR5EdPR9mu5UNt4Z8GqBgwKxLEtL9WffErnI6rDULC4hQYErOiwDCH74ICPXqC7UXcq
 9hzo7yy54emcUGGDLEwZNAMyOPyUftyObHyJeh83wuF6F9/Cxmp6OgaY6Mj9AJvGlnLE
 P59TXiGPs0yDA/9HdEwQZi4FqTDOQZbZ2IdlLUyW/r8jf9+73PZnzYVQdOxuAEqho+8B
 0Pww==
X-Gm-Message-State: AOJu0YwudPjiMUadjqQN3P3wEh42w9Y4sGRS3kYVGoTd6pX3Eecb90Wj
 JOYsF5inD9RPBQjKL1yus9iZTfIsZ6j1HrBWEdbxxchPA+0AD54iv28Bbm3WwWA=
X-Gm-Gg: ASbGncvnPVWTVOYfb3+V7tDYIawX0oyThI0KGX5GI8coGbd5OM5gKhMKNldLQIHe/nj
 maQE6cn2iVj8hl+svguyCex/ZbwmzGHhcnrTurxpc44zxxPkXO+dBfy/Vk//9LnEEIZYlOigw/4
 OdPVu13iex5uE8n/9/7kIooQ3hL28TPPlL1Hg1L/1CwkqVcb0Ux1gHunBcQtXhMeYMecJoSpbOx
 k/mKLy2+jVq+YhtV1asEJK6mlV5X/NFPKIrrw/KYmn1HExcPm97rKqnF5QXes6+WBVzIR0imd6a
 6lHj2kcNZASyHgF21Hj8Su9p2xrAepyTXSS9DT+txGErgtp1AA==
X-Google-Smtp-Source: AGHT+IGxazwJu5y8it4J8kgTcc+UI3Yhiy7qKSO8Tu7PMSQP5KEnBknhgOLxyhh7+xT6GvQ4fOD4ZA==
X-Received: by 2002:a05:6000:1a8c:b0:3a0:ad33:c1b3 with SMTP id
 ffacd0b85a97d-3a1f6422047mr9873377f8f.3.1747044315977; 
 Mon, 12 May 2025 03:05:15 -0700 (PDT)
Received: from localhost ([177.45.162.169])
 by smtp.gmail.com with UTF8SMTPSA id
 71dfb90a1353d-52c536fcc07sm5346355e0c.1.2025.05.12.03.05.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 03:05:15 -0700 (PDT)
Date: Mon, 12 May 2025 07:05:07 -0300
MIME-Version: 1.0
Message-Id: <20250512-fixes-modify_ldt-v2-1-eaef5577e44e@suse.com>
X-B4-Tracking: v=1; b=H4sIANLHIWgC/32OUQ6CMBBEr2L222qpItEv72GIKe0Cm0hrdpFIC
 He35QB+vmTezCwgyIQCt90CjBMJxZDA7Hfgehs6VOQTg9Gm1KWuVEtfFDVET+38fPlRYeNa742
 t/ElD0t6MWyZZjzpxYwVVwza4PhdFpo7CcbAyIud8TzJGnrcHU5GtP2NToQpVaWsu13OedXf5C
 B5cHKBe1/UH6ZseJs8AAAA=
X-Change-ID: 20250507-fixes-modify_ldt-ebcfdd2a7d30
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2687; i=rbm@suse.com;
 h=from:subject:message-id; bh=Higyb7gpFBKfoO6t4pXNFleu83ptP2z4QxnE3cOoLbI=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBoIcfYIpvh6lII9uFXSEmw58gFOObmQCZvHuUt3
 snA7p26nb6JAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaCHH2AAKCRDJC4p8Y4ZY
 pt30D/wO6RCwMFjBKGmSDX91BF8nKzH50c8syYRgkOLlLpt6ZkulJ5daqGux1p9VeS7zYhHhZ4E
 jisvg77bq9vNjinbalgDl2fhBAjzzbyJBe3XdtxFfMIWSOtwMoSuu2hyWvl4HVb6ChXf5pr/K/7
 1zDugkxOe2Ehf76E4IWYQB5aSCX8Ygkum4wxgm6ZTQe73LwPNmoxyN4mnoS2qyOppPcmBfbLdWH
 4YIYbvGK+QD9Zv8VXea5aTxVPVCl/KRgRMoz8tQpeMcyepMuXdZC73sW2W00vfOd6hWJKbeqMd7
 YfyZ2avSl1xlgnAmdMh2A4+fAWRSd9Wai/Lv25v4zupQncOfyT/IPgg5Wxjf4ExytFrb7HBAa85
 NzZ6AVMxejRk5ZWIKKyjT+ZUinbWaCLE/3QFzNb9xaar6qdunwk9a8kK1DYmhSHZbNjiP+4Y32n
 U0B811lYdFgm1BE/5ZVnUmq2z+F4Z2isaoXTWQLYroFKShmXTiBAAwsR9WsvgCsaAREAA39/jvI
 TAG/zxK2bJjI0W7ebWzUzaFwoz/sHLQdywZFVuFdWiXwZVmGNCagy/824boih/I2zY6D54531ZW
 xD4Y6dqvjhIMw1DD5/GovcUwngEGWoERtAVsrjNDvHWU8hy+DUbaXZ+C+suiA3tEw6KmKhdFOLE
 b+UurxfcrjtZCqA==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] ldt.h: Add workaround for x86_64
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

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KClRoZSBjb21taXQgYmUw
YWFjYTJmNzQyICgic3lzY2FsbHMvbW9kaWZ5X2xkdDogQWRkIGxhcGkvbGR0LmgiKSBsZWZ0IGJl
aGluZAphbiBpbXBvcnRhbnQgZmFjdG9yIG9mIG1vZGlmeV9sZHQoKTogdGhlIGtlcm5lbCBpbnRl
bnRpb25hbGx5IGNhc3RzIHRoZQpyZXR1cm4gdmFsdWUgdG8gdW5zaWduZWQgaW50LiBUaGlzIHdh
cyBoYW5kbGVkIGluCnRlc3RjYXNlcy9jdmUvY3ZlLTIwMTUtMzI5MC5jIGJ1dCB3YXMgcmVtb3Zl
ZC4gQWRkIGl0IGJhY2sgdG8gdGhlIHJlbGV2YW50CmZpbGUuCgpSZXBvcnRlZC1ieTogTWFydGlu
IERvdWNoYSA8bWRvdWNoYUBzdXNlLmN6PgpTaWduZWQtb2ZmLWJ5OiBSaWNhcmRvIEIuIE1hcmxp
w6hyZSA8cmJtQHN1c2UuY29tPgotLS0KQ2hhbmdlcyBpbiB2MjoKLSBBZGRlZCBUQlJPSyBmb3Ig
YW55IHJldCAhPSAwIGluIG1vZGlmeV9sZHQgY2FsbCBpbiBjdmUtMjAxNS0zMjkwLmMKLSBMaW5r
IHRvIHYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjUwNTA3LWZpeGVzLW1vZGlmeV9s
ZHQtdjEtMS03MGEyNjk0Y2ZkZGNAc3VzZS5jb20KLS0tCiBpbmNsdWRlL2xhcGkvbGR0LmggICAg
ICAgICAgICB8IDIyICsrKysrKysrKysrKysrKysrKysrKy0KIHRlc3RjYXNlcy9jdmUvY3ZlLTIw
MTUtMzI5MC5jIHwgIDggKysrKysrKy0KIDIgZmlsZXMgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xhcGkvbGR0LmggYi9pbmNs
dWRlL2xhcGkvbGR0LmgKaW5kZXggNmI1YTJkNTljYjQxYmZjMjRlYjVhYzI2YzNkNDdkNDlmYjhm
Zjc4Zi4uMTczMzIxZGQ5YWMzNGJhODdlZmYwZWVlOTYwNjM1ZjMwZDg3ODk5MSAxMDA2NDQKLS0t
IGEvaW5jbHVkZS9sYXBpL2xkdC5oCisrKyBiL2luY2x1ZGUvbGFwaS9sZHQuaApAQCAtMzEsNyAr
MzEsMjcgQEAgc3RydWN0IHVzZXJfZGVzYyB7CiBzdGF0aWMgaW5saW5lIGludCBtb2RpZnlfbGR0
KGludCBmdW5jLCBjb25zdCBzdHJ1Y3QgdXNlcl9kZXNjICpwdHIsCiAJCQkgICAgIHVuc2lnbmVk
IGxvbmcgYnl0ZWNvdW50KQogewotCXJldHVybiB0c3Rfc3lzY2FsbChfX05SX21vZGlmeV9sZHQs
IGZ1bmMsIHB0ciwgYnl0ZWNvdW50KTsKKwlsb25nIHJ2YWw7CisKKwllcnJubyA9IDA7CisJcnZh
bCA9IHRzdF9zeXNjYWxsKF9fTlJfbW9kaWZ5X2xkdCwgZnVuYywgcHRyLCBieXRlY291bnQpOwor
CisjaWZkZWYgX194ODZfNjRfXworCS8qCisJICogVGhlIGtlcm5lbCBpbnRlbnRpb25hbGx5IGNh
c3RzIG1vZGlmeV9sZHQoKSByZXR1cm4gdmFsdWUKKwkgKiB0byB1bnNpZ25lZCBpbnQgdG8gcHJl
dmVudCBzaWduIGV4dGVuc2lvbiB0byA2NCBiaXRzLiBUaGlzIG1heQorCSAqIHJlc3VsdCBpbiBz
eXNjYWxsKCkgcmV0dXJuaW5nIHRoZSB2YWx1ZSBhcyBpcyBpbnN0ZWFkIG9mIHNldHRpbmcKKwkg
KiBlcnJubyBhbmQgcmV0dXJuaW5nIC0xLgorCSAqLworCWlmIChydmFsID4gMCAmJiAoaW50KXJ2
YWwgPCAwKSB7CisJCXRzdF9yZXMoVElORk8sCisJCQkiV0FSTklORzogTGliYyBtaXNoYW5kbGVk
IG1vZGlmeV9sZHQoKSByZXR1cm4gdmFsdWUiKTsKKwkJZXJybm8gPSAtKGludCllcnJubzsKKwkJ
cnZhbCA9IC0xOworCX0KKyNlbmRpZiAvKiBfX3g4Nl82NF9fICovCisKKwlyZXR1cm4gcnZhbDsK
IH0KIAogc3RhdGljIGlubGluZSBpbnQgc2FmZV9tb2RpZnlfbGR0KGNvbnN0IGNoYXIgKmZpbGUs
IGNvbnN0IGludCBsaW5lbm8sIGludCBmdW5jLApkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2N2ZS9j
dmUtMjAxNS0zMjkwLmMgYi90ZXN0Y2FzZXMvY3ZlL2N2ZS0yMDE1LTMyOTAuYwppbmRleCA4ZWMx
ZDUzYmJiNWE5ZjNlNzc2MWQzOTg1NWQzNGY1OTNlMTE4YTI4Li5lNzA3NDJhY2M4N2MzOTA4ODk1
M2UwMmYxNjE0NmI3YjU4YTc1ZmQxIDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMvY3ZlL2N2ZS0yMDE1
LTMyOTAuYworKysgYi90ZXN0Y2FzZXMvY3ZlL2N2ZS0yMDE1LTMyOTAuYwpAQCAtMTk3LDcgKzE5
NywxMyBAQCBzdGF0aWMgdm9pZCBzZXRfbGR0KHZvaWQpCiAJCS51c2VhYmxlCSA9IDAKIAl9Owog
Ci0JU0FGRV9NT0RJRllfTERUKDEsICZkYXRhX2Rlc2MsIHNpemVvZihkYXRhX2Rlc2MpKTsKKwlU
RVNUKG1vZGlmeV9sZHQoMSwgJmRhdGFfZGVzYywgc2l6ZW9mKGRhdGFfZGVzYykpKTsKKwlpZiAo
VFNUX1JFVCA9PSAtMSAmJiBUU1RfRVJSID09IEVJTlZBTCkgeworCQl0c3RfYnJrKFRDT05GIHwg
VFRFUlJOTywKKwkJCSJtb2RpZnlfbGR0OiAxNi1iaXQgZGF0YSBzZWdtZW50cyBhcmUgcHJvYmFi
bHkgZGlzYWJsZWQiKTsKKwl9IGVsc2UgaWYgKFRTVF9SRVQgIT0gMCkgeworCQl0c3RfYnJrKFRC
Uk9LIHwgVFRFUlJOTywgIm1vZGlmeV9sZHQiKTsKKwl9CiB9CiAKIHN0YXRpYyB2b2lkIHRyeV9j
b3JydXB0X3N0YWNrKHVuc2lnbmVkIHNob3J0ICpvcmlnX3NzKQoKLS0tCmJhc2UtY29tbWl0OiBi
MDcwYTU2OTJlMDM1ZWMxMmMzZDNjN2E3ZTllOTdjMjcwZmQ0ZDdkCmNoYW5nZS1pZDogMjAyNTA1
MDctZml4ZXMtbW9kaWZ5X2xkdC1lYmNmZGQyYTdkMzAKCkJlc3QgcmVnYXJkcywKLS0gClJpY2Fy
ZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+CgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
