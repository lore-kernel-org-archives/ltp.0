Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E6FC3DA45
	for <ltp@archiver.kernel.org>; Fri, 12 Jul 2024 03:04:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B60F63D15F3
	for <ltp@archiver.kernel.org>; Fri, 12 Jul 2024 05:04:19 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9B9F03D12C9
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 05:04:03 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C5A481A007FE
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 05:04:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720753440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=arfLGXpg8qI1sXKd8tugXB6/7se48/stsLV71y5A5JQ=;
 b=aTBZpBstniwA0lJBYdtKpb1fUG/zSCngjP24daKGmuCIVPMoo2QpkhVJBTfj2/ePLJrh/+
 T6cI/dg5KQSd4nqH6Guzf2i1P0gK0ym1MtG6aZLjVzeKt1I4RGLZlWzmFpZlhWVkG0Luza
 PW9iDe6KkLTSM70hbnF6V2M9BA5YnOs=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-JTaDu7WDOYuwWtCmEnzTZQ-1; Thu, 11 Jul 2024 23:03:58 -0400
X-MC-Unique: JTaDu7WDOYuwWtCmEnzTZQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2c972018f0fso1525774a91.2
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 20:03:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720753437; x=1721358237;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=arfLGXpg8qI1sXKd8tugXB6/7se48/stsLV71y5A5JQ=;
 b=ftYQOeENA2AaetKJ16cv6GexKj5lsdZkLi0f7Aj6IH4PCOfAMpkLMXYUPCPiZU+Vx5
 8CcZBbA6/+4i4v0QdsHoP37fCyyv6gv4gX8eG9xLe/CLpvwY72di3sPFvIfBs9MMl9WJ
 rK2g19l/RegW9VykED/+YQnEapPHNfKgRg/JvPH3FeXD7VYB86ahv3dqGUpNtPrt9OeA
 Sf6xbF/EC5rKCADKXNhnGAuEkBCY9d8ramPsU989DAkfEBTXGGSWkYH/DlITbxD8aACb
 1POVDd/MdA8Yx/YPd0jO8yfuLoy3s8sDoWqQPMM5Uu1oJ9j5b5Qn3mafRTbOQMPRCldb
 AGDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWziFpO8yRz6P/Mu2X/90ASRjuLfmODl20HHPWwPF46Z5LlGJdYV7Biuf9+Id8qZN1hT7BWDn9J5oeG7yvtLERGP9M=
X-Gm-Message-State: AOJu0YxTl94qdZNAGGh0Nf3ZJdpo1Vz1womQ9L0yCHZRxdWT0xkzCsJs
 YFsv4J5z9Q8LH1OYMS8bdcUr//ZL7jqmEqDKunZXpmXCDZXplaHR3sdq12LWctstAIczyNTO3Ez
 zZs5Ttdtm88LWc9Lmx+uT3wPl01dhurlR/yhkBV6LNaZ89DrRFNUpWAMARgL6b8LmaTDC6p5ZlU
 aj0sphkjSvcvsduRG5AQte2xo=
X-Received: by 2002:a17:90b:502:b0:2c9:6ecf:89b8 with SMTP id
 98e67ed59e1d1-2ca35d3b03dmr8189530a91.38.1720753437355; 
 Thu, 11 Jul 2024 20:03:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZIrGLzDp6dQv41SYV1XZjwl4tX3LkciUvElJKp+3/pJMlNx7/06YO0sUCizXELHsLaReJx+uMc1SdM6gBF3A=
X-Received: by 2002:a17:90b:502:b0:2c9:6ecf:89b8 with SMTP id
 98e67ed59e1d1-2ca35d3b03dmr8189516a91.38.1720753436813; Thu, 11 Jul 2024
 20:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240711-landlock-v3-0-c7b0e9edf9b0@suse.com>
 <20240711-landlock-v3-5-c7b0e9edf9b0@suse.com>
 <20240711204007.GC85696@pevik>
 <CAEemH2fdFsQqN3a8sZ7+oeU7w3j+X7HdnGa=zC4H4+iXO9YUAw@mail.gmail.com>
In-Reply-To: <CAEemH2fdFsQqN3a8sZ7+oeU7w3j+X7HdnGa=zC4H4+iXO9YUAw@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 12 Jul 2024 11:03:44 +0800
Message-ID: <CAEemH2eYZ05Fn0ZYhpG16UUzYo=F3GKBpYeRG_X2BUdrLbY8PA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3 05/11] Add landlock01 test
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

