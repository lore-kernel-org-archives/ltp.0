Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4553C54F4C
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 13:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785245252; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=fJ9wIclWUez8sgkmWXYhR51zQ6YwU+Y9ALt/6I7QD7g=;
 b=iJpmLAmN8fKeVCej7n8y9S+Kpi7lF4WfikUwD7v4neQwdinUUlnodYIURTM9DyknQLwFb
 q8KoRdmK/YoaJTSLFUiXIJttsiIiGsuM7jICnHaLteFL+j39uMYoVbwFfk7IV5TT5VC/opP
 U8EAUBVy5hvGIwIEcoYlSMhJuMYbnBw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E23A3E7497
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 15:27:32 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C8E133E5618
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 15:27:12 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BAA781400B8E
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 15:27:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785245229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=niI6xeifBcnZs3ykQxEyZQWsv+iA5umQMBslXV59CAc=;
 b=HQPL4mLa+SdGATyjDyC69gyaswV4urbsIMJbMF1dn0Prtv432drUsH2dIjIj5W0KEmi+hn
 u4kWACP2tHxp2YavyrUwB1Pwk6uPirpm047lOKcbyGqUf42aawnu4we66JE8TzEYad8dqq
 d5ecpiclYw0BfvSXBXgs2CGy7NcVGeE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-j2TBofsKMyeeiJPk85svQA-1; Tue, 28 Jul 2026 09:27:05 -0400
X-MC-Unique: j2TBofsKMyeeiJPk85svQA-1
X-Mimecast-MFC-AGG-ID: j2TBofsKMyeeiJPk85svQA_1785245224
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-472a798fc7cso2923608f8f.1
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 06:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785245224; x=1785850024;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=niI6xeifBcnZs3ykQxEyZQWsv+iA5umQMBslXV59CAc=;
 b=Liaxw2IjRR4QDNtwlt7oGo+1fidFnP5SjESkCYLnr/C3mnWrbcYwNrM+9f05Ghhhbb
 6aqTELulAv1S9JgYO2SrQgqhJ34S0KUsUy88h3vDXZmyBC/530VrqtJx3jpm61WnGXkd
 c4vfhsYmcuhbH0FOJ42Pi7gFGjfmmsxCWoUNSVnZU7OY4lkwmYBPpVYVznPb2aWtnKgM
 9HnlNA74K473jfiK6NSE0z0LRyUQs3xm1KEkImAtcERHdYUkSBQidRWAyldQCAjOShmn
 +CifLbWQuIHLZRFg1c6CyImXHlP4lnDWZK6SxxXyZkiD5PXBOnVYoBA284zMmZQX0xSB
 jzig==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqo9cU7llyz0E3/3kUE166m44yEWsMThMdLS/KA0Awh8as6zdqk8Ya7I5FjeqW1iM3wt58=@lists.linux.it
X-Gm-Message-State: AOJu0Yy1xKNiVuFAnVmU3Sc9C+SSCkxr5sh3OYrWl1zGH1Np+KoYeStU
 poyfo4F/ASqXKjaTqUbWqCo3DPT6/Vshl204m0Gy6AezDD0SK0BwChrt0ynVkxGzJuZXFf25ipH
 C36QGxvUUs5Z3bJbN0gek93Y5lXVKqziGEXh4AIcs9frZI0APcSNn/RNXGE+ZaiiIzc2tOdGh7p
 m7xwJ2YENK6yeQktOrbjtVNA4DrZg=
X-Gm-Gg: AR+sD11v0bOoSuCC67zhj/CVM+Ev5pC1sw1j1Lvmjj2Wndl6bGUbxDZTphd/H7CiI9R
 KulN4k7eFz8cYOs6Op/blrSwkPBZ/fWDeT18JnKdzdoQ5Zvef81EoCqMN2MUbzs53zG4zw2d1AL
 o/yM2VZPuZkChDrH3X94dISJvxpjfa2P7G87Xjm0QEEQEtNCgzxoc/0Ro=
X-Received: by 2002:a5d:584d:0:b0:461:a15f:6df4 with SMTP id
 ffacd0b85a97d-47fb1ea7d19mr2956283f8f.35.1785245224371; 
 Tue, 28 Jul 2026 06:27:04 -0700 (PDT)
X-Received: by 2002:a5d:584d:0:b0:461:a15f:6df4 with SMTP id
 ffacd0b85a97d-47fb1ea7d19mr2956254f8f.35.1785245223964; Tue, 28 Jul 2026
 06:27:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260722192052.3975-1-linuxtestproject.agent@gmail.com>
 <20260722212646.2340340-1-bgrech@redhat.com> <20260727082240.GA1010349@pevik>
 <CAA835F7iF91Hrb099kbpG0+CR3WOBCH34C7tiB-4uJfNWjva8w@mail.gmail.com>
 <20260728131601.GA1065673@pevik>
In-Reply-To: <20260728131601.GA1065673@pevik>
Date: Tue, 28 Jul 2026 15:26:46 +0200
X-Gm-Features: AUfX_mxA4UcFlfx0w_N67Yj1afkVmkTPdE0sx_r_-b-WX81_ARlkp3zSsUi3oHQ
Message-ID: <CAASaF6y+umcvL+fvCvr=V=b9qAu2waBu2oUARxze6bA1=Ui45g@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vhYGRAoTzIU_HsQxALMn0pu-40HPTovaQkhwNWNO3os_1785245224
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] cve/icmp_rate_limit01: Lower icmp_msgs_per_sec
 for debug kernel reliability
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

