Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2778E77188
	for <ltp@archiver.kernel.org>; Mon, 30 Dec 2024 08:56:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7762A3EC065
	for <ltp@archiver.kernel.org>; Mon, 30 Dec 2024 09:56:06 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D02B3E2577
 for <ltp@lists.linux.it>; Mon, 30 Dec 2024 09:55:50 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E79AC641A4F
 for <ltp@lists.linux.it>; Mon, 30 Dec 2024 09:55:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735548946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nNYVzDv7vue4pR/nXrmsw5PqQbr9NjgVIKgrOfXMpZk=;
 b=dLU9RmwFn0WvV/6aPhFCyZtqqG07D1eOdgOxqNvE3rWLVYHyaHmqupP1XB81Nfa4PXcvqW
 UQ79yBWAQpNEGEmeQ5pLLD9nwMKN19lwJg7iZn9Inr5eYt4IgJx7Rys6lMDwdyh4K46iB1
 /gc5NmfRnC9UoCTEQ2vH0gRno3Y4+DY=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-I5ek9x6XP5yQBje7ixLFrQ-1; Mon, 30 Dec 2024 03:55:44 -0500
X-MC-Unique: I5ek9x6XP5yQBje7ixLFrQ-1
X-Mimecast-MFC-AGG-ID: I5ek9x6XP5yQBje7ixLFrQ
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ef79403c5eso18429675a91.0
 for <ltp@lists.linux.it>; Mon, 30 Dec 2024 00:55:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735548943; x=1736153743;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nNYVzDv7vue4pR/nXrmsw5PqQbr9NjgVIKgrOfXMpZk=;
 b=BUQRZd6yhyq2zi1HcY5zZgJl6iIYuhvQmtKMnDXZRrObGfcvW2LZGUQeujknnRPjRj
 Ynoqt1NVis5unkgf9vIecWKczROhhTgzlEFStDGpk0hC6NzOWH5BKiYbFU9Cuh3BV1DW
 dS6REj5q6nANqsDzknRJUN6tcbNnLgplLJOoCk5UNs7lz7hYRP0NdHjIuH683vkGBI1Y
 27kCzBGvILKvnmEUq4XMjverLJw6e//X8C3GyvODtFGwRNBs7H85GUjlq6xVWmFCRDly
 P692FweecCDwdg3blLou6IMbFT5q+AruMkKa/XLxR65noA7q/YNP96DDAa345F0JCwbY
 QfmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWs85mV1mbt8J/Yab24QzRUibpPUsZ15Os2I4/t6oyD+KJ9IqnmH2als+18sZghbd3aIdo=@lists.linux.it
X-Gm-Message-State: AOJu0YwIWSRc23fyJRUEC+SlTEA8csnVI2v+F1YbbixtS09NZ7q6AuQR
 8TwkQ9io+0Smhw+0+4OhXYuY+i8iRGQXM1xYJLI4qMrpfSufp0Mzp7/WEh82yC0BfeYBEpcjpWS
 68rzwLRv+Q+aw/9uLa62w7SEtLvvJGMNO0u6C4iFjBFvjCjeRhiWfkB8g7HTiCfIaiwbygRO5IV
 9waGuFcpuc9qRtuLPgmdLOWVkQNRcW3ONX4fgD
X-Gm-Gg: ASbGncuyyNduZIquYtp8BEG0PbwzfzOobB/wtbWBxRecFU3eo1hhYBPDdMdCG69cwbg
 YXfhPCi65d4wnBW6O1YDgOPcXZ9jgUuCQy6JltDc=
X-Received: by 2002:a17:90b:5246:b0:2ee:d18c:7d84 with SMTP id
 98e67ed59e1d1-2f452e4a839mr53741003a91.20.1735548942739; 
 Mon, 30 Dec 2024 00:55:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKYE1SKWz43hqIWCqswWHi9YUQopuhAR7wW9qiKaAzzl1gMizyYyizYirLz3q2ZLwbLOn8svqgL7F8UOMsK8s=
X-Received: by 2002:a17:90b:5246:b0:2ee:d18c:7d84 with SMTP id
 98e67ed59e1d1-2f452e4a839mr53740986a91.20.1735548942416; Mon, 30 Dec 2024
 00:55:42 -0800 (PST)
MIME-Version: 1.0
References: <20241227073921.GB290415@pevik>
In-Reply-To: <20241227073921.GB290415@pevik>
From: Li Wang <liwang@redhat.com>
Date: Mon, 30 Dec 2024 16:55:30 +0800
Message-ID: <CAEemH2cnb9dao+2qjuaCLMegQzpHRSTuP7mT_F+oftxiMTi8cA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kicjz24kzKTXS9dirqqOcHjuNULt9yb1tE4PxdOl5h4_1735548943
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [RFC] Convert test catalog (docparse) from asciidoc to
 readthedocs.io (sphinx)
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

