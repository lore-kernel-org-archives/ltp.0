Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBEEFC83F07
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 11:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751888127; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=nxMMyrh1RxqaDyAAZ+TnxOkaw30dwugggXGdlViBC24=;
 b=IlxjGlJMhUbt+MxKrTnZ0TgM4sFiw3IAOE8vfEqSM03NNvLNEeSf0woBNtVexdsq3bDs+
 aS3LzmMVRQ3cjFNZptHmwrKCwWSOrc6m+wAD4xep6aqyZiOsERn9JXCAh+ouxcpT9dd66n/
 cpwnpOVrSJRJWgWN7rXEZdhCm180qFs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 547FC3C99D5
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 13:35:27 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 547A03C2365
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 13:35:06 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5DBDB1A00378
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 13:35:05 +0200 (CEST)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a54690d369so2981310f8f.3
 for <ltp@lists.linux.it>; Mon, 07 Jul 2025 04:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751888104; x=1752492904; darn=lists.linux.it;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8JLkwZb5E/dj4xBYnyRek3hNg+oxLlGjEpGWF8liRfM=;
 b=XgH/gpWSoYGVBF8A1ykNfROEEZ46hkj41HrKvAnKOxqBVRGGnPJjV/Rl9C+RJJCxw6
 NdPWlUZnH0FCHIEja6/SOu7uJrgsHrHsmdXb/92TOTVE+2i6e3G6C8SwdKnFdwONHyGE
 UD5/9AdGHTi8h9PSIDKLixQI9mRvL2av4CJHOsp5uWMok89so/DkOZ+iZ3wlKltgOgXy
 kTGWW3Cf6RWpA2oR+1AQ3HmbJlEDKbY6MV9FvP32baTNSVUhuEu/xM4vLnow16pkb5xV
 XB7i1BAwLBslN2s6ZTZ+t0qznjy5Gdq4CURUyrzBNrUKtvajpdvOZt8KFeVwjkVcJFmP
 FdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751888104; x=1752492904;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8JLkwZb5E/dj4xBYnyRek3hNg+oxLlGjEpGWF8liRfM=;
 b=YVjEiUMJZtJhM+uxv6w3EUIzQZFx2sa/JYfiJ0ux4cxUzd7CjNqsPwvd98w01Zfkoe
 D9ByhsdbdLIMnta1Yk3lmMPqeHkkHemoD7EONs1VxVAuWawyoOoO+M5r6ZOQvyVCLQ/4
 0ZLGshWlVWbsOb2kOPvA9bReH9C5QuUMKiK8rnG7BZgzMjzQufCB83Bvn8s6znE/65wp
 XKDpWFxeOpFoqcSml4C9XtWd1+nxqpJlBy21M9nraS91KQm3usAW0Qs7tlf9AeQzzPHn
 ixV0V1IL2ik6j51Ap4vqwgpGKFA/0w3K7E66P2dVDFbmOyVHN7A9tByMQXxzbIXb0s8Q
 6Q9Q==
X-Gm-Message-State: AOJu0YxFugV1Zx7BG02SqIfQL5+R9+vXNd4djh/Dd9rOccn978P3RsDu
 bE1XfdolG06a8Tw5dbvEc8cyIshB8l3tPoisRE5bH8qP6y4n4UhProiNz/eE2UBz2E/K+JY/XB7
 H1LPV
X-Gm-Gg: ASbGncv15Bl84TXIE03iGJ8x17NQOLyj4AMntgTtOa+gHJiPGydiNmBs2MYS4864Jo9
 hCP4lMilHkuwf9P8yfGfscYkv1HU3fZPybCKK4iKrL4JMFALEJWbyHQEVejf7mUj3vTRiHo71qL
 xEBo3kBpiSjhDwC9UWkaNOvapqJ3eFhOsKIGcK4GqfoI4nz3kQDjbqkCNnTSfB3TkUdaWld1+4r
 1pd8sIEkwrf7cZKdzK81vfslaUbss4IRApa2UswORuoBCCmFX1srgLmuZ4gW0BQDCwNLhf7vVzK
 ivZHGudmnqQnJM8AEFgaIk5NB+PrRp9uNdR1+ETUwcQaIescdg==
