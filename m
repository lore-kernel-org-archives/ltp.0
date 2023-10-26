Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4BC9C25B48
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 08:12:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 272D83CCB34
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 10:12:38 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B30153C8711
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 10:12:28 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 902CD1009BCE
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 10:12:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698307945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mp07FBA3qkSPGdx/U3ybWnMn3Tv5LiUzP8+/aRpR9Pg=;
 b=jT0g6wu52KvcqNhwmb/dMUv9nrve1Qg7sftLJpLusSkvo8cMJeBHoaBPwS8vovnb/uI+05
 c6cXhHIGK0Z74U0XYWKAQgBc8WdS+jbPE/RfYoirgW7HvN9R4Kx8CwrzMN1cqpP4LZ1W4W
 1VLWzQgA6z22AedB0VxuwqzGTarx1pM=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-oos6nVW1PByqpgSU1RxAIA-1; Thu, 26 Oct 2023 04:12:23 -0400
X-MC-Unique: oos6nVW1PByqpgSU1RxAIA-1
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-7b750197555so223588241.3
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 01:12:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698307942; x=1698912742;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mp07FBA3qkSPGdx/U3ybWnMn3Tv5LiUzP8+/aRpR9Pg=;
 b=ZvhA6Wm5rvVnMwquxCfrsMVM4hTe6fuf3acg6OJCu7h6P17bKPthTXJpnA8MYG0k2O
 1NzFUsojliImzWXpsSJQLdgdnpsOIZOT90EzU5vBgtiSC/6Q3oope3Bk4MeDerZuMBOT
 R//4ormxLDU3i31oa+It+Fe8w7VDrALsLTqc6GUsJtXXVKXakE6u6zY6weJkxyqyGlFg
 4OXjlHA9HRQxgZS+uWEjBWF4tXK9NLT5RvhJV3uQg8UaZXcUuYFtYJ47sjo70ZsdRWkF
 UZTUNrllu7MlhbF5BrTm7tHK25uyl9/rjI3BaGSPjXpmbbFP8je/xy1Js9BtnNYCZWqY
 SmGw==
X-Gm-Message-State: AOJu0YzQZ8whgOkang9D5GxZ3KiTPETxTiUIZTjoeJgUmln57hHNAWjK
 RAVNjcQQ4yr09DW1Z7O2pb5Kvf2DQ8CQbrKy+UaB6F+WQ8ly6O3cXtQ0e5NiKxjvu+QA6xDXZFa
 ddM+ts+lAed1qUulMQUB/lQ5TFY8=
X-Received: by 2002:a67:ab07:0:b0:44e:9313:b045 with SMTP id
 u7-20020a67ab07000000b0044e9313b045mr16306932vse.7.1698307941738; 
 Thu, 26 Oct 2023 01:12:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFj/+OyO1IQLO6d9JNk3PsCATgf8L9Z3lQ4fZeQOHswYcMI/waQRv63Mkai2AHZrVUQGCiwsZ3PRL1g9phPC4s=
X-Received: by 2002:a67:ab07:0:b0:44e:9313:b045 with SMTP id
 u7-20020a67ab07000000b0044e9313b045mr16306920vse.7.1698307941474; Thu, 26 Oct
 2023 01:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231025140109.340441-1-pvorel@suse.cz>
In-Reply-To: <20231025140109.340441-1-pvorel@suse.cz>
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 26 Oct 2023 10:12:53 +0200
Message-ID: <CAASaF6yVnrBK0UCxj4HRbi_scm84KS5Jm_xi8rUEuXcZXo=rZQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/2] Remove CentOS 7 support
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
Cc: Ulrich Hecht <uli@kernel.org>, Martin Doucha <martin.doucha@suse.com>,
 Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBPY3QgMjUsIDIwMjMgYXQgNDowMeKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IEhpIGFsbCwKPgo+IHdlIHJlY2VudGx5IGhhZCB5ZXQgYW5vdGhlciBy
