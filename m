Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9748C021B2
	for <ltp@archiver.kernel.org>; Tue, 25 Feb 2025 16:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740499911; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=uO6ADVo0uFsdpP+Z/FkWoS4E/ymfhav8O1gmXH6tYHM=;
 b=SD0eHe5P4QcnN3LyGkUCBfuwPEVHxCk52DVeugJJykb3IMtxnWEmz9klJfk4PYRtDf+Gx
 JVQivpnsKlXTpsbkgdGDKJl39CpYpzDoLEtbSdxog/hk0Ci+6Cd1JgQ+p43cYQMaeGzuEbm
 d3iNsbxCbBB5AG5NrGMWkk1N+1u2KhE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E76623C9BF5
	for <ltp@archiver.kernel.org>; Tue, 25 Feb 2025 17:11:51 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 656C43C996D
 for <ltp@lists.linux.it>; Tue, 25 Feb 2025 17:11:30 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3046466D516
 for <ltp@lists.linux.it>; Tue, 25 Feb 2025 17:11:29 +0100 (CET)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aaec61d0f65so1155928966b.1
 for <ltp@lists.linux.it>; Tue, 25 Feb 2025 08:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1740499888; x=1741104688; darn=lists.linux.it;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=12KfRGK/oc+rb3igdviEwaAQIMGFaLhRkr8rR2aqLyU=;
 b=gO09ZELtxLga7N3vjMTuN0Hs/NKMN6dDB4bS989tYxLqDWXJ6Jb+2TeXkdGbYHDP8L
 2Kyji8NcU25Jb1S3u1+tZVMMTe9W6IknNIbU2sEZiXUdVsoBw2OiNC/wfch6UwmKuV6R
 hIuuxuQr/vwniFwEm7A68kXjcHNW/3jdf1EGNbF0K+hvIfWK1rO104BwkGuBQrYSSJS7
 GaQ0GV3VYq3K+rkWwfH+VdjKlZ1K6Zo7V/jnydvxSL8dgZHvO2lXEPxqv4F0TwXTMrng
 ccwgXo3yYCLKIkzXsQlCS5CM4FnSjYHdRaS/TEU9zGyLf7hU3jVD+C3nnYKg/J9fJ+d5
 ahUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740499888; x=1741104688;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=12KfRGK/oc+rb3igdviEwaAQIMGFaLhRkr8rR2aqLyU=;
 b=DW/H+omdCybllkdT7q/fCUrhCDCrgxj6QGmqwYeWAs1Tkuq72bvS9lapAPfJXtWCDJ
 jXneYFHHqoQhteiznE6HscuSQMu5zMj+3QyVMQUCt/AO49Au0IfkcYwNvqz5iVBf7xno
 ZWzFhCLgkCZPLn/k++Mqd2Ce87gWXrHqrv4/kdP4Yg27L0F0U3b2IW/g3TM5AMyWbZcd
 3g2wxVNS5gQqDF8Lx8UNcaJNbDbwh2ck21v/2+Ep08eBOi/UqWYbNM8yUVLqBKWxfSgP
 zkeLCgajkYw9Ow+sNLRBfMxt6Yiu+h6oJjtXMw+kLvdtaKKbbr+vymydZT5e+B/jdW4Z
 2ByA==
X-Gm-Message-State: AOJu0YwgKHx0AUBU3Au95m1b635bXx2c0UOiOx1k5KE6rdF3Sjr3bERk
 uDzYN9QJ903ZIkSJBnBkx2qi5F/d09YW02RjsWiox/JTwguOblLwRPfcoJNnRDCS/ryxEumE7hT
 M
X-Gm-Gg: ASbGncskxTDrrkdInA3QZTc5SdVUoQp7eqrVho0GDSnoGpglGy2cxZpAA4Ffm7pi5u7
 JM8i716Z0XrMGJPJNN0HqyZuYkyjtzaaO0Oq1cNso1M2BN8kgXSDm4FRhShxjmyCFL+DDdA6+0U
 9Oxgey7RKXif+4g00HuJ/wis15/2IdfdIWpkt5qUsUYjOGnty2mq0ur9CobvKDLTCs00tS60W8b
 nZ/g/xcWybsyCyPjZLRVYohjtyZZ0EhcuQJtBw5BE7IitECCD81DVg0rAvYD1Antt38wMVfI/WF
 gYj1Qfv0/2Kz+w4=
