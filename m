Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2928FEC1133
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 09:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771925083; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=rEFxIQXG6YKMD/SQ2sA0zWvt+0iZn/QeUOv9AEHJyJM=;
 b=LYHwsTBt7wgrfVp1Gad7FOUWYsDQRZTEVCeEfe8hU0dod3+NaISkA5gl5kNyrOlNmvnVU
 hteFldkFJ60tWVWGMQyc28vQe4A2Y6cbvKYW9uaC/4GexwZud1QkGQO75m6b937zkcKp8G0
 j0+Zh+VB06edqCdfXY7/I3CIjFWECN4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B16103D0F80
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 10:24:43 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED2073D0E36
 for <ltp@lists.linux.it>; Mon, 23 Feb 2026 18:01:28 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3D22420090A
 for <ltp@lists.linux.it>; Mon, 23 Feb 2026 18:01:28 +0100 (CET)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43591b55727so4487520f8f.3
 for <ltp@lists.linux.it>; Mon, 23 Feb 2026 09:01:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771866087; cv=none;
 d=google.com; s=arc-20240605;
 b=JxZqjwb+zc3MVJAttcRZMczw+pYZ4p4P5P3MeI6RDQtx8k9zD5IoA9Vy6FjCggssTt
 LA8U1AAomZplaA4dgw3Z2b8oFdYqovzFxNRNfkHCEnseARLxkrOqhzWkaEV8jvBrMbIq
 v6qX2+Ky6uFh90PrjX6SNjYYooxuMdibYPtVqQzqyBdHSK5jNu5f3JXzRqMqMchtMmf3
 cf16w3Ohc1oKNkApJC7Ha1ApsqWKHRQI1VNmviNi/is0LS+alDlQB7ZdlOi3MdVjznNB
 y/FaYxc/YVsrtiX5JFloxYoEna802GmA9EnjCETDxoLZ8ARngLfdHpHdMb0GfCqDmxIV
 PwYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=c1uuAVGah4iHma6KxBFHJjxcd8KZsM0GNS4D6Im2UHs=;
 fh=PvPWywCZZf3t5kY/HDPCtH2UJHVYREzd3rq64B7Cb2Q=;
 b=AsoCnCHoGsbroSujk+iLgftkEUVjnPKeAyMO6onaPavwTNKIkOC6oqGPpwSXGNtwPQ
 yDXSCkRJJI7wnU4ZHp/Ssy/pV/OYNc0jCPpy7o64Gmyv9VA11+0QSPOZFyFkzSyT/DVi
 82XBI7FsJWkrmGa2WmCVdD77QHqsEGHTWXA8pWbf+DiXYW2DrTpWCq0TEzVzy55AGUqh
 sBj9HGFyLEZFDn9GRmhNNx4tcl2t5dvWBNNSXSskj+J3Ce8r+1X+OUPBmeWvE3lGdU1p
 QVm/h+8Oca6yG77xTALTzZUb8sUylrRaW+/3N/1Mx7P3ej+wi7LhTJw4XypMCXdav8Xd
 JQaw==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1771866087; x=1772470887; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c1uuAVGah4iHma6KxBFHJjxcd8KZsM0GNS4D6Im2UHs=;
 b=LdOwTTtrhJwDfkVGeNelrU7ex8SJ9V0n1nR/cYkBdvmsvT6C03a5lQrE4Vj45tj02E
 THk2euSm+UsG+wJDkb8coPI/hPKmuY/c6dRDBKOS37NS8P8zcbnMZgVTzneeu6hmokJ3
 t/8SLEqIP0gvkDKO2Kgh/A4lrg9tgyjiYumaXlyLOESlmUy5at4AslyqefIZI6FJ7hwZ
 w1r+0QguWKXnVu2+xzZSAi+tp8+Vl5rW16CGqIbwz8mgMvOfnsDRu1Qt9WAB/0MJFDrO
 MPxTkOj25uRTFndylOHq9Fr7MnPTu0jUuFJvedaMCCoErsSb/ES8h/EAh5WdIYy1JaqG
 mXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866087; x=1772470887;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c1uuAVGah4iHma6KxBFHJjxcd8KZsM0GNS4D6Im2UHs=;
 b=Ier1yrtEm9FmdMIJ4VS5jkCHyzIrGz3eCRw/p31VM7bHdj0AdYnSpDPklPK8ONnYji
 5m0c1M1lAgMQXjkkGgURhAfGOclQVzcByeqQigI7WatvbXIxM5CGaEGcdMAvPc4hdszi
 Nx4r5xhI9CwrcCXJuwdgGMBmhsPFr/CloX22XWd1sFmoiWLUTLj295DvrR9kOBX220jI
 NXGU34QwLtLFK4bSkuCnvhr6YYdb0DbRKOSxIzrM8yRipUQZ/bbXh/MZL+wJe5c7cD9o
 J9CsrnzSqOaFw8VRQTRzgMLCFo/6zL5imDnZilXLcbBEoYWpn74svqy9VZ2ACD3YRsOG
 HADQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1VCTKoYIMpefXeg+EadUoysRrOuOjIx9x/4v/NCjnGVp7kKmfcEORmJUdQK30j55148I=@lists.linux.it
