Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB64D3EE6A
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 14:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1769091449; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=OylHnuVolPJ5NJniiFfk/eClCMbZlMYXhzuqnRUjD5A=;
 b=UYsuZZYWtiZWIpnLG58O22BLQ7hQ+qt9+VecIZj6Sl1L5i4FCxOS1eCQhTKtzzLBisUeY
 JjaRfis/NymG7dzSASDC0EDW+V3bcanh/VT+NC+Jzx0obFsuzN1NkRfFbo8x05Q6XgbnQ78
 CPb7vJm8U8QtGjGAsTFIq3y31LkH+ro=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D7B453CB730
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 15:17:29 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6CD833CB680
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 15:17:04 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AABE8200B76
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 15:17:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769091421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T8AdAeN0crPuBNrHh/W275EDLpk7gHJkKc5w0iv0SBY=;
 b=DsaXEjVw3bP+SsPJ97VmBIXIOsOchCYiHb8AIm0lIyNtQYVsJJZKFCR/5gOCjwiQAw58DP
 MxvHILCTNBnIuVdwVCShwDN0+W1GuochyY5Tr+sQb7XFx5XzhMbc4KSo32XXqO7qHa4t4g
 3MaSTXOLhgm+jONOKX2gAhDBR5ceRVU=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-jcLSptPzPUu7WmeIwfKKlw-1; Thu, 22 Jan 2026 09:17:00 -0500
X-MC-Unique: jcLSptPzPUu7WmeIwfKKlw-1
X-Mimecast-MFC-AGG-ID: jcLSptPzPUu7WmeIwfKKlw_1769091419
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2b70d8095daso915321eec.1
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 06:17:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769091419; x=1769696219;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T8AdAeN0crPuBNrHh/W275EDLpk7gHJkKc5w0iv0SBY=;
 b=djnfFuZrGaZlRv6pFkwtBvOWtCAUS27FqHktDqDO+S+0UAsUrzv3s+hXMcsT8Xs/I8
 RaHu2uphpmb1Wzs54bTS1vHPYn1T6JyKcy8i1I4+bemahy48yH5yyYXtpTJoxEL9pUuj
 AoNEqwRx0tKOUxxj6pVMuMJiULcaJ8Cd5ABIACyW00jJgMloheJEhJnf/vyoL/dro4ML
 d+1mtc3nayoxXbol83M5OJIgwpncsloFK1sucZJ8TqsqdDi2+6cJ37fDY2eB6AVQDgH6
 ejiI8bQWrdwrUwzQHXAYlwIwLIh3PAbHEk6a95USwIniYpCJBkqE5uUgZLDc64f2QQg7
 /tng==
X-Forwarded-Encrypted: i=1;
 AJvYcCVs7WkaDLwKKtxK3iFAy7ze/EOuNwYe7ZUgb317pSpk44VjUyGPAWguGwK4FGyRsbSBnUk=@lists.linux.it
X-Gm-Message-State: AOJu0YxY2kjyhIMUaU9Sw/UVudcIRgIlGwC3YB1n/t444mbSftX/bFqx
 QDBhwdWufcTH2L18ZnmSt222Mfpa29YYF7lasKvuCBqwhYA7qpTHdTxAkKypjYv4GNXl5H+4Rru
 VI+xMRAvziRhDJqn+cguL4ofHvWN4w3Dc2GKWymaP8W0JmaYvIOwxvk1nakWasK+paVvP9iK5AI
 ejBzYOYKrPcv+b7NUBG0KwirpBXiQ=
X-Gm-Gg: AZuq6aIZAin5kIs9hRRTz6Q7KT0MFFBKtA17nO1U4Mvsoh1P1PxZCWKK1PJcbHG408j
 JpJMciIZZ+HslGM3IipuDCAtm0mZQwSpEV7RSM4h3nXei3OsIAaR/l0FaNI0VFVbW6pF+s9Yn0r
 5T8s/UpBiGY1qMt0y8+P5Dp2DZFMQmbNEfYdcZdXUd9+8AWlgL6fPWRD3hHtIn0C3Iqmw=
X-Received: by 2002:a05:7300:d518:b0:2b7:24ad:5c54 with SMTP id
 5a478bee46e88-2b724ad6420mr2016165eec.9.1769091418978; 
 Thu, 22 Jan 2026 06:16:58 -0800 (PST)
X-Received: by 2002:a05:7300:d518:b0:2b7:24ad:5c54 with SMTP id
 5a478bee46e88-2b724ad6420mr2016150eec.9.1769091418525; Thu, 22 Jan 2026
 06:16:58 -0800 (PST)
MIME-Version: 1.0
References: <20260122102606.87754-1-liwang@redhat.com>
 <CAASaF6w3S2STiyS9LvOsK_uVEvRoO6uq=XNMG-cMNheC0k1RHg@mail.gmail.com>
 <20260122123154.GC64562@pevik>
 <CAEemH2c8+X85Ac-oPtsOND=OW=YHvx1R_TNctTThfskKhgOP9Q@mail.gmail.com>
 <20260122130634.GA71214@pevik>
In-Reply-To: <20260122130634.GA71214@pevik>
Date: Thu, 22 Jan 2026 22:16:46 +0800
X-Gm-Features: AZwV_QhtzOaINHt7m6PJuoGsae2tDDPX8AvhxwZZcLjPZIoiAKM3qDL4pEP-EqY
Message-ID: <CAEemH2dLV-XpBo_t+=894dxOWEdZ0CX6KeU7Fz1xE2AdfKDsKA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gXxdd-Oz4ipymi9E2-YT-SBJeuKw-uAyHJBY5irluRc_1769091419
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] clone10: add support archs
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

