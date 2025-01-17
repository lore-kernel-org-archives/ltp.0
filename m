Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE6DC02185
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 08:28:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C2E93C7C30
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 09:27:59 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9B8993C7C19
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 09:27:41 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 550E91BD1723
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 09:27:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737102459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hYuedOnOoIN1IGtQGmqh23rP2yewGGrz6oslkJauZDs=;
 b=EEZcXziCk+zKqDOBq47Yb5UJLqyglB2o8IOhF4B32cx0d+6wb0b1twm000LASa7ZQKRlAn
 Nx6JtA8lLNVI2x8fDt/E1PP9+KhgLRg/aQXEYuyUNY7TIOlpw3vyFIcfNpsLsewy1ljaxs
 WIAkGvJeLQ+bcuRuIash8DXDuQikVgE=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-ZjpO0nWROjqdKGAWYpL0Jg-1; Fri, 17 Jan 2025 03:27:37 -0500
X-MC-Unique: ZjpO0nWROjqdKGAWYpL0Jg-1
X-Mimecast-MFC-AGG-ID: ZjpO0nWROjqdKGAWYpL0Jg
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2ef9864e006so5299946a91.2
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 00:27:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737102456; x=1737707256;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hYuedOnOoIN1IGtQGmqh23rP2yewGGrz6oslkJauZDs=;
 b=oe8r0F2Q2cfPNZL9QwwIziiLrltBdjc/vRm6hIfG2AbGOXF2rkTYlt6nL7jf3ha8Ke
 YebUM1XLVuWd3XdooNjtyFmIVvLAA3Y5sedU6y2kD+kb4FnzBvCEWdQhhAg3jS43Vglz
 zq2iCgRMj3SBd3o1W3g3y/khzAHsPe+mzMz8Px7KSEjtW5FqqFy3H6bwmqBPhgwsRcMS
 TyV+ecidXguCoGVBcXELHqN5sx2TNQpAcx3LKUhvN36pHLnO8sVklTdANdFForlm7K07
 j68i2Z+YUYE50wu9MSOWnywT9o5h8mRzLtJI2wTJEZz4qssZ9FyjtGxmN9VH+ZDaYq+D
 vGiQ==
X-Gm-Message-State: AOJu0Ywrxuxz69K1uZMUqWCHbf4wfH/23vQX2RP0cdJPzAqELKUPRDAp
 IE9smj7JOkXW4QykcmcylQYcTDK9IC4ibKHih/6LzB9ecKHjAn7YM4rJ4wRjEvLnCrB8UlThqpu
 2fmu0WFtoScUoWD+aYt/ITOCfc4ap3BEZtCwKlS2SjjdOHvXMgHcxY55KVawDUFh2w7iaEUwXaQ
 PjIyHP5SRs6fiUr1DIOWtR4Hc=
X-Gm-Gg: ASbGncusVy9BvlXryHA49vptxhWGW7BM0z0c8ZqLJvxR4ZdiXjIhOimCaS9z4EZ9qtN
 2cZuyIU0LgeHl9tJFH9I4cY0tu0Gn7Qf40lvdRNU=
X-Received: by 2002:a17:90b:5201:b0:2ee:d797:40a4 with SMTP id
 98e67ed59e1d1-2f782c70204mr2544113a91.8.1737102456337; 
 Fri, 17 Jan 2025 00:27:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+1BaWzryUKZjbzM6xT1wPgt9q4nf2Tfz9utQK9elneCKD9Hg/s7ufB8G6fXVqNRaV8JOCYdCkGgw3rByxvxY=
X-Received: by 2002:a17:90b:5201:b0:2ee:d797:40a4 with SMTP id
 98e67ed59e1d1-2f782c70204mr2544007a91.8.1737102454563; Fri, 17 Jan 2025
 00:27:34 -0800 (PST)
MIME-Version: 1.0
References: <20250117071758.120366-1-liwang@redhat.com>
 <95cf0806-4600-4949-8ed7-a31cacf2c8a5@suse.com>
