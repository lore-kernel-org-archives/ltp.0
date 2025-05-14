Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D55C4C3ABCC
	for <ltp@archiver.kernel.org>; Wed, 14 May 2025 10:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747219984; h=date :
 mime-version : message-id : references : in-reply-to : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=6+henXlMuVDh+tmmXmakmRNipsfe+zcm1NjlKH014lM=;
 b=jhc6kc2Atgp+btnHxsJNLT/exOCWanz11z6I7gIxYjrOAbdRNHB/3RqbsQe+tUgXoJAqJ
 3946ldaZErYZv8IfR24e0qBcPChzNh2+dciDwhAcLIUJ5G7QGjoHTsP6HnbUiTo5AVPt2hK
 Xcsf5g5byX/umbr4LIm4eh0ettSUbtE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 66F853CC3B7
	for <ltp@archiver.kernel.org>; Wed, 14 May 2025 12:53:04 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 629A53C1D15
 for <ltp@lists.linux.it>; Wed, 14 May 2025 12:50:24 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3A7FF1000BF6
 for <ltp@lists.linux.it>; Wed, 14 May 2025 12:50:24 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a0b7fbdde7so6503547f8f.2
 for <ltp@lists.linux.it>; Wed, 14 May 2025 03:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1747219823; x=1747824623; darn=lists.linux.it;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=u+YEn1flBaKnKIzKm4S1q2TPMLrARYAlaIQNFhJLhwA=;
 b=Ske68A4YRCWanHiFFUbP1ihvPd2n8XMR0Zyh0lqjt2htTd6AyhyjfASNqyigOayBzB
 a0eL583N1TmnYncKhS5sPZqKLfEulLX0yvcwAREOLI71yFugF0tg0NRDTTBQNINuMOpQ
 JwILwtHrtziLs01dT8OP9LoAS/G4PMLo7hDBmGZxE3rFiclGGLrw4UQD8qnDrA1qdD1g
 GsJyW9bOrCLzTbJZ0wAZZSj5/9l7Ao6oWxIqxTy3YUmx6K2sPgewF6Ctuc+PsPpuUWri
 oL6z+5za7xEp0GrsjxRHv80mlm5a1AxrSl7VTEt5IEXIeHaajHY41/ph7cl4bdhulfLm
 7PNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747219823; x=1747824623;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u+YEn1flBaKnKIzKm4S1q2TPMLrARYAlaIQNFhJLhwA=;
 b=D5ejhYNK1jBco9qF/KIHwEx0uH+0OpbFxY+LkC21XtIGmL0P3kfQt9DIexwYnUR03k
 0IYtiGn7MhkZRchSkwOm2mym4/9N31BirZVwx1XlRu3f2PPrfvGi2q0BOl9d+/joSN27
 gmKTqH5fm6jIa0V7b3N4bF+Tj8KxiUAWZkXWbU4fQE+zFXOjZBmHxAHKpCmci7c3gPm+
 cqNY8jjswI7Ve+IuNC4xLqDnA1ysa7NMo78L2HdwvSUrc5de370TlE6hF1FXTwPTJ6n9
 J9+UnPFAtBKK3o/RVFdKszcGxy9DXFIm2igWMsxGgaas1pcUY4a2suI1aO5wIZYnqnPH
 5aVw==
X-Gm-Message-State: AOJu0Yx0KUKNVQJAD4Dsy0M4UU0Zr1xAVuRQHEu/ViWbtlokARryCI7z
 iT+ae6x3kgjJs8APIu0LgZnrOin7iZikekRA3adlI7mZkHaQoirFSJZaaOkyiG+wAn2preyF1AS
 D
X-Gm-Gg: ASbGncuxHY8RREiLq72N9lQFkbOq3pm3gvPO7YMP05iI5dnXl7K5UgrQBsry5f3xSeX
 Ic29vFiQdh8ja6/hxSP+QsBY4jX0Mpy5HV8ypwKPiEp8njZDxnO3VcqzNHhbYyGIvK+ABVnh30S
 Rf+Mo8hnbg7W8woW5HqJXUTE4Q50CNUd+nRAUHBzvvYk5okejJgJRD7NFyTEWgwR++4siGWSLdR
 iS5vJOyEPjkSwazSEX7rMAeCOVeQOfiGu55N2HP9cZtFUUaMa3DOa10UVw4mftLFU/X8ZbvG4YU
 eSYV/nOqVbYGuT6hGyGi4IHnP+J8EPmarWKd9Tc=
