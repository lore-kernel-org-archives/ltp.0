Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2612AE77188
	for <ltp@archiver.kernel.org>; Fri,  3 Jan 2025 05:01:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C2903F0AC9
	for <ltp@archiver.kernel.org>; Fri,  3 Jan 2025 06:01:25 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F6EE3C527F
 for <ltp@lists.linux.it>; Fri,  3 Jan 2025 06:01:09 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DA46410154C5
 for <ltp@lists.linux.it>; Fri,  3 Jan 2025 06:01:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735880466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0sbXQuCyHCoCapx0Ri76uY776zRmKODwu0Y99n8yPNE=;
 b=Cl+92xw24xOgrJMmfnsICc2F1Z7yAzvXf+SlHCSV/rCAAS9L2C/iLNqBo8lq7eVzUHOyfV
 YeqBj1BGYJdn4n5TGzn8S8+ONqasIrUPuvgZxbKBVN1RTgg/RAtgxvT0njdQBorG2/+kJO
 gKdFE5Y7uPkpy3BL5jMRdkNfXVIvpzw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-vF5l2gx-Ny22UUI6zVYpHg-1; Fri, 03 Jan 2025 00:01:03 -0500
X-MC-Unique: vF5l2gx-Ny22UUI6zVYpHg-1
X-Mimecast-MFC-AGG-ID: vF5l2gx-Ny22UUI6zVYpHg
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2efc3292021so26430891a91.1
 for <ltp@lists.linux.it>; Thu, 02 Jan 2025 21:01:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735880461; x=1736485261;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0sbXQuCyHCoCapx0Ri76uY776zRmKODwu0Y99n8yPNE=;
 b=Q5Iyf673oRKKOHnHN9KsFYJ+AfH/hg/MJZHQabAEVImJyUWiHJgVZotP3flyasC2Gz
 G2/j/08itRc35NR3yw3h8nnFfk5x2D1FRapSQK2ReyEMHWSQlWgJinYeyZxSvKc4yJx2
 IKKEnLUh6zDoMXFFF3sfi5NxgfdNpFaD4HCNkxWd90yw30fWvPekSVcs0S1W0tPnaNf3
 Ddm5PDK7lbXJh1LbCAQdSE2rYhn+MmERvVoEUU0YKb8u91VGxSHdcWfNcwcth7pxGcHX
 TvuCQbIpmsN037WbTXNJTrw76Nj5lLESO8WHN9egfgFmhAVzwgGYwiTMu6q9f1KHEEuy
 xopg==
X-Gm-Message-State: AOJu0YyjBa8LUCFe8WC6yUmAlEDj6oySNslgkMnumG3hraRAaKhgM7Zd
 p17RViwi+cKYC6g2wYLwyJuKpMOQzPKCPOCcXWtWEBplpbP5+1jKojQu8Yh5xAjb4iC8+gbAMnc
 kMyDYCaFyv+MQ8lobg9vbzg5m4YH5YC1ERFNhPzQeynzK3Z7iFyMnnogTiaXhGw6nSoeU5YWjI8
 5f+F0DMtOKQFM/l9dsGF8S4MI=
X-Gm-Gg: ASbGncs+Xd85bM27cmAw5tKqMZh/w1gmn4kN9brFKUn16wKqDFq4e7xvm/pjd9mnoYF
 wKLfWHI3UoxPsODFvIO4MSyJOgdQAxm3yk7elB+0=
X-Received: by 2002:a17:90b:6cb:b0:2f2:f6e0:3f6a with SMTP id
 98e67ed59e1d1-2f452e1ea53mr68496476a91.14.1735880461246; 
 Thu, 02 Jan 2025 21:01:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGorE9fb48zWD4JmbRFwRG+PqLYvY4LdVJFlniJy1eje4WepnJ7WvIY/5UIwWvNZS1IOysSjJHgxWdRtxjZV8s=
X-Received: by 2002:a17:90b:6cb:b0:2f2:f6e0:3f6a with SMTP id
 98e67ed59e1d1-2f452e1ea53mr68496430a91.14.1735880460701; Thu, 02 Jan 2025
 21:01:00 -0800 (PST)
MIME-Version: 1.0
References: <20241222072251.13150-1-liwang@redhat.com>
 <20250102124319.GA81987@pevik>
In-Reply-To: <20250102124319.GA81987@pevik>
From: Li Wang <liwang@redhat.com>
Date: Fri, 3 Jan 2025 13:00:48 +0800
Message-ID: <CAEemH2cXL8yu0jhHz7wefvBbDGy-wXcz8Mw1JZv8FqLAXHKm9Q@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: G9QETQoNMNa0LjYDPbQeYH0buDp0c-Z-MQtoDbXsSIY_1735880461
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/2] lib: multiply the timeout if detect slow
 kconfigs
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

