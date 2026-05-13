Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04FDACD4851
	for <ltp@archiver.kernel.org>; Wed, 13 May 2026 08:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778661401; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=xwK7M3ylvDkUqYSnflJR0DRojzxH3qScMLNNSXkDstc=;
 b=MKXILcX8IZYgskoZdLFq+gRsH7G2w65J3QkSDZnngiSiJPERKzmoP7UwzCUwUaDBa/tKc
 auJ5sUs32QgmidQhcECrpLyZEHk27QKl3KVgz/ySnsWTtFzA4p8uG9f70OTs5NiLILQBzHC
 h5Y/2JSqXhvYdejOUDudWYHKiIQ1r6I=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7C0173DF957
	for <ltp@archiver.kernel.org>; Wed, 13 May 2026 10:36:41 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 028233D888C
 for <ltp@lists.linux.it>; Wed, 13 May 2026 10:36:16 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 425536002C8
 for <ltp@lists.linux.it>; Wed, 13 May 2026 10:36:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778661373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oRPp0CxLJRT8mKXDCVuv5yk0cYHwzTvfFuyYei6Q2XQ=;
 b=i60wq02XyqITyJHpnSLGkfLgTSD16gJk/n9+q/3p+rNKd2drVswsUqG8ftjmsfxI0EuoT4
 3SkIyXaLmRXpaabS06Z+AB34rUCkdYxKr2KsS4G+II/cm7YTK6PqVjX2M5qqDa3PeEHWuy
 NfE7TDTdo8EdC17d9MI/AZMum+V4S7g=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-_WPxSqUsMS--pQjzEVIjRg-1; Wed, 13 May 2026 04:36:10 -0400
X-MC-Unique: _WPxSqUsMS--pQjzEVIjRg-1
X-Mimecast-MFC-AGG-ID: _WPxSqUsMS--pQjzEVIjRg_1778661369
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-39391b06ef8so38879231fa.2
 for <ltp@lists.linux.it>; Wed, 13 May 2026 01:36:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778661369; x=1779266169;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oRPp0CxLJRT8mKXDCVuv5yk0cYHwzTvfFuyYei6Q2XQ=;
 b=F7sRKLXEiUCUOauGgYlFL5+lyvl+9hQDZjnJHA6de1YkkjuWaJhoa1Yvta+YQYfxot
 lu5RzRNSgXOuOL04hMIcaxFaKZTb47E4vDXLA84F0Pulx4rQdTJXDocZaQz0MDr2fgfa
 ijOej3tDcIKtAHtLpqsUYQo1OAJ2cJEKbNKlOZK/q9lvVtP/hI0hv067ng69CJCfmPqr
 UlKa7AABCZ9JrXnE408ummsHmERkL2Vtrv1T4+zezhUJif/8WHbknyJzQruBYAocQPPg
 8XJMv1WGo18R/4KEfoWopDYynK60GGa552dTvVf3sNlUooqCEsI5YA/xX23Xt0vQHvR/
 EaBQ==
X-Gm-Message-State: AOJu0Ywugp5IjwwKpEQ45f1IMFR5zmWgoDw8jq7M/8JsWIcV+QQPdh/g
 0LK37hRZ/+0crWTXkaArFBqPqHmNUSVEbfyESPQSNDydnb8DZfPmxlpbZB7PcN+K6p9lUWkQeUu
 GxyCWaG9vUUenQNU0Kec+7VJbHx8ORblvCk04/D9MAsKzNsw0G/LTw04ZzY8ih3BMeSDJzp7qil
 rCYQtno2dajpVx4gqUNktTP59/ato=
X-Gm-Gg: Acq92OFAk/lu26MvFwyF4P9VyIP6/Q72OCu6Rhv9B3kOz5EGJI0KFfcP1SrTj9mgYqb
 ixPpkmqTqUFJ4cTw2XShmVmsYYwAXxiidteQ/xPJpnfmNqspgpqvhLvFnQ3LpnLZzyQUnMOwU4i
 /1pQpict/yURd3otiKo4YWG7rqtgpToP+j6aLOqWuqmNaABdsd2+VwOxtEIIPJFmkqrgh/MEbvm
 agOvw==
X-Received: by 2002:a05:651c:150b:b0:394:3edb:eb85 with SMTP id
 38308e7fff4ca-3944e6b7be6mr7200631fa.4.1778661368838; 
 Wed, 13 May 2026 01:36:08 -0700 (PDT)
X-Received: by 2002:a05:651c:150b:b0:394:3edb:eb85 with SMTP id
 38308e7fff4ca-3944e6b7be6mr7200481fa.4.1778661368284; Wed, 13 May 2026
 01:36:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260507111809.28934-2-mmenashe@redhat.com>
 <20260507120105.4062-1-linuxtestproject.agent@gmail.com>
