Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F544E77198
	for <ltp@archiver.kernel.org>; Tue,  7 Jan 2025 05:38:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 86C5B3C6D08
	for <ltp@archiver.kernel.org>; Tue,  7 Jan 2025 06:38:33 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA0263C0E5E
 for <ltp@lists.linux.it>; Tue,  7 Jan 2025 06:38:17 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B769410231C1
 for <ltp@lists.linux.it>; Tue,  7 Jan 2025 06:38:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736228295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SS38e0ovKgaC01INbyxJxrdt/ajgu/ba+/wvMzaQj9E=;
 b=Rt/1pPNqXZs9tbk0RhJhHxdfewjNjQwNhdz7fNCBGWsTWrlhf6XXO09CBFB1K6nU9qfcoV
 KT+UXId6l60Xd1HLrhrmiSD5gHBjKXNm9HltDKxoo/Yxd1nrtbSDUtrUtDDDSFDXZ2fPWL
 c58t6TVBG8hOUNFxU72ExZhQ8q1yb5o=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-Pa66rZy2NuqW3OpXqcqI5Q-1; Tue, 07 Jan 2025 00:38:13 -0500
X-MC-Unique: Pa66rZy2NuqW3OpXqcqI5Q-1
X-Mimecast-MFC-AGG-ID: Pa66rZy2NuqW3OpXqcqI5Q
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2ef775ec883so21495361a91.1
 for <ltp@lists.linux.it>; Mon, 06 Jan 2025 21:38:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736228292; x=1736833092;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SS38e0ovKgaC01INbyxJxrdt/ajgu/ba+/wvMzaQj9E=;
 b=JPeEpBE7S9eWm6qzsHIl1u5gI8SK+DM6gACgP5mpXRO/TiNMto18ZD46x05FakZGBu
 j5rgaWJV+EfaQ6YGR4WJ1c0p152cV+yT4vLucfqGoajf6WLoTl7x2sjvfq4VYPr+WZUE
 S5ACkWtifUhvBHMmWkLAqnR92/wu9jyjyNR0ehm6t/pKoPMRQ/5+ClCVOxwIPro/E+8Y
 em33v0pTn+blScv+XV1NjXV0KGZHrBww3QHl1eUy/TA0gMs+9QSAJMFlNKcfxaf5H9bs
 fX+e0v2+SrE9KdUwSl36eIJJ8ShGtBXf4k4DGq6pFLRSNdTO2Ymvk083L/VVycRXC8eY
 DdCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWrbHD/zwsOKVvAGSE2AFB8Eaq+eZhaoupae8+hTV2FwGKEcx2omDtcoODY2XsQ8NSam8=@lists.linux.it
X-Gm-Message-State: AOJu0Yw4pl+QGisE645ixjOmZATJVPMbH+n7AX63jGAZMKExkbH9xUxB
 P7EjFodZO2wUI165ripdKBc6jN3xU0jJj52tx1+cgx1cX6+l2oYh2XS0T5B1kpAU/5VW/HP8xT6
 UesKCqS40N2jjXXZvB6u83vG5J9LOszmRcobnQCOOOa1kv1GDghTrRjAVS79lqZiyhnZW1M/b5B
 WSB/0Be+4rHj34YsYUyOypD38=
X-Gm-Gg: ASbGnctYU8QkEUh4/bUy4zWIRfkvWGkbvLRwJBlHiPn3UU7PWfD8fjK6I0iPV0ZQshC
 RiM6niL/0aWAjlm5hCxLTy3FNyXAXVihkeB6pRmQ=
X-Received: by 2002:a17:90a:c2c7:b0:2ee:ee77:227c with SMTP id
 98e67ed59e1d1-2f452dfaecdmr81374228a91.3.1736228292247; 
 Mon, 06 Jan 2025 21:38:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuKRpMjPiSXNZnOhV2utXxvQbWXa4i2dtTvcwN6BBpkYscjVFgPYJ40/pBSt1eLYMmq1f4DRBE12af8dOzqBM=
