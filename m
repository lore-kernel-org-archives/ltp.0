Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9EACD7876A
	for <ltp@archiver.kernel.org>; Fri, 19 Dec 2025 13:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1766149648; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=pqJUAcLPsdgDxRUOVibDBkl6LRZQFvSWXOCh41CIFhU=;
 b=dCMIMowp4SPfA76OMLhoKN5iwpUCtbeo7DalZoGdoiu282dCQNQlFX1Rp9VM8BG2zb3A0
 kL/QSuBAebVWtt6NNKa6HsyCFqDnduLu0eofQfMQ/g4G4OvnqSH/6nflJubId7Q803KAh5E
 RD1z0NsL29HJqlN21MaOT2PHmP7diPY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E33F3D0535
	for <ltp@archiver.kernel.org>; Fri, 19 Dec 2025 14:07:28 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F2DB3CB3C1
 for <ltp@lists.linux.it>; Fri, 19 Dec 2025 14:07:05 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2EC87140121C
 for <ltp@lists.linux.it>; Fri, 19 Dec 2025 14:07:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766149622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eVJoFwh6zRn4wLHcJcMeqJKoPOSpW0c/0u8aZpcJptI=;
 b=C3SvM2U3HEDdnCQggKuKRlGxDkCz7oAr0YaTBCRFFeYs2+or5uQbtTqMj0dHfJs/3MPK1F
 SMo6M1opvuURGuYtPoZEM9gFumb+WUR8ZoCHCwNV6qELwuvBLIKz37qeppdVgKuzEO+drZ
 q04e8NWpY+hpuX+/zfJQG38xh+RwemM=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-dnbW3UmQMdauw4faDiEaLw-1; Fri, 19 Dec 2025 08:07:01 -0500
X-MC-Unique: dnbW3UmQMdauw4faDiEaLw-1
X-Mimecast-MFC-AGG-ID: dnbW3UmQMdauw4faDiEaLw_1766149620
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-bc0de474d4eso3400449a12.0
 for <ltp@lists.linux.it>; Fri, 19 Dec 2025 05:07:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766149619; x=1766754419;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eVJoFwh6zRn4wLHcJcMeqJKoPOSpW0c/0u8aZpcJptI=;
 b=WCFKZVwmT3S44nMQJ/dUBsEA/Jn5mEqejHeuqzHxg2IdBekmg6hInQbWZw+fr6FOLi
 tlRSgw0wGxL4EeRbk/58WdiYDotmPusacRPLq0/W1+E8Zx3j1umn+Q/5bERXbh9mit9C
 LVUCOCc/4BBlum+Kl7TCtDaeK3mxDZX/7/AZCzEF6Po+tsULH+yIlBnC6rX27Z5MsFZh
 QRp3bykiCNNascd7a38rG7eDkaMvVme2sAmTZJFveYjGM/19J8CUxUbkyVlM6wg8U7Z1
 2vGIn2Y1aZ5BoK6Khv3uKLFx1GHIyCG9XxCZSO3P2nyXzU5llhFLaIyG3jD7eA4kGFTP
 ud8A==
X-Gm-Message-State: AOJu0Yz2e5lvKKk/mF22RHDs1Al29SutOHnVgkhAzIb/5lXlbufmO3Op
 GgF1g/Xor+r2KSh9FjhyQSdgJTpY1otb77s17TyH3K/SsARZ91wu0VLgsajb42RcZbMuWju1YXS
 fXzcSHj+wfa9GFosVEuDG56T4q9QeVh6sV+esNoI8m6ucNKnFfnrEN5hjIRVjgDNiNVwACnoQS7
 jVsDzY9BTIof6kcxgdr3WT/pjVe4kFh6DzLJOU9R3R
X-Gm-Gg: AY/fxX7+b4GQH7O4ZGlrsd7s0eqL3ue7fe7uoTrQIoml3/SJLeYqlFcxfkCOY9MP5En
 os3b+kb1T/eMdaciTtcunb6y4hARhSyqY85044Oi5ScXRuiJ6TDbRNzt6OFRv9HFfqmtGDa2F4D
 a70tKfQrbRKqTWZ+nwuqQi+4911lFD1qH+FL4qtOIZCOuULhamCtDulDmzb5SCVYVSIgI=
X-Received: by 2002:a05:7301:a2a:b0:2ae:5ba4:a8a6 with SMTP id
 5a478bee46e88-2b05ec909cdmr2325823eec.35.1766149619179; 
 Fri, 19 Dec 2025 05:06:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsQzxqae/ecnUKcHpAjRob+1xicoZM/b5EG/CjVCuxqb9E35bmXGyvA4kKr8i2WBij/8XJHwoHqjeco+mjFfY=
