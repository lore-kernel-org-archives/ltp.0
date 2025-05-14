Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B5D1C3ABDA
	for <ltp@archiver.kernel.org>; Wed, 14 May 2025 09:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747213858; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=nT+0xu9zSWhGWtR80m/z2d+4UiY/juT/kZLVwdjjtkI=;
 b=YV0FyFZAhdG6tzZfc5/G/F79crEknZey0MCoRNoDgUNun0Ay0NtzBAT+H0h9ULAeY7bEy
 bRQoLPue40gEtYMyVreRzzmVr60KgrxrS0H3Dd+HrpcvNtwX5DvNkYRxKnviZ/nua6oEWXj
 LGaGlH2RJBtRhIJjqq3E7fW30mJ8FZY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E75B53CC392
	for <ltp@archiver.kernel.org>; Wed, 14 May 2025 11:10:58 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E3FA13C93B8
 for <ltp@lists.linux.it>; Wed, 14 May 2025 11:10:36 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C4F2F600B78
 for <ltp@lists.linux.it>; Wed, 14 May 2025 11:10:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747213833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=55NymfM0nO0qNBhr6CgoketK2XBs31LrXXtiCS62SgI=;
 b=dZOPwevbeqp0TgthJCXRzbKrYktg1FyG3vX9dscE3pT+Ytf51BWZXJd3O9KOqlVIX95SmD
 PQkfqPfa0hyXlPdLNhm//dI5J9eT09xQwjhlbDnTso74S88MNwr3LsZ/0Oh9xBIPEMMM/i
 CjHCEhOAV7am54Dt/VrdEmfifl4djtA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-1VlyHwp5NraJR7ZRY9JrMg-1; Wed, 14 May 2025 05:10:29 -0400
X-MC-Unique: 1VlyHwp5NraJR7ZRY9JrMg-1
X-Mimecast-MFC-AGG-ID: 1VlyHwp5NraJR7ZRY9JrMg_1747213829
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a2046b5e75so1253043f8f.1
 for <ltp@lists.linux.it>; Wed, 14 May 2025 02:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747213829; x=1747818629;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=55NymfM0nO0qNBhr6CgoketK2XBs31LrXXtiCS62SgI=;
 b=KoD9GTKWLSAqoqeHqeBbhwtvk2c7C3Vg//4KWGsbPU2MUOkCK7asH1J8BkPUso8o2b
 O6BWT00a+7U6WwqwkEO/IAjqFl7CLNF+rS9xBNGq2p2IhZv3hjDawHvTm9Ybr++SMXPS
 Ax3rYuW7OG2zAZCRKp+e1XEfP2ZQTOTtjU7RmQBDXcMMf3P///HfDTmCJv6XuAWdXFhO
 33KA/9RARBAjuk0EbDUAnL7mLXQs/DM5x6CZjRlwpWCW6ju35XP/TJhS+qyWqZTHN4+z
 0+kKSe/qJGR1j43vo/kK7BTdkd74aWzul/DFWK7JAM6iG/TMNZdXdlG9175mR0xjXrMU
 9Atw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVitbpp5I1+lnEVQYo5DuJk8DOtLMZYjJlZbbbztZH0oI/vjEHJwu/PE/rpPn0OmXGnwcE=@lists.linux.it
X-Gm-Message-State: AOJu0Yzz8dcwSFCpuBrlEbPAQJTEPVncCOhRclIFPp/LVuXlqNZf874q
 2nm3Gvajvr/q8xm4Ck7Y3EIigFrxNU4dvNkYv2ETuWy1WiNq6hEUfrZaDs+8tUndtR6h4C0e4s3
 CH8li6DL4JIy1d5AQCF9DNf4bFvDmeXBK1uVPtAyY4aoYdXzrZJt0nkVmGHsEQznpPLln37hJBj
 IlF8SvckpmRn0kdtRftbIllAlC0lU6itZUEseo
