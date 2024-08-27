Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C923C52D6F
	for <ltp@archiver.kernel.org>; Tue, 27 Aug 2024 03:28:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E5DAD3D26CC
	for <ltp@archiver.kernel.org>; Tue, 27 Aug 2024 05:28:19 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E5E583C7A13
 for <ltp@lists.linux.it>; Tue, 27 Aug 2024 05:28:03 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E422F600041
 for <ltp@lists.linux.it>; Tue, 27 Aug 2024 05:27:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724729276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U1s0hCLr4FjBlF6P6Z5JvM0aH0nl/3Pmil6muY/95HY=;
 b=BlvAAYXhXHkBQiQtKSKVCA21WQvXrhu2MqLOeFS3BYdP8iF5BslQ7O4s+grUx1D1up0Feb
 NJn59Z2zC8uLVbIHqnv7E5PayNEcPSSjcdAW+Psw/OJTbSeBainwGyLoZGUhao9aX/HXZM
 RvpRVRArKFdMKGtVgbAZMojeS0qy3ns=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-0nWy5eCOOYqvpyYgHnyruA-1; Mon, 26 Aug 2024 23:27:49 -0400
X-MC-Unique: 0nWy5eCOOYqvpyYgHnyruA-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-6507e2f0615so4374265a12.1
 for <ltp@lists.linux.it>; Mon, 26 Aug 2024 20:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724729269; x=1725334069;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U1s0hCLr4FjBlF6P6Z5JvM0aH0nl/3Pmil6muY/95HY=;
 b=k+5Kbj2pxsRI88e4fOubDmyDwbpaRoFu+JJ71BSW38M+QjLyneRHLOCXFD/nKQROfs
 +fwcW6QeEKlo7KZuFTNbRwrZ++5/pQfV0hUS393sfKswo8dsSEX5/1Yxa/DXeF9/aQ4g
 DZsk8CWYt7mKh1p4P0jBzbFTvEnwvaoy1Kh0+jKeKqQvqy2ncnaguMkyb+rwvk2NyZcm
 4cBIVjFAX65+N8TpS/IE5TitP2rvOISjrSOmgajTwK1e2Ylc6TJbbrks3AfBv7gmSptt
 4um/TzBNxfXf56KFYxVf0tpAMCbkFERGQZVxJqQFNJSq3qfVIIgAUaOoimYdQbIn2Dcg
 CfDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWoZcmkLcT9AxoNnLHllEwkitV+oqnfH0/m7WtdDlQQ57XRS90+E5G/KfIrGhK/7Q9/3Q=@lists.linux.it
X-Gm-Message-State: AOJu0Yynn5ZhWUCYBtQj5hjt1fiDFqwf8i8lW45gOQySzVd6FCtCSFSy
 tzq5e35MwOYqCmw9im5xjhEhQBx/xk0XACxgluISyxRUdJssgjD3YEDlr6tUnczQQBQcV+h/FFH
 nrPEfJjWv6z5Qxts+i06jklh+JfMMbsMyMYKGox/DaDL6TtrmOnW2KSsAt/zRF5Rp9R8WaR9p/P
 77pPFCAkYR1viSPlNxf5/B3Mg=
X-Received: by 2002:a05:6a21:318b:b0:1c4:a49b:403 with SMTP id
 adf61e73a8af0-1ccc09b6a85mr1661044637.46.1724729268794; 
 Mon, 26 Aug 2024 20:27:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEb2QHagUWM1fnGf+ZqFpwNmRJ+CNT4g4X1/rmb6k+LLSMAf29sz1TOk2po6aNol9XpdiW0Eg5I7eCi7Fw2+a4=
X-Received: by 2002:a05:6a21:318b:b0:1c4:a49b:403 with SMTP id
 adf61e73a8af0-1ccc09b6a85mr1661029637.46.1724729268364; Mon, 26 Aug 2024
 20:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240827032218.34744-1-liwang@redhat.com>