ZWdyZXNzaW9uIG9uIG9sZCBDZW50T1MgNyAoa2VybmVsIDMuMTAsCj4gZ2xpYmMgMi4xNywgZ2Nj
IDQuOC41IFsxXS4gVGhhdCBicm91Z2h0IG1lIHRvIHRoZSBxdWVzdGlvbiBpZiB3ZSBzdGlsbAo+
IHdhbnQgdG8gc3VwcG9ydCBpdC4KPgo+IEFsdGhvdWdoIHdlIHRlc3QgaW4gU1VTRSBhbHNvIHZl
cnkgb2xkIFNMRVMgcmVsZWFzZXMsIHRoZXNlIGFyZSB0ZXN0ZWQKPiB3aXRoIG9sZGVyIExUUCBy
ZWxlYXNlcy4gSSBzdXBwb3NlIFJlZCBIYXQgZG9lcyB0aGUgc2FtZSB3aXRoIFJIRUwKPiAoTGks
IEphbiwgcGxlYXNlIGNvcnJlY3QgbWUgaWYgbm90LCBvciBmZWVsIGZyZWUgdG8gaW50cm9kdWNl
IGFub3RoZXIKPiBDZW50T1MgdmVyc2lvbiwgYXMgdGhlcmUgd2lsbCBub25lIHdpdGggdGhpcyBw
YXRjaHNldCksIHRodXMgd2h5Cj4gcHJldGVuZCBjdXJyZW50IExUUCBpcyB1c2VmdWwgb24gdGhl
c2Ugb2xkIHJlbGVhc2VzLgoKTG9va2luZyBhdCBpbnRlcm5hbCBMVFAgdGVzdCB3cmFwcGVyLCBp
dCdzIHVzaW5nIG9sZGVyIExUUCByZWxlYXNlIGZvciBSSEVMNywKc28geW91ciBhc3N1bXB0aW9u
IGFwcGVhcnMgdG8gYmUgY29ycmVjdC4KCj4KPiBJIHdvbmRlciB3aG8gaXMgYWN0dWFsbHkgaW50
ZXJlc3RlZCBpbiBrZWVwaW5nIExUUCBjb21waWxhYmxlIGZvciBDZW50T1MgNy4KPiBBY2NvcmRp
bmcgdG8gZGlzdHJvd2F0Y2ggaXQgRU9MIGluIDIwMjQtMDYgWzJdLCBidXQgZG9lcyBhbnlib2R5
IGV2ZW4gcnVuIG5ldwo+IExUUCBvbiBpdC4gSWYgeWVzLCBwbGVhc2Ugc3BlYWsgdXAsIGJ1dCBJ
J2QgZXhwZWN0IHRoYXQgcGVyc29uIHRvCj4gYWN0dWFsbHkgbWFpbnRhaW4gQ0kgZmFpbHVyZXMu
CgpUaGVyZSdzIHBsYW5uZWQgRUxTIHVudGlsIDIwMjYsIGJ1dCBJJ2QgZXhwZWN0IHRoYXQgY29u
dGludWVzIHVzaW5nCm9sZGVyIExUUCBmb3IgdGVzdHMuCgo+Cj4gVGhlIG9sZGVzdCBTTEVTIHJl
bGVhc2UgU1VTRSBhY3R1YWxseSB0ZXN0cyB3aXRoIHRoZSBsYXRlc3QgTFRQIHJlbGVhc2UgaXMK
PiBTTEUxMi1TUDIgKGtlcm5lbCA0LjQsIGdsaWJjIDIuMjIgYW5kIGdjYyA0LjguNSkuIFRoZSBs
YXRlc3Qga2VybmVsIExUU1MgaXMKPiA0LjE0LiBUaHVzIHJlbW92aW5nIENlbnRPUyA3IGZyb20g
dGhlIENJIGFuZCByZS1hZGRpbmcgVWJ1bnR1IDE2LjA0IExUUwo+IHhlbmlhbCAoa2VybmVsIDQu
NCwgZ2xpYmMgMi4yMywgZ2NjIDUuMy4xKSB3b3VsZCBtb3JlIG9yIGxlc3MgZml0IFNVU0UKPiBu
ZWVkcy4gSXQgYWN0dWFsbHkgRU9MLCBidXQgZG9ja2VyIGlzIHN0aWxsIHN1cHBvcnRlZCBbM10u
Cj4KPiBUaGUgYmVuZWZpdCB3b3VsZCBiZSB0byBoYXZlIDMgeWVhcnMgeW91bmdlciBiYXNlIGtl
cm5lbCBhbmQgZ2xpYmMgKHRodXMKPiBsZXNzIGxhcGkgZmFsbGJhY2tzIG5lZWRlZCkuIElmIHRo
aXMgaXMgYWNjZXB0ZWQsIEknbGwgaGF2ZSBsb29rIG9uCj4gb2xkZXIgY29kZSBhbmQgc2VuZCBm
b2xsb3dpbmcgcGF0Y2hlcyB3aGljaCByZW1vdmVzIGl0Lgo+Cj4gV2UgY3VycmVudGx5IHVzZSAt
c3RkPWdudTk5IHNpbmNlIGRjN2JlMzBlMiAoImNvbmZpZzogRXhwbGljaXRseSBzZXQgZ251OTki
KSwKPiB3aGljaCBkb2N1bWVudHMgdGhhdCBjYW4ndCB1c2UgQzk5IGJlY2F1c2UgTFRQIGlzIGZh
ciBmcm9tIGNvbXBsaWFudC4KPiBUaGVyZWZvcmUgSSdkIGtlZXAgaXQgdGhlIHNhbWUgdW50aWwg
d2UgcmV3cml0ZSAob3IgZGVsZXRlKSB0aGUgb2xkIGNvZGUuCj4gKHhlbmlhbCBnY2MgNS4zLjEg
aGFzIHRoZSBkZWZhdWx0IGRpYWxlY3QgLXN0ZD1nbnUxMSBbNF0sIFNMRTEyLVNQMiBnY2MgNC44
LjUgaXMKPiAtc3RkPWdudTkwIFs1XSwgQzk5IGlzIGFscmVhZHkgc3VwcG9ydGVkIGluIGdjYyA0
LjUsIHdpdGggLWZleHRlbmRlZC1pZGVudGlmaWVycwo+IFs2XSkuCj4KPiBLaW5kIHJlZ2FyZHMs
Cj4gUGV0cgo+Cj4gUGV0ciBWb3JlbCAoMik6Cj4gICBDSTogUmVBcGxhY2UgQ2VudE9TIDcgd2l0
aCBvcGVuU1VTRSBMZWFwIDQyLjIsIFVidW50dSB4ZW5pYWwKPiAgIGRvYy9zdXBwb3J0OiBVcGRh
dGUgdGhlIGxhdGVzdCB0ZXN0ZWQgZGlzdHJvcwo+Cj4gIC5naXRodWIvd29ya2Zsb3dzL2NpLnlt
bCAgICAgICAgICAgICAgICAgICAgICAgIHwgMTcgKysrKysrKysrKystLS0tLS0KPiAgLi4uZWQt
a2VybmVsLC1saWJjLC10b29sY2hhaW4tdmVyc2lvbnMuYXNjaWlkb2MgfCAgMiArLQo+ICAyIGZp
bGVzIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCj4KPiAtLQo+IDIu
NDIuMAo+CgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xp
c3RpbmZvL2x0cAo=
