Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3FCCCD1284
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 09:01:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 478E13C0970
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 11:01:37 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 142CD3CF7BF
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 11:01:21 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C5D7A100861C
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 11:01:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712826076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MTfpic8HTHNdiw1d523ApxZqUMkz5CGL/HK/E1jhU80=;
 b=iI1/8P/DpvxqFwlCSMqKu1YJH1d66sE5PvtXGcD1/H/fqni7PL3yharBMlf3EKE5fLBY4m
 VUMoG0P9IFOyiv4XVGMLXC+dHK5ME9j45WNHvNQjESCS/y/02fQLF62ckyWj3612ccx/FT
 ZPwz/Dx74cXWutSHzsfXqYGbL3MFU8Y=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-K0-fPTOJMwmy3kp9nIQ8Xg-1; Thu, 11 Apr 2024 05:01:13 -0400
X-MC-Unique: K0-fPTOJMwmy3kp9nIQ8Xg-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2a4f59746f7so3679825a91.1
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 02:01:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712826073; x=1713430873;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MTfpic8HTHNdiw1d523ApxZqUMkz5CGL/HK/E1jhU80=;
 b=KVgGyEFArHl2tkRW1uaTqb0pwFh66rhj/7Zw9AaIbzlbQYqnjt3K4vcWMpL8AHUcyC
 B6eOh+IYnJqZ9dE6Poi6uedfNE2Xm5ww2kMP7KvsRKSpkuMP+dEB85FLTBasj8459CIa
 KPCCkpK1rRtNnA6dZwikYIR8LpWkcW1oe7kFqla3VzBH7KlzVcW+9NR+bK4FH0PfhY6v
 M0Tai+EQDmbbAOguTS0CtQGvGZI+yqzSRx+AXgte1RjGgqktDOvlGEm/5wdW4IT73vhf
 fvrs49QANTdY7Jxv/UbfzKW82RTsP1ihLV9Nu5IA3ietXEGpKzSD20PY/pb2ZbL0uGLw
 g9iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlsgcRM0/Xxqnq9iXu9CnO28XV5k94AhA1/ae/PfPOr8N4Bdf42pMMJ61VGI6M0WsYulifoCWObOqXzKeko+dmEII=
X-Gm-Message-State: AOJu0YzElm4G3Dpj/NRusBjQKcvJ/DrFj9UYZgSSjhSLWbPtDsUG0GpW
 Qnot1Y7J4hIZdZ2MgQojF/hJL4FBdWaJesRC2yF9NgkJm4vDG2LtreXXk9qtByNSoSDs4lhpoRI
 m8Wg15FaPs3yoSiWroDucNh2u/9MBw7Dd1f1RaTDao1tw3xrPiJdVuPlEEFOaJK46FF3iaC52cL
 aUZa0J4Qk7pdv6HEPo2KZRbsc=
X-Received: by 2002:a17:90b:46d0:b0:2a1:fa5b:106 with SMTP id
 jx16-20020a17090b46d000b002a1fa5b0106mr4501546pjb.30.1712826072692; 
 Thu, 11 Apr 2024 02:01:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVmoCcJy0iSBePoqfYfya4GEZLUZt6BPYu0PNZYCI+Qoia51YFeDbtgmb6AKsh1I19UDRtRqzcrTwYYSSBq5U=
X-Received: by 2002:a17:90b:46d0:b0:2a1:fa5b:106 with SMTP id
 jx16-20020a17090b46d000b002a1fa5b0106mr4501516pjb.30.1712826072257; Thu, 11
 Apr 2024 02:01:12 -0700 (PDT)
MIME-Version: 1.0
References: <6868ae95-b004-4fb2-8aac-7ccf96b32f90@suse.com>
 <CAEemH2eDT6gN3hw=Lz2qgnwFnnHmNYai9tqbKduSkcWfNjpERQ@mail.gmail.com>
 <20240410101225.GA187895@pevik>
