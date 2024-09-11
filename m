Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E6BEE0214
	for <ltp@archiver.kernel.org>; Wed, 11 Sep 2024 07:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1726041241; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=vW0NgYheVnws9jYjlArVNm96u3SzA50cf7ar8TQ5LaA=;
 b=Kcil3QXR3tclroL0lncAd1EeKY1EuH11h+5V4oHOgJSV7tq81mu1uFdiDvtz+Jd/vnQb9
 uy8/tAu6HmIGnftsrgsrH1nsrnxkQVfu+Tj8a4QfbxQnTCvUGGn2mbMjG3Pj7mtZKsvdAjL
 ioueYqinBR38urNhPiqEEvE9+pXtyvs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 258993C1C73
	for <ltp@archiver.kernel.org>; Wed, 11 Sep 2024 09:54:01 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 54C9B3C1C13
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 09:53:41 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 208A220EB32
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 09:53:40 +0200 (CEST)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a8a7929fd64so857795066b.0
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 00:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1726041219; x=1726646019; darn=lists.linux.it;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AsIZSqrYzJsnDbHHNDxbwS51fRAryELEhBLu7sBeuUM=;
 b=Zy+oz0v6sXansUSkyz1z8rElO/+3QEPjo4+wXV9eTbtTp4RYidIRov43PUAVamffBb
 1XMv1YfyErMAk7b2yJ5w9ilHm02r4cr2HRLHLbdQCagFZcTW0y4jep9IzAVSoFeLAji+
 D/4/nA+rpHyo8UEMlRdATBWvth69BYiDfBNrDHChGp4RryWYtUhITm38OUe8FTuj8Z4X
 2SVJpv3ClKvvd6oTTcs/kuXSaz9TnsABVATwEL78kvS/7hLLr1k4JyTc1KhG26R2tl5z
 8F1OhGTXHJKl1XY3edUYTpME+dIlewjoOXspR4bZY4Thg3C0uk4j8NfNIHjKIzFyPw7A
 wExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726041219; x=1726646019;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AsIZSqrYzJsnDbHHNDxbwS51fRAryELEhBLu7sBeuUM=;
 b=FRMCy5hC2AvAw2QPMmuWaHYahbg2T+LK/yglki+dSYJhr34TLBC3HyXLYxY9EsoyjI
 cphbeo2qFm52wSHtT0aVJbA7ZJHnohqODRDvem4k+5FxOHG/TrUNvdRlf/eGFAWDYxCg
 pidrLL2zRdKZoq6MUlXY35byyN7/8rRBTCBceLAX/J8WUWR75RIxK71VvrAqxBToz3kU
 C0PbyjTjW1YOIT5CYg34i4lSYoGfrpvqTuRr0yXj8I/Kd5IM3pxel6dczq2m8L7fNjoS
 iaZKlgeTpDMezRApNjcJqGgueFhOPPt+WDsjgPE/5UanxafQ9JI+17TRtsqUqZvf2Cfw
 OjIg==
X-Gm-Message-State: AOJu0YxpbGXv2ksTLduE1tUfI9OE9K7sdUi646ilGPuGv+96FWUO2vVl
 nqDmchnYAZFbwPveCOMKGtI0xIC7FI6uoMnxwC+DqyC4eTK+r6D8cScPmRcc2DHhGCFwObRK2JD
 kmxs=
X-Google-Smtp-Source: AGHT+IEUmlrYl6lpkVfMs6J8L+K+/HvXCFqFPeGAiVUMeyX9NfdjpG90GYDz3yxL4Be0XAeltjSOSQ==
X-Received: by 2002:a17:907:1c07:b0:a7d:a00a:aa02 with SMTP id
 a640c23a62f3a-a8ffaaa7202mr315294566b.1.1726041218588; 
 Wed, 11 Sep 2024 00:53:38 -0700 (PDT)
Received: from [192.168.178.49] ([79.140.118.7])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25d556e8sm580670066b.204.2024.09.11.00.53.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2024 00:53:38 -0700 (PDT)
Message-ID: <186c1131-189b-48fb-b0ec-965a8097c324@suse.com>
Date: Wed, 11 Sep 2024 09:53:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Li Wang <liwang@redhat.com>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240909-landlock_whitelist-v1-1-60c54aa9526d@suse.com>
 <CAEemH2fLVESjVK2VzE_hpYKtrAiLbEDykfDa0gyomrRzCyVDkw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAEemH2fLVESjVK2VzE_hpYKtrAiLbEDykfDa0gyomrRzCyVDkw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] Add landlock syscalls to whitelist in statistics
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

