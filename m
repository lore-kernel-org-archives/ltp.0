Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 510F4C369D3
	for <ltp@archiver.kernel.org>; Mon, 28 Apr 2025 09:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1745832217; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=sxJbqyxDJ5CRTQJA9NHgqKopAtQx156IHGaIBN16yD0=;
 b=pn6F+F83ZONuvIXGIK1b4kPhfGuY99tDf3koOuFczatXMvH4VjXYT8yy4cM9+IIJ/g7XZ
 U5q01eRc7K98+4Fi46ESj1qbUk5gpn2kcBhfCyBAkc4vRyunkw/e6ne4onAQPSiZ22IH6Ga
 06T0PjlDxQHMeQcFVwMMTk5+scDKjRQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4F2F53CB9F6
	for <ltp@archiver.kernel.org>; Mon, 28 Apr 2025 11:23:37 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 66BC03C2F88
 for <ltp@lists.linux.it>; Mon, 28 Apr 2025 11:23:14 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6D8E6600700
 for <ltp@lists.linux.it>; Mon, 28 Apr 2025 11:23:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745832191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nP3CHf6O1zXH6PTmLSg4nYtfiu1trd0aakx4PV+hbo0=;
 b=TbAUVGp5UH5DukhhsGonL0LBeMYBMk35/LaqfzF5cSXj8cgN08lpujduOxGLlTLGBXFwSF
 Sp70yZdw68MfydwkJxtE6UPrEb1/2OxULl/ilU7v2rbqdKr6vXZVltqWp4Ze5q2SstZAK8
 NT+ORZwuEBboEuIAXGBROPO80KqxvlM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-movqDOFKMCG2c32EzBHyXA-1; Mon, 28 Apr 2025 05:23:09 -0400
X-MC-Unique: movqDOFKMCG2c32EzBHyXA-1
X-Mimecast-MFC-AGG-ID: movqDOFKMCG2c32EzBHyXA_1745832188
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3011bee1751so4105231a91.1
 for <ltp@lists.linux.it>; Mon, 28 Apr 2025 02:23:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745832188; x=1746436988;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nP3CHf6O1zXH6PTmLSg4nYtfiu1trd0aakx4PV+hbo0=;
 b=hAIBCnElKVN/jnpyUqBnHJMYOJb0bZFe07pvo7/v1S5UigMZG9vNiHZAFdHLefwl5F
 +fJwHgrhUoEx84aWo9ZfLliwKDSixwCTITcZWP+N3joAUMSrPwp1n6SosGT5kRk0i9o7
 CWPvBJWTpRZnidGiIaMzg7C5io58ZefrXSUdfzTJtLh06s4U4ULl3ZFE69ffBIYLxB7e
 BaNmDoc7JB0OfuLsABbyb7jnhc55rvxizxWbCwykWokHcaIqqxf7wLkD1i9YgHB4RotM
 wZ2hDDznU/M457el67XrD6r75U5Bnoox2iYkY/yztRGF/2As1Xf9RU0pKZSpmltMnCwc
 nRRA==
X-Gm-Message-State: AOJu0YzFNh4yGDN1gaVnJYG07oePccjB4StVL4iQr+bhX/YJsiwcJhZw
 mibGoNfaOqEww/gUyTcvGFq9tIXHQmND5iUJ2gXg5GySBwsdTVchWVg7ICHPHCWWcz6+TGrtLl0
 8CAhSazlSPJOsvxL31ktC7mfSIFaAsy9Emrs3r0BT/ntyNQvy7AqfjrXH3KmpJHwXJt99UEzGPh
 0Hk+3Zu/uljnX/MePjyVssjoU=
X-Gm-Gg: ASbGncsPGQJBi6WayO9npYC15E1oRrT8/OaAW/Hg1YobXqI+51LQXxb/1Sf7b5iYO4E
 52LinK1EJzs0YxWqvFgXCsUtt1oj7eao3Rgr+pYOvwCunJ7jl1x1Qn5fAn0AD3wTH5JDtGA==
X-Received: by 2002:a17:90b:5490:b0:309:f5c6:4c5c with SMTP id
 98e67ed59e1d1-30a01398884mr11925888a91.25.1745832187876; 
 Mon, 28 Apr 2025 02:23:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFR3n9ATgFkwyVBF+MvQ/QYkUY9HGpgLbi4gFDoZNPynQkV2+Ya3jElrA1FLVVS8xYtB084i1mszwjUsv6GXsw=
X-Received: by 2002:a17:90b:5490:b0:309:f5c6:4c5c with SMTP id
 98e67ed59e1d1-30a01398884mr11925796a91.25.1745832186493; Mon, 28 Apr 2025
 02:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250327200044.4104125-1-tjmercier@google.com>
 <CAEemH2czhNJmDykDTGenBNjdnNsOPkCLDCZRHHWcvG_=jBMRQw@mail.gmail.com>
