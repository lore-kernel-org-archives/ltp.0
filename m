Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C168C4345F
	for <ltp@archiver.kernel.org>; Tue, 16 Apr 2024 06:35:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 573B73CFA9B
	for <ltp@archiver.kernel.org>; Tue, 16 Apr 2024 08:35:49 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BF3D73CFA35
 for <ltp@lists.linux.it>; Tue, 16 Apr 2024 08:35:33 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 98293201741
 for <ltp@lists.linux.it>; Tue, 16 Apr 2024 08:35:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713249330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WwZUnfVR7b2FLp+dhKSKCC0kG7MsiDvxLr7j41QnlUg=;
 b=L+cClE/tq4q8C4AyjHa9coKcx0bVTDbQ2eOcZZML+U44S/RtGWrG43pm2pYHTvqLemvKjp
 +kGQpMar1JUDGr1RO8t4bPOawTgTc0XwOk5WRBBoDp8pl8tD6g7TgKRpz7hlfI36k2WmXP
 wKGGISyYoNpxHizNHZ3n9WkPK3lEWOw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-Q2WAaT1DMv6Xf3X3qiXIhA-1; Tue, 16 Apr 2024 02:35:28 -0400
X-MC-Unique: Q2WAaT1DMv6Xf3X3qiXIhA-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2a2d197ac0aso3818305a91.2
 for <ltp@lists.linux.it>; Mon, 15 Apr 2024 23:35:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713249327; x=1713854127;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WwZUnfVR7b2FLp+dhKSKCC0kG7MsiDvxLr7j41QnlUg=;
 b=OQ1/kfZpWbEyRKry/kPztuKaWGmlGK9zGJVMHdAvVI4Xd05Z68K4VmppYbbwGj7mp1
 /sxnO9wDmtnOZjV+pqIt3+y2s5UCu5ivU2FYe39gV5H+5CP0JGNUgnLD/aRc4uyrKaXM
 FeYFZ/WXN6otSYXxn8vxVJNvBXUD0SPisHii9ZCk7tGpCDnGPEOnNAh/tHVhO+Im1Q5t
 F7rKQrXrv4/Y9foUrk7sPpFdueM/gEJvojm/0LvPM+3aUkWf6ENR1ceTn8hBqlkCNAuI
 C9ibcwqNhi7oSLqdi85CsKRlASAQ8TYl6FA5J/YYu5yMu8MMiOgChsDDRAqXgPvquumm
 TS0Q==
X-Gm-Message-State: AOJu0YzMbIA2OI0D3nBM2iN93xSsbu0YQxBtU55+v3S5PGMQ2GhKH0TP
 Y/qUyjfjrg2OcxTlYNwO95ri2yjnu6X7BAqWWyXSzV/AlMBQUe84jTFZQ+wKzm+Ugsu97xJqdT2
 K93/rFdr43t/kgLucn6WKyr42923hbCwuWhGXLjo80OvX3ZXFaPxn6zKx7xt14RJmi/Z/FQqRTc
 zFek78EfHvMCNq6+0+jWWWlIo=
X-Received: by 2002:a17:90a:b28c:b0:2a2:5457:d34e with SMTP id
 c12-20020a17090ab28c00b002a25457d34emr8989818pjr.13.1713249326990; 
 Mon, 15 Apr 2024 23:35:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFnMPKW8N0cGh/WHr3KXf5IfRyLGLM+QofKlCKlFzxHFsHud1A2butZk/A7Dmzu45nAh8zbnIpZL0rIJ6FWRo=
X-Received: by 2002:a17:90a:b28c:b0:2a2:5457:d34e with SMTP id
 c12-20020a17090ab28c00b002a25457d34emr8989805pjr.13.1713249326626; Mon, 15
 Apr 2024 23:35:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240322030208.3278120-1-liwang@redhat.com>
 <20240322050046.GA572447@pevik>
 <CAEemH2c3SNktFnPpsnbXvtTvfEv84byRrNmjcz3YyQHem9mcGg@mail.gmail.com>
 <20240322053217.GA588706@pevik>
 <CAEemH2fjNisDjZjRn60534rK1AHefbXPEUPS1FS0EA0OcfFrtQ@mail.gmail.com>
 <20240415152043.GA541530@pevik>