X-Google-Smtp-Source: AGHT+IGN0lmeLg2RESpMMUkelScdrEVrumtp63MYucFd8LQ1fs480ULhmNj2aIFErevgeZONKB/iaw==
X-Received: by 2002:a5d:5848:0:b0:3a0:90c3:dd90 with SMTP id
 ffacd0b85a97d-3a34969307cmr2526801f8f.11.1747219823404; 
 Wed, 14 May 2025 03:50:23 -0700 (PDT)
Received: from localhost ([177.45.162.169])
 by smtp.gmail.com with UTF8SMTPSA id
 71dfb90a1353d-52c67dd1aa9sm6829873e0c.4.2025.05.14.03.50.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 03:50:23 -0700 (PDT)
Date: Wed, 14 May 2025 07:49:59 -0300
MIME-Version: 1.0
Message-Id: <20250514-conversions-kill-v1-6-cd633e941e8b@suse.com>
References: <20250514-conversions-kill-v1-0-cd633e941e8b@suse.com>
In-Reply-To: <20250514-conversions-kill-v1-0-cd633e941e8b@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2080; i=rbm@suse.com;
 h=from:subject:message-id; bh=uE9Y2JXkivBFBOc8LBBcbOFg0+aSbnp8PZSNoGOPBRg=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBoJHVaCAbjesW0xb8OXCbLAV68Az5CR4PCQ4LBB
 C/uY3A0xUKJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaCR1WgAKCRDJC4p8Y4ZY
 pqk9D/47WzzhJYKaWQ1+QnXGuUAhN5/Xoaf3G2xHhogwVgaZ6vcx5M/GjFkvTTVeHYliBPcutIL
 cc2iHeJPWuzp6ZWIgv2N11cW8lZyc5a+JZ8URkdcd1aN2wfjVfXrkFpLmzG7nkPRDEyAgnRxSiS
 ThR7tJLMgufXdfoEu64U2luZqGhZBJkiikQfhwbs4Ld2Qoz1oTTegRgpgOTWDAmPSFtNoLlqkTB
 +txEWKwV1oBVZhsIR4svKQ7c1yWsFexcRQEGd01kSJPQJbi2ppi1rlokUpabOPVHtB1oofAj+Gh
 0RRadWiv+vRot+vdLFIH8pPUOadGqoycIlvnOY0ZkWVCCELWsxrvZCOskp+LrFjELTcVZIwKy4D
 olXYy3MCdrhCdsQDroUa21WT7foWywU+43zQv+hJkoPpJUBOpLnZFu6S8/RX24w4NonhK627lXf
 izJvQI7qEZFc/C9cAKuqPiMbOFPdhMYHOSG3Q1RTnkn3pssg1B0MZbil0y0OlobyBUWL0PEtSDw
 pg0CrFfKQjeaC33/9pY4gDbhYKJMADA4ejTBcgd5D8WmFZd1X4G4KyMJw5RKagVW69NWQwWKVs9
 3F6oG7OIfAJrKL29imDTKVyngKv05SLjPTCcew8yGC4NqD83uVjXX1ORxpnL4r0Ms7thRiZ9g/F
 CpmZld7AZcineUQ==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 6/6] syscalls: Remove kill09
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

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KClRoaXMgdGVzdCBjYXNl
IGlzIGFscmVhZHkgY292ZXJlZCBieSBraWxsMTEuCgpTaWduZWQtb2ZmLWJ5OiBSaWNhcmRvIEIu
IE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgotLS0KIHJ1bnRlc3Qvc3lzY2FsbHMgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgIDEgLQogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9raWxsLy5n
aXRpZ25vcmUgfCAgMSAtCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2tpbGwva2lsbDA5LmMg
ICB8IDM2IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIDMgZmlsZXMgY2hhbmdlZCwg
MzggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvcnVudGVzdC9zeXNjYWxscyBiL3J1bnRlc3Qv
c3lzY2FsbHMKaW5kZXggYTdhZDg4MzdmZGFkODA1NDdkZDg1NTI3YmM4ZTUwYmRmMzgxZjZlMC4u
ZTdiYzdiMjdiNjA0ZTBmMGY2OWI2YmFkOTk5NTU2NjJjNmM1OGE5MSAxMDA2NDQKLS0tIGEvcnVu
dGVzdC9zeXNjYWxscworKysgYi9ydW50ZXN0L3N5c2NhbGxzCkBAIC02OTksNyArNjk5LDYgQEAg
a2lsbDA1IGtpbGwwNQoga2lsbDA2IGtpbGwwNgoga2lsbDA3IGtpbGwwNwoga2lsbDA4IGtpbGww
OAota2lsbDA5IGtpbGwwOQoga2lsbDEwIGtpbGwxMAoga2lsbDExIGtpbGwxMQoga2lsbDEyIGtp
bGwxMgpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9raWxsLy5naXRpZ25v
cmUgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2tpbGwvLmdpdGlnbm9yZQppbmRleCA4MTBl
ZDAyMDAwNzJkYmE3Nzg0YTAwMjBmOTExMzUyMzVhN2YyOTFmLi44MTg4YWExMDgzZDkyZTI1ZTY1
NGI5YWYzMmMxNWE0YWNiYjZhYjNkIDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL2tpbGwvLmdpdGlnbm9yZQorKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2tpbGwv
LmdpdGlnbm9yZQpAQCAtNCw3ICs0LDYgQEAKIC9raWxsMDYKIC9raWxsMDcKIC9raWxsMDgKLS9r
aWxsMDkKIC9raWxsMTAKIC9raWxsMTEKIC9raWxsMTIKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMva2lsbC9raWxsMDkuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
a2lsbC9raWxsMDkuYwpkZWxldGVkIGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggYmExMmU0NjhkZTBi
OTE4ZjU0NzA3MzgwMTlhZGMzNzgwNzZjZjI5My4uMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2tpbGwva2lsbDA5
LmMKKysrIC9kZXYvbnVsbApAQCAtMSwzNiArMCwwIEBACi0vLyBTUERYLUxpY2Vuc2UtSWRlbnRp
ZmllcjogR1BMLTIuMC1vci1sYXRlcgotLyoKLSAqIENvcHlyaWdodCAoYykgMjAwMCBTaWxpY29u
IEdyYXBoaWNzLCBJbmMuICBBbGwgUmlnaHRzIFJlc2VydmVkLgotICovCi0KLS8qXAotICogVmVy
aWZ5IHRoYXQga2lsbCgyKSB3b3JrcyB3aGVuIHNlbmRpbmcgU0lHS0lMTCB0byBhIGNoaWxkIHBy
b2Nlc3MuCi0gKi8KLQotI2luY2x1ZGUgPHNpZ25hbC5oPgotI2luY2x1ZGUgPHN5cy90eXBlcy5o
PgotI2luY2x1ZGUgPHN5cy93YWl0Lmg+Ci0KLSNpbmNsdWRlICJ0c3RfdGVzdC5oIgotCi1zdGF0
aWMgdm9pZCBydW4odm9pZCkKLXsKLQlpbnQgc3RhdHVzOwotCXBpZF90IHBpZDsKLQotCXBpZCA9
IFNBRkVfRk9SSygpOwotCWlmICghcGlkKQotCQlwYXVzZSgpOwotCi0JVEVTVChraWxsKHBpZCwg
U0lHS0lMTCkpOwotCWlmIChUU1RfUkVUID09IC0xKQotCQl0c3RfcmVzKFRGQUlMIHwgVFRFUlJO
TywgImtpbGwoLi4sIFNJR0tJTEwpIGZhaWxlZCIpOwotCWVsc2UKLQkJdHN0X3JlcyhUUEFTUywg
ImtpbGwoJWQsIFNJR0tJTEwpIHJldHVybmVkICVsZCIsIHBpZCwgVFNUX1JFVCk7Ci0JU0FGRV9X
QUlUKCZzdGF0dXMpOwotfQotCi1zdGF0aWMgc3RydWN0IHRzdF90ZXN0IHRlc3QgPSB7Ci0JLnRl
c3RfYWxsID0gcnVuLAotCS5mb3Jrc19jaGlsZCA9IDEsCi19OwoKLS0gCjIuNDkuMAoKCi0tIApN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
