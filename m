Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3468C54E66
	for <ltp@archiver.kernel.org>; Fri, 15 Mar 2024 04:09:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DFD5C3D170D
	for <ltp@archiver.kernel.org>; Fri, 15 Mar 2024 05:09:37 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D6E703CE997
 for <ltp@lists.linux.it>; Fri, 15 Mar 2024 05:09:22 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C53A5201113
 for <ltp@lists.linux.it>; Fri, 15 Mar 2024 05:09:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710475760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6MEtjprF+/BO6Xd+qMZyz6oC3bY4W29zUQNdOCmueAs=;
 b=GikQ6u0JeIlPPl0GiAIGb+4jPyg3wWvpQ4SQrSKJV55FILOchZE1Z/7GlI3IyV9n+BqYzi
 vjSSVmmS014X4E92s/qBc7OrIk90BYHmXQgXzG37dgos0c9CZfF6IDZ4MKglnQh6cTWYwd
 k4XexGmiF+jD2quMK/z5RIVxj4DIVzw=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-5Jfn_3biPZ6nz0K95uO9SA-1; Fri, 15 Mar 2024 00:09:17 -0400
X-MC-Unique: 5Jfn_3biPZ6nz0K95uO9SA-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5c66a69ec8eso1116133a12.3
 for <ltp@lists.linux.it>; Thu, 14 Mar 2024 21:09:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710475755; x=1711080555;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6MEtjprF+/BO6Xd+qMZyz6oC3bY4W29zUQNdOCmueAs=;
 b=hIaSQzOX5sy4KRTv5B7OE+Wi6YlD/rqaA7sBwCYGR7V1ye2k4lxq/bhRZCmJN5nTzc
 RKp4Sl+zlPIw32dFsuw/Qh5k3KI+J5mIzxWPgmys8rhCBCVgKbPukqEtMZaZ/n1URvzX
 qOOXXnSZgE49P4106/UBX1Kup4QEoNaBoYtk8Cbu/WsIsZr4CGALin0lolx2qsf3rxv4
 jwOnFRpVBrpBVBH9OV16Lqi//D1OwNXXXacseWSOocOJ2HL6SNeiv6QU+4cTYv/yQLpC
 SSG4KbBKRmPeZiiXB7xRcZuJjvOlZ7O2RypF82e4XUxh3GeNmUkf/GjYUGojtX38v1AG
 CVsA==
X-Gm-Message-State: AOJu0Yy9+Z/prsKmpMtNpsBx5nG9qvu7z6NhGwJB7ryqayx2BLVtHHrN
 XaBjWsyuXctHNGKvMMQ0RUb+v510atDs3TVGHQyr2cAuMNx7BkLehqvHO+wokdZDLLqlYvn6BYp
 AsZSVPvbbxmTA42WnEscKG1Ny2A7ZaXaQ3yuYc9LOj8zrzuiNfpxrHR58d8beOQo5TliJHttUuX
 IGzQptltpFGXDGk3DbyPZpjUAQ7KSBSY9HUzfMY38=
X-Received: by 2002:a05:6a20:548a:b0:1a3:3fbd:f859 with SMTP id
 i10-20020a056a20548a00b001a33fbdf859mr3970389pzk.2.1710475755088; 
 Thu, 14 Mar 2024 21:09:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFYJTwxifKw6rN2uB/ncsSVqf5vfNxpqCJ9KvQoLGzMsZFjvpJ4rRtIswu/ZjxCBS6sZ5FPLJ2YyQj1ojbq+o=
X-Received: by 2002:a05:6a20:548a:b0:1a3:3fbd:f859 with SMTP id
 i10-20020a056a20548a00b001a33fbdf859mr3970378pzk.2.1710475754773; Thu, 14 Mar
 2024 21:09:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240314013320.5536-1-wegao@suse.com>
 <CAEemH2dn7zRijqq-ZmxsS7CSh2__dzVzpP9ZsPh3APmYWvu=mg@mail.gmail.com>
 <ZfOkrcg5Kt9l59Ss@wegao.68.199.193>
 <CAEemH2dgxRPG1xRQRFdyFPjr+awKL33Fp5xgdMAA=3=t-K19VQ@mail.gmail.com>
 <ZfPEHJNRH16jRQAU@wegao.185.0.200>
