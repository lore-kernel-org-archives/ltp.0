Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46262C35FF3
	for <ltp@archiver.kernel.org>; Fri, 21 Mar 2025 07:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742543674; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=9wjaShyi6wz6X06GZpwPbZb5VjpRS82clRu0Kf8a3a8=;
 b=T5W6PlpjqV/QRa9GGChRnFkwg8y7drnjefebiQs5DFAp/n+iUyU1q3qlgnO2FYW7BhKUv
 XTa1S+hzjnewqnfmh0p/zCk/awKwLwtgtlDsjHCCfTpFOUEF7lbG2zbTSf1KDhiXUHuFcr+
 dA/R46qy5kajkeVUn3yR7ymwEvqVSLs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A7A453CAECD
	for <ltp@archiver.kernel.org>; Fri, 21 Mar 2025 08:54:34 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 135693CACF3
 for <ltp@lists.linux.it>; Fri, 21 Mar 2025 08:54:12 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3B569200A13
 for <ltp@lists.linux.it>; Fri, 21 Mar 2025 08:54:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742543650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QWu7FsraGzAx2esMdbM6KfA4AhOMReIw6TZ6lnHxUBo=;
 b=R/tGheDgrOKWpKHnpR+GKgXiWPzEz0QP+WSjt3cEBWLOqlhlTTguayvfSE2D7WU/qBF/Cq
 wxdN7uc5YaI27qfuKwt9GGkntZkoWe3OvDmt9jD0ViVfHSavZ8qkzvqfig6wXeWBBoWPlc
 KxD1TXuPlmnrAUn0Q3gQUKwMoUio6WY=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-YwOcwmB8NB-vfNU95ft1nw-1; Fri, 21 Mar 2025 03:54:08 -0400
X-MC-Unique: YwOcwmB8NB-vfNU95ft1nw-1
X-Mimecast-MFC-AGG-ID: YwOcwmB8NB-vfNU95ft1nw_1742543648
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2240a96112fso38953235ad.2
 for <ltp@lists.linux.it>; Fri, 21 Mar 2025 00:54:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742543647; x=1743148447;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QWu7FsraGzAx2esMdbM6KfA4AhOMReIw6TZ6lnHxUBo=;
 b=mKgdMZ11+Bk7yTqcsBtnx2bPgA5UYqzCtxkX7ZDSWRoa55Gz5d8nSL68usAZriSsQb
 zdwnPhl924GEtH0zy1G1g1unH0LSbM5FWpntTanL6smyqy8/E5Z4LrYrxyJhDfwijroK
 tZodicedSHoynkznF8IVXpFjIZ3sStk41akXeKTSNOzP+ng9XndZvayc/4n+mbWEeVJU
 591Fg2EKGJ4NHEVe7M2zgMzt0A+eN09mNFV2eSLF5nBpYqbOqTTK4BZ4IyLXZqbMumhZ
 +1CqE4VTji4iqkrSD29HIemMInTS7HxGeG67ndZcF/Dec3dEdUi1c5lAmYmz/XBfYQiL
 YSxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJFV1Lqc4tsXr+SsJsNJxpW7FG1pkK3zSfIQqg/Kd+VVTOjUsfJBGy3JtdQq8SOXwU6h4=@lists.linux.it
X-Gm-Message-State: AOJu0YwOlao3K/Jxn+T6dHUCUzjojhiFkF66vESqECBpA/5cUN1TLT1Q
 uPs9THxyJ30zRi7n8femprilMa8oiiGjhTMkNVVxhcmfzmSX2WGqN6NmedRmewpmSSfJPcnPzMC
 L7c/YUKvm4Cxuog20GC1aQ7RZB4KZww0CxHTkmlVFamrqUxiKPxWWSFOU5oUEgB10eKl7ufYBPn
 ZcKe73HKRdcX3DDHXJn92XsLPGPjHVpcWAIP4F
X-Gm-Gg: ASbGncsy+X2uUJ+zhK5nlsYl9p6plKVYcK2JLMYurVZ0Hbx24Vdh+do0SezqVS0clvR
 B/xnCon0GMqRMJzVmFgH5NoQHfq8TCXGrJU3UcplRtKr6+EBCcyFSnpVREu/gtrIVfHS3hAVpaw
 ==
X-Received: by 2002:a17:902:f70f:b0:220:e023:8fa6 with SMTP id
 d9443c01a7336-22780e31437mr41172915ad.50.1742543646797; 
 Fri, 21 Mar 2025 00:54:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhb7Clr5SguXB0HlBzTAiY/AZ9fSNfMrwDifZAytynop3aXoFmwt9LntJdtToY2EMk14Yl9JfGHzoLe3nRKFY=