In-Reply-To: <95cf0806-4600-4949-8ed7-a31cacf2c8a5@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 17 Jan 2025 16:27:22 +0800
X-Gm-Features: AbW1kvZiBGt2L4_7mnfA605Foe9X8dRWudvkEYnFulm7Y11-iyofSYxIkLXogtw
Message-ID: <CAEemH2f4DoH4Lggpncbh9OmCcu0AQBc8Fp_yczE5EG2C=MLn+w@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>, Petr Vorel <pvorel@suse.cz>, 
 Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: I1p-z3MMACP3F7aDvNmlIlTQdRwx16-rTWT-yJUpnYM_1737102456
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] lib: add TST_NO_SLOW_KCONFIG_CHECK macro for
 testcase tools
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

T24gRnJpLCBKYW4gMTcsIDIwMjUgYXQgMzo0OeKAr1BNIEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJl
YS5jZXJ2ZXNhdG9Ac3VzZS5jb20+Cndyb3RlOgoKPiBIaSBMaSwKPgo+IHRoZSBmZWF0dXJlIGlz
IGludGVyZXN0aW5nLCBidXQgSSBoYXZlIHRoZSBmZWVsaW5nIHRoaXMgc2hvdWxkIGJlIGFkZGVk
Cj4gdG8gdHN0X3Rlc3Qgc3RydWN0IHJhdGhlciB0aGFuIHVzaW5nIGEgZmxhZyBhdCBjb21waWxl
IHRpbWUuCj4gRm9yIGV4YW1wbGUsIGJ5IGFkZGluZyB0byB0c3RfdGVzdCBhIHNsb3dfa2NvbmZp
ZyBhdHRyaWJ1dGUuCj4KClRoYW5rcy4gQnV0IHNvdW5kcyBhIGxpdHRsZSBiaXQgdW5uZWNlc3Nh
cnkgdG8gYWRkIG5ldyBmaWVsZCBpbiB0c3RfdGVzdApzdHJ1Y3QuCgpXaGF0IGFib3V0IHVzaW5n
IGFuIGdsb2JhbCB2YXJpYWJsZSBsaWtlIHRzdF9ub19zbG93X2tjb2ZpZ19jaGVjayA/CgoKCj4K
PiBBbmRyZWEKPgo+IE9uIDEvMTcvMjUgMDg6MTcsIExpIFdhbmcgd3JvdGU6Cj4gPiBUaGUgbWFj
cm8gVFNUX05PX1NMT1dfS0NPTkZJR19DSEVDSyBpcyBhZGRlZCB0byBjb250cm9sIHdoZXRoZXIK
PiA+IHRoZSB0c3RfaGFzX3Nsb3dfa2NvbmZpZygpIGZ1bmN0aW9uICh3aGljaCBwcmVzdW1hYmx5
IGNoZWNrcyBmb3IKPiA+IHNsb3cga2VybmVsIGNvbmZpZ3VyYXRpb25zKSBzaG91bGQgYmUgZXhl
Y3V0ZWQuCj4gPgo+ID4gVGhpcyBhbGxvd3MgdGVzdCBjYXNlcyBhbmQgdG9vbHMgdG8gb3B0IG91
dCBvZiB0aGlzIGFkZGl0aW9uYWwKPiA+IGNoZWNrLCBlbmFibGluZyBtb3JlIGZsZXhpYmxlIGFu
ZCBmYXN0ZXIgdGVzdCBleGVjdXRpb24gaW4KPiA+IGNlcnRhaW4gc2NlbmFyaW9zLgo+ID4KPiA+
IFNpZ25lZC1vZmYtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPgo+ID4gLS0tCj4gPiAg
IGxpYi90c3RfdGVzdC5jICAgICAgICAgICAgICAgICAgICB8IDIgKysKPiA+ICAgdGVzdGNhc2Vz
L2xpYi90c3RfZGV2aWNlLmMgICAgICAgIHwgMSArCj4gPiAgIHRlc3RjYXNlcy9saWIvdHN0X2dl
dF9mcmVlX3BpZHMuYyB8IDEgKwo+ID4gICB0ZXN0Y2FzZXMvbGliL3RzdF9uc19jcmVhdGUuYyAg
ICAgfCAxICsKPiA+ICAgdGVzdGNhc2VzL2xpYi90c3RfbnNfZXhlYy5jICAgICAgIHwgMSArCj4g
PiAgIHRlc3RjYXNlcy9saWIvdHN0X3J1bl9zaGVsbC5jICAgICB8IDEgKwo+ID4gICA2IGZpbGVz
IGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9saWIvdHN0X3Rl
c3QuYyBiL2xpYi90c3RfdGVzdC5jCj4gPiBpbmRleCBiMjA0YWQ5NzUuLjAwZDM0YjZmMCAxMDA2
NDQKPiA+IC0tLSBhL2xpYi90c3RfdGVzdC5jCj4gPiArKysgYi9saWIvdHN0X3Rlc3QuYwo+ID4g
QEAgLTE3MDIsOCArMTcwMiwxMCBAQCB1bnNpZ25lZCBpbnQgdHN0X211bHRpcGx5X3RpbWVvdXQo
dW5zaWduZWQgaW50Cj4gdGltZW91dCkKPiA+ICAgICAgIGlmICh0aW1lb3V0IDwgMSkKPiA+ICAg
ICAgICAgICAgICAgdHN0X2JyayhUQlJPSywgInRpbWVvdXQgbXVzdCB0byBiZSA+PSAxISAoJWQp
IiwgdGltZW91dCk7Cj4gPgo+ID4gKyNpZm5kZWYgVFNUX05PX1NMT1dfS0NPTkZJR19DSEVDSwo+
ID4gICAgICAgaWYgKHRzdF9oYXNfc2xvd19rY29uZmlnKCkpCj4gPiAgICAgICAgICAgICAgIHRp
bWVvdXQgKj0gNDsKPiA+ICsjZW5kaWYKPiA+Cj4gPiAgICAgICByZXR1cm4gdGltZW91dCAqIHRp
bWVvdXRfbXVsOwo+ID4gICB9Cj4gPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2xpYi90c3RfZGV2
aWNlLmMgYi90ZXN0Y2FzZXMvbGliL3RzdF9kZXZpY2UuYwo+ID4gaW5kZXggNDVmNzdhMzhiLi4z
ODY2MzY2MTAgMTAwNjQ0Cj4gPiAtLS0gYS90ZXN0Y2FzZXMvbGliL3RzdF9kZXZpY2UuYwo+ID4g
KysrIGIvdGVzdGNhc2VzL2xpYi90c3RfZGV2aWNlLmMKPiA+IEBAIC04LDYgKzgsNyBAQAo+ID4g
ICAjaW5jbHVkZSA8c3RkaW8uaD4KPiA+ICAgI2luY2x1ZGUgPHN0ZGxpYi5oPgo+ID4gICAjZGVm
aW5lIFRTVF9OT19ERUZBVUxUX01BSU4KPiA+ICsjZGVmaW5lIFRTVF9OT19TTE9XX0tDT05GSUdf
Q0hFQ0sKPiA+ICAgI2luY2x1ZGUgInRzdF90ZXN0LmgiCj4gPiAgICNpbmNsdWRlICJvbGQvb2xk
X2RldmljZS5oIgo+ID4KPiA+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMvbGliL3RzdF9nZXRfZnJl
ZV9waWRzLmMKPiBiL3Rlc3RjYXNlcy9saWIvdHN0X2dldF9mcmVlX3BpZHMuYwo+ID4gaW5kZXgg
MzcwZWMzZTI2Li5jNjQzNjY4N2EgMTAwNjQ0Cj4gPiAtLS0gYS90ZXN0Y2FzZXMvbGliL3RzdF9n
ZXRfZnJlZV9waWRzLmMKPiA+ICsrKyBiL3Rlc3RjYXNlcy9saWIvdHN0X2dldF9mcmVlX3BpZHMu
Ywo+ID4gQEAgLTEsNiArMSw3IEBACj4gPiAgIC8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBH
UEwtMi4wLW9yLWxhdGVyCj4gPgo+ID4gICAjZGVmaW5lIFRTVF9OT19ERUZBVUxUX01BSU4KPiA+
ICsjZGVmaW5lIFRTVF9OT19TTE9XX0tDT05GSUdfQ0hFQ0sKPiA+ICAgI2luY2x1ZGUgPHN0ZGlv
Lmg+Cj4gPiAgICNpbmNsdWRlICJ0c3RfdGVzdC5oIgo+ID4KPiA+IGRpZmYgLS1naXQgYS90ZXN0
Y2FzZXMvbGliL3RzdF9uc19jcmVhdGUuYwo+IGIvdGVzdGNhc2VzL2xpYi90c3RfbnNfY3JlYXRl
LmMKPiA+IGluZGV4IGNlMzcwN2E2MC4uOGMyMmFkNDQ5IDEwMDY0NAo+ID4gLS0tIGEvdGVzdGNh
c2VzL2xpYi90c3RfbnNfY3JlYXRlLmMKPiA+ICsrKyBiL3Rlc3RjYXNlcy9saWIvdHN0X25zX2Ny
ZWF0ZS5jCj4gPiBAQCAtMTcsNiArMTcsNyBAQAo+ID4gICAgKi8KPiA+Cj4gPiAgICNkZWZpbmUg
VFNUX05PX0RFRkFVTFRfTUFJTgo+ID4gKyNkZWZpbmUgVFNUX05PX1NMT1dfS0NPTkZJR19DSEVD
Swo+ID4KPiA+ICAgI2luY2x1ZGUgPHN0ZGlvLmg+Cj4gPiAgICNpbmNsdWRlIDxzdHJpbmcuaD4K
PiA+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMvbGliL3RzdF9uc19leGVjLmMgYi90ZXN0Y2FzZXMv
bGliL3RzdF9uc19leGVjLmMKPiA+IGluZGV4IDZhOGUzOTMzOS4uY2E1YjcxN2RhIDEwMDY0NAo+
ID4gLS0tIGEvdGVzdGNhc2VzL2xpYi90c3RfbnNfZXhlYy5jCj4gPiArKysgYi90ZXN0Y2FzZXMv
bGliL3RzdF9uc19leGVjLmMKPiA+IEBAIC0xNCw2ICsxNCw3IEBACj4gPiAgICAqLwo+ID4KPiA+
ICAgI2RlZmluZSBUU1RfTk9fREVGQVVMVF9NQUlOCj4gPiArI2RlZmluZSBUU1RfTk9fU0xPV19L
Q09ORklHX0NIRUNLCj4gPgo+ID4gICAjaW5jbHVkZSA8c3RkaW8uaD4KPiA+ICAgI2luY2x1ZGUg
PHN5cy93YWl0Lmg+Cj4gPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2xpYi90c3RfcnVuX3NoZWxs
LmMKPiBiL3Rlc3RjYXNlcy9saWIvdHN0X3J1bl9zaGVsbC5jCj4gPiBpbmRleCA3YTQ0NmUwMDQu
LmIxMmExZTlmNiAxMDA2NDQKPiA+IC0tLSBhL3Rlc3RjYXNlcy9saWIvdHN0X3J1bl9zaGVsbC5j
Cj4gPiArKysgYi90ZXN0Y2FzZXMvbGliL3RzdF9ydW5fc2hlbGwuYwo+ID4gQEAgLTUsNiArNSw3
IEBACj4gPiAgICNpbmNsdWRlIDxzeXMvbW91bnQuaD4KPiA+Cj4gPiAgICNkZWZpbmUgVFNUX05P
X0RFRkFVTFRfTUFJTgo+ID4gKyNkZWZpbmUgVFNUX05PX1NMT1dfS0NPTkZJR19DSEVDSwo+ID4g
ICAjaW5jbHVkZSAidHN0X3Rlc3QuaCIKPiA+ICAgI2luY2x1ZGUgInRzdF9zYWZlX3N0ZGlvLmgi
Cj4gPiAgICNpbmNsdWRlICJ1anNvbi5oIgo+Cj4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAK
TWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
