Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C6ACC2BD09
	for <ltp@archiver.kernel.org>; Thu, 27 Jun 2024 18:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1719511352; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=zxTwx3shWNOUSBPreMbM2vWqO2tEryfm6Ihj+gtE0dc=;
 b=ivMD7EvwU902Vuu+qYxbMhx7b5ImATH2Lq0OBNHgc3s7TOLhZGpuQrFwElYphHKW+8xLr
 KS6IU952hxN6aEqMaHxGLvv3BecvoQk/R/DsGQgmcz6+aG2dMYNXwev5Ri2xyn95Uvmck8+
 BvdmKpxrV56J3JqKfKvWNZwUZisoGDg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B21A3D1228
	for <ltp@archiver.kernel.org>; Thu, 27 Jun 2024 20:02:32 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C22D3D107E
 for <ltp@lists.linux.it>; Thu, 27 Jun 2024 20:02:09 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8AC99601085
 for <ltp@lists.linux.it>; Thu, 27 Jun 2024 20:02:08 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4255f915611so6165e9.0
 for <ltp@lists.linux.it>; Thu, 27 Jun 2024 11:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1719511328; x=1720116128; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fy/O/d1qpQZ182ubN+3NhvsaTqtyXxTBNIRdvmlN6ok=;
 b=0gp6Nogx/bdy/yHHrUVzJvf5kYx4X8uUO+lRgXQUbqCDFfDdMEQD3zOmeg7cnN4eQ4
 3gH7r4VYUpY4WIzzdjlopVod7TxR5yiVOrkFG4ciDpGcbP2fZKhATRsk6a2wW1cpnmP4
 BAFqhimb4YIAe6bKlfptZDgZTRBauJFTQvS4IxcD0szvc3PSH4lhLMYcoFkt3sEqzu76
 GRg43Rjp5da+keQcHu3UenTXeeISP9WeIihKAYOs97ORPcPmUx1ANncF99DG6kr66o8u
 CbX+8HBZ57UCU8JY0e9hG06A+PBiHYbz2SU3IqTaIkjxr4VTM6oH7Uf56EW4/iE/ay66
 0q3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719511328; x=1720116128;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fy/O/d1qpQZ182ubN+3NhvsaTqtyXxTBNIRdvmlN6ok=;
 b=Xn3XRM0Bqi8noT9SU5Nz4i3C/Ymta36wF+AKmIO+dqWPGcxhglpgyQGMPVH/j1moxn
 A+ylEcF3bYamCxabjzOVZIqhVMjIAIEarStPCZABTfekTfHLEppmmDP+yVbC7nX6Kqxe
 9+FT4uD7vRBYmL7fw+h/DDaYWox45+RVfXAIbN1StahlQxL2Xgu8y62gwTaphG8yqbeA
 iA734FRyUBAkX3RskHcSR1kGp6Lsa74TZHXjlrL0ZI48XQBrDUpPkTj/BIAFRNpPMT9i
 6Q0EUnBdwnPoBeRvp5R1bmMG3YpG+xrCT73KojP7i/FCIozYb3roFVutjlN4OS5GMyqw
 qCRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrkQuB9OsaOqjUyDhYOXA/EYq5Wi9mtVTFqDpEg10HUAzmZS6WkBzQwL0lyB7UCljLQDohauwcN1mjWTEtyJMnBAw=
X-Gm-Message-State: AOJu0Yw7rNajpH+qGGshnmMJ5x0jc4Xxh3Bouruhux+tEWAS5oDDuldh
 mnWlJiKy8IBIVAnXZvDxAIsjERWSkN3ZJGDf6D7uioO2f5I1c9Zx2GGN593kRm70/d+eirF9oMn
 BQjVX90mVdYifjuOq7Hw0a3Nq2JUpkcISXtQ=
X-Google-Smtp-Source: AGHT+IHcAG8SrFAupdR7vU6LEFwf4oAvJNM5u+awlL2otoPwvQ/306X8Lngxj7M3euQQAkwVgl2LxIRvI67UX1qPims=
X-Received: by 2002:a05:600c:3b9b:b0:424:891e:a9fe with SMTP id
 5b1f17b1804b1-4256b77e8aamr71775e9.1.1719511327827; Thu, 27 Jun 2024 11:02:07
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
In-Reply-To: <CAEemH2eQwPSQrHKY3AxT03Nf9Y7NoKpY3y+XE8donjLhHYbP2Q@mail.gmail.com>
Date: Thu, 27 Jun 2024 11:01:54 -0700
Message-ID: <CANDhNCqWvQ9DCwXtdMW81OoZ0qULk8-6PCYwVeF_Ep+b4Kkg2A@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
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

