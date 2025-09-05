Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 946FBCA1010
	for <ltp@archiver.kernel.org>; Fri,  5 Sep 2025 07:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1757057849; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=pEBsT25AJ7VIJhpu6kPh4YmOqP6BdNE9E8Pzk1Eg8EU=;
 b=eGCHjzp7fkKy/AlsFrs2VEv0/RxexdASBUUBRKdbHdiRrkItzFwCCZmHitLWLVCUjcPp6
 RRL3+G2Nj39+KKoqSMXYmPO+0/ugg4131xvQWN8tZfai27tRiAMPT9BKXL50REAUSN1mC+C
 E5+460D3a1XGT3iESrWprGbNqRWRLNg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 61E8A3CD4E4
	for <ltp@archiver.kernel.org>; Fri,  5 Sep 2025 09:37:29 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CB38F3C6CF0
 for <ltp@lists.linux.it>; Fri,  5 Sep 2025 09:37:08 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A77096009D8
 for <ltp@lists.linux.it>; Fri,  5 Sep 2025 09:37:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757057825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pwFJWQm04rrwlD5UQMVJKCCfgRzucZICQ06GZoLrbi0=;
 b=XW5+9o6052X3shEO+1LWMPd1y/rWw7OBnGbVYDjq2hlKjIgXDVXYvpF408JVYIa7nKLBDL
 o28eqB1pafGvC4474PRHolCbVh64eAJBgqcxRJvqCC0Pu/e1qUWREOaRBU8M+DV36HZyt9
 eWksMY6krMO4pXxPZO3hQjgZ4yUnSAY=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-5AX5QkLmPDOCwADfn1KUuA-1; Fri, 05 Sep 2025 03:37:03 -0400
X-MC-Unique: 5AX5QkLmPDOCwADfn1KUuA-1
X-Mimecast-MFC-AGG-ID: 5AX5QkLmPDOCwADfn1KUuA_1757057823
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b4fbcfd821eso1406009a12.0
 for <ltp@lists.linux.it>; Fri, 05 Sep 2025 00:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757057821; x=1757662621;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pwFJWQm04rrwlD5UQMVJKCCfgRzucZICQ06GZoLrbi0=;
 b=Amo3Q651ag8JhK3Iib5evNv+oyBLsIJ8Yo4pcO1wOs+4T0nxDPyewEWpJt8vzxFuQj
 EDEP+ZZiQyfN5W6GZgUmEwwV3j6I9R/QKD8Iw2YIN/dbs61cZbPLaExl8zSlSsmXv6zU
 +8+zBP8PakYQ9EZap4AxC+YysNcc1Yt3NnZu0ZoKv9MJ6RhclH3+wX+8yOBf3nmzDzNB
 gE9GpA4cWjTlKU7RUYy0HA84K8Ha8olJEkgo7QrDGcCF8U8aZ+kYv2Ui5ELmtYUpd4XR
 PrAbLFo2Z+aO1StH0QeoKJkqWbd4jG3KAW1Pidj+ND3KasOd5kNcvnp3UNxFBgRaMDn4
 el+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhPO+GxTQ80smQxLAyffTcSwiZV5Vjy4Pjj3XEyo73ULIuCmie/OQej87t+PUfX3yZIXk=@lists.linux.it
X-Gm-Message-State: AOJu0YwAaV2kxUJCXc2O5ovMRTmE7JE5roQqySrBCJWtxEYJewSn1VlP
 W4KA9FYlzTXLQmR6GEfRA0jvimWyrNJTE2epalB3+41z70yPmMnMlZOsdCSXjZ4B1eqZnHlAeFB
 76kdzEMpeviOea/jHXOan2KkETi/nrY1QV/6x/4bei74A6V3thGc6D3ZXzQ+cTez47NXYsxXMCY
 pKr1zY785HpaBOMF5zrtZ3qtbCNbySrejLj0uWng==
X-Gm-Gg: ASbGnctF2UcO7bGAyvMkhkUwEptgneYA4P1YMGLbquzvUnyEyoJvCKqEDHppB+u9UZ9
 PiUzKaXnkpXTMpKusHVdVpd9UcE7/hPsJCLIM9lsDoa+y5BstDW81JKLQfA+0lqBltcLkUmU/MO
 p+7Vl7x/4qhVZP1B/kRsq9+Q==