In-Reply-To: <CAEemH2czhNJmDykDTGenBNjdnNsOPkCLDCZRHHWcvG_=jBMRQw@mail.gmail.com>
Date: Mon, 28 Apr 2025 17:22:54 +0800
X-Gm-Features: ATxdqUE2s3ICO8AAdVUkyO7Ia2h4ojO_H9RYKIxloYxMICzTmSSTWCzTKdGlFVw
Message-ID: <CAEemH2e3JnKW+b-2AWhyXQ3eJpfm7DEuekB4KgAc9wEMG_4OrQ@mail.gmail.com>
To: "T.J. Mercier" <tjmercier@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: G8P3lsv8mNaQdwkZs5Lkwe8j4Yz0WzUgUaOaCQshAeo_1745832188
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] memcg_control_test: Disable swapping in test
 cgroup for v2
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
Cc: mkoutny@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

UGF0Y2ggbWVyZ2VkLCB0aGFua3MhCgpPbiBGcmksIE1hciAyOCwgMjAyNSBhdCAxMjoxMuKAr1BN
IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKCj4KPgo+IE9uIEZyaSwgTWFyIDI4
LCAyMDI1IGF0IDQ6MDHigK9BTSBULkouIE1lcmNpZXIgdmlhIGx0cCA8bHRwQGxpc3RzLmxpbnV4
Lml0Pgo+IHdyb3RlOgo+Cj4+IG1lbWNnX2NvbnRyb2xfdGVzdF8xIHNldHMgYm90aCBhIG1lbW9y
eSBsaW1pdCBhbmQgYSBtZW1zdy9zd2FwIGxpbWl0IHRvCj4+IGEgc2luZ2xlIHBhZ2UsIGFuZCB0
aGVuIGFza3MgbWVtX3Byb2Nlc3MgdG8gYWxsb2NhdGUgMiBwYWdlcyBpbiBhbgo+PiBhdHRlbXB0
IHRvIGNhdXNlIGEgbWVtY2cgT09NIGtpbGwuIEhvd2V2ZXIsIGlmIHN3YXBwaW5nIGlzIGVuYWJs
ZWQgdGhlCj4+IGZpcnN0IHBhZ2UgY2FuIGJlIHN3YXBwZWQgYmVmb3JlIHRoZSBzZWNvbmQgaXMg
YWxsb2NhdGVkIGNhdXNpbmcgbmVpdGhlcgo+PiBsaW1pdCB0byBiZSBleGNlZWRlZCBpbiB2MiBz
aW5jZSB0aGVyZSBpcyBubyBjb21iaW5lZCBtZW1zdyBjb3VudGVyIGluCj4+IHYyLiBJbiB0aGlz
IGNhc2Ugbm8gT09NIGtpbGwgd2lsbCBvY2N1ciB3aGljaCByZXN1bHRzIGluIGEgdGVzdCBmYWls
dXJlLgo+PiBGaXggdGhpcyBieSBkaXNhYmxpbmcgc3dhcCBpbiB0aGUgdGVzdCBjZ3JvdXAgZm9y
IHYyIGlmIHN3YXAgaXMgZW5hYmxlZCwKPj4gY2F1c2luZyBib3RoIHBhZ2VzIHRvIGFsd2F5cyBi
ZSBhY2NvdW50ZWQgdW5kZXIgdGhlIHNhbWUgY291bnRlciBzdWNoCj4+IHRoYXQgbWVtb3J5Lm1h
eCBjYXVzZXMgYW4gT09NIGtpbGwuCj4+Cj4+IEZpeGVzOiBjMGI4MTU3MzYgKCJOZXcgdGVzdGNh
c2UgYWRkZWQgYnkgTmF1ZmFsLiIpCj4+IFNpZ25lZC1vZmYtYnk6IFQuSi4gTWVyY2llciA8dGpt
ZXJjaWVyQGdvb2dsZS5jb20+Cj4+Cj4KPiBSZXZpZXdlZC1ieTogTGkgV2FuZyA8bGl3YW5nQHJl
ZGhhdC5jb20+Cj4KPiAtLS0KPj4gIC4uLi9tZW1jZy9jb250cm9sL21lbWNnX2NvbnRyb2xfdGVz
dC5zaCAgICAgICAgICAgIHwgMTQgKysrKysrKysrKystLS0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAx
MSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0Cj4+IGEvdGVz
dGNhc2VzL2tlcm5lbC9jb250cm9sbGVycy9tZW1jZy9jb250cm9sL21lbWNnX2NvbnRyb2xfdGVz
dC5zaAo+PiBiL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxlcnMvbWVtY2cvY29udHJvbC9tZW1j
Z19jb250cm9sX3Rlc3Quc2gKPj4gaW5kZXggNjgyODdhNzBjLi43OWIzYTAyYTkgMTAwNjQ0Cj4+
IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxlcnMvbWVtY2cvY29udHJvbC9tZW1jZ19j
b250cm9sX3Rlc3Quc2gKPj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9jb250cm9sbGVycy9tZW1j
Zy9jb250cm9sL21lbWNnX2NvbnRyb2xfdGVzdC5zaAo+PiBAQCAtMTIsNyArMTIsNiBAQCBUU1Rf
TkVFRFNfVE1QRElSPTEKPj4KPj4gIFBBR0VfU0laRT0kKHRzdF9nZXRjb25mIFBBR0VTSVpFKQo+
Pgo+PiAtVE9UX01FTV9MSU1JVD0kUEFHRV9TSVpFCj4+ICBBQ1RJVkVfTUVNX0xJTUlUPSRQQUdF
X1NJWkUKPj4gIFBST0NfTUVNPSQoKFBBR0VfU0laRSAqIDIpKQo+Pgo+PiBAQCAtNTAsMTMgKzQ5
LDIyIEBAIHRlc3QxKCkKPj4KPj4gICAgICAgICAjIElmIHRoZSBrZXJuZWwgaXMgYnVpbHQgd2l0
aG91dCBzd2FwLCB0aGUgJG1lbXN3X21lbW9yeV9saW1pdAo+PiBmaWxlIGlzIG1pc3NpbmcKPj4g
ICAgICAgICBpZiBbIC1lICIkdGVzdF9kaXIvJG1lbXN3X21lbW9yeV9saW1pdCIgXTsgdGhlbgo+
PiAtICAgICAgICAgICAgICAgUk9EIGVjaG8gIiRUT1RfTUVNX0xJTUlUIiBcPgo+PiAiJHRlc3Rf
ZGlyLyRtZW1zd19tZW1vcnlfbGltaXQiCj4+ICsgICAgICAgICAgICAgICBpZiBbICIkY2dyb3Vw
X3ZlcnNpb24iID0gIjIiIF07IHRoZW4KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgIyB2MiBk
b2VzIG5vdCBoYXZlIGEgY29tYmluZWQgbWVtc3cgbGltaXQgbGlrZSB2MS4KPj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgIyBEaXNhYmxlIHN3YXBwaW5nIGluIHYyIHNvIGFsbCBwYWdlcyBnZXQK
Pj4gYWNjY291bnRlZCB0byB0aGUgbm9uLXN3YXAgY291bnRlci4KPj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgU1dBUF9MSU1JVD0wCj4+ICsgICAgICAgICAgICAgICBlbHNlCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICMgU3dhcHBpbmcgY2Fubm90IGJlIGRpc2FibGVkIHZpYQo+PiBtZW1z
dy5saW1pdF9pbl9ieXRlcyBpbiB2MS4KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgIyBBcHBs
eSBhIG1lbXN3IGxpbWl0IGluIHYxIHRvIGNhcHR1cmUgYW55Cj4+IHN3YXBwZWQgcGFnZXMKPj4g
KyAgICAgICAgICAgICAgICAgICAgICAgU1dBUF9MSU1JVD0kQUNUSVZFX01FTV9MSU1JVAo+PiAr
ICAgICAgICAgICAgICAgZmkKPj4gKyAgICAgICAgICAgICAgIFJPRCBlY2hvICIkU1dBUF9MSU1J
VCIgXD4gIiR0ZXN0X2Rpci8kbWVtc3dfbWVtb3J5X2xpbWl0Igo+PiAgICAgICAgIGZpCj4+Cj4+
ICAgICAgICAgS0lMTEVEX0NOVD0wCj4+ICAgICAgICAgdGVzdF9wcm9jX2tpbGwKPj4KPj4gLSAg
ICAgICBpZiBbICRQUk9DX01FTSAtZ3QgJFRPVF9NRU1fTElNSVQgXSAmJiBbICRLSUxMRURfQ05U
IC1lcSAwIF07IHRoZW4KPj4gKyAgICAgICBpZiBbICRLSUxMRURfQ05UIC1lcSAwIF07IHRoZW4K
Pj4gICAgICAgICAgICAgICAgIHRzdF9yZXMgVEZBSUwgIlRlc3QgIzE6IGZhaWxlZCIKPj4gICAg
ICAgICBlbHNlCj4+ICAgICAgICAgICAgICAgICB0c3RfcmVzIFRQQVNTICJUZXN0ICMxOiBwYXNz
ZWQiCj4+IC0tCj4+IDIuNDkuMC40NzIuZ2U5NDE1NWE5ZWMtZ29vZwo+Pgo+Pgo+PiAtLQo+PiBN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAKPj4K
Pj4KPgo+IC0tCj4gUmVnYXJkcywKPiBMaSBXYW5nCj4KCgotLSAKUmVnYXJkcywKTGkgV2FuZwoK
LS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0
cAo=