X-Gm-Message-State: AOJu0Yx1cj+ustN47rSl+sapQltXVKm+K9KxtYI4kDjrCV+UDdQe0mHZ
 hZ31fuCwWAwLwymgqGD+h3DXWyBm6ypTuLzy1AQHz8vJA3bygAqcKk03CCltGqkAclBUiDCP9f5
 vQBefyqzWTw4PF/RT1dcNrqELH0F35yD6yyAP0tJy0g==
X-Gm-Gg: ATEYQzxaoy0/VJzEqqLqlhxCV6h/AVoGNZ6d9PxZuGxSFHFgPKejUTvuCRzFp2zkYtf
 NdqcjQVJO8wwkg5FA5MkZt02kK/x15Q3OEJjEuDgz71pt4KXv9jgemhByzOPLOzUaj9W9qFnHIK
 zKmp0hbpM7ZBOSItAXKeFuvd5sBnkEe2/y0O9kgI5+rJfDve5qndbwip3XPMe8jZwDQTOTJJiss
 n5NPKaSjSGS0TKXmHZ8ej0hZkKId7XhQzIoakF6QpaPHE1wsgiMNtQZPzuc8Zskh6k9Z1mTKXjH
 bFfq789d0/VlyaFI
X-Received: by 2002:a05:6000:2585:b0:437:72d8:7dd9 with SMTP id
 ffacd0b85a97d-4396f17f814mr16618243f8f.47.1771866085031; Mon, 23 Feb 2026
 09:01:25 -0800 (PST)
MIME-Version: 1.0
References: <20260221135338.26236-2-sebastian.chlad@suse.com>
 <20260222203442.GB417048@pevik> <aZyGMpdvgFXoYjHb@yuki.lan>
