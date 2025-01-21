Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D836FC02182
	for <ltp@archiver.kernel.org>; Tue, 21 Jan 2025 08:49:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 32A533C261F
	for <ltp@archiver.kernel.org>; Tue, 21 Jan 2025 09:49:02 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9C9D93C0229
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 09:48:47 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id ED492208095
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 09:48:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737449325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jlKEdeXBgV48963BUQkvj8pJo694GFHJ1//O8V2G8nM=;
 b=gXwcQUyzDxRrYysCwmHpCXSVgSQ/Gf8xVNIuvONBzyQTrB+hcPoTW0e39ul1hQtz40GLBV
 ArQ8YpnfHI/0tyumZln2VTKDdSi1OnGiVonHjO7LD67ucAAZJbgDaMfp9Hpsd0CvWg6coS
 wash6tRtpnzEKY5sMaNbeHJppD0necQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-rZ86OPoVMFauwkL9t3Zr3Q-1; Tue, 21 Jan 2025 03:48:42 -0500
X-MC-Unique: rZ86OPoVMFauwkL9t3Zr3Q-1
X-Mimecast-MFC-AGG-ID: rZ86OPoVMFauwkL9t3Zr3Q
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2f2a9743093so9874041a91.3
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 00:48:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737449321; x=1738054121;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jlKEdeXBgV48963BUQkvj8pJo694GFHJ1//O8V2G8nM=;
 b=rml/iSzDS2p0dF7yePj0CVv7PMa72e69evpjISfnlHP1G2RAVnYesST3pC04VLLWb+
 o4HITqXe2klO4x4xNxHrueoomcx+/6gN+SL32Ry28yMAqeL+IZ5ZO23gOQt+Ye0uMy8f
 RmFRGPMT4bt1TPLdoGc9po3xW+2kDvPPX9gEkPt9rgHEHK8kSUN7bLEZ8oV5G5dJ/7aF
 2UYPte61OCmxggZ+wGaI+8V/3h3eTEhwLCVOrz27Oz2WoAVhiT8hZUifIGl0PXBfu9Vx
 zLkf7nmtrWbI7/nP9ncKncWSKFqYLY16mejcnqTduFHUXRBxo2w2lTGaG9gCXwdU8iY2
 XjkA==
X-Gm-Message-State: AOJu0YysyspOcaQcoup2/LdoisHiVcWvaO5UxHgKhzNgwZ3R3zK5gSdS
 WfbABqxTOCGIWSEn6HckVf69/FwqHhskz26oxq/yjGd+BgdkiepjORG0hgc/YqQn5AeNq/ku4su
 /StmGyhBQvO8uVrmmxY0hPhTFaqj3AUwHLb+yeFTJazr9Hw/jmrLuMfUZinrbnbWMXCHTlvGe2E
 rK/OmvRmnLniAY5+UC44pF5QM=
X-Gm-Gg: ASbGncvH8EohcmYmuTSYKSadJFtQl2NfSE3AgofKi+CbkoS2lujp/ijWeae4wgoDvB/
 NkHtIX7rIlv+Q7gFpA8YTIxbPVk4siK3xY2EAv/oUZZcqkN2Wsq2x
X-Received: by 2002:a17:90b:544f:b0:2ee:f076:20fa with SMTP id
 98e67ed59e1d1-2f782d4eda2mr23733260a91.25.1737449321176; 
 Tue, 21 Jan 2025 00:48:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsvYYxxVIto92hzyeID12o4vf06+X2QcQ027l1S6QFdaY8dMAqdG/nqxCGsNaRmqAX4tmJgWn9Psqq8wrxUnc=
X-Received: by 2002:a17:90b:544f:b0:2ee:f076:20fa with SMTP id
 98e67ed59e1d1-2f782d4eda2mr23733237a91.25.1737449320870; Tue, 21 Jan 2025
 00:48:40 -0800 (PST)