X-Google-Smtp-Source: AGHT+IEY0RghYWoqeY1KXxk2hURATSH7TqDaCDqdugo40podlTgJJPUbwCZBm8t2hPH917yKMpDTNg==
X-Received: by 2002:a05:6000:4612:b0:3a4:dd8e:e16d with SMTP id
 ffacd0b85a97d-3b49700aa4fmr9849278f8f.15.1751888104371; 
 Mon, 07 Jul 2025 04:35:04 -0700 (PDT)
Received: from localhost ([177.45.162.214])
 by smtp.gmail.com with UTF8SMTPSA id
 af79cd13be357-7d5dbe7b5b0sm581000885a.60.2025.07.07.04.35.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jul 2025 04:35:01 -0700 (PDT)
Date: Mon, 07 Jul 2025 08:34:55 -0300
MIME-Version: 1.0
Message-Id: <20250707-new-munmap04-v3-1-e3efda8e7d2b@suse.com>
X-B4-Tracking: v=1; b=H4sIAN6wa2gC/32NsQ6CMBRFf4V0tua1QBUn/8M4PMpDOrSQFqqG8
 O+2TC46nuSec1cWyBsK7FKszFM0wYwuQXkomB7QPYibLjGTIGs4QcUdPbldnMUpAdaNRglIAJo
 lZfLUm9eeu90TtxiItx6dHnLEYpjJ5+Fgwjz6934bRZ7/eIiCC66ob5Qozy008hqWQEc9WpYPo
 vznyuRWpdJn6FKgUl/utm0fMlnIY/wAAAA=
