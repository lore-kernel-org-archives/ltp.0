Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C77F2CA1015
	for <ltp@archiver.kernel.org>; Thu,  4 Sep 2025 13:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1756991701; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=VlxCqWwQIhgxDZsmRRzPKrPURU0mS9dg+bY2g7n4MTM=;
 b=cB/uTnkoPTzNq4osl+bkYKEYyxC4dh7rqmOfYVFnpwtFFdN8X3KhWNqYstNeUo2fMkGDP
 mxnfWEmBNSp7bAXvvw4cQajCQ8/5GSVj9J9iwYrlDHeNc/7lZ1qGGf8yARlzWCrIX6FPrcO
 U2GXC9b0CIilFbFWOHAFA07AaGqYYk4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E6F243CD442
	for <ltp@archiver.kernel.org>; Thu,  4 Sep 2025 15:15:01 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E17F83CD3E9
 for <ltp@lists.linux.it>; Thu,  4 Sep 2025 15:14:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0928C600198
 for <ltp@lists.linux.it>; Thu,  4 Sep 2025 15:14:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756991679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HPomLZLBLO6CF99R/0edZQ3az9o70hOq/wlzCpHA+WU=;
 b=ffuWL3SNkVA8LjRwLzWuczi3nJFdpqZrt3sy3DB+5xeFSZ0btDWHIZjHFUXyQGtsT5yAwJ
 cbBdRclnC4oQ/7QFKrFjWvrWgbi4DAXTSjjm+oovvW4QqESxKOAylxlAbYMeCB1+H4Lyhw
 05kyxLIBEv8OHORkuIhjoM3l/f1rn8w=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-4K6mAv34OO6dIfhh3ZF-1Q-1; Thu, 04 Sep 2025 09:14:37 -0400
X-MC-Unique: 4K6mAv34OO6dIfhh3ZF-1Q-1
X-Mimecast-MFC-AGG-ID: 4K6mAv34OO6dIfhh3ZF-1Q_1756991676
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2445805d386so10449965ad.1
 for <ltp@lists.linux.it>; Thu, 04 Sep 2025 06:14:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756991675; x=1757596475;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HPomLZLBLO6CF99R/0edZQ3az9o70hOq/wlzCpHA+WU=;
 b=SMZM80Nw1ki3forofLROXD5gsceiz7fybVj37bm/rbYp3/OgpDcXj4YQs0Qo9LUZAg
 CFqJd+kuVzrYcjmrAfVMQvrpXjF4rrH7nretQ11xPybnki9LuDc6Q7yXpD78CeyFj348
 l8lHyexvIqf+sFXLTnZyNKMSmhMy1f54e0FWLjCUlxaTdh5NKUdKTiGcJrrnSZDKrYAe
 s4fcaLb4YlQsE8RYZTiCqII7OXWNWj8G1ScV8xZSMAShy9C9xWZ+QrBI1IhkCtLeXDvC
 Repbtaz3kIvcTHeADOvkupjVAIgINB0HxOO7qbkcs1yMP51XZ+7jQbV0ifDBSDeJrkbp
 qS3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9gGu7kmJQuWA8z+z3ahRD9rwLZb+vz0IyGMYsjJzJLkiB8IwIfyWu9U8PsgCMNkaMN9c=@lists.linux.it
X-Gm-Message-State: AOJu0YzdJctpypIGTxCG6kpDJnMcNIuSWEgFKEg6uV97K6pcxZIPeJKu
 T6eleY69toSZ8WYytH5Zaw5gZlsXo7PU4rHho5BsewbI/yWpJN9Zbf9lOcmNzVGAya+piJlOJOr
 AuthQGrUUPf0UIvoOp0m73CSvTz3y501Kw/FM2R42PzJK3em8H0tf527gHGMcWhx2JIe1fymlLb
 mWudAyTgbrZttY2qiaEYjt3O6Gs56Xv2OrUwpHgg==
X-Gm-Gg: ASbGncvQobI5NhdTTqoWNvSthRPosShqNW1dAx8tlkiPijaJKmey+NQ6PmN3Mq91lnO
 bDd/j5chIH/rH1KFobbTaGU30tC/WnQZBDtULU5mT+0DGc8uGTUCSnDALzukGnaToz+hjf0Jm2Y
 zjnhoUWfxWT66KRsebgwxPNQ==