In-Reply-To: <20260507120105.4062-1-linuxtestproject.agent@gmail.com>
Date: Wed, 13 May 2026 11:35:52 +0300
X-Gm-Features: AVHnY4Kuon0j_F5QMNcdkopE3SzzvkbY7sFLhXIozma0cHWzXJFWoBk0Q_nYPec
Message-ID: <CAHGiOXdBE=p8Mwqsa7gvGbS7GqJnTi1kCJJg9rUc9k8dtcABFA@mail.gmail.com>
To: linuxtestproject.agent@gmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3Ack8Vo7RPM7HPgB3ohLQVn22CxvxVQ_j2YqS4jO2XI_1778661369
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] futex_wait06: Add EFAULT error coverage test
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
From: Michael Menasherov via ltp <ltp@lists.linux.it>
Reply-To: Michael Menasherov <mmenashe@redhat.com>
Cc: ltp@lists.linux.it, LTP AI Reviewer <ltp-ai@noreply.github.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

ICBIaSwKCiAgSnVzdCBhIGtpbmQgcmVtaW5kZXIgYWJvdXQgdGhpcyBwYXRjaCBzZXJpZXMgc2Vu
dCBvbiBNYXkgN3RoLgogIFRoZSBMVFAgQUkgUmV2aWV3ZXIgaGFzIGFscmVhZHkgYXBwcm92ZWQg
YWxsIGZvdXIgcGF0Y2hlcy4KCiAgV291bGQgYXBwcmVjaWF0ZSBpdCBpZiBzb21lb25lIGNvdWxk
IHRha2UgYSBsb29rIHdoZW4gdGltZSBwZXJtaXRzLgoKICBUaGFua3MsCiAgTWljaGFlbCBNZW5h
c2hlcm92CgpPbiBUaHUsIE1heSA3LCAyMDI2IGF0IDM6MDHigK9QTSA8bGludXh0ZXN0cHJvamVj
dC5hZ2VudEBnbWFpbC5jb20+IHdyb3RlOgoKPiBIaSBNaWNoYWVsLAo+Cj4gT24gVGh1LCA3IE1h
eSAyMDI2LCBNaWNoYWVsIE1lbmFzaGVyb3Ygd3JvdGU6Cj4gPiBbUEFUQ0ggMS80XSBmdXRleF93
YWl0MDY6IEFkZCBFRkFVTFQgZXJyb3IgY292ZXJhZ2UgdGVzdAo+ID4gW1BBVENIIDIvNF0gZnV0
ZXhfd2FpdDA3OiBBZGQgRUlOVFIgZXJyb3IgY292ZXJhZ2UgdGVzdAo+ID4gW1BBVENIIDMvNF0g
ZnV0ZXhfd2FrZTA1OiBBZGQgRUZBVUxUIGVycm9yIGNvdmVyYWdlIHRlc3QKPiA+IFtQQVRDSCA0
LzRdIGZ1dGV4X2NtcF9yZXF1ZXVlMDM6IEFkZCBFRkFVTFQgZXJyb3IgY292ZXJhZ2UgdGVzdAo+
Cj4gUmV2aWV3ZWQtYnk6IExUUCBBSSBSZXZpZXdlciA8bHRwLWFpQG5vcmVwbHkuZ2l0aHViLmNv
bT4KPgo+IC0tLQo+IE5vdGU6Cj4KPiBPdXIgYWdlbnQgY29tcGxldGVkIHRoZSByZXZpZXcgb2Yg
dGhlIHBhdGNoLiBUaGUgZnVsbCByZXZpZXcgY2FuIGJlCj4gZm91bmQgYXQ6IChub3QgYXZhaWxh
YmxlKQo+Cj4gVGhlIGFnZW50IGNhbiBzb21ldGltZXMgcHJvZHVjZSBmYWxzZSBwb3NpdGl2ZXMg
YWx0aG91Z2ggb2Z0ZW4gaXRzCj4gZmluZGluZ3MgYXJlIGdlbnVpbmUuIElmIHlvdSBmaW5kIGlz
c3VlcyB3aXRoIHRoZSByZXZpZXcsIHBsZWFzZQo+IGNvbW1lbnQgdGhpcyBlbWFpbCBvciBpZ25v
cmUgdGhlIHN1Z2dlc3Rpb25zLgo+Cj4gUmVnYXJkcywKPiBMVFAgQUkgUmV2aWV3ZXIKPgo+Cgot
LSAKCk1pY2hhZWwgTWVuYXNoZXJvdgoKU29mdHdhcmUgUXVhbGl0eSBFbmdpbmVlciAtIEF1dG9t
b3RpdmUgS2VybmVsCgpSZWQgSGF0IDxodHRwczovL3d3dy5yZWRoYXQuY29tLz4KPGh0dHBzOi8v
d3d3LnJlZGhhdC5jb20vPgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo=
