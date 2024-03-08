Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F11C54E4A
	for <ltp@archiver.kernel.org>; Fri,  8 Mar 2024 13:39:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9DC133D01BB
	for <ltp@archiver.kernel.org>; Fri,  8 Mar 2024 14:39:42 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 29F2E3C3320
 for <ltp@lists.linux.it>; Fri,  8 Mar 2024 14:39:26 +0100 (CET)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3D3936008C8
 for <ltp@lists.linux.it>; Fri,  8 Mar 2024 14:39:26 +0100 (CET)
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-42ee984152cso11921551cf.1
 for <ltp@lists.linux.it>; Fri, 08 Mar 2024 05:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709905165; x=1710509965; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IH0IvMnNTf78tNoeMiHngta9MG3X0L8EopHT61FbZuA=;
 b=flHUfWhuUwxQixwvUAnfcgyDAXf8DK5n5UFbPuJn1pUDJANm85tm3olj406XJj5lwa
 pXStq5m90/RLcdSEk5M9Bcus5X4+U3Deo6h8qRf90Koh86sY+bkUGq7XuXhLQ4ZJ/L0M
 mwdXgngbm4C+/ZVVgfyGTsgfr2S72WZIw18gCrY/X4SDcdxHPkOMMtkQc8AqAWEZUbPJ
 XIncmhMxcUUBjIVml7b4tA0MhUuYXocSE5xYvfpdz5Xvq4yEknivBoZ35QTVsCnaFs/4
 Kr8Vx4qmsVOmHn5xd/v/02b9pSn8XS2nJzwzYI97niDDi/0ZZ7+r3/fWrkQxs4zvMLzf
 3HQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709905165; x=1710509965;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IH0IvMnNTf78tNoeMiHngta9MG3X0L8EopHT61FbZuA=;
 b=UHBTa9Qu9AHlAfOXhA1HMpjRge5uboz8WqHuj+hsvLa/xdugbKs27S5UnevsrlJEkR
 vOVeuoK5++TNiilOOzuplQIxjs6IKlubLED2oPLEp2oNx30CM7uKK5/+lJk7E3a8Xa6l
 +VIJ9H4e6aldW0v+GczR6Vs77OBTyK7FOk1R9kNp0g57FZzMEPRjsDze/P3+FxSNszMH
 GbDPJG0VClO2oO0CEk/gX1gqPjNCzIsbCtUPCiNg/WY0eObSWsSyjxum9GGLNOZ23atG
 Dem2JkLYyAazASNQeDTwOTlejcgALWsQlJewm0Y9NfY0C0ucrw1IURS0w33BcH53C+Ga
 U8OQ==
X-Gm-Message-State: AOJu0YxmGC7u/CoxoXpNApK2jjPqBn2MNI1ZOMfgquM4ukdtymoZ5P+j
 JDrIUdHBg8grcDkydkC0qIcNDk8Kk5i5FU9SdSMxhvglWrosABpzN0MDNV1LYpVUJtEo5zW729l
 /3CTq2SZXlx2PXdkAPXyezB64Mt0=
X-Google-Smtp-Source: AGHT+IEhprcmrJxwJcGpQGNyJO/LCHJD1OpO6kPY1xjGrJktM4iV/rxOVYlJ6gNhGGvsp0kvpmK8rO8NzdrS72Kj5tY=
X-Received: by 2002:a05:622a:40a:b0:42e:bcd9:df0 with SMTP id
 n10-20020a05622a040a00b0042ebcd90df0mr11974225qtx.62.1709905165024; Fri, 08
 Mar 2024 05:39:25 -0800 (PST)
