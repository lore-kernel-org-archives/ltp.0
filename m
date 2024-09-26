Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C0ECCFA13
	for <ltp@archiver.kernel.org>; Thu, 26 Sep 2024 07:48:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9E9F43C4E3B
	for <ltp@archiver.kernel.org>; Thu, 26 Sep 2024 09:48:15 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D8EBD3C02D9
 for <ltp@lists.linux.it>; Thu, 26 Sep 2024 09:47:59 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 020651400276
 for <ltp@lists.linux.it>; Thu, 26 Sep 2024 09:47:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727336876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lwW7TbDLIONmTXNDeKheiis4hCcc08yhZx+1UNyKOLA=;
 b=aDYI7Zad/BxoDaIsq35jQ80b/bkT0jA/gefU/sRgBOarYnOe35Vjh55wMEm4jIeiEG35Le
 upuRCv2yVNkdJy3YHN/iPQc666rvmOXcI1Cuj6SigvUCSwHrFV1psb+8GlYtmljZc8Q6Va
 H7HmL8345PDodbRQC8IBtSRPM51vkCQ=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588--vj2s34ZOSK6ONf0I-_1RA-1; Thu, 26 Sep 2024 03:47:54 -0400
X-MC-Unique: -vj2s34ZOSK6ONf0I-_1RA-1
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-710e6266023so531374a34.2
 for <ltp@lists.linux.it>; Thu, 26 Sep 2024 00:47:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727336873; x=1727941673;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lwW7TbDLIONmTXNDeKheiis4hCcc08yhZx+1UNyKOLA=;
 b=Hnl+Q/SANgaXK5NS4fyV/6260JP5bc0YhtA2SN6KjECS4UhYrnVjJjI6lc29dAQDLb
 fpjKLw9xJeMrxM6z+EZ8wm+PehioYeoXPYQPSjwmeDxSZeEgpujgJMvvLD/s4lAvPBZ0
 MNi09Il5ErLDSjIJqAfCoBlfmaonm0dIzlH7acZXGu4WDqW8B0LCU4zQcJaoxWU1wBX/
 XBMt5sFN2BpH1aeMvcrpIa81td010MfRlm4EcPnsNB7Letknpvp3EYrQ4dzuROWkDvTx
 gl/D2CBeFut75zjgkNp4Qj2R7FyP2mUlTSRNQpUikfABNzMSyVmMfoYL0xv6NfDP6UYp
 OP/g==
X-Gm-Message-State: AOJu0YxfHjoR8PQfAIvnVSE/jLMwo6fLmHZRWzoZ3HriwwIgLwGJUlox
 z5De0Xo5riCS06dncRoCsEgxxpzTn1O64FC1LZ79t6vTscLmYlNMgKG/yufZ09n+jyGIMHKWWBq
 2NBI0Hqv1Jd+DztmXaUn1LKdUlxCY0I3EOlrQpudH8wZEY3vOypc0rKUPZopFOgdJlHS42eaWRo
 Q/T25N4XPB6kUFR4EiI3f8chU=
X-Received: by 2002:a05:6830:3498:b0:710:f3cb:5b91 with SMTP id
 46e09a7af769-713c7f44bd4mr4355313a34.21.1727336873618; 
 Thu, 26 Sep 2024 00:47:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtC259xrFT3F4RhMVps9raPKOTYwVnVq4cJiTKU85Ti2TS0uA9yz76Mo8wK+3I+66nTOGZhtCyFT1Wp3+xGP0=
X-Received: by 2002:a05:6830:3498:b0:710:f3cb:5b91 with SMTP id
 46e09a7af769-713c7f44bd4mr4355301a34.21.1727336873170; Thu, 26 Sep 2024
 00:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240924-generate_syscalls-v1-0-941507a9cdac@suse.com>
 <ff7c5d36-e2dc-47b6-aded-64ecf649d8a3@suse.com>
 <CAASaF6yUzHRxR8pvi0AXCYA6XqQHE8A1miqFLX88xYHMnwsq9A@mail.gmail.com>
 <98bdc518-be50-47d9-a6f9-5718217317c9@suse.com>
 <CAASaF6wYYSfjxgg2byVBDhqCpQs9-8ngJZv8LrrJiytPR2=+ag@mail.gmail.com>
 <5e157a19-8832-4531-b1b5-617f2a1044d5@suse.com>