T24gV2VkLCBKdW4gMjYsIDIwMjQgYXQgODozMuKAr1BNIExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKPiBPbiBUaHUsIEp1biAyNywgMjAyNCBhdCAxOjAx4oCvQU0gSm9obiBTdHVs
dHogPGpzdHVsdHpAZ29vZ2xlLmNvbT4gd3JvdGU6Cj4+IE9uIFR1ZSwgSnVuIDI1LCAyMDI0IGF0
IDc6MjbigK9QTSBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+ID4gSm9obiBT
dHVsdHogPGpzdHVsdHpAZ29vZ2xlLmNvbT4gd3JvdGU6Cj4+ID4+Cj4+ID4+IFNob3VsZCB0aGUg
b2xkIC0td2l0aC1yZWFsdGltZS10ZXN0c3VpdGUgb3B0aW9uIGJlIHJlbW92ZWQgdGhlbj8KPj4g
Pgo+PiA+Cj4+ID4gTm8sIHdlIG5lZWQgaXQuCj4+ID4KPj4gPiBXaGVuIGNvbmZpZ3VyaW5nIExU
UCB3aXRob3V0IHRoZSAtLXdpdGgtcmVhbHRpbWUtdGVzdHN1aXRlIG9wdGlvbiwgaXQgd2lsbAo+
PiA+IHNraXAgYnVpbGRpbmcgdGhlIHN0dWZmIHVuZGVyIHRlc3RjYXNlcy9yZWFsdGltZS8gYnkg
ZGVmYXVsdC4KPj4KPj4gUmlnaHQuIEJ1dCBhcyBJIG1lbnRpb25lZCBlYXJsaWVyLCBidWlsZGlu
ZyB3aXRoIGl0IHNlZW1zIHRvIGJlIGJyb2tlbgo+PiBjdXJyZW50bHk/Cj4KPgo+IE5vdCBicm9r
ZW4sIHRoYXQncyBiZWNhdXNlIHlvdSBkaWRuJ3QgYnVpbGQgaW4gY29ycmVjdCB3YXkuCj4gJ21h
a2UgYXV0b3Rvb2xzJyBpcyB0aGUgZmlyc3QgbmVjZXNzYXJ5IHN0ZXAgZm9yIHRoZSBidWlsZC4K
PgoKT2ssIGJ1dCBldmVuIGFmdGVyIGRvaW5nIHRoYXQgYXMgeW91IHN1Z2dlc3RlZCwgYnVpbGRp
bmcgd2l0aCB0aGUKZm9sbG93aW5nIGZhaWxzIGZvciBtZToKCm1ha2UgYXV0b3Rvb2xzCi4vY29u
ZmlndXJlIC1DIHRlc3RjYXNlcy9yZWFsdGltZS8KbWFrZSAtagouLi4KbWFrZVszXTogKioqIE5v
IHJ1bGUgdG8gbWFrZSB0YXJnZXQgJ01ha2VmaWxlLmFtJywgbmVlZGVkIGJ5CidNYWtlZmlsZS5p
bicuICBTdG9wLgptYWtlWzJdOiAqKiogWy4uLy4uL2luY2x1ZGUvbWsvZ2VuZXJpY190cnVua190
YXJnZXQuaW5jOjEwODogYWxsXSBFcnJvciAyCm1ha2VbMV06ICoqKiBbLi4vaW5jbHVkZS9tay9n
ZW5lcmljX3RydW5rX3RhcmdldC5pbmM6MTA4OiBhbGxdIEVycm9yIDIKbWFrZTogKioqIFtNYWtl
ZmlsZTo4NTogdGVzdGNhc2VzLWFsbF0gRXJyb3IgMgoKU28gaXQgZG9lcyAqc2VlbSogbGlrZSBz
b21ldGhpbmcgaXMgYnJva2VuLiA6KQoKdGhhbmtzCi1qb2huCgotLSAKTWFpbGluZyBsaXN0IGlu
Zm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
