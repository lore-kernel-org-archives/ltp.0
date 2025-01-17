Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF52C02183
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 09:35:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B7ECE3C7C31
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 10:35:04 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A81AD3C2EE4
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 10:34:47 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 730B9604833
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 10:34:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737106484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/qxbqhWUNLn5ThnKzEnAi+485vGHgkpgXoWJk/Y3NSQ=;
 b=eRvxHgw/1XH3VYsuNBz/1M8U1oKVeKfVy8UFkt9pitbi7itgp7KSCv1ydy6SCkcQUQt1we
 1yvAIR2ogEC5Em9eh7IcHDzB7o2D+kzs0Hd51/F5XlIj05JWzTgGv6MlwEIiZmhSBRx9uz
 qm1uTYLgEnTMwn3hXZZWbvt2w6x9z5E=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-Q-AuRvADOTa_XWF6EvBwag-1; Fri, 17 Jan 2025 04:34:42 -0500
X-MC-Unique: Q-AuRvADOTa_XWF6EvBwag-1
X-Mimecast-MFC-AGG-ID: Q-AuRvADOTa_XWF6EvBwag
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2f780a3d6e5so1139391a91.0
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 01:34:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737106481; x=1737711281;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/qxbqhWUNLn5ThnKzEnAi+485vGHgkpgXoWJk/Y3NSQ=;
 b=UtpoZF4LGzMydt+oLT/hv9JfG5zw1hO3ESG0dvwXZGNcXzCpo6knesARIIqbjLRNTA
 DizqTT3kHRTrs2VIV0bPwyzhpNT3knwC3Yb26silc4pG+zrm5VlUNvpSOvgc3QwREy9I
 e3BTHYRz1LnazJUA8DdtIFAsLZC0i1mUvhJ4FK00u36xh3QYQFpgMRLQcBi8H2o1rMZH
 6mFKYxL0YpyUEpFd2ypIpHd/m0VVEsQQotm0Ph6FOF3t08smGjELmKYV7LMmedGpITnt
 EVAuDzx5Iq4aXyl15ECrTSk1EYdk7squ+q3dwol/Zp7jFtlklCKUu7MT7n+azegE2Vr/
 qjrQ==
X-Gm-Message-State: AOJu0Yw4f3R3NxR/HjlCEsjOSzmInYY+tt0rYWlUSTPSBB6eXyH24I8x
 H5LyM5QPJQO6wdalDzOXSLoJNOqcnypSH8CI+a737nmc2pXMjzfGqFUbcIXXHU0XJfwRUZgVHKJ
 xgwZobAI2cH2JUq8BuN7d3nqBMthsRQDLzp0HsyLtGEK7qebKkIlvClnaxkuUpmYD7CfgE6hH82
 9aDI3GzBmk6BIskwRCnxlVM6A=
X-Gm-Gg: ASbGncuS0bOjtNUvfKyJrd8yyLw9ujwO3UQGboxNhAIqajg9QML2wzkvh/6DUWMb8By
 UezRXqr70KpmrdX/dhXF7mEeIFH/2CNElbCPnPKQ=
X-Received: by 2002:a17:90b:5344:b0:2ee:d63f:d73 with SMTP id
 98e67ed59e1d1-2f782c90af3mr3090362a91.11.1737106481604; 
 Fri, 17 Jan 2025 01:34:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9hplO/hPFIr/vGlrN2GwrlSO178xSBSLaNnHWVkDfVPMb9hG8cOR83yXeqF10N46lYAJds9m971T9LnQEDC4=
X-Received: by 2002:a17:90b:5344:b0:2ee:d63f:d73 with SMTP id
 98e67ed59e1d1-2f782c90af3mr3090347a91.11.1737106481324; Fri, 17 Jan 2025
 01:34:41 -0800 (PST)
MIME-Version: 1.0
References: <20250117084118.740225-1-pvorel@suse.cz>
 <CAEemH2c82HAwMdWJ7a5WPLzHTJWA-dhunXuJQdt4WK4zWdpPYg@mail.gmail.com>
 <20250117091603.GA742253@pevik>
 <CAEemH2fKfuXhBMaYA6W9=f1ML0m81qfBjxPGQRMSswGKFeMxyQ@mail.gmail.com>
