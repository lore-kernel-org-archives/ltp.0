Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D966C3DA4A
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 10:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1722508834; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=0D6YgtNe++J/fT60L+q+VC/yp3KaQpTJjwfmXjaGFG4=;
 b=mO9I7aVZ0YQwOIBW0cpZfutbjQeULx8mJREUY1369ZZB06BTvh+84hUTO0QyU7Ci8KUi5
 d/ey4oifmZacxD6Ufi7YUxQUJe1ZArsona6ocl6NRYfGNRu91A3GewM1AGlcFPfQ19k1937
 7bhEJ+bVZHG+Jq6OXoM3upEIdtPrlFU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CACD93D1F46
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 12:40:34 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 49AE93D1F24
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 12:40:11 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A2C4E60714A
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 12:40:10 +0200 (CEST)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-368313809a4so1138307f8f.0
 for <ltp@lists.linux.it>; Thu, 01 Aug 2024 03:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1722508809; x=1723113609; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NVJHLWTrSvs4PJ+N2GqtYCdrEJUMB4KWSQ35qZZuuLY=;
 b=H8VFKiHM4TQVxoxb8J10KyDTytu1KXeMeu+GcbaWKlTLoufVEeUhJdo1NXn/GuUtz2
 E3/l1Bw3JBYEwltE2mzci4msisFtSx3z/GVpRC1uoo60UjYj5roAT5TbljqYqGwFQuma
 KWuVPrbN0GAwmqXHvfteEBj3n4K9TTdBi+0fNQS0opue6IXdLM8l4Sre4Kb9w/sFhhX7
 QniRlpZZi0n/xTJpByPCx7j5Cc828/6waiKjm1FrR8TvVOWtpKz9IieK/GnwHGgKkDER
 qmYAwnx5Gf7FCEaHg2YDeJr1Oqy+d2S7blPA4ZfhyuvFf7VmNJErvB/IRHqkm1KOzRh8
 nlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722508809; x=1723113609;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NVJHLWTrSvs4PJ+N2GqtYCdrEJUMB4KWSQ35qZZuuLY=;
 b=uBO8mrGY91A7BCO5PaLHtjHH50/ehUCJsXfFrN6eg0V8V/Oe1CBJMz27n3P5K7m0A5
 nqMNjEu9ecCRT/3rh01pUC1fE13dGi22WRa+ElT3tcS8G7m/Zdr9WA6Pk9FpZ2fFW0x0
 gcPCR4ZKwfvLrJX36bjztaourk2lWSyAjc68Lyvre4GfbEotVwwE8Aak79baD8OZTBzD
 O2nCWUfRBsaIJnoOGtqi09+nXcLySYHb0a53SYpbZ0u+zFFUKa3Ml2ES8F7OCsWIMjAZ
 S4XVuGf+e0krueVfSNdmDIuzl9MBVJxfl0jAGgav5UNQ7E7Wps2U4PCVEx70UuIjz8Ta
 RXkg==
X-Gm-Message-State: AOJu0YyhKjXsxIaQMNkp1/Xyd9/oz3RLOPuBP+mnyeLfB43SXyiDRlXI
 rIQ5ETF1lsw63g6EzmwC7coKx4CFOBbSt5iNi5BT13wnC2+N8qzqQJxWYYrcoBY8zxKBxYnP0JE
 =
X-Google-Smtp-Source: AGHT+IEKFVu6AP6jdKGJDI5XInMPkwovc2MzCcPAC3QPUrmnNK6odZAGQRYH1ola1I8QbqglX8piHw==
X-Received: by 2002:a05:6000:a90:b0:36b:aa27:3f79 with SMTP id
 ffacd0b85a97d-36bb358477cmr1028042f8f.4.1722508809306; 
 Thu, 01 Aug 2024 03:40:09 -0700 (PDT)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7fbe089sm135586385ad.269.2024.08.01.03.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 03:40:08 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu,  1 Aug 2024 06:40:04 -0400
Message-Id: <20240801104004.15514-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] cpuset_memory_test.c: Use $TMPDIR as prefix for
 HUGEPAGE file path
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

