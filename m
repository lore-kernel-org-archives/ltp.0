Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7099FB44C5
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 07:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777016083; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=zDs6skXVCUDIdQhewSfq23SxjO9MItHyTMoGTUSh1dw=;
 b=iZv4fPXD2yEfKl8H2h8s3hP2tCuoxfz5qlac1wY6wc4mQpUOqiTKbLkDs04uhsk9uJRxA
 AUIHnxnZirqdXiMB4UreeV2WGHpY+jjqcjV850dJ/kC1jmPhYTU/WZN5qw0Zq7jO1LozXhC
 9FAvH5L3tkxC5JZuIpEhUmel+IjMvI8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3BBB13E2587
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 09:34:43 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 68B3F3E2571
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 09:34:19 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 92B271000A45
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 09:34:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777016056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iXG60c//1jp/UAs2BoXHpT6DXlppGNftIcO0lcjrCco=;
 b=CuXAqSHHXVpPcZWOOWPhX8rM0+Pe5NLFGPgEHbBu+rm+dRiPzyzAambGiz3NkPr25sCrPs
 q43nW4Q4lxnzxDEUZ7D229b00OdZL4KrW6y6mU0jrQihaJdICZO5HMwKQI2pNeAcPA/kxe
 hvzlSMaYJoAzHQtfketU4ae8tutpWxc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-H5teAZvlNNC5qa3x7E-Y2w-1; Fri, 24 Apr 2026 03:34:14 -0400
X-MC-Unique: H5teAZvlNNC5qa3x7E-Y2w-1
X-Mimecast-MFC-AGG-ID: H5teAZvlNNC5qa3x7E-Y2w_1777016054
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43ea7a5da57so6039837f8f.1
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 00:34:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777016053; x=1777620853;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iXG60c//1jp/UAs2BoXHpT6DXlppGNftIcO0lcjrCco=;
 b=KcFBx9Hihsvjkwsya2V79immH7VgjlWxKqBARPb+jfCFrvCAVAJb5HuNAoyXkadVlO
 RM/Nw3VcDSAmAj8S+tSq+RZ7grx4V9thFmKuK9FB8IevxiJ/6MAnEwqr5eILm6v887bU
 gA7qyNqfZVYBky3DmfIFgjWXHNlwL90yhT3Mjbjq0pv8ZyccmzE4yFdfkEAZqMJe2MPJ
 Sy39NgJkdXI29qe3Uml4IEye2hAzeu90KDRvsZ1C5W9sqeJdTzyU7sX4JLhYQ9DB+fnv
 jVn3sliH0anbHFdBEqC7Mf46KOB2eYhm6wKH6XCu7+h5lkRG+wK2WrGT6a0hX+ljK33q
 9pbQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/RPd4/i2mwIPu2eEhfhBrnoV/uloxmmQdrSmB8rZpbS18y+ecDu3yxV8Bp5PwC+jbhGB8=@lists.linux.it
X-Gm-Message-State: AOJu0Yw5DtHDe+2Egzas53rwB16tF9zPrC2R+GyvLuqd9FARIxp5U+ll
 pCMdfkxoi7sT9qqAX8gKAFj/uB0V8xFNwrnwtkfpEty/oJCdvWrEJL8RA6xpE0JaUla6FPeh8P/
 6MpPFGB2EKlrQ4StpEM4Wl8nIUJ1iKarzVWVg+GopSt+zej5eBHzmjVSq9xP7svTENHzfVeynss
 CNJTE6oe78dSDHWYk5S8g2J3OmMKc=
X-Gm-Gg: AeBDiesiyderszDwLZnjudcYkRhqgWL3LaHJFT059eI8pLr6KcaD4K4/Y/eXm3/Qtq6
 p0BHrKfevDX6oVWUXmeMaIHWmWdr1+sU2OwjzEhYKeWrufEhecxBq6CGk4eyGcvOd/M/JAyXp2G
 pZ94Gz7wTNUrVmw0/qj2RiQ1SxssFKFSbkJVy6du7UTIKMQTbryS0+W10ZVK0AykVbtbz585+ja
 3krQ8Etd0cGDqY=
X-Received: by 2002:a5d:5f89:0:b0:441:1c95:17e7 with SMTP id
 ffacd0b85a97d-4411c951810mr28253041f8f.15.1777016053608; 
 Fri, 24 Apr 2026 00:34:13 -0700 (PDT)
X-Received: by 2002:a5d:5f89:0:b0:441:1c95:17e7 with SMTP id
 ffacd0b85a97d-4411c951810mr28253003f8f.15.1777016053177; Fri, 24 Apr 2026
 00:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260424060543.462475-1-pvorel@suse.cz>
 <aesL6YSphAi5vJbO@linux.dev>
 <20260424063132.GE462697@pevik> <aesWy5_fBdPNzvle@linux.dev>
