Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F30CD11C2
	for <ltp@archiver.kernel.org>; Wed, 10 Apr 2024 08:45:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AF8AB3CF75B
	for <ltp@archiver.kernel.org>; Wed, 10 Apr 2024 10:45:16 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 32CB13CAB59
 for <ltp@lists.linux.it>; Wed, 10 Apr 2024 10:45:01 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2234514011B4
 for <ltp@lists.linux.it>; Wed, 10 Apr 2024 10:44:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712738698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GiKtabtvEDkcueC+l+CFCdwdB8I4kIOeCg0YdxPJhBY=;
 b=bC4XXDXszDimpDHCb8cZJbC0n5RiKl5E/xbSrEvW9s2d/Izq1OgajEoBY/ioL4BchNc1B0
 kNd+gYucNS+dNZ7EZX80ad0y61trjcF0xuLmDmNyIvkybn4WfbSzH7uYen35cEqXTNt4iW
 2bV8f7T/4tCpZisQcdYUPDq8vFCtOME=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355--2Se4Kv9Paqfpn_SndRAkQ-1; Wed, 10 Apr 2024 04:44:56 -0400
X-MC-Unique: -2Se4Kv9Paqfpn_SndRAkQ-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5ca5b61c841so5304485a12.3
 for <ltp@lists.linux.it>; Wed, 10 Apr 2024 01:44:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712738695; x=1713343495;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GiKtabtvEDkcueC+l+CFCdwdB8I4kIOeCg0YdxPJhBY=;
 b=TxkVJB8K1kMnuULa+l5A39wBy1EMhmVBVYN8mt3ji9HkpY7who/6waEgGxN+Vj4vNx
 xMky7LBEe55H1ATbTy85P9kfQ7hqw9EaTuGRJfv9kXcf+2Nl18gm3o7mAgOtDFeByZGT
 IlgypUfcWBFr1TrQMhkx/f8t/4/hkrfqv0ChMp6BjwpWIYXJrdxh5716xHYImjJWb1K5
 w4faZ9oqPhYZXrZQZOUYM/Vu4iJITSGcnLf0spjZkqG8R96Cvs4TgL1SyeZiY3FDisf/
 aOIRpn4LYtS7GiH6UtSkNYmOGKRizQGvuZ7wLi2m473IInyVsKjqEL3IMU5aLhFsae5q
 +iXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlWd+DsQl/+mtaglTftf6CDM4weJ4gggLRL6j4J2tvM6WKXvEfJfvPDrLNp4hahbJ4ErQ2L6kbwChACg4qmr/nNnE=
X-Gm-Message-State: AOJu0YxRmxuS83hgpyc32gFq86RsFHKIMX04VbNUfqajLP5P4Kv2RVyt
 REJgV8qtDgkICmx9nyTDu/+nNfFZDzs9F+WfH5G9L3GY0fVpk/Ekk8QpHRrXct7xGiVq08/ISE+
 PujwzBxYtIRguASlQo0s67pvE9lhivQ9vuYkJ1RAy6ZIOWNE0+r7ndkJsnnn3uyLfB4ous97ROO
 9m1p9BHM1ExKAjDXjpxlwzFkQ=
X-Received: by 2002:a05:6a20:1059:b0:1a3:57b4:ed1c with SMTP id
 gt25-20020a056a20105900b001a357b4ed1cmr1950492pzc.25.1712738695339; 
 Wed, 10 Apr 2024 01:44:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcxzMMAUn8IAttAuk0/yImXmC7qPXHHwk8+sfBucaXB4slcZVTqzrlhUukdxXmN+QmTsJ35Ht1z4VYA9grFvA=
X-Received: by 2002:a05:6a20:1059:b0:1a3:57b4:ed1c with SMTP id
 gt25-20020a056a20105900b001a357b4ed1cmr1950481pzc.25.1712738694967; Wed, 10
 Apr 2024 01:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240329180742.384709-1-gregory.price@memverge.com>
 <CAEemH2eZiJgM83z12eReH+2nrNiH9VkbK0F+iPk3sAZYhPoMRg@mail.gmail.com>
 <ZhXR7gdhKIFVEdvS@memverge.com>
