Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 927EFEB64DA
	for <ltp@archiver.kernel.org>; Thu, 20 Jul 2023 10:04:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 95D713CDC94
	for <ltp@archiver.kernel.org>; Thu, 20 Jul 2023 12:04:08 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4C64A3C954B
 for <ltp@lists.linux.it>; Thu, 20 Jul 2023 12:03:56 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0ED4C1A00CB1
 for <ltp@lists.linux.it>; Thu, 20 Jul 2023 12:03:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689847433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f4NWMe0TvFNxKCC9HhMqo2fvHjjy4tK7i+3tFTwF8yo=;
 b=CHk4Bv3B1EphQaXIA+aJmb3IJyk9bQfKJUi8feQ0/dEbDoiwHMAwhjMNtOyV24yZlTSJig
 zPKab+vX1P38S5FZfNU/It3Js1OYDWPSrvZo1q5NRY5ics81UnlAfjtQ5Cfg2aU9g4QplC
 9qtXxSVsfbFaMBA89OZGNPD/EXgHZak=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-1Pq6FlyGPi-X-Tx3Ggz1VA-1; Thu, 20 Jul 2023 06:03:50 -0400
X-MC-Unique: 1Pq6FlyGPi-X-Tx3Ggz1VA-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b7355cab4fso6060091fa.1
 for <ltp@lists.linux.it>; Thu, 20 Jul 2023 03:03:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689847428; x=1692439428;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f4NWMe0TvFNxKCC9HhMqo2fvHjjy4tK7i+3tFTwF8yo=;
 b=ilarwF8w3oht4WEUtEDSqG/A9U2ynxYpsxXEtCYMLJfCRrypmocetaE4x5gFoBd8oZ
 7NOhnlb/kZ0Uty2jE/y8OFqBGpvtJl8lXHFAcqQjRxqKwUxDNYEb9cg1sSNZrBg5/dpr
 S3ALL9TqWQrj3KPxOvHyrqRkIzBfpqKvmPTGIx+0m6g1+MxEpUXynU8WPzmjptJOtNEU
 +xopUantBkM76c44nN29re5UlDSm74sNnmQVPze8qCxIvJzRX2rtnnd1zEl36IOvlTH/
 0P17QkynxfoAOe2LIbOaxXWT4LRvkg11rtBYCgOGtTg7HtCccIw4ydwStq9UH63m5t5D
 R5Dw==
X-Gm-Message-State: ABy/qLbTUIJfG+eksJHUY+70DUmxeK/rKgkgmJoEvAc9h+3006IWdtB9
 yAZPNQWY6G1XqAf6cAbBcpINPvysYEkfzhUyd+QxSBXJoLAbKuCeAseT/f2jC2cYJg6g4984khV
 kjn4aWdye/ndNJO6ihYGvqc5yZ8M=
X-Received: by 2002:a2e:8083:0:b0:2b7:339c:f791 with SMTP id
 i3-20020a2e8083000000b002b7339cf791mr2025931ljg.25.1689847428575; 
 Thu, 20 Jul 2023 03:03:48 -0700 (PDT)
X-Google-Smtp-Source: APBJJlExPgcVb0Emtm6wmHMVAZxaRE+PI/sFFbPRyrLpzsVzB+u/+UyZWu4+O9m+LijX0r9Pk3OKJSJrjLZagIHX+V4=
X-Received: by 2002:a2e:8083:0:b0:2b7:339c:f791 with SMTP id
 i3-20020a2e8083000000b002b7339cf791mr2025919ljg.25.1689847428286; Thu, 20 Jul
 2023 03:03:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230718100050.1162482-1-pvorel@suse.cz>
 <CAEemH2fAuHrE4XyBjpudMCJJ4ZJ+9TOu=LpHXzizUp-uRqWXdA@mail.gmail.com>
 <20230719101225.GB1221211@pevik>
 <CAEemH2esxksDg1NznrCW4QKO3NvEFUENWVcc4s-jf+Yk1-_RHw@mail.gmail.com>
 <20230720094343.GA1300426@pevik>
