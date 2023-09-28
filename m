Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC59CE7B09
	for <ltp@archiver.kernel.org>; Thu, 28 Sep 2023 07:56:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F1A4F3C9944
	for <ltp@archiver.kernel.org>; Thu, 28 Sep 2023 09:56:50 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 35A043C993F
 for <ltp@lists.linux.it>; Thu, 28 Sep 2023 09:56:40 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 32DB6616620
 for <ltp@lists.linux.it>; Thu, 28 Sep 2023 09:56:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695887797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6YAl3l8s0XAVc7/i13O1Hm9fQYqNveJy5kn2sssxeYA=;
 b=XwElqR/Eg8O3O+D+hdwoAhTVjHuEyPo3N9efgzF/mJVZPHvKvL0hke90QoU5NuV6VDCDqg
 FzgUc+3tANoq5HXOJDZPIg6tJuxQ6WxtCB2hzm6Hjrjk/7upNUYM1vhEaGlqw4bl9A86FO
 4knl1stb/BWjB1VhXerJ1OO0UPtWjr4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-erQH2ryxNkqxVNGkdzxAdw-1; Thu, 28 Sep 2023 03:56:34 -0400
X-MC-Unique: erQH2ryxNkqxVNGkdzxAdw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5042bc93273so18103816e87.1
 for <ltp@lists.linux.it>; Thu, 28 Sep 2023 00:56:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695887793; x=1696492593;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6YAl3l8s0XAVc7/i13O1Hm9fQYqNveJy5kn2sssxeYA=;
 b=kyw65tjT5hWxjIGtKQaw0a3b1F1LcbJScLN7hLZ7pTLCrwF9u45eiwANt589P0N1kd
 FGgtB1Qc8sksW18m4Qor4Qagx9s4XtvtpOCJtojMwX7q8DSRrvHrYfEXVQ0T7ETG/j6j
 27d7Ybu/Qtr0Ea4nGXapVtwfp+jacMFyZOSSxElgBy71zpUYxwlHDvvQi3SigpntTA/1
 Kx7GQU+Rf9GzloTfI2kxZvTJica21GZW1+5zb/lI+olmjQP1ajGVMr6gmvtrRiupaAcL
 xdlg8kWK+Y7B6TgpS/D2diflRZdAXnyvPbER/UBqaum1/QmJyKvopxseznNoXMveMqAf
 N+pA==
X-Gm-Message-State: AOJu0YwUjACTX0vAA4mamLlpeYuC5fEuubw08RcdLenIJZiBNRFIRYtZ
 8yLarSaPa4eQHGKFMpMk9rpmH0Vd4TzvPxEftRiL+CcR2FTk1QgkWgowXiTirCLfMsiupl1QOcQ
 CDqmKT/oI0/LfvmTZaZYDkTmcW54=
X-Received: by 2002:a05:6512:68b:b0:504:369d:f11c with SMTP id
 t11-20020a056512068b00b00504369df11cmr620014lfe.34.1695887793071; 
 Thu, 28 Sep 2023 00:56:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQznzwoTJGgRJ9YD8Q71ElNAGSiPpZublboaIPv7f0BIcfKfiesOc0Bct5wQdevQdZzsJdgMenb7rQr5fSb00=
X-Received: by 2002:a05:6512:68b:b0:504:369d:f11c with SMTP id
 t11-20020a056512068b00b00504369df11cmr619993lfe.34.1695887792709; Thu, 28 Sep
 2023 00:56:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230927202121.300325-1-pvorel@suse.cz>
In-Reply-To: <20230927202121.300325-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Thu, 28 Sep 2023 15:56:20 +0800
Message-ID: <CAEemH2c0LDiPty6RpOa7GLOEAhgEzkVQK49w6w9iVYxiRCrMeQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 0/6] Release scripts and docs
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