In-Reply-To: <20240410101225.GA187895@pevik>
From: Li Wang <liwang@redhat.com>
Date: Thu, 11 Apr 2024 17:00:59 +0800
Message-ID: <CAEemH2e7GAQmdkcu0p3p=4Hequ4nck2+ECeSfMYpXSpvKhqsDg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] New LTP documentation!
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwKCk9uIFdlZCwgQXByIDEwLCAyMDI0IGF0IDY6MTLigK9QTSBQZXRyIFZvcmVsIDxw
dm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+IEhpIGFsbCwKPgo+ID4gSGkgQW5kcmVhLAo+Cj4gPiBP
biBNb24sIE1hciAxOCwgMjAyNCBhdCA4OjQx4oCvUE0gQW5kcmVhIENlcnZlc2F0byB2aWEgbHRw
IDwKPiBsdHBAbGlzdHMubGludXguaXQ+Cj4gPiB3cm90ZToKPgo+ID4gPiBIZWxsbyBldmVyeW9u
ZSwKPgo+ID4gPiBhcyBhbHJlYWR5IG1lbnRpb25lZCBpbiB0aGUgbW9udGhseSBMVFAgbWVldGlu
ZywgTGludXggVGVzdCBQcm9qZWN0Cj4gPiA+IGxhY2tzIG9mIGEgbmljZSBhbmQgY2xlYW4gZG9j
dW1lbnRhdGlvbiB0aGF0IGNhbiBiZSBlYXNpbHkgYWNjZXNzZWQgYnkKPiA+ID4gdXNlcnMsIGRl
dmVsb3BlcnMgYW5kIG1haW50YWluZXJzLgo+ID4gPiBUaGUgY3VycmVudCBMVFAgZG9jdW1lbnRh
dGlvbiBpcyBhbHNvIG5vdCBtYXRjaGluZyB3aXRoIG91ciBleHBlY3RhbmN5Cj4gPiA+IHRvd2Fy
ZHMgdGhlIGVudGlyZSBwcm9qZWN0LCB3aGljaCBpcyBoYXMgYmVlbiBoZWF2aWx5IHJlZmFjdG9y
ZWQgYW5kIGl0Cj4gPiA+IGhhcyBjaGFuZ2VkIGluIHRoZSBwYXN0IHllYXJzLCBwcm92aWRpbmcg
YSBoaWdoZXIgcXVhbGl0eSBjb2RlIGFuZCBuZXcKPiA+ID4gdGVzdGluZyBmZWF0dXJlcy4KPgo+
ID4gPiBGb3IgdGhpcyByZWFzb25zLCB3ZSB0aGluayBpdCdzIHRpbWUgdG8gbW92ZSBmb3J3YXJk
IGFuZCB0byBzdGFydAo+ID4gPiB3b3JraW5nIG9uIGRvY3VtZW50YXRpb24sIGhlbHBpbmcgcGVv
cGxlIHRvIHVzZSwgdG8gZGV2ZWxvcCBhbmQgdG8KPiA+ID4gbWFpbnRhaW4gTFRQIGluIGFuIGVh
c2llciB3YXksIGluY3JlYXNpbmcgcXVhbGl0eSBvZiB0aGUgb3ZlcmFsbAo+IHByb2plY3QKPiA+
ID4gYW5kIHRvIGNhbGwgbW9yZSBkZXZlbG9wZXJzIGluIHRoZSBjb21tdW5pdHkuCj4KPiA+ID4g
SSBzdGFydGVkIHRvIHdvcmsgb24gZG9jdW1lbnRhdGlvbiByZWZhY3RvcmluZywgcmUtb3JnYW5p
emluZyB0aGUKPiA+ID4gb3ZlcmFsbCBzdHJ1Y3R1cmUuIFRoZSBmaXJzdCBwcm90b3R5cGUgY2Fu
IGJlIGZvdW5kIGhlcmU6Cj4KPiA+ID4gaHR0cHM6Ly9sdHAtYWNlcnYucmVhZHRoZWRvY3MuaW8v
ZW4vbGF0ZXN0L2luZGV4Lmh0bWwKPgo+Cj4gPiBMb29rcyBncmVhdCEgVGhhbmtzIGZvciBicmlu
Z2luZyB0aGlzLgo+Cj4gPiBBbmQgSSBqdXN0IHRyaWVkIHRoYXQgdGhlIGxhdGVzdCBMVFAgY29t
cGlsZWQgJiBleGVjdXRlZCBzdWNjZWVkIG9uCj4gPiBSSEVMLTcuOS4KPiA+IENhbiB5b3UgdXBk
YXRlIHRoZSAiT2xkZXN0IHRlc3RlZCBkaXN0cmlidXRpb25zIiBbMV0gcGFydCBieSBhZGRpbmc6
Cj4KPiA+ICAgUkhFTC03LjkgTWFpcG8gKERpc3RybykgIDMuMTAgKGtlcm5lbCkgIDQuOC41KGdj
YykgIDIuMTcoZ2xpYmMpCj4gLShjbGFuZykKPgo+IEFsdGhvdWdoIGluIHRoZSBvcmlnaW5hbCBk
b2NzLCB0aGUgdGFibGUgd2FzIG5vdCB1bmRlciBzZWN0aW9uICJCdWlsZAo+IHRlc3RpbmcKPiB3
aXRoIEdpdEh1YiBBY3Rpb25zIiwgSSBhc3N1bWVkIGl0J3MgY2xlYXIgd2UgdGFsayBhYm91dCBH
aXRIdWIgQWN0aW9ucwo+IHRlc3RpbmcuCj4gVGhhdCdzIHdoeSBJIHB1dCB0aGVyZSBvbmx5IGRp
c3Ryb3Mgd2UgYWN0dWFsbHkgaGF2ZSBpbgo+IC5naXRodWIvd29ya2Zsb3dzL2NpLnltbAo+IGFu
ZCBub3QgZS5nLiBTTEUxMi1TUDIgd2hpY2ggd2UgdGVzdCB3aXRoIGxhdGVzdCBMVFAgcmVsZWFz
ZS4KPgo+IEkgYWN0dWFsbHkgZmluZCB1c2VmdWwgdG8gc3RhbmQgd2hpY2ggZGlzdHJvcyB3ZSB0
ZXN0IHByaXZhdGVseSwgYnV0IHRoaXMKPiBpbmZvCj4gc2hvdWxkIGJlIG9idmlvdXMgKGVpdGhl
ciBhZGQgYSBjb2x1bW4gIkNJIiwgd2hlcmUgd291bGQgYmUgIkdpdEh1Ygo+IEFjdGlvbnMiIG9y
Cj4gIlJIRUwgcHJpdmF0ZSBDSSIgb3Igd2hhdGV2ZXIuCj4KCgo+Cj4gQExpIEFuZHJlYSBwdXQg
dGhlcmUgYXMgbmV3IGluZm86ICJNaW5pbWFsIHN1cHBvcnRlZCBrZXJuZWwgdmVyc2lvbiBpcwo+
IDMuMTAuIgo+IHdoaWNoIGlzIG5vdCBpbiBvbGQgZG9jcy4gRG8geW91IHJlYWxseSB0ZXN0IFJI
RUwtNy45ICgzLjEwIGJhc2VkKSB3aXRoIHRoZQo+IGxhdGVzdCBMVFAgcmVsZWFzZT8KPgoKWWVz
LCBJIGRpZCBidXQgb25seSBjaGVja2VkIG9uIFJIRUwtNy45IHdpdGggeDg2XzY0IGFuZCBzMzkw
eAooY29tcGlsZSAmIGV4ZWN1dGlvbiB3ZWxsKSBsYXN0IHRpbWUuCgpBZnRlciByZWJ1aWxkaW5n
IHRoZSBsYXRlc3QgYnJhbmNoIG9uIGFsbCBhcmNoZXMsIEkgZm91bmQgdGhlIHJlc3QKYXJjaGVz
IGhhdmUKcHJvYmxlbXMgaW4gY29tcGlsaW5nIChmb3JnaXZlIG1lIGNhcmVsZXNzIGxhc3QgdGlt
ZSkuCgpOb3cgSSBhbSBoZXNpdGFudCB0byBmaXggdGhlIGVycm9yIG9yIHJhaXNlIHRoZSBiYXNl
bGluZSB0byBSSEVMOC4zLgooSSB0YWxrZWQgdG8gY29sbGVhZ3VlcyBhbmQgZ290IHRvIGtub3cg
dGhleSBhbHdheXMgY2hvc2UgdG8gdXNlIGZpeGVkCnZlcnNpb25zIG9mIExUUCB3aGVuIDw9UkhF
TDguMikuCgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiMgMy4xMC4wLTExMzYuZWw3LnBwYzY0bGUK
CiMgZ2xpYmMtMi4xNy0zMTYuZWw3LnBwYzY0bGUKCkluIGZpbGUgaW5jbHVkZWQgZnJvbSAvdXNy
L2luY2x1ZGUvdGVybWlvcy5oOjQwOjAsCiAgICAgICAgICAgICAgICAgZnJvbSAvdXNyL2luY2x1
ZGUvYml0cy9pb2N0bC10eXBlcy5oOjUsCiAgICAgICAgICAgICAgICAgZnJvbSAvdXNyL2luY2x1
ZGUvc3lzL2lvY3RsLmg6MjksCiAgICAgICAgICAgICAgICAgZnJvbSAuLi8uLi8uLi8uLi9pbmNs
dWRlL2xhcGkvaW9jdGwuaDoxMSwKICAgICAgICAgICAgICAgICBmcm9tIGlvY3RsMDIuYzozMToK
L3Vzci9pbmNsdWRlL2JpdHMvdGVybWlvcy5oOjMzOjg6IGVycm9yOiByZWRlZmluaXRpb24gb2Yg
4oCYc3RydWN0IHRlcm1pb3PigJkKIHN0cnVjdCB0ZXJtaW9zIHsKICAgICAgICBeCkluIGZpbGUg
aW5jbHVkZWQgZnJvbSBpb2N0bDAyLmM6Mjk6MDoKL3Vzci9pbmNsdWRlL2FzbS90ZXJtYml0cy5o
OjIyOjg6IG5vdGU6IG9yaWdpbmFsbHkgZGVmaW5lZCBoZXJlCiBzdHJ1Y3QgdGVybWlvcyB7CiAg
ICAgICAgXgoKCgoKPgo+IEBZYW5nIFh1IEkgZm91bmQgeW91IHJlbW92ZWQgZmFsbGJhY2tzIHVw
IHRvIGtlcm5lbCAzLjEwOgo+Cj4gMDZhZGEwMzI5ICgiUmVtb3ZlIG9sZCBrZXJuZWwgdmVyc2lv
biBjaGVjayB3aGVuIHVzaW5nIG1pbl9rdmVyIHVuZGVyCj4gMy4xMCIpCj4gODYyZDk0YzQ1ICgi
UmVtb3ZlIG9sZCBrZXJuZWwgdmVyc2lvbiBjaGVjayB3aGVuIHVzaW5nIHRzdF9rdmVyY21wIHVu
ZGVyCj4gMy4xMCIpCj4gOTcxODI4YzAwICgic2hlbGw6IFJlbW92ZSBvbGQga2VybmVsIHZlcnNp
b24gY2hlY2sgYmVsb3cgMy4xMCIpCj4KPiBIb3BlZnVsbHkgSSBoYXZlbid0IG92ZXJsb29rIGFu
eXRoaW5nLgo+Cj4gQEFuZHJlYTogQWxzbywgSSB3b3VsZCBwcmVmZXIgdG8gcHV0IGJhY2sgcGFy
YWdyYXBoICIxLiBCdWlsZCB0ZXN0aW5nIHdpdGgKPiBHaXRIdWIgQWN0aW9ucyIuIEknbGwgc2Vu
ZCBhIHBhdGNoLCB0byBmb3JjZSBteXNlbGYgdG8gbGVhcm4gYnVpbGRpbmcgbmV3Cj4gZG9jcy4K
Pgo+IEtpbmQgcmVnYXJkcywKPiBQZXRyCj4KPiA+IFsxXQo+IGh0dHBzOi8vbHRwLWFjZXJ2LnJl
YWR0aGVkb2NzLmlvL2VuL2xhdGVzdC91c2Vycy9zdXBwb3J0ZWRfc3lzdGVtcy5odG1sCj4KPgoK
LS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9saXN0aW5mby9sdHAK