MIME-Version: 1.0
References: <20250120143420.815363-1-pvorel@suse.cz>
In-Reply-To: <20250120143420.815363-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Tue, 21 Jan 2025 16:48:29 +0800
X-Gm-Features: AbW1kvZzf-ZgNTdgCxLw1D3IDJ_usfkN3m1ibWsOrgJzSIq5sz945vQsM5CFWOM
Message-ID: <CAEemH2ftoFk6+5rR5z1oHreVaJA_e1MWLZ6VcM+K5CPC9DfQ5Q@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: s9zJZGrgj2xq64vPWn-FDsggK5gqOZP6U3EMrtTrXo8_1737449321
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] lib: Remove CONFIG_LATENCYTOP as "slow"
 kernel option
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
Cc: ltp@lists.linux.it, Alessandro Carminati <acarmina@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBKYW4gMjAsIDIwMjUgYXQgMTA6MzTigK9QTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3Vz
ZS5jej4gd3JvdGU6Cgo+IENPTkZJR19MQVRFTkNZVE9QIGVuYWJsZXMgYSBrZXJuZWwgbGF0ZW5j
eSB0cmFja2luZyBpbmZyYXN0cnVjdHVyZSB0aGF0IGlzCj4gdXNlZCBieSB0aGUgImxhdGVuY3l0
b3AiIHVzZXJzcGFjZSB0b29sLiBUaGUgbGF0ZW5jeSB0aGF0IGlzIHRyYWNrZWQgaXMgbm90Cj4g
ZWxzZSBjb25zdW1pbmcgQ1BVKSwgYnV0IGluc3RlYWQsIGl0IGlzIHRoZSBsYXRlbmN5IGFuIGFw
cGxpY2F0aW9uCj4gZW5jb3VudGVycwo+IGJlY2F1c2UgdGhlIGtlcm5lbCBzbGVlcHMgb24gaXRz
IGJlaGFsZiBmb3IgdmFyaW91cyByZWFzb25zLgo+Cj4gVGhpcyBjb2RlIHRyYWNrcyAyIGxldmVs
cyBvZiBzdGF0aXN0aWNzOgo+IDEpIFN5c3RlbSBsZXZlbCBsYXRlbmN5Cj4gMikgUGVyIHByb2Nl
c3MgbGF0ZW5jeQo+Cj4gSU1ITyB0aGlzIG9wdGlvbiBpcyBzYWZlIHVubGVzcyBvbmUgcnVucyBs
YXRlbmN5dG9wIHVzZXJzcGFjZSB0b29sIHdoaWxlCj4gdGVzdGluZyBMVFAuCj4KPiBNb3RpdmF0
aW9uIGZvciB0aGlzIGlzIHRoZSBvcGVuU1VTRSBhbmQgc29tZSBTTEVTIGtlcm5lbHMgdXNlCj4g
Q09ORklHX0xBVEVOQ1lUT1AgYW5kIGFsbCB0ZXN0cyBhcmUgd29ya2luZyB3aXRoIGEgZGVmYXVs
dCB0aW1lb3V0Lgo+IHN0YXJ2YXRpb24uYyBpcyBkaXNhYmxlZCB3aXRoIFRDT05GIG9uIHNsb3cg
a2VybmVscywgd2hpY2ggcHJldmlvdXNseQo+IHdvcmtlZCB3ZWxsIG9uIGtlcm5lbHMgd2l0aCBD
T05GSUdfTEFURU5DWVRPUC4KPgo+IFNpZ25lZC1vZmYtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBz
dXNlLmN6Pgo+CgpUaGFua3MgZm9yIHJlbW92aW5nIHRoaXMsIEkgZGlkbid0IGRvIG11Y2ggbW9y
ZSBldmFsdWF0aW9uIG9uIHRoYXQgY29uZmlnCndoaWxlIGFkZGluZyBpdCB0byB0c3RfaGFzX3Ns
b3dfa2NvbmZpZygpLgoKUmV2aWV3ZWQtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPgoK
LS0tCj4gTk9URTogSSB3b3VsZCBsaWtlIHRvIGdldCB0aGlzIG1lcmdlZCBiZWZvcmUgdXBjb21p
bmcgcmVsZWFzZS4KPgo+IEtpbmQgcmVnYXJkcywKPiBQZXRyCj4KPiAgbGliL3RzdF9rY29uZmln
LmMgfCAxIC0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQg
YS9saWIvdHN0X2tjb25maWcuYyBiL2xpYi90c3Rfa2NvbmZpZy5jCj4gaW5kZXggNjY0MDJlMzcw
ZC4uOWJjZDU3NzIxMCAxMDA2NDQKPiAtLS0gYS9saWIvdHN0X2tjb25maWcuYwo+ICsrKyBiL2xp
Yi90c3Rfa2NvbmZpZy5jCj4gQEAgLTY0NCw3ICs2NDQsNiBAQCBzdGF0aWMgc3RydWN0IHRzdF9r
Y29uZmlnX3ZhciBzbG93X2tjb25maWdzW10gPSB7Cj4gICAgICAgICBUU1RfS0NPTkZJR19JTklU
KCJDT05GSUdfS0FTQU4iKSwKPiAgICAgICAgIFRTVF9LQ09ORklHX0lOSVQoIkNPTkZJR19TTFVC
X1JDVV9ERUJVRyIpLAo+ICAgICAgICAgVFNUX0tDT05GSUdfSU5JVCgiQ09ORklHX1RSQUNFX0lS
UUZMQUdTIiksCj4gLSAgICAgICBUU1RfS0NPTkZJR19JTklUKCJDT05GSUdfTEFURU5DWVRPUCIp
LAo+ICAgICAgICAgVFNUX0tDT05GSUdfSU5JVCgiQ09ORklHX0RFQlVHX05FVCIpLAo+ICAgICAg
ICAgVFNUX0tDT05GSUdfSU5JVCgiQ09ORklHX0VYVDRfREVCVUciKSwKPiAgICAgICAgIFRTVF9L
Q09ORklHX0lOSVQoIkNPTkZJR19RVU9UQV9ERUJVRyIpLAo+IC0tCj4gMi40Ny4xCj4KPgoKLS0g
ClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5s
aW51eC5pdC9saXN0aW5mby9sdHAK