X-Gm-Gg: ASbGncuWoT7QmEaRmEow61WBx2EUWj4Oi8toKekabU5yUW7yfet9r9/Aa6m3cbguZrF
 EuqTD7XznIuFjqmknN2Gp7XEitZMtBhUAy6h/U+5J2ZVAR9lwLRBfbBHu2zEQIaRnfdpR
X-Received: by 2002:a05:6000:2910:b0:3a2:595:e8cb with SMTP id
 ffacd0b85a97d-3a34991dc62mr2132787f8f.45.1747213828707; 
 Wed, 14 May 2025 02:10:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnM7brvLMuQhV+JB+q4u/Ih6IgkJOavenvzXhMSX0udcdFUyySsvl+CTHCHxYxLutC6WRUtJFa4u9BYlZH/vg=
X-Received: by 2002:a05:6000:2910:b0:3a2:595:e8cb with SMTP id
 ffacd0b85a97d-3a34991dc62mr2132764f8f.45.1747213828392; Wed, 14 May 2025
 02:10:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250416191645.355088-1-wegao@suse.com>
 <20250428160421.3457215-1-wegao@suse.com>
 <aBt7ck35Dq8GIKHc@yuki.lan>
 <CAASaF6y+e6eKMONT2FdgsLJyhGzZPswQNqthQpneEqpte+-6pQ@mail.gmail.com>
 <aCNox5FGkPsLWGf2@MiWiFi-CR6608-srv>
 <CAASaF6yRO-_dX-ktapqAcWyqU-jwf2k8cJ9+Q7XAN7sqkngz8A@mail.gmail.com>
 <CAEemH2dWyGyHXngTSghnAUmyF+DS0GNvKatVR9CuTpMEZc-rPQ@mail.gmail.com>
