Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B136C282D6
	for <ltp@archiver.kernel.org>; Tue,  4 Mar 2025 12:58:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF6913CA014
	for <ltp@archiver.kernel.org>; Tue,  4 Mar 2025 13:58:28 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 45E373CA041
 for <ltp@lists.linux.it>; Tue,  4 Mar 2025 13:57:58 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0A53C140DF95
 for <ltp@lists.linux.it>; Tue,  4 Mar 2025 13:57:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741093074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qo4O6k/tJX/aDmHUmDZjyHhCml52bUSRDEzxf94zjiA=;
 b=R+o28E4ZqvBrZ1nqNpsf+L5eEDBaFtJHND+KRXSu1RBj6iPAWmcE8WOXfepN61poCRaMdz
 h6W2GRzn5WICyjbo2o48Gq6c+P0KMAtcIYvBssSTv6ojNSMHWr0NGDvHERzzsLAdC3tnfv
 xkAmVAo9yy3aYTcwLeuPl8QKSXV+sZ0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-DX2XNArGN0yWNg0yY9q58A-1; Tue, 04 Mar 2025 07:57:47 -0500
X-MC-Unique: DX2XNArGN0yWNg0yY9q58A-1
X-Mimecast-MFC-AGG-ID: DX2XNArGN0yWNg0yY9q58A_1741093067
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2fed0f307ccso6219051a91.0
 for <ltp@lists.linux.it>; Tue, 04 Mar 2025 04:57:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741093066; x=1741697866;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qo4O6k/tJX/aDmHUmDZjyHhCml52bUSRDEzxf94zjiA=;
 b=Y3RATwoDFksqftMDhy0VZbxipGykYPKINlDg6MQyymLkeTI3ijbOUm7dgvNLnplibg
 gEPCAO9FFUc+/Utgyp0QMdmA0PAEpN+0Si7mVnnd65QTFYr1L46fVSFPosv8csSC73n5
 a4P7aOKhGXHu7FLz1aQSnBqIm0UaM7VhQ3ymHjRVFKnz+yi0QVfMN8DQT4Q9cs0COhxV
 M/L4/K3DdpFElMowlryoc2H2fWJXk64bK3X06Oy1j+oJuZdTg8302NJDmhHDVYCDAxZ3
 AVbvUbRvmCppsHktuqU7WXszigMQMXjG01g6GqG2gjV97C1UUBtJmTw7fRoM+eFNVGMh
 Uyog==
X-Gm-Message-State: AOJu0YxLCHHkpj65Sf0HiXJmFZsY1AqmAJP9YiLwBDIxA9y2MyStzJSm
 rKIQogpAfK9a/tnADuJwOJoKToP4eh6zHZ/E1kHFBxgQ3nawt4Q2Fz/MNT5zxvE0xkG244eF8Nk
 omFrJfiK/pSR4SUFU2NPgVXWSqtJfyhDqx2aEvP6IMRLHjfI9f7WxKgKLtaVzGkowk+UVOYZnMp
 BW0jcnuuf0RFcfGmD+FQketxrkbs6C5wvIBkTL
X-Gm-Gg: ASbGnct/I5t2WuuLMxT5hljnWls4QGU/j6BAZH1A1rhEInQr37plWIPa0o1dYMCiphD
 JOfQBZMIa7TTtG0+OVqV4vfJYumLgQqmMcDla9c6o2jvgvdBAzpBQRK5A/rlPM0Yr3u5KpVQ3Wg
 ==
X-Received: by 2002:a17:90a:c10c:b0:2fe:dd2c:f8f0 with SMTP id
 98e67ed59e1d1-2fedd2cf9c4mr14825137a91.22.1741093066224; 
 Tue, 04 Mar 2025 04:57:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9wpzg20v8fSBrKrt8jL3LSo1XP+rGtGO+1SXXyydO4PErk8EYp+90f9/bZvsVJqwWwpCHozLgsgW5l70khVk=
X-Received: by 2002:a17:90a:c10c:b0:2fe:dd2c:f8f0 with SMTP id
 98e67ed59e1d1-2fedd2cf9c4mr14825027a91.22.1741093064365; Tue, 04 Mar 2025
 04:57:44 -0800 (PST)
MIME-Version: 1.0
References: <20250228172439.3276777-1-pvorel@suse.cz>
 <20250228172439.3276777-2-pvorel@suse.cz>
In-Reply-To: <20250228172439.3276777-2-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Tue, 4 Mar 2025 20:57:32 +0800
X-Gm-Features: AQ5f1Jqu3rRjYiQ41a-Uef5fkUrBfdHH6eF4WkfSMDnQBww3IcV2a7d99wSvQCk
Message-ID: <CAEemH2eBJ5AeTKgbDAbCpZKLA7DZMWhpEcrSUJAdJuNU5yULOA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: N5F_9v2FMvqVK0L8XDAtdx8tlV2Eao4bKzqFXfTxqrU_1741093067
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [RFC PATCH 1/5] shell lib: Add support for test cleanup
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

