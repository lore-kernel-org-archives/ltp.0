Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA73DCDB483
	for <ltp@archiver.kernel.org>; Fri, 13 Oct 2023 13:28:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 49E023CD3E9
	for <ltp@archiver.kernel.org>; Fri, 13 Oct 2023 15:28:43 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 434B03C6BD3
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 15:28:32 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 17F131A01983
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 15:28:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697203709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dSj7KLOgPcZFx1FW/nCR7Bdobt7dy28fg/0glkDq3XI=;
 b=hSeLi21rvd/TEwbnQ61sJb33CTV0fr3awN7klUHhb5lNPYf+J2w0DXMuGQQhsdL6+tSDfM
 dvNAUSK+H//6Um8qOGNW/A/7s/5ELvT8D6dVvNgJ1lfkSQp4+U9EpzfbEpmjBYro7rUkij
 UVb5NpfxZW8hfZB3cRsBT5C5x4ZFHmI=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-u8QDOTHXO7OeRJQJOHYrYQ-1; Fri, 13 Oct 2023 09:28:13 -0400
X-MC-Unique: u8QDOTHXO7OeRJQJOHYrYQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5056cc81e30so1992465e87.0
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 06:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697203691; x=1697808491;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dSj7KLOgPcZFx1FW/nCR7Bdobt7dy28fg/0glkDq3XI=;
 b=rw4SqObeSYcymfH2ekSlBeMwJcqEmPMv98zvupmwo1GOvqFUPb5jdQKFsTANGM4Hop
 en9Lvnb2Oqe4lqDdsatk0BT2BP6ZhCGsPaKIdGncFCoGmmvG4tz4gwMRDSwhIDwNyEee
 yNm1Kq3pnUEIPH3vJSiB8lNHNSDdGCPZd1QtxWa/twmtFzqS3XLk7iTBy3HRVaKhwl9y
 iHNJ7j5pkpLvTOJiKOQGapoiVvXXlnDYEdf6HA1pKNg7SSbvuJ9tLJKTpURAkXDZxDX3
 FCInZ591l4NrpVlqqJhsTgDmy/YTaDhZOPX8s+olhhwjQ43PvthcB/qFQSLw36ADp1Nr
 OwtQ==
X-Gm-Message-State: AOJu0YzHC/rGVBIlzaE5kVAEFYktXhgMvGuDOZCQAML7K3GI1e3P6PI9
 WyOPZPgHRO2OqM09aq6zzJd0d0c+hNjsoK6lQbJL4J/4VqxJAL/SDsu0y0vYMtlcwYMPYEMSlnR
 TFXwcu9VXWR8tGYRUQsoY5CzPSYUb6tiNPXcHdTVV
X-Received: by 2002:a05:6512:304b:b0:500:9969:60bf with SMTP id
 b11-20020a056512304b00b00500996960bfmr24717678lfb.68.1697203690863; 
 Fri, 13 Oct 2023 06:28:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMu3wEMD4g2d8MC7ykh/z6SqpyaIRud981qIKeJQhHUEa9HowZKoHc8BQdYo93V6Nn6SUXLW/SW4KOL2D7ZGM=
X-Received: by 2002:a05:6512:304b:b0:500:9969:60bf with SMTP id
 b11-20020a056512304b00b00500996960bfmr24717668lfb.68.1697203690467; Fri, 13
 Oct 2023 06:28:10 -0700 (PDT)
MIME-Version: 1.0
References: <20231013074748.702214-1-pvorel@suse.cz>
 <20231013074748.702214-3-pvorel@suse.cz>
 <20231013123056.GC733568@pevik>
In-Reply-To: <20231013123056.GC733568@pevik>
From: Li Wang <liwang@redhat.com>
Date: Fri, 13 Oct 2023 21:27:58 +0800
Message-ID: <CAEemH2es0i-=V5W=2ZhZnN7OOq9BnFkkkSPyU1EUDWj0XHu1WA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 2/4] lib: Add .modprobe
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

