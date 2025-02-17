Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1BB4C021A0
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 08:48:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1843F3C9BA3
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 09:48:45 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B8D263C92EA
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 09:48:27 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 95D47142D438
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 09:48:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739782104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R0y+QSUlUZsjWHEWanf6RvnOht/jwIya3C7cSFpFNkU=;
 b=UmPmi3yF/rj2H1qLM76gvIOzSff6cT1e5+mtAbjAOkqoZDzmMunfuNC6YlfkneXIrfgMYr
 PbwjBfsvJO2OxKlpnX07jcFwb3Kv/TjZ7N9A+3TH+40eoB5tl1geo5zdPGGBt++o6VtnBP
 tBAocAnN7u04+nbjtAjQk7Bx4fqJQgM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478--6wPQ9iXP6GJ1M0TszlwTA-1; Mon, 17 Feb 2025 03:48:22 -0500
X-MC-Unique: -6wPQ9iXP6GJ1M0TszlwTA-1
X-Mimecast-MFC-AGG-ID: -6wPQ9iXP6GJ1M0TszlwTA_1739782101
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2fc1c3b3dc7so7501101a91.2
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 00:48:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739782101; x=1740386901;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R0y+QSUlUZsjWHEWanf6RvnOht/jwIya3C7cSFpFNkU=;
 b=ljGMPXwQ5GcnlKC6CDRaPsO+3WlXV9H22qKwgSOcYoHNeQs6bimRcee1qzFu5oXrSr
 RfcNgU5Ul8/Bfo3BJo5HZGenUkpBtem8dawkDI7MvkJRxeByChi577QX1sowB1BEZXUj
 gi03lB7qUJ+4TE37cQgC/QslOrhkbHFNqTiJQ++S4Gw7hrNhL/XCg3E7jG31yjTvhr4Q
 FxHpIV6DfMUqlclejxTcwk+q7xrULnSNqc1pP9hJQ41NhquRoUdAxc2k4j/OSLdMWBLA
 y31AMtjiWFLKnaimqFcWg5WkBD+h9s2xnPAxg2znhYqhjOm7VMqIvIlj+2LifC2hbkTf
 NoRQ==
X-Gm-Message-State: AOJu0YyBW3cuuuCW9t4fueTOf/F7PAyc48yMPFYijRI3vnqo+XBC88eJ
 REqC7Qd+4FHZvPaYQ7aQg9fTy6gkg1Cd/7zSYw+puU4O3p/J7NWGubvKGb5+uTxWaLrV+8Qsh0R
 gMIiybgESohQfNo7J2n6go7YYLow9zBrPuggSAY8y/aEGLk8f++CDQVOiI8NDHVY+QxxJ43rPDo
 snPryeUheBetVGVcsbV5ZeWr0=
X-Gm-Gg: ASbGncvEJ6xSqqcBn4dt923quCoAELy/kNGAVDXa6mbubFv+34q2DuFzgFpNPBovZPe
 qvmyKlQ+JMKRs/q78Xp49eB8rEJ/c6ZYYTEjH9J9ltjtu4x+FFKAQP7VSCCV/+kc=
X-Received: by 2002:a17:90b:3a8f:b0:2ef:114d:7bf8 with SMTP id
 98e67ed59e1d1-2fc40d131e5mr13590069a91.6.1739782100972; 
 Mon, 17 Feb 2025 00:48:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFIoj0Gp31iKy7O4SOOa8PfDQyIxZWlioPC401G9fZk0dXnJQ6STBzUtPoTVI9y26HxCdHoSU5O3sx58YSb8Oo=
X-Received: by 2002:a17:90b:3a8f:b0:2ef:114d:7bf8 with SMTP id
 98e67ed59e1d1-2fc40d131e5mr13590038a91.6.1739782100577; Mon, 17 Feb 2025
 00:48:20 -0800 (PST)
MIME-Version: 1.0
References: <22b831c6-4a7c-4393-a840-d0b00512acbb.jinguojie.jgj@alibaba-inc.com>
 <4ae915b4-0be1-4ea6-b59e-50c9a960c558.jinguojie.jgj@alibaba-inc.com>
 <CA+B+MYT=RRPEUQ8WydQWeQkB02xO5=EJd=gqOTXB1F5OUWj9HQ@mail.gmail.com>
 <CA+B+MYRjJjmSxZscaFTtrPXGW2RNOyah4F__82UfN41MER+e_A@mail.gmail.com>