TmljZSB3b3JrIQoKSSBkaWRuJ3QgdmVyaWZ5IHRoZSBzaGVsbCBzY3JpcHQgd29yayBidXQgZ2Vu
ZXJhbGx5IGxvb2tzIGdvb2QuCkl0IHNob3VsZCBiZSBzYWZlIHRvIGFkZCB0aG9zZSBwYXRjaGVz
IGluIHRoZSBuZXcgcmVsZWFzZQphcyBtb3N0IGNoYW5nZXMgZm9jdXMgb24gZG9jdW1lbnRhdGlv
bi4KClJldmlld2VkLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KCgpPbiBUaHUsIFNl
cCAyOCwgMjAyMyBhdCA0OjIx4oCvQU0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+IHdyb3Rl
OgoKPiBUTDtEUgo+ICogIkxUUCBSZWxlYXNlIFByb2NlZHVyZSIgd2lraSBwYWdlIGlzICh0ZW1w
b3JhcmlseSkgdmlzaWJsZSBvbjoKPiBodHRwczovL2dpdGh1Yi5jb20vcGV2aWsvbHRwL3dpa2kv
VEVTVAo+Cj4gTk9URSBkdWUgYSBwdWJsaWMgaG9saWRheSBpbiB0aGUgQ3plY2ggUmVwdWJsaWMg
dG9tb3Jyb3csIEkgZG9uJ3QgZXhwZWN0Cj4gQ3lyaWwgd2lsbCBoYXZlIHRpbWUgdG8gaGF2ZSBs
b29rIGludG8gdGhpcyBiZWZvcmUgcmVsZWFzZSAod2hpY2ggc2hvdWxkCj4gYmUgb24gRnJpZGF5
KS4KPgo+IENoYW5nZXMgdjEtPnYyOgo+ICJMVFAgUmVsZWFzZSBQcm9jZWR1cmUiIHdpa2kgcGFn
ZQo+ICogQ3JlYXRlICIxLiBSZWxlYXNlIHByZXBhcmF0aW9ucyIgcGFyYWdyYXBoLCB1c2UgQ3ly
aWwncyB0ZXh0IGZvciBpdC4KPiAqIEFkZCBzZWN0aW9uICIyLiBQcmVwYXJlIHRoZSByZWxlYXNl
IG5vdGVzIiAoaW1wb3J0YW50IHBhcnQgYXMgd2hpY2ggdGFrZXMKPiAgIHNvbWUgdGltZSwgdGh1
cyBkZXNlcnZlIGl0J3Mgb3duIHNlY3Rpb24sIDV0aCBzZWN0aW9uIHdpdGggc2VuZGluZwo+ICAg
YW5ub3VuY2VtZW50IGlzIG9mIGNvdXJzZSBrZXB0KS4KPiAqIEtlcHQgY29tbWFuZCBleGFtcGxl
cyAoTGkpLCB1cGRhdGUgdGhlbSAoZS5nLiBub3QgcHVzaGluZyBhbGwgdGFncywKPiAgIGJ1dCBv
bmx5IG9uZSBjcmVhdGVkIC0gdGhpcyBjYW4gYXZvaWQgcHVzaGluZyB0YWdzIGZyb20gZm9ya3Mg
LSBlLmcuCj4gICBmcm9tIEFPU1ApLgo+ICogTWVudGlvbiB0b29scy90YWctcmVsZWFzZS5zaCB0
b29scy9jcmVhdGUtdGFyYmFsbHMtbWV0YWRhdGEuc2ggc2NyaXB0cy4KPiAqIHMvMjAyMzA1MTYv
WVlZWU1NREQvIGluIHdpa2kgZG9jIChwcmV2aW91cyB0YWcga2VwdCBhcyAyMDIzMDEyNywgQ3ly
aWwpLgo+Cj4gdG9vbHMvdGFnLXJlbGVhc2Uuc2gKPiAqIFJlbW92ZSBza2VsZXRvbiBnZW5lcmF0
aW9uIChDeXJpbCkuCj4KPiBPdGhlcgo+ICogcmVzZW5kICJSZW1vdmUgTWFrZWZpbGUucmVsZWFz
ZSIgaW4gdGhpcyBzZXJpZXMuCj4gKGl0J3Mgc2VwYXJhdGVkLCBidXQgbGV0J3MgcmVtb3ZlIGl0
IG9uY2Ugd2UgYWdyZWUgb24gdGhpcykuCj4KPiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgo+Cj4gUGV0
ciBWb3JlbCAoNik6Cj4gICB0b29sczogQWRkIGEgc2NyaXB0IGZvciB0YWdnaW5nIHRoZSByZWxl
YXNlCj4gICB0b29sczogQWRkIHNjcmlwdCBmb3IgY3JlYXRpbmcgdGFyYmFsbHMgYW5kIG1ldGFk
YXRhCj4gICBkb2M6IFJlbmFtZSBmaWxlcyB0byBuYW1lcyBmcm9tIGx0cC53aWtpLmdpdAo+ICAg
ZG9jOiBBZGQgUmVsZWFzZSBwcm9jZWR1cmUKPiAgIGRvYzogVXBkYXRlIHJlbGVhc2UgcHJvY2Vk
dXJlCj4gICBSZW1vdmUgTWFrZWZpbGUucmVsZWFzZQo+Cj4gIC5naXRodWIvd29ya2Zsb3dzL3dp
a2ktbWlycm9yLnltbCAgICAgICAgICAgICB8ICAxNiArLQo+ICBNYWtlZmlsZS5yZWxlYXNlICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNDYgLS0tLS0KPiAgLi4uaWxkLXN5c3RlbS1n
dWlkZS50eHQgPT4gQnVpbGQtU3lzdGVtLnJlc3R9IHwgICAwCj4gIGRvYy97Yy10ZXN0LWFwaS50
eHQgPT4gQy1UZXN0LUFQSS5hc2NpaWRvY30gICB8ICAgMAo+ICAuLi5tcGxlLnR4dCA9PiBDLVRl
c3QtQ2FzZS1UdXRvcmlhbC5hc2NpaWRvY30gfCAgIDAKPiAgLi4uLWMtYXBpLnR4dCA9PiBDLVRl
c3QtTmV0d29yay1BUEkuYXNjaWlkb2N9IHwgICAwCj4gIC4uLmt2bS10ZXN0LWFwaS50eHQgPT4g
S1ZNLVRlc3QtQVBJLmFzY2lpZG9jfSB8ICAgMAo+ICAuLi5QLUxpYnJhcnktQVBJLVdyaXRpbmct
R3VpZGVsaW5lcy5hc2NpaWRvY30gfCAgIDAKPiAgZG9jL0xUUC1SZWxlYXNlLVByb2NlZHVyZS5h
c2NpaWRvYyAgICAgICAgICAgIHwgMTgzICsrKysrKysrKysrKysrKysrKwo+ICAuLi5haW50YWlu
ZXItUGF0Y2gtUmV2aWV3LUNoZWNrbGlzdC5hc2NpaWRvY30gfCAgIDAKPiAgLi4ubC10ZXN0LWFw
aS50eHQgPT4gU2hlbGwtVGVzdC1BUEkuYXNjaWlkb2N9IHwgICAwCj4gIC4uLmtlcm5lbCwtbGli
YywtdG9vbGNoYWluLXZlcnNpb25zLmFzY2lpZG9jfSB8ICAgMAo+ICAuLi5zLnR4dCA9PiBUZXN0
LVdyaXRpbmctR3VpZGVsaW5lcy5hc2NpaWRvY30gfCAgIDAKPiAgLi4uc2VyLWd1aWRlLnR4dCA9
PiBVc2VyLUd1aWRlbGluZXMuYXNjaWlkb2N9IHwgICAwCj4gIHRvb2xzL2NyZWF0ZS10YXJiYWxs
cy1tZXRhZGF0YS5zaCAgICAgICAgICAgICB8ICA1NiArKysrKysKPiAgdG9vbHMvbGliLnNoICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDMxICsrKwo+ICB0b29scy90YWctcmVs
ZWFzZS5zaCAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNDUgKysrKysKPiAgMTcgZmlsZXMg
Y2hhbmdlZCwgMzE4IGluc2VydGlvbnMoKyksIDU5IGRlbGV0aW9ucygtKQo+ICBkZWxldGUgbW9k
ZSAxMDA2NDQgTWFrZWZpbGUucmVsZWFzZQo+ICByZW5hbWUgZG9jL3tidWlsZC1zeXN0ZW0tZ3Vp
ZGUudHh0ID0+IEJ1aWxkLVN5c3RlbS5yZXN0fSAoMTAwJSkKPiAgcmVuYW1lIGRvYy97Yy10ZXN0
LWFwaS50eHQgPT4gQy1UZXN0LUFQSS5hc2NpaWRvY30gKDEwMCUpCj4gIHJlbmFtZSBkb2Mve2Mt
dGVzdC10dXRvcmlhbC1zaW1wbGUudHh0ID0+IEMtVGVzdC1DYXNlLVR1dG9yaWFsLmFzY2lpZG9j
fQo+ICgxMDAlKQo+ICByZW5hbWUgZG9jL3tuZXR3b3JrLWMtYXBpLnR4dCA9PiBDLVRlc3QtTmV0
d29yay1BUEkuYXNjaWlkb2N9ICgxMDAlKQo+ICByZW5hbWUgZG9jL3trdm0tdGVzdC1hcGkudHh0
ID0+IEtWTS1UZXN0LUFQSS5hc2NpaWRvY30gKDEwMCUpCj4gIHJlbmFtZSBkb2Mve2xpYnJhcnkt
YXBpLXdyaXRpbmctZ3VpZGVsaW5lcy50eHQgPT4KPiBMVFAtTGlicmFyeS1BUEktV3JpdGluZy1H
dWlkZWxpbmVzLmFzY2lpZG9jfSAoMTAwJSkKPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRvYy9MVFAt
UmVsZWFzZS1Qcm9jZWR1cmUuYXNjaWlkb2MKPiAgcmVuYW1lIGRvYy97bWFpbnRhaW5lci1wYXRj
aC1yZXZpZXctY2hlY2tsaXN0LnR4dCA9Pgo+IE1haW50YWluZXItUGF0Y2gtUmV2aWV3LUNoZWNr
bGlzdC5hc2NpaWRvY30gKDEwMCUpCj4gIHJlbmFtZSBkb2Mve3NoZWxsLXRlc3QtYXBpLnR4dCA9
PiBTaGVsbC1UZXN0LUFQSS5hc2NpaWRvY30gKDEwMCUpCj4gIHJlbmFtZSBkb2Mve3N1cHBvcnRl
ZC1rZXJuZWwtbGliYy12ZXJzaW9ucy50eHQgPT4KPiBTdXBwb3J0ZWQta2VybmVsLC1saWJjLC10
b29sY2hhaW4tdmVyc2lvbnMuYXNjaWlkb2N9ICgxMDAlKQo+ICByZW5hbWUgZG9jL3t0ZXN0LXdy
aXRpbmctZ3VpZGVsaW5lcy50eHQgPT4KPiBUZXN0LVdyaXRpbmctR3VpZGVsaW5lcy5hc2NpaWRv
Y30gKDEwMCUpCj4gIHJlbmFtZSBkb2Mve3VzZXItZ3VpZGUudHh0ID0+IFVzZXItR3VpZGVsaW5l
cy5hc2NpaWRvY30gKDEwMCUpCj4gIGNyZWF0ZSBtb2RlIDEwMDc1NSB0b29scy9jcmVhdGUtdGFy
YmFsbHMtbWV0YWRhdGEuc2gKPiAgY3JlYXRlIG1vZGUgMTAwNzU1IHRvb2xzL2xpYi5zaAo+ICBj
cmVhdGUgbW9kZSAxMDA3NTUgdG9vbHMvdGFnLXJlbGVhc2Uuc2gKPgo+IC0tCj4gMi40MC4xCj4K
PgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9s
aXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
