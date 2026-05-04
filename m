Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 716D6FF885A
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 09:28:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E68B43E2C80
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 11:28:27 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6FBEA3E1A82
 for <ltp@lists.linux.it>; Mon,  4 May 2026 11:28:10 +0200 (CEST)
Received: from mail-dy1-x1342.google.com (mail-dy1-x1342.google.com
 [IPv6:2607:f8b0:4864:20::1342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1D3031A00606
 for <ltp@lists.linux.it>; Mon,  4 May 2026 11:28:09 +0200 (CEST)
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-2ecf9e398f4so8786647eec.1
 for <ltp@lists.linux.it>; Mon, 04 May 2026 02:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777886887; x=1778491687; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3aJoJjlj0Et1HWr527QkpKBNaAa2uKrGT4FK/KVwo7w=;
 b=cfSl6ZXmVievXYQKlKFrsavlIUwwsLNDIJXKPz9imWU90Llv2vfKjoKNODvcLzm6UW
 LS8b1J4MY36APmiij4nOha/NEWJUSM+t6dwVFDEw6851B5WaQJoOJa+yfZV8qVK8cEHQ
 vpYfzT7FW8gPsc6qljkxgtuociAnjFoErTWY9ytBqn5AXjFCfesTyBIipgmrGjqat6a5
 cdKx6UcMSa8m2rAP/AsqiepWPDoLjsit8YqQZJ7A1PYq80QcBvFVrSurBZk3n3K4R7Z7
 m8tN+JhmB2bAq7hSFYVCFM08+SIk9w1MrS2FVdAFlOLO/tylyMI/4Mq/8tnCtmWIKsc9
 jx7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777886887; x=1778491687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3aJoJjlj0Et1HWr527QkpKBNaAa2uKrGT4FK/KVwo7w=;
 b=BiCUIlDPD7zKhSv/dcNre7QPieiKYHiAFUHMjSnP2mYHEekgdvSReyWDDm9e9OQNzX
 Ly3TlJn4Ai56u0czBQN5inpbq4CIsOt7GS8BqD6LPMjZbzspjLT/088Mwxzqyk2PjS5B
 C9gUzOME4yR7PGScA/72XznsapMLsT880nR6WEaqjUIoYX3epS4sqaU1bFsfzXw6zqHN
 rARAXkSgnyXcqzubDhSF0BUlf4mGVZp6h2BV1RBxylX6aaHqaS+hV/TiwjaDQmBsV6Z3
 8i1FXTHq7FXT+ytBgLEdoj9T6ipMDosqcFpVAW+qrICGsNQDudMiUYgz/zmGfJZAH1Pq
 rWAA==
X-Gm-Message-State: AOJu0Yy+5YGAVzpeiWQKiLwCGtcXkG2ejxZ7ZW1UMPKZj+9WrhhLEtwi
 ChP27OLzrhiVJX3DMniztZ43Ycx3urr/93f5S3sSMlKsOjzvEjauz1oM1o76zJDNnbc=
X-Gm-Gg: AeBDiesjPPyqqUS7FIKgi2YyZyu2Z5OUFxODspDQrn4gDkg/smv/m3unPin40qfHNMI
 7iFNJ2MKPaFTGFXxa+nVGlnn2qbdIempujk+w9U5Z4cmSG8rRcvfWSXFvEN0/z+mA0fkwBfUwYE
 9x9Z2zkPxa4HYt3XVjw7SExrW4dzkRDNJ5UYAywF80vn0nw8J+9FpDcggs4TS3KNgRaKtFmbp3R
 FU/czCD3MVvkoUxaQucMsQh8OcMxrqTAG3isMOCVd5kMwOw6gjHCOeB7GrJwi+I9C3ne9/rRe4J
 cFGXrC26qdrjsu57b7GhwBg6UqfMGQzuydhslnVlkNUhoqys+3FO7otNOcpzlJo/EMInFAD8vI0
 ExNT89w3GIPqGiTVcxo4wGEmKdzuxv90BxKS2q4r0DuTx88k8YjECChz4CLSdmJG8Rpux6drdzn
 z48JWhrUBlPL2gIGw8n9g5SSre8nq2z2+gSV9SYtCex+Ml4SwvNG9no7ZAEV7GDRfVKkcnubP9u
 MAKdxOMY319NP/tw/5ZJ1JSf2TvVd1G9G/UKIWb5P0T6DvsSzo=
X-Received: by 2002:a05:7300:7490:b0:2ea:5057:a304 with SMTP id
 5a478bee46e88-2efb7ad84f4mr3433318eec.2.1777886887352; 
 Mon, 04 May 2026 02:28:07 -0700 (PDT)
Received: from
 runnervmeorf1.c5dam0qjnfsefkc3bjzldlum2d.dx.internal.cloudapp.net
 ([52.159.247.179]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f194556795sm5074862eec.2.2026.05.04.02.28.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 02:28:07 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon,  4 May 2026 09:28:05 +0000
Message-ID: <20260504092805.4070-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504-safe_splice-v2-1-aa7eaa6b5ed7@suse.com>
References: <20260504-safe_splice-v2-1-aa7eaa6b5ed7@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: Add SAFE_SPLICE() macro
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQW5kcmVhLAoKLS0tIFtQQVRDSCAxLzJdIC0tLQoKT24gTW9uLCA0IE1heSAyMDI2LCBBbmRy
ZWEgQ2VydmVzYXRvIHdyb3RlOgo+IGxpYjogQWRkIFNBRkVfU1BMSUNFKCkgbWFjcm8KPgo+IEFk
ZCBuZXcgU0FGRV9TUExJVCgpIGluIGxhcGkvc3BsaWNlLmguCgoiU0FGRV9TUExJVCgpIiAtPiAi
U0FGRV9TUExJQ0UoKSIuCgo+IC0jaW5jbHVkZSAibGFwaS9zcGxpY2UuaCIKPiAuLi4KPiArCVNB
RkVfU1BMSUNFKGZpbGVfZmQsICZvZmZfaW4sIHBpcGVmZFsxXSwgTlVMTCwgT1ZFUldSSVRFX1NJ
WkUsIDApOwoKQWZ0ZXIgdGhpcyBjb21taXQsIFNBRkVfU1BMSUNFKCkgaXMgY2FsbGVkIGluIGFm
X2FsZzA4LmMsIHRlZTAxLmMsIGFuZAp2bXNwbGljZTAxLmMgYnV0IGFsbCB0aHJlZSBubyBsb25n
ZXIgaW5jbHVkZSA8bGFwaS9zcGxpY2UuaD4g4oCUIHRoZSB0cmVlCmRvZXMgbm90IGNvbXBpbGUu
IFRoZSBpbmNsdWRlIHJlbW92YWwgYW5kIHRoZSBTQUZFX1NQTElDRSgpIGNvbnZlcnNpb24KbXVz
dCBub3QgYmUgc3BsaXQgYWNyb3NzIGNvbW1pdHMuCgpUaGlzIHBhdGNoIGFsc28gbWl4ZXMgImFk
ZCBsaWJyYXJ5IG1hY3JvIiB3aXRoICJjb252ZXJ0IHRlc3QgZmlsZXMiOwpzcGxpdCB0aGVtOiBw
YXRjaCAxIHRvdWNoZXMgb25seSBsYXBpL3NwbGljZS5oLCBwYXRjaCAyIGFkZHMgdGhlCmluY2x1
ZGUgYW5kIGNvbnZlcnRzIHRoZSBzcGxpY2UoKSBjYWxscyBpbiBhbGwgdGhyZWUgdGVzdCBmaWxl
cy4KCi0tLSBbUEFUQ0ggMi8yXSAtLS0KCk9uIE1vbiwgNCBNYXkgMjAyNiwgQW5kcmVhIENlcnZl
c2F0byB3cm90ZToKPiB0ZWUwMSwgdm1zcGxpY2UwMSwgYWZfYWxnMDg6IFVzZSBTQUZFX1NQTElD
RSgpCj4KPiBSZXBsYWNlIHJhdyBzcGxpY2UoKSBjYWxscyB3aXRoIFNBRkVfU1BMSUNFKCkgaW4g
dGVzdHMgd2hlcmUgc3BsaWNlIGlzCj4gdXRpbGl0eSBwbHVtYmluZywgbm90IHRoZSBzdWJqZWN0
IG9mIHRlc3RpbmcuCgpUaGlzIHBhdGNoIG9ubHkgYWRkcyB0aHJlZSAiI2luY2x1ZGUgbGFwaS9z
cGxpY2UuaCIgbGluZXM7IHRoZSBhY3R1YWwKc3BsaWNlKCktdG8tU0FGRV9TUExJQ0UoKSBjb252
ZXJzaW9uIGlzIGluIHBhdGNoIDEvMi4gU3ViamVjdCBhbmQgYm9keQptdXN0IGRlc2NyaWJlIHdo
YXQgdGhpcyBwYXRjaCBhY3R1YWxseSBkb2VzLCBvciBiZXR0ZXI6IHJlc3RydWN0dXJlCnRoZSBz
ZXJpZXMgc28gdGhlIGNvbnZlcnNpb24gYW5kIGl0cyBpbmNsdWRlIGxpdmUgaW4gdGhlIHNhbWUg
Y29tbWl0LgoKLS0tCk5vdGU6CgpPdXIgYWdlbnQgY29tcGxldGVkIHRoZSByZXZpZXcgb2YgdGhl
IHBhdGNoLgoKVGhlIGFnZW50IGNhbiBzb21ldGltZXMgcHJvZHVjZSBmYWxzZSBwb3NpdGl2ZXMg
YWx0aG91Z2ggb2Z0ZW4gaXRzCmZpbmRpbmdzIGFyZSBnZW51aW5lLiBJZiB5b3UgZmluZCBpc3N1
ZXMgd2l0aCB0aGUgcmV2aWV3LCBwbGVhc2UKY29tbWVudCB0aGlzIGVtYWlsIG9yIGlnbm9yZSB0
aGUgc3VnZ2VzdGlvbnMuCgpSZWdhcmRzLApMVFAgQUkgUmV2aWV3ZXIKCi0tIApNYWlsaW5nIGxp
c3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