In-Reply-To: <CA+B+MYRjJjmSxZscaFTtrPXGW2RNOyah4F__82UfN41MER+e_A@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 17 Feb 2025 16:48:08 +0800
X-Gm-Features: AWEUYZnwRucYk9wZ1fScgaWfkb8f9NM-qmB-km9m9qWV-XAnSnFfRRraZFBHT60
Message-ID: <CAEemH2c+nZxPr2fFtSZsSEt8jeoZdYFpCTV6OYo1qr+=yDwbyQ@mail.gmail.com>
To: Jin Guojie <guojie.jin@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vzdixNvRvtyf5Cy8AmjbNtvdIW-TWdL7JQ9hQDd7yA0_1739782101
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] controllers: skip test when cgroup v2 is loaded
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
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgR3VvamllLAoKT24gTW9uLCBGZWIgMTcsIDIwMjUgYXQgMzoyNeKAr1BNIEppbiBHdW9qaWUg
PGd1b2ppZS5qaW5AZ21haWwuY29tPiB3cm90ZToKCj4gSGkgTGkgV2FuZywKPgo+IFRoaXMgcGF0
Y2ggZml4ZXMgdGhlIGp1ZGdtZW50IG9mIGNvbnRyb2xsZXJzIGluIHRoZSBjZ3JvdXAgdjIgc3lz
dGVtCj4gYW5kIGltcHJvdmVzIHRoZSBlcnJvciBtZXNzYWdlLgo+IFRoaXMgaXMgdGhlIHNlY29u
ZCB2ZXJzaW9uIEkndmUgbWFkZS4KPiBXb3VsZCB5b3UgcGxlYXNlIHJldmlldyBpdD8KPgoKU3Vy
ZSwgd2UgZG8gbm93IGhhdmUgYSBuZXcgY2dyb3VwX2xpYi5zaCB0byByZXBsYWNlIHRoZSBvdXRk
YXRlZCBzaGVsbApDR3JvdXAgQVBJLCBjYW4gd2UgaW5jbHVkZSB0aGF0IG5ldyB0byB1cGRhdGUg
dGVzdF9jb250cm9sbGVycy5zaD8KCgoKPgo+IFJlZ2FyZHMsCj4gSmluCj4KPiBPbiBUaHUsIERl
YyAxOSwgMjAyNCBhdCAyOjM24oCvUE0gSmluIEd1b2ppZSA8Z3VvamllLmppbkBnbWFpbC5jb20+
IHdyb3RlOgo+ID4KPiA+IFYyOgo+ID4gKiBDb3JyZWN0aW9uIG9mIGNvbW1lbnRzCj4gPgo+ID4g
VjE6Cj4gPiAqIEluaXRpYWwgY2hlY2sgZm9yIGNncm91cCB2Mgo+ID4KPiA+IFdoZW4gcnVubmlu
ZyAiY29udHJvbGxlcnMiIGNhc2Ugb24gc29tZSBuZXdlciBMaW51eCBkaXN0cmlidXRpb25zLCB0
aGVyZQo+ID4gd2lsbCBiZSAxMCBFUlJPUiBtZXNzYWdlcyBkdXJpbmcgdGhlIHNldHVwIHBoYXNl
LCBhbmQgc2V2ZXJhbCBURkFJTAo+ID4gcmVzdWx0cyBhdCB0aGUgZW5kLgo+ID4KPiA+IEN1cnJl
bnQgImNvbnRyb2xsZXJzIiBjYXNlcyBvbmx5IGltcGxlbWVudCB0ZXN0cyBmb3IgY2dyb3VwIHYx
IGZpbGUKPiBpbnRlcmZhY2UuCj4gPiBJdCdzIGJldHRlciB0byBza2lwIHRoZSB0ZXN0IGFmdGVy
IGNoZWNraW5nIHRoYXQgdjIgaGllcmFyY2h5IGhhcwo+ID4gYWxyZWFkeSBiZWVuIGxvYWRlZC4K
PiA+Cj4gPiBbMV0gaHR0cHM6Ly9saXN0cy5saW51eC5pdC9waXBlcm1haWwvbHRwLzIwMjQtRGVj
ZW1iZXIvMDQxMDgyLmh0bWwKPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBKaW4gR3VvamllIDxndW9q
aWUuamluQGdtYWlsLmNvbT4KPiA+IC0tLQo+ID4gIHRlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxl
cnMvdGVzdF9jb250cm9sbGVycy5zaCB8IDkgKysrKysrKysrCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDkgaW5zZXJ0aW9ucygrKQo+ID4KPiA+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL2Nv
bnRyb2xsZXJzL3Rlc3RfY29udHJvbGxlcnMuc2gKPiA+IGIvdGVzdGNhc2VzL2tlcm5lbC9jb250
cm9sbGVycy90ZXN0X2NvbnRyb2xsZXJzLnNoCj4gPiBpbmRleCA3YWE5NzRmZjIuLjBiNjczODdl
YyAxMDA3NTUKPiA+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxlcnMvdGVzdF9jb250
cm9sbGVycy5zaAo+ID4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9jb250cm9sbGVycy90ZXN0X2Nv
bnRyb2xsZXJzLnNoCj4gPiBAQCAtMzcsNiArMzcsMTUgQEAKPiA+ICAjCj4gPiAgICAgICAgICAg
ICMKPiA+Cj4gIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwo+ID4KPiA+ICsjIEN1cnJlbnRseSBv
bmx5IGNncm91cCB2MSBpbnRlcmZhY2UgY2FuIGJlIHRlc3RlZC4KPiA+ICsjIFdoZW4gdGhlIHYy
IGhpZXJhcmNoeSBpcyBhbHJlYWR5IGxvYWRlZCBpbiB0aGUgc3lzdGVtLCBza2lwIHRoZSB0ZXN0
Lgo+ID4gK21vdW50IHwgZ3JlcCAgIiB0eXBlIGNncm91cDIgIiAmPi9kZXYvbnVsbAo+ID4gK2lm
IFsgJD8gPT0gMCBdCj4gPiArdGhlbgo+ID4gKyAgICAgICB0c3RfYnJrbSBUQ09ORiAiIiAidGVz
dF9jb250cm9sbGVycy5zaDogVjEgY29udHJvbGxlcgo+ID4gcmVxdWlyZWQsIGJ1dCBtb3VudGVk
IG9uIFYyIgo+ID4gKyAgICAgICBleGl0IDMyCj4gPiArZmkKPiA+ICsKPiA+ICBpZiBbIC1mIC9w
cm9jL2Nncm91cHMgXQo+ID4gIHRoZW4KPiA+ICAgICAgICAgQ1BVX0NPTlRST0xMRVI9YGdyZXAg
LXcgY3B1IC9wcm9jL2Nncm91cHMgfCBjdXQgLWYxYDsKPiA+IC0tCj4gPiAyLjM0LjEKPgo+Cgot
LSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3Rz
LmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