In-Reply-To: <CAEemH2dWyGyHXngTSghnAUmyF+DS0GNvKatVR9CuTpMEZc-rPQ@mail.gmail.com>
Date: Wed, 14 May 2025 11:10:12 +0200
X-Gm-Features: AX0GCFsXVvyKEMfAR1cPiAnl28aFMVTZcW2yu1qJFTdWIDx-ALM_12J31MMUPUs
Message-ID: <CAASaF6xNg8AeQMRscHY_gsqQGxw=wPhYiwquuHVKLSgZEYDoFA@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Bh3zaTv0Txvf9YYE_YTRenDWArCIoAU6mFJYcoASPFs_1747213829
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] mmap22.c: Test for new MAP_DROPPABLE flag for
 mmap
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
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBNYXkgMTQsIDIwMjUgYXQgMTE6MDTigK9BTSBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0
LmNvbT4gd3JvdGU6Cj4KPiBPbiBXZWQsIE1heSAxNCwgMjAyNSBhdCA0OjUy4oCvUE0gSmFuIFN0
YW5jZWsgdmlhIGx0cCA8bHRwQGxpc3RzLmxpbnV4Lml0PiB3cm90ZToKPiA+Cj4gPiBPbiBUdWUs
IE1heSAxMywgMjAyNSBhdCA1OjQ04oCvQU0gV2VpIEdhbyA8d2VnYW9Ac3VzZS5jb20+IHdyb3Rl
Ogo+ID4gPgo+ID4gPiBPbiBNb24sIE1heSAxMiwgMjAyNSBhdCAxMDo0Mzo1NUFNICswMjAwLCBK
YW4gU3RhbmNlayB3cm90ZToKPiA+ID4gPiBJcyBhbnlvbmUgZWxzZSBzZWVpbmcgdGhpcyB0ZXN0
IGZhaWxpbmcgb24gcmVjZW50IDYuMTUtcmM1IGtlcm5lbHM/Cj4gPiA+ID4KPiA+ID4gPiA9PT09
IG1tYXAyMiA9PT09Cj4gPiA+ID4gY29tbWFuZDogbW1hcDIyCj4gPiA+ID4gdHN0X3RtcGRpci5j
OjMxNjogVElORk86IFVzaW5nIC90bXAvTFRQX21tYXpDVUxOTiBhcyB0bXBkaXIgKHRtcGZzIGZp
bGVzeXN0ZW0pCj4gPiA+ID4gdHN0X3Rlc3QuYzoxOTM4OiBUSU5GTzogTFRQIHZlcnNpb246IDIw
MjUwMTMwLTI1My1nNGEwZTNhOGZhCj4gPiA+ID4gdHN0X3Rlc3QuYzoxOTQyOiBUSU5GTzogVGVz
dGVkIGtlcm5lbDoKPiA+ID4gPiA2LjE1LjAtMC5yYzUuMjUwNTA5ZzljNjlmODg4NDkwNC40Ny5l
bG4xNDgueDg2XzY0ICMxIFNNUAo+ID4gPiA+IFBSRUVNUFRfRFlOQU1JQyBGcmkgTWF5ICA5IDE1
OjE3OjMxIFVUQyAyMDI1IHg4Nl82NAo+ID4gPiA+IHRzdF9rY29uZmlnLmM6ODg6IFRJTkZPOiBQ
YXJzaW5nIGtlcm5lbCBjb25maWcKPiA+ID4gPiAnL2xpYi9tb2R1bGVzLzYuMTUuMC0wLnJjNS4y
NTA1MDlnOWM2OWY4ODg0OTA0LjQ3LmVsbjE0OC54ODZfNjQvYnVpbGQvLmNvbmZpZycKPiA+ID4g
PiB0c3RfdGVzdC5jOjE3NTg6IFRJTkZPOiBPdmVyYWxsIHRpbWVvdXQgcGVyIHJ1biBpcyAwaCAw
NW0gNTRzCj4gPiA+ID4gbW1hcDIyLmM6NTU6IFRGQUlMOiBNQVBfRFJPUFBBQkxFIGRpZCBub3Qg
ZHJvcCBtZW1vcnkgd2l0aGluIHRoZSB0aW1lb3V0IHBlcmlvZC4KPiA+ID4gPgo+ID4gPgo+ID4g
PiBJIGhhdmUgdGVzdGVkIHJjNS82IGFuZCBib3RoIGdpdmUgcGFzcyByZXN1bHQuCj4gPgo+ID4g
SSBkbyBzZWUgaXQgZmFpbCBhbG1vc3QgZGFpbHkgb24gbXVsdGlwbGUgYXJjaGVzIChWTXMgYW5k
IGJhcmVtZXRhbCksCj4gPiBtYXliZSBzb21lIGRpZmZlcmVuY2UgaW4gb3VyIGNvbmZpZy4KPgo+
IEhhdmUgeW91IHRyaWVkIHRoZSBvcmlnaW5hbCBzZWxmLXRlc3QgKHdpdGhvdXQgdXNpbmcgQ2dy
b3VwKT8KPiBJZiBpdCBzdGlsbCBmYWlscywgY29uc2lkZXIgaXQgYSBrZXJuZWwgaXNzdWUuCgpJ
J2xsIGhhdmUgYSBjbG9zZXIgbG9vayBhbmQgdHJ5IG1hbnVhbGx5LiBBdCBmaXJzdCBnbGFuY2Ug
YXQgdGVzdCwgSQpzdXNwZWN0IGNvbXBpbGVyCmRvaW5nIHNvbWV0aGluZyBjbGV2ZXIgZm9yOgog
ICAgICAgICAgICAgICAgZm9yICg7OykKICAgICAgICAgICAgICAgICAgICAgICAgKihjaGFyICop
bWFsbG9jKHBhZ2Vfc2l6ZSkgPSAnQic7Cgo+Cj4gLS0KPiBSZWdhcmRzLAo+IExpIFdhbmcKPgoK
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