T24gU2F0LCBNYXIgMSwgMjAyNSBhdCAxOjI14oCvQU0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgoKPiBGcm9tOiBDeXJpbCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4KPgo+IFJl
dmlld2VkLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPiBTaWduZWQtb2ZmLWJ5OiBD
eXJpbCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4KPiAtLS0KPiBUaGUgc2FtZSBhcyBpbjoKPgo+
IGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC9sdHAvcGF0Y2gvMjAyNTAyMTQx
MTIxMzUuMTg5NDctMy1jaHJ1YmlzQHN1c2UuY3ovCj4KPiAgdGVzdGNhc2VzL2xpYi9ydW5fdGVz
dHMuc2ggICAgICAgICAgICAgICAgICAgIHwgIDQgKysrLQo+ICAuLi4vbGliL3Rlc3RzL3NoZWxs
X2xvYWRlcl9icmtfY2xlYW51cC5zaCAgICAgfCAyMCArKysrKysrKysrKysrKysrKysrCj4gIHRl
c3RjYXNlcy9saWIvdGVzdHMvc2hlbGxfbG9hZGVyX2NsZWFudXAuc2ggICB8IDIwICsrKysrKysr
KysrKysrKysrKysKPiAgdGVzdGNhc2VzL2xpYi90c3RfZW52LnNoICAgICAgICAgICAgICAgICAg
ICAgIHwgIDQgKysrKwo+ICA0IGZpbGVzIGNoYW5nZWQsIDQ3IGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkKPiAgY3JlYXRlIG1vZGUgMTAwNzU1IHRlc3RjYXNlcy9saWIvdGVzdHMvc2hlbGxf
bG9hZGVyX2Jya19jbGVhbnVwLnNoCj4gIGNyZWF0ZSBtb2RlIDEwMDc1NSB0ZXN0Y2FzZXMvbGli
L3Rlc3RzL3NoZWxsX2xvYWRlcl9jbGVhbnVwLnNoCj4KPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2Vz
L2xpYi9ydW5fdGVzdHMuc2ggYi90ZXN0Y2FzZXMvbGliL3J1bl90ZXN0cy5zaAo+IGluZGV4IDMy
MWY3NGU1ZmUuLjEyOGNlZTMzNzcgMTAwNzU1Cj4gLS0tIGEvdGVzdGNhc2VzL2xpYi9ydW5fdGVz
dHMuc2gKPiArKysgYi90ZXN0Y2FzZXMvbGliL3J1bl90ZXN0cy5zaAo+IEBAIC05LDYgKzksNyBA
QCBzaGVsbF9sb2FkZXJfZmlsZXN5c3RlbXMuc2gKPiAgc2hlbGxfbG9hZGVyX2tjb25maWdzLnNo
Cj4gIHNoZWxsX2xvYWRlcl9zdXBwb3J0ZWRfYXJjaHMuc2gKPiAgc2hlbGxfbG9hZGVyX3RjbnQu
c2gKPiArc2hlbGxfbG9hZGVyX2NsZWFudXAuc2gKPiAgc2hlbGxfdGVzdDAxCj4gIHNoZWxsX3Rl
c3QwMgo+ICBzaGVsbF90ZXN0MDMKPiBAQCAtMjEsNyArMjIsOCBAQCBURVNUU19UQlJPSz0iCj4g
IHNoZWxsX2xvYWRlcl9pbnZhbGlkX2Jsb2NrLnNoCj4gIHNoZWxsX2xvYWRlcl9pbnZhbGlkX21l
dGFkYXRhLnNoCj4gIHNoZWxsX2xvYWRlcl9ub19tZXRhZGF0YS5zaAo+IC1zaGVsbF9sb2FkZXJf
d3JvbmdfbWV0YWRhdGEuc2giCj4gK3NoZWxsX2xvYWRlcl93cm9uZ19tZXRhZGF0YS5zaAo+CgpJ
dCBzZWVtcyB0aGUgc2hlbGxfbG9hZGVyX3dyb25nX21ldGFkYXRhLnNoIGlzIGEgZHVwbGljYXRl
IG9mCnNoZWxsX2xvYWRlcl9pbnZhbGlkX21ldGFkYXRhLiBNYXliZSB3ZSBjYW4gcmVtb3ZlIG9u
ZSBvZiB0aGVtLgoKT3RoZXJ3aXNlIGxvb2tzIGdvb2Q6ClJldmlld2VkLWJ5OiBMaSBXYW5nIDxs
aXdhbmdAcmVkaGF0LmNvbT4KCgoKPiArc2hlbGxfbG9hZGVyX2Jya19jbGVhbnVwLnNoIgo+Cj4g
IFRFU1RTX1RDT05GPSJzaGVsbF90ZXN0MDYiCj4KPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2xp
Yi90ZXN0cy9zaGVsbF9sb2FkZXJfYnJrX2NsZWFudXAuc2gKPiBiL3Rlc3RjYXNlcy9saWIvdGVz
dHMvc2hlbGxfbG9hZGVyX2Jya19jbGVhbnVwLnNoCj4gbmV3IGZpbGUgbW9kZSAxMDA3NTUKPiBp
bmRleCAwMDAwMDAwMDAwLi44YzcwNGE1NDA2Cj4gLS0tIC9kZXYvbnVsbAo+ICsrKyBiL3Rlc3Rj
YXNlcy9saWIvdGVzdHMvc2hlbGxfbG9hZGVyX2Jya19jbGVhbnVwLnNoCj4gQEAgLTAsMCArMSwy
MCBAQAo+ICsjIS9iaW4vc2gKPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1v
ci1sYXRlcgo+ICsjIENvcHlyaWdodCAoYykgMjAyNC0yMDI1IEN5cmlsIEhydWJpcyA8Y2hydWJp
c0BzdXNlLmN6Pgo+ICsjCj4gKyMgLS0tCj4gKyMgZW52Cj4gKyMgewo+ICsjIH0KPiArIyAtLS0K
PiArCj4gK1RTVF9DTEVBTlVQPWNsZWFudXAKPiArCj4gKy4gdHN0X2xvYWRlci5zaAo+ICsKPiAr
Y2xlYW51cCgpCj4gK3sKPiArICAgICAgIHRzdF9yZXMgVElORk8gIkNsZWFudXAgcnVucyIKPiAr
fQo+ICsKPiArdHN0X2JyayBUQlJPSyAiVGVzdCBleGl0cyIKPiBkaWZmIC0tZ2l0IGEvdGVzdGNh
c2VzL2xpYi90ZXN0cy9zaGVsbF9sb2FkZXJfY2xlYW51cC5zaAo+IGIvdGVzdGNhc2VzL2xpYi90
ZXN0cy9zaGVsbF9sb2FkZXJfY2xlYW51cC5zaAo+IG5ldyBmaWxlIG1vZGUgMTAwNzU1Cj4gaW5k
ZXggMDAwMDAwMDAwMC4uZmI3YmJkZjVhOQo+IC0tLSAvZGV2L251bGwKPiArKysgYi90ZXN0Y2Fz
ZXMvbGliL3Rlc3RzL3NoZWxsX2xvYWRlcl9jbGVhbnVwLnNoCj4gQEAgLTAsMCArMSwyMCBAQAo+
ICsjIS9iaW4vc2gKPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRl
cgo+ICsjIENvcHlyaWdodCAoYykgMjAyNC0yMDI1IEN5cmlsIEhydWJpcyA8Y2hydWJpc0BzdXNl
LmN6Pgo+ICsjCj4gKyMgLS0tCj4gKyMgZW52Cj4gKyMgewo+ICsjIH0KPiArIyAtLS0KPiArCj4g
K1RTVF9DTEVBTlVQPWRvX2NsZWFudXAKPiArCj4gKy4gdHN0X2xvYWRlci5zaAo+ICsKPiArZG9f
Y2xlYW51cCgpCj4gK3sKPiArICAgICAgIHRzdF9yZXMgVElORk8gIkNsZWFudXAgZXhlY3V0ZWQi
Cj4gK30KPiArCj4gK3RzdF9yZXMgVFBBU1MgIlRlc3QgaXMgZXhlY3V0ZWQiCj4gZGlmZiAtLWdp
dCBhL3Rlc3RjYXNlcy9saWIvdHN0X2Vudi5zaCBiL3Rlc3RjYXNlcy9saWIvdHN0X2Vudi5zaAo+
IGluZGV4IDY4ZjlhMGRhYTkuLmIxM2JhYjM3YzMgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2xp
Yi90c3RfZW52LnNoCj4gKysrIGIvdGVzdGNhc2VzL2xpYi90c3RfZW52LnNoCj4gQEAgLTM1LDMg
KzM1LDcgQEAgdHN0X2Jya18oKQo+Cj4gIGFsaWFzIHRzdF9yZXM9InRzdF9yZXNfICR0c3Rfc2Ny
aXB0X25hbWUgXCRMSU5FTk8iCj4gIGFsaWFzIHRzdF9icms9InRzdF9icmtfICR0c3Rfc2NyaXB0
X25hbWUgXCRMSU5FTk8iCj4gKwo+ICtpZiBbIC1uICIkVFNUX0NMRUFOVVAiIF07IHRoZW4KPiAr
ICAgICAgIHRyYXAgJFRTVF9DTEVBTlVQIEVYSVQKPiArZmkKPiAtLQo+IDIuNDcuMgo+Cj4KPiAt
LQo+IE1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0
cAo+Cj4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBz
Oi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
