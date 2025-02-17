Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F235C021A9
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 22:02:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E8C723C993B
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 23:02:22 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 38D6F3C9C10
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 23:01:31 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BBDEB22BDD8
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 23:01:30 +0100 (CET)
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-220e989edb6so91896155ad.1
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 14:01:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739829689; x=1740434489;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:dkim-signature:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aiVKgoc7isiai54kzwJcQgFeNxrWEHw51ZFfLDyVB3c=;
 b=qyfSVr/8RFCu0QaDvqrX4RTJQk7Uhhxiv1kvyEMgJY9qzldxuznqZYubI82hEz+h2f
 IxjaGTIZLS5n8jQqQsjS/3mdlr7zG4LuUe6jSg60mpottGw6/xcftXZxR3GTJLlWI5ar
 9iDxfFi3fR+q5TV/6+4SGauJ1M0udQ0vqQ22HR/eWMgmLMcIBpjaNd2J1HWbK4Hr4Jya
 EUtCYqaKHRoPGWvjd6SJkT+z0tRhkHgQMb3vAlfVzvwIjqlm2fatOIm6766pFIsNTqfQ
 ggWGIPqO5XiQLE4E0tHU/JrTUNgKHbRkdQ8esosZKrEYit1BYe6bCoRl98vd4aatU/Qy
 PDiA==
X-Gm-Message-State: AOJu0Ywlnv5LsGmQEDEgkfqdnvF0a1ja5wLnWKNPyhBvTOz+J1LmXHG9
 zQ7j61wvNhFKASyKWRftn++qoEcPksyCMonDi8fuc700qI9NW+cWcbBpnD1h
X-Gm-Gg: ASbGncu/M1AhkukDXdOA7xE0wQN1lrDe2Avvwp9wdAoplCAmPdPHjQ/sOG6X9R4lrCQ
 mdfePfEMX5qyO1xTdhereN3zao+lAvcI1gRSgUnfFj2NRjbBPkXcjPsjrtN5TuydQTjYG94qbV/
 Ds5p9+tvbf0jYajdDycxSH4dHOR6K+G+BWEBRJ5vuX6fl44+Ed/pNgeOoTY7cBZx6cGguF6jJsY
 9cc8clVAOgTewm+NCH0BNAy+DJjUvtCeQB3bRV4egD3CAAAFTyB3+i62/+11aQO0oFoGvffJe4D
 rpNoqRvh7ENb9jTGdFtagMshMQpDVlD3
X-Google-Smtp-Source: AGHT+IFabgNvBQ9p0qXRfDAsEuA0vCVF3rwnVDOIey4Q8U6aGmWizxcQ2VC5IDoGORrPj6IKkbtHRQ==
X-Received: by 2002:a17:902:fc4e:b0:21f:71b4:d2aa with SMTP id
 d9443c01a7336-22103efeebcmr203595845ad.5.1739829688681; 
 Mon, 17 Feb 2025 14:01:28 -0800 (PST)
