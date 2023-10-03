Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 583E1E75428
	for <ltp@archiver.kernel.org>; Tue,  3 Oct 2023 05:48:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D03E3CC575
	for <ltp@archiver.kernel.org>; Tue,  3 Oct 2023 07:48:35 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9251B3CC01F
 for <ltp@lists.linux.it>; Tue,  3 Oct 2023 07:48:23 +0200 (CEST)
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com
 [IPv6:2607:f8b0:4864:20::e2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3731C10007D8
 for <ltp@lists.linux.it>; Tue,  3 Oct 2023 07:48:23 +0200 (CEST)
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-4547428694dso263996137.3
 for <ltp@lists.linux.it>; Mon, 02 Oct 2023 22:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696312102; x=1696916902; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z9I6c5Iwr/ba0wcKssKanfPKS8G9JmXveu7lH25s+r4=;
 b=DYMPZsexv0K5OqnGvROaNVWDj9oFOWCtxjZboWH1fxMjKq3g9VVfsieORNAGVvzQX5
 hy4inGRI4hjIn4+VP+n0G5yTDieN2X0AyQqbCKN6NMCj+cd+M7pufzECE3G2YFHKjnwP
 TTSj9qnqfGR7iK0djcPux0cdHGKtd2H0dYJbqalQp28FEY/o+bH+FIom86OKaW4jKUPe
 zEws9XN5iPkyAuTP7p4B5ir2nIx8MUbTy2rVUnojixlMmQHRhkLcL7tmQLMcusRop39E
 KPpt0e1Wb5h9fDgF3/KfjfFS0iNNz9DwDXok0oDZqD8yLvE0QJGY8vKs4qycbiLk4xVw
 9ZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696312102; x=1696916902;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z9I6c5Iwr/ba0wcKssKanfPKS8G9JmXveu7lH25s+r4=;
 b=lszWLOhNiMPG3BGVh6nzlvatWp3ESUvb/pf4pBaFFTqEX2lHef1sRgyEVjEc4a4Kxc
 V53p+DB1rJjYkNkfu7+yJEn6Rnq8PCy0WdrTpesvGhFEOsB1ovLizPu4x8beJ0sgCheA
 6nUTf0ChUxjLf6f9ccOacuMfCmfPvMqpAbJMvRls5+9ihVqkzQFlwONm8qATFYetC3xi
 pZ4IooZBQV/spUn9Wy8BdwDuCZMDcAg4Z/eeZgD8LcflAoIs/iqHIdo5egRYh02BKt/P
 QzEpbV45jRdpDRt7+/iEiCfArt80JHFPQDqLNLiY3kAINcmsVgcrQ28llxt2kmkj+cCP
 ObfQ==
X-Gm-Message-State: AOJu0Yyq7XrDI8V3c9K45oiEWFS4AKPQMvbcpsD6qRpyj8xFsk4cln34
 Y1OxFsSPDtXLnCqyKigB9uMpd69K7Z5nDjS7KRw=
X-Google-Smtp-Source: AGHT+IE/TD/7gci8Ynz+vg+opW2HyHCnA+bveARviO4k4TBQ1IQj0346GBakn5zu3Yf6vdufRdiE1l1vlq4VW0iSlsI=
X-Received: by 2002:a05:6102:104:b0:452:88da:2e1f with SMTP id
 z4-20020a056102010400b0045288da2e1fmr11572759vsq.21.1696312101940; Mon, 02
 Oct 2023 22:48:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231003015704.2415-1-reubenhwk@gmail.com>
In-Reply-To: <20231003015704.2415-1-reubenhwk@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 3 Oct 2023 08:48:10 +0300
Message-ID: <CAOQ4uxi04iyf-9tnQ3vREvBwMPK-MaDVWi0KcqTNufodsxDFZg@mail.gmail.com>
To: Reuben Hawkins <reubenhwk@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] vfs: fix readahead(2) on block devices
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
Cc: mszeredi@redhat.com, brauner@kernel.org, lkp@intel.com, willy@infradead.org,
 oe-lkp@lists.linux.dev, oliver.sang@intel.com, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBPY3QgMywgMjAyMyBhdCA0OjU34oCvQU0gUmV1YmVuIEhhd2tpbnMgPHJldWJlbmh3