In-Reply-To: <ZfPEHJNRH16jRQAU@wegao.185.0.200>
From: Li Wang <liwang@redhat.com>
Date: Fri, 15 Mar 2024 12:09:02 +0800
Message-ID: <CAEemH2erkkB5Mj_WiGjErK-Z5Dc7bY_2D7Lu-nBpsqyFeo=8sA@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v1] swapon01.c: Apply a margin to avoid oom
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

T24gRnJpLCBNYXIgMTUsIDIwMjQgYXQgMTE6NDTigK9BTSBXZWkgR2FvIDx3ZWdhb0BzdXNlLmNv
bT4gd3JvdGU6Cgo+IE9uIEZyaSwgTWFyIDE1LCAyMDI0IGF0IDExOjE3OjAxQU0gKzA4MDAsIExp
IFdhbmcgd3JvdGU6Cj4gPiBPbiBGcmksIE1hciAxNSwgMjAyNCBhdCA5OjMw4oCvQU0gV2VpIEdh
byA8d2VnYW9Ac3VzZS5jb20+IHdyb3RlOgo+ID4KPiA+ID4gT24gVGh1LCBNYXIgMTQsIDIwMjQg
YXQgMDI6NDA6NDBQTSArMDgwMCwgTGkgV2FuZyB3cm90ZToKPiA+ID4gPiBIaSBXZWksCj4gPiA+
ID4KPiA+ID4gPiBPbiBUaHUsIE1hciAxNCwgMjAyNCBhdCA5OjMz4oCvQU0gV2VpIEdhbyB2aWEg
bHRwIDxsdHBAbGlzdHMubGludXguaXQ+Cj4gPiA+IHdyb3RlOgo+ID4gPiA+Cj4gPiA+ID4gPiBE
dXJpbmcgb3VyIHRlc3QgaSBmaW5kIGEgb29tIGVycm9yIGR1cmluZyB0ZXN0IHdoaWNoIHRyaWdn
ZXJlZCBieQo+ID4gPiA+ID4gdHN0X3BvbGx1dGVfbWVtb3J5Lgo+ID4gPiA+ID4KPiA+ID4gPiA+
IGtlcm5lbDoKPiA+ID4gPiA+Cj4gPiA+Cj4gb29tLWtpbGw6Y29uc3RyYWludD1DT05TVFJBSU5U
X01FTUNHLG5vZGVtYXNrPShudWxsKSxjcHVzZXQ9LyxtZW1zX2FsbG93ZWQ9MC0xLG9vbV9tZW1j
Zz0vbHRwL3Rlc3QtOTU1Mix0YXNrX21lbWNnPS9sdHAvdGVzdC05NTUyMAo+ID4gPiA+ID4ga2Vy
bmVsOiBNZW1vcnkgY2dyb3VwIG91dCBvZiBtZW1vcnk6IEtpbGxlZCBwcm9jZXNzIDk1NzUgKHN3
YXBvbjAxKQo+ID4gPiA+ID4gdG90YWwtdm06MTA1MTQ4NGtCLCBhbm9uLXJzczoxMDQ2NTcya0Is
IGZpbGUtcnNzOjEyODBrQiwKPiBzaG1lbS1yc3M6MGswCj4gPiA+ID4gPgo+ID4gPiA+ID4gU2ln
bmVkLW9mZi1ieTogV2VpIEdhbyA8d2VnYW9Ac3VzZS5jb20+Cj4gPiA+ID4gPiAtLS0KPiA+ID4g
PiA+ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N3YXBvbi9zd2Fwb24wMS5jIHwgNCArKyst
Cj4gPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQo+ID4gPiA+ID4KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL3N3YXBvbi9zd2Fwb24wMS5jCj4gPiA+ID4gPiBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvc3dhcG9uL3N3YXBvbjAxLmMKPiA+ID4gPiA+IGluZGV4IGQ0MDZlNGJkOS4uMzU3OTkyNTI1
IDEwMDY0NAo+ID4gPiA+ID4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zd2Fwb24v
c3dhcG9uMDEuYwo+ID4gPiA+ID4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zd2Fw
b24vc3dhcG9uMDEuYwo+ID4gPiA+ID4gQEAgLTQxLDcgKzQxLDkgQEAgc3RhdGljIHZvaWQgc2V0
dXAodm9pZCkKPiA+ID4gPiA+ICAgICAgICAgbWFrZV9zd2FwZmlsZShTV0FQX0ZJTEUsIDEwLCAw
KTsKPiA+ID4gPiA+Cj4gPiA+ID4gPiAgICAgICAgIFNBRkVfQ0dfUFJJTlRGKHRzdF9jZywgImNn
cm91cC5wcm9jcyIsICIlZCIsIGdldHBpZCgpKTsKPiA+ID4gPiA+IC0gICAgICAgU0FGRV9DR19Q
UklOVEYodHN0X2NnLCAibWVtb3J5Lm1heCIsICIlbHUiLCBURVNUTUVNKTsKPiA+ID4gPiA+ICsK
PiA+ID4gPiA+ICsgICAgICAgLyogQXBwbHkgYSBtYXJnaW4gdG8gYXZvaWQgb29tIGR1cmluZyB0
c3RfcG9sbHV0ZV9tZW1vcnkgKi8KPiA+ID4gPiA+ICsgICAgICAgU0FGRV9DR19QUklOVEYodHN0
X2NnLCAibWVtb3J5Lm1heCIsICIlbHUiLCBURVNUTUVNICsKPiA+ID4gVEVTVE1FTS8xMDApOwo+
ID4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+IEV2ZW4gd2l0aCBhIGJpdCBvZiBtYXJnaW4gYWRkZWQg
dGhlcmUgaXMgc3RpbGwgbm90IGd1YXJhbnRlZSB0bwo+IGF2b2lkIE9PTQo+ID4gPiA+IGNvbXBs
ZXRlbHkuCj4gPiA+ID4KPiA+ID4gPiBBcyB0aGUgQ2dyb3VwIFYxIGFuZCBWMiB0cmFjayBtZW1v
cnkgYW5kIHN3YXAgaW4gdHdvIHdheXMsIGlmIHRoZQo+IG1hcmdpbgo+ID4gPiBpcwo+ID4gPiA+
IHRvbyBsYXJnZSB0aGF0IG1pZ2h0IG5vdCBtYWtlIHRoZSBzd2FwIGhhcHBlbiB3aGljaCBpcyBu
b3Qgb3VyCj4gPiA+IGV4cGVjdGF0aW9uLgo+ID4gPiA+Cj4gPiA+ID4gU28gb3RoZXIgbWV0aG9k
IEkgY2FuIHRoaW5rIG9mIGlzIHRvIGRpc2FibGUgdGhlIE9PTSBpbiBDZ291cCwKPiA+ID4gPiAg
ICAgZWNobyAxID4gbWVtb3J5Lm9vbV9jb250cm9sCj4gPiA+IFRoaXMgb3B0aW9uIG5vdCBleGlz
dCBpbiBjZ3JvdXB2MiwgaXQgc2VlbXMgbm8gZGlyZWN0IG9vbSBjb250cm9sIGZvcgo+ID4gPiBj
Z3JvdXB2Mgo+ID4gPgo+ID4KPiA+IE9rLCB3aGljaCB2ZXJzaW9uIChmb3VuZCB0aGUgT09NIGlz
c3VlKSBkaWQgeW91IHRlc3Qgb24/Cj4gbW91bnQgfCBncmVwIGNncm91cAo+IGNncm91cDIgb24g
L3N5cy9mcy9jZ3JvdXAgdHlwZSBjZ3JvdXAyCj4gKHJ3LG5vc3VpZCxub2Rldixub2V4ZWMscmVs
YXRpbWUsbnNkZWxlZ2F0ZSxtZW1vcnlfcmVjdXJzaXZlcHJvdCkKPiA+IE1heWJlIGhlcmUgd2Ug
aGF2ZSB0byBzcGxpdCB0aGUgY29udHJvbCB3b3JrIGludG8gdHdvIHBhcnRzIChWMSBhbmQgVjIp
Lgo+CgoKPiBIb3cgdG8gZGlzYWJsZSBPT00gYW5kIGFsc28gbGV0IHN3YXAgYWN0aW9uIGhhcHBl
biBhdCB0aGUgc2FtZSB0aW1lIGZvcgo+IGNncm91cCBWMj8KPgoKVGhlIENncm91cCB2MiBkb2Vz
IG5vdCBwcm92aWRlIGEgd2F5IHRvIGRpc2FibGUgT09NIGluc2lkZSBkaXJlY3RseS4KCklmIHdl
IHdhbnQgdG8gYXZvaWQgT09NIGhhcHBlbmluZywganVzdCBoYXZlIHRvIG1hbmFnZSBPT00gYmVo
YXZpb3IKaW4gY2dyb3VwIHYyIGJ5IHNldHRpbmcgYXBwcm9wcmlhdGUgdmFsdWVzIGZvciAnbWVt
b3J5Lm1heCcsICdtZW1vcnkuaGlnaCcsCmFuZCB1c2luZyAnbWVtb3J5Lm9vbS5ncm91cCcgdG8g
ZGV0ZXJtaW5lIHdoZXRoZXIgdGhlIE9PTSBraWxsZXIgc2hvdWxkCnRhcmdldCBpbmRpdmlkdWFs
IHByb2Nlc3NlcyBvciB0aGUgd2hvbGUgQ2dyb3VwLgoKQWZ0ZXIgbG9va2luZyBiYWNrIGF0IHRo
aXMgY2FzZSBhZ2FpbiwgSSBndWVzcyB0aGUgbWFpbiByZWFzb24gaXMgdGhhdCB0aGUKc3dhcGZp
bGUgaXMgdG9vIHNtYWxsIHRvIGJlYXIgdGhlIG1lbW9yeSBsb2FkLCBvbmUgZGlyZWN0IG1ldGhv
ZCBpcyBsaWtlCnlvdSB0byBlbmxhcmdlIHRoZSAnbWVtb3J5Lm1heCcgdmFsdWUsIGJ1dCB0aGF0
IHN0aWxsIGRvZXMgbm90IHJlc29sdmUKcHJvYmxlbXMgZXZlbnR1YWxseS4KCk9uZSBwb3NzaWJs
ZSBzb2x1dGlvbiBpcyBjcmF0ZSBhIGJpdCBsYXJnZXIgc3dhcGZpbGUgZm9yIHRoZSB0ZXN0LCBh
bmQKdW5saW1pdGVkCnRoZSBzd2FwIG91dCBzaXplLiBDYW4geW91IHRyeSB0aGlzIHBhdGNoIG9u
IHlvdXIgc3lzdGVtPwoKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zd2Fwb24vc3dh
cG9uMDEuYworKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N3YXBvbi9zd2Fwb24wMS5j
CkBAIC0zOCwxMCArMzgsMTQgQEAgc3RhdGljIHZvaWQgdmVyaWZ5X3N3YXBvbih2b2lkKQogc3Rh
dGljIHZvaWQgc2V0dXAodm9pZCkKIHsKICAgICAgICBpc19zd2FwX3N1cHBvcnRlZChTV0FQX0ZJ
TEUpOwotICAgICAgIG1ha2Vfc3dhcGZpbGUoU1dBUF9GSUxFLCAxMCwgMCk7CisgICAgICAgbWFr
ZV9zd2FwZmlsZShTV0FQX0ZJTEUsIDEwMjQsIDApOwoKICAgICAgICBTQUZFX0NHX1BSSU5URih0
c3RfY2csICJjZ3JvdXAucHJvY3MiLCAiJWQiLCBnZXRwaWQoKSk7CiAgICAgICAgU0FGRV9DR19Q
UklOVEYodHN0X2NnLCAibWVtb3J5Lm1heCIsICIlbHUiLCBURVNUTUVNKTsKKyAgICAgICBpZiAo
VFNUX0NHX1ZFUl9JU19WMSh0c3RfY2csICJtZW1vcnkiKSkKKyAgICAgICAgICAgICAgIFNBRkVf
Q0dfUFJJTlRGKHRzdF9jZywgIm1lbW9yeS5zd2FwLm1heCIsICIlbHUiLCB+MFVMKTsKKyAgICAg
ICBlbHNlCisgICAgICAgICAgICAgICBTQUZFX0NHX1BSSU5UKHRzdF9jZywgIm1lbW9yeS5zd2Fw
Lm1heCIsICJtYXgiKTsKIH0KCiBzdGF0aWMgc3RydWN0IHRzdF90ZXN0IHRlc3QgPSB7CgoKLS0g
ClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5s
aW51eC5pdC9saXN0aW5mby9sdHAK