T24gRnJpLCBPY3QgMTMsIDIwMjMgYXQgODozMeKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgYWxsLAo+Cj4gbWF5YmUgLm1vZHByb2JlIGlzIHRvbyBzaG9ydCBu
YW1lLCBidXQgSSdtIG5vdCBzdXJlIHdoYXQgd291bGQgYmUgYmV0dGVyLgo+IE1heWJlIC5tb2Rw
cm9iZV9tb2R1bGUgPwo+CgoubW9kcHJvYmVfbW9kdWxlIHNvdW5kcyBiZXR0ZXIuCgpBbHNvLCBJ
IHRoaW5rIHRoYXQgbWF5YmUgd2UgY2FuIHN1cHBvcnQgbW9kcHJvYmUgc29tZQp0aGlyZC1wYXJ0
eSBtb2R1bGVzICh3cml0dGVuIGJ5IHVzZXJzKSBpbiB0ZXN0IGNhc2UsIHRoZXJlIGFyZQphIGZl
dyBtYW5hZ2VkIGJ5IHNoZWxsIHNjcmlwdHMsIGJ1dCBpZiAubW9kcHJvYmVfbW9kdWxlCm1hbmFn
ZXMgdGhlbSB1bmlmeSBpbiBDLCBpdCB3b3VsZCBiZSBuaWNlIGZvciB0ZXN0IHZhcmlldHkuCgoK
Cj4KPiAuLi4KPiA+ICsrKyBiL2RvYy9DLVRlc3QtQVBJLmFzY2lpZG9jCj4gPiBAQCAtMTYwOSw2
ICsxNjA5LDExIEBAIGZpcnN0IG1pc3NpbmcgZHJpdmVyLgo+ID4gIFRoZSBkZXRlY3Rpb24gaXMg
YmFzZWQgb24gcmVhZGluZyAnbW9kdWxlcy5kZXAnIGFuZCAnbW9kdWxlcy5idWlsdGluJwo+IGZp
bGVzCj4gPiAgZ2VuZXJhdGVkIGJ5IGttb2QuIFRoZSBjaGVjayBpcyBza2lwcGVkIG9uIEFuZHJv
aWQuCj4KPiA+ICtOVUxMIHRlcm1pbmF0ZWQgYXJyYXkgJy5tb2Rwcm9iZScgb2Yga2VybmVsIG1v
ZHVsZSBuYW1lcyBhcmUgdHJpZWQgdG8KPiBiZSBsb2FkZWQKPiA+ICt3aXRoICdtb2Rwcm9iZScg
dW5sZXNzIHRoZXkgYXJlIGJ1aWx0aW4gb3IgYWxyZWFkeSBsb2FkZWQuIFRlc3QgZXhpdHMKPiB3
aXRoCj4gPiArJ1RDT05GJyBvbiBmaXJzdCAnbW9kcHJvYmUnIG5vbi16ZXJvIGV4aXQuIER1cmlu
ZyBjbGVhbnVwIGFyZSB0aGUKPiBtb2R1bGVzCj4gPiArbG9hZGVkIGJ5IHRoZSB0ZXN0IHVubG9h
ZGVkIHdpdGggJ3JtbW9kJy4KPgo+IC4uLgo+Cj4gPiArICAgICBpZiAodHN0X3Rlc3QtPm1vZHBy
b2JlKSB7Cj4gPiArICAgICAgICAgICAgIGNvbnN0IGNoYXIgKm5hbWU7Cj4gPiArICAgICAgICAg
ICAgIGludCBpOwo+ID4gKwo+ID4gKyAgICAgICAgICAgICBmb3IgKGkgPSAwOyAobmFtZSA9IHRz
dF90ZXN0LT5tb2Rwcm9iZVtpXSk7ICsraSkgewo+ID4gKyAgICAgICAgICAgICAgICAgICAgIC8q
IG9ubHkgbG9hZCBtb2R1bGUgaWYgbm90IGFscmVhZHkgbG9hZGVkICovCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgaWYgKCFtb2R1bGVfbG9hZGVkKG5hbWUpICYmCj4gdHN0X2NoZWNrX2J1aWx0
aW5fZHJpdmVyKG5hbWUpKSB7Cj4KPiBBbHNvIHdlIGNvdWxkIG1ha2UgaXQgaW5kZXBlbmRlbnQg
b24gbW9kdWxlcy5idWlsdGluIChOaXhPUyBiYXNlZCBwcm9ibGVtIC0KPiBtaXNzaW5nIHRoZXNl
IGZpbGVzKS4gSS5lLiB3ZSB3b3VsZCBrZWVwIG9ubHkgbW9kdWxlX2xvYWRlZCgpLCByZW1vdmUK
PiB0c3RfY2hlY2tfYnVpbHRpbl9kcml2ZXIoKS4gQnV0IHRoZW4gd2UgY291bGQgbm90IHJ1biBy
bW1vZCAvIG1vZHByb2JlIC1yLAo+IG9yIHdlIHdvdWxkIGhhdmUgdG8gaWdub3JlIGl0J3MgZXhp
dCBjb2RlIChybW1vZCBvbiBidWlsdGluIG1vZHVsZSkgZmFpbHMuCj4KCk9yIHdlIGFkZCBvbmUg
c3RlcCB0byBkZXRlY3QgbW9kdWxlcy5idWlsdGluIGZpbGUsIGlmIG5vLAp0aGVuIGp1c3QgcHJp
bnQgYSBXYXJuaW5nIGF0IHVubG9hZCBpbiBmYWlscz8KCgoKPgo+IEtpbmQgcmVnYXJkcywKPiBQ
ZXRyCj4KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IGNoYXIgKmNvbnN0
IGNtZF9tb2Rwcm9iZVtdID0KPiB7Im1vZHByb2JlIiwgbmFtZSwgTlVMTH07Cj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBTQUZFX0NNRChjbWRfbW9kcHJvYmUsIE5VTEwsIE5VTEwp
Owo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbW9kdWxlc19sb2FkZWRbaV0gPSAx
Owo+ID4gKyAgICAgICAgICAgICAgICAgICAgIH0KPiA+ICsgICAgICAgICAgICAgfQo+ID4gKyAg
ICAgfQo+ID4gKwo+Cj4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGlu
Zm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
