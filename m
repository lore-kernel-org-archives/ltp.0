Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A38DC3ABC3
	for <ltp@archiver.kernel.org>; Tue, 13 May 2025 13:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747141658; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=ZbKJ8R0xFYYiFD6yxiyCuBWhGf9suUF48Cdz9nUwDVw=;
 b=jw9FYUNc5sSbpkMdylvxa96p1yyZfAAlH11RJuiIORpuYZTlZNxj8intTktWWiXwDvVzd
 w0cqiFMLhvQXMiTGn8Fxfk+oqgc1WYimwL+FxAxqlfato4i174KVTaSb5TtuUfL0gcaH+Ot
 +Fn/fkb+yn5fmxuOE4CoBu1DO0voQWg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E7AA23CC33D
	for <ltp@archiver.kernel.org>; Tue, 13 May 2025 15:07:38 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A06F43CC30E
 for <ltp@lists.linux.it>; Tue, 13 May 2025 15:07:15 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EF32C6008F1
 for <ltp@lists.linux.it>; Tue, 13 May 2025 15:07:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747141633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+PjcYVMnKUykzJhj86kdaSrJdK7dFVYvI+zJ1SC2LAY=;
 b=jCn8rh7BbRs8fak2oS1Qsx5gXuwgCQGGssZ1bSzJqmWtcgujNinI51HF7yx6YMg0Gv3X0L
 39skTrsveP8t6hao+mwF/IIEjWBS5bP5Bc+IUvV+vjUbWxwuS1PNF8vedDHGngR1dR6zI5
 K4fxOGDID8w8EAHpnBVkNt0b+uCBwfs=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-aixgl02-ObOJvAq6I-4E7A-1; Tue, 13 May 2025 09:07:11 -0400
X-MC-Unique: aixgl02-ObOJvAq6I-4E7A-1
X-Mimecast-MFC-AGG-ID: aixgl02-ObOJvAq6I-4E7A_1747141631
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-22fd4e7ea48so37075505ad.3
 for <ltp@lists.linux.it>; Tue, 13 May 2025 06:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747141631; x=1747746431;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+PjcYVMnKUykzJhj86kdaSrJdK7dFVYvI+zJ1SC2LAY=;
 b=xOIhKehoTr+AxGCYVujRSRTIQZKUCRF3fRKhgfKt7dgdhbOZ0VwDe0quAv1cBtkNca
 OBz3W4dNQKDNeEc+nCWjjUgxckDYwxsIyYjXvYnCV3/oZC84RXfKL2gr4ElsmyAuQrU3
 BwJTdGs3zTYRJoMng4+v3INyA+XLWgGFKYzNuoIl7nSKiXiigbMjzjO9nGuXfyNkwrLg
 hk/5yZunayvpNOKlkzBgVB5nHIIKkbMzfvw5KFEFbX8Z9UJE0VH2OGx5eTqQVDEjRqjy
 dOvl2UWOnVxNvLleP5Dz3gC/XqSU0rrQ9p+VasELPUygWykzIYYjndIQG59OFbpB4ULL
 a0kA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNIRU9kiOTU6BkXQsyGJ6d66zPIvroPry1+jnbBw5QI3rjJlfWA619d1bDIJtqUi74CPs=@lists.linux.it
X-Gm-Message-State: AOJu0YzZ9aLXKzj5Hgd5kG4uMS4RGswDvwfCG5Nvqql8ihxpgL5F843q
 rRI4Hp84RWGReEiW1OoaSAo/x974la2396qlBE1sgYLw8CkPrFxt579wcx2XwOzVX32oG2LnfyM
 kHfqHpEJQ2lzBZle6N3ch0cwMbStJVytXPy5TvwtyPSK1zOX8mJ+t30SDbFX68UNBOuVir3bBD8
 ZI7SinxGRlfmbTqYPNFUeMdE8=
X-Gm-Gg: ASbGncu5Jv2TFw4vh4gpVsWatqhXN/MCdDuLVl3PyadXMo6IKRtwznMok8TGe8ySs53
 Ay351Ui9pACLiWPef2KhsW3mnGgM+jy4vwxVkQp278waZTkFRcQMUn8nsgoEH7BpW07ispA==
X-Received: by 2002:a17:902:cf08:b0:223:5c33:56a2 with SMTP id
 d9443c01a7336-22fc8b6041amr287860305ad.28.1747141630765; 
 Tue, 13 May 2025 06:07:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6DXVYFBMbf5styP7AeNwDDOWYZftZollm+Dor9RIqTwb8SYe2Fs4cdDLlzb0RHBlKzEKo/q5BhsC5QjJ/aFM=
