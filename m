Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4212C624D3
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 13:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788529117; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=IIGGleRTUqPLutslqrSd6Ll098yro6eIL2n9PkCbS1E=;
 b=ZdooDdAY2kn151eL2QiGO06X1plK2rURYs+UD4+KQHgz4sCNPf702NgNwBExqJwVP1scu
 vBKqb62BqqSG603H/UFYdlrW8zu4nqiwWa5WjRnLZJpuEOMyfT3xYD4dey9rs3rZ/SHvfCC
 u/6S00+SafNiYkkxhmgz9A3eUJfijzo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3DA153E5701
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 15:38:37 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D1FAF3E30CD
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 15:38:18 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 99D3B14004EC
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 15:38:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788529095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x3rNOvNbdpRdftJmYSteOXneAAFByEk4MHz5LeSgXuI=;
 b=DdnVp58jXq2oUanDtoNSDiks9MI2vWxiqPCjXWuguOZHyarVeSu3P9gO1Eb0u6rmS5Ulhj
 qHLYJFi6LG7KbLgmozX55RBLQWouckqiGp0WFVhZnVjnD78cioW9c+/OpvjdPh/iamCQKI
 Icl2jFXFaTvv80TMOy5QpMArlbr0coA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-M8lXdE8CPI6xz9G368qG5A-1; Fri, 04 Sep 2026 09:38:13 -0400
X-MC-Unique: M8lXdE8CPI6xz9G368qG5A-1
X-Mimecast-MFC-AGG-ID: M8lXdE8CPI6xz9G368qG5A_1788529092
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47f6d70223dso705822f8f.1
 for <ltp@lists.linux.it>; Fri, 04 Sep 2026 06:38:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788529092; x=1789133892;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x3rNOvNbdpRdftJmYSteOXneAAFByEk4MHz5LeSgXuI=;
 b=FTLf/aMPTw4oBJPjIg4lmnndMmsrOsMcN+iNy2KnElFYC2ONQIRvzoXNbjDmF6mSg9
 C5T4BR7sN/b4b+ueGaJPEntBjomNgPuNJQfmbCs0OsbPf2c7n4uUEIXiKeVr3JiMftV9
 y1vkCLoRXftrPXfxfdTQ92JUjJIs/Gb6tXGgCPmhtaC3dd0q4qquHYgsq9dvp5D8Ce1c
 RQFLRmPtKqASmllGdP/K+maDqXknHYPCKXzDIJZ/xmxNVaXDruvmvXdpREC48xoHGSBg
 a+qw+pkSigaZbM93e01NeEoo49n2V2Z8EwA4S9htl/wIped/eNRzObajAyjKbBZPJ+lj
 OYEA==
X-Gm-Message-State: AFuF++lvBUYdteEYIlEhr0w5wcxu4f0E7eJMuQn4u/S54BKwQN13eMLq
 LGNzolutDYKsClUNg8BJwN8pr2bETLYHttKJ+QVEcWhQKAKQ52yVwtCwHTkstmq7s1rdUoLtoQQ
 OZWFjIYRamq7M+uoSo/+/RMxqyUAf8CtG38oW2BvqhaVY39TGQknKptJGUDflcmYbdZWWPxipnV
 QS+cXJsUF9Ymw7pH22vBoGx7qGv8g=
X-Gm-Gg: AYBFou3b6/bUy7jS7DByF855LtMUtfhouWVer3mqoYy/aD9TzXOX4QosYFidXrxPKZF
 jgqxROVwPjHTSRSZpGWvKGsS9z17qm6NAkZ8GJ9J5iTx2sEW2e6q6q0gqL09yO8kP3OkP1G/PhW
 oAL9dvoFiU4w9e/FGQb3tAnr7INJE7gRMndj0Rn4Ce
X-Received: by 2002:a5d:64c2:0:b0:482:e968:86f9 with SMTP id
 ffacd0b85a97d-4858708cae2mr13629908f8f.14.1788529092342; 
 Fri, 04 Sep 2026 06:38:12 -0700 (PDT)
X-Received: by 2002:a5d:64c2:0:b0:482:e968:86f9 with SMTP id
 ffacd0b85a97d-4858708cae2mr13629765f8f.14.1788529091845; Fri, 04 Sep 2026
 06:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260904085555.1202288-1-pvorel@suse.cz>