X-Received: by 2002:a17:902:f70f:b0:220:e023:8fa6 with SMTP id
 d9443c01a7336-22780e31437mr41172655ad.50.1742543646476; Fri, 21 Mar 2025
 00:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240612121106.11127-1-chrubis@suse.cz>
 <20240612121106.11127-2-chrubis@suse.cz>
 <20250320173141.GA114876@pevik>
 <CAEemH2d8OzjHVi7ZJD3ah=C+JpDFmGcRTj=4CzDZ950uNqBfmw@mail.gmail.com>
 <20250321064151.GA145712@pevik>
In-Reply-To: <20250321064151.GA145712@pevik>
Date: Fri, 21 Mar 2025 15:53:54 +0800
X-Gm-Features: AQ5f1JoFpew0PcN9gkONbxJVP58hB_lOHvgLZnkv9LtPsctAc26S1Zaoqlh9mWc
Message-ID: <CAEemH2fpNpwwN=_xhP1k=ATV2g1BiXku+p++CpZPvGjS95PvOQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hi-ywdCCyrNVHOkPK8xvDP0ZW_VBVNCmU1cAgIQ0JZI_1742543648
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 1/2] lib: tst_test: Add per filesystem mkfs and
 mount opts
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

T24gRnJpLCBNYXIgMjEsIDIwMjUgYXQgMjo0MuKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgTGksCj4KPiA+IE9uIEZyaSwgTWFyIDIxLCAyMDI1IGF0IDE6MzHi
gK9BTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cj4KPiA+ID4gSGkgQ3lyaWws
IGFsbCwKPgo+ID4gPiA+IFRoaXMgY29tbWl0IGRvZXM6Cj4KPiA+ID4gPiAqIEdyb3VwIHRoZSBm
aWxlc3lzdGVtIHR5cGUsIG1rZnMgYW5kIG1vdW50IG9wdGlvbnMgaW50byBhIHNlcGFyYXRlCj4g
PiA+ID4gICBzdHJ1Y3R1cmUKPgo+ID4gPiA+ICogQWRkIGFuIGFycmF5IG9mIHRoZXNlIHN0cnVj
dHVyZXMgdG8gYmUgYWJsZSB0byBkZWZpbmUgcGVyCj4gZmlsZXN5c3RlbQo+ID4gPiA+ICAgbWtm
cyBhbmQgbW91bnQgb3B0aW9ucwo+Cj4gPiA+ID4gVGhlIGRldGFpbHMgb24gdGhlIHVzYWdlIHNo
b3VsZCBiZSBob3BlZnVsbHkgY2xlYXIgZnJvbSB0aGUKPiA+ID4gPiBkb2N1bWVudGF0aW9uIGNv
bW1lbnRzIGZvciB0aGUgc3RydWN0IHRzdF90ZXN0Lgo+Cj4gPiA+IEZZSSwgdGhpcyBtZXJnZWQg
YXMgY2NlNjE4ODkxNiAoImxpYjogdHN0X3Rlc3Q6IEFkZCBwZXIgZmlsZXN5c3RlbQo+IG1rZnMg
YW5kCj4gPiA+IG1vdW50IG9wdHMiKSBjYXVzZXMgdGhpcyBiZWhhdmlvciBvZiBub25lIHRlc3Rp
bmcgcnVuIHdoZW4gdGhlcmUgaXMgbm8KPiA+ID4gc3VpdGFibGUKPiA+ID4gZmlsZXN5c3RlbS4g
SSBmb3VuZCBpdCB3aGVuIHRyeWluZyB0byBiaXNlY3Qgc29tZXRoaW5nIHdpdGgKPiByYXBpZG8t
bGludXgKPiA+ID4gYW5kCj4gPiA+IGNvbXBpbGUga2VybmVsIHdpdGhvdXQgQnRyZnMgYW5kIFhG
Uy4gRG9uJ3Qgd2Ugd2FudCB0byBhZGQgc29tZSBUQ09ORj8KPgo+Cj4gPiBJIHRoaW5rIHdlIG5l
ZWQgVENPTkYgdGhlcmUuIENhbiB5b3UgY29uZmlybSBiZWxvdyBjaGFuZ2UgbWFrZXMgc2Vuc2U/
Cj4KPiBUaGFua3MhIExHVE0gKHVudGVzdGVkKS4gQ2FuIHlvdSBwbGVhc2Ugc2VuZCBhIHBhdGNo
PyAoSSdsbCB0ZXN0IGl0KS4KPgoKU2VlOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L3BpcGVybWFp
bC9sdHAvMjAyNS1NYXJjaC8wNDI3MjMuaHRtbAoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