In-Reply-To: <ZhXR7gdhKIFVEdvS@memverge.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 10 Apr 2024 16:44:43 +0800
Message-ID: <CAEemH2fSFBw92+3jHuCsMSg0R+8JvPpQwv2xBE9NaWFaNrrCCw@mail.gmail.com>
To: Gregory Price <gregory.price@memverge.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] mempolicy/mbind: update syscall tests for
 weighted interleave
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
Cc: ltp@lists.linux.it, Gregory Price <gourry.memverge@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgR3JlZ29yeSwKCk9uIFdlZCwgQXByIDEwLCAyMDI0IGF0IDc6NDDigK9BTSBHcmVnb3J5IFBy
aWNlIDxncmVnb3J5LnByaWNlQG1lbXZlcmdlLmNvbT4Kd3JvdGU6Cgo+IE9uIE1vbiwgQXByIDA4
LCAyMDI0IGF0IDAzOjQwOjM4UE0gKzA4MDAsIExpIFdhbmcgd3JvdGU6Cj4gPiBIaSBHcmVnb3J5
LAo+ID4KPiA+IFRoYW5rIHlvdSBmb3Igc3RhcnRpbmcgdGhpcywgY29tbWVudHMgYXJlIGlubGlu
ZSBiZWxvdy4KPiA+Cj4gPiA+ICsjZGVmaW5lIE1QT0xfV0VJR0hURURfSU5URVJMRUFWRSA2Cj4g
PiA+ICsjZW5kaWYKPiA+ID4KPiA+Cj4gPiBBbmQgY2FuIHdlIG1vdmUgdGhpcyBjb21tb24gcGFy
dCBpbnRvIGluY2x1ZGUvbGFwaS9udW1haWYuaCwKPiA+IHRvIGF2b2lkIGRlZmluaW5nIHRoaXMg
YWdhaW4gYW5kIGFnYWluIGluIHRlc3QgY2FzZXM/Cj4gPgo+Cj4gSSBoYXZlIGEgcGVuZGluZyBw
YXRjaCB0byBkbyBqdXN0IHRoYXQsIGJ1dCBpdCBpcyBub3QgdXBzdHJlYW0geWV0Lgo+Cj4gVGhp
cyB3YXMgYSBjb21tZW50IGluIHRoZSBjaGFuZ2Vsb2c6Cj4KPiA+ID4gTVBPTF9XRUlHSFRFRF9J
TlRFUkxFQVZFIGlzIGlmZGVmIGRlZmluZWQgYmVjYXVzZSBpdCBpcyBub3QgdXBzdHJlYW0KPiA+
ID4gaW4gbGlibnVtYSB5ZXQsIHNvIHRoaXMgZW5zdXJlcyBjb21waWxhdGlvbi4KPgo+IFRob3Vn
aHQgaXQgd2FzIHVzZWZ1bCB0byBzaG9vdCBvdXQgYSB2ZXJzaW9uIG9mIHRoaXMgYmVmb3JlIGl0
IGFsbCBsYW5kcwo+IGZvciB0aGUgc2FrZSBvZiBnZXR0aW5nIGFoZWFkIG9mIHRoZSBjdXJ2ZSBh
IGJpdC4KPgo+ID4KPiA+IEZpcnN0LCB3ZSBkbyBub3Qgc3VnZ2VzdCBhZGRpbmcgYW55IG5ldyB0
ZXN0cyBieSBhcHBseWluZyBvbmUgImJpZyIKPiA+IHBhdGNoIGVzcGVjaWFsbHkgc2luY2UgdGhp
cyBjb250YWlucyB0b28gbWFueSBvdGhlciBpcnJlbGV2YW50Cj4gPiBtb2RpZmljYXRpb25zLgo+
ID4gV2UnZCBiZXR0ZXIgc2VwYXJhdGUgdGhlbSBpbiBzaW5nbGUgdG8gZ3VhcmFudGVlIGV2ZXJ5
dGhpbmcgZ29lcwo+ID4gd2VsbCBmb3IgdHJhY2VhYmlsaXR5IG9mIHRoZSBjb21taXQuCj4gPgo+
Cj4gV2lsbCBkby4KPgo+ID4gU2Vjb25kLCBJIGRvbid0IHNlZSBhbnkgbmV3IGNvZGUgaW4gc2V0
X21lbXBvbGljeTA2LzA3LCBzaW5jZSB5b3UKPiA+IG9ubHkgY29waWVkIHRoZW0gZnJvbSBzZXRf
bWVtcG9saWN5MDIvMDQsIGV2ZW4gd2l0aG91dCBhbnkgY2hhbmdlIG9mIHRoZQo+ID4gY29tbWVu
dHMsIHRoaXMgaXMgYmFkIGZvciB0ZXN0IG1haW50ZW5hbmNlIHdvcmsgYW5kIGludm9sdmVzIHJl
ZHVuZGFudAo+ID4gc3R1ZmYuCj4gPgo+Cj4gdGhlIG9ubHkgbWFqb3IgZGlmZmVyZW5jZXMgYmV0
d2VlbiB0aGUgdGVzdHMsIHByZXNlbnRseSwgYXJlIHRoYXQgdGhlCj4gcG9saWN5IGFwcGxpZWQg
aXMgd2VpZ2h0ZWQgaW50ZXJsZWF2ZQo+Cj4gVEVTVChzZXRfbWVtcG9saWN5KE1QT0xfV0VJR0hU
RURfSU5URVJMRUFWRSwgYm0tPm1hc2twLCBibS0+c2l6ZSsxKSk7Cj4gICAgICAgICAgICAgICAg
ICAgIF5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXgo+Cj4gSW4gdHJ1dGgsIHRoaXMgdGVzdCBpc24n
dCByZWFsbHkgY29tcGxldGVseSwgYXMgaXQgc2hvdWxkIGFsc286Cj4KPiAxKSBTZXQgdGhlIHN5
c2ZzIHZhbHVlcyBsb2NhdGVkIGF0Cj4gL3N5cy9rZXJuZWwvbW0vbWVtcG9saWN5L3dlaWdodGVk
X2ludGVybGVhdmUvCj4KPiAyKSBWYWxpZGF0ZSBhbGxvY2F0aW9ucyBhY3R1YWxseSBtYXRjaCB0
aG9zZSBzZXR0aW5ncwo+Cj4gSG93ZXZlciwgdGhpcyB0ZXN0IGlzIHF1aXRlIGNvbXBsaWNhdGVk
IHRvIHdyaXRlIGFuZCBtYWtlIGZ1bGx5Cj4gcmVsaWFibGUsIGFzIHlvdSBhbHNvIG5lZWQgdG8g
a25vdwo+Cj4gMSkgVGhlIGVudmlyb25tZW50IChhdmFpbGFibGUgbm9kZXMsIGNwdSBub2Rlcywg
bWVtb3J5LW9ubHkgbm9kZXMpCj4gMikgVGhlIG5vZGUgdGhlIHRlc3Qgd2lsbCBiZSBydW4gb24g
KHdoaWNoIGNhbiBiZSBmb3JjZWQpCj4gMykgV2hlcmUgYWxsb2NhdGlvbnMgd2lsbCBzdGFydCBm
cm9tIChub2RlIFggb3Igbm9kZSBZKSBhcyB0aGlzIGNhbgo+ICAgIHVsdGltYXRlbHkgYWZmZWN0
IHRoZSBmaW5hbCBkaXN0cmlidXRpb24uCj4KPiBJbiBteSB0ZXN0cyBzZXBhcmF0ZWx5LCB0aGUg
dGVzdCBpdHNlbGYgY2FuIGFsc28gY2F1c2UgYWxsb2NhdGlvbgo+IChzdGFjaywgb3RoZXIgcmVn
aW9ucykgd2hpY2ggbWF5IHJlc3VsdCBpbiBhbiB1bmV4cGVjdGVkIGRpc3RyaWJ1dGlvbiBvZgo+
IG1lbW9yeSBvbiB0aGUgdGFyZ2V0IHJlZ2lvbi4gIFRoaXMgaXMgYmVjYXVzZSB0aG9zZSBhbGxv
Y2F0aW9ucyBhcmUKPiBjcmVkaXRlZCBhcyBwYXJ0IG9mIHRoZSBpbnRlcmxlYXZpbmcsIGJ1dCB0
aGUgZXhpc3RpbmcgY29kZSBvZiB0aGUgdGVzdAo+IGNhbm5vdCBhZGp1c3QgZm9yIHRoYXQuIFRo
aXMgbWF5IGNhdXNlIGZhaWx1cmVzIGZvciBubyBvYnZpb3VzIHJlYXNvbi4KPgo+IFRoaXMgaXMg
dWx0aW1hdGVseSB3aHkgSSBsZWZ0IHRoZSB0ZXN0cyBtb3N0bHkgdW5jaGFuZ2VkLCBiZWNhdXNl
IEkKPiBmb3VuZCBpdCBvbmx5IHJlYXNvbmFibGUgdG8gdGVzdCB0aGUgZGVmYXVsdCBiZWhhdmlv
ci4KPgo+ID4gVGhlIHJlY29tbWVuZGVkIHdheSBpcyB0byBhZGQgTVBPTF9XRUlHSFRFRF9JTlRF
UkxFQVZFIGluCj4gPiB0aGUgb3JpZ2luYWwgY2FzZSBpZiB5b3UganVzdCB3YW50IHRvIHZhbGlk
YXRlIHRoZSBiZWhhdmlvciBzaW1pbGFybHkKPiB3aXRoCj4gPiBNUE9MX0lOVEVSTEVBVkUuCj4g
Pgo+ID4gQnV0IGlmIHlvdSB3YW50IHRvIHRlc3Qgc29tZXRoaW5nIHNwZWNpYWwvbmV3IG9mCj4g
TVBPTF9XRUlHSFRFRF9JTlRFUkxFQVZFLAo+ID4gSSB0aGluayB0aGF0J3MgbmVjZXNzYXJ5IHRv
IGNyZWF0ZSBzZXRfbWVtcG9saWN5MDYvMDcsIGFuZCBkbyBzb21ldGhpbmcKPiA+IHZhbGlkYXRl
IHRoYXQgaW50ZXJsZWF2aW5nIGJlaGF2aW9yIGlzIGV4ZWN1dGVkIGJhc2VkIG9uIHdlaWdodHMg
c2V0IGluICcKPiA+IC9zeXMva2VybmVsL21tL21lbXBvbGljeS93ZWlnaHRlZF9pbnRlcmxlYXZl
LycuCj4gPgo+Cj4gV2FzIGhvcGluZyB0byBnZXQgaW5wdXQgb24gdGhpcy4gIEkgdGhpbmsgcHJv
YmFibHkgdHJ5aW5nIHRvIHdyaXRlIGEKPiB0ZXN0IHRvIHRyYWNrIHBhZ2UtZGlzdHJpYnV0aW9u
IG9mIHJlYWwgd2VpZ2h0ZWQgaW50ZXJsZWF2ZSB3aWxsIGJlCj4gZGlmZmljdWx0IHRvIG1ha2Ug
cmVsaWFibGUsIHNvIG1heWJlIEkgc2hvdWxkIGp1c3QgZm9sZCB0aGVzZSB0ZXN0cyBiYWNrCj4g
aW50byB0aGUgb3JpZ2luYWwgYW5kIG5vdGUgdGhhdCB0aGlzIHNpbXBseSB0ZXN0cyB0aGUgZGVm
YXVsdCBiZWhhdmlvcgo+ICh3aGljaCBpcyBlcXVpdmFsZW50IHRvIE1QT0xfSU5URVJMRUFWRSku
Cj4KCk9rLCBzdXJlLiBJZiBzbyBtZXJnZSB0aGUgTVBPTF9XRUlHSFRFRF9JTlRFUkxFQVZFIGlu
dG8KTVBPTF9JTlRFUkxFQVZFIHRlc3Qgc2hvdWxkIGJlIGVub3VnaC4KCgoKPgo+IFRoYXQgbWF5
IHJlcXVpcmUgY2hhbmdpbmcgdGhlIG9yaWdpbmFsIHRlc3RzIHRvIGVuc3VyZSB0aGUgc3lzZnMg
ZmlsZXMKPiBhcmUgc2V0IHRvIDEgdG8gZXhwbGljaXRseSBhdm9pZCBmYWlsdXJlcy4gIEJ1dCBJ
IHdhc24ndCBzdXJlIGlmIHRoYXQKPiB3YXMgb2sgc2luY2UgaXQgd291bGQgYmUgbWFraW5nIHNp
bGVudCBzeXN0ZW0td2lkZSBjaGFuZ2VzLCBhbmQgd291bGQKPiByZXF1aXJlIHJvb3QuCj4KCkxU
UCBsaWIgcHJvdmlkZXMgYSB3YXkgdG8gc2F2ZS9yZXN0b3JlIHRoZSAnL3Byb2MgfCAvc3lzJyB2
YWx1ZQpiZWZvcmUgYW5kIGFmdGVyIGRvaW5nIHRoZSB0ZXN0LCBzbyBpdCB3b3VsZCBub3QgYmUg
ZGlmZmljdWx0IHRvCnNhdGlzZnkgdGhlIHJlcXVpcmVtZW50IGlmIGl0IGlzIGp1c3Qgc2V0IDEg
dG8gYSByZWxhdGl2ZSBmaWxlLgoKc2VlOgpodHRwczovL2dpdGh1Yi5jb20vbGludXgtdGVzdC1w
cm9qZWN0L2x0cC9ibG9iL21hc3Rlci9kb2Mvb2xkL0MtVGVzdC1BUEkuYXNjaWlkb2MjMTI3LXNh
dmluZy0tcmVzdG9yaW5nLXByb2NzeXMtdmFsdWVzCgpPciwgdXNlIHRzdF9zeXNfY29uZl9zYXZl
KCkgc2VwYXJhdGVseSB0byB0cmF2ZXJzZSBhbmQgc2F2ZSB0aGUgdmFsdWUgb2YKIm1lbXBvbGlj
eS93ZWlnaHRlZF9pbnRlcmxlYXZlL25vZGUqIiBmaWxlIGlmIHdlIGFyZSB1bnN1cmUgaG93IG1h
bnkgbm9kZXMKYXJlIG9uIHRoZSBzeXN0ZW0sIHRoZW4gc2V0IHRoZSB2YWx1ZSB2aWE6CiAgICBT
QUZFX0ZJTEVfUFJJTlRGKCIuLi93ZWlnaHRlZF9pbnRlcmxlYXZlL25vZGUqIiwgIiVkIiwgMSk7
ClVsdGltYXRlbHksIExUUCBsaWIgd2lsbCByZXN0b3JlIGFsbCBvZiB0aGUgdmFsdWVzIHRvIHRo
ZSBvcmlnaW5hbC4KCkFuZCBzZXQgIi5uZWVkc19yb290ID0gMSwiIGluIHRoZSBzdHJ1Y3QgdHN0
X3Rlc3Qgd2lsbCBiZSB0aGUgcmVxdWVzdGVkCnJvb3QgcGVybWlzc2lvbi4KCgotLSAKUmVnYXJk
cywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0
L2xpc3RpbmZvL2x0cAo=