In-Reply-To: <CAEemH2fKfuXhBMaYA6W9=f1ML0m81qfBjxPGQRMSswGKFeMxyQ@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 17 Jan 2025 17:34:28 +0800
X-Gm-Features: AbW1kvabr9UENapsztoZBlHUlMboFqW3jAiy3QJc9nO2f3Cq4f8YhAggrpjpdD4
Message-ID: <CAEemH2ehgw1RsgGVnyceKtj-i_uoahce=hWpam2Cs7ECxqemxA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BA6ToLCZFZLXuRsUBBjzSA6dWEB4JPue0iy-aPB4rwE_1737106482
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 1/1] lib: Multiply slow config only for a real
 tests
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

T24gRnJpLCBKYW4gMTcsIDIwMjUgYXQgNToyNuKAr1BNIExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKCj4KPgo+IE9uIEZyaSwgSmFuIDE3LCAyMDI1IGF0IDU6MTbigK9QTSBQZXRy
IFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cj4KPj4gPiBPbiBGcmksIEphbiAxNywgMjAy
NSBhdCA0OjQx4oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgo+Pgo+PiBU
TDtEUjogd3JvbmcgcGF0Y2gsIHBsZWFzZSBpZ25vcmUgaXQuCj4+Cj4+IC4uLgo+PiA+ID4gK3N0
YXRpYyBpbmxpbmUgaW50IGZvbyh1bnNpZ25lZCBpbnQgdGltZW91dCkKPj4KPj4KPj4gPiBXaGF0
IGlzIHRoZSBmb28oKSB1c2VkIGZvcj8KPj4KPj4gSSdtIHNvcnJ5LCBJIG5vdGljZWQgdGhpcyBh
ZnRlciBzZW5kaW5nIGFzIHdlbGwuIEJ1dCBnb3Qgc2xvdyBkb3duIGR1ZQo+PiBUU1RfTk9fREVG
QVVMVF9NQUlOIGluIHRzdF90ZXN0LmMgYXMgd2VsbC4KPj4KPj4gPiA+ICtzdGF0aWMgaW5saW5l
IGludCB0c3RfbXVsdGlwbHlfb25fc2xvd19jb25maWcodW5zaWduZWQgaW50IHRpbWVvdXQpCj4+
ID4gPiArewo+PiA+ID4gKyNpZm5kZWYgVFNUX05PX0RFRkFVTFRfTUFJTgo+PiA+ID4gKyAgICAg
ICBpZiAodHN0X2hhc19zbG93X2tjb25maWcoKSkKPj4gPiA+ICsgICAgICAgICAgICAgICB0aW1l
b3V0ICo9IDQ7Cj4+ID4gPiArI2VuZGlmIC8qIFRTVF9OT19ERUZBVUxUX01BSU4gKi8KPj4gPiA+
ICsgICAgICAgcmV0dXJuIHRpbWVvdXQ7Cj4+ID4gPiArfQo+Pgo+Pgo+PiA+IEJ1dCB0aGUgdHN0
X3Rlc3QuYyBoYXMgZGVmaW5lZCB0aGUgVFNUX05PX0RFRkFVTFRfTUFJTiBtYWNybwo+PiA+IHNv
IGl0IHdpbGwgZ28gY29tcGxpZSB3aXRoIHRoZSBzZWNvbmQgYnJhbmNoIGFsd2F5cy4KPj4KPj4g
PiBJT1csIHRoZSB0c3RfaGFzX3Nsb3dfa2NvbmZpZygpIHdpbGwgbmV2ZXIgYmUgcGVyZm9ybWVk
Lgo+Pgo+PiBZZXMsIHlvdSdyZSByaWdodCB0aGlzIHdvdWxkIG5vdCB3b3JrIChpdCB0b29rIG1l
IGEgd2hpbGUgdG8gZmluZCBpdCBhcwo+PiB3ZWxsKS4KPj4KPj4gSSBob3BlZCB3ZSB3b3VsZCBo
YXZlIHNvbWUgc21hcnQgZXZhbHVhdGlvbiB3aGljaCB3b3VsZCBhbGxvdyBub3QgaGF2aW5nCj4+
IHRvIGFkZAo+PiBhbnl0aGluZyB0byBmaWxlcyBpbiB0ZXN0Y2FzZXMvbGliLywgYnV0IHRoaXMg
d2lsbCBub3Qgd29yay4KPj4KPj4gV2UgY2FuIGVpdGhlciBjb21iaW5lIHlvdXIgYXBwcm9hY2gg
d2l0aCB0aGlzIChoYXZlIGEgbmV3IGRlZmluaXRpb24gKwo+PiBzdGF0aWMKPj4KPgo+IFRoYXQg
d29uJ3Qgd29ya3MgYXMgd2VsbCwgZGVmaW5lIGEgbmV3IG1hY3JvIGxpa2UgVFNUX0lHTk9SRV9T
TE9XX0tDT05GSUcKPiBpbiB0ZXN0Y2FzZS9saWIvKiBpcyB1c2VsZXNzLiBCZWNhdXNlIHRoZSBs
aWJsdHAuYSBpcyBpbmRlcGVuZGVudCBvZiBvdGhlcgo+IHRoaW5ncyB1bmRlcgo+IHRlc3RjYXNl
LyBkaXIuIEl0IGhhcyBiZWVuIGRlY2lkZWQgd2hlbiB3ZSBsaW5rIHRoZSBsaWJsdHAuYS4KPgo+
IFNvIGV2ZW50dWFsbHkgd2UgaGF2ZSB0byBnbyB0aGUgd2F5IEFuZHJlYSBzdWdnZXN0cy4KPgoK
Q2FuIHlvdSB0cnkgd2l0aCB0aGUgc2ltcGxlIGZpeCBiZWxvdzoKCi0tLSBhL2luY2x1ZGUvdHN0
X3Rlc3QuaAorKysgYi9pbmNsdWRlL3RzdF90ZXN0LmgKQEAgLTU2OCw2ICs1NjgsOCBAQCBzdHJ1
Y3QgdHN0X2ZzIHsKCiAgICAgICAgc3RydWN0IHRzdF9odWdlcGFnZSBodWdlcGFnZXM7CgorICAg
ICAgIHVuc2lnbmVkIGludCBpZ25vcmVfc2xvd19rY29uZmlnOworCiAgICAgICAgdW5zaWduZWQg
aW50IHRhaW50X2NoZWNrOwoKICAgICAgICB1bnNpZ25lZCBpbnQgdGVzdF92YXJpYW50czsKZGlm
ZiAtLWdpdCBhL2xpYi90c3RfdGVzdC5jIGIvbGliL3RzdF90ZXN0LmMKaW5kZXggYjIwNGFkOTc1
Li5kM2VjMWRhYTcgMTAwNjQ0Ci0tLSBhL2xpYi90c3RfdGVzdC5jCisrKyBiL2xpYi90c3RfdGVz
dC5jCkBAIC0xNzAyLDcgKzE3MDIsNyBAQCB1bnNpZ25lZCBpbnQgdHN0X211bHRpcGx5X3RpbWVv
dXQodW5zaWduZWQgaW50CnRpbWVvdXQpCiAgICAgICAgaWYgKHRpbWVvdXQgPCAxKQogICAgICAg
ICAgICAgICAgdHN0X2JyayhUQlJPSywgInRpbWVvdXQgbXVzdCB0byBiZSA+PSAxISAoJWQpIiwg
dGltZW91dCk7CgotICAgICAgIGlmICh0c3RfaGFzX3Nsb3dfa2NvbmZpZygpKQorICAgICAgIGlm
ICghdHN0X3Rlc3QtPmlnbm9yZV9zbG93X2tjb25maWcgJiYgdHN0X2hhc19zbG93X2tjb25maWco
KSkKICAgICAgICAgICAgICAgIHRpbWVvdXQgKj0gNDsKCiAgICAgICAgcmV0dXJuIHRpbWVvdXQg
KiB0aW1lb3V0X211bDsKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9saWIvdHN0X25zX2V4ZWMuYyBi
L3Rlc3RjYXNlcy9saWIvdHN0X25zX2V4ZWMuYwppbmRleCA2YThlMzkzMzkuLjg3ZDk1ZmU5YyAx
MDA2NDQKLS0tIGEvdGVzdGNhc2VzL2xpYi90c3RfbnNfZXhlYy5jCisrKyBiL3Rlc3RjYXNlcy9s
aWIvdHN0X25zX2V4ZWMuYwpAQCAtMjQsNiArMjQsNyBAQCBleHRlcm4gc3RydWN0IHRzdF90ZXN0
ICp0c3RfdGVzdDsKCiBzdGF0aWMgc3RydWN0IHRzdF90ZXN0IHRlc3QgPSB7CiAgICAgICAgLmZv
cmtzX2NoaWxkID0gMSwgLyogTmVlZGVkIGJ5IFNBRkVfQ0xPTkUgKi8KKyAgICAgICAuaWdub3Jl
ZF9zbG93X2tjb25maWcgPSAxOwogfTsKCgoKCj4KPgo+Cj4+IGZ1bmN0aW9uIGluIHRzdF90ZXN0
LmgpIG9yIHVzZSBzdHJ1Y3QgdHN0X3Rlc3QgZmxhZyBhcyBBbmRyZWEgc3VnZ2VzdGVkLgo+PiBJ
J20gbm90Cj4+IHN1cmUgd2hhdCBpcyBiZXR0ZXIsIEkgc2xpZ2h0bHkgcHJlZmVycmVkIHRoZSBk
ZWZpbml0aW9uLCBiZWNhdXNlIG9uZSBkYXkKPj4gd2UKPj4gbWlnaHQgd2FudCB0byBnZXQgcmlk
IG9mIHN0cnVjdCB0c3RfdGVzdCB3b3JrYXJvdW5kcyBpbiB0ZXN0Y2FzZXMvbGliCj4+IHRoZXJl
Zm9yZQo+PiBJIHdvdWxkIHByZWZlciBub3QgdG8gYWRkIHlldCBhbm90aGVyLgo+Pgo+PiBGWUkg
dHN0X3Rlc3Qgc3RydWN0IHVzZSBpcyBmb3JjZWQgYnkgY29kZSBpbiBzYWZlX2Nsb25lKCkgbGli
L3RzdF90ZXN0LmM6Cj4+Cj4+IHBpZF90IHNhZmVfY2xvbmUoY29uc3QgY2hhciAqZmlsZSwgY29u
c3QgaW50IGxpbmVubywKPj4gICAgICAgICAgICAgICAgICBjb25zdCBzdHJ1Y3QgdHN0X2Nsb25l
X2FyZ3MgKmFyZ3MpCj4+IHsKPj4gICAgICAgICBwaWRfdCBwaWQ7Cj4+Cj4+ICAgICAgICAgaWYg
KCF0c3RfdGVzdC0+Zm9ya3NfY2hpbGQpCj4+ICAgICAgICAgICAgICAgICB0c3RfYnJrKFRCUk9L
LCAidGVzdC5mb3Jrc19jaGlsZCBtdXN0IGJlIHNldCEiKTsKPj4KPj4gVGhpcyBjb3VsZCBiZSBh
bHNvIGd1YXJkZWQgYnkgbmV3IGRlZmluaXRpb24uIFRoZW4gaXQgc2hvdWxkIGhhdmUKPj4gcHJv
YmFibHkgYQo+PiBkaWZmZXJlbnQgbmFtZSB0aGFuIFRTVF9OT19TTE9XX0tDT05GSUdfQ0hFQ0su
IFN1cmUsIHdlIHBvc3Rwb25lIHRoaXMKPj4gY2xlYW51cAo+PiBhZnRlciB0aGUgcmVsZWFzZS4K
Pj4KPj4gQlRXIHdlIGhhdmUgVENPTkYgb24gc3RhcnZhdGlvbi5jLiBUaGlzIHRlc3Qgd291bGQg
d29yayBpZiB3ZSBkb24ndAo+PiBwcm9sb25nIGl0Cj4+IGV2ZW4gbG9uZ2VyIHdpdGggdHN0X2hh
c19zbG93X2tjb25maWcoKSwgdGh1cyBtaWdodCB3YW50IHRvIHJlbW92ZSBUQ09ORgo+PiBhbmQK
Pj4gZGlzYWJsZSB0c3RfaGFzX3Nsb3dfa2NvbmZpZygpIHRoZXJlIGFzIHdlbGwuIFdlIGNhbiBk
byBpdCB3aXRoIGJvdGggd2F5cy4KPj4KPj4gS2luZCByZWdhcmRzLAo+PiBQZXRyCj4+Cj4+Cj4K
PiAtLQo+IFJlZ2FyZHMsCj4gTGkgV2FuZwo+CgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