X-Change-ID: 20250704-new-munmap04-a59ca20ae00c
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4755; i=rbm@suse.com;
 h=from:subject:message-id; bh=4rDaRTZcjn5A/mlqFX3OtUtTzf4uftkk0KTQPbXdMAA=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBoa7DhWUTiqVBv5Eul2CHf3M6OXEqTYpKXCvWkj
 g/vuY42Qb2JAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaGuw4QAKCRDJC4p8Y4ZY
 plhiD/94taXDqJJoVqF6s7LMQHJT7bxIPI7CwNMqXCCHxzJlTFy40ZPMG9+t7HX7U8xop4KMXwJ
 rixwerzNlh6glUSYKYjn+Ak8rYObz1RFU1Ez6c4C+HnN6Oc3VKXMhaM6Pa6CIDfW0k4HDpqgoRM
 OyDiLYDo//0Lr5Dqk2hCe1Z+G1+3mX1Aj7/RvkLFhm2BUSypw+Gr2TpgeHchh5aGTOyScDnGS+9
 f9i0yQpWH2UvC6dQr3pXgue39V18K7VBa6GkIzi7/DyhWaqFMiaUV4Opewk3Q4ksPbSF+3svZyK
 xXmjGSi4MfQa5loFf1gW9J/AlX48mQG4QBNgqp/Z6wJGdJBYKNcEELEMIFTMhGqlbGfJPJGfHSc
 BvumHdrxbC0rdUW+E7/romidpLGyE6fljw6r53E5JAEQOQxUx8HERubTp1SUTbl/5bkvkycRP+e
 dZE7r2txdeojlliLFHINS7tXgnsrLL0Sik/+nioGmUmNPmJBBplCOl1gpiKKw3STNFhtctp7CDa
 Z4U3LSIZEwMBT6pFamxb1TPlNFouOzGv3h13Ob4hRxnRTaXRzweVE8WRiaktJyVWesxShcE6SSs
 0WPhMR4TMaKOJCS+A8ymW2cvOXy0JdUZ/02lbJ+CX1VkW0TRUeQJhdlKWX9Y640+aZFn2i3pV9/
 opYnj692CC7/sBg==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] syscalls: munmap: Add munmap04 to check ENOMEM
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

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KClRoZSBFUlJPUlMgc2Vj
dGlvbiBvZiB0aGUgbW1hcCgyKSBtYW5wYWdlIHNheXM6CgpFTk9NRU06IFRoZSBwcm9jZXNzJ3Mg
bWF4aW11bSBudW1iZXIgb2YgbWFwcGluZ3Mgd291bGQgaGF2ZSBiZWVuIGV4Y2VlZGVkLgpUaGlz
IGVycm9yIGNhbiBhbHNvIG9jY3VyIGZvciBtdW5tYXAoKSwgd2hlbiB1bm1hcHBpbmcgYSByZWdp
b24gaW4gdGhlCm1pZGRsZSBvZiBhbiBleGlzdGluZyBtYXBwaW5nLCBzaW5jZSB0aGlzIHJlc3Vs
dHMgaW4gdHdvIHNtYWxsZXIgbWFwcGluZ3MKb24gZWl0aGVyIHNpZGUgb2YgdGhlIHJlZ2lvbiBi
ZWluZyB1bm1hcHBlZC4KCkFkZCBhIG5ldyB0ZXN0IG11bm1hcDA0IHRvIGFkZHJlc3MgdGhpcyBz
Y2VuYXJpby4KClNpZ25lZC1vZmYtYnk6IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5j
b20+Ci0tLQpDaGFuZ2VzIGluIHYzOgotIEFkZGVkIG1pc3NpbmcgaW5jbHVkZSB0byAibGFwaS9t
bWFwLmgiCi0gTWFkZSBtYXhfbWFwX2NvdW50IGEgdGVzdCBvcHRpb24KLSBLZWVwIHRoZSBtYXBw
ZWQgcmVnaW9ucyBpbiB0aGUgaGVhcAotIFJlcXVpcmVkIG1pbi4ga2VybmVsIHY0LjE3Ci0gTGlu
ayB0byB2MjogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI1MDcwNC1uZXctbXVubWFwMDQt
djItMS00MzZjODBkZjk2NDZAc3VzZS5jb20KCkNoYW5nZXMgaW4gdjI6Ci0gQ29ycmVjdGVkIHRo
ZSBjb21taXQgbWVzc2FnZQotIExpbmsgdG8gdjE6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3Iv
MjAyNTA3MDQtbmV3LW11bm1hcDA0LXYxLTEtNmVmOTYxMzhiMDkyQHN1c2UuY29tCi0tLQogcnVu
dGVzdC9zeXNjYWxscyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxICsKIHRlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvbXVubWFwLy5naXRpZ25vcmUgfCAgMSArCiB0ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL211bm1hcC9tdW5tYXAwNC5jIHwgOTQgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysKIDMgZmlsZXMgY2hhbmdlZCwgOTYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBh
L3J1bnRlc3Qvc3lzY2FsbHMgYi9ydW50ZXN0L3N5c2NhbGxzCmluZGV4IDU4MjQyMmFjOWNhOGNj
YWU1OThjNjI2YTExY2Y2ZWU3YzMwZjBlM2EuLmQ5MTg5NjNiN2FkNjE2Y2U1OTMxNDc2ZDA4MDRk
MmNiNTY2OTQyYzAgMTAwNjQ0Ci0tLSBhL3J1bnRlc3Qvc3lzY2FsbHMKKysrIGIvcnVudGVzdC9z
eXNjYWxscwpAQCAtOTUxLDYgKzk1MSw3IEBAIG11bmxvY2thbGwwMSBtdW5sb2NrYWxsMDEKIG11
bm1hcDAxIG11bm1hcDAxCiBtdW5tYXAwMiBtdW5tYXAwMgogbXVubWFwMDMgbXVubWFwMDMKK211
bm1hcDA0IG11bm1hcDA0CiAKIG5hbm9zbGVlcDAxIG5hbm9zbGVlcDAxCiBuYW5vc2xlZXAwMiBu
YW5vc2xlZXAwMgpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tdW5tYXAv
LmdpdGlnbm9yZSBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbXVubWFwLy5naXRpZ25vcmUK
aW5kZXggOTRkOGMxMGEyNGNhZTQ3YzY4MDU1NDZiZmY0MWE4NGEyYTJlODE3My4uZDQxOGRjNDUx
MmFiZTZkZmZjYjI3OWZkZGJkYmRlMjVhNGY0NDIzMCAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9tdW5tYXAvLmdpdGlnbm9yZQorKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5
c2NhbGxzL211bm1hcC8uZ2l0aWdub3JlCkBAIC0xLDMgKzEsNCBAQAogL211bm1hcDAxCiAvbXVu
bWFwMDIKIC9tdW5tYXAwMworL211bm1hcDA0CmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL211bm1hcC9tdW5tYXAwNC5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9t
dW5tYXAvbXVubWFwMDQuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLi5lMzI2ZDI0YTVmYjkyN2IxYmI3YzdkNTE0Mzhm
NWEzZDc2OTY5NmMyCi0tLSAvZGV2L251bGwKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9tdW5tYXAvbXVubWFwMDQuYwpAQCAtMCwwICsxLDk0IEBACisvLyBTUERYLUxpY2Vuc2UtSWRl
bnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgorLyoKKyAqIENvcHlyaWdodCAoYykgMjAyNSBTVVNF
IExMQyBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgorICovCisKKy8qXAorICog
VmVyaWZ5IHRoYXQgbXVubWFwKCkgZmFpbHMgd2l0aCBFTk9NRU0gYWZ0ZXIgcGFydGlhbGx5IHVu
bWFwcGluZyBhbgorICogZXhpc3RpbmcgbWFwLCB3aGlsZSBoYXZpbmcgdGhlIG1heGltdW0gYW1v
dW50IG9mIG1hcHMgYWxyZWFkeSBhbGxvY2F0ZWQuCisgKi8KKworI2luY2x1ZGUgInRzdF90ZXN0
LmgiCisjaW5jbHVkZSAibGFwaS9tbWFwLmgiCisKKyNkZWZpbmUgUEFEIDIgLyogYXZvaWQgYWRq
YWNlbnQgbWFwcGluZyBtZXJnZXMgKi8KKyNkZWZpbmUgUEFHRVMgMworI2RlZmluZSBNQVhfTUFQ
X0NPVU5UX0ZJTEUgIi9wcm9jL3N5cy92bS9tYXhfbWFwX2NvdW50IgorCitzdGF0aWMgY2hhciAq
c3RyX21heF9tYXBfY291bnQ7CitzdGF0aWMgaW50IG1heF9tYXBfY291bnQgPSA1MDA7CisKK3N0
YXRpYyB1aW50cHRyX3QgYmFzZSA9IDB4MTAwMDAwMDAwVUw7CitzdGF0aWMgc2l6ZV90IHBhZ2Vf
c3o7CitzdGF0aWMgdW5zaWduZWQgbG9uZyB2bWFfc2l6ZTsKK3N0YXRpYyB1bnNpZ25lZCBsb25n
IG1heF9tYXBfY291bnRfb3JpZzsKK3N0YXRpYyBpbnQgbWFwX2NvdW50Oworc3RhdGljIHZvaWQg
KiptYXBzOworCitzdGF0aWMgdm9pZCBydW4odm9pZCkKK3sKKwlUU1RfRVhQX0ZBSUwobXVubWFw
KG1hcHNbMl0gKyBwYWdlX3N6LCBwYWdlX3N6KSwgRU5PTUVNKTsKK30KKworc3RhdGljIHZvaWQg
c2V0X21heF9tYXBfY291bnQoc2l6ZV90IG1heCkKK3sKKwl0c3RfcmVzKFRJTkZPLCAiU2V0dGlu
ZyBtYXhfbWFwX2NvdW50ID0gJXp1IiwgbWF4KTsKKwlTQUZFX0ZJTEVfUFJJTlRGKE1BWF9NQVBf
Q09VTlRfRklMRSwgIiV6dSIsIG1heCk7Cit9CisKK3N0YXRpYyB2b2lkIHNldHVwKHZvaWQpCit7
CisJcGFnZV9zeiA9IFNBRkVfU1lTQ09ORihfU0NfUEFHRVNJWkUpOworCXZtYV9zaXplID0gUEFH
RVMgKiBwYWdlX3N6OworCisJaWYgKHRzdF9wYXJzZV9pbnQoc3RyX21heF9tYXBfY291bnQsICZt
YXhfbWFwX2NvdW50LCAxMDAsIElOVF9NQVgpKQorCQl0c3RfYnJrKFRCUk9LLCAiSW52YWxpZCBt
YXguIG1hcCBjb3VudCAnJXMnIiwKKwkJCXN0cl9tYXhfbWFwX2NvdW50KTsKKworCVNBRkVfRklM
RV9TQ0FORihNQVhfTUFQX0NPVU5UX0ZJTEUsICIlbHUiLCAmbWF4X21hcF9jb3VudF9vcmlnKTsK
Kwl0c3RfcmVzKFRJTkZPLCAiT3JpZ2luYWwgbWF4X21hcF9jb3VudCA9ICVsdSIsIG1heF9tYXBf
Y291bnRfb3JpZyk7CisJc2V0X21heF9tYXBfY291bnQobWF4X21hcF9jb3VudCk7CisKKwltYXBz
ID0gU0FGRV9NQUxMT0MobWF4X21hcF9jb3VudCAqIHNpemVvZihjaGFyICopKTsKKwlmb3IgKGlu
dCBpID0gMDsgaSA8IG1heF9tYXBfY291bnQ7IGkrKykKKwkJbWFwc1tpXSA9IE5VTEw7CisKKwl3
aGlsZSAoMSkgeworCQl2b2lkICpwID0KKwkJCW1tYXAoKHZvaWQgKikoYmFzZSArIFBBRCAqIHZt
YV9zaXplICogbWFwX2NvdW50KSwKKwkJCSAgICAgdm1hX3NpemUsIFBST1RfTk9ORSwKKwkJCSAg
ICAgTUFQX1BSSVZBVEUgfCBNQVBfQU5PTllNT1VTIHwgTUFQX0ZJWEVEX05PUkVQTEFDRSwKKwkJ
CSAgICAgLTEsIDApOworCQlpZiAocCA9PSBNQVBfRkFJTEVEKQorCQkJYnJlYWs7CisJCW1hcHNb
bWFwX2NvdW50KytdID0gcDsKKwl9CisKKwlpZiAobWFwX2NvdW50ID09IG1heF9tYXBfY291bnQp
CisJCXRzdF9icmsoVEJST0ssICJNYXBwZWQgYWxsICVkIHJlZ2lvbnMsIGV4cGVjdGVkIGxlc3Mi
LAorCQkJbWFwX2NvdW50KTsKKworCXRzdF9yZXMoVElORk8sICJNYXBwZWQgJWQgcmVnaW9ucyIs
IG1hcF9jb3VudCk7Cit9CisKK3N0YXRpYyB2b2lkIGNsZWFudXAodm9pZCkKK3sKKwlzZXRfbWF4
X21hcF9jb3VudChtYXhfbWFwX2NvdW50X29yaWcpOworCWZvciAoaW50IGkgPSAwOyBpIDwgbWFw
X2NvdW50OyBpKyspIHsKKwkJaWYgKG1hcHNbaV0gPT0gTlVMTCkKKwkJCWJyZWFrOworCQlTQUZF
X01VTk1BUCgodm9pZCAqKShtYXBzW2ldKSwgdm1hX3NpemUpOworCX0KKwlmcmVlKG1hcHMpOwor
fQorCitzdGF0aWMgc3RydWN0IHRzdF90ZXN0IHRlc3QgPSB7CisJLnRlc3RfYWxsID0gcnVuLAor
CS5zZXR1cCA9IHNldHVwLAorCS5jbGVhbnVwID0gY2xlYW51cCwKKwkubmVlZHNfcm9vdCA9IDEs
CisJLm1pbl9rdmVyID0gIjQuMTciLAorCS5vcHRpb25zID0gKHN0cnVjdCB0c3Rfb3B0aW9uW10p
eyB7ICJuOiIsICZzdHJfbWF4X21hcF9jb3VudCwKKwkJCQkJICAgICJNYXguIG1hcCBjb3VudCAo
ZGVmYXVsdDogNTAwKSIgfSwKKwkJCQkJICB7fSB9LAorfTsKCi0tLQpiYXNlLWNvbW1pdDogZjZi
NzZmZTM3M2QxOTMyY2UxZDIyNDhlODNmZjI4NDA4NTE0NTc5NwpjaGFuZ2UtaWQ6IDIwMjUwNzA0
LW5ldy1tdW5tYXAwNC1hNTljYTIwYWUwMGMKCkJlc3QgcmVnYXJkcywKLS0gClJpY2FyZG8gQi4g
TWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+CgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczov
L2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