VGVzdCBjYXNlIHdpbGwgZmFpbCB3aXRoIGZvbGxvd2luZyBlcnJvciBpZiBydW5uaW5nIG9wZXJh
dGlvbiBzeXN0ZW0Kd2hpY2ggZm9yY2Ugcm9vdCBwYXRoIHJlYWQgT05MWS4KCm1rZGlyOiBjYW5u
b3QgY3JlYXRlIGRpcmVjdG9yeSDigJgvaHVnZXRsYuKAmTogUmVhZC1vbmx5IGZpbGUgc3lzdGVt
CgpTaWduZWQtb2ZmLWJ5OiBXZWkgR2FvIDx3ZWdhb0BzdXNlLmNvbT4KLS0tCiAuLi4vY3B1c2V0
X21lbW9yeV90ZXN0L2NwdXNldF9tZW1vcnlfdGVzdC5jICAgICAgfCAxMSArKysrKysrKy0tLQog
Li4uL2NwdXNldF9tZW1vcnlfdGVzdC9jcHVzZXRfbWVtb3J5X3Rlc3RzZXQuc2ggIHwgMTYgKysr
KysrKystLS0tLS0tLQogMiBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAxMSBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL2NvbnRyb2xsZXJzL2NwdXNl
dC9jcHVzZXRfbWVtb3J5X3Rlc3QvY3B1c2V0X21lbW9yeV90ZXN0LmMgYi90ZXN0Y2FzZXMva2Vy
bmVsL2NvbnRyb2xsZXJzL2NwdXNldC9jcHVzZXRfbWVtb3J5X3Rlc3QvY3B1c2V0X21lbW9yeV90
ZXN0LmMKaW5kZXggOTkxMmQ4ZDZhLi43Mzc3MGZkM2MgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9r
ZXJuZWwvY29udHJvbGxlcnMvY3B1c2V0L2NwdXNldF9tZW1vcnlfdGVzdC9jcHVzZXRfbWVtb3J5
X3Rlc3QuYworKysgYi90ZXN0Y2FzZXMva2VybmVsL2NvbnRyb2xsZXJzL2NwdXNldC9jcHVzZXRf
bWVtb3J5X3Rlc3QvY3B1c2V0X21lbW9yeV90ZXN0LmMKQEAgLTE3Nyw5ICsxNzcsMTQgQEAgdm9p
ZCBtbWFwX2ZpbGUoaW50IGZsYWdfYWxsb2NhdGVkKQogCXN0YXRpYyBpbnQgZmRfaHVnZXBhZ2U7
CiAJaW50IGZkX3RtcDsKIAorCWNoYXIgcGF0aFsxMDBdOworCWNoYXIgKnRtcGRpciA9IGdldGVu
digiVE1QRElSIik7CisKKwlzcHJpbnRmKHBhdGgsICIlcyVzIiwgdG1wZGlyLCBGSUxFX0hVR0VQ
QUdFKTsKKwogCWlmICghZmxhZ19hbGxvY2F0ZWQpIHsKIAkJaWYgKG9wdF9odWdlcGFnZSkgewot
CQkJZmRfaHVnZXBhZ2UgPSBvcGVuKEZJTEVfSFVHRVBBR0UsCisJCQlmZF9odWdlcGFnZSA9IG9w
ZW4ocGF0aCwKIAkJCQkJICAgT19DUkVBVCB8IE9fUkRXUiwgMDc1NSk7CiAJCQlpZiAoZmRfaHVn
ZXBhZ2UgPCAwKQogCQkJCWVycigxLCAib3BlbiBodWdlcGFnZSBmaWxlIGZhaWxlZCIpOwpAQCAt
MTkxLDcgKzE5Niw3IEBAIHZvaWQgbW1hcF9maWxlKGludCBmbGFnX2FsbG9jYXRlZCkKIAkJCSBN
QVBfU0hBUkVELCBmZF90bXAsIDApOwogCQlpZiAocCA9PSBNQVBfRkFJTEVEKSB7CiAJCQlpZiAo
b3B0X2h1Z2VwYWdlKQotCQkJCXVubGluayhGSUxFX0hVR0VQQUdFKTsKKwkJCQl1bmxpbmsocGF0
aCk7CiAJCQllcnIoMSwgIm1tYXAoZmlsZSkgZmFpbGVkIik7CiAJCX0KIAkJdG91Y2hfbWVtb3J5
X2FuZF9lY2hvX25vZGUocCwgbWVtc2l6ZSk7CkBAIC0yMDEsNyArMjA2LDcgQEAgdm9pZCBtbWFw
X2ZpbGUoaW50IGZsYWdfYWxsb2NhdGVkKQogCiAJCWlmIChvcHRfaHVnZXBhZ2UpIHsKIAkJCWNs
b3NlKGZkX2h1Z2VwYWdlKTsKLQkJCXVubGluayhGSUxFX0hVR0VQQUdFKTsKKwkJCXVubGluayhw
YXRoKTsKIAkJfQogCX0KIH0KZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxl
cnMvY3B1c2V0L2NwdXNldF9tZW1vcnlfdGVzdC9jcHVzZXRfbWVtb3J5X3Rlc3RzZXQuc2ggYi90
ZXN0Y2FzZXMva2VybmVsL2NvbnRyb2xsZXJzL2NwdXNldC9jcHVzZXRfbWVtb3J5X3Rlc3QvY3B1
c2V0X21lbW9yeV90ZXN0c2V0LnNoCmluZGV4IGMxZTdjZWE4Zi4uYjYzNDI1MDg4IDEwMDc1NQot
LS0gYS90ZXN0Y2FzZXMva2VybmVsL2NvbnRyb2xsZXJzL2NwdXNldC9jcHVzZXRfbWVtb3J5X3Rl
c3QvY3B1c2V0X21lbW9yeV90ZXN0c2V0LnNoCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJv
bGxlcnMvY3B1c2V0L2NwdXNldF9tZW1vcnlfdGVzdC9jcHVzZXRfbWVtb3J5X3Rlc3RzZXQuc2gK
QEAgLTE3NSw4ICsxNzUsOCBAQCB0ZXN0NigpCiAJCXJldHVybiAwCiAJZmkKIAotCW1rZGlyIC9o
dWdldGxiCi0JbW91bnQgLXQgaHVnZXRsYmZzIG5vbmUgL2h1Z2V0bGIKKwlta2RpciAke1RNUERJ
Un0vaHVnZXRsYgorCW1vdW50IC10IGh1Z2V0bGJmcyBub25lICR7VE1QRElSfS9odWdldGxiCiAK
IAlzYXZlX25yX2h1Z2VwYWdlcz0kKGNhdCAvcHJvYy9zeXMvdm0vbnJfaHVnZXBhZ2VzKQogCWVj
aG8gJCgoMiokbnJfbWVtcykpID4gL3Byb2Mvc3lzL3ZtL25yX2h1Z2VwYWdlcwpAQCAtMTg0LDgg
KzE4NCw4IEBAIHRlc3Q2KCkKIAljcHVzZXRfbWVtb3J5X3Rlc3QgLS1tbWFwLWZpbGUgLS1odWdl
cGFnZSAtcyAkSFVHRVBBR0VTSVpFID4iJE1FTU9SWV9SRVNVTFQiICYKIAlzaW1wbGVfZ2V0cmVz
dWx0ICQhICIkQ1BVU0VULzAiCiAKLQl1bW91bnQgL2h1Z2V0bGIKLQlybWRpciAvaHVnZXRsYgor
CXVtb3VudCAke1RNUERJUn0vaHVnZXRsYgorCXJtZGlyICR7VE1QRElSfS9odWdldGxiCiAKIAll
Y2hvICRzYXZlX25yX2h1Z2VwYWdlcyA+IC9wcm9jL3N5cy92bS9ucl9odWdlcGFnZXMKIAlpZiBb
ICQoY2F0IC9wcm9jL3N5cy92bS9ucl9odWdlcGFnZXMpIC1uZSAkc2F2ZV9ucl9odWdlcGFnZXMg
XTsgdGhlbgpAQCAtMjE0LDggKzIxNCw4IEBAIHRlc3Q3KCkKIAkJcmV0dXJuIDAKIAlmaQogCi0J
bWtkaXIgL2h1Z2V0bGIKLQltb3VudCAtdCBodWdldGxiZnMgbm9uZSAvaHVnZXRsYgorCW1rZGly
ICR7VE1QRElSfS9odWdldGxiCisJbW91bnQgLXQgaHVnZXRsYmZzIG5vbmUgJHtUTVBESVJ9L2h1
Z2V0bGIKIAogCXNhdmVfbnJfaHVnZXBhZ2VzPSQoY2F0IC9wcm9jL3N5cy92bS9ucl9odWdlcGFn
ZXMpCiAJZWNobyAkKCgyKiRucl9tZW1zKSkgPiAvcHJvYy9zeXMvdm0vbnJfaHVnZXBhZ2VzCkBA
IC0yMjMsOCArMjIzLDggQEAgdGVzdDcoKQogCWNwdXNldF9tZW1vcnlfdGVzdCAtLXNobSAtLWh1
Z2VwYWdlIC1zICRIVUdFUEFHRVNJWkUgLS1rZXk9NyA+IiRNRU1PUllfUkVTVUxUIiAmCiAJc2lt
cGxlX2dldHJlc3VsdCAkISAiJENQVVNFVC8wIgogCi0JdW1vdW50IC9odWdldGxiCi0Jcm1kaXIg
L2h1Z2V0bGIKKwl1bW91bnQgJHtUTVBESVJ9L2h1Z2V0bGIKKwlybWRpciAke1RNUERJUn0vaHVn
ZXRsYgogCiAJZWNobyAkc2F2ZV9ucl9odWdlcGFnZXMgPiAvcHJvYy9zeXMvdm0vbnJfaHVnZXBh
Z2VzCiAJaWYgWyAkKGNhdCAvcHJvYy9zeXMvdm0vbnJfaHVnZXBhZ2VzKSAtbmUgJHNhdmVfbnJf
aHVnZXBhZ2VzIF07IHRoZW4KLS0gCjIuMzUuMwoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0
cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