MIME-Version: 1.0
References: <20240307092603.16269-1-meted@linux.ibm.com>
In-Reply-To: <20240307092603.16269-1-meted@linux.ibm.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 8 Mar 2024 15:39:14 +0200
Message-ID: <CAOQ4uxhFB2Gv2+8N-sc9a1+Kz1KqW+bniJe0JhVSHsaMWnxrmQ@mail.gmail.com>
To: Mete Durlu <meted@linux.ibm.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] fanotify14: fix anonymous pipe testcases
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBNYXIgOCwgMjAyNCBhdCAyOjQz4oCvUE0gTWV0ZSBEdXJsdSA8bWV0ZWRAbGludXgu
aWJtLmNvbT4gd3JvdGU6Cj4KPiBXaGVuIFNFbGludXggaXMgY29uZmlndXJlZCAoY29tZXMgb3V0
IG9mIHRoZSBib3ggb24gbW9zdCBkaXN0cm9zKSBhbmQKPiBpcyBjb25maWd1cmVkIHRvIGVuZm9y
Y2luZyAodGhlIGRlZmF1bHQgY29uZmlndXJhdGlvbiksIHRlc3RzIHJlbGF0ZWQKPiB0byBhbm9u
eW1vdXMgcGlwZXMgcmV0dXJuIEVBQ0NFUyBpbnN0ZWFkIG9mIHRoZSBleHBlY3RlZCBlcnJubyBF
SU5WQUwuCj4gRml4IHRoZSBmYWlsdXJlcyBjYXVzZWQgYnkgdGhlIGFib3ZlIGNvbmRpdGlvbiBi
eSBjaGVja2luZyB0aGUgU0VsaW51eAo+IGNvbmZpZ3VyYXRpb24gYW5kIGFkanVzdGluZyB0aGUg
ZXJybm8gYWNjb3JkaW5nbHkuCgpIaSBNZXRlLAoKSXNuJ3QgdGhlIG91dGNvbWUgb2YgdGhlIHRl
c3QgZGVwZW5kZW50IG9uIHRoZSBTRXBvbGljeSBydWxlcz8KTm90IG9ubHkgaWYgaXQgaXMgZW5m
b3JjZWQ/CgpTb3JyeSBJIGhhdmUgdmVyeSBsaXR0bGUgZXhwZXJpZW5jZSB3aXRoIFNFTGludXgu
CgpUaGFua3MsCkFtaXIuCgo+Cj4gU2lnbmVkLW9mZi1ieTogTWV0ZSBEdXJsdSA8bWV0ZWRAbGlu
dXguaWJtLmNvbT4KPiAtLS0KPiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9m
YW5vdGlmeTE0LmMgfCAxNyArKysrKysrKysrKysrKysrKwo+ICAxIGZpbGUgY2hhbmdlZCwgMTcg
aW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
ZmFub3RpZnkvZmFub3RpZnkxNC5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlm
eS9mYW5vdGlmeTE0LmMKPiBpbmRleCBkMDJkODE0OTUuLjYxZWQ4YzY2MCAxMDA2NDQKPiAtLS0g
YS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MTQuYwo+ICsrKyBi
L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkxNC5jCj4gQEAgLTI3
LDEyICsyNywxNCBAQAo+ICAjZGVmaW5lIF9HTlVfU09VUkNFCj4gICNpbmNsdWRlICJ0c3RfdGVz
dC5oIgo+ICAjaW5jbHVkZSA8ZXJybm8uaD4KPiArI2luY2x1ZGUgPHN0ZGxpYi5oPgo+Cj4gICNp
ZmRlZiBIQVZFX1NZU19GQU5PVElGWV9ICj4gICNpbmNsdWRlICJmYW5vdGlmeS5oIgo+Cj4gICNk
ZWZpbmUgTU5UUE9JTlQgIm1udHBvaW50Igo+ICAjZGVmaW5lIEZJTEUxIE1OVFBPSU5UIi9maWxl
MSIKPiArI2RlZmluZSBTRUxJTlVYX1NUQVRVU19QQVRIICIvc3lzL2ZzL3NlbGludXgvZW5mb3Jj
ZSIKPgo+ICAvKgo+ICAgKiBMaXN0IG9mIGlub2RlIGV2ZW50cyB0aGF0IGFyZSBvbmx5IGF2YWls
YWJsZSB3aGVuIG5vdGlmaWNhdGlvbiBncm91cCBpcwo+IEBAIC0yNDAsNiArMjQyLDE5IEBAIHN0
YXRpYyBzdHJ1Y3QgdGVzdF9jYXNlX3Qgewo+ICAgICAgICAgfSwKPiAgfTsKPgo+ICtzdGF0aWMg
aW50IGlzX3NlbGludXhfZW5mb3JjaW5nKHZvaWQpCj4gK3sKPiArICAgICAgIGNoYXIgcmVzOwo+
ICsgICAgICAgaW50IGZkOwo+ICsKPiArICAgICAgIGZkID0gb3BlbihTRUxJTlVYX1NUQVRVU19Q
QVRILCBPX1JET05MWSk7Cj4gKyAgICAgICBpZiAoZmQgPD0gMCkKPiArICAgICAgICAgICAgICAg
cmV0dXJuIDA7Cj4gKyAgICAgICBTQUZFX1JFQUQoMSwgZmQsICZyZXMsIDEpOwo+ICsgICAgICAg
U0FGRV9DTE9TRShmZCk7Cj4gKyAgICAgICByZXR1cm4gYXRvaSgmcmVzKTsKPiArfQo+ICsKPiAg
c3RhdGljIHZvaWQgZG9fdGVzdCh1bnNpZ25lZCBpbnQgbnVtYmVyKQo+ICB7Cj4gICAgICAgICBz
dHJ1Y3QgdGVzdF9jYXNlX3QgKnRjID0gJnRlc3RfY2FzZXNbbnVtYmVyXTsKPiBAQCAtMjc5LDYg
KzI5NCw4IEBAIHN0YXRpYyB2b2lkIGRvX3Rlc3QodW5zaWduZWQgaW50IG51bWJlcikKPiAgICAg
ICAgIGlmICh0Yy0+cGZkKSB7Cj4gICAgICAgICAgICAgICAgIGRpcmZkID0gdGMtPnBmZFswXTsK
PiAgICAgICAgICAgICAgICAgcGF0aCA9IE5VTEw7Cj4gKyAgICAgICAgICAgICAgIGlmIChpc19z
ZWxpbnV4X2VuZm9yY2luZygpKQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHRjLT5leHBlY3Rl
ZF9lcnJubyA9IEVBQ0NFUzsKPiAgICAgICAgIH0KPgo+ICAgICAgICAgdHN0X3JlcyhUSU5GTywg
IlRlc3RpbmcgJXMgd2l0aCAlcyIsCj4gLS0KPiAyLjQ0LjAKPgo+Cj4gLS0KPiBNYWlsaW5nIGxp
c3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAKCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
