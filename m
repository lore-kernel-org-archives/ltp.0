Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FEF8C47DAF
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 09:13:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2F6813CE23E
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 10:13:11 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 11C0F3C9978
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 10:12:55 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0F5381402F92
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 10:12:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705914773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fR22YuN6cujCkv8+o7XzAmoxVspnPoFcu3osZZhCgxw=;
 b=VVSj9fhEUb7SvWurbaH9q0GZPBhm/1fqOeXVy0qNfhUzdemYP99WyD9leEwWFRqAWxlYqN
 Vf5ZEO3ZQprtyDO+/9+HGOLXAN+mSj1I194NgQtEfDY/2pzxw7i9/TXng3B9lhG8Ry2xk/
 73Uo1eJbBNXz/PfYRSq5OCFoyKTxDNI=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-Y8xymSYpOhCM5Zv160dW8A-1; Mon, 22 Jan 2024 04:12:50 -0500
X-MC-Unique: Y8xymSYpOhCM5Zv160dW8A-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-6dbcf18d487so862724b3a.1
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 01:12:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705914769; x=1706519569;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fR22YuN6cujCkv8+o7XzAmoxVspnPoFcu3osZZhCgxw=;
 b=vSzigkaT14erZ7S1Cl/6lifCX4syYC0RraSyAQfiCKmePfakfAxoBR3z5TDoZUgeR1
 d3+g6teehMGB+9czgZJTArPQyfN4VMTXaSXJGoj4J/PmVxYBevsc0plwz24g5Ubh0CcJ
 0fz/cy1cvi6DNpHh2xFsoCF/SklcJ02F2wXfDLQPI5WW0W1RKyvix8Ny/7Aa5ZvYN+Ii
 TmT5AMXuM9HVBMHWETKO/UbRFSlRk0XAXrLx80+mqtNYvfJk2iOd4dgAqz1NebSAyVHb
 w4RTgW71RiM7+JiiiGojV++tao6IflylCJrN+PaIYXat6/EU9FBGq1qcBMgsbXD08gYL
 zVMw==
X-Gm-Message-State: AOJu0YwNiKcWRhjo1tYJggmRkKua/53EXJOqGwNIKlKdO+JBVtZ7+TVH
 dGUMJ+zV3N9Y2g1RLYtHFziSxpZf0zqNmZl6YOMlX+8AkRBhnNgUfMbaujkrkdipZ2M8oUWN0TE
 iP8h5KJBpWSljfKaLBjnBZQ7OIVoU8qJh5xhsyl/T5JTVdhzMyH9DHLkLsKVB97gJXVM5bOxzT6
 ys7lGi8bUWsUabQue3yIekncI=
X-Received: by 2002:a05:6a20:258c:b0:19c:4dc5:36d9 with SMTP id
 k12-20020a056a20258c00b0019c4dc536d9mr361075pzd.124.1705914769327; 
 Mon, 22 Jan 2024 01:12:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEMhOE/tqUA2l6Dyh2FFVW05zrlnGE5gQbW+GeoQXPm0IBqyszJumTtbdom6TL2BfF7VA9ox8P6VSFN4uxSF0=
X-Received: by 2002:a05:6a20:258c:b0:19c:4dc5:36d9 with SMTP id
 k12-20020a056a20258c00b0019c4dc536d9mr361066pzd.124.1705914768959; Mon, 22
 Jan 2024 01:12:48 -0800 (PST)
MIME-Version: 1.0
References: <20240122072948.2568801-1-liwang@redhat.com>
 <20240122090349.GD76754@pevik>
In-Reply-To: <20240122090349.GD76754@pevik>
From: Li Wang <liwang@redhat.com>
Date: Mon, 22 Jan 2024 17:12:37 +0800
Message-ID: <CAEemH2c7_pvi1imV3pb2oc3g_ZGSTvBsKd=OYE=mSW2g=Z-BEA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/4] libswap: add known swap supported fs check
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

