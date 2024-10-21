Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AEE8D17141
	for <ltp@archiver.kernel.org>; Mon, 21 Oct 2024 22:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1729548373; h=date :
 mime-version : message-id : to : cc : subject : list-id :
 list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=IDdvl+HiL+xAKzQFNnEWoATDgSgHMpuCMfqEeYVWA40=;
 b=jyQtd1chfrqGWb5sRj8HK8YGH/9kSj9VWbeuQ0ll+ieykQRxoiDJewmcynda3cw8l6GLG
 qyplwO9lWjUGOFDrpjfghi2A1aMx5E7RYZhKfH5gWY71gty1l4sunIVVIk4MgKRs4qTk+8M
 PRx1exoc6DBex2PK6ytvefzY4F5wiUw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 842E83C6F33
	for <ltp@archiver.kernel.org>; Tue, 22 Oct 2024 00:06:13 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8FDF63C6747
 for <ltp@lists.linux.it>; Tue, 22 Oct 2024 00:05:53 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B57811182E7B
 for <ltp@lists.linux.it>; Tue, 22 Oct 2024 00:05:52 +0200 (CEST)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-37d6a2aa748so3276056f8f.1
 for <ltp@lists.linux.it>; Mon, 21 Oct 2024 15:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1729548352; x=1730153152; darn=lists.linux.it;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OdS6xVlG/EFYxX1OBtGVGA/EYWUkTtGA/nuWnVOitTY=;
 b=HEhQKeZpDRUmGRCdnMIlYjChMYOb2oGrYF673z/O267HA925VqzHaL2BGS7EMX+UpU
 SGXTwT8dAFsrP87muDO5x47LgE+kpGe5OPH6fy8ShVyJtm+dz3vda31fh8kfJNNns8tk
 xwR9MiPDehud+vS3rRyo74EQFnqWJu3vsgIlAZw/2pYf+1HdOQLS4+WzKlk7W2ooc+MW
 qeQ4ImbyDn0Nz/AkxCtGjtlBzeHmmrobCIs1+S8WFrTcBt8GVNmbXzsdNiZRe7ijcawA
 sxdGNR3ECTHEqVRyiyLrmo5BXGXo2v4qQFFk5t9ZR59FZhRU1ZJwmSRnWc1kazVK/rbI
 lTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729548352; x=1730153152;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OdS6xVlG/EFYxX1OBtGVGA/EYWUkTtGA/nuWnVOitTY=;
 b=Yr7bg0u/jAR3iy0vC0/FWhgGiKgq5KO38bvp4otv1pGgW1JVj1/2U3Phan5HrO/WIo
 k6dIy985lKwxesol0Ub8I2TGQ34umc20T5vA+VvxA7YgTCXmpEuhMbmC0Mg8s0caYy1T
 qyfHghLOh9RwKIB4GMqyVLPnDLK2PW6FYZuigOasw1E9CrD5KQGxLeOhcHmLqVzprBeG
 uMX858CtBz1CFEXwDur28E3gb/lMn3vM3B3Uc8hL9AlIKtt7llU6NzT48u2UsGRG4+a5
 HEXTkM6mGin3i2Gfw6KS8RueBLmsX3ublvlZ1f+GIhrF+0AVxnB1aEhq7ZeaeBLtIIDJ
 5OtA==
X-Gm-Message-State: AOJu0Yzw+++jgrDHT1YrevYgSTC9DJwpU+noJIsy3YBtiBdz89WfZ72n
 SeakwrAlodPeGCkaj3RpoKCV4/PGe0PCcCHkmO4LSZQIj2N0ug4ciThJEeNi1LW+FDS/11znJBF
 4
X-Google-Smtp-Source: AGHT+IHlD3TjUhxrxYxQsNEDhBXxnGpyVQJB2fmBO7eRwFR1jymzq3h4ZUgeIMwEtyfkXnxo7XnF6w==
X-Received: by 2002:adf:ecc3:0:b0:37d:45ad:8394 with SMTP id
 ffacd0b85a97d-37ea2164cf9mr7316102f8f.15.1729548352031; 
 Mon, 21 Oct 2024 15:05:52 -0700 (PDT)
