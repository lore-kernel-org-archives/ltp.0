Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9712C7115D
	for <ltp@archiver.kernel.org>; Fri, 20 Jun 2025 09:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750411434; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=8H4jhaSOYLFQqAGGYIu8uoKFTLKMvL8DNlx5pH/kSgM=;
 b=iK0GBzbH2gi4Sex7/u7/zZuuPbDRb4Ke770bbmWuAArqfkcXrO7ajFbBI93Cb4tUyTfc+
 nIRaodN5I0CqD9YO/RZ9LizJfLQgEwL8KSwo6j/WJxLJ9jlKfbE/JDlY1asC1jBGiq3Jf02
 Lj4OskbEdJheoxp6a/ou4hhzY0Nbn0g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E9803CC863
	for <ltp@archiver.kernel.org>; Fri, 20 Jun 2025 11:23:54 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 254753CC832
 for <ltp@lists.linux.it>; Fri, 20 Jun 2025 11:23:31 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D291A10009BA
 for <ltp@lists.linux.it>; Fri, 20 Jun 2025 11:23:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750411408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GdoA5AshRIjmSzJVcPkcTamHV6cxSfr9CKtjTVZ3MKc=;
 b=i2s2GU/nDaQfFOmuppMWMXByI89mn2iUSV4WG/e9ltCtc21Ovgn2EDvYyrIdm4W9slN5IL
 +0z7LulqNo6VlhW9HviMqBfR5lmJ8gk7k6LVZUDqFiIS/u57DVg0M2BxCsxXY7nQ2F7/KR
 BamM51GsLgKGzk2WdOGyIfB2EUxDjS8=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-svGdCUVtNXiOwyCCpbAIPQ-1; Fri, 20 Jun 2025 05:23:24 -0400
X-MC-Unique: svGdCUVtNXiOwyCCpbAIPQ-1
X-Mimecast-MFC-AGG-ID: svGdCUVtNXiOwyCCpbAIPQ_1750411404
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b31c38d4063so1149646a12.3
 for <ltp@lists.linux.it>; Fri, 20 Jun 2025 02:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750411404; x=1751016204;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GdoA5AshRIjmSzJVcPkcTamHV6cxSfr9CKtjTVZ3MKc=;
 b=SATWdZe8wrx017Hs57dCKBVW4OqvMOe8dRM4+3M7XexAtpVLldlk/h+DLtXxlzHk8a
 hA/a4ZCma8BnNVvixo+h5wyZMuYBvznjgDHRe7UbbFnho/WMvxgfmBypDH3JUmlQv7jk
 8/AQ0rDJNUSmRE69mw7T43xkx77NFoCxcDsP2kjJwiSntxuwUorgBI29UPxMjWdcS5tx
 mkz0UvnHWIfLS8cxykd2s6k3mb8j3wPpS6/n/1Yrafg8p5C6OY3zxjGEq0+Ftp8p9aBm
 qMYFSyOYu8jSo5i8E0mKmhStmvWkjB+wA4QdUxFvYGftSMiiJb2Q1JmFFvcY4o/rTzCm
 gqZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1qErpninbYBGEbXRIMd3OhrL7uSKFiglDZU5sKZWrDcuYGHBIWich1ALS0h61RxgirYk=@lists.linux.it
X-Gm-Message-State: AOJu0YzqTNRT3O6epMkpTZhtOhYxakbHHmKyafNirTjNd1fGqIzAOlSA
 fdMpnSHnRcnU5qJDe41s8Q/VoQHigo1Yg+KnUoVgguBWhqoRV8SOJ7bu6YFLco4GWL5BEewTIxs
 I2ul3ah1RjyAsbLDDaEFm2FCSDkN/VnCBlIhNGTbsXgFL59F7q+h3natmW/c8uQtUIu+wPvZ4bH
 WtHHPf+rCSG89ccSoMgimCglhe5xk=
X-Gm-Gg: ASbGncvT7B0vwUp4txJUMC1TATmZB5tjVrrxdvUE6YaVn9yb/VV40QJI1sWkwOg2u+A
 bKkZJ4sNslQzTX2Jy4VsNEIPQGL5f02Ot7FGoWvHb1Zghsm2Eiwjt8Qi7O4g7RUi/74za2zJPSJ
 e/IQIe
X-Received: by 2002:a17:902:e54a:b0:234:a139:1215 with SMTP id
 d9443c01a7336-237d9ab5f7fmr38717465ad.35.1750411403593; 
 Fri, 20 Jun 2025 02:23:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGY5/4H9a9IQYAcfqqxK8qsX1bp6/8GV/w2Z+A0fqCO8BnOLIdENMDgJgaXk/kAKo7mPLRJWQPQfsB6PD7a++k=