X-Received: by 2002:a17:90a:c2c7:b0:2ee:ee77:227c with SMTP id
 98e67ed59e1d1-2f452dfaecdmr81374196a91.3.1736228291858; Mon, 06 Jan 2025
 21:38:11 -0800 (PST)
MIME-Version: 1.0
References: <20241222072251.13150-1-liwang@redhat.com>
 <20250102124319.GA81987@pevik>
 <CAEemH2cXL8yu0jhHz7wefvBbDGy-wXcz8Mw1JZv8FqLAXHKm9Q@mail.gmail.com>
 <Z3gGuFHey5qgQ__6@yuki.lan>
 <CAEemH2cawEE9=-3=QUScg+K4JYe5hqhYMtUManS_8JsBfG30AQ@mail.gmail.com>
 <Z3vII4tENjV4G6GQ@yuki.lan> <20250106125255.GC302614@pevik>
 <Z3vc-PafjaXVIcRJ@yuki.lan> <20250106153624.GB323533@pevik>
 <Z3wCr3LG_ztyQYHj@yuki.lan>
In-Reply-To: <Z3wCr3LG_ztyQYHj@yuki.lan>
From: Li Wang <liwang@redhat.com>
Date: Tue, 7 Jan 2025 13:37:59 +0800
Message-ID: <CAEemH2c28ob0=3tq94i7AiwFZW0EyGnb=WAP3P3Qftwb6hLkuw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RUgTTFNQ-DlddmM9xRlQ_60V6VVHKXJUkdqVVIRAf2I_1736228292
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/2] lib: multiply the timeout if detect slow
 kconfigsD
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBKYW4gNywgMjAyNSBhdCAxMjoyOeKAr0FNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiBBbmQgaWYgdmFsdWUgZG9lcyBub3QgZ2V0IGNoYW5n
ZWQgaXQncyB0aGUgZGVmYXVsdCB2YWx1ZS4gQWxzbyBuYW1lIGlzIGEKPiBiaXQKPiA+IGNvbmZ1
c2luZyAoeW91IHN1Z2dlc3QgdG8gaGF2ZSBtZW1iZXJzICJ0aW1lb3V0IiwgInJ1bnRpbWUiKSwg
d2hpY2gKPiBzdWdnZXN0IHRoZQo+ID4gc3BlY2lhbCB2YWx1ZSBpcyByZWxhdGVkIHRvIGJvdGgu
Cj4gPgo+ID4gT0ssIGZsYWcgd2hpY2ggd291bGQgYWxsb3cgdXMgdG8gc2VlIHRoYXQgdGltZSB3
aWxsIGJlIGNoYW5nZWQuCj4gPgo+ID4gPiBUaGVuIGFsbCBsb25nIHJ1bm5pbmcgdGVzdCB3b3Vs
ZCBoYXZlIGVpdGhlciB0c3RfdGVzdC0+dGltZW91dCBvcgo+ID4gPiB0c3RfdGVzdC0+cnVudGlt
ZSBzZXQuCj4gPgo+ID4gPiBUZWNobmljYWxseSB3ZSB3b3VsZCBuZWVkIHR3byBzcGVjaWFsIHRp
bWVvdXQgdmFsdWVzCj4gPiA+IFRTVF9VTkxJTUlURURfVElNRU9VVCBhbmQgVFNUX1JVTlRJTUVf
VElNRU9VVC4KPiA+Cj4gPiBPSywgVFNUX1VOTElNSVRFRF9USU1FT1VUIGlzIGVxdWl2YWxlbnQg
b2Y6Cj4gPgo+ID4gI2RlZmluZSBUU1RfVU5MSU1JVEVEX1JVTlRJTUUgKC0xKQo+ID4KPiA+IE1h
eWJlIGhhdmUganVzdCBzaW5nbGUgZGVmaW5pdGlvbiBUU1RfVU5MSU1JVEVELCB3aGljaCBjb3Vs
ZCBiZSB1c2VkIGluCj4gYm90aAo+ID4gdHN0X3Rlc3QtPnRpbWVvdXQgYW5kIHRzdF90ZXN0LT5y
dW50aW1lPyBCdXQgdGhhdCdzIGp1c3QgYW4KPiBpbXBsZW1lbnRhdGlvbgo+ID4gZGV0YWlsLgo+
Cj4gVGhlIFVOTElNSVRFRF9SVU5USU1FIHdvdWxkIG5vdCBiZSBuZWVkZWQgYW55bW9yZS4gQmVj
YXVzZSBydW50aW1lIHdpbGwKPiBtZWFuIF9vbmx5XyBmb3IgaG93IGxvbmcgd2lsbCBhIGZldyB0
ZXN0cyBzcGVuZCBpbiB0aGUgbWFpbiBsb29wLgo+IEluZmluaXRlIGxvb3AgZG9lcyBub3QgbWFr
ZSBhbnkgc2Vuc2UuIFRoZSB0c3RfcnVudGltZSB3aWxsIGJlIGJhc2ljYWxseQo+IHJlbmFtZWQg
dG8gdGltZW91dCBhbmQgVFNUX1VOTElNSVRFRF9SVU5USU1FIGJlY29tZXMKPiBUU1RfVU5MSU1J
VEVEX1RJTUVPVVQuCj4KPiA+ID4gPiA+IE1heWJlIHdlIHNob3VsZCBoYXZlIGNhbGxlZCB0aGUg
bWF4X3J1bnRpbWUgYSB0aW1lb3V0IGFuZCBhZGQKPiBydW50aW1lCj4gPiA+ID4gPiBmb3IgdGVz
dHMgdGhhdCBuZWVkcyBpdC4gVGhhdCB3YXkgd2Ugd291bGQgaGF2ZSB0aW1lb3V0Cj4gY29tcHJv
bWlzaW5nIG9mCj4gPiA+ID4gPiB0d28gcGFydHMsIG9uZSB3b3VsZCBiZSB0aGUgMzBzIHRoYXQg
aXMgdXNlZCBmb3IgYWxsIHRlc3RzIGFuZAo+IHNlY29uZAo+ID4gPiA+ID4gcGFydCBmcm9tIHRo
ZSB0c3RfdGVzdCBzdHJ1Y3R1cmUuIEFuZCB0aGVuIHRoZSBzdW0gb2YgdGhlc2UgdHdvCj4gd291
bGQgYmUKPiA+ID4gPiA+IG11bHRpcGxpZWQgYnkgdGhlIHRpbWVvdXQgbXVsdGlwbGllcnMuIFRo
ZW4gd2Ugd291bGQgaGF2ZSBhCj4gcnVudGltZSwKPiA+ID4gPiA+IHdoaWNoIHdvdWxkIGJlIHVz
ZWQgb25seSBieSB0ZXN0cyB0aGF0IGNhbGwKPiB0c3RfcmVtYWluaW5nX3J1bnRpbWUoKS4KPiA+
Cj4gPiBPSywgdGhlIHBvaW50IG9mIHdob2xlIGNoYW5nZSBpcyB0byBzZXBhcmF0ZSBzb21lIGdl
bmVyYWwgdGltZW91dCAoMzAKPiBzZWMpIGZyb20KPiA+IHJ1bnRpbWUgKHVzZWQgZm9yIHRzdF9y
ZW1haW5pbmdfcnVudGltZSgpKSwgcmlnaHQ/Cj4KPiBUaGUgcG9pbnQgaXMgdG8gc2VwYXJhdGUg
dGltZW91dCwgd2hpY2ggaXMgYSBndWVzcyBvbiB1cHBlciBib3VuZCBvbiB0aGUKPiB0aW1lIHRo
ZSB0ZXN0IHdpbGwgc3BlbmQgZXhlY3V0aW5nIGZyb20gYSBydW50aW1lIHdoaWNoIGlzIHRoZSBl
eGFjdAo+IHRpbWUgYSBmZXcgdGVzdHMgd2lsbCBzcGVuZCBsb29waW5nIGluIHRoZSB0ZXN0IGZ1
bmN0aW9uLgo+Cj4gPiA+ID4gPiBUaGUgb3ZlcmFsbCB0ZXN0IHRpbWVvdXQgd291bGQgYmUgdGhl
bjoKPiA+Cj4gPiA+ID4gPiAoZGVmYXVsdF8zMHNfdGltZW91dCArIHRzdF90ZXN0LT50aW1lb3V0
KSAqIFRJTUVPVVRfTVVMICsKPiB0c3RfdGVzdC0+cnVudGltZSAqIFJVTlRJTUVfTVVMCj4gPgo+
ID4gKGRlZmF1bHRfMzBzX3RpbWVvdXQgKyB0c3RfdGVzdC0+dGltZW91dCkgKiBUSU1FT1VUX01V
TCBpcyBtZWFudCBmb3IKPiBzZXR1cCBvcgo+ID4gY2xlYW51cCBhbmQgbGlicmFyeSBvdmVyaGVh
ZCwgdHN0X3Rlc3QtPnJ1bnRpbWUgKiBSVU5USU1FX01VTCBmb3IKPiBydW5uaW5nIHRlc3QKPiA+
IGZ1bmN0aW9uPwo+Cj4gTm8sIGl0J3MgdGhlIG90aGVyIHdheSBhcm91bmQuIFRoZSB0aW1lb3V0
IGlzIGEgZ3Vlc3NlZCB1cHBlciBib3VuZCBmb3IKPiBhIHRlc3QgZXhlY3V0aW9uIHRpbWUuIEl0
J3MgZm9yIGV2ZXJ5dGhpbmcgdGhlIHRlc3QgZG9lcyBhbmQgaW4gbW9zdCBvZgo+IHRoZSBjYXNl
cyBvbmx5IHRoZSBkZWZhdWx0IHRpbWVvdXQgKHdoaWNoIGlzIGtpbmQgb2Ygc2FmZXR5IG1lYXN1
cmUpIGlzCj4gc3VmZmljaWVudC4gVGhlbiB0aGVyZSBhcmUgdGVzdHMgdGhhdCBkbyBzb21lIHdv
cmsgdGhhdCBpcyBub3QgdGltZQo+IGJvdW5kLCBlLmcuIEkvTy4gSW4gdGhhdCBjYXNlIHdlIHNl
dCB0aGUgdGltZW91dCBpbiB0aGUgdHN0X3Rlc3QKPiBzdHJ1Y3R1cmUgdG8gc29tZSB2YWx1ZSB3
ZSBtZWFzdXJlZCBpbiBwcmFjdGljZSBhbmQgdGhhdCBwbHVzIHRoZQo+IGRlZmF1bHQgdGltZW91
dCB3aWxsIGJlY29tZSB0aGUgb3ZlcmFsbCB0ZXN0IHRpbWVvdXQuCj4KPiBUaGVuIHdlIGhhdmUg
YSBmZXcgdGVzdGNhc2VzIHRoYXQgZG8gYSBsb29wIGluIHRoZSB0ZXN0IGZ1bmN0aW9uIHRoYXQK
PiB0YWtlcyBleGFjdCB0aW1lLiBJbiB0aGF0IGNhc2Ugd2Uga25vdyB0aGF0IHdlIHNwZW5kIGV4
YWN0bHkgcnVudGltZSBpbgo+IHRoZSB0ZXN0IGZ1bmN0aW9uLCBidXQgdGhlcmUgaXMgYSBzZXR1
cCBhbmQgY2xlYW51cCBhcyB3ZWxsLiBTbyB3ZSBhZGQKPiB0aGUgZGVmYXVsdCB0aW1lb3V0IHRv
IHRoZSBydW50aW1lIHRvIGdldCB0aGUgb3ZlcmFsbCB0aW1lb3V0LiBUaGVyZSBtYXkKPiBiZSBh
bHNvIGEgY2FzZSB3aGVyZSB0aGUgdGVzdCBzZXR1cCBmb3Igc3VjaCB0ZXN0IHRha2VzIHNvbWUg
dGltZSwgaW4KPiB0aGF0IGNhc2Ugd2Ugd291bGQgc2V0IGJvdGggdGhlIHRpbWVvdXQgYW5kIHJ1
bnRpbWUgaW4gdGhlIHRzdF90ZXN0Cj4gc3RydWN0dXJlLiBUaGUgdGltZW91dCB3b3VsZCBiZSB1
cHBlciBib3VuZCBmb3IgdGhlIHRlc3Qgc2V0dXAgYW5kCj4gcnVudGltZSB3b3VsZCBiZSBleGFj
dGx5IGZvciBob3cgbG9uZyB3aWxsIHRoZSB0ZXN0IGZ1bmN0aW9uIGxvb3AuCj4KCkZhaXIgZW5v
dWdoLCBJIGFncmVlIHdpdGggdGhhdC4KClRodXMgd2Ugd2lsbCBoYXZlIHRzdF90ZXN0LT50aW1l
b3V0IHVzZWQgZm9yIHNldHVwIHRpbWUgY29udHJvbCwgYW5kCnRzdF90ZXN0LT5ydW50aW1lIG1l
YW5zIHRoZSBleGFjdCBleGVjdXRhYmxlIHRpbWUgb2YgdGhlIG1haW4gZnVuY3Rpb24sCnRzdF9y
ZW1haW5pbmdfcnVudGltZSgpIG9ubHkgcmVseSBvbiB0c3RfdGVzdC0+cnVudGltZSB0byBjb3Vu
dC4KCkFzIHlvdSBwb2ludGVkIG91dCBhYm92ZToKIChkZWZhdWx0XzMwc190aW1lb3V0ICsgdHN0
X3Rlc3QtPnRpbWVvdXQpICogVElNRU9VVF9NVUwgKwp0c3RfdGVzdC0+cnVudGltZSAqIFJVTlRJ
TUVfTVVMCgpCdXQsIHF1ZXN0aW9ucyBjb21lIGJhY2sgdG8gdGhlIGl0ZW0sIHdoaWNoIHBhcnQg
c2hvdWxkIGJlIGV4dGVuZGVkCndoZW4gZGV0ZWN0aW5nIHNsb3cga2VybmVsIGNvbmZpZ3M/IHRo
ZSBUSU1FT1VUX01VTD8KSWYgc28gaXQgbG9va3Mgb25seSByZW5hbWluZyBzb21ldGhpbmcgYmFz
ZWQgb24gbXkgcGF0Y2ggbm8gZXNzZW50aWFsCmNoYW5nZXMuCgoKCj4KPiBNYWlubHkgdGhpcyB3
b3VsZCBtYWtlIHN1cmUgdGhhdCBpZiB0aW1lb3V0IHBhcnQgb2YgdGhlIG92ZXJhbGwgdGVzdAo+
IHRpbWUgbGltaXQgZ2V0cyBtdWx0aXBsaWVkLCBiZWNhdXNlIHdlIGFyZSBydW5uaW5nIG9uIGEg
c2xvdyBzeXN0ZW0sIHRoZQo+IHJ1bnRpbWUgd2lsbCBub3QuIEJlY2F1c2Ugd2UgY291bGQgY29u
dHJvbCB0aGUgdGltZW91dCBhbmQgcnVudGltZQo+IHNlcGFyYXRlbHkuCj4KPiA+ID4gTm90IG9u
bHksIHRoZSBkZWZhdWx0IDMwcyB0aW1lb3V0IGlzIGZvciB0aGUgd2hvbGUgdGVzdHJ1biBmb3Ig
dGVzdHMKPiA+ID4gdGhhdCBhcmUgcXVpY2sgZW5vdWdoLiBXZSBoYXZlIGEgbG90IG9mIHRlc3Rz
IHRoYXQgcnVuIGp1c3QgZm9yIGxlc3MKPiA+ID4gdGhhbiAxcyBldmVuIG9uIHNtYWxsIGVtYmVk
ZGVkIGJvYXJkcy4KPiA+Cj4gPiBBbmQgeWVzLCB3aXRoIHByb3Blcmx5IHNldCBkYXRhLCAzMHMg
Y291bGQgYmUgY2FyZWZ1bGx5IGxvd2VyZWQgZG93biBhCj4gYml0Lgo+Cj4gVGhhdCB3YXMgbXkg
bG9uZyB0ZXJtIHBsYW4uCj4KPiAtLQo+IEN5cmlsIEhydWJpcwo+IGNocnViaXNAc3VzZS5jego+
Cj4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
