Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 175EBC02196
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 06:34:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4EA8D3C2CC1
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 07:34:47 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7CFDF3C0387
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 07:34:29 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 37CF3226C74
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 07:34:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738823667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jN4S47KvYPfX2j5GZgnINGt1n8fDTN8XtOmW6ExsUQQ=;
 b=DG4XsY0T3SsiKuCdtiLMUjOI9Y9IyFqumeVdp+0OFr4ALJu4qzf/to3bLBOueQzJvsAPaB
 0OcYTCOvwk2m2hJtOl7O0Hcbu8A53vXjnaveNi9JJ0QrfFv8BHCgqRtVAMU5Xc9j9QXfvC
 Qz/c0Xa8ojUjxwpKJaq/URehEtDK/l0=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-21YMWNExPv-sCwhXYiPzGQ-1; Thu, 06 Feb 2025 01:34:25 -0500
X-MC-Unique: 21YMWNExPv-sCwhXYiPzGQ-1
X-Mimecast-MFC-AGG-ID: 21YMWNExPv-sCwhXYiPzGQ
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3f3412843dbso613930b6e.0
 for <ltp@lists.linux.it>; Wed, 05 Feb 2025 22:34:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738823665; x=1739428465;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jN4S47KvYPfX2j5GZgnINGt1n8fDTN8XtOmW6ExsUQQ=;
 b=gU+p8NAnmbb/IQpNfMucXpSSUrHVikfzOX0nG4pvC9umZU7t4nulGGNEbWmgizaYzv
 lsgv6rvZnKXnRxDTHbLnR8PpTt3YqExtLvI1J7qVuSc6pCXpgymj1RBmjv2z0gioqjFY
 Mm0sX2YtLmyG7rEFfthHfe7E1oKKxccDel4dCScCQHIZPHFy94JcxSX5D1yAYqoY1dVA
 gRDSvS1lH3FwxU069LnxzOoFwVoaUB53FR9rw8i024pIPNzOZeKcFqvILZcHhNpz9FCK
 7f8YTdHc8nn/EjjXG7sVzn9LGtKY0dcvyb7qdzAiaOHc2vRx1I1i2YWT3pW/rYGZRjA0
 aclA==
X-Gm-Message-State: AOJu0Yy0LdPklmAuzgifSLLcW1cmAhSIATxveOnItD1+gbxH2bpf7QQH
 Jztp+5sNItCfQXXddktPSxn0NYf02GNwFSQTlovnNUKqm2C5aClvqVOJ6ystiER3ztqmKdcCpG+
 UDK8d4WQAgg+gLl6P9xntsqMOANF6dHw20UkT+/b2tzV1IpcfccQRBvP95uoaNc8PXJjM9ELCkJ
 B+MmSVlU6e1wBHTmN0xcR7HGQ=
X-Gm-Gg: ASbGnctqofT9TDKIY3VFSiJGThRGpA6WZfgUt3XRD3OVp1pSYeQIbATolbicwCIUsWA
 Gsh0r0ioJb9y35WMox3U3Xmn861NfrC4hJpftUtPzJTAqn5V2g4kK+SbnVLXlIw==
X-Received: by 2002:a05:6808:4408:b0:3eb:63c9:fe87 with SMTP id
 5614622812f47-3f37c121d58mr2972560b6e.16.1738823664797; 
 Wed, 05 Feb 2025 22:34:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFh1oiNGznQrLjI2MgY7aTWJMXGN7/iU2ZoprIkK+N04WB1+9NL8t/ueDF/YFpgzL+AMQIkbNTOKuXi6m3PEck=
X-Received: by 2002:a05:6808:4408:b0:3eb:63c9:fe87 with SMTP id
 5614622812f47-3f37c121d58mr2972552b6e.16.1738823664428; Wed, 05 Feb 2025
 22:34:24 -0800 (PST)
MIME-Version: 1.0
References: <1b9d04fe8d4f0f386398216b9a5c172bb010c97f.1737029809.git.jstancek@redhat.com>
 <Z4kqqIQlgj4QF21X@yuki.lan>