X-Received: by 2002:a17:902:e54a:b0:234:a139:1215 with SMTP id
 d9443c01a7336-237d9ab5f7fmr38716905ad.35.1750411403110; Fri, 20 Jun 2025
 02:23:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAEemH2czcnak7S50--_nh5Z2Ou+rF0=5kvY7Kx_87k_X5eEj4g@mail.gmail.com>
 <aDcRHXhOBcqVDp05@yuki.lan>
 <CAEemH2f6qeojmFXfisc-_o3iFbda98p2JCVAV_K09gbKtVQp1g@mail.gmail.com>
 <CAEemH2f8B5aJffcnbkYsr9j5KfZutgQkken8vbokNhsu19C8MA@mail.gmail.com>
 <aFUkEQXv7Wcy0lvv@yuki.lan>
In-Reply-To: <aFUkEQXv7Wcy0lvv@yuki.lan>
Date: Fri, 20 Jun 2025 17:23:10 +0800
X-Gm-Features: Ac12FXxVbrRKE_19MYxGg5ffPk3DuAlk0mRCbWkVkN4xrkPpUlxLnQQGk5I3tzA
Message-ID: <CAEemH2fsZS8To4HfRfiBp0jLH55qnLt2xMFREheGMj9y=2dOEw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8KrN5ydkjZ9cM-1iOVcfm22asg1FQj6e2bO2NgBixIs_1750411404
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [RFC] Reduce .runtime for Long-Running Tests ?
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBKdW4gMjAsIDIwMjUgYXQgNTowM+KAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiBBZnRlciBhIHJvdW5kIG9mIGV4cGVyaW1lbnRzIGFu
ZCBpbnRlcm5hbCBkaXNjdXNzaW9ucyAodGhhbmtzIHRvCj4gPiBJYW4gV2llbiBmb3Igc2hhcmlu
ZyBoaXMgdGhvdWdodHMgd2l0aCBtZSksIHdlIHRoaW5rIHRoYXQgbWFraW5nCj4gPiBMVFBfUlVO
VElNRV9NVUwgc3VwcG9ydCBmbG9hdGluZyBwb2ludCBudW1iZXJzIFswLCAxXSBtYXkKPiA+IGEg
cG9zc2libGUgd2F5IHRvIHJlZHVjZSB0aGUgLnJ1bnRpbWUgdmFsdWVzIHNldCBpbiB0ZXN0cy4K
PiA+Cj4gPiBGb3IgZXhhbXBsZSwgc2V0dGluZyBMVFBfUlVOVElNRV9NVUwgdG8gMC4xIGNhbiBv
YnZpb3VzbHkKPiA+IHJlZHVjZSB0aGUgdGVzdCB0aW1lIG9mIDYwMCBzZWNvbmRzIHRvIDYwIHNl
Y29uZHMuCj4gPgo+ID4gT25lIG1heSB0aGluayB0aGF0IHJlZHVjaW5nIHRoZSAucnVudGltZSB2
YWx1ZSBpbiBhcHJvZHVjdGlvbgo+ID4gZW52aXJvbm1lbnQgaXMgcG90ZW50aWFsbHkgcmlza3ks
IGFuZCB0byBzb21lIGV4dGVudCB0aGUgYW5zd2VyCj4gPiBpcyB5ZXMuCj4gPgo+ID4gQnV0IGxv
b2tpbmcgYmFjaywgTFRQIGlzIHRyaWdnZXJlZCB2ZXJ5IGZyZXF1ZW50bHkgaW4gQ0kgYW5kIHZh
cmlvdXMKPiA+IHByb2R1Y3Rpb24gZmxvd3MsIHNvIHRvIGNvbXBlbnNhdGUgZm9yIHRoaXMgbG9z
cywgd2UgY2FuIHVzZSBmbG9hdGluZwo+ID4gcG9pbnQgTFRQX1JVTlRJTUVfTVVMIG9ubHkgaW4g
ZGVzaWduYXRlZCBxdWljayBDSSwgaW5zdGVhZCBvZgo+ID4gdXNpbmcgaXQgaW4gZGFpbHkgdGVz
dHMuIFRoaXMgd2lsbCBoZWxwIGNvdmVyIG1vcmUgc2NlbmFyaW9zLgo+Cj4KCgo+IEhhdmluZyBy
ZWR1Y2VkIHJ1bnRpbWUgZm9yIENJIG1ha2VzIHNlbnNlLCBhcyB5b3Ugc2FpZCB5b3UgYXJlIG1h
a2luZyB1cAo+IGZvciB0aGUgcmVkdWN0aW9uIGJ5IHRoZSBudW1iZXIgb2YgdGVzdHJ1bnMuIEl0
IG1heSBub3Qgd29yayB3ZWxsIGZvcgo+IGZ1enp5IHN5bmMgdGhvdWdoIHdoZXJlIHdlIGRlcGVu
ZCBvbiBoYXZpbmcgZ29vZCBlbm91Z2ggc2FtcGxpbmcgcGVyaW9kLgo+CgpBZ2FpbnN0IHRoaXMg
cmVxdWlyZW1lbnQsIG1heWJlIHdlIGNhbiBpbnRyb2R1Y2UgYSAic3dpdGNoIGJ1dHRvbiIgdG8g
Y2xvc2UKcnVudGltZV9tdWx0aXBseSAoMC4xXSB0YWtlIGVmZmVjdGl2ZSBpbiBmdXp6eSBzeW5j
IHNhbXBsaW5nIHRlc3RzLCBldmVuIGZvcgpzb21lIG90aGVyIHRlc3RzIHRoYXRyZWx5IG9uIHRz
dF9yZW1haW5kX3J1bnRpbWUgdG8gY29udHJvbCB0aGUgcHJvY2VzcwooZS4uZyBwcmVhZHYyMDMp
IGFzIHdlbGwKCldpdGggdGhpcyBzd2l0Y2gsIHdlIGNhbiBwcmVjaXNlbHkgY29udHJvbCB0aGUg
c3BlY2lmaWVkIHRlc3Qgbm90IGdldAppbXBhY3RlZApieSB0aGUgdmFsdWUgb2YgTFRQX1JVTlRJ
TUVfTVVMKHdoYXRldmVyIDwxIG9yID4xKS4KCgoKPgo+IEFsc28gbGltaXRpbmcgdGhlIHNtYWxs
ZXN0IG11bHRpcGxpZXIgdG8gYmUgMC4xIG9yIHNvIGRvZXMgbWFrZSBzZW5zZS4gSQo+IGFzc3Vt
ZSB0aGF0IGlmIHdlIHNldCBpdCB0byAwLjAxIG9yIHNtYWxsZXIgbW9zdCB0ZXN0cyB3aXRoIHJ1
bnRpbWUKPiB3b3Vkbid0IGV2ZW4gZXhlY3V0ZS4KPgo+ID4gRnJvbSBvdXIgQ0kgcmVwb3J0LCB1
c2UgMC4xIGluIHJ1bnRpbWVfbXVsIGZpbmQgYSBmZXcgZmFpbHVyZXMgaW4gdGhlCj4gcm91bmQK
PiA+IGRvd24gcHJvYmxlbSB3aXRoIG5pY2UwNS5jICgucnVudGltZSA9IDMpLCB0aGlzIGlzIGEg
ZGVmZWN0IG9mCj4gPiBtdWx0cGx5X3J1bnRpbWUoKS4KPiA+IEFsc28sIGFub3RoZXIgcHJlYWR2
MjAzIHBvc3NpYmxlIGZhaWx1cmUgcmVsYXRlZCB0aGlzLiBCdXQgdGhleSBhcmUgdGlueQo+ID4g
aXNzdWVzLiBBbmQgdGhlIHJlc3QgLnJ1bnRpbWUgdGVzdHMgc28gZmFyIG5vIG9idmlvdXMgcHJv
YmxlbSBvbiB0aGF0Lgo+Cj4gSSBndWVzcyB0aGF0IHdlIG5lZWQgdG8gbWFrZSBzdXJlIHRoYXQg
dGhlIHJ1bnRpbWUgc3RheXMgcG9zaXRpdmUuIFNvCj4gbWF5YmUgd2UgbmVlZCBzb21ldGhpbmcg
YXM6Cj4KPiBydW50aW1lID0gTUFYKDIsIHRzdF90ZXN0LT5ydW50aW1lICogcnVudGltZV9tdWwp
Cj4KPiA+IFNvIEkgd291bGQgbGlrZSB0byBzdGFydCB0aGUgd29yayBmcm9tIHRoaXMgcG9pbnQg
dG8gcmVkdWNlIGV4ZWN1dGlvbgo+IHRpbWUuCj4KPiBTb3VuZHMgZ29vZCB0byBtZS4KPgo+IC0t
Cj4gQ3lyaWwgSHJ1YmlzCj4gY2hydWJpc0BzdXNlLmN6Cj4KPgoKLS0gClJlZ2FyZHMsCkxpIFdh
bmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5m
by9sdHAK
