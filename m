Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC98C27C53
	for <ltp@archiver.kernel.org>; Thu, 20 Jun 2024 01:46:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C1423D0DFA
	for <ltp@archiver.kernel.org>; Thu, 20 Jun 2024 03:46:19 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 86F033CE037
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 03:46:04 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6E7A11A00691
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 03:46:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718847961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bjZdsAnkALj3hHwbdAYeWs9J/Vn17UHCj1rQblQmPl8=;
 b=VdUB1aVz90xa3vRdIUbap4JA7SAghLSq19CXk3iG2+68f1i6gljR4a3ucla1o8LQp3UIKm
 S0bqueXlEERe6g5/l1XzDxdUa2ngeM0S6uo8X4tC5MMBhOIiSc0PuH+pkO3Vgez8V1GPgc
 lwF68ZAWduQtdzwyCTOumVjHbvbeRgQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-VOD0IrzaOA2kY33cv7a3Lw-1; Wed, 19 Jun 2024 21:45:59 -0400
X-MC-Unique: VOD0IrzaOA2kY33cv7a3Lw-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2c4b0f01581so466122a91.2
 for <ltp@lists.linux.it>; Wed, 19 Jun 2024 18:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718847958; x=1719452758;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bjZdsAnkALj3hHwbdAYeWs9J/Vn17UHCj1rQblQmPl8=;
 b=wPq5GT45aaJc8eDJZdRlJPWWBSuyYgigWJIMzFCoDcsosp798+ulZyQtIvy20d0ASI
 So3vApgW/ytwOuBdO8fAl94vdJSLB5Y6ZYKFtmUzcNyqr0IspLOMqkOKw5QImaQHgUbU
 QQxJeU6GG7jkc7n54u6/owc4fSQCrkVPQ2DnBT0PTpeyGiPQTg0zz50XL7pgvJOC2Xe5
 2A3bRI0n9858uKgAJqvwiTHem5iS9XyD/FYUJuVjImzPPumd7uLJ4H+RU7E/r5JLVYWv
 y1ph/WFYJcciKKFWNH0oo5+tYbMgBUFDdAmCga2MJIGViVQmXJsbB7jC0zDyBhKJ1Djt
 T7XA==
X-Gm-Message-State: AOJu0YyeDk5wMv9SIOWmHLuXUCPy3YRRtJgoyxbLL26YWlF2IspZvoDr
 0jxj7neROgKrZgLdeOxgLmZmITeYNIAB8nwBqqZRShhkUrD9BHK2zV81T7rJBOzMssUNT4SIAx6
 4xWuzzqc7C4/UF9wWXlNG1mVdLfcP639cLuGKWIMAkwwsVApRXqRfzVSrMKbtr3KHpa9sg2rXij
 n1rGCvAFjgjEfIUpFyMdfTMLuDBUTZwq/zzQ==
X-Received: by 2002:a17:90b:1081:b0:2c2:daf5:4192 with SMTP id
 98e67ed59e1d1-2c7b5d79adamr3865021a91.32.1718847957711; 
 Wed, 19 Jun 2024 18:45:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr/JrlvPjSJiQ7fGwuQYOfeQOfgkoBMUerVyZ+0eY0pLsYT0SlMxAAWyF95vM5JeAfPo54jQ/YhH1VMXGoEHA=
X-Received: by 2002:a17:90b:1081:b0:2c2:daf5:4192 with SMTP id
 98e67ed59e1d1-2c7b5d79adamr3865013a91.32.1718847957380; Wed, 19 Jun 2024
 18:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240619073345.326108-1-liwang@redhat.com>
 <20240619074703.GA410266@pevik>
 <CAEemH2d3gVj+cSvVc6-Qvj4CxhBO4pVnqfouYBg03myH+S87mw@mail.gmail.com>
 <20240619133058.GA457380@pevik>
In-Reply-To: <20240619133058.GA457380@pevik>
From: Li Wang <liwang@redhat.com>
Date: Thu, 20 Jun 2024 09:45:45 +0800
Message-ID: <CAEemH2fCgxdUJdwcAaJahseTmFsq8tdT8qJ5HK+qPNpp2reqBQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] tst_kconfig: Avoid buffer overflow when parsing
 /proc/cmdline
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

