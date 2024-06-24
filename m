Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE6FC2BD09
	for <ltp@archiver.kernel.org>; Mon, 24 Jun 2024 12:53:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A42953D0F91
	for <ltp@archiver.kernel.org>; Mon, 24 Jun 2024 14:53:02 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 817333D0EBC
 for <ltp@lists.linux.it>; Mon, 24 Jun 2024 14:52:48 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B8B51600CD4
 for <ltp@lists.linux.it>; Mon, 24 Jun 2024 14:52:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719233565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tpkYiPVbYZAAVhVW2+Ipm0TqQtLbQ8K9fbRFItISsBs=;
 b=Jg4LwT1H6gVesyxxIRGfvrB9/nb4wC1J/Xt5kzNUMXzw+gv10ubyNtDDNfEFATZMt4wxUR
 OlhzCCLkr1suUkXjB3n/x+xtTHz78N61jDcScthe9OrqYquaPYyC3C+If6qcm0uhp2kl+p
 6alwhm6hSXy/BNXTmjSUY66F9IKOOlQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-QyapJT0VN2C5OtaLcWCDpg-1; Mon, 24 Jun 2024 08:52:43 -0400
X-MC-Unique: QyapJT0VN2C5OtaLcWCDpg-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2c7c3069ee0so5346925a91.3
 for <ltp@lists.linux.it>; Mon, 24 Jun 2024 05:52:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719233563; x=1719838363;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tpkYiPVbYZAAVhVW2+Ipm0TqQtLbQ8K9fbRFItISsBs=;
 b=dCziQW9RHJZkvmNRAPiBwOBy/e4coTCqJKULOFghvuKcIlUBrgstKNJPafwJxeYPij
 g1igYyPlU/zNMutkkgz9ZczHI+f+ri7Qhnxgaigs5gFFX3GFi9zDw7P0N/0KKlOcygr/
 ikAOQpsNyJF0VqZgEHfSvravykR32EF8DqhbrEIT8iAxBP5mnqo39T9I16gm2QQVmQV0
 QV9/IOnT8CFhz6McF1H/hxD2FcgduApU5d4HJ6hl50n9WboRXnseY5iBD6zMzTntJu+2
 VTbUrxQxqzezunMxgHs7Uo2+YtSjXeUFEEAtAm6hnEFSQ4FvcwvZIdaXRbf8kKDp75LW
 fiMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGMSMSIPV/IhX2RHJDCQ119JotsjQ+gR/VnSodjO2F1L627knSfcP4Ao4zajasqwNIyYc1bIDPmXrQ2Vv/owIHhsg=
X-Gm-Message-State: AOJu0YxESUI6/Xx6q5/0XjY9JLtNO6A42tkmbYSuN9ThoxKTF6S7htQ4
 LGR9xhAg8/n17u7vo7K3w6AVhbiRMDJ6JRsQqrDXpKOo5sRYfICSYmTJNFwPAFPltYvBwaXcZ0i
 cgTArLjXnVTNKMS32PG+RFCe7gGUybdCaKIQmSHvCjpwWnTt5rpgi93wYoL6ktrq03ubvzJBWnI
 3VitXdKs7OSMfJG2Dl4Ew5+0k=
X-Received: by 2002:a17:90b:4d8e:b0:2c2:97c2:1426 with SMTP id
 98e67ed59e1d1-2c86127e2cfmr3068718a91.10.1719233562780; 
 Mon, 24 Jun 2024 05:52:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7JO/FooimsNULNvwJ1y6PXielX4eWnQ/jog5uZmtdf2fCCeLGMnHk6dWM5Ofj9SOIbTeLuXRHGZsP0YkrS2Q=
X-Received: by 2002:a17:90b:4d8e:b0:2c2:97c2:1426 with SMTP id
 98e67ed59e1d1-2c86127e2cfmr3068703a91.10.1719233562457; Mon, 24 Jun 2024
 05:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240419110230.191809-1-pvorel@suse.cz>
 <CAEemH2eZNO=P5c_igqNKSva-q37y7GSK=d44wUHd=Ua=DTUNDw@mail.gmail.com>
 <ZnlnHOGlHDOyhImb@yuki>
