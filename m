Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21E9C3ABC0
	for <ltp@archiver.kernel.org>; Wed,  7 May 2025 23:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1746661066; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=5QrPIZhmSJ31wE+BfJTKMjfN+6Be9Ndi0Tosw4pE8Uw=;
 b=auvGVc/WjzTiENJumocgdAL5nXc2kabQCcoQFDOwG7NJlEkVwcfzMwsJmRx55PuCXPKTC
 0D3xTQoTTdYcwLQSdJRhNtS6/vRRTH59SD7dCSqx5uI7GcmaNjlFOkGCA7lah70QRZ0brH9
 EVyRn0flKC836sByRtvMnDbxh4oEwAQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA7523CBDC2
	for <ltp@archiver.kernel.org>; Thu,  8 May 2025 01:37:46 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 92C4F3CB2D0
 for <ltp@lists.linux.it>; Thu,  8 May 2025 01:37:23 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BB8EF680436
 for <ltp@lists.linux.it>; Thu,  8 May 2025 01:37:22 +0200 (CEST)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5fbee322ddaso745648a12.0
 for <ltp@lists.linux.it>; Wed, 07 May 2025 16:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1746661042; x=1747265842; darn=lists.linux.it;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UO4SuQJyGr7vlyDpikmfdjbHzPEx5bQYNMuEnnu5f94=;
 b=Ar2iZTUJpLG6vwvxIh8RCxV0cJ8ADI7bPthkRZ0zK40GFr0DO3N7cpio2cfkvrsqdZ
 wUh9D0oWU6j895IbuRAPXkvTmGsfxGSa05AvtePp6aBBarR4ksg1adJYMpX8EhrTn2eP
 fLOX4a1TLft0omlKxPJBgUCoZqqxi1EeGDJU7dHjWGe1ijBnLYpxXGhGsike+N24/F/k
 ONhH5Oxu/EaLhMxkIUPyzLCkHrHpq54YMfeqmtx16EC7C2DxziUidVut4nzWTUN5CPYD
 PCWnaiL/4LRPqS0uonTXvN6GzxLs5icX8fP6qS9tF1eY11AR+199xYc+XJyUh4A0R372
 5bhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746661042; x=1747265842;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UO4SuQJyGr7vlyDpikmfdjbHzPEx5bQYNMuEnnu5f94=;
 b=TML/20ZU5x1fzb8or7P9aNZGwwOxofPV2WZwqZGWrCL3e9l8JIQj8nD+gEY3iQq0TQ
 gnCOGrnV0W/nxUgDFE4Zvr+xGkctUD2llZW5HacNSJICLJlkcwvA9XBqJYTBdf4CZsDQ
 lwSFgriknUrgQpG62N6R7rqCazTf9tlyNtODaNbXvogT3jQHCN2oiA/WEJd6amM70Y+X
 J93NdC1+BQmz+LzSQBlz9vrqx1Ve/SOe65pF2P4HaMMnuG3Fcyts7TETCvAQ26Xh1Dfw
 C/sAUecsosgczZ7wLDnxTEWyEDuwHtQxUkEoVGLrM6J5gZWbUBLdANlQmsrXC/3rDlnG
 RgzQ==
X-Gm-Message-State: AOJu0YzzBF4IDT7qSj9G+/ZW0LuXRZfZFHJpk1l24EYR3QqPqveF0Zim
 bBbeUm/FJQ5yHMvM4HzjZJWt8eSSFjqLA9wKbT/KoJAZTwav40vS74p4gpEei9vSKhPRszQa1FZ
 c
X-Gm-Gg: ASbGncvB1dCa25AOqpUSyoMz3NXcF+ochjbLNX3R/5BB6shQjwCXtEEj8B7iCZHnLKf
 4NKNmI/joJhBShaiewGn4jHRzieIMR034E6Wzwoxy6A8NHjm6sE+JoGRYYuOzclp15erUrTruzn
 K2MrRCbO/rZHJiDtAt2HvaCgmHY+MmMH22DVXe5KFeQfrj/67EdTBI8Kr2j6FQFjBX1m+pktvzz
 STeVLFXm+KGWZsmOEISL0MLz2szczTVZUdbcqD0L//p1JEDYF59auUZOVRbkvOZEtwXFbPfiIj8
 2MpKxJlo6c4YKpd3azPNWqEpjyTs
X-Google-Smtp-Source: AGHT+IHWPxqixxUskzp9XMK9GTVdZTBtfOT42+Y8ljdLYn+88Q78WEAbvlbcmXD5YpxxUDuDF35Aqw==
X-Received: by 2002:a17:906:6a0b:b0:ad1:8d41:ee51 with SMTP id
 a640c23a62f3a-ad1e8cd7139mr542974566b.42.1746661041954; 
 Wed, 07 May 2025 16:37:21 -0700 (PDT)