In-Reply-To: <20240415152043.GA541530@pevik>
From: Li Wang <liwang@redhat.com>
Date: Tue, 16 Apr 2024 14:35:14 +0800
Message-ID: <CAEemH2ev62JxH7-DA5Sc2LjMKrquYqt927ATHZefNPAOiXb5qA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3 1/2] libswap: add two methods to create swapfile
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

SGkgUGV0ciwKClRoYW5rcyBmb3IgcmVwb3J0aW5nIHRoaXMuCgpPbiBNb24sIEFwciAxNSwgMjAy
NCBhdCAxMToyMOKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PiB3cm90ZToKCj4gSGkg
TGksCj4KPiA+IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PiB3cm90ZToKPgo+ID4gPiA+IFRo
YW5rcywgSSB3b3VsZCBnaXZlIHRoZSBwYXRjaCBzZXQgbW9yZSB0aW1lIGluIGNhc2Ugb3RoZXJz
IGhhdmUKPiA+ID4gY29tbWVudHMuCj4KPiA+ID4gU3VyZS4gVGhhbmtzIGZvciBhIG5pY2Ugd29y
ayEKPgo+Cj4gPiBQYXRjaCBzZXQgYXBwbGllZC4KPgo+IEZZSSBpdCBsb29rcyBsaWtlIHRoaXMg
cGF0Y2ggbWVyZ2UgYXM6Cj4KPiBmOTg3ZmZmZjUgKCJsaWJzd2FwOiBhZGQgdHdvIG1ldGhvZHMg
dG8gY3JlYXRlIHN3YXBmaWxlIikKPgo+IGludHJvZHVjZWQgVFdBUk4gb24gYWxsIHRlc3RzIHdo
aWNoIHRvdWNoZWQ6IHN3YXBvZmYwWzEyXSwgc3dhcG9uMFsxLTNdIG9uCj4gb3BlblNVU0UgVHVt
Ymxld2VlZAo+IG9uIHBwYzY0bGUgKGUuZy4gdmVyeSBjbG9zZSB0byBtYWlubGluZSBzdGFibGUg
a2VybmVsczogNi44LngpLiBIYXZlIHlvdQo+IG5vdGljZWQKPiB0aGlzIG9uIEZlZG9yYSBhcyB3
ZWxsPyAgSSBob3BlIHRvIG1hbmFnZSB0byBoYXZlIGxvb2sgb24gaXQgc29vbiwgYnV0Cj4gbWF5
YmUKPiBpdCdzIG9idmlvdXMgdG8geW91IGFscmVhZHkuCj4KPiBsaWJzd2FwLmM6MTYzOiBUV0FS
TjogU3dhcGZpbGUgc2l6ZSBpcyBsZXNzIHRoYW4gdGhlIHN5c3RlbSBwYWdlIHNpemUuCj4gVXNp
bmcgcGFnZSBzaXplICg2NTUzNiBieXRlcykgaW5zdGVhZCBvZiBibG9jayBzaXplICg0MDk2IGJ5
dGVzKS4KPgoKWWVzLCB0aGF0IGlzIGV4cGVjdGVkIG9uIGEgc3lzdGVtIHdpdGggYSBsYXJnZXIg
cGFnZSBzaXplLCBzbyBpdCBjb3VsZApndWFyYW50ZWUgYXQgbGVhc3Qgb25lIHBhZ2UgY2FuIGJl
IHN3YXBwZWQgb3V0LgoKRG8geW91IHdhbnQgdG8gc3dpdGNoIHRvIHVzaW5nIFRJTkZPIGZvciB0
aGUgY2hvaWNlPyBUQkggaXQKZG9lc24ndCBtYXR0ZXIgdG8gcmVwb3J0IHRoYXQgV0FSTklORyBt
ZXNzYWdlLgoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0
dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