a0BnbWFpbC5jb20+IHdyb3RlOgo+Cj4gUmVhZGFoZWFkIHdhcyBmYWN0b3JlZCB0byBjYWxsIGdl
bmVyaWNfZmFkdmlzZS4gIFRoYXQgcmVmYWN0b3IgYWRkZWQgYW4KPiBTX0lTUkVHIHJlc3RyaWN0
aW9uIHdoaWNoIGJyb2tlIHJlYWRhaGVhZCBvbiBibG9jayBkZXZpY2VzLgo+Cj4gSW4gYWRkaXRp
b24gdG8gU19JU1JFRywgdGhpcyBjaGFuZ2UgY2hlY2tzIFNfSVNCTEsgdG8gZml4IGJsb2NrIGRl
dmljZQo+IHJlYWRhaGVhZC4gIFRoZXJlIGlzIG5vIGNoYW5nZSBpbiBiZWhhdmlvciB3aXRoIGFu
eSBmaWxlIHR5cGUgYmVzaWRlcyBibG9jawo+IGRldmljZXMgaW4gdGhpcyBjaGFuZ2UuCj4KPiBG
aXhlczogM2Q4Zjc2MTUzMTliICgidmZzOiBpbXBsZW1lbnQgcmVhZGFoZWFkKDIpIHVzaW5nIFBP
U0lYX0ZBRFZfV0lMTE5FRUQiKQo+IFNpZ25lZC1vZmYtYnk6IFJldWJlbiBIYXdraW5zIDxyZXVi
ZW5od2tAZ21haWwuY29tPgoKUmV2aWV3ZWQtYnk6IEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBn
bWFpbC5jb20+CgpDaHJpc3RpYW4sCgpXZSd2ZSBoYWQgYSBsb3Qgb2YgYmFjayBhbmQgZm9ydGgg
b24gdGhpcyBwYXRjaC4KSSd2ZSBhc2tlZCBSZXViZW4gdG8gcG9zdCB0aGlzIG1pbmltYWwgYW5k
IGJhY2twb3J0YWJsZSBwYXRjaAp3aGljaCBzaG91bGQgcmVwbGFjZSB0aGUgb25lIHRoYXQgaXMg
Y3VycmVudGx5IG9uIHRoZSBoZWFkIG9mCnZmcy5taXNjIGluIG9yZGVyIHRvIG9ubHkgZml4IHRo
ZSByZWdyZXNzaW9uIHdpdGhvdXQgb3RoZXIgY2hhbmdlcwpvZiBiZWhhdmlvci4KCklmIHlvdSBo
YXBwZW4gdG8gc2VuZCBhbnkgdmZzIGZpeGVzIHRvIDYuNiwgdGhpcyBvbmUgY2FuIGFsc28KYmUg
aW5jbHVkZWQgYnV0IG5vIG5lZWQgdG8gcnVzaC4KCkl0IHdvdWxkIGJlIHdyb25nIHRvIG1peCB0
aGUgcmVncmVzc2lvbiBmaXggd2l0aCBvdGhlciBjaGFuZ2VzIG9mCmJlaGF2aW9yIGJlY2F1c2Ug
dGhlIGxhdHRlciB3ZSBtYXkgYmUgIGZvcmNlZCB0byByZXZlcnQgaW4gdGhlIGZ1dHVyZS4KCkVp
dGhlciBSZXViZW4gb3IgSSB3aWxsIGZvbGxvdyB1cCBsYXRlciB3aXRoIHBhdGNoZXMgdG8gY2hh
bmdlIHRoZQpiZWhhdmlvciBvZiBwb3NpeF9mYWR2aXNlIGFuZCByZWFkYWhlYWQoMikgZm9yIHBp
cGVzIGFuZCBzb2NrZXRzCmFzIHN1Z2dlc3RlZCBieSBNYXR0aGV3LgoKVGhhbmtzLApBbWlyLgoK
PiAtLS0KPiAgbW0vcmVhZGFoZWFkLmMgfCAzICsrLQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvbW0vcmVhZGFoZWFkLmMg
Yi9tbS9yZWFkYWhlYWQuYwo+IGluZGV4IGU4MTVjMTE0ZGUyMS4uNjkyNWU2OTU5ZmQzIDEwMDY0
NAo+IC0tLSBhL21tL3JlYWRhaGVhZC5jCj4gKysrIGIvbW0vcmVhZGFoZWFkLmMKPiBAQCAtNzM1
LDcgKzczNSw4IEBAIHNzaXplX3Qga3N5c19yZWFkYWhlYWQoaW50IGZkLCBsb2ZmX3Qgb2Zmc2V0
LCBzaXplX3QgY291bnQpCj4gICAgICAgICAgKi8KPiAgICAgICAgIHJldCA9IC1FSU5WQUw7Cj4g
ICAgICAgICBpZiAoIWYuZmlsZS0+Zl9tYXBwaW5nIHx8ICFmLmZpbGUtPmZfbWFwcGluZy0+YV9v
cHMgfHwKPiAtICAgICAgICAgICAhU19JU1JFRyhmaWxlX2lub2RlKGYuZmlsZSktPmlfbW9kZSkp
Cj4gKyAgICAgICAgICAgKCFTX0lTUkVHKGZpbGVfaW5vZGUoZi5maWxlKS0+aV9tb2RlKSAmJgo+
ICsgICAgICAgICAgICFTX0lTQkxLKGZpbGVfaW5vZGUoZi5maWxlKS0+aV9tb2RlKSkpCj4gICAg
ICAgICAgICAgICAgIGdvdG8gb3V0Owo+Cj4gICAgICAgICByZXQgPSB2ZnNfZmFkdmlzZShmLmZp
bGUsIG9mZnNldCwgY291bnQsIFBPU0lYX0ZBRFZfV0lMTE5FRUQpOwo+IC0tCj4gMi4zNC4xCj4K
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
