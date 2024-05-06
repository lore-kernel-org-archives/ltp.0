Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03220C4345F
	for <ltp@archiver.kernel.org>; Mon,  6 May 2024 03:21:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B2E1B3CD94B
	for <ltp@archiver.kernel.org>; Mon,  6 May 2024 05:21:52 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C380A3C0657
 for <ltp@lists.linux.it>; Mon,  6 May 2024 05:21:35 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 939B8100FD8B
 for <ltp@lists.linux.it>; Mon,  6 May 2024 05:21:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714965693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t56oQjbvhUNdhOpP+XUghr7tf2mYkw2apsTi6lY8H6o=;
 b=E+QNOyth3lXEJ53NqEqQQHj9etBypXeJD7jM3leqwtNvXwHqZlHvGY+es8Ae+tCYBijtdq
 B8jFT5yw8uIvDVzt8b9OHNF+DksbHP1l5FP+rqm7R6wamz/IRUSSo7J3FYxC+ROznIjki3
 IXtGv5+7d5N64h5pbOiMdDcibCEqZ5g=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-O882O1hGMHSEpy-R9D2eAw-1; Sun, 05 May 2024 23:21:29 -0400
X-MC-Unique: O882O1hGMHSEpy-R9D2eAw-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2b34facb83aso2016305a91.3
 for <ltp@lists.linux.it>; Sun, 05 May 2024 20:21:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714965688; x=1715570488;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t56oQjbvhUNdhOpP+XUghr7tf2mYkw2apsTi6lY8H6o=;
 b=TMOL7Uc3WQHG+Hd8182Lrj9ZLeCZmR7mjyJ4m+9ZA8HJNh0R/B6ARIfXM5AfRiET6k
 2TR7793HBcDuxGf5j4WpL3WQwB7ZvhmNBudGffb7OW4iHVJLzF8M4+9px7rowGYnsM5q
 UQaV9HGJZiIPDuehOchoHpwuIOapeQZ5i3F5FppPuyD496r7SK38Ay6SAjGwY9qlXrTC
 CQZc4U7tqu1e/tAt74NuXJs3oQxpv0bup7hBIJQXWDSmjgyVHLCFrNPS6V1hNuO2faXu
 1tIUeS28NoD40DYB+aNvoy2FeAEu+slBaywLrkNdmZ1X9bz4J3kZuQYTi9P9aF6qWdXz
 BCsw==
X-Gm-Message-State: AOJu0YyhN8pKZgaHbBmdDEJEBs06eieS0zRcKd2SuOqetjM3EIhU77bw
 RYYlR/8wSGtq/qRLwPp3005b9Qjlv8dtfp/giTRPZ75S/XL7bmqb3yNZbuDg3QhT7Y35pBdp8od
 T/YnFvzyWXz+y9AQEJuf5wIl7nsnFBuA1qFZasOvAZHcHupxUY/l+zF0hQ8yoJc9vcSEa0U+oK9
 5k/4i/mI9tc1P6RpnDaU/QZ44=
X-Received: by 2002:a17:90b:97:b0:2b4:35a9:65fb with SMTP id
 bb23-20020a17090b009700b002b435a965fbmr7210669pjb.10.1714965688037; 
 Sun, 05 May 2024 20:21:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYGKitSj8dHphpo5mTDFur5SvguMhzxe8rBByJamflVQljpiTwPR7iyVay2Flzf3xzdZIO+mHSfR7mRecLCn4=
X-Received: by 2002:a17:90b:97:b0:2b4:35a9:65fb with SMTP id
 bb23-20020a17090b009700b002b435a965fbmr7210656pjb.10.1714965687436; Sun, 05
 May 2024 20:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240430052845.31039-1-liwang@redhat.com>
 <20240430052845.31039-2-liwang@redhat.com> <ZjNrApqMiZ9bj0au@yuki>