X-Received: by 2002:a17:902:cf08:b0:223:5c33:56a2 with SMTP id
 d9443c01a7336-22fc8b6041amr287859845ad.28.1747141630343; Tue, 13 May 2025
 06:07:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250513050530.47541-1-liwang@redhat.com>
 <aCM2PrCrCdPqNIGc@yuki.lan> <20250513125148.GA244619@pevik>
 <CAEemH2dng7ZaxVgYUFLcqy0aamgFstoCogdOKkA2+DPJWctpig@mail.gmail.com>
In-Reply-To: <CAEemH2dng7ZaxVgYUFLcqy0aamgFstoCogdOKkA2+DPJWctpig@mail.gmail.com>
Date: Tue, 13 May 2025 21:06:58 +0800
X-Gm-Features: AX0GCFsjGkiYUZop9xuQKmBq_LpoziE27ctRzPZ7UUidwAvzQgOl5pvDQys_BcU
Message-ID: <CAEemH2f2qUqOxxEoaGhgvMWn4Y_EfDNMod=bAETWXBDZFQFRgw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WY1lAMOCVVyLUAWvV_nJ66wv4FiWYM0h_S0LfghqER0_1747141631
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] lib: initialize lib|main_pid to zero in the
 setup_ipc
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBNYXkgMTMsIDIwMjUgYXQgOTowMuKAr1BNIExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKPgo+IE9uIFR1ZSwgTWF5IDEzLCAyMDI1IGF0IDg6NTLigK9QTSBQZXRyIFZv
cmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cj4gPgo+ID4gSGkgYWxsLAo+ID4KPiA+IC4uLgo+
ID4gPiA+ICsrKyBiL2xpYi90c3RfdGVzdC5jCj4gPiA+ID4gQEAgLTU5LDcgKzU5LDYgQEAgc3Rh
dGljIGNvbnN0IGNoYXIgKnRpZDsKPiA+ID4gPiAgc3RhdGljIGludCBpdGVyYXRpb25zID0gMTsK
PiA+ID4gPiAgc3RhdGljIGZsb2F0IGR1cmF0aW9uID0gLTE7Cj4gPiA+ID4gIHN0YXRpYyBmbG9h
dCB0aW1lb3V0X211bCA9IC0xOwo+ID4gPiA+IC1zdGF0aWMgcGlkX3QgbGliX3BpZDsKPiA+ID4g
PiAgc3RhdGljIGludCBtbnRwb2ludF9tb3VudGVkOwo+ID4gPiA+ICBzdGF0aWMgaW50IG92bF9t
b3VudGVkOwo+ID4gPiA+ICBzdGF0aWMgc3RydWN0IHRpbWVzcGVjIHRzdF9zdGFydF90aW1lOyAv
KiB2YWxpZCBvbmx5IGZvciB0ZXN0IHBpZCAqLwo+ID4gPiA+IEBAIC0xNDMsNyArMTQyLDkgQEAg
c3RhdGljIHZvaWQgc2V0dXBfaXBjKHZvaWQpCj4gPiA+ID4gICAgICAgICAgICAgdHN0X2Z1dGV4
ZXMgPSAoY2hhciAqKXJlc3VsdHMgKyBzaXplb2Yoc3RydWN0IHJlc3VsdHMpOwo+ID4gPiA+ICAg
ICAgICAgICAgIHRzdF9tYXhfZnV0ZXhlcyA9IChzaXplIC0gc2l6ZW9mKHN0cnVjdCByZXN1bHRz
KSkvc2l6ZW9mKGZ1dGV4X3QpOwo+ID4gPiA+ICAgICB9Cj4gPiA+ID4gLSAgIHJlc3VsdHMtPmxp
Yl9waWQgPSBsaWJfcGlkOwo+ID4gPiA+ICsKPiA+ID4gPiArICAgcmVzdWx0cy0+bGliX3BpZCA9
IDA7Cj4gPiA+ID4gKyAgIHJlc3VsdHMtPm1haW5fcGlkID0gMDsKPiA+Cj4gPiBuaXQ6IElzIGl0
IHJlYWxseSBuZWVkZWQgdG8gaW50IHRoZW0gdG8gMD8gQmVjYXVzZSB0aGV5IHNob3VsZCBiZSAw
IGR1ZSB0aGUKPiA+IGRlZmF1bHQgc3RydWN0IHZhbHVlLCByaWdodD8KClRoZSByZXN1bHRzIHN0
cnVjdHVyZSBtZW1vcnkgd2FzIGR5bmFtaWNhbGx5IGFsbG9jYXRlZCB2aWEKbW1hcCBzbyB0aGUg
ZGVmYXVsdCB2YWx1ZSBtaWdodCBub3QgYmUgemVyby4gVW5sZXNzIHdlIGRvCmV4cGxpY2l0bHkg
Y2FsbCBtZW1zZXQoLCAwLCAuLi4pLgoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgoKLS0gCk1haWxp
bmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
