Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFEDBD2ECF7
	for <ltp@archiver.kernel.org>; Tue, 20 Jan 2026 12:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768913933; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=FCtsfxsUcy4LNX/7kDEyW+temY1585i8w4C4oA20iKU=;
 b=MixIsKlEEZ/a3BYQ1hs6mzXZzhkFyKkeluQoPTXUj4sC8T+6T0z+SvbEGzhf5HpdAJWks
 WsD4x0SkPWoPC8V9EF57w+2gB6nkwcX8SZuohOaF/jsr4PNhPl/nWwQLnM78z8FYWDbfh5w
 kPGYncjkSxX059xbJ8RR7h/kiz//QWQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4579E3CAF77
	for <ltp@archiver.kernel.org>; Tue, 20 Jan 2026 13:58:53 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF2423C196B
 for <ltp@lists.linux.it>; Tue, 20 Jan 2026 13:58:28 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1A27D600A81
 for <ltp@lists.linux.it>; Tue, 20 Jan 2026 13:58:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768913906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w6jdvZZuH+iPoaQ/SGeMXlOHknHXCYv98R5jA1+UeoE=;
 b=CoziJPKSZn/5ZSDPmGaT+Rm6t7lwrw9//Ews1a5/mMclMibW3Y0bD37VhIfSJwu8sg4ArZ
 HaeLhf47k+7vSNrTvntI9IXlo18vhHTl80rMvbW31PIU0m4MDtMRIClhBdyC2I8yAjl7cL
 yoAetxAcILHAFGmVHV5+ApdN5Hrjf9g=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-CtYeqnhJOm6ISnze8tpvFQ-1; Tue, 20 Jan 2026 07:58:25 -0500
X-MC-Unique: CtYeqnhJOm6ISnze8tpvFQ-1
X-Mimecast-MFC-AGG-ID: CtYeqnhJOm6ISnze8tpvFQ_1768913904
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2b6f335e94fso3690192eec.1
 for <ltp@lists.linux.it>; Tue, 20 Jan 2026 04:58:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768913902; x=1769518702;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w6jdvZZuH+iPoaQ/SGeMXlOHknHXCYv98R5jA1+UeoE=;
 b=gseGt8dP/fDmmKRiDuKoCeLVtaOHU3SnPFqVHSubvZt4IOD4wAqCpDnz+uMVLQgCfQ
 Er5ZOFZ1+erknYMgd5vois0arlPWYbzX5doQG2jjFe97Rz1Kv+1Nv3iOSwhVEYW9Uacs
 PabJFKcbFKLqfniJKUyiT7pCKNTZOyQIlaJCjiNDeilJdjmnF0VnGHWc/Z+cG57D+lOg
 m0JBTHARkBnR0XgHCAE4B+b/PR9p2uMke1R4S7eU/kBmp0D0Gl0Iz1jkll5P7tP5RWPS
 7M8Bue2LT0Edr6LmwYJzxyKxvym6+TQmnI0RyqGFaCiIvOxtQucBmTe55TcqXeL+pSUq
 nKiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUaZHml43hCnTKJVs06rzeRzc789/liERic2Hf3rHmiYuWqUxFwocnXA6zFetPyXSJ4BM=@lists.linux.it
X-Gm-Message-State: AOJu0YwrdF3hnLz0LXvVLR8GjOj2rBt0+8IFu2aIH5JfsZpozoTkUnnN
 +k32u+6X1j9OgMi+YxP0dx1Ia7KVOh4wVaAQQI4wYl+cIqMgqrgfvazjQNZE8vDW40tMuXNtNYD
 +4vFcf5TjVs+0v5qoQmPOiW/mLjFbtGA8FjMX/+xwCBVtuSuw3ir3J5nrA4bv64/K1EBAlmMTQ2
 bSys2/ipJViLAKF28a+LM11RIpTbp08l2nKxG2pw==
X-Gm-Gg: AZuq6aKNccpZQAMzObAEUaJEXRaxMN80vd8DluCPtN9hiA8nsJP27FzHI78UxKjlSE+
 Q9k7FLMqbsUQdXkTOx1cPijpagfX0WR5ZhdDWBwuuKPLTTD2VnGcHVINkq/7EXGNw/RWZCo6D0Q
 FOaaR54/2RxRopzzx017nUjJ1FI8m8++1NkC6RI2wCz6jFJXZKR+vWwnzBPxR50NyGXxk=