T24gRnJpLCBKdWwgMTIsIDIwMjQgYXQgMTA6MTHigK9BTSBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0
LmNvbT4gd3JvdGU6Cgo+IEhpIFBldHIsCj4KPiBPbiBGcmksIEp1bCAxMiwgMjAyNCBhdCA0OjQw
4oCvQU0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgo+Cj4+IEhpIEFuZHJlYSwK
Pj4KPj4gYWdhaW4sIExHVE0sIDIgdGhpbmdzOgo+Pgo+PiBGaXJzdCwgdGhpcyBmYWlscyBhdCBs
ZWFzdCBvbiB2YXJpb3VzIGtlcm5lbCB2ZXJzaW9ucyAodGVzdGVkOiBUdW1ibGV3ZWVkCj4+IDYu
MTAuMC1yYzctMy5nOTJhYmMxMC1kZWZhdWx0LCBhbmQgU0xFMTUtU1A0IDUuMTQuMjEgd2l0aCBs
c209bGFuZGxvY2sgYW5kCj4+IERlYmlhbiA2LjYuMTUtYW1kNjQpOgo+Pgo+PiBsYW5kbG9jazAx
LmM6NDk6IFRGQUlMOiBTaXplIGlzIHRvbyBzbWFsbCBleHBlY3RlZCBFSU5WQUw6IEVOT01TRyAo
NDIpCj4+Cj4+IElzIGl0IGEga2VybmVsIGJ1ZyBvciBhIHRlc3QgYnVnPwo+Pgo+Cj4gWW91IHBy
b2JhYmx5IG5lZWQgdG8gY2hlY2sgdGhlIGAvdXNyL2luY2x1ZGUvbGludXgvbGFuZGxvY2suaGAg
aGVhZGVyIGZpbGUKPiBleGlzdCwKPiBhbmQgdG8gc2VlIGlmICdzdHJ1Y3QgbGFuZGxvY2tfcnVs
ZXNldF9hdHRyJyBjb250YWlucyB0aGUgbmV3IGZpZWxkCj4gJ2hhbmRsZWRfYWNjZXNzX25ldCcu
Cj4KPiBJZiBub3QgZXhpc3Qgb3IgZG9lcyBub3QgY29udGFpbiB0aGF0LCB0aGUgdGVzdCBkZWZp
bmVzICdzdHJ1Y3QKPiBsYW5kbG9ja19ydWxlc2V0X2F0dHInCj4gaW4gbGFwaS9sYW5kbG9jay5o
IHdoaWNoIGNvbnRhaW5zIGhhbmRsZWRfYWNjZXNzX25ldCBkaXJlY3RseSwgdGhpcyBpcwo+IGxp
a2VseSB0aGUKPiByb290IGNhdXNlIGxlYWQgdGVzdCBmYWlsZWQgb24geW91ciBib3guCj4KCgpB
bmQsIGlmIHRoZSBoZWFkZXIgZmlsZSBkb2VzIG5vdCBleGlzdCwgdGhlIG1hY3JvIGNvbmRpdGlv
biB3aWxsIGNob29zZSB0bwp1c2UgJ3J1bGVfc2l6ZSAtIDEnLAphbmQgdGhhdCBjYXVzZWQgdGhl
IEVOT01TRyBlcnJvciBkdXJpbmcgdGVzdCBvbiB0aGUgbmV3ZXIga2VybmVsLgoKI2lmZGVmIEhB
VkVfU1RSVUNUX0xBTkRMT0NLX1JVTEVTRVRfQVRUUl9IQU5ETEVEX0FDQ0VTU19ORVQKICAgIHJ1
bGVfc21hbGxfc2l6ZSA9IHJ1bGVfc2l6ZSAtIHNpemVvZih1aW50NjRfdCkgLSAxOwojZWxzZQog
ICAgcnVsZV9zbWFsbF9zaXplID0gcnVsZV9zaXplIC0gMTsKI2VuZGlmCgpTbyB0byBrZWVwIHRo
ZSBrZXJuZWwtaGVhZGVycyBhbmQgcnVubmluZyBrZXJuZWwgdmVyc2lvbiBjb25zaXN0ZW50IHNo
b3VsZApiZSByZXF1aXJlZApmb3IgdGhlIGxhbmRsb2NrMDEgdGVzdC4gT3RoZXJ3aXNlIHRoZSAj
aWZkZWYgcG9zc2libHkgd29uJ3Qgd29yayBjb3JyZWN0bHkuCgpJIGd1ZXNzIHdlIG1pZ2h0IGhh
dmUgdG8gcmVzb2x2ZSB0aGlzIG9uIHRoZSB0ZXN0IHNpZGUuCgoKCgo+Cj4KPgo+Pgo+PiBJJ20g
bm90IHN1cmUgaWYgTGkncyBjb25jZXJuIFsxXSB3YXMgZnVsbHkgYWRkcmVzc2VkOgo+Pgo+PiAg
ICAgICAgIFdlIHN0aWxsIGhhdmUgdG8gYWRqdXN0IHRoZSBjYXNlIGlmIHNvbWVvbmUgaW50cm9k
dWNlcyBvbmUgbW9yZQo+PiBuZXcgZmllbGQKPj4gICAgICAgICBzaW1pbGFyIHRvICdoYW5kbGVk
X2FjY2Vzc19uZXQnIHRvIHRoZSBzdHJ1Y3R1cmUgaW4gdGhlIGZ1dHVyZS4KPj4KPj4gS2luZCBy
ZWdhcmRzLAo+PiBQZXRyCj4+Cj4+IFsxXQo+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sdHAv
Q0FFZW1IMmRrS3Z0aGJ4K3phLXJ3ZnNtYW5yYVp1dWQtc3ExTzRGWksyenRhNU1CTVNnQG1haWwu
Z21haWwuY29tLwo+Pgo+Pgo+Cj4gLS0KPiBSZWdhcmRzLAo+IExpIFdhbmcKPgoKCi0tIApSZWdh
cmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