T24gVGh1LCBKYW4gMiwgMjAyNSBhdCA4OjQz4oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgoKPiBIaSBMaSwgYWxsLAo+Cj4gWyBDYyBvdGhlcnMgdG8gZ2V0IGJyb2F0aGVy
IGZlZWRiYWNrIF0KPgo+ID4gVGhpcyByZWZpbmVzIHRoZSBoYW5kbGluZyBvZiB0aW1lb3V0cyBm
b3IgdGVzdHMgcnVubmluZyBvbgo+ID4gc3lzdGVtcyB3aXRoIHNsb3cga2VybmVsIGNvbmZpZ3Vy
YXRpb25zIChrY29uZmlncykuCj4KPiA+IFByZXZpb3VzbHksIHRoZSBtYXhfcnVudGltZSB3YXMg
bXVsdGlwbGllZCBnbG9iYWxseSB3aGVuCj4gPiBzbG93IGtjb25maWdzIHdlcmUgZGV0ZWN0ZWQs
IHdoaWNoIGluYWR2ZXJ0ZW50bHkgcHJvbG9uZ2VkCj4gPiB0aGUgcnVudGltZSBvZiBhbGwgdGVz
dHMgdXNpbmcgbWF4X3J1bnRpbWUgZm9yIGNvbnRyb2wuCj4KPiA+IFRoaXMgcGF0Y2ggY29ycmVj
dHMgdGhhdCBiZWhhdmlvciBieSBhcHBseWluZyB0aGUgbXVsdGlwbGljYXRpb24KPiA+IHNwZWNp
ZmljYWxseSB0byB0aW1lb3V0cywgZW5zdXJpbmcgaXQgb25seSBhZmZlY3RzIHRoZSBpbnRlbmRl
ZAo+ID4gb3BlcmF0aW9ucyB3aXRob3V0IGltcGFjdGluZyBvdGhlciB0ZXN0cy4KPgo+ID4gRml4
ZXM6IDJkYTMwZGYyNCAoImxpYjogbXVsdGlwbHkgdGhlIG1heF9ydW50aW1lIGlmIGRldGVjdCBz
bG93Cj4ga2NvbmZpZ3MiKQo+Cj4gVGhhbmtzIGZvciBoYW5kbGluZyB0aGlzLCBJIG92ZXJsb29r
ZWQgaXQgb24gMjd0aCwgdGh1cyByZXZpZXcgaXQgbm93Lgo+Cj4gTXVsdGlwbHlpbmcgd2hvbGUg
dGltZW91dCBpbnN0ZWFkIG9mIG1heF9ydW50aW1lIGhlbHBzIHRvIGhpZGUgbG9uZ2VyCj4gdGlt
ZW91dAo+IGZyb20gdGhlIHRlc3Qgd2hpY2ggdXNlcyBkZXRlY3Rpb24gdmlhIHRzdF9yZW1haW5p
bmdfcnVudGltZSgpLiBJLmUuCj4gcHJldmlvdXNseQo+IGl0IGJlaGF2ZWQgb24gc2xvdyBjb25m
aWcgYXMgTFRQX1JVTlRJTUVfTVVMPTQsIG5vdyBhcyBMVFBfVElNRU9VVF9NVUw9NC4KPgoKWWVz
LCB0aGUgYmVuZWZpdCBvZiBtdWx0aXBseWluZyBUSU1FT1VUIChvbiBhIHNsb3cgc3lzdGVtKSBp
cyBub3Qgb25seQp0byBhdm9pZCBpbmNyZWFzaW5nIHRoZSBhY3R1YWwgZXhlY3V0aW9uIHRpbWUg
b2YgdGhlIHRlc3QsIGJ1dCBhbHNvIHRvIGdpdmUKIHRoZSBzeXN0ZW0gbW9yZSB0aW1lIHRvIHdh
aXQgZm9yIHRoZSB0ZXN0IHRvIGNvbXBsZXRlIHRoZSBmaW5hbCB3b3JrLgoKT3JpZ2luYWw6CiAg
fCAgLS0gdGltZW91dCAtLSB8IC0tIG1heF9ydW50aW1lIC0tIHwKClByZXZpb3VzOgogIHwgIC0t
IHRpbWVvdXQgLS0gfCAtLS0tLS0tLSBtYXhfcnVudGltZSAqIDQgLS0tLS0tLS0gfAoKTm93Ogog
IHwgIC0tLS0tLS0tIHRpbWVvdXQgKiA0IC0tLS0tLS0tIHwgLS0gbWF4X3J1bnRpbWUgLS0gIHwK
CgoKCj4gR29vZCBpZGVhLiBJTUhPIGdvb2QgZW5vdWdoIChNYXJ0aW4gcHJldmlvdXNseSBzdWdn
ZXN0ZWQgWzFdIHRvIGFkZCBhIG5ldwo+IHRzdF90ZXN0IGZsYWcgdG8gaWRlbnRpZnkgdGVzdHMg
d2hpY2ggZXhpdCB3aGVuIHJ1bnRpbWUgZXhwaXJlcykuCj4KCkludHJvZHVjZSBhIG5ldyB0c3Rf
dGVzdCBmbGFnIHRvIHNwbGl0IHRoZSBtYXhfcnVudGltZSBpbnRvIHR3byBwYXJ0cyBjYW4KcmVz
b2x2ZSBpdCBhcyB3ZWxsLCBidXQgdGhlIGRpc2FkdmFudGFnZSBtaWdodCBtYWtlIHBlb3BsZSBo
YXJkIHRvCnVuZGVyc3RhbmQgdGhlIExUUCB0aW1lIGNvbnRyb2xsaW5nLCBpZiBnbyB3aXRoIHRp
bWVvdXQsIG1heF9ydW50aW1lLAptYXhfZXhldGltZQpJIHRoaW5rICdzaW1wbGUrdXNlbGZ1bCcg
aXMgYmVhdXRpZnVsIHVubGVzcyB3ZSBuZWVkIHRvIGNvbXBsZXggaXQgaW4gdGhlCmZ1dHVyZS4K
CgoKPgo+IFJldmlld2VkLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPgo+IFNvbWUg
bWVhc3VyZW1lbnRzIG9uIG15IFR1bWJsZXdlZWQgVk0sIHdoaWNoIGlzIGRldGVjdGVkIGFzIHNs
b3cgZHVlCj4gQ09ORklHX0xBVEVOQ1lUT1A6Cj4KPiBURVNUICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgMmRhMzBkZjI0fiB8Cj4gMmRhMzBkZjI0ICB8IHRo
aXMgcGF0Y2gKPgo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tfC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiBzd2FwcGluZzAx
LmMgKGNhbGxzIHRzdF9yZW1haW5pbmdfcnVudGltZSgpKSAgICAgIHwgMGggMTBtIDMwcyB8IDBo
IDQwbQo+IDMwcyB8IDBoIDEybSAwMHMKPiB0c3RfZnV6enlfc3luYzAxLmMgKGNhbGxzIHRzdF9y
ZW1haW5pbmdfcnVudGltZSgpKXwgMGggMDNtIDAwcyB8IDBoIDEwbQo+IDMwcyB8IDBoIDA0bSAz
MHMKPiB0c3RfY2dyb3VwMDIuYyAoZGVmYXVsdCB0aW1lb3V0IDBoIDAwbSAzMHMpICAgICAgIHwg
MGggMDBtIDMwcyB8IDBoIDAwbQo+IDMwcyB8IDBoIDAybSAwMHMKPiB0ZXN0X3J1bnRpbWUwMS5j
ICgubWF4X3J1bnRpbWUgPSA0LCBjYWxscyAgICAgICAgIHwgMGggMDBtIDM0cyB8IDBoIDAwbQo+
IDQ2cyB8IDBoIDAybSAwNHMKPiB0c3RfcmVtYWluaW5nX3J1bnRpbWUoKSkKPiBzdGFydmF0aW9u
LmMgKGNhbGxzIHRzdF9yZW1haW5pbmdfcnVudGltZSgpIG9ubHkgIHwgMGggMDFtIDA1cyB8IDBo
IDAybQo+IDUwcyB8IDBoIDAybSAzNHMKPiB0byBkZXRlY3QgZmFpbHVyZSkgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwKPgo+ID0+IFRlc3RzIHdoaWNoIGNhbGwgdHN0X3JlbWFpbmlu
Z19ydW50aW1lKCkgcnVucyBzbGlnaHRseSBsb25nZXIsIGJ1dCBJTUhPCj4gdGhhdCdzIE9LLiBP
dGhlciB0ZXN0cyAocmVnYXJkbGVzcyBpZiB3aXRoIHRoZSBkZWZhdWx0IHJ1bnRpbWUgb3IgdGhl
c2UKPiB3aGljaAo+IHNldCAubWF4X3J1bnRpbWUpIHJ1biA0KiBsb25nZXIgYXMgZXhwZWN0ZWQu
Cj4KPiBUZXN0ZWQtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pgo+CgpUaGUgbG9uZ2Vy
IHRpbWUgaXMgbm90IGJlY2F1c2UgY2FsbCB0c3RfcmVtYWluaW5nX3J1bnRpbWUoKSwgaXQganVz
dCBjb21lcwpmcm9tCnRoZSAnIHRpbWVvdXQgKj0gNCcgd2hpbGUgZGV0ZWN0aW5nIHNsb3cgY29u
ZmlncywgYXMgeW91IGNhbiBzZWUsIHRoZQpvcmlnaW5hbCBkZWZhdWx0CnRpbWVvdXQgaXMgMzBz
LCBhbmQgd2l0aCBtdWx0aXBsZSA0IGl0IGJlY29tZSAxMjBzICh3aGljaCBpcyArMm1pbnMpLCBh
bGwKdGhlIHRlc3Qgd2l0aAp0aGlzIHBhdGNoIHNob3dzIHRoYXQgMiBtb3JlIG1pbnMgdGhlcmUu
CgpCdXQsIHRoYXQgZG9lcyBub3QgbWVhbiB0aGUgdGVzdCBleGVjdXRpbmcgdGltZSBpcyByZWFs
bHkgYWRkaW5nIDIgbWludXRlcywKaXQganVzdAptZWFucyBoYXZpbmcgdGhhdCB0aW1lb3V0IHZh
bHVlLiBXZSBuZWVkIHRvIHVzZSBgdGltZSAuL3N3YXBwaW5nMDFgIHRvCmV2YWx1YXRlIHRoZSBy
ZWFsIHRlc3QgdGltZSwgYW5kIEkgZGlkbid0IGZpbmQgYW55IG1vcmUgZGVsYXkgd2l0aCB0aGlz
Cm1ldGhvZCA6KS4KClRoYW5rcyBmb3IgdGhlIGNvbXBhcmlzb24sIGFjdHVhbGx5IEkgZGlkIHNv
bWUgdGVzdHMgZm9yIFJIRUwgYW5kIGdvdCBhCmdvb2QgcmVzdWx0LgoKCj4gS2luZCByZWdhcmRz
LAo+IFBldHIKPgo+IFsxXQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2x0cC9iNmRhNzdmMy00
NWQ2LTRlZWQtYjJkMy05MGFkMjBjNjNlNTBAc3VzZS5jei8KPgo+ID4gU2lnbmVkLW9mZi1ieTog
TGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+Cj4gPiAtLS0KPiA+ICBsaWIvdHN0X3Rlc3QuYyB8
IDYgKysrLS0tCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlv
bnMoLSkKPgo+ID4gZGlmZiAtLWdpdCBhL2xpYi90c3RfdGVzdC5jIGIvbGliL3RzdF90ZXN0LmMK
PiA+IGluZGV4IDIwNWZjODMyNi4uZmVmZmM5Zjg2IDEwMDY0NAo+ID4gLS0tIGEvbGliL3RzdF90
ZXN0LmMKPiA+ICsrKyBiL2xpYi90c3RfdGVzdC5jCj4gPiBAQCAtNTU1LDkgKzU1NSw2IEBAIHN0
YXRpYyBpbnQgbXVsdGlwbHlfcnVudGltZShpbnQgbWF4X3J1bnRpbWUpCj4KPiA+ICAgICAgIHBh
cnNlX211bCgmcnVudGltZV9tdWwsICJMVFBfUlVOVElNRV9NVUwiLCAwLjAwOTksIDEwMCk7Cj4K
PiA+IC0gICAgIGlmICh0c3RfaGFzX3Nsb3dfa2NvbmZpZygpKQo+ID4gLSAgICAgICAgICAgICBt
YXhfcnVudGltZSAqPSA0Owo+ID4gLQo+ID4gICAgICAgcmV0dXJuIG1heF9ydW50aW1lICogcnVu
dGltZV9tdWw7Cj4gPiAgfQo+Cj4gPiBAQCAtMTcwNiw2ICsxNzAzLDkgQEAgdW5zaWduZWQgaW50
IHRzdF9tdWx0aXBseV90aW1lb3V0KHVuc2lnbmVkIGludAo+IHRpbWVvdXQpCj4gPiAgICAgICBp
ZiAodGltZW91dCA8IDEpCj4gPiAgICAgICAgICAgICAgIHRzdF9icmsoVEJST0ssICJ0aW1lb3V0
IG11c3QgdG8gYmUgPj0gMSEgKCVkKSIsIHRpbWVvdXQpOwo+Cj4gPiArICAgICBpZiAodHN0X2hh
c19zbG93X2tjb25maWcoKSkKPiA+ICsgICAgICAgICAgICAgdGltZW91dCAqPSA0Owo+ID4gKwo+
ID4gICAgICAgcmV0dXJuIHRpbWVvdXQgKiB0aW1lb3V0X211bDsKPiA+ICB9Cj4KPgoKLS0gClJl
Z2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
