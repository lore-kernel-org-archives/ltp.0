Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9781CC2BD09
	for <ltp@archiver.kernel.org>; Thu, 27 Jun 2024 18:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1719511421; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=v5Wgt3vVJnFcvh9vZzWzeTS4GG4mBNfMckFSXzvcoiU=;
 b=oOCLslPIgV/8I9z40UwDacCp4xYmdDh0baNAHfV4tXNf6l6sMK+d+Bzp5rlch9DYlQQ+u
 BfqYyhb8hEbAkwDV+LOhHhw2I+BoSltXj9Mep9Hk9UlVsl1wl9hqbBD264DI+aXlgVag2Hl
 nTwspstzV1OtGE9KWUXvqPWpepJuFGk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 240203D1320
	for <ltp@archiver.kernel.org>; Thu, 27 Jun 2024 20:03:41 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D5D423D107E
 for <ltp@lists.linux.it>; Thu, 27 Jun 2024 20:03:18 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0BA28600BD8
 for <ltp@lists.linux.it>; Thu, 27 Jun 2024 20:03:18 +0200 (CEST)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-57d00a51b71so1582a12.0
 for <ltp@lists.linux.it>; Thu, 27 Jun 2024 11:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1719511397; x=1720116197; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+/SnY4T7Jvxbij8lFazzbBKTczWtwkgGL5sBcZfOrek=;
 b=mPoNsJtbPwYnMhAk7QNHeYeMWXV1jwPRlsJN1muYxZeNwxrTZwI94sFROckzdtSx5/
 tBgSmGSIK9w6Ij8F1SDm25bFo+/c4TFxarzCKxtC/Jc6vVhVRO5Vc/XRqw4smqya4H2S
 BT62SpSqr/AIqvqSbJj9CEphg/jgmpT2r4YvKUzgdJyUw5DnxP4Ofv3jAb+7lE8Iqr4Y
 E+5UROd/atZn68UDto/QyD6PpBHzNBK/7c0PfFA6eg2HCGAjIac0jmL2ahP+qVowgPQ0
 ZGxvQ6MHH9EAHVGTjRtL+EAGZTmVTKlhsTLdtdg5K27JzixOiWdgduHKkknLhWQCl8FP
 pCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719511397; x=1720116197;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+/SnY4T7Jvxbij8lFazzbBKTczWtwkgGL5sBcZfOrek=;
 b=p/FSmRWHyniFyUOzrmdFty+g7ZwceA+NL1SEjWygAKFj0vu1oflwDC6S7R+E8t05SL
 2QUnGTEae+AKCJF+mirNMjLg5dwCkeIvp7dLEsZ38Hge6X07O7suOfzwDo3rES8ve7Ff
 YZiwdrEkmtBV3wKKp8bn5rEiD9GbW2yI209VXNNAtrJlyWtggTA7O7FNrBkF2JQwLW43
 xQhYfwjtuZ/3VTg/aZWcZ5eA2o6EW8huURw+2McvQzdvSKr7Z2+tphQO/qgR+Y569gwN
 w7EI0evrOhypS2mBPKP+XrycbkqGxdI5jaIl0LM7tZpbLi9ERtSKjO1u28GfmFYjyuCi
 hcYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHqmMQdegvWZtUfzvMkLoBaktXu7Mz5ix3GPebZQ+vnUuAgZ5mDAHwHiEoUr+g9Ud8C9R78k258ajGoB7Gv/si/kM=
X-Gm-Message-State: AOJu0YwflWf6SSXmtLS7ClCqjtdj6I6UvdfOxMcag0DmUQHTqZfEbrUD
 Y0PCitFO8pI+60VrdFMvIOkYTyuOD/z/KHD2+2rBQ+Et9TaAjtSmkxDRyOQfhFzq7itCgeGIzAM
 yaLc18wOckTwYhFqTWgnftVxMsaYnaV0S7xY=
X-Google-Smtp-Source: AGHT+IHXCIN+qZcqapwt83fZWBiRnCTHvQVTqx8Q/o/ixG9L+LsWWAKhdyaEFCZ6g8LwcAoZ7rNd7EZDK6s+VPu2nTw=
X-Received: by 2002:a50:954b:0:b0:57c:d1dd:e645 with SMTP id
 4fb4d7f45d1cf-5860c6462abmr7226a12.5.1719511397227; Thu, 27 Jun 2024 11:03:17
 -0700 (PDT)
MIME-Version: 1.0
References: <20240423225821.4003538-1-jstultz@google.com>
 <20240423225821.4003538-3-jstultz@google.com>
 <Zi9jL1jycx6oo37g@yuki>
 <CANDhNCq__ZY9w3Nse-+K+d9gyXhrOe_6oZ=X01x_HufZwQ_6ig@mail.gmail.com>
 <Zjn1-1YRyZGIUtEP@yuki> <ZnlORS6RGTAA4UhS@yuki>
 <CANDhNCqk-3o+Bu_c9PbqoxSacGQaGUrdTM5VDoZCOipEttXKLw@mail.gmail.com>
 <CAEemH2fT2NsoZfRvNrhRrstF=dhzF8Y90HqVQSCf1VxqpNHgEw@mail.gmail.com>
 <CANDhNCr4-cE7_Uy86Pa3kjzFG_EOOB38C_mSGSfZtc=vd7L5yQ@mail.gmail.com>
 <CAEemH2cUj4U4Z=G437fduyQA6-UrnhE4b1_QtRB0kmPn5OMgAA@mail.gmail.com>
 <CANDhNCpYjncxr-fn8o5vDDYScf4zvVmH_w_Ms1Jhg9tsn-UgDQ@mail.gmail.com>
 <CAEemH2eQwPSQrHKY3AxT03Nf9Y7NoKpY3y+XE8donjLhHYbP2Q@mail.gmail.com>
 <CANDhNCqWvQ9DCwXtdMW81OoZ0qULk8-6PCYwVeF_Ep+b4Kkg2A@mail.gmail.com>