Received: from localhost ([177.68.4.104]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec13d7416sm3381513b3a.101.2024.10.21.15.05.50
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 15:05:51 -0700 (PDT)
Date: Mon, 21 Oct 2024 19:05:07 -0300
MIME-Version: 1.0
Message-Id: <20241021-block_dev-v2-1-339a95c89fe0@suse.com>
X-B4-Tracking: v=1; b=H4sIABLQFmcC/23MQQrCMBCF4auUWRvJTFWqK+8hRZpkYoPaSEaDU
 nJ3Y9cu/8fjm0E4BRY4NDMkzkFCnGrQqgE7DtOFVXC1gTRtUGOnzC3a69lxVrYlwi2xbgcH9f9
 I7MN7sU597THIM6bPQmf8rf+UjAqVR7/vnGdjdu4oL+G1jXfoSylfsWnbwqEAAAA=
X-Change-ID: 20241018-block_dev-c322152e03ad
To: ltp@lists.linux.it
Cc: 
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4527; i=rbm@suse.com;
 h=from:subject:message-id; bh=Wik7YsDmSd+Y8fuvxQM1URvMwdHT+PehC387kaTjGjk=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBnFtA7SWmW+E2koUPQXpRJW6gjeYDaTi3oROQBY
 45uKV4klRqJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZxbQOwAKCRDJC4p8Y4ZY
 pr9wD/96kznQHXjz5UzszLY64AO3y/b7CwrYYQZzejhXtANN/SHIIl0oBpF1AMgbSGhA7nnG6yV
 jNWxIgXgWTHJEHNoC1AnFwkr0/7/tNTrgcYAc1P4Oqr0kikiLNqopIxcWfOgi2YFZ+QWox1WpE0
 NFeZ8INnT0GXHc/UDQZD38M+X6rbwIleMxpdHzTJXKYfu1KyZBfqf4qKXt8t2sxoc2Lz4qU1KWS
 3n/OMzpr9PmXzPwyeKIjIfTLTHdCX3b5KGcG/5N+B29s+XAecxP2UcMDQinh9qjfuAVljheXuNW
 WDdeJecmd9LIfcSRk9oIypBcGJntJJXobO76ssob29fXt7t8woQs2KG5Z1ilm7HzvNGHIBVsva5
 tOqSLe8LfxIi/AHd52d3O4L59IQ3vp5UDJiEB9yghkHp/LLDRRPcjBdz9/FKhjHsibS16K1aJbZ
 VzFOuCjWXVDKoq26FxPUDEHoT0aJQ3PHZDmClEo/Y8dEFRYRAxDf+VUDonX4XTFm0+uDKPQDEp4
 bEHxv34I4HiVdy4HXsreZfP4Hlh6viOwzDQjH/cK5hTyFZCdeVJUyk6jr9vVAW8WUH2KVAzJpoA
 DK38Kq05lMHtpn3hwuAu+cBENqeqz1IHPLUY3Cb9vZ6AimE2eHHeBu8MN0ChFCwEpOe+Rzc4Ru4
 jr1T93LCpN/IrBQ==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] block_dev: Convert to new API
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
From: "Ricardo B. Marliere via ltp" <ltp@lists.linux.it>
Reply-To: "Ricardo B. Marliere" <rbm@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