X-Google-Smtp-Source: AGHT+IHoCJxwHPx9d7RdXVMrMHJtnrwwrF5/gK/Ha7NFEjA5y5oTsoSp3ZqmKr9oq+uvWjTE6SOLpw==
X-Received: by 2002:a17:907:2d0f:b0:aae:fd36:f511 with SMTP id
 a640c23a62f3a-abed1067a35mr388854266b.47.1740499888394; 
 Tue, 25 Feb 2025 08:11:28 -0800 (PST)
Received: from localhost ([179.228.215.131])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-7347a6adac3sm1687670b3a.31.2025.02.25.08.11.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 08:11:27 -0800 (PST)
Date: Tue, 25 Feb 2025 13:11:25 -0300
MIME-Version: 1.0
Message-Id: <20250225-disable_virt_other_getrusage04-v2-1-71d91adee359@suse.com>
X-B4-Tracking: v=1; b=H4sIAKzrvWcC/42OWwqDMBBFtyL5borGB6Rf3UcRmcTRBFpTZmJoE
 ffe6Ar6eeBwz90EI3lkcSs2QZg8+7BkUJdCWAfLjNKPmYUqVVsq1cjRM5gnDslTHEJ0SMOMkVa
 GGctGWj0aBaCx01bkkTfh5D9n4NFnNsAoDcFi3TH7Ao5Ih+g8x0Df80iqDv3vZqpkJY01TV3Dp
 Lu6vfPKeLXhJfp9339Wnr2l5AAAAA==