In-Reply-To: <ZnlnHOGlHDOyhImb@yuki>
From: Li Wang <liwang@redhat.com>
Date: Mon, 24 Jun 2024 20:52:30 +0800
Message-ID: <CAEemH2fkPSwNiBtXRtDN4ngcR-v_GvjV6fXq6FZux1Ub3Hy-aQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] libs: Remove 'libltp' prefix from libs source
 directories
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

T24gTW9uLCBKdW4gMjQsIDIwMjQgYXQgODozMeKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiA+IEkga25vdyByZW5hbWluZyBmaWxlcyBpcyBub3Qg
b3B0aW1hbC4gQnV0IGhpc3Rvcnkgd2lsbCBiZSBrZXB0LCB3aGVuCj4gPiA+IGJyb3dzaW5nIHdp
dGggZ2l0ayBvciBnaXQgZ3VpLgo+ID4gPgo+ID4gPiBJbXByb3ZlbWVudDogbGVzcyB0eXBpbmcg
d2hlbiBjZCB0byB0aGUgZGlyZWN0b3J5Lgo+ID4gPgo+Cj4gSSBkbyBub3QgaGF2ZSBhIHN0cm9u
ZyBvcGluaW9uIG9uIHRoaXMsIGZlZWwgZnJlZSB0byBwdXNoIHRoZSBjaGFuZ2UKPiB3aXRoIG15
Ogo+Cj4gQWNrZWQtYnk6IEN5cmlsIEhydWJpcyA8Y2hydWJpc0BzdXNlLmN6Pgo+Cj4gPiArMSBJ
IGFncmVlIHdpdGggdGhpcywgYW5kIEkgYWx3YXlzIGhhdmUgYSBxdWVzdGlvbiwgd2h5Cj4gPiB3
ZSBoYXZlIGFkZGl0aW9uYWwgbGlicy8gcGFyYWxsZWwgd2l0aCBsaWIvLCBpcyB0aGVyZSBhbnkg
cm9vdAo+ID4gZGlmZmVyZW5jZSBiZXR3ZWVuIHRoZW0/IG9yIGp1c3QgYSBoaXN0b3JpY2FsIGlz
c3VlPwo+Cj4gVGhlIGlkZWEgaXMgZXhhY3RseSBob3cgaXQgd2FzIGRlc2NyaWJlZCBieSBQZXRl
ciwgdGhlc2UgYXJlIHVzdWFsbHkKPiBsaWJyYXJpZXMgdXNlZCBvbmx5IGJ5IGEgZmV3IHRlc3Rz
IGUuZy4gZnVuY3Rpb25zIHRvIGRlYWwgd2l0aCBzd2FwIG9yCj4gbGludXggaW5wdXQsIHdoaWxl
IGxpYi8gaGFzIGZ1bmN0aW9ucyB0aGF0IGFyZSB1c2VkIGJ5IG1vc3Qgb2YKPiB0aGUgdGVzdHMg
d2l0aCBtb3JlIGdlbmVyaWMgZnVuY3Rpb25hbGl0aWVzLgo+Cj4gQXBhcnQgZnJvbSBzbWFsbCBz
cGVlZHVwIGl0IG1ha2VzIHRoaW5ncyBhIGJpdCBlYXNpZXIgdG8gbmF2aWdhdGUsIGF0Cj4gbGVh
c3QgSSB0aGluayBzby4gT3IgZG8geW91IHRoaW5rIHRoYXQgdGhpcyB3b3VsZCBiZSBiZXR0ZXIg
d2l0aCBhbGwgdGhlCj4gZmlsZXMgaW4gYSBzaW5nbGUgZGlyZWN0b3J5Pwo+CgpIbW0sIG1heWJl
IHllcywgdGhlIGxpbWl0ZWQgc3BlZWR1cCBjYW4gYmUgaWdub3JlZCBmb3IgdG9kYXkncyBwcm9j
ZXNzb3JzLgpCdXQgcHV0dGluZyBsaWIgdG9nZXRoZXIgY2FuIG1ha2UgcGVvcGxlIHVuZGVyc3Rh
bmQgTFRQIGxpYiBtb3JlCmNvbXBsZXRlbHkvZWFzaWx5LgoKQW55d2F5LCB0aGUgcGF0Y2ggaXRz
ZWxmIGxvb2tzIGdvb2QuClJldmlld2VkLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4K
CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