X-Received: by 2002:a05:7300:7c13:b0:2af:7ee:5300 with SMTP id
 5a478bee46e88-2b6b3f30eb7mr10779886eec.14.1768913900644; 
 Tue, 20 Jan 2026 04:58:20 -0800 (PST)
X-Received: by 2002:a05:7300:7c13:b0:2af:7ee:5300 with SMTP id
 5a478bee46e88-2b6b3f30eb7mr10779767eec.14.1768913897250; Tue, 20 Jan 2026
 04:58:17 -0800 (PST)
MIME-Version: 1.0
References: <aWmqFAzdtsR0t5aJ@autotest-wegao.qe.prg2.suse.org>
In-Reply-To: <aWmqFAzdtsR0t5aJ@autotest-wegao.qe.prg2.suse.org>
Date: Tue, 20 Jan 2026 20:58:05 +0800
X-Gm-Features: AZwV_QieYp1Zh4AkdIBtfLHph3hT6myf8EWBTQZouC1IgOjjD6BTt_mrh7hcn6o
Message-ID: <CAEemH2edx23hnGmxW=EsapU0cgESGt1mws+GC-yCHFSN3ZVp9Q@mail.gmail.com>
To: Wei Gao <wegao@suse.com>, Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: n44B3LN_yzsgtDaPk5kXflyTaH99DfeXnxmtFTDs86U_1768913904
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] clone10.c failed on 32bit compilation
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