Received: from localhost ([177.45.162.169])
 by smtp.gmail.com with UTF8SMTPSA id
 46e09a7af769-73210a1a0c3sm848816a34.34.2025.05.07.16.37.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:37:21 -0700 (PDT)
Date: Wed, 07 May 2025 20:37:16 -0300
MIME-Version: 1.0
Message-Id: <20250507-fixes-modify_ldt-v1-1-70a2694cfddc@suse.com>
X-B4-Tracking: v=1; b=H4sIAKvuG2gC/x3M0QrCMAyF4VcZuTZYO8bAVxGRtkm3gGslGaKMv
 budlx+c/2xgrMIG124D5beY1NJwOXWQ5lAmRqFm8M4PbnAjZvmw4VJJ8vfxpBU5pkzkw0i9g5a
 9lP+bVt3uzTEYY9RQ0nwcVZVJynkJtrLCvv8Avq7e4oIAAAA=
X-Change-ID: 20250507-fixes-modify_ldt-ebcfdd2a7d30
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2426; i=rbm@suse.com;
 h=from:subject:message-id; bh=Q75I99LLo82aGDklpdS2O8eJGj9pLdeGL4zZMV+EUxg=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBoG+6tVdrLYfPfnjqCA+qUrhaDZUraqJ+w+UEy5
 03sF3mLK1yJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaBvurQAKCRDJC4p8Y4ZY
 pnWpEACOLGQJ4KPbhQcWJJ0KBy6CpUx1B6c5LZnysjbrGymYRKXky9fr9o1H+jw6g9HJqTh0eos
 jDfFBrbTV7uEBNtOyLXiRUklz7PA4aHlddZQHsCkrF11TU09io3LGMWoStukETZvc4US9qJGLLU
 BJ5todKPkSl1Y+s3gIaz4jxayDCjUuDAgyIla9QLs/tHNczKn5/mRkWD80B7TobH+dLtoTOSQCm
 weOln3bt4f4S3mQ8OLwC4npq3uKxj/bH39iw71JPJpEv0JgzXG3Gg59IubrvGNpvpeN4WsnLECB
 AhKBwNuxtDYaL+codnL3B/42gWwJRs1yyHKrqDS2MIR/wL+E7jze/Xn4aZPc8s50UzYikjalls9
 /Jqe49uYu1feUkB4c+N0hK92FOOx9B2uO2TThLpwaUzJzPtOjKnOTsityyb2eJqoGXHdwa45mI/
 6PxnyW7rpDjgKGkz+i8aeNK64z1UbyHBghLkvd0T0nQ56cHpcQQMKIoaIvcWM2fi6ptx6fG+YRd
 2fDLfzqNTh+EGF24At1tltcokcm8xRSqAw9hwzUxO5QZxgEheYn0e4ACWAoXkzCHpNZc/WVjvf8
 4aAEMXR63EQfYuRFmb23ft+PZHCtcrBPUfjpwa2WWueREyUTzDVrK3uhjPNhKANV5hTnws1kkrb
 jCQ/spy/kktZ4sg==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] ldt.h: Add workaround for x86_64
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
w6hyZSA8cmJtQHN1c2UuY29tPgotLS0KIGluY2x1ZGUvbGFwaS9sZHQuaCAgICAgICAgICAgIHwg
MjIgKysrKysrKysrKysrKysrKysrKysrLQogdGVzdGNhc2VzL2N2ZS9jdmUtMjAxNS0zMjkwLmMg
fCAgNiArKysrKy0KIDIgZmlsZXMgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xhcGkvbGR0LmggYi9pbmNsdWRlL2xhcGkvbGR0
LmgKaW5kZXggNmI1YTJkNTljYjQxYmZjMjRlYjVhYzI2YzNkNDdkNDlmYjhmZjc4Zi4uMTczMzIx
ZGQ5YWMzNGJhODdlZmYwZWVlOTYwNjM1ZjMwZDg3ODk5MSAxMDA2NDQKLS0tIGEvaW5jbHVkZS9s
YXBpL2xkdC5oCisrKyBiL2luY2x1ZGUvbGFwaS9sZHQuaApAQCAtMzEsNyArMzEsMjcgQEAgc3Ry
dWN0IHVzZXJfZGVzYyB7CiBzdGF0aWMgaW5saW5lIGludCBtb2RpZnlfbGR0KGludCBmdW5jLCBj
b25zdCBzdHJ1Y3QgdXNlcl9kZXNjICpwdHIsCiAJCQkgICAgIHVuc2lnbmVkIGxvbmcgYnl0ZWNv
dW50KQogewotCXJldHVybiB0c3Rfc3lzY2FsbChfX05SX21vZGlmeV9sZHQsIGZ1bmMsIHB0ciwg
Ynl0ZWNvdW50KTsKKwlsb25nIHJ2YWw7CisKKwllcnJubyA9IDA7CisJcnZhbCA9IHRzdF9zeXNj
YWxsKF9fTlJfbW9kaWZ5X2xkdCwgZnVuYywgcHRyLCBieXRlY291bnQpOworCisjaWZkZWYgX194
ODZfNjRfXworCS8qCisJICogVGhlIGtlcm5lbCBpbnRlbnRpb25hbGx5IGNhc3RzIG1vZGlmeV9s
ZHQoKSByZXR1cm4gdmFsdWUKKwkgKiB0byB1bnNpZ25lZCBpbnQgdG8gcHJldmVudCBzaWduIGV4
dGVuc2lvbiB0byA2NCBiaXRzLiBUaGlzIG1heQorCSAqIHJlc3VsdCBpbiBzeXNjYWxsKCkgcmV0
dXJuaW5nIHRoZSB2YWx1ZSBhcyBpcyBpbnN0ZWFkIG9mIHNldHRpbmcKKwkgKiBlcnJubyBhbmQg
cmV0dXJuaW5nIC0xLgorCSAqLworCWlmIChydmFsID4gMCAmJiAoaW50KXJ2YWwgPCAwKSB7CisJ
CXRzdF9yZXMoVElORk8sCisJCQkiV0FSTklORzogTGliYyBtaXNoYW5kbGVkIG1vZGlmeV9sZHQo
KSByZXR1cm4gdmFsdWUiKTsKKwkJZXJybm8gPSAtKGludCllcnJubzsKKwkJcnZhbCA9IC0xOwor
CX0KKyNlbmRpZiAvKiBfX3g4Nl82NF9fICovCisKKwlyZXR1cm4gcnZhbDsKIH0KIAogc3RhdGlj
IGlubGluZSBpbnQgc2FmZV9tb2RpZnlfbGR0KGNvbnN0IGNoYXIgKmZpbGUsIGNvbnN0IGludCBs
aW5lbm8sIGludCBmdW5jLApkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2N2ZS9jdmUtMjAxNS0zMjkw
LmMgYi90ZXN0Y2FzZXMvY3ZlL2N2ZS0yMDE1LTMyOTAuYwppbmRleCA4ZWMxZDUzYmJiNWE5ZjNl
Nzc2MWQzOTg1NWQzNGY1OTNlMTE4YTI4Li42YWEwNjRiYWIzMGEwMzlkMjY4YjJlOWYxNzI1ODU2
NGVkYTgwNjdjIDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMvY3ZlL2N2ZS0yMDE1LTMyOTAuYworKysg
Yi90ZXN0Y2FzZXMvY3ZlL2N2ZS0yMDE1LTMyOTAuYwpAQCAtMTk3LDcgKzE5NywxMSBAQCBzdGF0
aWMgdm9pZCBzZXRfbGR0KHZvaWQpCiAJCS51c2VhYmxlCSA9IDAKIAl9OwogCi0JU0FGRV9NT0RJ
RllfTERUKDEsICZkYXRhX2Rlc2MsIHNpemVvZihkYXRhX2Rlc2MpKTsKKwlURVNUKG1vZGlmeV9s
ZHQoMSwgJmRhdGFfZGVzYywgc2l6ZW9mKGRhdGFfZGVzYykpKTsKKwlpZiAoVFNUX1JFVCA9PSAt
MSAmJiBUU1RfRVJSID09IEVJTlZBTCkgeworCQl0c3RfYnJrKFRDT05GIHwgVFRFUlJOTywKKwkJ
CSJtb2RpZnlfbGR0OiAxNi1iaXQgZGF0YSBzZWdtZW50cyBhcmUgcHJvYmFibHkgZGlzYWJsZWQi
KTsKKwl9CiB9CiAKIHN0YXRpYyB2b2lkIHRyeV9jb3JydXB0X3N0YWNrKHVuc2lnbmVkIHNob3J0
ICpvcmlnX3NzKQoKLS0tCmJhc2UtY29tbWl0OiBiMDcwYTU2OTJlMDM1ZWMxMmMzZDNjN2E3ZTll
OTdjMjcwZmQ0ZDdkCmNoYW5nZS1pZDogMjAyNTA1MDctZml4ZXMtbW9kaWZ5X2xkdC1lYmNmZGQy
YTdkMzAKCkJlc3QgcmVnYXJkcywKLS0gClJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5j
b20+CgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
