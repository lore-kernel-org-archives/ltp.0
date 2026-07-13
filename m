Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C04C43458
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 12:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783946627; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=bfPPJ1ytLdywwas+szsOMFIX80yehzIjPIGEzK5iKhA=;
 b=O52p36yvgF7rzJhEuq8Eu7P+YBcVbZggyNuPPD4vHOyC1qigWo9+aRf1o5us96fUt7iMV
 h5YHlQJhHauvRrXDi7yyPsWoepLIRpPPVdy/XHbX2NpjxopnUVNF5JKWhRX8b8KhmYoTPe1
 RfGlbP2qvURbrfZbU2jiCQ2WGqFe8xY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3863D3E7FE9
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 14:43:47 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B75113E2A3D
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 14:43:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6E8781A00141
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 14:43:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783946601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AZi2kxg/HWvQPNa6EvDrJa6A5KIQ5JHWHGEm+EsVhxk=;
 b=ihIKxyqyUxNF9rOHnmwYpWBjis49wre1UYw7qzs7GcOs7JIVCc1ycP62Mjjj1SEOrKsjj3
 8YVwo27Aobl7xO+M6GUZvk8vjxVwZtc7cwdjXl87q5Ac/Kxt4q/RDgB88icfdDBV6dO7z8
 kODR3lIf09q+QlIr181DYMV3IaQB2og=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-WubVSMW8OXutaHnfUkWOzA-1; Mon, 13 Jul 2026 08:43:19 -0400
X-MC-Unique: WubVSMW8OXutaHnfUkWOzA-1
X-Mimecast-MFC-AGG-ID: WubVSMW8OXutaHnfUkWOzA_1783946599
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8f0f45415cfso51111566d6.2
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 05:43:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783946599; x=1784551399;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AZi2kxg/HWvQPNa6EvDrJa6A5KIQ5JHWHGEm+EsVhxk=;
 b=dp7xUbevfzV0ddnKqmCHQ6QMuXuhF2MKSGkoaHqEBKwcOf0Eyb1w/1lZf/5tfAbba4
 4KUGhl+oZb00msaLVcffeQM+J4ArtXzcfzYuJWLgGoFt8aRtoBG5ez0iRgV2VBawiHXz
 x1GMMZ7YLGB2fuj+VM0XyrpPoHJoXWlAERovP3jv1bQkRwdh95ITDW5BRdFq9TtyBPGA
 3s+NDw4/Ze6Pt7V9JVWju39LSywOD9C8SEuM2X3uZsLo3XKSFVBXGHr9iqwNDyyBbN5D
 71MgDrsDsyx63FT0PwllC0K/mTS/3XwtNcOscAUn0IIyCcAYK4if365gLDL3NRgmI1t5
 +Srw==
X-Gm-Message-State: AOJu0Yy8HIlV7d18D9nLZqzi9uRz71M5rwuEZYNo30MnHcygTv9FLKz0
 N8rpHfoMgrgfXF0hOJuJ6u+MxisnWWUAxxxO3QDXF27FzX63F2aHczivCjFQHE/Hvx/dBxfYRYv
 5IL7t9AyTzOBhi2tgqXO/LgsG0aei1z6enmolTWu2FRPwCNpwTJGTct39iXJwdqGF/gt3P8LTnA
 zp3559lNCoTse2pc3/YUOgvlwJncQ=
X-Gm-Gg: AfdE7cl5GEdOwZW3Ml0oD3pYyOrsQt9Y74eUk0YrUz3ODS7Rzc1R+sp0bEs/Jnjw6bm
 UZefMU3vSVRAyLQi7YMF4h4G+if/8ZSILJW5nteKgJ8rSI20zJwprqBn55Zyr6uk6c36Xq1P6ld
 daB3unBlFPklYNQhJWiZS7ghpC75v8LEwHgkAretBfaMY+ixWzR7NqE0le+lnfiCJ4vnM=
X-Received: by 2002:a05:6214:2387:b0:8ef:e3c9:533e with SMTP id
 6a1803df08f44-903ff761684mr98678606d6.9.1783946599256; 
 Mon, 13 Jul 2026 05:43:19 -0700 (PDT)
X-Received: by 2002:a05:6214:2387:b0:8ef:e3c9:533e with SMTP id
 6a1803df08f44-903ff761684mr98677966d6.9.1783946597941; Mon, 13 Jul 2026
 05:43:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260710143155.588390-1-sbertram@redhat.com>
 <6a54ab9c.25509765.3b629d.6f12@mx.google.com>