In-Reply-To: <CANDhNCqWvQ9DCwXtdMW81OoZ0qULk8-6PCYwVeF_Ep+b4Kkg2A@mail.gmail.com>
Date: Thu, 27 Jun 2024 11:03:05 -0700
Message-ID: <CANDhNCo8C7mXQgwhWcukHjwLTks6SzpKxB8tXzmAA6qaRu+8TA@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/6] sched_football: Use atomic for ball
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
From: John Stultz via ltp <ltp@lists.linux.it>
Reply-To: John Stultz <jstultz@google.com>
Cc: Darren Hart <darren@os.amperecomputing.com>, kernel-team@android.com,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBKdW4gMjcsIDIwMjQgYXQgMTE6MDHigK9BTSBKb2huIFN0dWx0eiA8anN0dWx0ekBn
b29nbGUuY29tPiB3cm90ZToKPgo+IE9uIFdlZCwgSnVuIDI2LCAyMDI0IGF0IDg6MzLigK9QTSBM
aSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiBPbiBUaHUsIEp1biAyNywgMjAy
NCBhdCAxOjAx4oCvQU0gSm9obiBTdHVsdHogPGpzdHVsdHpAZ29vZ2xlLmNvbT4gd3JvdGU6Cj4g
Pj4gT24gVHVlLCBKdW4gMjUsIDIwMjQgYXQgNzoyNuKAr1BNIExpIFdhbmcgPGxpd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPiA+PiA+IEpvaG4gU3R1bHR6IDxqc3R1bHR6QGdvb2dsZS5jb20+IHdy
b3RlOgo+ID4+ID4+Cj4gPj4gPj4gU2hvdWxkIHRoZSBvbGQgLS13aXRoLXJlYWx0aW1lLXRlc3Rz
dWl0ZSBvcHRpb24gYmUgcmVtb3ZlZCB0aGVuPwo+ID4+ID4KPiA+PiA+Cj4gPj4gPiBObywgd2Ug
bmVlZCBpdC4KPiA+PiA+Cj4gPj4gPiBXaGVuIGNvbmZpZ3VyaW5nIExUUCB3aXRob3V0IHRoZSAt
LXdpdGgtcmVhbHRpbWUtdGVzdHN1aXRlIG9wdGlvbiwgaXQgd2lsbAo+ID4+ID4gc2tpcCBidWls
ZGluZyB0aGUgc3R1ZmYgdW5kZXIgdGVzdGNhc2VzL3JlYWx0aW1lLyBieSBkZWZhdWx0Lgo+ID4+
Cj4gPj4gUmlnaHQuIEJ1dCBhcyBJIG1lbnRpb25lZCBlYXJsaWVyLCBidWlsZGluZyB3aXRoIGl0
IHNlZW1zIHRvIGJlIGJyb2tlbgo+ID4+IGN1cnJlbnRseT8KPiA+Cj4gPgo+ID4gTm90IGJyb2tl
biwgdGhhdCdzIGJlY2F1c2UgeW91IGRpZG4ndCBidWlsZCBpbiBjb3JyZWN0IHdheS4KPiA+ICdt
YWtlIGF1dG90b29scycgaXMgdGhlIGZpcnN0IG5lY2Vzc2FyeSBzdGVwIGZvciB0aGUgYnVpbGQu
Cj4gPgo+Cj4gT2ssIGJ1dCBldmVuIGFmdGVyIGRvaW5nIHRoYXQgYXMgeW91IHN1Z2dlc3RlZCwg
YnVpbGRpbmcgd2l0aCB0aGUKPiBmb2xsb3dpbmcgZmFpbHMgZm9yIG1lOgo+Cj4gbWFrZSBhdXRv
dG9vbHMKPiAuL2NvbmZpZ3VyZSAtQyB0ZXN0Y2FzZXMvcmVhbHRpbWUvCgpPaCwgc29ycnksIEkg
Y3Jvc3Mgd2lyZXMgdHlwaW5nIHRoaXMgb3V0LiBJdCB3YXMKLi9jb25maWd1cmUgLS13aXRoLXJl
YWx0aW1lLXRlc3RzdWl0ZQoKPiBtYWtlIC1qCj4gLi4uCj4gbWFrZVszXTogKioqIE5vIHJ1bGUg
dG8gbWFrZSB0YXJnZXQgJ01ha2VmaWxlLmFtJywgbmVlZGVkIGJ5Cj4gJ01ha2VmaWxlLmluJy4g
IFN0b3AuCj4gbWFrZVsyXTogKioqIFsuLi8uLi9pbmNsdWRlL21rL2dlbmVyaWNfdHJ1bmtfdGFy
Z2V0LmluYzoxMDg6IGFsbF0gRXJyb3IgMgo+IG1ha2VbMV06ICoqKiBbLi4vaW5jbHVkZS9tay9n
ZW5lcmljX3RydW5rX3RhcmdldC5pbmM6MTA4OiBhbGxdIEVycm9yIDIKPiBtYWtlOiAqKiogW01h
a2VmaWxlOjg1OiB0ZXN0Y2FzZXMtYWxsXSBFcnJvciAyCj4KPiBTbyBpdCBkb2VzICpzZWVtKiBs
aWtlIHNvbWV0aGluZyBpcyBicm9rZW4uIDopCj4KPiB0aGFua3MKPiAtam9obgoKLS0gCk1haWxp
bmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