V2VpIEdhbyA8d2VnYW9Ac3VzZS5jb20+IHdyb3RlOgoKPiBUcnkgZm9sbG93aW5nIHBhdGNoIGZp
cnNsdHkgc3RpbGwgZ290IEVJTlZBTCBzaW5jZSB0bHNfZGVzYy0+ZW50cnlfbnVtYmVyIHdpbGwg
YmUgLTEgc3RpbGwgZ28gc2FtZSBlcnJvci4KPgo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xhcGkv
dGxzLmggYi9pbmNsdWRlL2xhcGkvdGxzLmgKPiBpbmRleCBhMDY3ODcyZTAuLmFlZGM5MDdkOSAx
MDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xhcGkvdGxzLmgKPiArKysgYi9pbmNsdWRlL2xhcGkvdGxz
LmgKPiBAQCAtNzMsNiArNzMsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgaW5pdF90bHModm9pZCkK
PiAgICAgICAgIHRsc19kZXNjLT5saW1pdF9pbl9wYWdlcyA9IDA7Cj4gICAgICAgICB0bHNfZGVz
Yy0+c2VnX25vdF9wcmVzZW50ID0gMDsKPiAgICAgICAgIHRsc19kZXNjLT51c2VhYmxlID0gMTsK
PiArICAgICAgIHRsc19wdHIgPSB0bHNfZGVzYzsKPgo+ICAjZWxzZQo+ICAgICAgICAgdHN0X2Jy
ayhUQ09ORiwgIlVuc3VwcG9ydGVkIGFyY2hpdGVjdHVyZSBmb3IgVExTIik7Cj4KPiBzbyBpIHRy
eSB0byBjaGFuZ2UgZW50cnlfbnVtYmVyIHRvIGNvcnJlY3Qgb25lIGJhc2Uga2VybmVsIHNyYyBs
b2dpYy4KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9sYXBpL3Rscy5oIGIvaW5jbHVkZS9sYXBpL3Rs
cy5oCj4gaW5kZXggYTA2Nzg3MmUwLi45ZTY5MjQ0ZGEgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9s
YXBpL3Rscy5oCj4gKysrIGIvaW5jbHVkZS9sYXBpL3Rscy5oCj4gQEAgLTY0LDcgKzY0LDcgQEAg
c3RhdGljIGlubGluZSB2b2lkIGluaXRfdGxzKHZvaWQpCj4gICAgICAgICB0bHNfcHRyID0gYWxs
b2NhdGVfdGxzX2FyZWEoKTsKPiAgICAgICAgIHRsc19kZXNjID0gU0FGRV9NQUxMT0Moc2l6ZW9m
KCp0bHNfZGVzYykpOwo+ICAgICAgICAgbWVtc2V0KHRsc19kZXNjLCAwLCBzaXplb2YoKnRsc19k
ZXNjKSk7Cj4gLSAgICAgICB0bHNfZGVzYy0+ZW50cnlfbnVtYmVyID0gLTE7Cj4gKyAgICAgICB0
bHNfZGVzYy0+ZW50cnlfbnVtYmVyID0gMTM7Cj4gICAgICAgICB0bHNfZGVzYy0+YmFzZV9hZGRy
ID0gKHVuc2lnbmVkIGxvbmcpdGxzX3B0cjsKPiAgICAgICAgIHRsc19kZXNjLT5saW1pdCA9IFRM
U19TSVpFOwo+ICAgICAgICAgdGxzX2Rlc2MtPnNlZ18zMmJpdCA9IDE7Cj4KPiBOb3cgaSBnZXQg
Zm9sbG93aW5nIG91dHB1dCwgbm8gRUlOVkFMIG5vdyBidXQgaXQgc2VlbXMgY2hpbGQgYW5kIHBh
cmVudCBwb2ludCB0byBzYW1lIHRscyBhcmVhLgo+IHRzdF90bXBkaXIuYzozMTY6IFRJTkZPOiBV
c2luZyAvdG1wL0xUUF9jbG9hMjBhd3EgYXMgdG1wZGlyICh0bXBmcyBmaWxlc3lzdGVtKQo+IHRz
dF90ZXN0LmM6MjAyNTogVElORk86IExUUCB2ZXJzaW9uOiAyMDI1MDEzMC01NDYtZzEzZGJkODM4
Ywo+IHRzdF90ZXN0LmM6MjAyODogVElORk86IFRlc3RlZCBrZXJuZWw6IDYuMTkuMC1yYzUtZ2I3
MWU2MzVmZWVmYyAjMTEgU01QIFBSRUVNUFRfRFlOQU1JQyBUdWUgSmFuIDEzIDE2OjE2OjE1IENT
VCAyMDI2IHg4Nl82NAo+IHRzdF9rY29uZmlnLmM6NzE6IFRJTkZPOiBDb3VsZG4ndCBsb2NhdGUg
a2VybmVsIGNvbmZpZyEKPiB0c3RfdGVzdC5jOjE4NDY6IFRJTkZPOiBPdmVyYWxsIHRpbWVvdXQg
cGVyIHJ1biBpcyAwaCAwMG0gMzBzCj4gY2xvbmUxMC5jOjQ4OiBUSU5GTzogQ2hpbGQgKFBJRDog
NTI2MiwgVElEOiA1MjYzKTogVExTIHZhbHVlIHNldCB0bzogMTAxCj4gY2xvbmUxMC5jOjcyOiBU
RkFJTDogUGFyZW50IChQSUQ6IDUyNjIsIFRJRDogNTI2Mik6IFRMUyB2YWx1ZSBtaXNtYXRjaDog
Z290IDEwMSwgZXhwZWN0ZWQgMTAwCgpXZWxsLCB0aGlzIGluZGljYXRlcyB0aGF0IHRoZSBDaGls
ZCBkb2VzIG5vdCBzd2l0Y2ggdG8gaXRzZWxmIFRMUwpjb3JyZWN0bHksIHN0aWxsIHVzZSB0aGUg
cGFyZW50LCBhbmQgc28gdGhlICdfX3RocmVhZCB0bHNfdmFyJyB2YWx1ZQpnZXRzIG1vZGlmaWVk
LgoKV2l0aCB0d28gZGF5cyBvZiByZXNlYXJjaCwgSSByb3VnaGx5IGRyZXcgdGhlIHBpY3R1cmUg
b2YgdGhlIHBvc3NpYmxlCnJlYXNvbiBhcyBiZWxvdzoKClVzaW5nIGEgbmFrZWQgY2xvbmUoKSB0
byB2ZXJpZnkgdGhhdCBDTE9ORV9TRVRUTFMgaXMgdW5yZWxpYWJsZQp3aGVuIHJ1bm5pbmcgMzIt
Yml0IG9uIHg4Nl82NCwgc2luY2UgaTM4NiBUTFMgcmVxdWlyZXMgdHdvIHN0ZXBzOgp3cml0aW5n
IHRoZSBkZXNjcmlwdG9yIGFuZCBzd2l0Y2hpbmcgdGhlIHNlbGVjdG9yLCBidXQgQ0xPTkVfU0VU
VExTCm9ubHkgb3ZlcnJpZGVzIHRoZSBmb3JtZXI6CgpUaGlzIGlzIHRoZSBzaW1wbGlmaWVkIGNh
bGwgY2hhaW46CgprZXJuZWxfY2xvbmUoKQogICBjb3B5X3Byb2Nlc3MoKQogICAgICBjb3B5X3Ro
cmVhZCgpCiAgICAgICAgICBzZXRfbmV3X3RscygpCiAgICAgICAgICAgICBkb19zZXRfdGhyZWFk
X2FyZWEoKQoKSW4gY29weV90aHJlYWQoKSwgdGhlIGNoaWxk4oCZcyByZWdpc3RlciBmcmFtZSBp
cyBjb3BpZWQgZnJvbSB0aGUgcGFyZW50CipjaGlsZHJlZ3MgPSAqY3VycmVudF9wdF9yZWdzKCk7
IGFuZCBvbiB0aGUgMzItYml0IHNpZGUgaXQgYWxzbyBkb2VzCnNhdmVzZWdtZW50KGdzLCBwLT50
aHJlYWQuZ3MpOyBzYXZpbmcgdGhlIGN1cnJlbnQgJWdzIGludG8gdGhyZWFkX3N0cnVjdC4KClRv
Z2V0aGVyLCB0aGlzIG1lYW5zIHRoYXQgdW5sZXNzIHNvbWV0aGluZyBleHBsaWNpdGx5IG92ZXJ3
cml0ZXMgaXQgbGF0ZXIsCnRoZSBjaGlsZOKAmXMgaW5pdGlhbCAlZ3Mgc2VsZWN0b3IgaXMgaW5o
ZXJpdGVkIGZyb20gdGhlIHBhcmVudC4KCiAgaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGlu
dXgvdjYuMTgvc291cmNlL2FyY2gveDg2L2tlcm5lbC9wcm9jZXNzLmMjTDI0MwoKVGhlbiwgaW4g
ZG9fc2V0X3RocmVhZF9hcmVhKCksIHRoZSBrZXJuZWwgdXBkYXRlcyB0aGUgVExTIGRlc2NyaXB0
b3IKc2V0X3Rsc19kZXNjKHAsIGlkeCwgJmluZm8sIDEpOyBIb3dldmVyLCB3aGVuIChwICE9IGN1
cnJlbnQpLCB0aGUgeDg2XzMyIHBhdGgKZG9lcyBub3QgdXBkYXRlIG9yIHJlZnJlc2ggYW55IHNl
Z21lbnQgc2VsZWN0b3IuIFNvIGl0IHVwZGF0ZXMgdGhlIGRlc2NyaXB0b3IKYnV0IGRvZXMgbm90
IHN3aXRjaCB0aGUgY2hpbGTigJlzICVncyBzZWxlY3RvciB0byB0aGUgbmV3IG1vZGlmaWVkX3Nl
bC4KCiAgaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuMTgvc291cmNlL2FyY2gv
eDg2L2tlcm5lbC90bHMuYyNMMTUwCgpUaGVyZWZvcmUsIHJlbHlpbmcgb24gQ0xPTkVfU0VUVExT
IGFsb25lIGNhbiBsZWF2ZSB0aGUgY2hpbGQgZXhlY3V0aW5nCndpdGggdGhlIHBhcmVudOKAmXMg
JWdzIHNlbGVjdG9yLCBzbyBUTFMgYWNjZXNzZXMgc3RpbGwgcmVzb2x2ZSB0byB0aGUKb2xkIFRM
UyBiYXNlLgoKSW4gc3VtbWFyeSwgaWYgdGhpcyBhbmFseXNpcyBpcyBtYWtlIHNlbnNlLCB3ZSBu
ZWVkIHRvIGNvbmZpZ3VyZSB0aGUgVENPTkYKdGVzdCBicmFuY2ggc2tpcCBvbiBpMzg2LgoKLS0g
ClJlZ2FyZHMsCkxpIFdhbmcKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCg==