In-Reply-To: <6a54ab9c.25509765.3b629d.6f12@mx.google.com>
Date: Mon, 13 Jul 2026 08:43:07 -0400
X-Gm-Features: AUfX_mxyME9X30ppIZioG296-ODeOTRn_c6JkSOLZHyx0OqX9nHy5q7rnGNOjis
Message-ID: <CAD_=S2m-XRaiUKeAEwLW4Jw9w6=reFWYbPUAm7JfSmQ1ogbX5Q@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kCs0js4I1Zsl9uFJc9FYV6WMpn5EExcp3rsegIS7LFI_1783946599
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v1] pipe13: Scale child reap window with
 LTP_TIMEOUT_MUL
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
From: Stephen Bertram via ltp <ltp@lists.linux.it>
Reply-To: Stephen Bertram <sbertram@redhat.com>
Cc: Stephen Bertram via ltp <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQW5kcmVhLAoKV2hlbiBpc29sYXRlZCwgSSBjYW4gcmVwcm9kdWNlIHRoZSBpc3N1ZSwgYWx3
YXlzIHdpdGggdGhlIDEwMCBzY2VuYXJpbywgb24KYSBkZWJ1ZyBrZXJuZWwuIFRoZSBkZWJ1ZyBr
ZXJuZWwgSSB1c2UgaGFzIGxvY2tpbmcgYW5kIGttZW1sZWFrIGFjdGl2ZQp3aGljaCBzbG93cyBw
ZXJmb3JtYW5jZSBncmVhdGx5LgoKQXMgZm9yIHRoZSBzY2FsaW5nLCBMVFBfVElNRU9VVF9NVUwg
d2lsbCBhbGxvdyB1c2VycyB0byBzY2FsZSBsYXJnZXIgYXMKbmVlZGVkLCBzbyBJIGRvbid0IHRo
aW5rIHRoZSBpbml0aWFsIHRpbWUsIDFzLCBpcyBhbiBpc3N1ZSB3aXRoIHRoZQppbXBsZW1lbnRh
dGlvbi4gSXQga2VlcHMgaXQgYXMgYmVmb3JlLCB3aXRob3V0IHVzaW5nIHRoZSBtdWx0aXBsZSwg
YnV0IG5vdwphbGxvd3MgdXMgdG8gaW5jb3Jwb3JhdGUgdGhlIG11bHRpcGxlIGZvciBsb25nZXIg
d2FpdCB0aW1lcyBpZiBuZWVkZWQuIElmCnlvdSB0aGluayB3ZSBzaG91bGQgc3RhcnQgaGlnaGVy
IEkgY291bGQsIGJ1dCB3aGVuIEkgcnVuIHRoaXMgdGVzdCB3aXRob3V0CmV2ZW4gdXNpbmcgdGhl
IHZhcmlhYmxlIG11bHRpcGxpZXIsIGl0IHdvcmtzIGZpbmUgYmVjYXVzZQp0c3RfbXVsdGlwbHlf
dGltZW91dCBhbHNvIGFkZHMgYSA0eCBtdWx0aXBsZSBmb3IgZGVidWcga2VybmVscy4KClRoYW5r
IHlvdSBmb3IgdGhlIHN1Z2dlc3Rpb24gYW5kIEkgd2lsbCBtYWtlIGNoYW5nZXMgdG8gd29yawp3
aXRoIFRTVF9SRVRSWV9GTl9FWFBfQkFDS09GRigpLgoKdGhhbmtzLAoKc3RlcGhlbgpIZS9IaXMv
SGltCgoKT24gTW9uLCBKdWwgMTMsIDIwMjYgYXQgNToxMeKAr0FNIEFuZHJlYSBDZXJ2ZXNhdG8g
PGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20+Cndyb3RlOgoKPiBIaSBTdGVwaGVuLAo+Cj4gPiBU
aGUgcG9zdC1jbG9zZSB3YWl0IHVzZWQgYSBmaXhlZCAxMDAwMDAwIHVzIGNhcCBvbiBleHBvbmVu
dGlhbCBiYWNrb2ZmCj4gPiAofjUyNCBtcyB0b3RhbCkuIFNjYWxlIHRoYXQgY2FwIHdpdGggdHN0
X211bHRpcGx5X3RpbWVvdXQoKSBzbyBkZWJ1Zwo+ID4ga2VybmVscyBhbmQgTFRQX1RJTUVPVVRf
TVVMIGFwcGx5LCBmaXhpbmcgZmFpbHVyZXMgdW5kZXIgcGFyYWxsZWwKPiA+IEtpcmsgd29ya2Vy
cyB3aXRob3V0IGNoYW5naW5nIGRlZmF1bHQgYmVoYXZpb3Igb24gbm9uLWRlYnVnIHN5c3RlbXMu
Cj4gPgo+ID4gQmVmb3JlIChvbmx5IHdpdGggY2FzZSAxMDApOgo+ID4KPiA+IHBpcGUxMy5jOjUw
OiBUSU5GTzogQ3JlYXRpbmcgMTAwIGNoaWxkIHByb2Nlc3Nlcwo+ID4gcGlwZTEzLmM6ODE6IFRJ
TkZPOiBwaWQgNDM1MDA3IHN0aWxsIHNsZWVwcwo+ID4gLi4uCj4gPiBwaXBlMTMuYzo4MTogVElO
Rk86IHBpZCA0MzUzMDAgc3RpbGwgc2xlZXBzCj4gPiBwaXBlMTMuYzo4OTogVEZBSUw6IENsb3Nl
ZCBwaXBlIGRpZG4ndCB3YWtlIHVwIGV2ZXJ5b25lCj4gPiBUaGUgbGlzdCB2YXJpZWQgYnV0IHNv
bWV0aW1lcyB1cCB0byAyMCB3b3VsZCByZW1haW5lZCBhc2xlZXAuCj4gPgo+ID4gQWZ0ZXIgdXNp
bmcgdHN0X211bHRpcGx5X3RpbWVvdXQoKSwgdGVzdCBwYXNzZXMuCj4gPgo+ID4gVGhlIGZhaWx1
cmUgYmVmb3JlIHdvdWxkIGhhcHBlbiwgd2hlbiB1c2luZyA0IHBhcmFsZWxsIHdvcmtlcnMKPiA+
IG9uIGEgZGVidWcga2VybmVsLCBhYm91dCAxIHRvIDIgdGltZXMgd2hlbiBpdGVyYXRlZCA1IHRp
bWVzLgo+ID4gV2l0aCB0aGUgYWRkaXRpb24gb2YgdGhlIGZ1bmN0aW9uLCB1bmRlciB0aGUgc2Ft
ZSBjb25kaXRpb25zLAo+ID4gaXQgaGFzIG5vdCBmYWlsZWQgaW4gMTAwIGl0ZXJhdGlvbnMuCj4g
Pgo+ID4gU2lnbmVkLW9mZi1ieTogU3RlcGhlbiBCZXJ0cmFtIDxzYmVydHJhbUByZWRoYXQuY29t
Pgo+ID4gLS0tCj4gPiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9waXBlL3BpcGUxMy5jIHwg
MyArKy0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
Cj4gPgo+ID4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcGlwZS9waXBl
MTMuYwo+IGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9waXBlL3BpcGUxMy5jCj4gPiBpbmRl
eCA1ZDc2ZTFmMDAuLmNmMWNjYmNiYyAxMDA2NDQKPiA+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvcGlwZS9waXBlMTMuYwo+ID4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9waXBlL3BpcGUxMy5jCj4gPiBAQCAtNDQsNiArNDQsNyBAQCBzdGF0aWMgdm9pZCB2ZXJpZnlf
cGlwZSh1bnNpZ25lZCBpbnQgbikKPiA+ICAgICAgIGludCByZXQ7Cj4gPiAgICAgICB1bnNpZ25l
ZCBpbnQgaSwgY250ID0gMCwgc2xlZXBfdXMgPSAxLCBmYWlsID0gMDsKPiA+ICAgICAgIHVuc2ln
bmVkIGludCBjaGlsZF9udW0gPSB0Y2FzZXNbbl07Cj4gPiArICAgICB1bnNpZ25lZCBpbnQgc2xl
ZXBfdXNfY2FwID0gdHN0X211bHRpcGx5X3RpbWVvdXQoMTAwMCkgKiAxMDAwVTsKPgo+IEV2ZW4g
YmV0dGVyOiB3ZSBjYW4gY3JlYXRlIGEgZnVuY3Rpb24gdG8gcmVhcCBjaGlsZHJlbiBhbmQgdmVy
aWZ5Cj4gaWYgdGhleSBhcmUgY29tcGxldGVkIHdoaWxlIGNvdW50aW5nIHRoZW0uCj4gVGhlbiB3
ZSBjYW4gdXNlIFRTVF9SRVRSWV9GTl9FWFBfQkFDS09GRigpIG9uIGl0Lgo+Cj4gVGhlIHByb2Js
ZW0gaXMgdGhhdCB3ZSBhcmUgd2FpdGluZyBhIGZpeGVkIGFtb3VudCBvZiB0aW1lICh+MXMpIHRo
YXQKPiBpcyBub3QgZW5vdWdoIHdoZW4gc3lzdGVtIGlzIG92ZXJsb2FkZWQuCj4KPiBNb3N0IGxp
a2VseSwgd2hlbiB5b3UgYXJlIGNhbGxpbmcga2lyayBwYXJhbGxlbCBleGVjdXRpb24sIG90aGVy
IHRlc3RzCj4gYXJlIG92ZXJsb2FkaW5nIHRoZSBzeXN0ZW0gYW5kIHRoaXMgdGVzdCBmYWlscyBh
Y2NvcmRpbmdseS4KPgo+IFJlZ2FyZHMsCj4gLS0KPiBBbmRyZWEgQ2VydmVzYXRvCj4gU1VTRSBR
RSBBdXRvbWF0aW9uIEVuZ2luZWVyIExpbnV4Cj4gYW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbQo+
Cj4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5m
by9sdHAK