SGkgUGV0ciwKCk9uIFdlZCwgSnVuIDE5LCAyMDI0IGF0IDk6MzLigK9QTSBQZXRyIFZvcmVsIDxw
dm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+IEhpIExpLAo+Cj4gPiBPbiBXZWQsIEp1biAxOSwgMjAy
NCBhdCAzOjQ34oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgo+Cj4gPiA+
ID4gV2hlbiB0aGUgdGVzdCBpcyBydW4gd2l0aCBhIGtlcm5lbCBib290aW5nIHdpdGggbWFueSBw
YXJhbWV0ZXJzLCB0aGUKPiA+ID4gPiBidWZmZXIgc2l6ZSBpcyBvZnRlbiBub3QgbGFyZ2UgZW5v
dWdoIHRvIHN0b3JlIHRoZSBjb21wbGV0ZSBjb21tYW5kCj4gPiA+ID4gbGluZS4gVGhpcyByZXN1
bHRzIGluIGEgYnVmZmVyIG92ZXJmbG93IGFuZCB0aGUgdGVzdCBjb21wbGFpbnMgd2l0aAo+ID4g
PiA+IHRoZSBmb2xsb3dpbmcgbWVzc2FnZToKPgo+ID4gPiA+ICAgdHN0X2tjb25maWcuYzo2MDk6
IFRXQVJOOiBCdWZmZXIgb3ZlcmZsb3dlZCB3aGlsZSBwYXJzaW5nCj4gL3Byb2MvY21kbGluZQo+
Cj4gPiA+IFRoYW5rcyBmb3IgdGhlIGZpeCEKPgo+ID4gPiBSZXZpZXdlZC1ieTogUGV0ciBWb3Jl
bCA8cHZvcmVsQHN1c2UuY3o+Cj4gPiA+IEZpeGVzOiAxODA4MzQ5ODIgKCJrY29uZmlnOiBhZGQg
ZnVudGlvbiB0byBwYXJzZSAvcHJvYy9jbWRsaW5lIikKPgo+ID4gPiBOT1RFIHRzdF9rY29uZmln
X3JlYWQoKSBoYXMgY2hhciBsaW5lWzEyOF0sIGFsc28gc3RydWN0Cj4gdHN0X2tjbWRsaW5lX3Zh
cgo+ID4gPiBtZW1iZXIKPgo+Cj4gPiBUeXBpY2FsbHkgMTI4IGlzIGxvbmcgZW5vdWdoIGZvciBM
aW51eCBrZXJuZWwgcGFyYW1ldGVycywgb3RoZXJ3aXNlIGl0Cj4gaGFyZAo+ID4gZm9yIHBlb3Bs
ZSB0byBtZW1vcml6ZSB0aGUgbmFtZSBhbmQgdmFsdWUuCj4KPiBTdXJlLCBsZXQncyBrZWVwIGl0
IGZvciBub3csIGJ1dCBleGFtcGxlcyB3ZSBhcmUgZ2V0dGluZyBjbG9zZSA6KS4gU29vbmVyCj4g
b3IKPiBsYXRlciB0aGVzZSBjb25maWdzLCB3aGljaCBhcmUgZ2VuZXJhdGVkIGJ5IHRvb2xjaGFp
biB3aWxsIGJlIGxvbmdlciB0aGFuCj4gMTI4Cj4gY2hhcnM6Cj4KPiAkIGF3ayAnbGVuZ3RoID4g
bWF4X2xlbmd0aCB7IG1heF9sZW5ndGggPSBsZW5ndGg7IGxvbmdlc3RfbGluZSA9ICQwIH0gRU5E
Cj4geyBwcmludCBsb25nZXN0X2xpbmUgfScgL2Jvb3QvY29uZmlnKgo+IENPTkZJR19DQ19WRVJT
SU9OX1RFWFQ9ImdjYyAoU1VTRSBMaW51eCkgMTMuMi4xIDIwMjQwMjA2IFtyZXZpc2lvbgo+IDY3
YWM3OGNhZjMxZjdjYjMyMDIxNzdlNjQyOGE0NmQ4MjliNzBmMjNdIgo+Cj4gJCBhd2sgJ2xlbmd0
aCA+IG1heF9sZW5ndGggeyBtYXhfbGVuZ3RoID0gbGVuZ3RoOyBsb25nZXN0X2xpbmUgPSAkMCB9
IEVORAo+IHsgcHJpbnQgbG9uZ2VzdF9saW5lIH0nIC9ib290L2NvbmZpZyogfCB3YyAtTAo+IDEw
OQo+Cj4gSSB3YXMgc3VycHJpc2VkIGV2ZW4gcmVhbCBjb25maWcgb3B0aW9uIHdhcyBxdWl0ZSBs
b25nOgo+Cj4gJCBhd2sgJ2xlbmd0aCA+IG1heF9sZW5ndGggeyBtYXhfbGVuZ3RoID0gbGVuZ3Ro
OyBsb25nZXN0X2xpbmUgPSAkMCB9IEVORAo+IHsgcHJpbnQgbG9uZ2VzdF9saW5lIH0nIC9ib290
L2NvbmZpZyoKPgo+IENPTkZJR19MU009ImxhbmRsb2NrLGxvY2tkb3duLHlhbWEsbG9hZHBpbixz
YWZlc2V0aWQsaW50ZWdyaXR5LGFwcGFybW9yLHNlbGludXgsc21hY2ssdG9tb3lvLGJwZiIKPgo+
ICQgYXdrICdsZW5ndGggPiBtYXhfbGVuZ3RoIHsgbWF4X2xlbmd0aCA9IGxlbmd0aDsgbG9uZ2Vz
dF9saW5lID0gJDAgfSBFTkQKPiB7IHByaW50IGxvbmdlc3RfbGluZSB9JyAvYm9vdC9jb25maWcq
IHwgd2MgLUwKPiA5Nwo+Cj4gPiA+IGhhcyB0aGlzIGxlbmd0aC4gVGhlIGxvbmdlc3QgbGluZSBv
biBzb21lIG9uIG15IHN5c3RlbXMgaXMgMTA5LCBpdCdzCj4gc3RpbGwKPiA+ID4gT0ssCj4gPiA+
IGhvcGVmdWxseSBpdCBzdGF5cyA6KS4KPgo+Cj4gPiBIbW0sIGdvb2QgcG9pbnQuIEFmdGVyIHRo
aW5raW5nIGl0IG92ZXIsIHNlZW1zIHRvbyBoYXN0eSB0byBlbmxhcmdlIHRoZQo+ID4gYnVmW10g
c2l6ZSB0byA1MTIuCj4KPiA+IFdlJ2QgYmV0dGVyIGtlZXAgdGhlIHNpemUgc2FtZSBiZXR3ZWVu
ICd0c3Rfa2NtZGxpbmVfdmFyLnZhbHVlJyB0byB0aGUKPiA+IGxvY2FsICdidWZbXScuCj4gKzEu
IEkgd291bGQgZXZlbiBkZWZpbmUgYSBjb25zdGFudCB0byBrZWVwIHRoZXNlIDIgc2l6ZXMgdGhl
IHNhbWUuCj4KPiA+IEFuZCB0aGUgb3ZlcmZsb3cgaXMgbm90IGEgcHJvYmxlbSwgaXQganVzdCBk
cm9wcyBzb21lIHVudXNlZCBpbmZvWzFdIHRvCj4gPiByZWxvb3AgdG8KPiA+IHRoZSBoZWFkIGZv
ciBzYXZpbmcgb3VyIHRhcmdldCBwYXJhbWV0ZXIuCj4KPiA+IFsxXQo+IEJPT1RfSU1BR0U9KGhk
MCxncHQyKS9vc3RyZWUvY2VudG9zLWRkNzQxNWVkMmM3Y2MzZjY1YmRjNGJmOGY5YTYzYjk1YmJi
MTNlZTBmZWU2MzNmNmI5MmE4NzI5NDRkMWQ2ZTQvdm1saW51ei01LjE0LjAtNHh4LjR4eC40NDk1
XzEzMzY1ODM5NDQuZWw5aXYueDg2XzY0Cj4KPiBBaCwgd2hhdCBhIGxvbmcgcGFyYW1ldGVyIDop
LiBPVE9IIHdvdWxkIGl0IGhhcm0gdG8gZW5sYXJnZSBib3RoIHRvIDI1NiBvcgo+IGV2ZW4KPiA1
MTI/Cj4KClllcywgYnV0IHRvIGJlIGhvbmVzdCwgd2UgYWx3YXlzIGRvbid0IGNhcmUgYWJvdXQg
dGhhdCBsb25nIHBhcmFtZXRlciwKYW5kIG1vc3RseSwgcGVvcGxlIGp1c3QgcGFyc2Ugc29tZXRo
aW5nIHRoZXkgcGFzcyBpbnRvIHRoZSBrZXJuZWwsCml0IGlzIGFsd2F5cyBzaG9ydCBhbmQgcG9w
dWxhci4KClNvIEkgYmVsaWV2ZSByYWlzZSB0byAyNTYgaXMgZW5vdWdoIHNpemUgZm9yIExUUC4K
CgoKPgo+ID4gSSdtIHRoaW5raW5nIG9mIGxvd2VyaW5nIHRoZSBwcmlvcml0eSBpbmZvIGZyb20g
VFdBUk4gdG8gVElORk8gaW4gdGhhdAo+IGxpbmU6Cj4gPiAgICAgdHN0X3JlcyhUV0FSTiwgIkJ1
ZmZlciBvdmVyZmxvd2VkIHdoaWxlIHBhcnNpbmcgL3Byb2MvY21kbGluZSIpOwo+Cj4gWWVzLCBi
dXQgYXJlIHlvdSBzdXJlIHRoYXQgb2NjYXNpb25hbCBsb25nIHBhcmFtZXRlciB3aWxsIGJlIGFs
d2F5cwo+IGlycmVsZXZhbnQ/Cj4gSSdkIHJlYWxseSBpbmNyZWFzZSB0aGUgc2l6ZS4KPgoKSSBn
dWVzcyB5ZXMsIGF0IGxlYXN0IHNvIGZhciBJIGRvbid0IHNlZSBhbnkgTFRQIHRlc3QgcGFyc2Ug
bG9uZyBwYXJhbWV0ZXJzLAppdCBpcyBzYWZlIHRvIGRyb3AgdGhlbSBJTUhPLgoKLS0gClJlZ2Fy
ZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5p
dC9saXN0aW5mby9sdHAK