In-Reply-To: <Z4kqqIQlgj4QF21X@yuki.lan>
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 6 Feb 2025 07:34:08 +0100
X-Gm-Features: AWEUYZnjTYBJKAUqQ0V3frYsEDJmvH8V-OWtKPBLO08TuRuIhK4U5Snpm_g_L0A
Message-ID: <CAASaF6zzT1GzdR7O8oC=JQso57VLO47jyXkBdbDZv1WKpW9uvA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XhH-G4XGR3CMZN9uMuNSeB1FE57U4czdFKuxTGvkgoE_1738823665
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] aio-stress: fix opened fd leak
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
Cc: liwan@redhat.com, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBKYW4gMTYsIDIwMjUgYXQgNDo1MOKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKPgo+IEhpIQo+ID4gSW4gY2FzZXMgd2hlcmUgd29ya2VyIGNvbXBsZXRl
cyBzcGVjaWZpZWQgbnVtYmVyIG9mIGBpdGVyYXRpb25zYCBiZWZvcmUKPiA+IG9wZXIgY29tcGxl
dGVzIGFsbCBgdG90YWxfaW9zYCwgc3VjaCBvcGVyIHJlbWFpbnMgb24gYWN0aXZlX2xpc3QuCj4g
PiBUaGlzIGlzIGEgcHJvYmxlbSBiZWNhdXNlIGNsZWFudXAgb25seSB3YWxrcyBvdmVyIGZpbmlz
aGVkIGxpc3QsCj4gPiBhbmQgY2xvc2VzIGZkcyBvbmx5IGZvciBpdGVtcyBvbiB0aGlzIGxpc3Qu
IFNvIGl0J3MgcG9zc2libGUgZm9yCj4gPiB0ZXN0IHRvIGV4aGF1c3QgdWxpbWl0IGZvciBvcGVu
IGZpbGVzIGFuZCBmYWlsOgo+ID4KPiA+ICQgLi9haW8tc3RyZXNzIC1hMSAtSTEwMCAtbzIgLXI0
IC1mMSAtZDFeCj4gPiBhaW8tc3RyZXNzLmM6MTM0NzogVFBBU1M6IFRlc3QgcGFzc2VkCj4gPiBh
aW8tc3RyZXNzLmM6MTI4NTogVElORk86IHN0YXJ0aW5nIHdpdGggcmFuZG9tIHdyaXRlCj4gPiBh
aW8tc3RyZXNzLmM6MTI5NjogVElORk86IGZpbGUgc2l6ZSAxMDI0TUIsIHJlY29yZCBzaXplIDBL
QiwgZGVwdGggMSwgSS9PIHBlciBpdGVyYXRpb24gMQo+ID4gYWlvLXN0cmVzcy5jOjEyOTg6IFRJ
TkZPOiBtYXggaW9fc3VibWl0IDEsIGJ1ZmZlciBhbGlnbm1lbnQgc2V0IHRvIDRLQgo+ID4gYWlv
LXN0cmVzcy5jOjEzMDA6IFRJTkZPOiB0aHJlYWRzIDEgZmlsZXMgMSBjb250ZXh0cyAxIGNvbnRl
eHQgb2Zmc2V0IDJNQiB2ZXJpZmljYXRpb24gb2ZmCj4gPiBhaW8tc3RyZXNzLmM6MTMxNDogVEJS
T0s6IG9wZW4oZmlsZTAuYmluLDEwNTI3MzgsMDYwMCkgZmFpbGVkOiBFTUZJTEUgKDI0KQo+Cj4g
TG9va3MgbGlrZSB0aGUgdGVzdCBoYXMgbWFueSBvcHRpb25zIGFuZCBzb21lIGNvbWJpbmF0aW9u
cyBtYXkgc2V0Cj4gdGhpbmdzIGluIGEgd2F5IHRoYXQgZG9lcyBub3QgbWFrZSBtdWNoIHNlbnNl
Lgo+Cj4gPiBDbGVhbi9mcmVlIGFsc28gaXRlbXMgZnJvbSBhY3RpdmVfbGlzdC4gQWxzbyBkb24n
dCBsZXQgYHN0YXR1c2AgZnJvbSBjbGVhbnVwCj4gPiBiZSBzZXQgdG8gemVybyBvbmNlIGl0IGJl
Y29tZXMgbm9uLXplcm8uCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogSmFuIFN0YW5jZWsgPGpzdGFu
Y2VrQHJlZGhhdC5jb20+Cj4gPiAtLS0KPiA+ICB0ZXN0Y2FzZXMva2VybmVsL2lvL2x0cC1haW9k
aW8vYWlvLXN0cmVzcy5jIHwgNyArKysrKystCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2Vy
bmVsL2lvL2x0cC1haW9kaW8vYWlvLXN0cmVzcy5jIGIvdGVzdGNhc2VzL2tlcm5lbC9pby9sdHAt
YWlvZGlvL2Fpby1zdHJlc3MuYwo+ID4gaW5kZXggNDE5ZmMyY2QyNWE0Li5lODQzMDhkMWQwZTgg
MTAwNjQ0Cj4gPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL2lvL2x0cC1haW9kaW8vYWlvLXN0cmVz
cy5jCj4gPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL2lvL2x0cC1haW9kaW8vYWlvLXN0cmVzcy5j
Cj4gPiBAQCAtMTEyMiw3ICsxMTIyLDEyIEBAIHJlc3RhcnQ6Cj4gPiAgICAgICB3aGlsZSAodC0+
ZmluaXNoZWRfb3BlcnMpIHsKPiA+ICAgICAgICAgICAgICAgb3BlciA9IHQtPmZpbmlzaGVkX29w
ZXJzOwo+ID4gICAgICAgICAgICAgICBvcGVyX2xpc3RfZGVsKG9wZXIsICZ0LT5maW5pc2hlZF9v
cGVycyk7Cj4gPiAtICAgICAgICAgICAgIHN0YXR1cyA9IGZpbmlzaF9vcGVyKHQsIG9wZXIpOwo+
ID4gKyAgICAgICAgICAgICBzdGF0dXMgPSBmaW5pc2hfb3Blcih0LCBvcGVyKSA/IDogc3RhdHVz
Owo+ID4gKyAgICAgfQo+ID4gKyAgICAgd2hpbGUgKHQtPmFjdGl2ZV9vcGVycykgewo+ID4gKyAg
ICAgICAgICAgICBvcGVyID0gdC0+YWN0aXZlX29wZXJzOwo+ID4gKyAgICAgICAgICAgICBvcGVy
X2xpc3RfZGVsKG9wZXIsICZ0LT5hY3RpdmVfb3BlcnMpOwo+ID4gKyAgICAgICAgICAgICBzdGF0
dXMgPSBmaW5pc2hfb3Blcih0LCBvcGVyKSA/IDogc3RhdHVzOwo+ID4gICAgICAgfQo+Cj4KPiBJ
IGd1ZXNzIHRoYXQgdGhpcyB3b3JrcyBhcyBhIG1pbmltYWwgZml4Lgo+Cj4gUmV2aWV3ZWQtYnk6
IEN5cmlsIEhydWJpcyA8Y2hydWJpc0BzdXNlLmN6PgoKUHVzaGVkLgoKCi0tIApNYWlsaW5nIGxp
c3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