T24gRnJpLCBEZWMgMjcsIDIwMjQgYXQgMzozOeKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkKPgo+IEkgc3VnZ2VzdCB0byBjb252ZXJ0IHRlc3QgY2F0YWxvZyAo
ImRvY3BhcnNlIikgZ2VuZXJhdGVkIGJ5IGRvY3BhcnNlLwo+IHRlc3RpbmZvLnBsCj4gYW5kIGFz
Y2lpZG9jL2FzY2lpZG9jdG9yIHRvIHNwaGlueCBnZW5lcmF0b3IgKHJlYWR0aGVkb2NzLmlvKS4K
PiBhc2NpaWRvYy9hc2NpaWRvY3RvciB3YXMgYSBnb29kIGNob2ljZSBhdCB0aGUgdGltZSwgYnV0
IG5vdyBpdCBsb29rcyB0byBtZQo+IGJldHRlciB0byB1c2Ugc3BoaW54IGZvciBldmVyeXRoaW5n
Lgo+CgpBZ3JlZS4KCgo+IEkgdm9sdW50ZWVyIHRvIGRvIHRoZSB3b3JrLCBidXQgSSB3b3VsZCBs
aWtlIHRvIGhhdmUgYSBnZW5lcmFsIGFncmVlbWVudAo+IGJlZm9yZQo+IEkgZG8gaXQuCj4KClRo
YW5rcywgdGhlIExpbnV4IEtlcm5lbCBoYXMgc2hpZnRlZCBmcm9tIEFzY2lpRG9jIHRvIHJlU3Ry
dWN0dXJlZFRleHQKYXMgcGFydCBvZiBpdHMgRG9jdW1lbnRhdGlvbiBvdmVyaGF1bC4gU28gSXQg
aXMgcmVhc29uYWJsZSBmb3IgTFRQIHRvIGRvCnRoaXMgYXMgd2VsbC4KCgoKPgo+IFByb3M6Cj4K
PiAqIFdlIGFscmVhZHkgaGF2ZSBhdHRlbXB0IHRvIHNob3cgdGVzdGVkIHN5c2NhbGxzIFsxXS4g
UHJpbnRpbmcgdGVzdAo+IGNhdGFsb2cgd291bGQKPiBoYXZlIG1vcmUgaW5mby4KPiAqIE5vIG5l
ZWQgdG8gaW5zdGFsbCBkZXBlbmRlbmNpZXMuCj4gKiBBdXRvbWF0aWMuIElmIHdlIGFkZCBhbHNv
IGRvYyBmb3Igc3RhYmxlIHJlbGVhc2VzLCBpdCB3b3VsZCByZXBsYWNlIHRoZQo+IG5lZWQKPiB0
byBpbnN0YWxsIGRlcGVuZGVuY2llcyBhbmQgdXBsb2FkIGZpbGUgdG8gTFRQIHJlbGVhc2Ugb24g
R2l0SHViIFsyXS4gVGhlbgo+IG9ubHkKPiBsaW5rIHRvIHBhZ2UgdG8gdGVzdCBjb3ZlcmFnZSBv
biBsaW51eC10ZXN0LXByb2plY3QucmVhZHRoZWRvY3MuaW8gb2YKPiBwYXJ0aWN1bGFyCj4gcmVs
ZWFzZSAob3IgbGluayB0byB3aG9sZSBkb2Mgb24gcGFydGljdWxhciByZWxlYXNlKSB3b3VsZCBi
ZSBhZGRlZCBpbgo+IHJlbGVhc2UKPiBtYWlsIGFubm91bmNlbWVudCAob3Igd2UgbWlnaHQga2Vl
cCBhZGRpbmcgZ2VuZXJhdGVkIHBkZi9lcHViL3ppcHBlZCBodG1sCj4gYWxzbwo+IHRvIExUUCBy
ZWxlYXNlcyBbMl0pLgo+ICogVW5pZmllZCBsb29rIGFuZCBmZWVsLgo+Cj4gV29yayBuZWVkZWQ6
Cj4KPiAqIENvbnZlcnQgZG9jcGFyc2UvdGVzdGluZm8ucGwgdG8gZG9jL2NvbmYucHksIG9idmlv
dXNseSBjaGFuZ2UgZnJvbQo+IGFzY2lpZG9jCj4gdG8gc3BpbnguCj4gKiBBZGRpbmcgc3RhYmxl
IHJlbGVhc2VzIChub3Qgc3VyZSBpZiBpdCBjYW4gYmUgY3JlYXRlZCBhdXRvbWF0aWNhbGx5IGZv
cgo+IGFsbAo+IHRhZ3MpLgo+ICogQWRkaW5nIG9mZmxpbmUgZm9ybWF0cyBbM10gc28gdGhhdCB1
c2VycyBjYW4gZG93bmxvYWQgdGhlIGRvY3MgKHRoYXQKPiB3b3VsZCBiZQo+IHVzZWZ1bCBhbnl3
YXkpLgo+Cj4gS2luZCByZWdhcmRzLAo+IFBldHIKPgo+IFsxXSBodHRwczovL2xpbnV4LXRlc3Qt
cHJvamVjdC5yZWFkdGhlZG9jcy5pby9lbi9sYXRlc3QvdXNlcnMvc3RhdHMuaHRtbAo+IFsyXSBo
dHRwczovL2dpdGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0L2x0cC9yZWxlYXNlcwo+IFszXSBo
dHRwczovL2RvY3MucmVhZHRoZWRvY3MuaW8vZW4vc3RhYmxlL2Rvd25sb2FkYWJsZS1kb2N1bWVu
dGF0aW9uLmh0bWwKPgo+CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBp
bmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