In-Reply-To: <ZjNrApqMiZ9bj0au@yuki>
From: Li Wang <liwang@redhat.com>
Date: Mon, 6 May 2024 11:21:15 +0800
Message-ID: <CAEemH2eeawxg0OihAO5WCaR9f6BH_MwfSrMRuPMV2Jssrm4Xbg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 2/2] kallsyms01: Utilize ksymbol table for
 unauthorized address access
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
Cc: Rafael Aquini <aquini@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQ3lyaWwsCgpBbGwgY29tbWVudHMgbWFrZSBzZW5zZSwgcGF0Y2ggdjMgaXMgY29taW5nLgoK
T24gVGh1LCBNYXkgMiwgMjAyNCBhdCA2OjMw4oCvUE0gQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1
c2UuY3o+IHdyb3RlOgoKPiBIaSEKPiA+IEBAIC0wLDAgKzEsMTQxIEBACj4gPiArLy8gU1BEWC1M
aWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQo+Cj4gQW55IHJlYXNvbiB0aGlzIGlzIEdQ
TC0yLjAtb25seSBhbmQgbm90IDIuMC1vci1sYXRlcj8KPgo+ID4gKy8qCj4gPiArICogQ29weXJp
Z2h0IChDKSAyMDI0IFJlZCBIYXQsIEluYy4KPiA+ICsgKi8KPiA+ICsKPiA+ICsvKlwKPiA+ICsg
KiBbRGVzY3JpcHRpb25dCj4gPiArICoKPiA+ICsgKiAgVXRpbGl6ZSBrZXJuZWwncyBzeW1ib2wg
dGFibGUgZm9yIHVuYXV0aG9yaXplZCBhZGRyZXNzIGFjY2Vzcy4KPiA+ICsgKgo+ID4gKyAqICBB
Y2Nlc3MgdGhlIHN5c3RlbSBzeW1ib2xzIHdpdGggcm9vdCBwZXJtaXNzaW9uIHRvIHRlc3Qgd2hl
dGhlciBpdCdzCj4gPiArICogIHBvc3NpYmxlIHRvIHJlYWQgYW5kIHdyaXRlIHRoZSBtZW1vcnkg
YWRkcmVzc2VzIG9mIGtlcm5lbC1zcGFjZQo+ID4gKyAqICBmcm9tIHVzZXItc3BhY2UuIFRoaXMg
aGVscHMgaW4gaWRlbnRpZnlpbmcgcG90ZW50aWFsIHZ1bG5lcmFiaWxpdGllcwo+ID4gKyAqICB3
aGVyZSB1c2VyLXNwYWNlIHByb2Nlc3NlcyBjYW4gaW5hcHByb3ByaWF0ZWx5IGFjY2VzcyBrZXJu
ZWwgbWVtb3J5Lgo+ID4gKyAqCj4gPiArICogU3RlcHM6Cj4gPiArICogIDEuIFN0YXJ0IGEgcHJv
Y2VzcyB0aGF0IHJlYWRzIGFsbCBzeW1ib2xzIGFuZCB0aGVpciBhZGRyZXNzZXMgZnJvbQo+ID4g
KyAqICAgICAnL3Byb2Mva2FsbHN5bXMnIGFuZCBzdG9yZXMgdGhlbSBpbiBhIGxpbmtlZCBsaXN0
Lgo+ID4gKyAqCj4gPiArICogIDIuIEF0dGVtcHQgdG8gd3JpdGUgdG8gZWFjaCBrZXJuZWwgYWRk
cmVzcyBmb3VuZCBpbiB0aGUgbGlua2VkIGxpc3QuCj4gPiArICogICAgIFRoZSBleHBlY3RhdGlv
biBpcyB0aGF0IGVhY2ggYXR0ZW1wdCB3aWxsIGZhaWwgd2l0aCBhIFNJR1NFR1YKPiA+ICsgKiAg
ICAgKHNlZ21lbnRhdGlvbiBmYXVsdCksIGluZGljYXRpbmcgdGhhdCB0aGUgdXNlci1zcGFjZSBw
cm9jZXNzCj4gPiArICogICAgIGNhbm5vdCB3cml0ZSB0byBrZXJuZWwgbWVtb3J5Lgo+ID4gKyAq
Cj4gPiArICogIDMuIEhhbmRsZSBlYWNoIFNJR1NFR1YgdXNpbmcgYSBzaWduYWwgaGFuZGxlciB0
aGF0IHNldHMgYSBmbGFnIGFuZAo+ID4gKyAqICAgICBsb25nIGp1bXBzIG91dCBvZiB0aGUgZmF1
bHRpbmcgY29udGV4dC4KPiA+ICsgKgo+ID4gKyAqICA0LiBJZiBhbnkgd3JpdGUgb3BlcmF0aW9u
IGRvZXMgbm90IHJlc3VsdCBpbiBhIFNJR1NFR1YsIGxvZyB0aGlzIGFzCj4gPiArICogICAgIGEg
cG90ZW50aWFsIHNlY3VyaXR5IHZ1bG5lcmFiaWxpdHkuCj4gPiArICoKPiA+ICsgKiAgNS4gT2Jz
ZXJ2ZSBhbmQgbG9nIHRoZSBiZWhhdmlvciBhbmQgYW55IHN5c3RlbSByZXNwb25zZXMgdG8gdGhl
c2UKPiA+ICsgKiAgICAgdW5hdXRob3JpemVkIGFjY2VzcyBhdHRlbXB0cy4KPiA+ICsgKgo+ID4g
KyAqLwo+ID4gKwo+ID4gKyNpbmNsdWRlIDxzdGRpby5oPgo+ID4gKyNpbmNsdWRlIDxzdGRsaWIu
aD4KPiA+ICsjaW5jbHVkZSA8YXNzZXJ0Lmg+Cj4gPiArI2luY2x1ZGUgPHVuaXN0ZC5oPgo+ID4g
KyNpbmNsdWRlIDxzdHJpbmcuaD4KPiA+ICsjaW5jbHVkZSA8c2V0am1wLmg+Cj4gPiArI2luY2x1
ZGUgPHNpZ25hbC5oPgo+ID4gKwo+ID4gKyNpbmNsdWRlICJ0c3RfdGVzdC5oIgo+ID4gKyNpbmNs
dWRlICJ0c3Rfc2FmZV9zdGRpby5oIgo+ID4gKwo+ID4gK3N0cnVjdCBrYWxsc3ltIHsKPiA+ICsg
ICAgIHVuc2lnbmVkIGxvbmcgYWRkcjsKPiA+ICsgICAgIGNoYXIgdHlwZTsKPiA+ICsgICAgIGNo
YXIgbmFtZVsxMjhdOwo+ID4gK307Cj4gPiArCj4gPiArc3RhdGljIHN0cnVjdCBrYWxsc3ltICpz
eW1fdGFibGU7Cj4gPiArc3RhdGljIHVuc2lnbmVkIGludCBucl9zeW1ib2xzOwo+ID4gK3N0YXRp
YyBzaWdqbXBfYnVmIGptcGJ1ZjsKPiA+ICt2b2xhdGlsZSBzaWdfYXRvbWljX3Qgc2Vndl9jYXVn
aHQgPSAwOwo+ID4gKwo+ID4gK3N0YXRpYyB2b2lkIHNlZ3ZfaGFuZGxlcihpbnQgc2lnKQo+ID4g
K3sKPiA+ICsgICAgIGlmIChzaWcgPT0gU0lHU0VHVikKPiA+ICsgICAgICAgICAgICAgc2Vndl9j
YXVnaHQrKzsKPiA+ICsgICAgIGVsc2UKPiA+ICsgICAgICAgICAgICAgdHN0X3JlcyhURkFJTCwg
IlVuZXhwZWN0ZWQgc2lnbmFsICVzIiwgc3Ryc2lnbmFsKHNpZykpOwo+ID4gKwo+ID4gKyAgICAg
c2lnbG9uZ2ptcChqbXBidWYsIDEpOwo+ID4gK30KPiA+ICsKPiA+ICtzdGF0aWMgdW5zaWduZWQg
aW50IHJlYWRfa2FsbHN5bXMoc3RydWN0IGthbGxzeW0gKnRhYmxlLCB1bnNpZ25lZCBpbnQKPiB0
YWJsZV9zaXplKQo+ID4gK3sKPiA+ICsgICAgIGNoYXIgKmxpbmUgPSBOVUxMOwo+ID4gKyAgICAg
c2l6ZV90IGxlbiA9IDA7Cj4gPiArICAgICB1bnNpZ25lZCBpbnQgbnJfc3ltcyA9IDA7Cj4gPiAr
ICAgICBGSUxFICpzdHJlYW0gPSBTQUZFX0ZPUEVOKCIvcHJvYy9rYWxsc3ltcyIsICJyIik7Cj4g
PiArCj4gPiArICAgICB3aGlsZSAoZ2V0bGluZSgmbGluZSwgJmxlbiwgc3RyZWFtKSAhPSAtMSkg
ewo+ID4gKwo+ID4gKyAgICAgICAgICAgICBpZiAodGFibGUgJiYgbnJfc3ltcyA8IHRhYmxlX3Np
emUpIHsKPiA+ICsgICAgICAgICAgICAgICAgICAgICBzc2NhbmYobGluZSwgIiVseCAlYyAlcyIs
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZ0YWJsZVtucl9zeW1z
XS5hZGRyLAo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmdGFibGVb
bnJfc3ltc10udHlwZSwKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
dGFibGVbbnJfc3ltc10ubmFtZSk7Cj4gPiArICAgICAgICAgICAgIH0KPiA+ICsKPiA+ICsgICAg
ICAgICAgICAgbnJfc3ltcysrOwo+ID4gKyAgICAgfQo+ID4gKwo+ID4gKyAgICAgU0FGRV9GQ0xP
U0Uoc3RyZWFtKTsKPiA+ICsKPiA+ICsgICAgIHJldHVybiBucl9zeW1zOwo+ID4gK30KPiA+ICsK
PiA+ICtzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQo+ID4gK3sKPiA+ICsgICAgIG5yX3N5bWJvbHMg
PSByZWFkX2thbGxzeW1zKE5VTEwsIDApOwo+ID4gKyAgICAgc3ltX3RhYmxlID0gU0FGRV9DQUxM
T0MobnJfc3ltYm9scywgc2l6ZW9mKCpzeW1fdGFibGUpKTsKPiA+ICsgICAgIHVuc2lnbmVkIGlu
dCByZWFkX3N5bWJvbHMgPSByZWFkX2thbGxzeW1zKHN5bV90YWJsZSwgbnJfc3ltYm9scyk7Cj4g
PiArCj4gPiArICAgICBpZiAobnJfc3ltYm9scyAhPSByZWFkX3N5bWJvbHMpCj4gPiArICAgICAg
ICAgICAgIHRzdF9yZXMoVFdBUk4sICIvcHJvYy9rYWxsc3ltcyBjaGFuZ2VkIHNpemUhPyIpOwo+
ID4gK30KPiA+ICsKPiA+ICtzdGF0aWMgdm9pZCBhY2Nlc3Nfa3N5bWJvbHNfYWRkcmVzcyhzdHJ1
Y3Qga2FsbHN5bSAqdGFibGUpCj4gPiArewo+ID4gKyAgICAgdHN0X3JlcyhUREVCVUcsICJBY2Nl
c3Mga2VybmVsIGFkZHI6IDB4JWx4ICglYykgKCVzKSIsCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB0YWJsZS0+YWRkciwgdGFibGUtPnR5cGUsIHRhYmxlLT5uYW1lKTsKPiA+ICsK
PiA+ICsgICAgIGlmIChzaWdzZXRqbXAoam1wYnVmLCAxKSA9PSAwKSB7Cj4gPiArICAgICAgICAg
ICAgICoodm9sYXRpbGUgdW5zaWduZWQgbG9uZyAqKXRhYmxlLT5hZGRyID0gMDsKPiA+ICsKPiA+
ICsgICAgICAgICAgICAgdHN0X3JlcyhURkFJTCwgIlN1Y2Nlc3NmdWxseSBhY2Nlc3NlZCBrZXJu
ZWwgYWRkciAweCVseAo+ICglYykgKCVzKSIsCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB0YWJsZS0+YWRkciwgdGFibGUtPnR5cGUsIHRhYmxlLT5uYW1lKTsKPiA+ICsgICAgIH0K
PiA+ICt9Cj4gPiArCj4gPiArc3RhdGljIHZvaWQgdGVzdF9hY2Nlc3Nfa2VybmVsX2FkZHJlc3Mo
dm9pZCkKPiA+ICt7Cj4gPiArICAgICBzdHJ1Y3Qgc2lnYWN0aW9uIHNhOwo+ID4gKyAgICAgbWVt
c2V0KCZzYSwgMCwgc2l6ZW9mKHNhKSk7Cj4gPiArICAgICBzYS5zYV9oYW5kbGVyID0gc2Vndl9o
YW5kbGVyOwo+ID4gKyAgICAgc2lnYWN0aW9uKFNJR1NFR1YsICZzYSwgTlVMTCk7Cj4KPiBXZSBj
YW4gbW92ZSB0aGUgc2lnYWN0aW9uIHRvIHRoZSB0ZXN0IHNldHVwLgo+Cj4gPiArICAgICBmb3Ig
KHVuc2lnbmVkIGludCBpID0gMDsgaSA8IG5yX3N5bWJvbHM7IGkrKykKPiA+ICsgICAgICAgICAg
ICAgYWNjZXNzX2tzeW1ib2xzX2FkZHJlc3MoJnN5bV90YWJsZVtpXSk7Cj4KPiBBbmQgd2UgaGF2
ZSB0byBzZXQgdGhlIHNlZ3ZfY2F1Z2h0IHRvIDAgYmVmb3JlIHRoaXMgbG9vcCwgb3RoZXJ3aXNl
IHRoZQo+IHRlc3QgZG9lcyBub3Qgd29yayB3aXRoIC1pIDIKPgo+ID4gKyAgICAgaWYgKHNlZ3Zf
Y2F1Z2h0ID09IChzaWdfYXRvbWljX3QpbnJfc3ltYm9scykKPiA+ICsgICAgICAgICAgICAgdHN0
X3JlcyhUUEFTUywgIkNhdWdodCAlZCB0aW1lcyBTSUdTRUdWIGluIGFjY2VzcyBrc3ltYm9scwo+
IGFkZHIiLCBzZWd2X2NhdWdodCk7Cj4KPiBBbmQgYWxzbyBpbiBhIGNhc2UgdGhhdCB3ZSBnb3Qg
d3JvbmcgbnVtYmVyIG9uIHNlZ2ZhdWx0cyB0aGlzIGRvZXMgbm90Cj4gcHJvZHVjZSBhbnkgcmVz
dWx0cy4gSSBndWVzcyB0aGF0IHdlIG5lZWQgdG8gZG86Cj4KPiAgICAgICAgIGlmICguLi4pCj4g
ICAgICAgICAgICAgICAgIHRzdF9yZXMoVFBBU1MsICIuLi4iKTsKPiAgICAgICAgIGVsc2UKPiAg
ICAgICAgICAgICAgICAgdHN0X3JlcyhURkFJTCwgIkNhdWdodCAlZCBTSUdTRUdWIGV4cGVjdGVk
ICVkIiwgLi4uKTsKPgo+Cj4gPiArfQo+ID4gKwo+ID4gK3N0YXRpYyB2b2lkIGNsZWFudXAodm9p
ZCkKPiA+ICt7Cj4gPiArICAgICBpZiAoc3ltX3RhYmxlKQo+ID4gKyAgICAgICAgICAgICBmcmVl
KHN5bV90YWJsZSk7Cj4gPiArfQo+ID4gKwo+ID4gK3N0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVz
dCA9IHsKPiA+ICsgICAgIC5uZWVkc19yb290ID0gMSwKPiA+ICsgICAgIC5zZXR1cCA9IHNldHVw
LAo+ID4gKyAgICAgLmNsZWFudXAgPSBjbGVhbnVwLAo+ID4gKyAgICAgLm1heF9ydW50aW1lID0g
NjAsCj4gPiArICAgICAudGVzdF9hbGwgPSB0ZXN0X2FjY2Vzc19rZXJuZWxfYWRkcmVzcywKPiA+
ICt9Owo+ID4gLS0KPiA+IDIuNDAuMQo+ID4KPiA+Cj4gPiAtLQo+ID4gTWFpbGluZyBsaXN0IGlu
Zm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCj4KPiAtLQo+IEN5cmlsIEhy
dWJpcwo+IGNocnViaXNAc3VzZS5jego+Cj4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFp
bGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