In-Reply-To: <5e157a19-8832-4531-b1b5-617f2a1044d5@suse.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 26 Sep 2024 09:47:35 +0200
Message-ID: <CAASaF6zHWu3CwTGNyu+gGNeqE_58gCA1XeysO0hPBbr14DpCtQ@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/4] Automatically generate syscalls.h
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

T24gVGh1LCBTZXAgMjYsIDIwMjQgYXQgOTowN+KAr0FNIEFuZHJlYSBDZXJ2ZXNhdG8KPGFuZHJl
YS5jZXJ2ZXNhdG9Ac3VzZS5jb20+IHdyb3RlOgo+Cj4KPiBPbiA5LzI1LzI0IDIyOjAxLCBKYW4g
U3RhbmNlayB3cm90ZToKPiA+IE9uIFR1ZSwgU2VwIDI0LCAyMDI0IGF0IDM6MjTigK9QTSBBbmRy
ZWEgQ2VydmVzYXRvCj4gPiA8YW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbT4gd3JvdGU6Cj4gPj4K
PiA+PiBPbiA5LzI0LzI0IDE1OjE2LCBKYW4gU3RhbmNlayB3cm90ZToKPiA+Pj4gT24gVHVlLCBT
ZXAgMjQsIDIwMjQgYXQgMTA6NDbigK9BTSBBbmRyZWEgQ2VydmVzYXRvIHZpYSBsdHAKPiA+Pj4g
PGx0cEBsaXN0cy5saW51eC5pdD4gd3JvdGU6Cj4gPj4+PiBIaSEKPiA+Pj4+Cj4gPj4+PiBQbGVh
c2UgY29uc2lkZXIgdGhpcyBwYXRjaHNldCBhcyBhIGRyYWZ0IG9wZW4gZm9yIGRpc2N1c3Npb24u
Cj4gPj4+IEhhdmUgeW91IGNvbXBhcmVkIG9sZCBhbmQgbmV3IGRlZmluZXM/IEFyZSB0aGVyZSBh
bnkgZGlmZmVyZW5jZXMKPiA+Pj4gKG90aGVyIHRoYW4gYWRkaXRpb25zKT8KPiA+Pj4KPiA+PiBP
bmx5IGFkZGl0aW9ucywgYnV0IHRoaXMgaXMgYSBkcmFmdCB3b3JrIGFuZCBJJ20gc2VhcmNoaW5n
IGZvcgo+ID4+IGFsdGVybmF0aXZlIGlkZWFzIGFzIHdlbGwuCj4gPj4gRm9yIGV4YW1wbGUsIHRo
ZSBsaW1pdGF0aW9uIG9mIHRoaXMgYXBwcm9hY2ggaXMgdGhhdCBzeXNjYWxscy5oIGhhcyB0bwo+
ID4+IGJlIGdlbmVyYXRlZCBhbnl3YXkuCj4gPiBJIGd1ZXNzIGl0IHdvdWxkbid0IGJlIHRvbyBk
aWZmaWN1bHQgdG8gY2hhbmdlIHNjcmlwdCB0byBnZW5lcmF0ZSAuaW4KPiA+IGZpbGVzIGluc3Rl
YWQsIHJpZ2h0Pwo+IEknbSBhbHJlYWR5IGRvaW5nIGl0IGluIHRoZSBnZW5lcmF0ZV9zeXNjYWxs
cy5zaCBzY3JpcHQsIHNvIGl0J3MgcXVpdGUKPiBlYXN5LiBUaGUgcG9pbnQgaXMgaWYgd2Ugd2Fu
dCB0byBtYWtlIHRoaXMgZXh0cmEgc3RlcCwgYmVjYXVzZSBtYXliZSB3ZQo+IGNhbiBqdXN0IGRv
d25sb2FkIHRoZSB0YWJsZXMgYWxyZWFkeSBjcmVhdGVkIGJ5IHRoZSBzeXNjYWxscy10YWJsZQo+
IHByb2plY3QgYW5kIHdlIGhhdmUgLmluIGZpbGVzIGZvciBmcmVlLiBCdXQgdGhhdCBhcHByb2Fj
aCBoYXMgZG93bnNpZGVzCj4gb2YgY291cnNlLgo+ID4+IEF0IHRoZSBzYW1lIHRpbWUsIHdlIGhh
dmUgcHJvamVjdHMgbGlrZQo+ID4+IGh0dHBzOi8vZ2l0aHViLmNvbS9ocncvc3lzY2FsbHMtdGFi
bGUgKHRoYXQgaW5zcGlyZWQgbXkgc2NyaXB0KQo+ID4+IHByb3ZpZGluZyBweXRob24gYmluZGlu
Z3MgYW5kICptYXliZSogaXQgY291bGQgYmUgdXNlZCB0byBjcmVhdGUgYQo+ID4+IHB5dGhvbiBz
Y3JpcHQgd2hpY2ggZ2VuZXJhdGUgLmluIGZpbGVzIHdoZW4gdGhleSBuZWVkIHRvIGJlIHVwZGF0
ZWQuCj4gPiBweXRob24gZmVlbHMgbGlrZSBhbiBleHRyYSBzdGVwLCBzaW5jZSB3ZSBjb3VsZCBk
byBpdCBpbiBleGlzdGluZyBzaGVsbCBzY3JpcHQuCj4gPiBNYXliZSBzdG9yZSBhIGNvcHkgb2Yg
dXBkYXRlLXRhYmxlcy5zaCBpbiBMVFAgcmVwbywgYW5kIGFkZCBzb21lIHdyYXBwZXIKPiA+IHRv
IHByb3ZpZGUgY3JlYXRlX3RhYmxlc19mb3JfTFRQKCkgZnVuY3Rpb24gYW5kIGEgY2hlY2sgdG8g
cHJpbnQgd2FybmluZyBpZgo+ID4gb3JpZ2luYWwgZ2l0aHViIHByb2plY3QgY2hhbmdlcyB1cGRh
dGUtdGFibGVzLnNoLgo+ID4KPiA+IGNyZWF0ZV90YWJsZXNfZm9yX0xUUCgpIHdvdWxkIGdlbmVy
YXRlIC5pbiBmaWxlcyBhbmQgcmVzdCBjYW4gc3RheSBhcyBpdCBpcy4KPgo+IEkgd2FzIGFsc28g
dGhpbmtpbmcgdGhhdCBtYXliZSBpdCdzIGVub3VnaCB0byBoYXZlIDIgc2NyaXB0czogb25lIGZv
cgo+IHVwZGF0aW5nIHN5c2NhbGxzIC5pbiBmaWxlcyB3aGVuIG5lZWRlZCBhbmQgb25lIGZvciBt
ZXJnaW5nIHRoZW0uCj4KPiBUaGUgb25seSBwcm9ibGVtIEkgc2VlIGluIHRoaXMgYXBwcm9hY2gg
aXM6IHdoZW4gZG8gd2Ugd2FudCB0byB1cGRhdGUKPiB0YWJsZXM/IEl0IHdvdWxkIGJlIG5pY2Ug
dG8gZG8gdGhhdCBldmVyeSAuL2NvbmZpZ3VyZSAsIGJ1dCB0aGF0IHdvdWxkCj4gYmUgdG9vIG11
Y2ggYmVjYXVzZSBvZiBnaXQvY3VybCBkZXBlbmRlbmN5LgoKTFRQIGNhbiBydW4gaW4gbGFicyB3
aXRoIG5vIGV4dGVybmFsIG5ldHdvcmsgYWNjZXNzLCBzbyBJJ2QgYXZvaWQgYW55IGRvd25sb2Fk
CmFzIHBhcnQgb2YgY29uZmlndXJlLiBBbmQgaW4gdW5saWtlbHkgY2FzZSBnaXRodWIgcHJvamVj
dCBkaXNhcHBlYXJzCndlIHdvdWxkIGhhdmUKTFRQIHJlbGVhc2VzIG91dCB0aGVyZSB3aXRoIGJy
b2tlbiBjb25maWd1cmUuCgpMb29raW5nIGF0IGdpdCBsb2csIGluIGxhc3QgY291cGxlIHllYXJz
IHdlIHVwZGF0ZWQgc3lzY2FsbHMgbWF5YmUgMy00CnRpbWVzIGVhY2ggeWVhci4KSSB0aGluayBp
dCdzIGVub3VnaCB0byBoYXZlIGl0IGFzIGFuIGV4dHJhIHN0ZXAgd2hlbiB3ZSBuZWVkIHRvIHVw
ZGF0ZSBzeXNjYWxscy4KSSBzZWUgaXQgYXMgYSBoZWxwZXIgc2NyaXB0IHlvdSBydW4gdG8gcGF0
Y2ggLmluIGZpbGVzLiBFdmVuIGlmIHRoYXQKdXNlcyByZWFkaWx5IGF2YWlsYWJsZQp0YWJsZXMg
ZnJvbSBnaXRodWIgcHJvamVjdCwgaXQgd291bGQgc3RpbGwgYmUgYSBwYXRjaCB0aGF0IHBlb3Bs
ZSBjYW4KcmV2aWV3IGFuZCBzcG90CnBvdGVudGlhbCBpc3N1ZXMgKG9yaWdpbmF0aW5nIGZyb20g
c2NyaXB0IG9yIHRhYmxlcykuCgo+Cj4gPj4gRXRjLi4KPiA+Pgo+ID4+Pj4gQW5kcmVhCj4gPj4+
Pgo+ID4+Pj4gT24gOS8yNC8yNCAxMDowNiwgQW5kcmVhIENlcnZlc2F0byB3cm90ZToKPiA+Pj4+
PiBUaGUgcHJvYmxlbSB3ZSBoYXZlIGF0IHRoZSBtb21lbnQgaXMgdGhhdCBhbGwgc3lzY2FsbHMg
aW5wdXQgZmlsZXMgbXVzdAo+ID4+Pj4+IGJlIGNoYW5nZWQgYnkgaGFuZCBlYWNoIHRpbWUgd2Ug
bmVlZCB0byB0ZXN0IGEgbmV3IHN5c2NhbGwuIFRoZSBpZGVhIGlzCj4gPj4+Pj4gdG8gc2ltcGxp
ZnkgdGhpcyBwcm9jZXNzLCBwcm92aWRpbmcgYSBzY3JpcHQgdGhhdCBpcyBhYmxlIHRvIHJlYWQg
ZnJvbQo+ID4+Pj4+IGtlcm5lbCBzb3VyY2VzIGFuZCB0byBnZW5lcmF0ZSBhbGwgc3lzY2FsbHMg
ZmlsZXMgd2UgbmVlZC4KPiA+Pj4+Pgo+ID4+Pj4+IFRoaXMgaXMgZG9uZSBieSB0aGUgZ2VuZXJh
dGVfc3lzY2FsbHMuc2ggc2NyaXB0IHRoYXQgY2FuIGJlIHVzZWQgYXMKPiA+Pj4+PiBmb2xsb3dp
bmc6Cj4gPj4+Pj4KPiA+Pj4+PiAuL2dlbmVyYXRlX3N5c2NhbGxzLnNoIHBhdGgvdG8va2VybmVs
L3NvdXJjZSBwYXRoL3RvL3N5c2NhbGxzLmgKPiA+Pj4+Pgo+ID4+Pj4+IFRoaXMgYXBwcm9hY2gg
cmVxdWlyZXMgYSBjZXJ0YWluIHR5cGUgb2YgYXR0ZW50aW9uLCBkdWUgdG8gdGhlIGZhY3QgdGhh
dAo+ID4+Pj4+IHdlIG5lZWQgdG8gZ2VuZXJhdGUgc3lzY2FsbHMuaCBhdCBlYWNoIGtlcm5lbCB2
ZXJzaW9uLCBvciB3aGVuIG5ldwo+ID4+Pj4+IHN5c2NhbGxzIGhhdmUgYmVlbiBhZGRlZCBpbiB0
aGUga2VybmVsLgo+ID4+Pj4+Cj4gPj4+Pj4gU2lnbmVkLW9mZi1ieTogQW5kcmVhIENlcnZlc2F0
byA8YW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbT4KPiA+Pj4+PiAtLS0KPiA+Pj4+PiBBbmRyZWEg
Q2VydmVzYXRvICg0KToKPiA+Pj4+PiAgICAgICAgICBSZW5hbWUgc3lzY2FsbHMgb3JkZXIgZmls
ZSB0byBzdXBwb3J0ZWQtYXJjaC50eHQKPiA+Pj4+PiAgICAgICAgICBBZGQgc2NyaXB0IHRvIGdl
bmVyYXRlIHN5c2NhbGxzLmgKPiA+Pj4+PiAgICAgICAgICBEZXByZWNhdGUgb2xkIHN5c2NhbGxz
IGlucHV0IGZpbGVzCj4gPj4+Pj4gICAgICAgICAgU2F2ZSBzeXNjYWxscy5oIGluc2lkZSByZXBv
Cj4gPj4+Pj4KPiA+Pj4+PiAgICAgaW5jbHVkZS9sYXBpLy5naXRpZ25vcmUgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgICAgMSAtCj4gPj4+Pj4gICAgIGluY2x1ZGUvbGFwaS9zeXNjYWxs
cy5oICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMzQyNzIgKysrKysrKysrKysrKysrKysr
Kwo+ID4+Pj4+ICAgICBpbmNsdWRlL2xhcGkvc3lzY2FsbHMvYWFyY2g2NC5pbiAgICAgICAgICAg
ICAgICAgICB8ICAgMzA2IC0KPiA+Pj4+PiAgICAgaW5jbHVkZS9sYXBpL3N5c2NhbGxzL2FyYy5p
biAgICAgICAgICAgICAgICAgICAgICAgfCAgIDMyNSAtCj4gPj4+Pj4gICAgIGluY2x1ZGUvbGFw
aS9zeXNjYWxscy9hcm0uaW4gICAgICAgICAgICAgICAgICAgICAgIHwgICA0MDQgLQo+ID4+Pj4+
ICAgICBpbmNsdWRlL2xhcGkvc3lzY2FsbHMvYmxhY2tsaXN0LXN5c2NhbGxzLnR4dCAgICAgICB8
ICAgICA2ICsKPiA+Pj4+PiAgICAgaW5jbHVkZS9sYXBpL3N5c2NhbGxzL2dlbmVyYXRlX3N5c2Nh
bGxzLnNoICAgICAgICAgfCAgIDI5MiArCj4gPj4+Pj4gICAgIGluY2x1ZGUvbGFwaS9zeXNjYWxs
cy9ocHBhLmluICAgICAgICAgICAgICAgICAgICAgIHwgICAgNTIgLQo+ID4+Pj4+ICAgICBpbmNs
dWRlL2xhcGkvc3lzY2FsbHMvaTM4Ni5pbiAgICAgICAgICAgICAgICAgICAgICB8ICAgNDM5IC0K
PiA+Pj4+PiAgICAgaW5jbHVkZS9sYXBpL3N5c2NhbGxzL2lhNjQuaW4gICAgICAgICAgICAgICAg
ICAgICAgfCAgIDk1NiArLQo+ID4+Pj4+ICAgICBpbmNsdWRlL2xhcGkvc3lzY2FsbHMvbG9vbmdh
cmNoLmluICAgICAgICAgICAgICAgICB8ICAgMzEwIC0KPiA+Pj4+PiAgICAgaW5jbHVkZS9sYXBp
L3N5c2NhbGxzL21pcHNfbjMyLmluICAgICAgICAgICAgICAgICAgfCAgIDM3OSAtCj4gPj4+Pj4g
ICAgIGluY2x1ZGUvbGFwaS9zeXNjYWxscy9taXBzX242NC5pbiAgICAgICAgICAgICAgICAgIHwg
ICAzNTUgLQo+ID4+Pj4+ICAgICBpbmNsdWRlL2xhcGkvc3lzY2FsbHMvbWlwc19vMzIuaW4gICAg
ICAgICAgICAgICAgICB8ICAgNDI1IC0KPiA+Pj4+PiAgICAgaW5jbHVkZS9sYXBpL3N5c2NhbGxz
L3Bvd2VycGMuaW4gICAgICAgICAgICAgICAgICAgfCAgIDQzMiAtCj4gPj4+Pj4gICAgIGluY2x1
ZGUvbGFwaS9zeXNjYWxscy9wb3dlcnBjNjQuaW4gICAgICAgICAgICAgICAgIHwgICA0MzIgLQo+
ID4+Pj4+ICAgICBpbmNsdWRlL2xhcGkvc3lzY2FsbHMvcmVnZW4uc2ggICAgICAgICAgICAgICAg
ICAgICB8ICAgMTI5IC0KPiA+Pj4+PiAgICAgaW5jbHVkZS9sYXBpL3N5c2NhbGxzL3MzOTAuaW4g
ICAgICAgICAgICAgICAgICAgICAgfCAgIDQxOSAtCj4gPj4+Pj4gICAgIGluY2x1ZGUvbGFwaS9z
eXNjYWxscy9zMzkweC5pbiAgICAgICAgICAgICAgICAgICAgIHwgICAzNjcgLQo+ID4+Pj4+ICAg
ICBpbmNsdWRlL2xhcGkvc3lzY2FsbHMvc2guaW4gICAgICAgICAgICAgICAgICAgICAgICB8ICAg
NDEzIC0KPiA+Pj4+PiAgICAgaW5jbHVkZS9sYXBpL3N5c2NhbGxzL3NwYXJjLmluICAgICAgICAg
ICAgICAgICAgICAgfCAgIDQxOCAtCj4gPj4+Pj4gICAgIGluY2x1ZGUvbGFwaS9zeXNjYWxscy9z
cGFyYzY0LmluICAgICAgICAgICAgICAgICAgIHwgICAzODMgLQo+ID4+Pj4+ICAgICBpbmNsdWRl
L2xhcGkvc3lzY2FsbHMvc3RyaXBfc3lzY2FsbC5hd2sgICAgICAgICAgICB8ICAgIDE5IC0KPiA+
Pj4+PiAgICAgLi4uL2xhcGkvc3lzY2FsbHMve29yZGVyID0+IHN1cHBvcnRlZC1hcmNoLnR4dH0g
ICAgfCAgICAgMSAtCj4gPj4+Pj4gICAgIGluY2x1ZGUvbGFwaS9zeXNjYWxscy94ODZfNjQuaW4g
ICAgICAgICAgICAgICAgICAgIHwgICAzOTYgLQo+ID4+Pj4+ICAgICAyNSBmaWxlcyBjaGFuZ2Vk
LCAzNTE3NCBpbnNlcnRpb25zKCspLCA2NzU3IGRlbGV0aW9ucygtKQo+ID4+Pj4+IC0tLQo+ID4+
Pj4+IGJhc2UtY29tbWl0OiA5NjhlNjI0NWQ5M2JjOTE3MjNlNzIwODZhNzFlNmJjNTBmNDk1ZDBi
Cj4gPj4+Pj4gY2hhbmdlLWlkOiAyMDI0MDkyMy1nZW5lcmF0ZV9zeXNjYWxscy03ODBkYzIyMjdi
ZGIKPiA+Pj4+Pgo+ID4+Pj4+IEJlc3QgcmVnYXJkcywKPiA+Pj4+IC0tCj4gPj4+PiBNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAKPiA+Pj4+Cj4K
CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8v
bHRwCg==