X-Received: by 2002:a05:7301:a2a:b0:2ae:5ba4:a8a6 with SMTP id
 5a478bee46e88-2b05ec909cdmr2325801eec.35.1766149618556; Fri, 19 Dec 2025
 05:06:58 -0800 (PST)
MIME-Version: 1.0
References: <20251219094219.151887-1-pvorel@suse.cz>
In-Reply-To: <20251219094219.151887-1-pvorel@suse.cz>
Date: Fri, 19 Dec 2025 21:06:46 +0800
X-Gm-Features: AQt7F2ofj9U31gGSDfvPsBtRg1ulmL4xeem5oy5g2HY7nAj1AQQ_wcXtld-Hbms
Message-ID: <CAEemH2eac_1G6jQCbOMPgCQtcTiDiYm92KBCgbf5m=84WqFZsQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _DAeJcoIDKibheMtrm0o_cW3EjsSNZY5nG_6VJlpe-c_1766149620
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v4 1/1] swapon03: Try to swapon() as many files
 until it fails
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
Cc: Michal Hocko <mhocko@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBEZWMgMTksIDIwMjUgYXQgNTo0MuKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gUHJldmlvdXNseSB0c3RfbWF4X3N3YXBmaWxlcygpIGhhZCBmaW5lIHR1
bmluZyBmb3IgYSBzcGVjaWZpYyBrZXJuZWwKPiB2ZXJzaW9uIHdoaWNoIHdhcyBmcmFnaWxlIGR1
ZSB2YXJpb3VzIGJhY2twb3J0cyBpbiBlbnRlcnByaXNlIGtlcm5lbHMuCj4KPiBMZXQncyB0cnkg
dG8gY3JlYXRlIGFuZCB1c2UgYXMgbWFueSBzd2FwIGZpbGVzIHVudGlsIHN3YXBvbigpIGZhaWxz
Lgo+IFRoZW4gY2hlY2sgZm9yIGV4cGVjdGVkIEVQRVJNLgo+Cj4gSXQgd2FzIHJlcXVpcmVkIHRv
IGluY3JlYXNlIGNtZF9idWZmZXIgc2l6ZSB0byBhdm9pZCBkaXJlY3RpdmUgb3V0cHV0Cj4gbWF5
IGJlIHRydW5jYXRlZCB3YXJuaW5nLgo+Cj4gU3VnZ2VzdGVkLWJ5OiBNaWNoYWwgSG9ja28gPG1o
b2Nrb0BzdXNlLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5j
ej4KPiAtLS0KPiBDaGFuZ2VzIHYzLT52NDoKPiAqIERvICpub3QqIHNraXAgdGVzdGluZyB3aGVu
IGV4cGVjdGVkIG1pbmltdW0gc3dhcCBmaWxlcyB3YXMgYWxyZWFkeQo+ICAgdXNlZCBpbiBTVVQg
KEN5cmlsKQo+ICogUmVuYW1lIHZhcmlhYmxlcyAoQ3lyaWwpCj4gKiBSdW4gdGVzdCBvbmx5IG9u
Y2UgKHJlbW92ZSAtaTIgZnJvbSBydW50ZXN0IGZpbGUpCj4KPiBMaW5rIHRvIHYzOgo+IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2x0cC8yMDI1MTExODE0MzYwNy40NTMwOC0zLXB2b3JlbEBzdXNl
LmN6Lwo+Cj4gaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L2x0cC9wYXRjaC8y
MDI1MTExODE0MzYwNy40NTMwOC0zLXB2b3JlbEBzdXNlLmN6Lwo+ICB0ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL3N3YXBvbi9zd2Fwb24wMy5jIHwgNDkgKysrKysrKysrKysrLS0tLS0tLS0tCj4g
IDEgZmlsZSBjaGFuZ2VkLCAyNyBpbnNlcnRpb25zKCspLCAyMiBkZWxldGlvbnMoLSkKPgo+IGRp
ZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N3YXBvbi9zd2Fwb24wMy5jCj4g
Yi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N3YXBvbi9zd2Fwb24wMy5jCj4gaW5kZXggYzAx
NGE0ODkxMi4uZThkY2ExZTI4MyAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL3N3YXBvbi9zd2Fwb24wMy5jCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9z
d2Fwb24vc3dhcG9uMDMuYwo+IEBAIC02LDkgKzYsMTIgQEAKPiAgICovCj4KPiAgLypcCj4gLSAq
IFRoaXMgdGVzdCBjYXNlIGNoZWNrcyB3aGV0aGVyIHN3YXBvbigyKSBzeXN0ZW0gY2FsbCByZXR1
cm5zOgo+ICsgKiBUZXN0IGNoZWNrcyB3aGV0aGVyIDptYW4yOmBzd2Fwb25gIHN5c3RlbSBjYWxs
IHJldHVybnMgRVBFUk0gd2hlbiB0aGUKPiBtYXhpbXVtCj4gKyAqIG51bWJlciBvZiBzd2FwIGZp
bGVzIGFyZSBhbHJlYWR5IGluIHVzZS4KPiAgICoKPiAtICogIC0gRVBFUk0gd2hlbiB0aGVyZSBh
cmUgbW9yZSB0aGFuIE1BWF9TV0FQRklMRVMgYWxyZWFkeSBpbiB1c2UuCj4gKyAqIE5PVEU6IHRl
c3QgZG9lcyBub3QgdHJ5IHRvIGNhbGN1bGF0ZSBNQVhfU1dBUEZJTEVTIGZyb20gdGhlIGludGVy
bmFsCj4gKyAqIGtlcm5lbCBpbXBsZW1lbnRhdGlvbiwgaW5zdGVhZCBtYWtlIHN1cmUgYXQgbGVh
c3QgMTUgc3dhcHMgd2VyZSBjcmVhdGVkCj4gKyAqIGJlZm9yZSB0aGUgbWF4aW11bSBvZiBzd2Fw
cyB3YXMgcmVhY2hlZC4KPiAgICovCj4KPiAgI2luY2x1ZGUgPHN0ZGlvLmg+Cj4gQEAgLTIwLDYg
KzIzLDEzIEBACj4gICNpbmNsdWRlICJsYXBpL3N5c2NhbGxzLmgiCj4gICNpbmNsdWRlICJsaWJz
d2FwLmgiCj4KPiArLyoKPiArICogTUFYX1NXQVBGSUxFUyBmcm9tIHRoZSBpbnRlcm5hbCBrZXJu
ZWwgaW1wbGVtZW50YXRpb24gaXMgY3VycmVudGx5Cj4gPDIzLCAyOT4sCj4gKyAqIGRlcGVuZGlu
ZyBvbiBrZXJuZWwgY29uZmlndXJhdGlvbiAoc2VlIG1hbiBzd2Fwb24oMikuIENob3NlIHNtYWxs
Cj4gZW5vdWdoCj4gKyAqIHZhbHVlIGZvciBmdXR1cmUgY2hhbmdlcy4KPiArICovCj4gKyNkZWZp
bmUgTUlOX1NXQVBfRklMRVMgMTUKPiArCj4gICNkZWZpbmUgTU5UUE9JTlQgICAgICAgIm1udHBv
aW50Igo+ICAjZGVmaW5lIFRFU1RfRklMRSAgICAgIE1OVFBPSU5UIi90ZXN0c3dhcCIKPgo+IEBA
IC0yNywzMSArMzcsMjggQEAgc3RhdGljIGludCBzd2FwZmlsZXM7Cj4KPiAgc3RhdGljIGludCBz
ZXR1cF9zd2FwKHZvaWQpCj4gIHsKPiAtICAgICAgIGludCBqLCBtYXhfc3dhcGZpbGVzLCB1c2Vk
X3N3YXBmaWxlczsKPiArICAgICAgIGludCB1c2VkX3N3YXBmaWxlcywgbWluX3N3YXBmaWxlczsK
PiAgICAgICAgIGNoYXIgZmlsZW5hbWVbRklMRU5BTUVfTUFYXTsKPgo+IC0gICAgICAgLyogRGV0
ZXJtaW5lIGhvdyBtYW55IG1vcmUgZmlsZXMgYXJlIHRvIGJlIGNyZWF0ZWQgKi8KPiAtICAgICAg
IG1heF9zd2FwZmlsZXMgPSB0c3RfbWF4X3N3YXBmaWxlcygpOwo+ICAgICAgICAgdXNlZF9zd2Fw
ZmlsZXMgPSB0c3RfY291bnRfc3dhcHMoKTsKPiAtICAgICAgIHN3YXBmaWxlcyA9IG1heF9zd2Fw
ZmlsZXMgLSB1c2VkX3N3YXBmaWxlczsKPiAtICAgICAgIGlmIChzd2FwZmlsZXMgPiBtYXhfc3dh
cGZpbGVzKQo+IC0gICAgICAgICAgICAgICBzd2FwZmlsZXMgPSBtYXhfc3dhcGZpbGVzOwo+IC0K
PiAtICAgICAgIC8qY3JlYXRlIGFuZCB0dXJuIG9uIHJlbWFpbmluZyBzd2FwZmlsZXMgKi8KPiAt
ICAgICAgIGZvciAoaiA9IDA7IGogPCBzd2FwZmlsZXM7IGorKykgewo+ICsgICAgICAgbWluX3N3
YXBmaWxlcyA9IE1JTl9TV0FQX0ZJTEVTIC0gdXNlZF9zd2FwZmlsZXM7Cj4KCkkgY2FuIGFzc3Vt
ZSBhIHBvdGVudGlhbCBpc3N1ZSBoZXJlIGlzOiBpZiBhIHRlc3Qgc3lzdGVtIGFscmVhZHkKY29u
dGFpbnMgc3dhcGZpbGVzIG1vcmUgdGhhbiBNSU5fU1dBUF9GSUxFUywgaGVyZSBtaW5fc3dhcGZp
bGUKd2lsbCBiZSBhIG5lZ2F0aXZlIHZhbHVlLgoKSXQgc291bmRzIHdlaXJkIHRvIG1vdW50IGEg
bmVnYXRpdmUgbnVtYmVyIG9mIGZpbGUgZm9yIHRlc3QuCgpXaGF0IGFib3V0OgoKbWluX3N3YXBm
aWxlcyA9IE1JTl9TV0FQX0ZJTEVTID4gdXNlZF9zd2FwZmlsZXMgPyBcCiAgICAgICAgICAgICAg
KE1JTl9TV0FQX0ZJTEVTIC0gdXNlZF9zd2FwZmlsZXMpIDogMDsKCgoKPgo+ICsgICAgICAgd2hp
bGUgKHRydWUpIHsKPgoKVGhlcmUgaXMgYW5vdGhlciBpc3N1ZSBpbiB0aGUgaW5maW5pdGUgbG9v
cCwgaWYgYSBrZXJuZWwgYnVnIG1ha2VzIG1vcmUKc3dhcGZpbGUgZG9lcyBub3QgcmV0dXJuIEVQ
RVJNIGJ1dCBhbnkgb3RoZXJzLCBoZXJlIG5vdCByZXBvcnQgZmFpbHVyZQphbmQgb25seSBrZWVw
IGxvb3BpbmcgZm9yZXZlci4KCk1heWJlIHdlIHNob3VsZCBzZXQgYSB1cGxpbWl0IChlLmcgTUFY
X1RSSUVTKSB0byBhdm9pZCB0aGF0IGhhcHBlbmluZy4KCiAgICAgICAgICAgICAgICAvKiBDcmVh
dGUgdGhlIHN3YXBmaWxlICovCj4gLSAgICAgICAgICAgICAgIHNucHJpbnRmKGZpbGVuYW1lLCBz
aXplb2YoZmlsZW5hbWUpLCAiJXMlMDJkIiwgVEVTVF9GSUxFLAo+IGogKyAyKTsKPiAtICAgICAg
ICAgICAgICAgU0FGRV9NQUtFX1NNQUxMX1NXQVBGSUxFKGZpbGVuYW1lKTsKPiArICAgICAgICAg
ICAgICAgc25wcmludGYoZmlsZW5hbWUsIHNpemVvZihmaWxlbmFtZSksICIlcyUwMmQiLCBURVNU
X0ZJTEUsCj4gc3dhcGZpbGVzKTsKPiArICAgICAgICAgICAgICAgTUFLRV9TTUFMTF9TV0FQRklM
RShmaWxlbmFtZSk7Cj4gKwo+ICsgICAgICAgICAgICAgICAvKiBRdWl0IG9uIGEgZmlyc3Qgc3dh
cCBmaWxlIG92ZXIgbWF4LCBjaGVjayBmb3IgRVBFUk0gKi8KPiArICAgICAgICAgICAgICAgaWYg
KHN3YXBvbihmaWxlbmFtZSwgMCkgPT0gLTEpIHsKPiArICAgICAgICAgICAgICAgICAgICAgICBp
ZiAoZXJybm8gPT0gRVBFUk0gJiYgc3dhcGZpbGVzID4gbWluX3N3YXBmaWxlcykKPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOwo+Cj4gLSAgICAgICAgICAgICAgIC8qIHR1
cm4gb24gdGhlIHN3YXAgZmlsZSAqLwo+IC0gICAgICAgICAgICAgICBUU1RfRVhQX1BBU1NfU0lM
RU5UKHN3YXBvbihmaWxlbmFtZSwgMCkpOwo+IC0gICAgICAgICAgICAgICBpZiAoIVRTVF9QQVNT
KQo+IC0gICAgICAgICAgICAgICAgICAgICAgIHRzdF9icmsoVEZBSUwsICJGYWlsZWQgdG8gc2V0
dXAgc3dhcCBmaWxlcyIpOwo+ICsgICAgICAgICAgICAgICAgICAgICAgIHRzdF9yZXMoVEZBSUwg
fCBURVJSTk8sICJzd2Fwb24oJXMsIDApIiwgZmlsZW5hbWUpOwo+ICsgICAgICAgICAgICAgICB9
Cj4gKyAgICAgICAgICAgICAgIHN3YXBmaWxlcysrOwo+ICAgICAgICAgfQo+Cj4gICAgICAgICB0
c3RfcmVzKFRJTkZPLCAiU3VjY2Vzc2Z1bGx5IGNyZWF0ZWQgJWQgc3dhcCBmaWxlcyIsIHN3YXBm
aWxlcyk7Cj4gLSAgICAgICBNQUtFX1NNQUxMX1NXQVBGSUxFKFRFU1RfRklMRSk7Cj4KPiAgICAg
ICAgIHJldHVybiAwOwo+ICB9Cj4gQEAgLTYxLDcgKzY4LDcgQEAgc3RhdGljIGludCBzZXR1cF9z
d2FwKHZvaWQpCj4gICAqLwo+ICBzdGF0aWMgaW50IGNoZWNrX2FuZF9zd2Fwb2ZmKGNvbnN0IGNo
YXIgKmZpbGVuYW1lKQo+ICB7Cj4gLSAgICAgICBjaGFyIGNtZF9idWZmZXJbMjU2XTsKPiArICAg
ICAgIGNoYXIgY21kX2J1ZmZlcltGSUxFTkFNRV9NQVgrMjhdOwo+ICAgICAgICAgaW50IHJjID0g
LTE7Cj4KCkhlcmUgd2UnZCBiZXR0ZXIgaW5pdGlhbGl6ZSAncmMgPSAwJyB0aG91Z2ggdGhlIHJl
dHVybiB2YWx1ZSBpcyBub3QgdXNlZAphbnl3aGVyZS4KCgo+Cj4gICAgICAgICBzbnByaW50Zihj
bWRfYnVmZmVyLCBzaXplb2YoY21kX2J1ZmZlciksICJncmVwIC1xICclcy4qZmlsZScKPiAvcHJv
Yy9zd2FwcyIsIGZpbGVuYW1lKTsKPiBAQCAtODMsMTEgKzkwLDkgQEAgc3RhdGljIHZvaWQgY2xl
YW5fc3dhcCh2b2lkKQo+ICAgICAgICAgY2hhciBmaWxlbmFtZVtGSUxFTkFNRV9NQVhdOwo+Cj4g
ICAgICAgICBmb3IgKGogPSAwOyBqIDwgc3dhcGZpbGVzOyBqKyspIHsKPiAtICAgICAgICAgICAg
ICAgc25wcmludGYoZmlsZW5hbWUsIHNpemVvZihmaWxlbmFtZSksICIlcyUwMmQiLCBURVNUX0ZJ
TEUsCj4gaiArIDIpOwo+ICsgICAgICAgICAgICAgICBzbnByaW50ZihmaWxlbmFtZSwgc2l6ZW9m
KGZpbGVuYW1lKSwgIiVzJTAyZCIsIFRFU1RfRklMRSwKPiBqKTsKPiAgICAgICAgICAgICAgICAg
Y2hlY2tfYW5kX3N3YXBvZmYoZmlsZW5hbWUpOwo+ICAgICAgICAgfQo+IC0KPiAtICAgICAgIGNo
ZWNrX2FuZF9zd2Fwb2ZmKFRFU1RfRklMRSk7Cj4gIH0KPgo+ICBzdGF0aWMgdm9pZCB2ZXJpZnlf
c3dhcG9uKHZvaWQpCj4gLS0KPiAyLjUxLjAKPgo+CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0g
Ck1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