In-Reply-To: <20260904085555.1202288-1-pvorel@suse.cz>
Date: Fri, 4 Sep 2026 15:37:55 +0200
X-Gm-Features: AcwNN1Wicn_PA-yOrWBWUiS04p43cy5GMAw7qKuuSkxY0XFeQ3COrXHdnqbMjNQ
Message-ID: <CAASaF6wHnnH4wL217t60g+X4eS=9uFG8xj0gWdmSM_Dj-LAxtg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: puUM1JjemNGfJGz46gvQtwO3OhFeFkYJ9cAcz3uijB4_1788529092
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/4] testscripts: Remove outdated scripts
 (ltp-pan)
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
Cc: Tim Bird <tim.bird@sony.com>, ltp@lists.linux.it,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBTZXAgNCwgMjAyNiBhdCAxMDo1NuKAr0FNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IENoYW5nZXMgdjEtPnYyOgo+ICogQWRkcmVzcyAzeCB2YWxpZCBjb21w
bGFpbnMgYnkgYWdlbnQKPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sdHAvMjAyNjA5MDMxNTU5
MjEuMzk4OS0xLWxpbnV4dGVzdHByb2plY3QuYWdlbnRAZ21haWwuY29tLwo+IFBhcnRseSBieSBh
bHJlYWR5IG1lcmdlZCBjb21taXRzIGRvaW5nIGNsZWFudXAgaW4gbmV0d29yayBkb2MsIHBhcnRs
eSBpbgo+IHRoaXMgcGF0Y2hzZXQuCgpBY2tlZC1ieTogSmFuIFN0YW5jZWsgPGpzdGFuY2VrQHJl
ZGhhdC5jb20+Cgo+Cj4gTGluayB0byB2MToKPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sdHAv
MjAyNjA5MDMxMjQ2MzEuMTEwMDc0Ni0xLXB2b3JlbEBzdXNlLmN6Lwo+IGh0dHBzOi8vcGF0Y2h3
b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9sdHAvbGlzdC8/c2VyaWVzPTExNTcxMDEmc3RhdGU9Kgo+
Cj4gS2luZCByZWdhcmRzLAo+IFBldHIKPgo+IFBldHIgVm9yZWwgKDQpOgo+ICAgUmVtb3ZlIHRl
c3RzY3JpcHRzL25ldHdvcmsuc2gKPiAgIFJlbW92ZSB0ZXN0c2NyaXB0cy90cG1fdG9vbHMuc2gK
PiAgIFJlbW92ZSB0ZXN0c2NyaXB0cy9sdHAtYWlvZGlvLnNoCj4gICBjb250cm9sbGVyczogUmVt
b3ZlIG9ic29sZXRlIHJlZmVyZW5jZXMgdG8gbHRwLXBhbgo+Cj4gIC4uLi9jcHVjdGwvcnVuX2Nw
dWN0bF9zdHJlc3NfdGVzdC5zaCAgICAgICAgICB8ICAgNCArLQo+ICAuLi4vY29udHJvbGxlcnMv
Y3B1Y3RsL3J1bl9jcHVjdGxfdGVzdC5zaCAgICAgfCAgIDQgKy0KPiAgLi4uL2NvbnRyb2xsZXJz
L21lbWN0bC9ydW5fbWVtY3RsX3Rlc3Quc2ggICAgIHwgICAyICstCj4gIHRlc3RjYXNlcy9rZXJu
ZWwvaW8vbHRwLWFpb2Rpby9SRUFETUUgICAgICAgICB8ICAgOCAtCj4gIHRlc3RjYXNlcy9uZXR3
b3JrL1JFQURNRS5tZCAgICAgICAgICAgICAgICAgICB8ICAxMiArLQo+ICB0ZXN0c2NyaXB0cy9s
dHAtYWlvZGlvLnNoICAgICAgICAgICAgICAgICAgICAgfCAzMjcgLS0tLS0tLS0tLS0tLS0tLS0t
Cj4gIHRlc3RzY3JpcHRzL25ldHdvcmsuc2ggICAgICAgICAgICAgICAgICAgICAgICB8IDExOCAt
LS0tLS0tCj4gIHRlc3RzY3JpcHRzL3RwbV90b29scy5zaCAgICAgICAgICAgICAgICAgICAgICB8
IDE3MyAtLS0tLS0tLS0KPiAgdGVzdHNjcmlwdHMveWVzZW50ZXIudHh0ICAgICAgICAgICAgICAg
ICAgICAgIHwgICAyIC0KPiAgOSBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCA2Mzgg
ZGVsZXRpb25zKC0pCj4gIGRlbGV0ZSBtb2RlIDEwMDc1NSB0ZXN0c2NyaXB0cy9sdHAtYWlvZGlv
LnNoCj4gIGRlbGV0ZSBtb2RlIDEwMDc1NSB0ZXN0c2NyaXB0cy9uZXR3b3JrLnNoCj4gIGRlbGV0
ZSBtb2RlIDEwMDc1NSB0ZXN0c2NyaXB0cy90cG1fdG9vbHMuc2gKPiAgZGVsZXRlIG1vZGUgMTAw
NjQ0IHRlc3RzY3JpcHRzL3llc2VudGVyLnR4dAo+Cj4gLS0KPiAyLjU1LjAKPgoKCi0tIApNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
