Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A17CE77173
	for <ltp@archiver.kernel.org>; Mon,  9 Dec 2024 09:43:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C68A93E6A32
	for <ltp@archiver.kernel.org>; Mon,  9 Dec 2024 10:43:02 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 10E753E6A24
 for <ltp@lists.linux.it>; Mon,  9 Dec 2024 10:42:46 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D6ED714232E2
 for <ltp@lists.linux.it>; Mon,  9 Dec 2024 10:42:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733737363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RUguippRYl4jNE3Ms43CHgJ1lKL0JZYnraJepIsS+x8=;
 b=gHyjk0Zd730z4lrYupPGfR6mf6AHxjx7BmaJWqQp0kRaGBa0uxeAsUAQIWngeFDfWreNKF
 n4teXrC5YrCisM1igbHnvhT3gyl3xblo5X8X4VeDK8RN1i1iOi6OvL9aCeubNnnSqmpm78
 RXxyhZ0GBjqN48tyhkQWcIwAXrlUbhg=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-MtLjHKeWOsmm6HaHsk8tWA-1; Mon, 09 Dec 2024 04:42:42 -0500
X-MC-Unique: MtLjHKeWOsmm6HaHsk8tWA-1
X-Mimecast-MFC-AGG-ID: MtLjHKeWOsmm6HaHsk8tWA
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-7fd3c241975so1314867a12.0
 for <ltp@lists.linux.it>; Mon, 09 Dec 2024 01:42:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733737359; x=1734342159;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RUguippRYl4jNE3Ms43CHgJ1lKL0JZYnraJepIsS+x8=;
 b=R5B1KTMjwZ9iiy2e9y01nAEdbKeb1ooxOyXRH9QDyaQlFOD+C82VBvmvbSbJkfwHv6
 fHzO5mP+ktRZOFVg9OTOP3EYeJ+s3muYAbFIhTEPh4W8bpXziH88NRRAt/ovuiQ2Mlyn
 aNaQWdCQkpjmPCHGwqeZFekhOIXYN8Tin8Hit7ixN3c4xKS8n5sj7MJY7NIOuQrApBQL
 Kjc0KR7TIk/qPHcw9Em8egsXuUoVnJh+6YhkXopWjifxEKXRLCJ6RIxCpSEdj6gHygQ+
 B3oQdKEgU4OC8/y2gWwXp4vTmRu7woqcoJ0S0dicYyma/6O6lHI6lkqu+lpwLi+flGmH
 v4XQ==
X-Gm-Message-State: AOJu0YxqfzDtwEF/r3H4jt2nrrr5wDgnRUdCtEM5EmVPoF+iHdzJOEtw
 GmN66OhqZnQ9Iq9k5WfqaS2w9hFTKbxB7veU7tt6OGgMMxLSkq2vq4XNKv+2LsuBJAtOiou2SIg
 WoQIrmTRXCoV/lpVFDxxjpMpK7m3yVWU+wc93eqEP5cf1hY2oMfbWwSofgGTf0atE/Yw5dPfpOr
 o6FK7t4KmSPk882RL3INPnjxdvSsyzN41D3O1+
X-Gm-Gg: ASbGncvTw3omqY43aYNtd1ktMTo/y/1HLIWQEjo4xArXjzU+91WBLcd10Uhlwh8uI1D
 bc9uS1m2zKaU3DZ6qtVmaL3Pr4j8oLsOY
X-Received: by 2002:a17:90b:278e:b0:2ee:ad18:b310 with SMTP id
 98e67ed59e1d1-2ef68e2c007mr18339029a91.18.1733737359087; 
 Mon, 09 Dec 2024 01:42:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHva2RXkD4jsP5A3fcrX0VNSDRq1wGHzrhulHPAmc0PyJ90dgMTKEIkndSY/tcs5UlJaWBiTO0CzSmq0QYVG/4=
X-Received: by 2002:a17:90b:278e:b0:2ee:ad18:b310 with SMTP id
 98e67ed59e1d1-2ef68e2c007mr18339007a91.18.1733737358684; Mon, 09 Dec 2024
 01:42:38 -0800 (PST)