T24gVHVlLCBKdWwgMjgsIDIwMjYgYXQgMzoxNuKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IEhpIEJyaWFuLAo+Cj4gPiBIaSBQZXRyLAo+Cj4gPiBIYXBweSB0byBj
b250cmlidXRlIQo+IFdlIGFyZSBoYXBweSB0byBnZXQgbmV3IGNvbnRyaWJ1dG9ycyA6KS4KPgo+
ID4gVGhhbmsgeW91IGZvciBsZXR0aW5nIG1lIGtub3csIHRoYXQgaXMgc3RyYW5nZS4gT24gbXkg
c3lzdGVtIGl0J3MKPiA+IGNvbmZpZ3VyZWQgY29ycmVjdGx5LiBEaWdnaW5nIGEgbGl0dGxlIGRl
ZXBlciwgSSB0aGluayBpdCBtaWdodCBiZSBhCj4gPiBjb3Jwb3JhdGUgc210cCBpc3N1ZS4KPgo+
IEZZSSBpdCdzIG1hbmdsZWQgIkZyb206IiBtYWlsIGhlYWRlciBbMV06ICJGcm9tOiBCcmlhbiBH
cmVjaCB2aWEgbHRwCj4gPGx0cEBsaXN0cy5saW51eC5pdD4iLiBJdCdzIHByb2JhYmx5IERNQVJD
ICsgTWFpbG1hbiByZWxhdGVkLgo+Cj4gQlRXIEkgdGhvdWdodCBpdCBzaG91bGQgbm90IGJlIG9u
IHJlZGhhdC5jb20gc2lkZSwgYmVjYXVzZSBKYW4gU3RhbmNlayBkb2VzIG5vdAo+IGhhdmUgdGhh
dCBwcm9ibGVtLCBidXQgYWN0dWFsbHkgaGUgZG9lcyBoYXZlIHRoYXQgcHJvYmxlbSBhcyB3ZWxs
IFszXSAiRnJvbTogSmFuCj4gU3RhbmNlayB2aWEgbHRwIDxsdHBAbGlzdHMubGludXguaXQ+Ii4g
SXQncyBqdXN0IGhlIHByb2JhYmx5IGRvZXMgbWVyZ2UgdGhlc2UKPiBwYXRjaGVzIGRpcmVjdGx5
IHdpdGhvdXQgZmlyc3QgZG93bmxvYWRpbmcgdGhlbSBmcm9tIHRoZSBtYWlsaW5nIGxpc3QuCgpI
bSBpbnRlcmVzdGluZywgaXQgYXBwZWFycyB0byBiZSBvbmx5IExUUC4gVGhlIHBhdGNoIEkgc2Vu
dCBsYXN0IHdlZWsKdG8gbGttbCBhcHBlYXJzIHRvIGJlIE9LLAphbmQgaXQncyB0aGUgc2FtZSBn
aXRjb25maWcgc2V0dXA6Cmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvODRhMzVlMTZmNzIz
MzBkNmU3YjJkNmU5NjkwNDBmMzY5NTllMmRhZC4xNzg0NjMwMjkwLmdpdC5qc3RhbmNla0ByZWRo
YXQuY29tL3JhdwoKPgo+IEFueXdheSwgdmVyeSBtaW5vciBwcm9ibGVtLCBidXQgaXQnZCBiZSBu
aWNlIHRvIGdldCBpdCBmaXhlZC4gT3VyIGxpc3QgaGFzCj4gc2V0dXA6IGZyb21faXNfbGlzdCA9
IG5vLiBJIHN1cHBvc2UgdGhpcyBpcyBjb3JyZWN0IChsb29raW5nIGF0IHRoZSBkb2NzIFs0XSBh
bmQKPiBhbHNvIGNoZWNrIG90aGVyIHByb2plY3RzIHNldHVwIFs1XSkuCj4KPiBLaW5kIHJlZ2Fy
ZHMsCj4gUGV0cgo+Cj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2x0cC8yMDI2MDcyMjIx
MjY0Ni4yMzQwMzQwLTEtYmdyZWNoQHJlZGhhdC5jb20vcmF3Cj4gWzJdIGh0dHBzOi8vd2lraS5s
aXN0Lm9yZy9ERVYvRE1BUkMKPiBbM10gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbHRwLzA4Yzg1
Y2Y2NGQ3MDNkZmFiYTMxMzk4YWI5ZDliNDgwNDg4ZmUzMzguMTc0NzIyNzQ4MS5naXQuanN0YW5j
ZWtAcmVkaGF0LmNvbS9yYXcKPiBbNF0gaHR0cHM6Ly9saXN0Lm9yZy9tYWlsbWFuLWFkbWluLnR4
dAo+IFs1XSBodHRwczovL3NvdXJjZXdhcmUub3JnL3BpcGVybWFpbC9iaW51dGlscy8yMDIzLU9j
dG9iZXIvMTI5ODUyLmh0bWwKPgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9saXN0aW5mby9sdHAK
