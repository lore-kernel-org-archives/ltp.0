Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A0AC3ABCC
	for <ltp@archiver.kernel.org>; Wed, 14 May 2025 11:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747221354; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=zo/msRePTjcsznNeRFBd/EU7k8OAeamXFV6QNXg0fGc=;
 b=eYQzDLXNLJxltEPLt6Rfq6cONdItiz0fKXLIl1ZC8vQ1UCi0Y8Q2muocMIxU3/44n0M/f
 XmBXPv57vBtozNA+fTlSw1N0vJ2lpDxkKJXP8OoFZdZ23Ng+05GUGcERsynbkLvtFWeWBL1
 nMIFsM6cb81gkDnHwgNV4wctcesZxmw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E58AE3CC3A5
	for <ltp@archiver.kernel.org>; Wed, 14 May 2025 13:15:54 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A08D23C96C9
 for <ltp@lists.linux.it>; Wed, 14 May 2025 13:15:31 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0DA5510000C0
 for <ltp@lists.linux.it>; Wed, 14 May 2025 13:15:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747221329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=feOqAVqZKwtLxIdqg+GfgwLRb+obU9WqflSHOKTKv9U=;
 b=RbXZ/CLGnmLy2WI4NYD8Wg6bOhavvNs13K07AVyW/OWERmwBohweo12jgGXGi+dwlveuui
 cFJjcMUri6H1BG1vvJ7+Zp5LqCWkWYxNUGiv9WxPH9aRz5V7Ko5tfXL1oZDRhxOGGneHk4
 bjE+yjw7JPyxGMtlel+6b2q2JkjTCUE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-d5ulBLYoNiuMPuv_hSDanQ-1; Wed, 14 May 2025 07:15:27 -0400
X-MC-Unique: d5ulBLYoNiuMPuv_hSDanQ-1
X-Mimecast-MFC-AGG-ID: d5ulBLYoNiuMPuv_hSDanQ_1747221327
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a1c86b62e8so2501632f8f.1
 for <ltp@lists.linux.it>; Wed, 14 May 2025 04:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747221326; x=1747826126;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=feOqAVqZKwtLxIdqg+GfgwLRb+obU9WqflSHOKTKv9U=;
 b=YVsO158UBdjz5VqQiwgH5ger04lm5D9GFdoEiG0RTVdVGQyy6Zcb11sYTLkX8lpi8n
 MaOtR7yaf9IA82QMFjDJh5AeEKIK4Y6Tstem8N1WJsHvwIJAqYVI0ihryYYfqsAgfX2V
 2KuxBpZpaasjA/4tmYQ3DQxUaSZ4Ii9OgjzoyIOSDW5WjT3RqV+z2N/2I+QzIv4GVfcs
 Ogn4fSwN1P351kntV+zz+RlNTyYCps2ymi0Lu6TpylsvcPLfKHUIqkmpunm6qaOLpWp1
 3pwqQm3pZfcZWaAnHx+iLzoc0TdFJju2rRSBWE/P9H1DzJj4TModEen2r9+oyfiS1EL4
 I5kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOiF7I1pESLB8wWxHRHxfXJf/z0PXHjKBi7PWumbn349QDY0OjuYjkZEUQSg+Q4bO+O/g=@lists.linux.it
X-Gm-Message-State: AOJu0YxxEW/jF6OLo8ltqA00Wvk3qPds5kYKNNunZXPwd3KmWmY2tsE2
 L9EcFHWevXKXH1/GGw02fMSdQAqHm0Gd/Ri3Hg9FMqZBUDtQJTIxikcvqf4qLapzXyfyczSQkjr
 sWy+ip2xMuGgeOL/lp6io8Zot/z2H+ebX+N4ekNwtPVlkN/8UN1EQhzw3ATY7PJ3bfHtYBeW0Xy
 HZ7JmpOy584arilEgmLKnQwfc=
X-Gm-Gg: ASbGncvvkhOXHMlJqhvr4hoKsvOMOUyz5jaCqbBy56syMYYGg0qhMLyn3GDOdhMwJV1
 xKqTlUXKMhuZcXhxr2TuHQJt0F/nitTRfcKWAY4REv+oZ7zCk3adTv/Wv/Vxz8iTYBMOz
X-Received: by 2002:a05:6000:2584:b0:3a0:9fe1:c2ac with SMTP id
 ffacd0b85a97d-3a3496a4fa7mr2473201f8f.22.1747221326590; 
 Wed, 14 May 2025 04:15:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWUvKG8lUvB/RyXCzuE90eK+gQ4p3ndDj+NOwpn7WYvvFGVMHzVCHIA12tzEHnmJEqUg5nBX0X1ngzXqIacng=