In-Reply-To: <20240827032218.34744-1-liwang@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 27 Aug 2024 11:27:36 +0800
Message-ID: <CAEemH2cuvRCBoKE=ox9Xba4aohrAqEsmcSubu5-KTjnNH4YaQA@mail.gmail.com>
To: linux-kernel@vger.kernel.org, ltp@lists.linux.it, 
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] loop: Increase bsize variable from unsigned short
 to unsigned int
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, John Garry <john.g.garry@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

QWRkaW5nIEplbnMgQXhib2UgYW5kIGxpbnV4LWJsb2NrQHZnZXIua2VybmVsLm9yZyBNTC4KCgpP
biBUdWUsIEF1ZyAyNywgMjAyNCBhdCAxMToyMuKAr0FNIExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKCj4gVGhpcyBjaGFuZ2UgYWxsb3dzIHRoZSBsb29wYmFjayBkcml2ZXIgdG8g
aGFuZGxlIGxhcmdlciBibG9jayBzaXplcwo+IGFuZCBpbmNyZWFzZXMgdGhlIGNvbnNpc3RlbmN5
IG9mIGRhdGEgdHlwZXMgdXNlZCB3aXRoaW4gdGhlIGRyaXZlci4KPiBFc3BlY2lhbGx5IHRvIG1h
Y3RjaCB0aGUgc3RydWN0IHF1ZXVlX2xpbWl0cy5sb2dpY2FsX2Jsb2NrX3NpemUgdHlwZS4KPgo+
IEFsc28sIHRoaXMgaXMgdG8gZ2V0IHJpZCBvZiB0aGUgTFRQL2lvY3RsX2xvb3AwNiB0ZXN0IGZh
aWx1cmU6Cj4KPiAgIDEyIGlvY3RsX2xvb3AwNi5jOjc2OiBUSU5GTzogVXNpbmcgTE9PUF9TRVRf
QkxPQ0tfU0laRSB3aXRoIGFyZyA+Cj4gUEFHRV9TSVpFCj4gICAxMyBpb2N0bF9sb29wMDYuYzo1
OTogVEZBSUw6IFNldCBibG9jayBzaXplIHN1Y2NlZWQgdW5leHBlY3RlZGx5Cj4gICAuLi4KPiAg
IDE4IGlvY3RsX2xvb3AwNi5jOjc2OiBUSU5GTzogVXNpbmcgTE9PUF9DT05GSUdVUkUgd2l0aCBi
bG9ja19zaXplID4KPiBQQUdFX1NJWkUKPiAgIDE5IGlvY3RsX2xvb3AwNi5jOjU5OiBURkFJTDog
U2V0IGJsb2NrIHNpemUgc3VjY2VlZCB1bmV4cGVjdGVkbHkKPgo+IExpbms6IGh0dHBzOi8vbGlz
dHMubGludXguaXQvcGlwZXJtYWlsL2x0cC8yMDI0LUF1Z3VzdC8wMzk5MTIuaHRtbAo+IFNpZ25l
ZC1vZmYtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPgo+IENjOiBKYW4gU3RhbmNlayA8
anN0YW5jZWtAcmVkaGF0LmNvbT4KPiBDYzogSm9obiBHYXJyeSA8am9obi5nLmdhcnJ5QG9yYWNs
ZS5jb20+Cj4gQ2M6IERhbWllbiBMZSBNb2FsIDxkbGVtb2FsQGtlcm5lbC5vcmc+Cj4gQ2M6IFN0
ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KPiAtLS0KPiAgZHJpdmVycy9ibG9j
ay9sb29wLmMgfCA2ICsrKy0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAz
IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmxvY2svbG9vcC5jIGIvZHJp
dmVycy9ibG9jay9sb29wLmMKPiBpbmRleCA3OGE3YmIyOGRlZmUuLjg2Y2MzYjE5ZmFhZSAxMDA2
NDQKPiAtLS0gYS9kcml2ZXJzL2Jsb2NrL2xvb3AuYwo+ICsrKyBiL2RyaXZlcnMvYmxvY2svbG9v
cC5jCj4gQEAgLTE3Myw3ICsxNzMsNyBAQCBzdGF0aWMgbG9mZl90IGdldF9sb29wX3NpemUoc3Ry
dWN0IGxvb3BfZGV2aWNlICpsbywKPiBzdHJ1Y3QgZmlsZSAqZmlsZSkKPiAgc3RhdGljIGJvb2wg
bG9fYmRldl9jYW5fdXNlX2RpbyhzdHJ1Y3QgbG9vcF9kZXZpY2UgKmxvLAo+ICAgICAgICAgICAg
ICAgICBzdHJ1Y3QgYmxvY2tfZGV2aWNlICpiYWNraW5nX2JkZXYpCj4gIHsKPiAtICAgICAgIHVu
c2lnbmVkIHNob3J0IHNiX2JzaXplID0gYmRldl9sb2dpY2FsX2Jsb2NrX3NpemUoYmFja2luZ19i
ZGV2KTsKPiArICAgICAgIHVuc2lnbmVkIGludCBzYl9ic2l6ZSA9IGJkZXZfbG9naWNhbF9ibG9j
a19zaXplKGJhY2tpbmdfYmRldik7Cj4KPiAgICAgICAgIGlmIChxdWV1ZV9sb2dpY2FsX2Jsb2Nr
X3NpemUobG8tPmxvX3F1ZXVlKSA8IHNiX2JzaXplKQo+ICAgICAgICAgICAgICAgICByZXR1cm4g
ZmFsc2U7Cj4gQEAgLTk3Nyw3ICs5NzcsNyBAQCBsb29wX3NldF9zdGF0dXNfZnJvbV9pbmZvKHN0
cnVjdCBsb29wX2RldmljZSAqbG8sCj4gICAgICAgICByZXR1cm4gMDsKPiAgfQo+Cj4gLXN0YXRp
YyB1bnNpZ25lZCBzaG9ydCBsb29wX2RlZmF1bHRfYmxvY2tzaXplKHN0cnVjdCBsb29wX2Rldmlj
ZSAqbG8sCj4gK3N0YXRpYyB1bnNpZ25lZCBpbnQgbG9vcF9kZWZhdWx0X2Jsb2Nrc2l6ZShzdHJ1
Y3QgbG9vcF9kZXZpY2UgKmxvLAo+ICAgICAgICAgICAgICAgICBzdHJ1Y3QgYmxvY2tfZGV2aWNl
ICpiYWNraW5nX2JkZXYpCj4gIHsKPiAgICAgICAgIC8qIEluIGNhc2Ugb2YgZGlyZWN0IEkvTywg
bWF0Y2ggdW5kZXJseWluZyBibG9jayBzaXplICovCj4gQEAgLTk4Niw3ICs5ODYsNyBAQCBzdGF0
aWMgdW5zaWduZWQgc2hvcnQgbG9vcF9kZWZhdWx0X2Jsb2Nrc2l6ZShzdHJ1Y3QKPiBsb29wX2Rl
dmljZSAqbG8sCj4gICAgICAgICByZXR1cm4gU0VDVE9SX1NJWkU7Cj4gIH0KPgo+IC1zdGF0aWMg
aW50IGxvb3BfcmVjb25maWd1cmVfbGltaXRzKHN0cnVjdCBsb29wX2RldmljZSAqbG8sIHVuc2ln
bmVkIHNob3J0Cj4gYnNpemUpCj4gK3N0YXRpYyBpbnQgbG9vcF9yZWNvbmZpZ3VyZV9saW1pdHMo
c3RydWN0IGxvb3BfZGV2aWNlICpsbywgdW5zaWduZWQgaW50Cj4gYnNpemUpCj4gIHsKPiAgICAg
ICAgIHN0cnVjdCBmaWxlICpmaWxlID0gbG8tPmxvX2JhY2tpbmdfZmlsZTsKPiAgICAgICAgIHN0
cnVjdCBpbm9kZSAqaW5vZGUgPSBmaWxlLT5mX21hcHBpbmctPmhvc3Q7Cj4gLS0KPiAyLjQ2LjAK
Pgo+Cj4gLS0KPiBNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0
aW5mby9sdHAKPgo+CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
