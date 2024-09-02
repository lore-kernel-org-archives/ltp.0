Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A11CA0ED3
	for <ltp@archiver.kernel.org>; Mon,  2 Sep 2024 08:45:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5F0DA3C323B
	for <ltp@archiver.kernel.org>; Mon,  2 Sep 2024 10:45:42 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 219353C2FE1
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 10:45:24 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 14F4A601BAE
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 10:45:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725266722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CMXGz+rf0NfqYlLSSiLPWLLpKvAqdoHUTqmShzUz3Bw=;
 b=ZpVh54P6t8nToeahFKpAS55xp+11o7aaIYJP8YdBQX8GfrcaZBEDENrq2GnaMO2kbnNjeu
 is2MR1BpxBypqvrJ8jdIWESTmee11sVNmeijqz+Sxww1AjNNOP3IukoNZjZX4zs+9SguyX
 Oo+mIAonc7nb1HvGre4dzQpE+2y6Qdg=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-1GV-W0UUPDW9NGqkyBbmzA-1; Mon, 02 Sep 2024 04:45:20 -0400
X-MC-Unique: 1GV-W0UUPDW9NGqkyBbmzA-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-20556f1cfebso16449565ad.1
 for <ltp@lists.linux.it>; Mon, 02 Sep 2024 01:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725266719; x=1725871519;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CMXGz+rf0NfqYlLSSiLPWLLpKvAqdoHUTqmShzUz3Bw=;
 b=tI2gV/FObShAo/tRdcBDqmByZfa07TLXhBAJ2+rVYD5PinNIsH5VVImQ/3GVcJwM8P
 UlrAhUXiX4YHcvppEYWO75do1RhoACr1WbZsKZSCqnkhlO9zCZsaqB+MliR/jJLA4p6P
 RSv0pMflBQpHaXckREYmPH1yXrgCAEPq87fsUu7Qu/kzvSveQBfdWSPVuSMh19JcqDqH
 aySdEmXby2sphP4EBAqkm5MzFNBSWUA5cSZ8UGPkt00Q02HzvvwaDMxgttVZ/8JmrOme
 mDN2wj26mlHyhlUP36S81q2ES4U5U+cqLyCdUTvvbE/7HFySM/dfrCd++rdAapP4tlrA
 vAgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQJn54KHZ2kHHQh//AvsAfqT6zz16OZN/kfRyKyI22HOWz8O3g9qHWhDT87KqS7/Qy6eM=@lists.linux.it
X-Gm-Message-State: AOJu0YzOLjyrYua5o85svd2ISz82f7ZyLHIe6dfS6CwYpdZ8ovwHNBi+
 qZ3XUGMDOtuoCHDHM5GfUND+vtMrZoJARpEcJAaXRUu6EGRRUwn0i3+UeN17RvKywrjTW6itp9L
 /jb31i4ky8LDK5L6Mab9CwjSat2TYXWKrZrp2FfMpbNokSQU4/c7+AYTpNjbxIQ0WTfHEHH7JR9
 n3gqvGDcAW4u4rLkInmW1AWdc=
X-Received: by 2002:a17:902:ec90:b0:203:a046:c666 with SMTP id
 d9443c01a7336-20545e44357mr85727475ad.3.1725266719680; 
 Mon, 02 Sep 2024 01:45:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEU0baq5wTD7qG57W+SoiO4JP03GIOKKHPeHluNsJhlNbeOhN8HLZgz/Iaz4ss10dXi0tzbCuD/2jG+73kwEo8=
X-Received: by 2002:a17:902:ec90:b0:203:a046:c666 with SMTP id
 d9443c01a7336-20545e44357mr85727245ad.3.1725266719163; Mon, 02 Sep 2024
 01:45:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240829114124.30299-1-wegao@suse.com>
 <20240902072842.GA280672@pevik>
In-Reply-To: <20240902072842.GA280672@pevik>
From: Li Wang <liwang@redhat.com>
Date: Mon, 2 Sep 2024 16:45:07 +0800
Message-ID: <CAEemH2eB4-wn6HyyJL9AUBaREeibhR5L9oEr9Z15tG7m_Q6ZDA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] hugemmap11.c: Change NORMAL_PATH to current
 working directory
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

T24gTW9uLCBTZXAgMiwgMjAyNCBhdCAzOjI54oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgo+Cj4gSGkgV2VpLCBMaSwKPgo+ID4gRm9sbG93aW5nIGVycm9yIHdpbGwgaGFw
cGVuIG9uIHNsZS1taWNybyBzeXN0ZW0gc2luY2UgIi8iIGlzIHJlYWQgb25seQo+ID4gdHN0X3Rl
c3QuYzoxMDYyOiBUQlJPSzogb3BlbigvbHRwX2h1ZzlJeTZPUiwxNjU3OCwxMDI0NzUyMDI0MCkg
ZmFpbGVkOiBFUk9GUyAoMzApCj4KPiA+IFNpZ25lZC1vZmYtYnk6IFdlaSBHYW8gPHdlZ2FvQHN1
c2UuY29tPgo+ID4gLS0tCj4gPiAgdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlbW1h
cC9odWdlbW1hcDExLmMgfCAyICstCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pCj4KPiA+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL21lbS9o
dWdldGxiL2h1Z2VtbWFwL2h1Z2VtbWFwMTEuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0
bGIvaHVnZW1tYXAvaHVnZW1tYXAxMS5jCj4gPiBpbmRleCA0OTZhODE0YjUuLjY3ZmNhMmRkZiAx
MDA2NDQKPiA+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZW1tYXAvaHVn
ZW1tYXAxMS5jCj4gPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL21lbS9odWdldGxiL2h1Z2VtbWFw
L2h1Z2VtbWFwMTEuYwo+ID4gQEAgLTIzLDcgKzIzLDcgQEAKPgo+ID4gICNkZWZpbmUgUDAgImZm
ZmZmZmZmIgo+ID4gICNkZWZpbmUgSU9TWiA0MDk2Cj4gPiAtI2RlZmluZSBOT1JNQUxfUEFUSCAi
Igo+ID4gKyNkZWZpbmUgTk9STUFMX1BBVEggIi4vIgo+Cj4gUmV2aWV3ZWQtYnk6IFBldHIgVm9y
ZWwgPHB2b3JlbEBzdXNlLmN6Pgo+Cj4gQExpOiBEbyB5b3Ugc2VlIGFueSBjb25zZXF1ZW5jZXM/
CgpJIHRoaW5rIGl0IGlzIG5vIHByb2JsZW0gdG8gYXBwbHkgdGhlIHBhdGNoLCBhcyB5b3UgcG9p
bnRlZAptbnRwb2ludCBpbXBsaWVzIG5lZWRzX3RtcGRpci4gIFNvIGl0IHdvbid0IGhpdCBhbiB1
bndyaXRhYmxlCmlzc3VlIHdoZW4gdXNpbmcgJFBXRC4KClJldmlld2VkLWJ5OiBMaSBXYW5nIDxs
aXdhbmdAcmVkaGF0LmNvbT4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgoKLS0gCk1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