X-Received: by 2002:a17:902:f689:b0:24c:b2a5:72f2 with SMTP id
 d9443c01a7336-24cb2a57687mr56222055ad.44.1756991674922; 
 Thu, 04 Sep 2025 06:14:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgh4Pmke/0oTuEQzl63kiz4pAqhU2+uCqK8cH2/rKjnZbLvC/usJy8i9l+06HIvzx8PGK2G/AaXgwJkkdJJkw=
X-Received: by 2002:a17:902:f689:b0:24c:b2a5:72f2 with SMTP id
 d9443c01a7336-24cb2a57687mr56221765ad.44.1756991674487; Thu, 04 Sep 2025
 06:14:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250904102609.133359-1-liwang@redhat.com>
 <20250904110018.GA56668@pevik> <aLl7ConfYPBglqhx@rei.lan>
In-Reply-To: <aLl7ConfYPBglqhx@rei.lan>
Date: Thu, 4 Sep 2025 21:14:22 +0800
X-Gm-Features: Ac12FXwd8rX0AlQ2au2fvwrvJsJCLzXFrIKxwqbva0gd_Dh4LTYptTWIH7G6Voc
Message-ID: <CAEemH2f=6MRZTk95ZctgPG-MKdyw5oK9WNgh3Tm8WNHQ9NcW_g@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5jhD3Vo9yc0CgiDtsdXy8nHst3S4k839Yn2ZvPfe9hM_1756991676
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] sched_football: synchronize with kickoff flag
 to reduce skew
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBTZXAgNCwgMjAyNSBhdCA3OjQy4oCvUE0gQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1
c2UuY3o+IHdyb3RlOgoKPiBIaSEKPiA+ID4gIHN0YXRpYyB2b2lkIGRvX3NldHVwKHZvaWQpCj4g
PiA+ICB7Cj4gPiA+ICsgICBpZiAoIXRzdF9jaGVja19wcmVlbXB0X3J0KCkpCj4gPiA+ICsgICAg
ICAgICAgIHRzdF9icmsoVENPTkYsICJUZXN0IHJlcXVpcmVzIHJlYWwtdGltZSBrZXJuZWwiKTsK
PiA+Cj4gPiBJIHVuZGVyc3Rvb2QgQ3lyaWwgaXMgcmVhbGx5IHN1Z2dlc3RpbmcgdG8ga2VlcCBp
dCBbMV0uIEkgd291bGQgYWxzbwo+IHZvdGUgdG8KPiA+IGtlZXAgaXQgKHdlIHN0aWxsIGhhdmUg
c29tZSB0aW1lIHRvIHNlZSBpZiBpdCBnb3QgZml4ZWQgYmVmb3JlIHJlbGVhc2UpLgo+ID4KPiA+
IEkga25vdyB3ZSBoYWQgdGhpcyBkaXNjdXNzaW9uIGluIHRoZSBwYXN0IChzb21lIG9mIHlvdXIg
Y29sbGVhZ3VlCj4gc3VnZ2VzdGluZyBpdAo+ID4gc2hvdWxkIG5vdCBiZSBydW4gb24gbm9uLVJU
IGtlcm5lbCksIHNvIEknbSBub3QgcHVzaGluZyBmb3IgaXQuCj4KPiBJIHN0aWwgZG8gbm90IHVu
ZGVyc3RhbmQgcmVhc29ucyBmb3IgZGlzYWJsaW5nIHRoZSB0ZXN0LiBUaGUgUE9TSVgKPiByZWFs
dGltZSBzY2hlZHVsbGluZyBjbGFzc2VzIGhhdmUgdG8gd29yayBwcm9wZXJseSByZWdhcmRsZXNz
IG9mIHRoZQo+IGtlcm5lbCBmbGF2b3IuIFdoeSBzaG91bGQgd2UgdHVybiB0aGUgdGVzdCBvZmYg
b24gbm9uLXJ0IGtlcm5lbCB0aGVuPwo+CgpObyBzcGVjaWFsIHJlYXNvbnMuIEkgc3RpbGwgY2Fu
IHNwb3JhZGljYWxseSBjYXRjaCB0aGUgZmFpbHVyZSBvbiBub24tUlQKa2VybmVsIHdpdGggZXZl
biBzbGVlcCAyIHNlY29uZHMuCgpUaHVzLCBJIHRvb2sgdGhpcyB2ZXJ5IGV4dHJlbWUgYXBwcm9h
Y2gsIGJlY2F1c2Ugb24gbm9uLVJUIGtlcm5lbCwgc2xlZXAKbWF5IG5vdCBoYXZlIGEgcGFydGlj
dWxhcmx5IHBlcmZlY3QgZWZmZWN0LCBJIGd1ZXNzIHRoZSBzdG9jayBrZXJuZWwgd2l0aApzY2hl
ZF9zZXRzY2hlZHVsZXIoLCBTQ0hFRF9GSUZPLCApIGlzIHN0aWxsIGhhcyBzY2hlZHVsaW5nIHNr
ZXcgd2l0aAp3b3JrbG9hZC4KCkJ1dCB0aGUgUlQga2VybmVsIGlzIG1vcmUgYWdncmVzc2l2ZSBp
biBzY2hlZHVsaW5nLCBhbmQgaXQgaXMgYWxtb3N0CmltcG9zc2libGUKdG8gZW5jb3VudGVyIGZh
bHNlIHBvc2l0aXZlcyB3aXRoIHRoYXQgZW5oYW5jZW1lbnQuCgoKLS0tIGEvdGVzdGNhc2VzL3Jl
YWx0aW1lL2Z1bmMvc2NoZWRfZm9vdGJhbGwvc2NoZWRfZm9vdGJhbGwuYworKysgYi90ZXN0Y2Fz
ZXMvcmVhbHRpbWUvZnVuYy9zY2hlZF9mb290YmFsbC9zY2hlZF9mb290YmFsbC5jCkBAIC0xMzAs
NiArMTMwLDggQEAgdm9pZCByZWZlcmVlKGludCBnYW1lX2xlbmd0aCkKICAgICAgICBwdGhyZWFk
X2JhcnJpZXJfd2FpdCgmc3RhcnRfYmFycmllcik7CiAgICAgICAgdHN0X2F0b21pY19zdG9yZSgw
LCAmdGhlX2JhbGwpOwogICAgICAgIHRzdF9hdG9taWNfc3RvcmUoMSwgJmtpY2tvZmZfZmxhZyk7
CisgICAgICAgdXNsZWVwKDIwMDAwMDApOworCgogICAgICAgIC8qIFdhdGNoIHRoZSBnYW1lICov
CiAgICAgICAgd2hpbGUgKChub3cudHZfc2VjIC0gc3RhcnQudHZfc2VjKSA8IGdhbWVfbGVuZ3Ro
KSB7CkBAIC0xOTksOSArMjAxLDYgQEAgc3RhdGljIHZvaWQgZG9fdGVzdCh2b2lkKQoKIHN0YXRp
YyB2b2lkIGRvX3NldHVwKHZvaWQpCiB7Ci0gICAgICAgaWYgKCF0c3RfY2hlY2tfcHJlZW1wdF9y
dCgpKQotICAgICAgICAgICAgICAgdHN0X2JyayhUQ09ORiwgIlRlc3QgcmVxdWlyZXMgcmVhbC10
aW1lIGtlcm5lbCIpOwotCiAgICAgICAgaWYgKHRzdF9wYXJzZV9pbnQoc3RyX2dhbWVfbGVuZ3Ro
LCAmZ2FtZV9sZW5ndGgsIDEsIElOVF9NQVgpKQogICAgICAgICAgICAgICAgdHN0X2JyayhUQlJP
SywgIkludmFsaWQgZ2FtZSBsZW5ndGggJyVzJyIsIHN0cl9nYW1lX2xlbmd0aCk7CgojIC4vc2No
ZWRfZm9vdGJhbGwKdHN0X3Rlc3QuYzoyMDA0OiBUSU5GTzogTFRQIHZlcnNpb246IDIwMjUwNTMw
CnRzdF90ZXN0LmM6MjAwNzogVElORk86IFRlc3RlZCBrZXJuZWw6IDYuMTIuMC01NS4yOS4xLmVs
MTBfMC54ODZfNjQKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICMxIFNNUCBQUkVF
TVBUX0RZTkFNSUMgTW9uIEF1ZyAxOAowNTozNzoyNCBFRFQgMjAyNSB4ODZfNjQKdHN0X2tjb25m
aWcuYzo4ODogVElORk86IFBhcnNpbmcga2VybmVsIGNvbmZpZwonL2xpYi9tb2R1bGVzLzYuMTIu
MC01NS4yOS4xLmVsMTBfMC54ODZfNjQvY29uZmlnJwp0c3RfdGVzdC5jOjE4MjU6IFRJTkZPOiBP
dmVyYWxsIHRpbWVvdXQgcGVyIHJ1biBpcyAwaCAwMG0gMzBzCnNjaGVkX2Zvb3RiYWxsLmM6MTYy
OiBUSU5GTzogcGxheWVyc19wZXJfdGVhbTogMzIgZ2FtZV9sZW5ndGg6IDUKc2NoZWRfZm9vdGJh
bGwuYzoxNzg6IFRJTkZPOiBTdGFydGluZyAzMiBvZmZlbnNlIHRocmVhZHMgYXQgcHJpb3JpdHkg
MTUKc2NoZWRfZm9vdGJhbGwuYzoxODU6IFRJTkZPOiBTdGFydGluZyAzMiBkZWZlbnNlIHRocmVh
ZHMgYXQgcHJpb3JpdHkgMzAKc2NoZWRfZm9vdGJhbGwuYzoxOTI6IFRJTkZPOiBTdGFydGluZyA2
NCBjcmF6eS1mYW4gdGhyZWFkcyBhdCBwcmlvcml0eSA1MApzY2hlZF9mb290YmFsbC5jOjExODog
VElORk86IFN0YXJ0aW5nIHJlZmVyZWUgdGhyZWFkCnNjaGVkX2Zvb3RiYWxsLmM6MTIxOiBUSU5G
TzogU3RhcnRpbmcgdGhlIGdhbWUgKDUgc2VjKQpzY2hlZF9mb290YmFsbC5jOjE0NDogVElORk86
IEZpbmFsIGJhbGwgcG9zaXRpb246IDE2NzYxCnNjaGVkX2Zvb3RiYWxsLmM6MTUwOiBURkFJTDog
RXhwZWN0OiBmaW5hbF9iYWxsID09IDAKCgoKPgo+IEl0IG1heSBtYWtlIHNlbnNlIHRvIHByb2xv
bmcgdGhlIHNldHRsaW5nIHBlcmlvZCBmb3Igbm9uLXJ0IHNvbWV0aGluZwo+IGFzOgo+Cj4gLi4u
Cj4gICAgICAgICBpZiAodHN0X2NoZWNrX3ByZWVtcHRfcnQoKQo+ICAgICAgICAgICAgICAgICBz
ZXR0bGluZ19wZXJpb2QgPSAyMDAwMDsKPiAgICAgICAgIGVsc2UKPiAgICAgICAgICAgICAgICAg
c2V0dGxpbmdfcGVyaW9kID0gMjAwMDAwOwo+Cj4KPiAuLi4KPiAgICAgICAgIHVzbGVlcChzZXR0
bGluZ19wZXJpb2QpOwo+IC4uLgo+Cj4KPiBJbiBvcmRlciB0byBtYWtlIHN1cmUgbm9uLXJ0IHNj
aGVkdWxsZXIgaGFzIGVub3VnaCB0aW1lIHRvIHNodWZmbGUgdGhlCj4gcHJvY2Vzc2VzIGFyb3Vu
ZCB0aGUgYXZhaWxhYmxlIENQVXMuIEJ1dCB0aGF0IHNob3VsZCBiZSB0aGUgb25seQo+IGRpZmZl
cmVuY2UuCj4KPiAtLQo+IEN5cmlsIEhydWJpcwo+IGNocnViaXNAc3VzZS5jego+Cj4KCi0tIApS
ZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