X-Received: by 2002:a05:6000:2584:b0:3a0:9fe1:c2ac with SMTP id
 ffacd0b85a97d-3a3496a4fa7mr2473180f8f.22.1747221326226; Wed, 14 May 2025
 04:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250416191645.355088-1-wegao@suse.com>
 <20250428160421.3457215-1-wegao@suse.com>
 <aBt7ck35Dq8GIKHc@yuki.lan>
 <CAASaF6y+e6eKMONT2FdgsLJyhGzZPswQNqthQpneEqpte+-6pQ@mail.gmail.com>
 <aCNox5FGkPsLWGf2@MiWiFi-CR6608-srv>
 <CAASaF6yRO-_dX-ktapqAcWyqU-jwf2k8cJ9+Q7XAN7sqkngz8A@mail.gmail.com>
 <CAEemH2dWyGyHXngTSghnAUmyF+DS0GNvKatVR9CuTpMEZc-rPQ@mail.gmail.com>
 <CAASaF6xNg8AeQMRscHY_gsqQGxw=wPhYiwquuHVKLSgZEYDoFA@mail.gmail.com>
 <CAEemH2fFUdjmqsNvFBk5mRjn+2xm62HJZx48Qug4jMdVBJNnsA@mail.gmail.com>
In-Reply-To: <CAEemH2fFUdjmqsNvFBk5mRjn+2xm62HJZx48Qug4jMdVBJNnsA@mail.gmail.com>
Date: Wed, 14 May 2025 13:15:09 +0200
X-Gm-Features: AX0GCFt-vdR4qNuBGHHAIMjFV6C4xSpagaiTKUuDGjIpwDtFep6hvlEU8bXyzu4
Message-ID: <CAASaF6zONvCb8p_ATDTS2Ma1rs=ZvHA03i3=xqLHbKH2ZOCPWw@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SpB1hBcf0h09LtTg_lCF0NVVwsK0Xtx55H1Qbh05Qcg_1747221327
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] mmap22.c: Test for new MAP_DROPPABLE flag for
 mmap
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
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBNYXkgMTQsIDIwMjUgYXQgMTE6MTTigK9BTSBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0
LmNvbT4gd3JvdGU6Cj4KPiBPbiBXZWQsIE1heSAxNCwgMjAyNSBhdCA1OjEw4oCvUE0gSmFuIFN0
YW5jZWsgPGpzdGFuY2VrQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIFdlZCwgTWF5IDE0
LCAyMDI1IGF0IDExOjA04oCvQU0gTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+
ID4gPgo+ID4gPiBPbiBXZWQsIE1heSAxNCwgMjAyNSBhdCA0OjUy4oCvUE0gSmFuIFN0YW5jZWsg
dmlhIGx0cCA8bHRwQGxpc3RzLmxpbnV4Lml0PiB3cm90ZToKPiA+ID4gPgo+ID4gPiA+IE9uIFR1
ZSwgTWF5IDEzLCAyMDI1IGF0IDU6NDTigK9BTSBXZWkgR2FvIDx3ZWdhb0BzdXNlLmNvbT4gd3Jv
dGU6Cj4gPiA+ID4gPgo+ID4gPiA+ID4gT24gTW9uLCBNYXkgMTIsIDIwMjUgYXQgMTA6NDM6NTVB
TSArMDIwMCwgSmFuIFN0YW5jZWsgd3JvdGU6Cj4gPiA+ID4gPiA+IElzIGFueW9uZSBlbHNlIHNl
ZWluZyB0aGlzIHRlc3QgZmFpbGluZyBvbiByZWNlbnQgNi4xNS1yYzUga2VybmVscz8KPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gPT09PSBtbWFwMjIgPT09PQo+ID4gPiA+ID4gPiBjb21tYW5kOiBt
bWFwMjIKPiA+ID4gPiA+ID4gdHN0X3RtcGRpci5jOjMxNjogVElORk86IFVzaW5nIC90bXAvTFRQ
X21tYXpDVUxOTiBhcyB0bXBkaXIgKHRtcGZzIGZpbGVzeXN0ZW0pCj4gPiA+ID4gPiA+IHRzdF90
ZXN0LmM6MTkzODogVElORk86IExUUCB2ZXJzaW9uOiAyMDI1MDEzMC0yNTMtZzRhMGUzYThmYQo+
ID4gPiA+ID4gPiB0c3RfdGVzdC5jOjE5NDI6IFRJTkZPOiBUZXN0ZWQga2VybmVsOgo+ID4gPiA+
ID4gPiA2LjE1LjAtMC5yYzUuMjUwNTA5ZzljNjlmODg4NDkwNC40Ny5lbG4xNDgueDg2XzY0ICMx
IFNNUAo+ID4gPiA+ID4gPiBQUkVFTVBUX0RZTkFNSUMgRnJpIE1heSAgOSAxNToxNzozMSBVVEMg
MjAyNSB4ODZfNjQKPiA+ID4gPiA+ID4gdHN0X2tjb25maWcuYzo4ODogVElORk86IFBhcnNpbmcg
a2VybmVsIGNvbmZpZwo+ID4gPiA+ID4gPiAnL2xpYi9tb2R1bGVzLzYuMTUuMC0wLnJjNS4yNTA1
MDlnOWM2OWY4ODg0OTA0LjQ3LmVsbjE0OC54ODZfNjQvYnVpbGQvLmNvbmZpZycKPiA+ID4gPiA+
ID4gdHN0X3Rlc3QuYzoxNzU4OiBUSU5GTzogT3ZlcmFsbCB0aW1lb3V0IHBlciBydW4gaXMgMGgg
MDVtIDU0cwo+ID4gPiA+ID4gPiBtbWFwMjIuYzo1NTogVEZBSUw6IE1BUF9EUk9QUEFCTEUgZGlk
IG5vdCBkcm9wIG1lbW9yeSB3aXRoaW4gdGhlIHRpbWVvdXQgcGVyaW9kLgo+ID4gPiA+ID4gPgo+
ID4gPiA+ID4KPiA+ID4gPiA+IEkgaGF2ZSB0ZXN0ZWQgcmM1LzYgYW5kIGJvdGggZ2l2ZSBwYXNz
IHJlc3VsdC4KPiA+ID4gPgo+ID4gPiA+IEkgZG8gc2VlIGl0IGZhaWwgYWxtb3N0IGRhaWx5IG9u
IG11bHRpcGxlIGFyY2hlcyAoVk1zIGFuZCBiYXJlbWV0YWwpLAo+ID4gPiA+IG1heWJlIHNvbWUg
ZGlmZmVyZW5jZSBpbiBvdXIgY29uZmlnLgo+ID4gPgo+ID4gPiBIYXZlIHlvdSB0cmllZCB0aGUg
b3JpZ2luYWwgc2VsZi10ZXN0ICh3aXRob3V0IHVzaW5nIENncm91cCk/Cj4gPiA+IElmIGl0IHN0
aWxsIGZhaWxzLCBjb25zaWRlciBpdCBhIGtlcm5lbCBpc3N1ZS4KPiA+Cj4gPiBJJ2xsIGhhdmUg
YSBjbG9zZXIgbG9vayBhbmQgdHJ5IG1hbnVhbGx5LiBBdCBmaXJzdCBnbGFuY2UgYXQgdGVzdCwg
SQo+ID4gc3VzcGVjdCBjb21waWxlcgo+ID4gZG9pbmcgc29tZXRoaW5nIGNsZXZlciBmb3I6Cj4g
PiAgICAgICAgICAgICAgICAgZm9yICg7OykKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICoo
Y2hhciAqKW1hbGxvYyhwYWdlX3NpemUpID0gJ0InOwo+Cj4gUHJvYmFibHksICAtTzIgaXMgdGhl
IGRlZmF1bHQgaW4gTFRQIGNvbXBpbGluZy4KPgo+IE9yLCB5b3UgY291bGQgYWxzbyB0cnkgZGlz
YWJsaW5nIEtTTSB3aGVuIHRlc3RpbmcgbW1hcDIyLmMgdG8gc2VlIGlmIGl0IGhlbHBzLgoKSW4g
Y2FzZSBvZiBteSBWTSwgaXQgbG9va3MgbGlrZSBpdCdzIGFibGUgdG8gc3dhcCBmYXN0ZXIgdGhh
biB3aGF0J3MKbmVlZGVkIHRvIGRyb3AgdGhlIGFsbG9jYXRpb24uCldpdGggdGhpcyBJIGdldCBQ
QVNTIHJpZ2h0IGF3YXk6CgpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9t
bWFwL21tYXAyMi5jCmIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tbWFwL21tYXAyMi5jCmlu
ZGV4IDBlNTg5ZGZhYi4uNTZmZTQxMmQxIDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5
c2NhbGxzL21tYXAvbW1hcDIyLmMKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tbWFw
L21tYXAyMi5jCkBAIC0zMiw2ICszMiw3IEBAIHN0YXRpYyB2b2lkIHRlc3RfbW1hcCh2b2lkKQoK
ICAgICAgICBjZ19jaGlsZCA9IHRzdF9jZ19ncm91cF9tayh0c3RfY2csICJjaGlsZCIpOwogICAg
ICAgIFNBRkVfQ0dfUFJJTlRGKHRzdF9jZywgIm1lbW9yeS5tYXgiLCAiJWQiLCBNRU1fTElNSVQp
OworICAgICAgIFNBRkVfQ0dfUFJJTlRGKHRzdF9jZywgIm1lbW9yeS5zd2FwLm1heCIsICIlZCIs
IDEpOwogICAgICAgIFNBRkVfQ0dfUFJJTlRGKGNnX2NoaWxkLCAiY2dyb3VwLnByb2NzIiwgIiVk
IiwgZ2V0cGlkKCkpOwoKICAgICAgICBhbGxvYyA9IFNBRkVfTU1BUCgwLCBhbGxvY19zaXplLCBQ
Uk9UX1JFQUQgfCBQUk9UX1dSSVRFLAoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9s
aXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