UHVzaGVkIGFmdGVyIG1vdmluZyB0aGVtIGludG8gYWxwaGFiZXRpY2FsIG9yZGVyLgoKQW5kcmVh
CgpPbiA5LzExLzI0IDA4OjE2LCBMaSBXYW5nIHdyb3RlOgo+Cj4KPiBPbiBUdWUsIFNlcCAxMCwg
MjAyNCBhdCAxOjM14oCvQU0gQW5kcmVhIENlcnZlc2F0byAKPiA8YW5kcmVhLmNlcnZlc2F0b0Bz
dXNlLmRlPiB3cm90ZToKPgo+ICAgICBGcm9tOiBBbmRyZWEgQ2VydmVzYXRvIDxhbmRyZWEuY2Vy
dmVzYXRvQHN1c2UuY29tPgo+Cj4gICAgIExhbmRsb2NrIHN5c2NhbGxzIGFyZSBjdXJyZW50bHkg
dGVzdGVkIGluIHRoZSBsYW5kbG9jayB0ZXN0aW5nCj4gICAgIHN1aXRlIGFuZAo+ICAgICB0aGVy
ZSdzIG5vIHJlYXNvbiB0byBjb25zaWRlciB0aGVtIHVudGVzdGVkLCBzbyB0aGV5IGNhbiBiZSBh
ZGRlZAo+ICAgICB0byB0aGUKPiAgICAgc3RhdGlzdGljcyB3aGl0ZWxpc3QuCj4KPiAgICAgU2ln
bmVkLW9mZi1ieTogQW5kcmVhIENlcnZlc2F0byA8YW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbT4K
Pgo+Cj4gUmV2aWV3ZWQtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPgo+Cj4gICAgIC0t
LQo+ICAgICDCoGRvYy9jb25mLnB5IHwgMyArKysKPiAgICAgwqAxIGZpbGUgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspCj4KPiAgICAgZGlmZiAtLWdpdCBhL2RvYy9jb25mLnB5IGIvZG9jL2NvbmYu
cHkKPiAgICAgaW5kZXggYzAzNDYzODhlLi43YTNlOWVjOWYgMTAwNjQ0Cj4gICAgIC0tLSBhL2Rv
Yy9jb25mLnB5Cj4gICAgICsrKyBiL2RvYy9jb25mLnB5Cj4gICAgIEBAIC05MCw2ICs5MCw5IEBA
IGRlZiBnZW5lcmF0ZV9zeXNjYWxsc19zdGF0cyhfKToKPiAgICAgwqAgwqAgwqAgwqAgwqAnc2Vj
Y29tcCcsCj4gICAgIMKgIMKgIMKgIMKgIMKgJ3NlbXRpbWVkb3AnLAo+ICAgICDCoCDCoCDCoCDC
oCDCoCdzZXRob3N0bmFtZScsCj4gICAgICvCoCDCoCDCoCDCoCAnbGFuZGxvY2tfY3JlYXRlX3J1
bGVzZXQnLAo+ICAgICArwqAgwqAgwqAgwqAgJ2xhbmRsb2NrX2FkZF9ydWxlJywKPiAgICAgK8Kg
IMKgIMKgIMKgICdsYW5kbG9ja19yZXN0cmljdF9zZWxmJywKPiAgICAgwqAgwqAgwqBdCj4KPiAg
ICAgwqAgwqAgwqAjIHBvcHVsYXRlIHdpdGggbm90IGltcGxlbWVudGVkLCByZXNlcnZlZCwgdW5t
YWludGFpbmVkCj4gICAgIHN5c2NhbGxzIGRlZmluZWQKPgo+ICAgICAtLS0KPiAgICAgYmFzZS1j
b21taXQ6IGQ2MGJkY2M3YzdhYzRiZTY2MjQzMDJiOTA5ZTRkMzgzNjc2NTJkZGEKPiAgICAgY2hh
bmdlLWlkOiAyMDI0MDkwOS1sYW5kbG9ja193aGl0ZWxpc3QtMWY5Yzk5NWExZWQ0Cj4KPiAgICAg
QmVzdCByZWdhcmRzLAo+ICAgICAtLSAKPiAgICAgQW5kcmVhIENlcnZlc2F0byA8YW5kcmVhLmNl
cnZlc2F0b0BzdXNlLmNvbT4KPgo+Cj4gICAgIC0tIAo+ICAgICBNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAKPgo+Cj4KPiAtLSAKPiBSZWdhcmRz
LAo+IExpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5p
dC9saXN0aW5mby9sdHAK