MIME-Version: 1.0
References: <20241206094938.92895-1-pvorel@suse.cz>
 <20241206094938.92895-2-pvorel@suse.cz>
In-Reply-To: <20241206094938.92895-2-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Mon, 9 Dec 2024 17:42:26 +0800
Message-ID: <CAEemH2fC96s866abHj7mk315GBP3Y1c+uSC-NhuG7P5ia2obKA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: l0hBU-YS4MywqUqaAd-owtbQvNyL6TLGtpzmlHRPbIA_1733737361
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/4] testcases/lib/run_tests.sh: Check expected
 results
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

T24gRnJpLCBEZWMgNiwgMjAyNCBhdCA1OjUw4oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgoKPiBUaGlzIHZlcmlmaWNhdGlvbiBoZWxwcyAxKSBzZWUgaWYgYW55dGhpbmcg
YnJva2UgMikgYmUgYWJsZSB0byBydW4gaW4gQ0kuCj4KPiBBbHNvOgo+IDEpIEFsbG93IHRvIHJ1
biB0ZXN0cyBvdXRzaWRlIG9mIHRoZSB0ZXN0IGRpcmVjdG9yeSAoY2FsbCBqdXN0IGJ5Cj4gcmVs
YXRpdmUgUEFUSCkuCj4gMikgQWxsb3cgdG8gcGFzcyBidWlsZCBkaXJlY3RvcnkgKHVzZWZ1bCBm
b3Igb3V0IG9mIHRyZWUgYnVpbGQpLgo+IDMpIEFsbG93IHRvIHNraXAgdGVzdHMgKHVzZWZ1bCBm
b3IgZ2l0aHViIENJKS4KPgo+IHNoZWxsX2xvYWRlcl9hbGxfZmlsZXN5c3RlbXMuc2ggc2hlbGxf
bG9hZGVyX3N1cHBvcnRlZF9hcmNocy5zaAo+IHNoZWxsX2xvYWRlcl9maWxlc3lzdGVtcy5zaCBm
YWlscyBvbiBHaXRodWIgQWN0aW9ucyBkdWUgYnJva2VuIGxvb3AKPiBkZXZpY2UgdGhlcmVmb3Jl
IHNraXAgdGhlbToKPgo+IHRzdF90bXBkaXIuYzozMTc6IFRJTkZPOiBVc2luZyAvdG1wL0xUUF9z
aGVIdE52NVIgYXMgdG1wZGlyIChvdmVybGF5ZnMKPiBmaWxlc3lzdGVtKQo+IHRzdF9kZXZpY2Uu
YzoxNDc6IFRJTkZPOiBObyBmcmVlIGRldmljZXMgZm91bmQKPiB0c3RfZGV2aWNlLmM6MzYwOiBU
QlJPSzogRmFpbGVkIHRvIGFjcXVpcmUgZGV2aWNlCj4KPiBTaWduZWQtb2ZmLWJ5OiBQZXRyIFZv
cmVsIDxwdm9yZWxAc3VzZS5jej4KPiAtLS0KPiBOT1RFOiBpdCdzIG5vdCBwZXJmZWN0ICh3ZSBj
b3VsZCBmaW5hbGx5IGFkZCBjaGVjayB3aGljaCBjb21wYXJlcyB3aG9sZQo+IG91dHB1dCksIGJ1
dCBjaGVja2luZyBleGl0IGNvZGUgaXMgYmV0dGVyIHRoYW4gbm90aGluZy4KPgo+IGxpYi9uZXds
aWJfdGVzdHMvcnVudGVzdC5zaCB1c2VzIGEgZGlmZmVyZW50IGFwcHJvYWNoLCBidXQgSSBkaWQg
bm90Cj4gYm90aGVyIHRyeWluZyB0byB1bmlmeSB0aGVtLiBCdXQgaXQgd291bGQgYmUgd29ydGgg
dG8gYWRkIHN1cHBvcnQgZm9yCj4gdGVzdHMgd2hpY2ggVEJST0sgb24gR2l0SHViIGFsc28gdG8g
bGliL25ld2xpYl90ZXN0cy9ydW50ZXN0LnNoLiBUaGF0Cj4gYWxsb3dzIHVzIHRvIGVhc2lseSBy
dW4gJ21ha2UgdGVzdCcgbG9jYWxseSB0byBnZXQgaGlnaGVyIGNvdmVyYWdlIChlLmcuCj4gYmVm
b3JlIHRoZSByZWxlYXNlKS4KPgo+ICB0ZXN0Y2FzZXMvbGliL3J1bl90ZXN0cy5zaCB8IDExNSAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA5
NSBpbnNlcnRpb25zKCspLCAyMCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS90ZXN0Y2Fz
ZXMvbGliL3J1bl90ZXN0cy5zaCBiL3Rlc3RjYXNlcy9saWIvcnVuX3Rlc3RzLnNoCj4gaW5kZXgg
NDBkNDE1ZTZjNC4uMzgwODcwYWU1NSAxMDA3NTUKPiAtLS0gYS90ZXN0Y2FzZXMvbGliL3J1bl90
ZXN0cy5zaAo+ICsrKyBiL3Rlc3RjYXNlcy9saWIvcnVuX3Rlc3RzLnNoCj4gQEAgLTEsMzIgKzEs
MTA3IEBACj4gICMhL2Jpbi9zaAo+Cj4gLXRlc3RkaXI9JChyZWFscGF0aCAkKGRpcm5hbWUgJDAp
KQo+IC1leHBvcnQgUEFUSD0iJFBBVEg6JHRlc3RkaXI6JHRlc3RkaXIvdGVzdHMvIgo+IC0KPiAt
Zm9yIGkgaW4gYHNlcSAtdyAwMSAwNmA7IGRvCj4gLSAgICAgICBlY2hvCj4gLSAgICAgICBlY2hv
ICIqKiogUnVubmluZyBzaGVsbF90ZXN0JGkgKioqIgo+IC0gICAgICAgZWNobwo+IC0gICAgICAg
Li90ZXN0cy9zaGVsbF90ZXN0JGkKPiAtZG9uZQo+ICtURVNUU19QQVNTPSJzaGVsbF90ZXN0MDEg
c2hlbGxfdGVzdDAyIHNoZWxsX3Rlc3QwMyBzaGVsbF90ZXN0MDQKPiBzaGVsbF90ZXN0MDUKPiAr
c2hlbGxfbG9hZGVyLnNoIHNoZWxsX2xvYWRlcl90Y250LnNoIHNoZWxsX2xvYWRlcl9jX2NoaWxk
LnNoIgo+ICsKPiArVEVTVFNfUEFTU19HSVRIVUJfVEJST0s9InNoZWxsX2xvYWRlcl9hbGxfZmls
ZXN5c3RlbXMuc2gKPiBzaGVsbF9sb2FkZXJfc3VwcG9ydGVkX2FyY2hzLnNoIHNoZWxsX2xvYWRl
cl9maWxlc3lzdGVtcy5zaAo+IHNoZWxsX2xvYWRlcl9rY29uZmlncy5zaCIKPiArCj4gK1RFU1RT
X0ZBSUw9InNoZWxsX2xvYWRlcl90YWdzLnNoIgo+ICsKPiArVEVTVFNfVEJST0s9InNoZWxsX2xv
YWRlcl93cm9uZ19tZXRhZGF0YS5zaCBzaGVsbF9sb2FkZXJfbm9fbWV0YWRhdGEuc2gKPiArc2hl
bGxfbG9hZGVyX2ludmFsaWRfbWV0YWRhdGEuc2ggc2hlbGxfbG9hZGVyX2ludmFsaWRfYmxvY2su
c2giCj4gKwo+ICtURVNUU19UQ09ORj0ic2hlbGxfdGVzdDA2Igo+Cj4gLWZvciBpIGluIHNoZWxs
X2xvYWRlci5zaCBzaGVsbF9sb2FkZXJfYWxsX2ZpbGVzeXN0ZW1zLnNoCj4gc2hlbGxfbG9hZGVy
X25vX21ldGFkYXRhLnNoIFwKPiAtICAgICAgICBzaGVsbF9sb2FkZXJfd3JvbmdfbWV0YWRhdGEu
c2ggc2hlbGxfbG9hZGVyX2ludmFsaWRfbWV0YWRhdGEuc2hcCj4gLSAgICAgICAgc2hlbGxfbG9h
ZGVyX3N1cHBvcnRlZF9hcmNocy5zaCBzaGVsbF9sb2FkZXJfZmlsZXN5c3RlbXMuc2hcCj4gLSAg
ICAgICAgc2hlbGxfbG9hZGVyX3RjbnQuc2ggc2hlbGxfbG9hZGVyX2tjb25maWdzLnNoCj4gc2hl
bGxfbG9hZGVyX3RhZ3Muc2ggXAo+IC0gICAgICAgIHNoZWxsX2xvYWRlcl9pbnZhbGlkX2Jsb2Nr
LnNoIHNoZWxsX2xvYWRlcl9jX2NoaWxkLnNoOyBkbwo+IC0gICAgICAgZWNobwo+IC0gICAgICAg
ZWNobyAiKioqIFJ1bm5pbmcgJGkgKioqIgo+IC0gICAgICAgZWNobwo+IC0gICAgICAgJGkKPiAr
U0tJUF9HSVRIVUI9Cj4gK0ZBSUw9Cj4gKwo+ICtzcmNkaXI9IiQocmVhbHBhdGggJChkaXJuYW1l
ICQwKSkiCj4gK2J1aWxkZGlyPSIkc3JjZGlyIgo+ICsKPiArdXNhZ2UoKQo+ICt7Cj4gKyAgICAg
ICBjYXQgPDwgRU9GCj4gK1VzYWdlOiAkMCBbLWIgRElSIF0gWy1zIFRFU1RTXQo+ICstYiBESVIg
ICBidWlsZCBkaXJlY3RvcnkgKHJlcXVpcmVkIGZvciBvdXQtb2YtdHJlZSBidWlsZCkKPiArLWgg
ICAgICAgcHJpbnQgdGhpcyBoZWxwCj4gK0VPRgo+ICt9Cj4gKwo+ICt3aGlsZSBnZXRvcHRzIGI6
aCBvcHQ7IGRvCj4gKyAgICAgICBjYXNlICRvcHQgaW4KPiArICAgICAgICAgICAgICAgJ2gnKSB1
c2FnZTsgZXhpdCAwOzsKPiArICAgICAgICAgICAgICAgJ2InKQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgIGJ1aWxkZGlyPSIkT1BUQVJHL3Rlc3RjYXNlcy9saWIvIgo+ICsgICAgICAgICAgICAg
ICAgICAgICAgIGlmIFsgISAtZCAiJGJ1aWxkZGlyIiBdOyB0aGVuCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBlY2hvICJkaXJlY3RvcnkgJyRidWlsZGRpcicgZG9lcyBub3QKPiBl
eGlzdCEiID4mMgo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZXhpdCAxCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgZmkKPiArICAgICAgICAgICAgICAgICAgICAgICA7Owo+ICsg
ICAgICAgICAgICAgICAqKSB1c2FnZTsgcnVudGVzdF9icmsgVEJST0sgIkVycm9yOiBpbnZhbGlk
IG9wdGlvbiI7Owo+ICsgICAgICAgZXNhYwo+ICBkb25lCj4KPiArIyBzcmNkaXIgaXMgZm9yICou
c2gsIGJ1aWxkZGlyIGZvciAqLmMKPiArZXhwb3J0IFBBVEg9IiRQQVRIOiRzcmNkaXI6JGJ1aWxk
ZGlyOiRzcmNkaXIvdGVzdHMvOiRidWlsZGRpci90ZXN0cy8iCj4gKwo+ICsKPiArdHN0X21hc2sy
ZmxhZygpCj4gK3sKPiArICAgICAgIGNhc2UgIiQxIiBpbgo+ICsgICAgICAgMCkgZWNobyBUUEFT
Uzs7Cj4gKyAgICAgICAxKSBlY2hvIFRGQUlMOzsKPiArICAgICAgIDIpIGVjaG8gVEJST0s7Owo+
ICsgICAgICAgNCkgZWNobyBUV0FSTjs7Cj4gKyAgICAgICAxNikgZWNobyBUSU5GTzs7Cj4gKyAg
ICAgICAzMikgZWNobyBUQ09ORjs7Cj4gKyAgICAgICBlc2FjCj4gK30KPiArCj4gK3J1bl90ZXN0
cygpCj4gK3sKPiArICAgICAgIGxvY2FsIGV4cD0iJDEiCj4gKyAgICAgICBsb2NhbCB0ZXN0IHJj
Cj4gKyAgICAgICBzaGlmdAo+ICsKPiArICAgICAgIGZvciB0ZXN0IGluICIkQCI7IGRvCj4KCldl
IGNvdWxkIGFkZCBhIGJsYW5rIGxpbmUgcHJpbnQgaGVyZSB0byBtYWtlIHRoZSBvdXRwdXQgYmV0
dGVyIHJlYWRhYmxlLgoKICBlY2hvICIiCgorICAgICAgICAgICAgICAgZWNobyAiKioqIFJ1bm5p
bmcgJyR0ZXN0JyAoZXhwOiAkKHRzdF9tYXNrMmZsYWcgJGV4cCkpICoqKiIKPgoKCj4gKyAgICAg
ICAgICAgICAgICR0ZXN0Cj4gKyAgICAgICAgICAgICAgIHJjPSQ/Cj4gKyAgICAgICAgICAgICAg
IGlmIFsgJHJjID0gMTI3IF07IHRoZW4KPiArICAgICAgICAgICAgICAgICAgICAgICBlY2hvICJU
ZXN0ICckdGVzdCcgbm90IGZvdW5kLCBtYXliZSBvdXQtb2YtdHJlZQo+IGJ1aWxkIGFuZCB1bnNl
dCBidWlsZGRpcj8iID4mMgo+ICsgICAgICAgICAgICAgICAgICAgICAgIGV4aXQgMQo+ICsgICAg
ICAgICAgICAgICBlbGlmIFsgJHJjID0gMiAtYSAkV0hJVEVMSVNUX0dJVEhVQiA9IDEgLWEKPiAi
JEdJVEhVQl9BQ1RJT05TIiBdOyB0aGVuCj4KCklmIG9uZSBvciBtb3JlIHZhcmlhYmxlcyB1c2Vk
IGluIHRoZSBjb25kaXRpb25hbCB0ZXN0IGFyZQplaXRoZXIgdW5zZXQgb3IgZW1wdHksIHRoYXQg
d2lsbCBsZWFkIHRvIGludmFsaWQgc3ludGF4LgoKU28gSSB3b3VsZCBzdWdnZXN0IHVzaW5nIFsg
Li4uIF0gYW5kICYmOgoKICBlbGlmIFsgJHJjID0gMiBdICYmIFsgJFdISVRFTElTVF9HSVRIVUIg
PSAxIF0gJiYgWyAtbiAiJEdJVEhVQl9BQ1RJT05TIgpdOyB0aGVuCgoKVGhlIHdob2xlIHBhdGNo
c2V0IGFuZCBDSSBqb2IgYWxsIGxvb2sgZ29vZC4KQ0k6Cmh0dHBzOi8vZ2l0aHViLmNvbS93YW5n
bGk1NjY1L2x0cC9hY3Rpb25zL3J1bnMvMTIyMzI3NjQ4MDUvam9iLzM0MTE4NDgzMzY5CgpSZXZp
ZXdlZC1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+CgoKLS0gClJlZ2FyZHMsCkxpIFdh
bmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5m
by9sdHAK