In-Reply-To: <aesWy5_fBdPNzvle@linux.dev>
Date: Fri, 24 Apr 2026 09:33:55 +0200
X-Gm-Features: AQROBzDMM0Jv3S4GJYVb5lGRRpywuVXqTC8HYHq8uR0je6nNYxl4MKJ9qxVhMg8
Message-ID: <CAASaF6xiLDa_uOKkG2=aVhysnbKNCT-H_PiFYFt5=889g1K74Q@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>, Jan Stancek <jstancek@redhat.com>,
 ltp@lists.linux.it, 
 Cyril Hrubis <chrubis@suse.cz>, Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yxZxGECWvtNJVny1R3e3xLcUpBfosHiT6SK_IjBEbZk_1777016054
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] ioctl_pidfd06: Update kernel version
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBBcHIgMjQsIDIwMjYgYXQgOToxM+KAr0FNIExpIFdhbmcgPGxpLndhbmdAbGludXgu
ZGV2PiB3cm90ZToKPgo+ID4gPiA+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaW9j
dGwvaW9jdGxfcGlkZmQwNi5jCj4gPiA+ID4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9pb2N0bC9pb2N0bF9waWRmZDA2LmMKPiA+ID4gPiBAQCAtNTQsNyArNTQsNyBAQCBzdGF0aWMg
dm9pZCBzZXR1cCh2b2lkKQo+ID4gPiA+ICAgaWYgKCFpb2N0bF9waWRmZF9pbmZvX2V4aXRfc3Vw
cG9ydGVkKCkpCj4gPiA+ID4gICAgICAgICAgIHRzdF9icmsoVENPTkYsICJQSURGRF9JTkZPX0VY
SVQgaXMgbm90IHN1cHBvcnRlZCBieSBpb2N0bCgpIik7Cj4gPgo+ID4gPiA+IC0gaWYgKHRzdF9r
dmVyY21wKDcsIDAsIDApID49IDApCj4gPiA+ID4gKyBpZiAodHN0X2t2ZXJjbXAoNiwgMTgsIDE0
KSA+PSAwKQo+ID4KPiA+ID4gV2hhdCB3aWxsIGhhcHBlbiBpZiB0aGlzIHRlc3QgaXMgcnVuIG9u
IGtlcm5lbCByYW5nZTogdjYuMTkuMCB+IHY2LjE5Ljk/Cj4gPgo+ID4gRllJIEkgaGF2ZW4ndCB0
ZXN0ZWQgdGhhdCwgYnV0IGl0IHNob3VsZCBmYWlsIG9uIDYuMTguMC4udjYuMTguMTMgYW5kIG9u
Cj4gPiB2Ni4xOS4wLi52Ni4xOS45IGR1ZSBtaXNzaW5nIGJhY2twb3J0Lgo+ID4KPiA+IEknZCBh
c3N1bWUgdGhhdCdzIGNvcnJlY3QsIGJlY2F1c2Ugb24gc3RhYmxlL0xUUyB3ZSBzaG91bGQgSU1I
TyBiZSBtb3JlIHN0cmljdAo+ID4gdG8gZW5zdXJlIGl0IGJlaGF2ZXMgYXMgZXhwZWN0ZWQuIFdE
WVQ/Cj4KPiBIbW0sIG1heWJlIHRoYXQncyBhY2NlcHRhYmxlLiBPciBqdXN0Ogo+Cj4gICBpZiAo
KHRzdF9rdmVyY21wKDYsIDE4LCAxNCkgPT0gMCB8fAo+ICAgICAgICB0c3Rfa3ZlcmNtcCg2LCAx
OSwgMTApID09IDApIHx8Cj4gICAgICAgIHRzdF9rdmVyY21wKDcsIDAsIDApID49IDApCj4KPiBB
bmQgaXQnZCBiZSBncmVhdCB0byBoYXZlIEphbidzIGNvbW1lbnRzLCBoZSBpcyBhbiBleHBlcnQg
aW4KPiB0aGUga2VybmVsIG1haW50ZW5hbmNlIGFyZWE6KS4KCmVobSwgbm90IHN1cmUgYWJvdXQg
dGhhdCA6LSkuCgpUaGlzIGlzIGNoYW5nZSBpbiBlcnJvciBjb2RlLCB3ZSBkaWRuJ3QgdHJlYXQg
cHJldmlvdXMgdmFsdWUgYXMgZXJyb3IgZm9yIG9sZGVyCnJlbGVhc2VzLCBzbyB3aHkgZG8gdGhh
dCBub3c/IEkgZG9uJ3Qgc2VlIGl0IGNvdmVyZWQgaW4gbWFuIHBhZ2VzICh5ZXQpLApzbyB3aHkg
YmUgc3RyaWN0PwoKSSB0aGluayB0aGUgcGF0Y2ggc2hvdWxkIGVpdGhlciB1c2UgbW9yZSBzcGVj
aWZpYyB2ZXJzaW9uIHJhbmdlcyBvcgphbGxvdyBib3RoIGVycm5vcyBvbiB2ZXJzaW9ucyA8PSA3
LjAuMC4KCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlz
dGluZm8vbHRwCg==