Received: from mail.marliere.net (marliere.net. [24.199.118.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366b24sm76714975ad.97.2025.02.17.14.01.27
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 14:01:28 -0800 (PST)
From: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
 s=2025; t=1739829687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aiVKgoc7isiai54kzwJcQgFeNxrWEHw51ZFfLDyVB3c=;
 b=M76EySSqBN9KycZJOaScTAhgMLIP+nCRIoO5CoTuZHYECfVZs3Uk3Xia1nc5vcoolCe0kw
 nlSFPRpy5MlhYZhb4MYF5Pe+jk3V1TEwspW+V1/I+fthg8pGbA3tlLLwgF7VA8UQOoO7th
 x0WZfkUUc42gqDobUW3VRc/Zwp1f8RB19Isb0FoFS+bOTgzQ2xj7M5IwLl7BncylDjPCpO
 Tx5tC3Fd+sckR7hGkwyd7l2Wgl2mJUFwVtLLqDltGTOeiGE/d/gFu+XbW00F3bpq2U0vcF
 Ta8F55WVDzmRIYIDrBQyifqxPqKeAaoDNEN+0qZRoCiGFAuFL3uWMZhqwiwtNg==
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Mon, 17 Feb 2025 19:01:16 -0300
MIME-Version: 1.0
Message-Id: <20250217-conversions-pause-v1-2-be8be41cb154@marliere.net>
References: <20250217-conversions-pause-v1-0-be8be41cb154@marliere.net>
In-Reply-To: <20250217-conversions-pause-v1-0-be8be41cb154@marliere.net>
To: Linux Test Project <ltp@lists.linux.it>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3768; i=ricardo@marliere.net; 
 h=from:subject:message-id;
 bh=jNd9jmSpXt0mDuKzQQ61bVX0azt3didrBOAei+wR3ns=; 
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBns7Gtfuw+cA6lVy+rhM2FVvqjKhSZ4C8Z99TFB
 9SOf6nhfbKJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ7OxrQAKCRDJC4p8Y4ZY
 pkQaD/4mmVz+ot6pIFv3aQlE6aD0E5eQLEPeGYtKUpZGUV59kfofSjcQalh40LfaIXOoadKwUmb
 mHZyovk+GEIwq1sHFnRzIxoaFzLDvO7MT21Gx3C1eN9kqQTeoyytIFD6pJmDWiOE7qrQv7g5fwQ
 fvPW8fz+WeT1WvotvyAF7oWPMzUl8Nt1j4geBaHInqgw6NInI9HNCf6492GC6UgIOR7J95JrbHS
 hzjBL5cDu00yCORPxeTdPS0tU8G7le2mR69BzJQCeWaQQ2Ywt4Nc3fn/P7vF3MAn5+59RE2SgpD
 MS+tOYCzmUzvNQutnll4h+MgqhUvMpyAv3X3esGgXrrUAVNsuT//gfPfUVUpiRN3J+tLf0Ci0mB
 N814eWTDGZB5NWI5VmV5Gv2PM4HuWylypAawsANW7Y8z60Mgg2ZmwaY4B7a/HSl3RBPZ6Jmxsap
 QB2/eK11zjggddW7k29irY2wBzb0buHJlphQea89ps0ScFrws0uCkGMnzsm6bSQTTNVgcIvmAqG
 wkQBtEgPC5FC00hNBlechNYi1BBIdjO/r5PQ3voVG5kjiYRzWBE+SGnm7Loow0o+LpHWTB4Ot11
 NLLuDl32m7D0qmPx86jUFS4JFxA11OO2lm5FPhdEloHeYJOUyIi4VG+Y+Nnw0jUzUzimZFulnSt
 fd7OpuLQOEQbR+A==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] syscalls/pause03: Refactor into new API
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

U2lnbmVkLW9mZi1ieTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJpY2FyZG9AbWFybGllcmUubmV0
PgotLS0KIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcGF1c2UvcGF1c2UwMy5jIHwgMTE0ICsr
KysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDI1IGluc2VydGlv
bnMoKyksIDg5IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvcGF1c2UvcGF1c2UwMy5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9wYXVzZS9w
YXVzZTAzLmMKaW5kZXggNDU5MjIyMDQ1YzA4ZGMxZmM0ODA0ZWZkMmVjZTAyMzE2ZmU1NWEwZS4u
NjQxNjEwYTc4MjkwZGUxZjI1YzFmODM4OGM3ZWM1MDIzZGQwMDE4MCAxMDA2NDQKLS0tIGEvdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9wYXVzZS9wYXVzZTAzLmMKKysrIGIvdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9wYXVzZS9wYXVzZTAzLmMKQEAgLTEsMTA0ICsxLDQwIEBACisvLyBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgogLyoKICAqIENvcHlyaWdodCAo
YykgSW50ZXJuYXRpb25hbCBCdXNpbmVzcyBNYWNoaW5lcyAgQ29ycC4sIDIwMDEKLSAqICAwNy8y
MDAxIFBvcnRlZCBieSBXYXluZSBCb3llcgotICoKLSAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNv
ZnR3YXJlOyAgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQotICogaXQgdW5k
ZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJsaXNo
ZWQgYnkKLSAqIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247IGVpdGhlciB2ZXJzaW9uIDIg
b2YgdGhlIExpY2Vuc2UsIG9yCi0gKiAoYXQgeW91ciBvcHRpb24pIGFueSBsYXRlciB2ZXJzaW9u
LgotICoKLSAqIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0
IHdpbGwgYmUgdXNlZnVsLAotICogYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyAgd2l0aG91dCBl
dmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mCi0gKiBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVT
UyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBTZWUKLSAqIHRoZSBHTlUgR2VuZXJhbCBQdWJs
aWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLgotICoKLSAqIFlvdSBzaG91bGQgaGF2ZSByZWNl
aXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCi0gKiBhbG9uZyB3
aXRoIHRoaXMgcHJvZ3JhbTsgIGlmIG5vdCwgd3JpdGUgdG8gdGhlIEZyZWUgU29mdHdhcmUgRm91
bmRhdGlvbiwKLSAqIEluYy4sIDUxIEZyYW5rbGluIFN0cmVldCwgRmlmdGggRmxvb3IsIEJvc3Rv
biwgTUEgMDIxMTAtMTMwMSBVU0EKKyAqIENvcHlyaWdodCAoYykgTGludXggVGVzdCBQcm9qZWN0
LCAyMDI1CisgKiAwNy8yMDAxIFBvcnRlZCBieSBXYXluZSBCb3llcgogICovCisKIC8qCi0gKiBU
ZXN0IERlc2NyaXB0aW9uOgotICogIHBhdXNlKCkgZG9lcyBub3QgcmV0dXJuIGR1ZSB0byByZWNl
aXB0IG9mIFNJR0tJTEwgc2lnbmFsIGFuZCBzcGVjaWZpZWQKLSAqICBwcm9jZXNzIHNob3VsZCBi
ZSB0ZXJtaW5hdGVkLgorICogVGhpcyB0ZXN0IHZlcmlmaWVzIHRoYXQgcGF1c2UoKSBkb2VzIG5v
dCByZXR1cm4gYWZ0ZXIgcmVjZWl2aW5nIGEgU0lHS0lMTAorICogc2lnbmFsLCBhdCB3aGljaCBw
b2ludCB0aGUgcHJvY2VzcyBzaG91bGQgYmUgdGVybWluYXRlZC4KICAqLwotI2luY2x1ZGUgPHVu
aXN0ZC5oPgotI2luY2x1ZGUgPGVycm5vLmg+Ci0jaW5jbHVkZSA8ZmNudGwuaD4KLSNpbmNsdWRl
IDxzeXMvd2FpdC5oPgotCi0jaW5jbHVkZSAidGVzdC5oIgotI2luY2x1ZGUgInNhZmVfbWFjcm9z
LmgiCi0KLXN0YXRpYyBwaWRfdCBjcGlkOwotCi1jaGFyICpUQ0lEID0gInBhdXNlMDMiOwotaW50
IFRTVF9UT1RBTCA9IDE7CiAKLXN0YXRpYyB2b2lkIGRvX2NoaWxkKHZvaWQpOwotc3RhdGljIHZv
aWQgc2V0dXAodm9pZCk7Ci1zdGF0aWMgdm9pZCBjbGVhbnVwKHZvaWQpOworI2luY2x1ZGUgInRz
dF90ZXN0LmgiCiAKLWludCBtYWluKGludCBhYywgY2hhciAqKmF2KQordm9pZCBydW4odm9pZCkK
IHsKLQlpbnQgbGM7CiAJaW50IHN0YXR1czsKKwlwaWRfdCBwaWQ7CiAKLQl0c3RfcGFyc2Vfb3B0
cyhhYywgYXYsIE5VTEwsIE5VTEwpOwotCi0Jc2V0dXAoKTsKLQotCWZvciAobGMgPSAwOyBURVNU
X0xPT1BJTkcobGMpOyBsYysrKSB7Ci0JCXRzdF9jb3VudCA9IDA7Ci0KLQkJaWYgKChjcGlkID0g
dHN0X2ZvcmsoKSkgPT0gLTEpCi0JCQl0c3RfYnJrbShUQlJPSyB8IFRFUlJOTywgTlVMTCwgImZv
cmsoKSBmYWlsZWQiKTsKLQotCQlpZiAoY3BpZCA9PSAwKQotCQkJZG9fY2hpbGQoKTsKLQotCQlU
U1RfUFJPQ0VTU19TVEFURV9XQUlUKGNsZWFudXAsIGNwaWQsICdTJyk7Ci0KLQkJa2lsbChjcGlk
LCBTSUdLSUxMKTsKLQotCQlTQUZFX1dBSVQoTlVMTCwgJnN0YXR1cyk7Ci0KLQkJaWYgKFdJRlNJ
R05BTEVEKHN0YXR1cykgJiYgV1RFUk1TSUcoc3RhdHVzKSA9PSBTSUdLSUxMKSB7Ci0JCQl0c3Rf
cmVzbShUUEFTUywgInBhdXNlKCkgZGlkIG5vdCByZXR1cm4gYWZ0ZXIgU0lHS0lMTCIpOwotCQkJ
Y29udGludWU7Ci0JCX0KLQotCQlpZiAoV0lGU0lHTkFMRUQoc3RhdHVzKSkgewotCQkJdHN0X3Jl
c20oVEZBSUwsICJjaGlsZCBraWxsZWQgYnkgJXMgdW5leHBlY3RlZGx5IiwKLQkJCSAgICAgICAg
IHRzdF9zdHJzaWcoV1RFUk1TSUcoc3RhdHVzKSkpOwotCQkJY29udGludWU7Ci0JCX0KLQotCQl0
c3RfcmVzbShURkFJTCwgImNoaWxkIGV4aXRlZCB3aXRoICVpIiwgV0VYSVRTVEFUVVMoc3RhdHVz
KSk7CisJcGlkID0gU0FGRV9GT1JLKCk7CisJaWYgKCFwaWQpIHsKKwkJcGF1c2UoKTsKKwkJdHN0
X3JlcyhURkFJTCwgIlVuZXhwZWN0ZWQgcmV0dXJuIGZyb20gcGF1c2UoKSIpOworCQlleGl0KDAp
OwogCX0KIAotCWNsZWFudXAoKTsKLQl0c3RfZXhpdCgpOworCVRTVF9QUk9DRVNTX1NUQVRFX1dB
SVQocGlkLCAnUycsIDEwMDAwKTsKKwlraWxsKHBpZCwgU0lHS0lMTCk7CisJU0FGRV9XQUlUUElE
KHBpZCwgJnN0YXR1cywgMCk7CiAKKwlpZiAoV0lGU0lHTkFMRUQoc3RhdHVzKSAmJiBXVEVSTVNJ
RyhzdGF0dXMpID09IFNJR0tJTEwpCisJCXRzdF9yZXMoVFBBU1MsICJwYXVzZSgpIGRpZCBub3Qg
cmV0dXJuIGFmdGVyIFNJR0tJTEwiKTsKKwllbHNlCisJCXRzdF9yZXMoVEZBSUwsICJDaGlsZCBl
eGl0ZWQgd2l0aCAlaSIsIFdFWElUU1RBVFVTKHN0YXR1cykpOwogfQogCi12b2lkIGRvX2NoaWxk
KHZvaWQpCi17Ci0JVEVTVChwYXVzZSgpKTsKLQotCXRzdF9yZXNtKFRGQUlMLCAiVW5leHBlY3Rl
ZCByZXR1cm4gZnJvbSBwYXVzZSgpIik7Ci0KLQlleGl0KDApOwotfQotCi12b2lkIHNldHVwKHZv
aWQpCi17Ci0JdHN0X3NpZyhGT1JLLCBERUZfSEFORExFUiwgY2xlYW51cCk7Ci0KLQlURVNUX1BB
VVNFOwotfQotCi0KLXZvaWQgY2xlYW51cCh2b2lkKQotewotCWtpbGwoY3BpZCwgU0lHS0lMTCk7
Ci19CitzdGF0aWMgc3RydWN0IHRzdF90ZXN0IHRlc3QgPSB7CisJLnRlc3RfYWxsID0gcnVuLAor
CS5mb3Jrc19jaGlsZCA9IDEsCit9OwoKLS0gCjIuNDguMQoKCi0tIApNYWlsaW5nIGxpc3QgaW5m
bzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