T24gTW9uLCBKYW4gMjIsIDIwMjQgYXQgNTowM+KAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgTGksIEN5cmlsLAo+Cj4gPiBUaGlzIGludHJvZHVjZSBhbiBlbmhh
bmNlbWVudCB0byB0aGUgbGlicmFyeSdzIGlzX3N3YXBfc3VwcG9ydGVkCj4gPiBmdW5jdGlvbiB0
byBjaGVjayBmb3IgZmlsZXN5c3RlbSBjb21wYXRpYmlsaXR5IGJlZm9yZSBhdHRlbXB0aW5nCj4g
PiB0byBjcmVhdGUgYW5kIGVuYWJsZSBhIHN3YXAgZmlsZS4gIEEgbGlzdCBvZiBzdXBwb3J0ZWQg
ZmlsZXN5c3RlbXMKPiA+IGlzIGFkZGVkIChleHQyLCBleHQzLCBleHQ0LCB4ZnMsIHZmYXQsIGV4
ZmF0LCBudGZzKSwgYW5kIGEgY2hlY2sKPiA+IGFnYWluc3QgdGhpcyBsaXN0IGlzIHBlcmZvcm1l
ZCB0byBlbnN1cmUgdGhhdCB0aGUgc3dhcCBvcGVyYXRpb25zCj4gPiBhcmUgb25seSBhdHRlbXB0
ZWQgb24ga25vd24gY29tcGF0aWJsZSBmaWxlc3lzdGVtcy4KPgo+ID4gSWYgdGhlIG1ha2Vfc3dh
cGZpbGUgZnVuY3Rpb24gZmFpbHMsIHRoZSBlcnJvciBoYW5kbGluZyBpcyBub3cKPiA+IG1vcmUg
ZGVzY3JpcHRpdmU6IGl0IGRpc3Rpbmd1aXNoZXMgYmV0d2VlbiBmYWlsdXJlcyBkdWUgdG8gdGhl
Cj4gPiBmaWxlc3lzdGVtIG5vdCBzdXBwb3J0aW5nIHN3YXAgZmlsZXMgYW5kIG90aGVyIHR5cGVz
IG9mIGZhaWx1cmVzLgo+ID4gU2ltaWxhcmx5LCB3aGVuIGF0dGVtcHRpbmcgdG8gZW5hYmxlIHRo
ZSBzd2FwIGZpbGUgd2l0aCBzd2Fwb24sCj4gPiB0aGUgcGF0Y2ggZW5zdXJlcyB0aGF0IGNsZWFy
ZXIgZXJyb3IgbWVzc2FnZXMgYXJlIHByb3ZpZGVkIGluCj4gPiBjYXNlcyB3aGVyZSB0aGUgb3Bl
cmF0aW9uIGlzIG5vdCBzdXBwb3J0ZWQgYnkgdGhlIGZpbGVzeXN0ZW0uCj4KPiA+IFNpZ25lZC1v
ZmYtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPgo+ID4gLS0tCj4gPiAgbGlicy9saWJs
dHBzd2FwL2xpYnN3YXAuYyB8IDMzICsrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQo+Cj4g
PiBkaWZmIC0tZ2l0IGEvbGlicy9saWJsdHBzd2FwL2xpYnN3YXAuYyBiL2xpYnMvbGlibHRwc3dh
cC9saWJzd2FwLmMKPiA+IGluZGV4IDEzNjEwNzA5ZS4uNjIzZjJmYjNjIDEwMDY0NAo+ID4gLS0t
IGEvbGlicy9saWJsdHBzd2FwL2xpYnN3YXAuYwo+ID4gKysrIGIvbGlicy9saWJsdHBzd2FwL2xp
YnN3YXAuYwo+ID4gQEAgLTEyLDYgKzEyLDE3IEBACj4gPiAgI2luY2x1ZGUgImxpYnN3YXAuaCIK
PiA+ICAjaW5jbHVkZSAibGFwaS9zeXNjYWxscy5oIgo+Cj4gPiArc3RhdGljIGNvbnN0IGNoYXIg
KmNvbnN0IHN3YXBfc3VwcG9ydGVkX2ZzW10gPSB7Cj4gPiArICAgICAiZXh0MiIsCj4gPiArICAg
ICAiZXh0MyIsCj4gPiArICAgICAiZXh0NCIsCj4gPiArICAgICAieGZzIiwKPiA+ICsgICAgICJ2
ZmF0IiwKPiA+ICsgICAgICJleGZhdCIsCj4gPiArICAgICAibnRmcyIsCj4gPiArICAgICBOVUxM
Cj4gPiArfTsKPiA+ICsKPiA+ICAvKgo+ID4gICAqIE1ha2UgYSBzd2FwIGZpbGUKPiA+ICAgKi8K
PiA+IEBAIC00MCwyMyArNTEsMzEgQEAgaW50IG1ha2Vfc3dhcGZpbGUoY29uc3QgY2hhciAqc3dh
cGZpbGUsIGludCBzYWZlKQo+ID4gICAqLwo+ID4gIHZvaWQgaXNfc3dhcF9zdXBwb3J0ZWQoY29u
c3QgY2hhciAqZmlsZW5hbWUpCj4gPiAgewo+ID4gKyAgICAgaW50IGksIHN3X3N1cHBvcnQgPSAw
Owo+ID4gICAgICAgaW50IGZpYm1hcCA9IHRzdF9maWJtYXAoZmlsZW5hbWUpOwo+IEp1c3QgYSBu
b3RlIHVucmVsYXRlZCB0byB0aGlzIHBhdGNoc2V0LiBXaGVuIHRlc3Rpbmcgb24gU0xFUyBrZXJu
ZWwgYmFzZWQKPiBvbgo+IDUuMy4xOCB3ZSBzdGlsbCBnZXQgVENPTkYgZHVlIG1pc3NpbmcgRklC
TUFQIGlvY3RsIHN1cHBvcnQ6Cj4KPiB0c3RfdGVzdC5jOjE2Njk6IFRJTkZPOiA9PT0gVGVzdGlu
ZyBvbiBidHJmcyA9PT0KPiB0c3RfdGVzdC5jOjExMTg6IFRJTkZPOiBGb3JtYXR0aW5nIC9kZXYv
bG9vcDAgd2l0aCBidHJmcyBvcHRzPScnIGV4dHJhCj4gb3B0cz0nJwo+IHRzdF90ZXN0LmM6MTEz
MjogVElORk86IE1vdW50aW5nIC9kZXYvbG9vcDAgdG8gL3RtcC9MVFBfc3dhemFxRjFML21udHBv
aW50Cj4gZnN0eXA9YnRyZnMgZmxhZ3M9MAo+IHRzdF9pb2N0bC5jOjIxOiBUSU5GTzogRklCTUFQ
IGlvY3RsIGlzIE5PVCBzdXBwb3J0ZWQ6IEVJTlZBTCAoMjIpCj4gbGlic3dhcC5jOjQ1OiBUSU5G
TzogRlNfTk9DT1dfRkwgYXR0cmlidXRlIHNldCBvbiBtbnRwb2ludC9zd2FwZmlsZTAxCj4KPiBs
aWJzd2FwLmM6MTE0OiBUQ09ORjogU3dhcGZpbGUgb24gYnRyZnMgbm90IGltcGxlbWVudGVkCj4K
CkludGVyZXN0aW5nLCBjYW4geW91IHRyeSB3aXRoIHRoZSBiZWxvdyBjb21tYW5kIG1hbnVhbGx5
IHRvIHNlZSBpZiBzd2FwZmlsZQppcyBzdXBwb3J0ZWQgY29ycmVjdGx5IG9uIHRoZSBCVFJGUz8K
ImN1dCBmcm9tIG1hbiA1IGJ0cmZzIgoKICAgICAgICAgICMgdHJ1bmNhdGUgLXMgMCBzd2FwZmls
ZQogICAgICAgICAgIyBjaGF0dHIgK0Mgc3dhcGZpbGUKICAgICAgICAgICMgZmFsbG9jYXRlIC1s
IDJHIHN3YXBmaWxlCiAgICAgICAgICAjIGNobW9kIDA2MDAgc3dhcGZpbGUKICAgICAgICAgICMg
bWtzd2FwIHN3YXBmaWxlCiAgICAgICAgICAjIHN3YXBvbiBzd2FwZmlsZQoKCgo+Cj4gQW0gSSB3
cm9uZyBvciBjb3VsZCBpdCBiZSBzb2x2ZWQgd2l0aCBGSUVNQVAgKDxsaW51eC9maWVtYXAuaD4p
Pwo+IElmIHllcywgSSB3b25kZXIgaWYgd2Ugc2hvdWxkIGZhbGxiYWNrIG9uIGJ0cmZzIHdoZW4g
RklCTUFQIGlzIG1pc3NpbmcKPgo+IGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL0RvY3VtZW50
YXRpb24vZmlsZXN5c3RlbXMvZmllbWFwLnR4dAo+Cj4gaHR0cHM6Ly91bml4LnN0YWNrZXhjaGFu
Z2UuY29tL3F1ZXN0aW9ucy82MjM4NTkvaG93LWRvLXlvdS1maW5kLXRoZS1waHlzaWNhbC1vZmZz
ZXQtZm9yLWEtZmlsZS1pbi1idHJmcwo+Cj4gS2luZCByZWdhcmRzLAo+IFBldHIKPgo+CgotLSAK
UmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo=