X-Change-ID: 20250224-disable_virt_other_getrusage04-c9db2aa9e69c
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1496; i=rbm@suse.com;
 h=from:subject:message-id; bh=nYyBI3HjKQNw9uQhxxkOQ4ndHcsIgAbgMiyv3c9Ovio=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBnveus0IGdRzrsc21p/Wr/1bOs6x6gW2DXH34AO
 SrMqbU17zKJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ73rrAAKCRDJC4p8Y4ZY
 pvXiD/9Fxggtn4vGp8V032VkA+z0fl5ywGJivinx3pZOZOaSAwQK3MnWRviihhzUBPmWYhgu/Dm
 0Yel288FU4Dykwev7MvAE9DldywelJ1hpX6Y4+r2v0q4kHpMKqpNSKjdwefZbHPMYU404R0qZti
 V8Gpt1Sb5pnvHd2UoUC+DbEMUfilZfmXXzRluJjGfylIE2S2QkbzEPsspgXCRjeLbnz6zohF9RP
 AzTpIGDYc8Il1wS0N6vks9KO5eI4K5CJZWuMrgC7jYkHJYKy/68TycJQ8w/4sjnpRi813p1wg8v
 X3eHZ6TZJpj7TTlV2rmSk8Lr2Jb96VCnIxRbXyac1j15CfTFPxeRmRA3EQRsdD8DYjWZdqBeg7K
 m5CvWH2WvafinyxiQV5UeQFoHyxBIiuEZ+5pIbJZX1u18x3uf0um0/LMbj0uR/5Gpfqw4N6go8n
 W6tI9ADAh28+z4+kqtIbzDbetKXO8kxaswc73Uvv2xeudKN3dKb9xotfKFaQtbWxyzNSfIGVH6L
 +chGBmI69t+Yt6Evf33TtM51qRIo6Vv06b6A9YuJkc3ut8tKsWERlSfbUD2FuoxWEFguG2g6OoS
 4yUwdWRhsfDFNJdfJaReNFu61g9Gqw2QNMcahpoyhchpXcZQbYMSdRw5KnLVDRf3F30Yput0GmJ
 oL+MLL4cOe+fzug==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls/getrusage04: Disable for VIRT_ANY
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
bm93biB0byBiZSB1bnN0YWJsZSB1bmRlciBzb21lIHZpcnR1YWxpemVkIGVudmlyb25tZW50cywK
dGhlcmVmb3JlIG9ubHkgYWxsb3cgaXQgZm9yIHJlY29nbml6ZWQgb25lcy4KClN1Z2dlc3RlZC1i
eTogTWFydGluIERvdWNoYSA8bWRvdWNoYUBzdXNlLmN6PgpTaWduZWQtb2ZmLWJ5OiBSaWNhcmRv
IEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgotLS0KQ2hhbmdlcyBpbiB2MjoKLSBVc2UgVklS
VF9BTlkgaW5zdGVhZCBvZiBWSVJUX09USEVSIGZvciBmdXR1cmUgcHJvb2ZpbmcKLSBMaW5rIHRv
IHYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjUwMjI0LWRpc2FibGVfdmlydF9vdGhl
cl9nZXRydXNhZ2UwNC12MS0xLWJjYjQzM2FmOTYzNUBzdXNlLmNvbQotLS0KIHRlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvZ2V0cnVzYWdlL2dldHJ1c2FnZTA0LmMgfCA3ICsrKystLS0KIDEgZmls
ZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9nZXRydXNhZ2UvZ2V0cnVzYWdlMDQuYyBiL3Rlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0cnVzYWdlL2dldHJ1c2FnZTA0LmMKaW5kZXggYjAzYmM1
NDliZDgzNWIzM2FjYWEwMjY5MzcwNjI1NWU4OGNiZTRmOC4uOTgzZGIyNjQ5NjkwZTQzMThiNjJj
ZTMzNDAxOTIxMDJjYjFkYWNmNCAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9nZXRydXNhZ2UvZ2V0cnVzYWdlMDQuYworKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L2dldHJ1c2FnZS9nZXRydXNhZ2UwNC5jCkBAIC0xOTgsOSArMTk4LDEwIEBAIHN0YXRpYyB2b2lk
IHNldHVwKHZvaWQpCiB7CiAJdHN0X3NpZyhOT0ZPUkssIERFRl9IQU5ETEVSLCBjbGVhbnVwKTsK
IAotCWlmICh0c3RfaXNfdmlydChWSVJUX1hFTikgfHwgdHN0X2lzX3ZpcnQoVklSVF9LVk0pIHx8
IHRzdF9pc192aXJ0KFZJUlRfSFlQRVJWKSkKLQkJdHN0X2Jya20oVENPTkYsIE5VTEwsICJUaGlz
IHRlc3RjYXNlIGlzIG5vdCBzdXBwb3J0ZWQgb24gdGhpcyIKLQkJICAgICAgICAiIHZpcnR1YWwg
bWFjaGluZS4iKTsKKwlpZiAodHN0X2lzX3ZpcnQoVklSVF9BTlkpKQorCQl0c3RfYnJrbShUQ09O
RiwgTlVMTCwKKwkJCSAiVGhpcyB0ZXN0Y2FzZSBpcyBub3Qgc3VwcG9ydGVkIG9uIHRoaXMiCisJ
CQkgIiB2aXJ0dWFsIG1hY2hpbmUuIik7CiAKIAlCSUFTX01BWCA9IGd1ZXNzX3RpbWVyX3Jlc29s
dXRpb24oKTsKIAoKLS0tCmJhc2UtY29tbWl0OiBhMWFlYmZkNGQ5OWQ1ZGExMjgzNGRhZTUyMTU4
MTVmZjhkODI5OTVjCmNoYW5nZS1pZDogMjAyNTAyMjQtZGlzYWJsZV92aXJ0X290aGVyX2dldHJ1
c2FnZTA0LWM5ZGIyYWE5ZTY5YwoKQmVzdCByZWdhcmRzLAotLSAKUmljYXJkbyBCLiBNYXJsacOo
cmUgPHJibUBzdXNlLmNvbT4KCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCg==