X-Received: by 2002:a05:6a20:9191:b0:24a:8315:7f3 with SMTP id
 adf61e73a8af0-24a83150a5dmr9553327637.58.1757057821054; 
 Fri, 05 Sep 2025 00:37:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwlQl4Oo+7RmciUo/cpH28Ju7gwEuV0CgF2QMbbZJtXwXK7K1prfvtCmwX30XkOYUq+6MMxaL+yrqikENWuis=
X-Received: by 2002:a05:6a20:9191:b0:24a:8315:7f3 with SMTP id
 adf61e73a8af0-24a83150a5dmr9553295637.58.1757057820633; Fri, 05 Sep 2025
 00:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250904102609.133359-1-liwang@redhat.com>
 <20250904110018.GA56668@pevik> <aLl7ConfYPBglqhx@rei.lan>
 <CAEemH2f=6MRZTk95ZctgPG-MKdyw5oK9WNgh3Tm8WNHQ9NcW_g@mail.gmail.com>
 <aLmwLn9RDo2qmk7K@yuki.lan>
 <CAEemH2cK3idxQHmpSGs8VuWSOosHrFNYK=ic0s90B_WNh7AVjw@mail.gmail.com>
 <CAEemH2cXQ=_F=Bq5CZN1j=SbeceDCKCdZh4jDdGSz-x10XZLtA@mail.gmail.com>
 <20250905070312.GA4185@pevik> <20250905073127.GA16065@pevik>
In-Reply-To: <20250905073127.GA16065@pevik>
Date: Fri, 5 Sep 2025 15:36:48 +0800
X-Gm-Features: Ac12FXzHZA_JOoGLxPObZfmV3vrk18s1cRXQ5TB4b5hSP1lnApfsloY4JYQ5anc
Message-ID: <CAEemH2eFCcFsiQPJ_94_ChxsXUmKx133ikDDo=RWzikk108PuQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3sZMnw9hzeh_KS5bjGYLYb1BmlCWc2BU86JQnTVC3yI_1757057823
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] sched_football: synchronize with kickoff flag
 to reduce skew
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