In-Reply-To: <aZyGMpdvgFXoYjHb@yuki.lan>
Date: Mon, 23 Feb 2026 18:01:14 +0100
X-Gm-Features: AaiRm53OmXPH8RkqNP4z73n0pyvZ1FStSsNU1bQyyU3Atfv6d0_SN9o4qNHzWCo
Message-ID: <CAJR+Y9J21VqshN2X4JxWfdX4-4PMSEZzEz3krMLk5KpnniLhDw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 24 Feb 2026 10:24:00 +0100
Subject: Re: [LTP] [PATCH] nfs: Adapt the lib to allow to test in 2-host mode
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
From: Sebastian Chlad via ltp <ltp@lists.linux.it>
Reply-To: Sebastian Chlad <sebastian.chlad@suse.com>
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBGZWIgMjMsIDIwMjYgYXQgNTo1NOKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKPgo+IEhpIQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBTZWJhc3RpYW4gQ2hs
YWQgPHNlYmFzdGlhbi5jaGxhZEBzdXNlLmNvbT4KPiA+ID4gLS0tCj4gPiA+ICB0ZXN0Y2FzZXMv
bmV0d29yay9uZnMvbmZzX3N0cmVzcy9uZnNfbGliLnNoIHwgMjIgKysrKysrKysrKysrKysrKyst
LS0tCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMo
LSkKPiA+Cj4gPiA+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMvbmV0d29yay9uZnMvbmZzX3N0cmVz
cy9uZnNfbGliLnNoIGIvdGVzdGNhc2VzL25ldHdvcmsvbmZzL25mc19zdHJlc3MvbmZzX2xpYi5z
aAo+ID4gPiBpbmRleCAxYWM4YmQ2NTcuLmU1MmY5NmE1YSAxMDA2NDQKPiA+ID4gLS0tIGEvdGVz
dGNhc2VzL25ldHdvcmsvbmZzL25mc19zdHJlc3MvbmZzX2xpYi5zaAo+ID4gPiArKysgYi90ZXN0
Y2FzZXMvbmV0d29yay9uZnMvbmZzX3N0cmVzcy9uZnNfbGliLnNoCj4gPiA+IEBAIC00NSw3ICs0
NSw3IEBAIFRTVF9TS0lQX0ZJTEVTWVNURU1TPSJleGZhdCxleHQyLGV4dDMsZnVzZSxudGZzLHZm
YXQsdG1wZnMiCj4gPiA+ICBUU1RfTU9VTlRfREVWSUNFPTEKPiA+ID4gIFRTVF9GT1JNQVRfREVW
SUNFPTEKPiA+ID4gIFRTVF9ORUVEU19ST09UPTEKPiA+ID4gLVRTVF9ORUVEU19DTURTPSIkVFNU
X05FRURTX0NNRFMgbW91bnQgZXhwb3J0ZnMgbW91bnQubmZzIgo+ID4gPiArVFNUX05FRURTX0NN
RFM9IiRUU1RfTkVFRFNfQ01EUyBtb3VudCBtb3VudC5uZnMiCj4KPiBJIGd1ZXNzIHRoYXQgaW4g
dGhlIGZ1cnR1cmUgd2Ugd2FudCBzZXBhcmF0ZSBzY3JpcHRzIGZvciB0aGUgZGlmZmVyZW50Cj4g
aG9zdHMgc28gdGhhdCBlYWNoIG9mIHRoZW0gY2FuIGhhdmUgcHJvcGVyIG1ldGFkYXRhLiBJIHN1
cHBvc2UgdGhhdCB0aGUKPiBUU1RfTU9VTlRfREVWSUNFIGRvZXMgbm90IGFwcGx5IHRvIHRoZSBy
aG9zdCBlaXRoZXIuCj4KPiBBbmQgd2l0aCB0aGF0IHdlIHdvdWxkIG5lZWQgc29tZSBraW5kIG9m
ICJtYXN0ZXIgZmlsZSIgdGhhdCB3b3VsZAo+IGV4cGxhaW4gd2hpY2ggc2NyaXB0IHNob3VsZCBi
ZSBleGVjdXRlZCBvbiB3aGljaCBob3N0IGV0Yy4gQnV0IEkgZ3Vlc3MKPiB0aGF0IGl0IHdvdWxk
IGJlIHRyaWNreSB0byBkZXNpbmcgdGhpcyBwcm9wZXJseS4KCk9yIGF0IGxlYXN0IGl0cyBhIGJp
dCBvZiBhIGxvbmd0ZXJtIGFzIEkgc2VlIGl0LiBBcyBvZiBub3csIGluIHRoZQoyLWhvc3QgTkZT
IHNldHVwLCBJIGluc3RhbGwgbmZzLXNlcnZlciBjb21wb25lbnRzIHRvIGFydGlmaWNpYWxseQpz
YXRpc2Z5IHRoZSB0ZXN0J3MgcmVxdWlyZW1lbnRzLgpUaGUgcGF0Y2ggaXMgdGhlIGVhc2llc3Qg
d2F5IHRvIHVudGFuZ2xlIHRoYXQsIEFGQUlLLgoKY2hlZXJzLApTZWIvCgo+Cj4gLS0KPiBDeXJp
bCBIcnViaXMKPiBjaHJ1YmlzQHN1c2UuY3oKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6
Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