T24gVGh1LCBKYW4gMjIsIDIwMjYgYXQgOTowNuKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+ID4gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgo+Cj4g
PiA+ID4gQWNrZWQtYnk6IEphbiBTdGFuY2VrIDxqc3RhbmNla0ByZWRoYXQuY29tPgo+Cj4gPiA+
IExHVE0uIEluZGVlZCBvbmx5IHRoZXNlIDMgYXJjaHMgZG9uJ3QgVENPTkYuCj4gPiA+IEFja2Vk
LWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPgo+ID4gPiBPdXQgb2YgY3VyaW9zaXR5
LCB3aGVyZSBpcyB0aGUgc3VwcG9ydCBkZWZpbmVkIGluIGtlcm5lbD8KPiA+ID4gImlmIChjbG9u
ZV9mbGFncyAmIENMT05FX1NFVFRMUykiIGlzIGluIG1hbnkgYXJjaHM6Cj4KPiA+IE5vdCBiYXNl
ZCBvbiB0aGlzLCB0aGUgY2xvbmUxMC5jIHRlc3Qgd2FzIHdyaXR0ZW4gYW5kIGdldHMgdGVzdGVk
Cj4gPiBvbmx5IG9uIHRoZSBrbm93biBhcmNocyAoeDg2XzY0LCBzMzkweCwgYWFyY2g2NCkgYnkg
bm93Lgo+Cj4gPiBBbmQgaW4gY2FzZSB0aGF0IG90aGVyIGFyY2hzIChub3QgdGVzdGVkKSBoYXZl
IGRpZmZlcmVudCBiZWhhdmlvciBsaWtlIGkzODYsCj4gPiBzbyB3ZSBhcmUgbGltaXRlZCB0byB0
aGUga25vdy90ZXN0ZWQgYXJjaHMuCj4KPiA+IElmIHdlIGNhbiBnZXQgYW5vdGhlciBhcmNoIHRv
IHZlcmlmaWVkIHdlIGNhbiBhZGQgaXQgdG8gdGhlCj4gPiAuc3VwcG9ydGVkX2FyY2hzIGFzIHdl
bGwuCj4KPiA+ICQgY2F0IC1uIGx0cC9pbmNsdWRlL2xhcGkvdGxzLmgKPiA+ICAgICAuLi4KPiA+
ICAgICA1MyBzdGF0aWMgaW5saW5lIHZvaWQgaW5pdF90bHModm9pZCkKPiA+ICAgICA1NCB7Cj4g
PiAgICAgNTUgICAgICNpZiBkZWZpbmVkKF9feDg2XzY0X18pIHx8IGRlZmluZWQoX19hYXJjaDY0
X18pIHx8IGRlZmluZWQoX19zMzkweF9fKQo+ID4gICAgIDU2ICAgICB0bHNfcHRyID0gYWxsb2Nh
dGVfdGxzX2FyZWEoKTsKPiA+ICAgICA1NyAjZWxzZQo+ID4gICAgIC4uLgo+Cj4gaW5jbHVkZS9s
YXBpL3Rscy5oCj4KPiBzdGF0aWMgaW5saW5lIHZvaWQgaW5pdF90bHModm9pZCkKPiB7Cj4gI2lm
IGRlZmluZWQoX194ODZfNjRfXykgfHwgZGVmaW5lZChfX2FhcmNoNjRfXykgfHwgZGVmaW5lZChf
X3MzOTB4X18pCj4gICAgICAgICB0bHNfcHRyID0gYWxsb2NhdGVfdGxzX2FyZWEoKTsKPiAjZWxz
ZQo+ICAgICAgICAgdHN0X2JyayhUQ09ORiwgIlVuc3VwcG9ydGVkIGFyY2hpdGVjdHVyZSBmb3Ig
VExTIik7Cj4gI2VuZGlmCj4KPiBJIHNlZS4gRmlyc3QgSU1ITyB0aGUgbWVzc2FnZSBpbiBpbmNs
dWRlL2xhcGkvdGxzLmggaXMgcHJldHR5IG1pc2xlYWRpbmcuIEl0Cj4gZG9lcyBub3QgbG9vayB0
byBtZSBhcyBhIHRlc3QgbGltaXRhdGlvbiwgYnV0IGFzIGEgbWlzc2luZyBhcmNoIHN1cHBvcnQg
aW4KPiBrZXJuZWwuICBJTUhPIHRoZSBtZXNzYWdlIHNob3VsZCBoYXZlIGJlZW4gc29tZXRoaW5n
IGxpa2U6CgorMQoKPiB0c3RfYnJrKFRDT05GLCAiVGVzdCBub3Qgc3VwcG9ydGVkIG9ubHkgYXJj
aGl0ZWN0dXJlIik7Cj4KPiAoaS5lLiB0byBtZW50aW9uICJ0ZXN0IikKPgo+IEFsc28gaGF2aW5n
IGFyY2ggbGlzdGVkIGluIHRoZSB0ZXN0IGFuZCBhbHNvIGluIHRscy5oIGlzIHJlZHVuZGFudC4K
PiBJTUhPIGl0IHNob3VsZCBiZSBvbmx5IG9uIGEgc2luZ2xlIHBsYWNlLgoKQWJzb2x1dGVseSB5
ZXMsIGFuZCBsb29rcyBsaWtlIHRoZSBpZmRlZmluZSBpbiB0bHMuaCBzaG91bGQgYmUgY2xlYW51
cCB0b28uCkZlZWwgZnJlZSBkbyB0aGF0IGluIGEgc2VwZXJhdGUgcGF0Y2ggb3IgSSB3aWxsIGxv
b2sgaW50byBpdCB0b21vcnJvdy4KCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