T24gRnJpLCBTZXAgNSwgMjAyNSBhdCAzOjMx4oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgoKPiA+IEhpIGFsbCwKPgo+ID4gLi4uCj4gPiA+IENoZWNraW5nIHRoZSBjb25m
aWd1cmF0aW9ucyBvZiB0aGUgc3RvY2sga2VybmVsIGFuZCB0aGUgcmVhbC10aW1lCj4gPiA+IGtl
cm5lbCwgdGhlIHN0b2NrIGtlcm5lbCB1c2VzICJDT05GSUdfUFJFRU1QVF9WT0xVTlRBUlk9eSwi
Cj4gPiA+IHdoaWNoIG9ubHkgcHJvdmlkZXMgdm9sdW50YXJ5IHByZWVtcHRpb24uCj4KPiA+IFll
cywgQ09ORklHX1BSRUVNUFRfVk9MVU5UQVJZPXkgaXMgaW4gYWxsIG1haW5saW5lIGRlZmNvbmZp
Z3MKPiA+IChhcmNoLyovY29uZmlncy8qX2RlZmNvbmZpZykuIFRoZXJlZm9yZSB3ZSBoYXZlIGl0
IGluIG91ciBUdW1ibGV3ZWVkCj4gKDYuMTYuMy0xKQo+ID4gYW5kIGluIHVwY29taW5nIFNMRVMx
NiAoNi4xMiBiYXNlZCkuIFNMRTE1LVNQNyAoNi40IGJhc2VkKSB1c2UKPiA+IENPTkZJR19QUkVF
TVBUX05PTkU9eSBpbnN0ZWFkLgo+Cj4gPiBMb29raW5nIGF0IHRoZSBoaXN0b3J5IEl0IHdvcmtz
IHdlbGwgb24gYWxsIGFyY2hzLCB3ZSBqdXN0IHJlY2VudGx5IGhhZCBhCj4gPiBwcm9ibGVtIHdp
dGggcHBjNjRsZSBobWMgb24gU0xFMTYgKHJlZ3VsYXIgcHBjNjRsZSB3b3JrcykuIExhdGVyIEkn
bGwKPiBjaGVjawo+ID4gaGlzdG9yeSBvZiBvbGRlciBTTEVTIHZlcnNpb25zLgo+Cj4gPiBBbmQg
bW9zdCBpbXBvcnRhbnRseSBJJ2xsIHRyeSB0byBydW4gbWFudWFsbHkgd2l0aCAtaSAobW9yZSBz
dHJlc3MgdGVzdCkuCj4KPiA+ID4gVGhpcyBwcmVlbXB0aW9uIG1vZGVsIGlzIGRlc2lnbmVkIHRv
IHN0cmlrZSBhIGJhbGFuY2UgYmV0d2Vlbgo+IHRocm91Z2hwdXQKPiA+ID4gYW5kIGxhdGVuY3ku
IEl0IG9ubHkgYWxsb3dzIHRoZSBrZXJuZWwgdG8gYmUgcHJlZW1wdGVkIGF0IHNwZWNpZmljLAo+
IHdlbGwKPiA+ID4gZGVmaW5lZAo+ID4gPiAic2FmZSBwb2ludHMsIiBwb3RlbnRpYWxseSByZXN1
bHRpbmcgaW4gbG9uZywgdW5ib3VuZGVkIGxhdGVuY2llcy4KPgo+ID4gPiBIb3dldmVyLCB0aGUg
c2NoZWRfZm9vdGJhbGwgdGVzdCB3YXMgbW9zdCBsaWtlbHkgZGVzaWduZWQgdG8gbWVhc3VyZSBv
cgo+ID4gPiBzdHJlc3MtdGVzdCB0aGUgZGV0ZXJtaW5pc3RpYywgbG93LWxhdGVuY3kgc2NoZWR1
bGluZyBiZWhhdmlvciB0aGF0IGlzCj4gPiA+IGNoYXJhY3RlcmlzdGljIG9mIHJlYWwtdGltZSAo
UlQpIGtlcm5lbC4KPgo+ID4gPiBTbywgSSB0ZW5kIHRvIGJlbGlldmUgdGhlIHRlc3QncyBmYWls
dXJlIG9uIHRoZSBzdG9jayBrZXJuZWwgaXMKPiBhY2NlcHRhYmxlLgo+ID4gPiBBbmQsIGJ5IHRo
ZSB3YXksIHdoYXQgZG9lcyB0aGUgU1VTRSBrZXJuZWwgY29uZmlndXJhdGlvbiBsb29rIGxpa2U/
Cj4KPgo+ID4gPiAjIGdyZXAgQ09ORklHX1BSRUVNUFQgL2Jvb3QvY29uZmlnLTYuMTIuMC01NS4y
OS4xLmVsMTBfMC54ODZfNjQKPiA+ID4gQ09ORklHX1BSRUVNUFRfQlVJTEQ9eQo+ID4gPiBDT05G
SUdfUFJFRU1QVF9WT0xVTlRBUlk9eQo+ID4gPiAjIENPTkZJR19QUkVFTVBUIGlzIG5vdCBzZXQK
PiA+ID4gIyBDT05GSUdfUFJFRU1QVF9SVCBpcyBub3Qgc2V0Cj4gPiA+IENPTkZJR19QUkVFTVBU
X0NPVU5UPXkKPiA+ID4gQ09ORklHX1BSRUVNUFRJT049eQo+ID4gPiBDT05GSUdfUFJFRU1QVF9E
WU5BTUlDPXkKPiA+ID4gQ09ORklHX1BSRUVNUFRfUkNVPXkKPiA+ID4gQ09ORklHX1BSRUVNUFRf
Tk9USUZJRVJTPXkKPgo+ID4gPiAoXiBJIGJ1aWx0IG15IHY2LjE3LXJjNCB3aXRoIHRoaXMgY29u
ZmlnIHRvbykKPgo+ID4gL2Jvb3QvY29uZmlnLTYuMTIuMC0xNjAwMDAuNC1kZWZhdWx0ICMgVHVt
Ymxld2VlZCB4NjhfNjQKPiA+IENPTkZJR19QUkVFTVBUX0JVSUxEPXkKPiA+ICMgQ09ORklHX1BS
RUVNUFRfTk9ORSBpcyBub3Qgc2V0Cj4gPiBDT05GSUdfUFJFRU1QVF9WT0xVTlRBUlk9eQo+ID4g
IyBDT05GSUdfUFJFRU1QVCBpcyBub3Qgc2V0Cj4gPiAjIENPTkZJR19QUkVFTVBUX0xBWlkgaXMg
bm90IHNldAo+ID4gIyBDT05GSUdfUFJFRU1QVF9SVCBpcyBub3Qgc2V0Cj4gPiBDT05GSUdfUFJF
RU1QVF9DT1VOVD15Cj4gPiBDT05GSUdfUFJFRU1QVElPTj15Cj4gPiBDT05GSUdfUFJFRU1QVF9E
WU5BTUlDPXkKPiA+IENPTkZJR19QUkVFTVBUX1JDVT15Cj4gPiBDT05GSUdfUFJFRU1QVF9OT1RJ
RklFUlM9eQo+ID4gIyBDT05GSUdfUFJFRU1QVF9UUkFDRVIgaXMgbm90IHNldAo+ID4gQ09ORklH
X1BSRUVNUFRJUlFfREVMQVlfVEVTVD1tCj4KPiA+IFVwY29taW5nIFNMRTE2IGlzIHNpbWlsYXIg
dG8gVHVtYmxld2VlZC4KPgo+ID4gL2Jvb3QvY29uZmlnLTYuNC4wLTE1MDcwMC43MTQuZ2E4ZTcw
MTctZGVmYXVsdCAjIFNMRTE1LVNQNyB4ODZfNjQgUlQKPiA+IENPTkZJR19QUkVFTVBUX0JVSUxE
PXkKPiA+IENPTkZJR19QUkVFTVBUX05PTkU9eQo+ID4gIyBDT05GSUdfUFJFRU1QVF9WT0xVTlRB
UlkgaXMgbm90IHNldAo+ID4gIyBDT05GSUdfUFJFRU1QVCBpcyBub3Qgc2V0Cj4gPiAjIENPTkZJ
R19QUkVFTVBUX1JUIGlzIG5vdCBzZXQKPiA+IENPTkZJR19QUkVFTVBUX0NPVU5UPXkKPiA+IENP
TkZJR19QUkVFTVBUSU9OPXkKPiA+IENPTkZJR19QUkVFTVBUX0RZTkFNSUM9eQo+ID4gQ09ORklH
X1BSRUVNUFRfUkNVPXkKPiA+IENPTkZJR19QUkVFTVBUX05PVElGSUVSUz15Cj4gPiAjIENPTkZJ
R19QUkVFTVBUX1RSQUNFUiBpcyBub3Qgc2V0Cj4gPiBDT05GSUdfUFJFRU1QVElSUV9ERUxBWV9U
RVNUPW0KPgo+ID4gL2Jvb3QvY29uZmlnLTYuNC4wLTE1MDcwMC41LXJ0ICMgU0xFMTUtU1A3IHg4
Nl82NCBSVAo+ID4gQ09ORklHX1BSRUVNUFRfTEFaWT15Cj4gPiAjIENPTkZJR19QUkVFTVBUX05P
TkUgaXMgbm90IHNldAo+ID4gIyBDT05GSUdfUFJFRU1QVF9WT0xVTlRBUlkgaXMgbm90IHNldAo+
ID4gIyBDT05GSUdfUFJFRU1QVCBpcyBub3Qgc2V0Cj4gPiBDT05GSUdfUFJFRU1QVF9SVD15Cj4g
PiBDT05GSUdfUFJFRU1QVF9DT1VOVD15Cj4gPiBDT05GSUdfUFJFRU1QVElPTj15Cj4gPiBDT05G
SUdfUFJFRU1QVF9SQ1U9eQo+ID4gQ09ORklHX1BSRUVNUFRfTk9USUZJRVJTPXkKPiA+ICMgQ09O
RklHX1BSRUVNUFRfVFJBQ0VSIGlzIG5vdCBzZXQKPiA+IENPTkZJR19QUkVFTVBUSVJRX0RFTEFZ
X1RFU1Q9bQo+Cj4gQW5kIGxvb2tpbmcgb24gc29tZSBvdGhlciBkaXN0cm9zLCBlLmcuIERlYmlh
biBoYWQKPiBDT05GSUdfUFJFRU1QVF9WT0xVTlRBUlk9eSBvbgo+IDYuMTIuMzgrZGViMTMgKGZy
b20gcmVjZW50bHkgcmVsZWFzZWQgc3RhYmxlIERlYmlhbiAxMyB0cml4aWUpLCBidXQgdGhleQo+
IGNoYW5nZWQKPiBpdCB0byBDT05GSUdfUFJFRU1QVF9MQVpZPXkgaW4gNi4xNi4zK2RlYjE0IChm
b3IgdXBjb21pbmcgRGViaWFuIGZvcmt5Cj4gKHRlc3RpbmcpCj4gLSBpbiBkZXZlbCBmb3Igbm93
KS4gSSB3b3VsZCBleHBlY3QgdGhhdCBzZXR1cCBmb3IgUlQga2VybmVsLgo+Cj4gPiBLaW5kIHJl
Z2FyZHMsCj4gPiBQZXRyCj4KPiA+ID4gIyBncmVwIENPTkZJR19QUkVFTVBUIC9ib290L2NvbmZp
Zy02LjEyLjAtNTUuMzEuMS5lbDEwXzAueDg2XzY0K3J0Cj4gPiA+IENPTkZJR19QUkVFTVBUX0JV
SUxEPXkKPiA+ID4gQ09ORklHX1BSRUVNUFQ9eQo+ID4gPiBDT05GSUdfUFJFRU1QVF9SVD15Cj4g
PiA+IENPTkZJR19QUkVFTVBUX0NPVU5UPXkKPiA+ID4gQ09ORklHX1BSRUVNUFRJT049eQo+ID4g
PiAjIENPTkZJR19QUkVFTVBUX0RZTkFNSUMgaXMgbm90IHNldAo+ID4gPiBDT05GSUdfUFJFRU1Q
VF9SQ1U9eQo+ID4gPiBDT05GSUdfUFJFRU1QVF9OT1RJRklFUlM9eQo+Cj4gSSBzdXBwb3NlIHRo
aXMgUlQga2VybmVsIGhhcyBDT05GSUdfUFJFRU1QVF9MQVpZPXksIHJpZ2h0Pwo+CgpOb3QgZXhh
Y3RseSwgSSByZW1vdmVkIHNvbWUgdW5lbmFibGluZyBvcHRpb25zIHdoZW4gcG9zdGluZy4KSXQg
aGFzICdDT05GSUdfQVJDSF9IQVNfUFJFRU1QVF9MQVpZJy4KClRoZSBmdWxsIHByZWVtcHQgY29u
ZmlnIGxvb2tzIGxpa2U6CgojIGdyZXAgUFJFRU1QVCAvYm9vdC9jb25maWctNi4xMi4wLTU1LjMx
LjEuZWwxMF8wLng4Nl82NCtydApDT05GSUdfUFJFRU1QVF9CVUlMRD15CkNPTkZJR19BUkNIX0hB
U19QUkVFTVBUX0xBWlk9eQpDT05GSUdfUFJFRU1QVD15CiMgQ09ORklHX1BSRUVNUFRfTEFaWSBp
cyBub3Qgc2V0CiMgQ09ORklHX1BSRUVNUFRfTEFaSUVTVCBpcyBub3Qgc2V0CkNPTkZJR19QUkVF
TVBUX1JUPXkKQ09ORklHX1BSRUVNUFRfQ09VTlQ9eQpDT05GSUdfUFJFRU1QVElPTj15CiMgQ09O
RklHX1BSRUVNUFRfRFlOQU1JQyBpcyBub3Qgc2V0CkNPTkZJR19QUkVFTVBUX1JDVT15CkNPTkZJ
R19IQVZFX1BSRUVNUFRfRFlOQU1JQz15CkNPTkZJR19IQVZFX1BSRUVNUFRfRFlOQU1JQ19DQUxM
PXkKQ09ORklHX1BSRUVNUFRfTk9USUZJRVJTPXkKQ09ORklHX0RSTV9JOTE1X1BSRUVNUFRfVElN
RU9VVD02NDAKQ09ORklHX0RSTV9JOTE1X1BSRUVNUFRfVElNRU9VVF9DT01QVVRFPTc1MDAKQ09O
RklHX0RSTV9YRV9QUkVFTVBUX1RJTUVPVVQ9NjQwMDAwCkNPTkZJR19EUk1fWEVfUFJFRU1QVF9U
SU1FT1VUX01BWD0xMDAwMDAwMApDT05GSUdfRFJNX1hFX1BSRUVNUFRfVElNRU9VVF9NSU49MQpD
T05GSUdfREVCVUdfUFJFRU1QVD15CiMgQ09ORklHX1BSRUVNUFRfVFJBQ0VSIGlzIG5vdCBzZXQK
IyBDT05GSUdfUFJFRU1QVElSUV9ERUxBWV9URVNUIGlzIG5vdCBzZXQKCgo+IEtpbmQgcmVnYXJk
cywKPiBQZXRyCj4KPgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5m
bzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