U2lnbmVkLW9mZi1ieTogUmljYXJkbyBCLiBNYXJsaWVyZSA8cmJtQHN1c2UuY29tPgotLS0KdjEt
PnYyOgotIEFkZGVkIGlmZGVmIGZvciBpbmNsdWRpbmcgZ2VuaGQuaCBpbiBvbGRlciBrZXJuZWxz
Ci0gUmVtb3ZlZCB1bnVzZWQgcG9pbnRlcgotIEZpeGVkIGBtYWtlIGNoZWNrYCBsaW50ZXIgd2Fy
bmluZ3MKLSBMaW5rIHRvIHYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjQxMDE4LWJs
b2NrX2Rldi12MS0xLWYxZjk4ZGZlYmI2ZEBzdXNlLmNvbQp2MToKLSBUZXN0ZWQgYWdhaW5zdCB2
Ni4xMQotLS0KIC4uLi9ibG9jay9ibG9ja19kZXZfa2VybmVsL2x0cF9ibG9ja19kZXYuYyAgICAg
ICAgIHwgIDQgKy0KIC4uLi9ibG9jay9ibG9ja19kZXZfdXNlci9ibG9ja19kZXYuYyAgICAgICAg
ICAgICAgIHwgNzcgKysrKysrKysrLS0tLS0tLS0tLS0tLQogMiBmaWxlcyBjaGFuZ2VkLCAzNCBp
bnNlcnRpb25zKCspLCA0NyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2Vy
bmVsL2RldmljZS1kcml2ZXJzL2Jsb2NrL2Jsb2NrX2Rldl9rZXJuZWwvbHRwX2Jsb2NrX2Rldi5j
IGIvdGVzdGNhc2VzL2tlcm5lbC9kZXZpY2UtZHJpdmVycy9ibG9jay9ibG9ja19kZXZfa2VybmVs
L2x0cF9ibG9ja19kZXYuYwppbmRleCAxNzA0N2MwZDVhZTNmNjU1NmYzZmE0YjBlYjJhMTdhODZl
NWYwNWE2Li41Y2UxNDVjOWY4N2QxYzhhMTNjMzI1MDU1OTU5OTAxNDVkMjRhOTI4IDEwMDY0NAot
LS0gYS90ZXN0Y2FzZXMva2VybmVsL2RldmljZS1kcml2ZXJzL2Jsb2NrL2Jsb2NrX2Rldl9rZXJu
ZWwvbHRwX2Jsb2NrX2Rldi5jCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvZGV2aWNlLWRyaXZlcnMv
YmxvY2svYmxvY2tfZGV2X2tlcm5lbC9sdHBfYmxvY2tfZGV2LmMKQEAgLTEyLDggKzEyLDEwIEBA
CiAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+CiAjaW5jbHVkZSA8bGludXgvZGV2aWNlLmg+CiAj
aW5jbHVkZSA8bGludXgvZnMuaD4KLSNpbmNsdWRlIDxsaW51eC9nZW5oZC5oPgogI2luY2x1ZGUg
PGxpbnV4L2Jsa2Rldi5oPgorI2lmbmRlZiBESVNLX05BTUVfTEVOCisjaW5jbHVkZSA8bGludXgv
Z2VuaGQuaD4KKyNlbmRpZgogCiBNT0RVTEVfQVVUSE9SKCJNw6FydG9uIE7DqW1ldGggPG5tMTI3
QGZyZWVtYWlsLmh1PiIpOwogTU9EVUxFX0FVVEhPUigiQ29weXJpZ2h0IChjKSAyMDEzIE9yYWNs
ZSBhbmQvb3IgaXRzIGFmZmlsaWF0ZXMiKTsKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwv
ZGV2aWNlLWRyaXZlcnMvYmxvY2svYmxvY2tfZGV2X3VzZXIvYmxvY2tfZGV2LmMgYi90ZXN0Y2Fz
ZXMva2VybmVsL2RldmljZS1kcml2ZXJzL2Jsb2NrL2Jsb2NrX2Rldl91c2VyL2Jsb2NrX2Rldi5j
CmluZGV4IDU0M2MzNjc5NWNjM2IyNzc2YzU5MTQxMDIzZTAzZmYyYzU4YmQzNmEuLjlmODdhODhj
OWY5MTUwZWQxNzcxNjE2ODIxZDI2ZTQ5ODJjNTU3MDggMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9r
ZXJuZWwvZGV2aWNlLWRyaXZlcnMvYmxvY2svYmxvY2tfZGV2X3VzZXIvYmxvY2tfZGV2LmMKKysr
IGIvdGVzdGNhc2VzL2tlcm5lbC9kZXZpY2UtZHJpdmVycy9ibG9jay9ibG9ja19kZXZfdXNlci9i
bG9ja19kZXYuYwpAQCAtMSwzICsxLDQgQEAKKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBH
UEwtMi4wLW9yLWxhdGVyCiAvKgogICogQ29weXJpZ2h0IChjKSAyMDEzIE9yYWNsZSBhbmQvb3Ig
aXRzIGFmZmlsaWF0ZXMuIEFsbCBSaWdodHMgUmVzZXJ2ZWQuCiAgKgpAQCAtMjYsNzQgKzI3LDU4
IEBACiAjaW5jbHVkZSA8dW5pc3RkLmg+CiAjaW5jbHVkZSA8c3RyaW5nLmg+CiAKLSNpbmNsdWRl
ICJ0ZXN0LmgiCi0jaW5jbHVkZSAic2FmZV9tYWNyb3MuaCIKLSNpbmNsdWRlICJvbGRfbW9kdWxl
LmgiCisjaW5jbHVkZSAidHN0X3Rlc3QuaCIKKyNpbmNsdWRlICJ0c3RfbW9kdWxlLmgiCiAKLWNo
YXIgKlRDSUQgPSAiYmxvY2tfZGV2IjsKLWludCBUU1RfVE9UQUwgPSA5OworI2RlZmluZSBNT0RV
TEVfTkFNRSAibHRwX2Jsb2NrX2RldiIKKyNkZWZpbmUgTU9EVUxFX05BTUVfS08JTU9EVUxFX05B
TUUgIi5rbyIKIAotc3RhdGljIGNvbnN0IGNoYXIgbW9kdWxlX25hbWVbXQk9ICJsdHBfYmxvY2tf
ZGV2LmtvIjsKIHN0YXRpYyBjb25zdCBjaGFyIGRldl9yZXN1bHRbXQk9ICIvc3lzL2RldmljZXMv
bHRwX2Jsb2NrX2Rldi9yZXN1bHQiOwogc3RhdGljIGNvbnN0IGNoYXIgZGV2X3RjYXNlW10JPSAi
L3N5cy9kZXZpY2VzL2x0cF9ibG9ja19kZXYvdGNhc2UiOwotc3RhdGljIGludCBtb2R1bGVfbG9h
ZGVkOwogCi1zdGF0aWMgaW50IHJ1bl9hbGxfdGVzdGNhc2VzOwotc3RhdGljIGNvbnN0IG9wdGlv
bl90IG9wdGlvbnNbXSA9IHsKLQl7ImEiLCAmcnVuX2FsbF90ZXN0Y2FzZXMsIE5VTEx9LAorc3Rh
dGljIGludCBtb2R1bGVfbG9hZGVkOworc3RhdGljIGNoYXIgKnJ1bl9hbGxfdGVzdGNhc2VzOwor
c3RhdGljIHN0cnVjdCB0c3Rfb3B0aW9uIG9wdGlvbnNbXSA9IHsKKwl7ImEiLCAgJnJ1bl9hbGxf
dGVzdGNhc2VzLCAiLWFcdFJ1biBhbGwgdGVzdC1jYXNlcyAoY2FuIGNyYXNoIHRoZSBrZXJuZWwp
In0sCiAJe05VTEwsIE5VTEwsIE5VTEx9CiB9OwogCiBzdGF0aWMgdm9pZCBjbGVhbnVwKHZvaWQp
CiB7CiAJaWYgKG1vZHVsZV9sb2FkZWQpCi0JCXRzdF9tb2R1bGVfdW5sb2FkKE5VTEwsIG1vZHVs
ZV9uYW1lKTsKLX0KLQotc3RhdGljIHZvaWQgaGVscCh2b2lkKQotewotCXByaW50ZigiICAtYSAg
ICAgIFJ1biBhbGwgdGVzdC1jYXNlcyAoY2FuIGNyYXNoIHRoZSBrZXJuZWwpXG4iKTsKLX0KLQot
dm9pZCBzZXR1cChpbnQgYXJnYywgY2hhciAqYXJndltdKQotewotCXRzdF9wYXJzZV9vcHRzKGFy
Z2MsIGFyZ3YsIG9wdGlvbnMsIGhlbHApOwotCi0JdHN0X3JlcXVpcmVfcm9vdCgpOwotCi0JdHN0
X3NpZyhGT1JLLCBERUZfSEFORExFUiwgY2xlYW51cCk7CisJCXRzdF9tb2R1bGVfdW5sb2FkKE1P
RFVMRV9OQU1FX0tPKTsKIH0KIAotc3RhdGljIHZvaWQgdGVzdF9ydW4odm9pZCkKK3N0YXRpYyB2
b2lkIHJ1bih1bnNpZ25lZCBpbnQgbikKIHsKLQlpbnQgb2ZmID0gMDsKIAkvKgogCSAqIHRlc3Qt
Y2FzZXMgIzggYW5kICM5IGNhbiBjcmFzaCB0aGUga2VybmVsLgogCSAqIFdlIGhhdmUgdG8gd2Fp
dCBmb3Iga2VybmVsIGZpeCB3aGVyZSByZWdpc3Rlcl9ibGtkZXYoKSAmCiAJICogdW5yZWdpc3Rl
cl9ibGtkZXYoKSBjaGVja3MgdGhlIGlucHV0IGRldmljZSBuYW1lIHBhcmFtZXRlcgogCSAqIGFn
YWluc3QgTlVMTCBwb2ludGVyLgogCSAqLwotCWlmICghcnVuX2FsbF90ZXN0Y2FzZXMpCi0JCW9m
ZiA9IDI7Ci0KLQl0c3RfbW9kdWxlX2xvYWQoY2xlYW51cCwgbW9kdWxlX25hbWUsIE5VTEwpOwot
CW1vZHVsZV9sb2FkZWQgPSAxOwotCi0JaW50IGksIHBhc3MgPSAwOwotCWZvciAoaSA9IDA7IGkg
PCBUU1RfVE9UQUwgLSBvZmY7ICsraSkgewotCQlTQUZFX0ZJTEVfUFJJTlRGKGNsZWFudXAsIGRl
dl90Y2FzZSwgIiVkIiwgaSArIDEpOwotCQlTQUZFX0ZJTEVfU0NBTkYoY2xlYW51cCwgZGV2X3Jl
c3VsdCwgIiVkIiwgJnBhc3MpOwotCQl0c3RfcmVzbSgocGFzcykgPyBUUEFTUyA6IFRGQUlMLCAi
VGVzdC1jYXNlICclZCciLCBpICsgMSk7CisJbisrOworCWlmICghcnVuX2FsbF90ZXN0Y2FzZXMg
JiYgKG4gPT0gOCB8fCBuID09IDkpKSB7CisJCXRzdF9yZXMoVENPTkYsICJTa2lwcGVkIG4gPSAl
ZCIsIG4pOworCQlyZXR1cm47CiAJfQotfQogCi1pbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJn
dltdKQotewotCXNldHVwKGFyZ2MsIGFyZ3YpOwotCi0JdGVzdF9ydW4oKTsKKwlpZiAoIW1vZHVs
ZV9sb2FkZWQpIHsKKwkJdHN0X21vZHVsZV9sb2FkKE1PRFVMRV9OQU1FX0tPLCBOVUxMKTsKKwkJ
bW9kdWxlX2xvYWRlZCA9IDE7CisJfQogCi0JY2xlYW51cCgpOworCWludCBwYXNzID0gMDsKIAot
CXRzdF9leGl0KCk7CisJU0FGRV9GSUxFX1BSSU5URihkZXZfdGNhc2UsICIlZCIsIG4pOworCVNB
RkVfRklMRV9TQ0FORihkZXZfcmVzdWx0LCAiJWQiLCAmcGFzcyk7CisJdHN0X3JlcygocGFzcykg
PyBUUEFTUyA6IFRGQUlMLCAiVGVzdC1jYXNlICclZCciLCBuKTsKIH0KKworc3RhdGljIHN0cnVj
dCB0c3RfdGVzdCB0ZXN0ID0geworCS5uZWVkc19yb290ID0gMSwKKwkuY2xlYW51cCA9IGNsZWFu
dXAsCisJLnRlc3QgPSBydW4sCisJLnRjbnQgPSA5LAorCS5vcHRpb25zID0gb3B0aW9ucywKK307
CgotLS0KYmFzZS1jb21taXQ6IDQ3YWZmNGRlY2M4MWFjODM3ZmQ3NDUyNzhkZWY2ODgzZmMyZjE5
N2IKY2hhbmdlLWlkOiAyMDI0MTAxOC1ibG9ja19kZXYtYzMyMjE1MmUwM2FkCgpCZXN0IHJlZ2Fy
ZHMsCi0tIApSaWNhcmRvIEIuIE1hcmxpZXJlIDxyYm1Ac3VzZS5jb20+CgoKLS0gCk1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