In-Reply-To: <20230720094343.GA1300426@pevik>
From: Li Wang <liwang@redhat.com>
Date: Thu, 20 Jul 2023 18:03:36 +0800
Message-ID: <CAEemH2fbuqyT3Crdv_9vhf56BkxpNj_3TB76z8+_8vh5Yfu+wQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] compat_16: Define USE_LEGACY_COMPAT_16_H for
 legacy tests
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
Cc: ltp@lists.linux.it,
 Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBKdWwgMjAsIDIwMjMgYXQgNTo0M+KAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gPiBIaSBQZXRyLAo+Cj4gPiBPbiBXZWQsIEp1bCAxOSwgMjAyMyBhdCA2
OjEy4oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgo+Cj4gPiA+IEhpIExp
LAo+Cj4gPiA+IC4uLgo+ID4gPiA+IEknbSBub3Qgc3VyZSBoZXJlIGlmIHdlIHJlYWxseSBuZWVk
IENPTVBBVF8xNl9IIGZvciBjaG9vc2luZyB0d28KPiBjb21wYXQKPiA+ID4gPiBoZWFkZXIgZmls
ZS4KPiA+ID4gPiBBcyB3ZSBhbHJlYWR5IHVzZSBoYXJkIGNvZGUgaW4gQyBzb3VyY2UgZmlsZSBs
aWtlICNpbmNsdWRlCj4gImNvbXBhdF8xNi5oIgo+ID4gPiBvcgo+ID4gPiA+ICJjb21wYXRfdHN0
XzE2LmgiLAo+ID4gPiA+IHNvIGNvbXBpbGUgd2l0aCAtSSB0aGUgaGVhZGVyIGRpcmVjdG9yeSBp
cyBlbm91Z2ggSSBndWVzcy4KPgo+ID4gPiA+IFRyeSB0aGlzIHNpbXBsZSBjb21wYXRfMTYubWss
IGl0IGF0IGxlYXN0IHdvcmtzIHdlbGwgb24gbXkgc2lkZS4KPiA+ID4gPiBPciwgZGlkIEkgbWlz
cyBhbnl0aGluZyBpbiB0aGUgMTZiaXQgY29tcGlsYXRpb24/Cj4KPiA+ID4gSSBsaWtlIHRoaXMg
c2ltcGxpZmljYXRpb24uCj4KPiA+ID4gV2VsbCwgdG91Y2ggY29tcGF0XzE2LmggY2F1c2VzIHJl
YnVpbGRpbmcgdGVzdHMgd2hpY2ggdXNlCj4gY29tcGF0X3RzdF8xNi5oLgo+ID4gPiBJIGRvbid0
IG1pbmQgdGhhdC4gQnV0IE9UT0ggdG91Y2ggY29tcGF0X3RzdF8xNi5oIGRvZXMgbm90IHRyaWdn
ZXIKPiA+ID4gcmVidWlsZGluZwo+ID4gPiB0ZXN0cyB3aGljaCB1c2UgY29tcGF0X3RzdF8xNi5o
IDooICh0ZXN0ZWQgb24KPiA+ID4gdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zZXRyZWdpZCku
IENvdWxkIHlvdSBwbGVhc2UgcmVjaGVjayB0aGF0Pwo+Cj4KPiA+IEdvb2QgcG9pbnQsIEkgb3Zl
cmxvb2tlZCB0aGUgcHJlcmVxdWlzaXRlIGZvciB0aGUgdGFyZ2V0IGJ1aWxkLCBzbyBpdAo+IG5l
ZWRzCj4gPiBhZGRpbmcgYmFjay4KPgo+ID4gQnV0IHdlIGRvbid0IGhhdmUgdGhlIG5lY2Vzc2Fy
eSB0byBrZWVwIElOVEVSTUVESUFURSBvYmplY3Qgc3ludGF4Lgo+Cj4gPiBEZWxldGUgc29tZSBs
aW5lcyBiYXNlZCBvbiB5b3VyIHBhdGNoOgo+Cj4gPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5
c2NhbGxzL3V0aWxzL2NvbXBhdF8xNi5tawo+ID4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy91dGlscy9jb21wYXRfMTYubWsKPiA+IEBAIC01MywxMSArNTMsOCBAQCBDUFBGTEFHUyAg
ICAgICAgICAgICArPSAtSSQoYWJzX3NyY2RpcikKPiA+IC1JJChhYnNfc3JjZGlyKS8uLi91dGls
cwo+ID4gIFNSQ1MgICAgICAgICAgICAgICAgICAgPz0gJChzb3J0ICQod2lsZGNhcmQgJChhYnNf
c3JjZGlyKS8qLmMpKQo+Cj4gPiAgTUFLRV9UQVJHRVRTICAgICAgICAgICA6PSAkKG5vdGRpciAk
KHBhdHN1YnN0ICUuYywlLCQoU1JDUykpKQo+ID4gLU1BS0VfVEFSR0VUU19PQkpTX1dPX0NPTVBB
VF8xNiA6PSAkKGFkZHN1ZmZpeCAubywkKE1BS0VfVEFSR0VUUykpCj4gPiAgTUFLRV9UQVJHRVRT
ICAgICAgICAgICArPSAkKGFkZHN1ZmZpeCBfMTYsJChNQUtFX1RBUkdFVFMpKQo+Cj4gPiAtIyBY
WFggKGdhcnJjb29wKTogVGhpcyBjb2RlIHNob3VsZCBiZSBwdXQgaW4gcXVlc3Rpb24gYXMgaXQg
Y2Fubm90IGJlCj4gPiBhcHBsaWVkCj4gPiAtIyAobm8gLmggZmlsZSwgbm8gVFNUX1VTRV9ORVdF
UjY0X1NZU0NBTEwgZGVmKS4KPiA+ICBERUZfMTYgICAgICAgICAgICAgICAgIDo9IFRTVF9VU0Vf
Q09NUEFUMTZfU1lTQ0FMTAo+Cj4gPiAgaWZlcSAoJChVU0VfTEVHQUNZX0NPTVBBVF8xNl9IKSwx
KQo+ID4gQEAgLTY2LDEzICs2Myw3IEBAIGVsc2UKPiA+ICBDT01QQVRfMTZfSCAgICAgOj0gJChh
YnNfc3JjZGlyKS8uLi91dGlscy9jb21wYXRfdHN0XzE2LmgKPiA+ICBlbmRpZgo+Cj4gPiAtaWZu
ZXEgKCQod2lsZGNhcmQgJChDT01QQVRfMTZfSCkpLCkKPiA+IC0kKE1BS0VfVEFSR0VUU19PQkpT
X1dPX0NPTVBBVF8xNik6ICQoQ09NUEFUXzE2X0gpCj4gPiAtLklOVEVSTUVESUFURTogJChNQUtF
X1RBUkdFVFNfT0JKU19XT19DT01QQVRfMTYpCj4gPiAtZW5kaWYKPiA+IC0KPiA+ICAlXzE2OiBD
UFBGTEFHUyArPSAtRCQoREVGXzE2KT0xCj4gPiAtIyBYWFggKGdhcnJjb29wKTogRW5kIHNlY3Rp
b24gb2YgY29kZSBpbiBxdWVzdGlvbi4uCj4KPiA+ICAlXzE2Lm86ICUuYyAkKENPTVBBVF8xNl9I
KQo+ID4gICAgICAgICAkKENPTVBJTEUuYykgJChPVVRQVVRfT1BUSU9OKSAkPAo+Cj4gTEdUTSwg
d291bGQgeW91IG1pbmQgdG8gc2VuZCBpdCBhcyBhIGZvbGxvdyB1cCB0byBteSBwYXRjaCwgYXMg
YW4KPiBhZGRpdGlvbmFsCj4gY2xlYW51cD8KPgoKWWVzLCBzdXJlLgoKLS0gClJlZ2FyZHMsCkxp
IFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0
aW5mby9sdHAK
