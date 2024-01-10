Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25BC9C4706C
	for <ltp@archiver.kernel.org>; Wed, 10 Jan 2024 02:17:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BDFB63C9430
	for <ltp@archiver.kernel.org>; Wed, 10 Jan 2024 03:17:24 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C67B3C1BC7
 for <ltp@lists.linux.it>; Wed, 10 Jan 2024 03:17:09 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5E1EF600921
 for <ltp@lists.linux.it>; Wed, 10 Jan 2024 03:17:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704853026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jm46x/uPgzlY8Za1JoSZfS/IPwRu6fYH6VWuH/Q4w6I=;
 b=JPJMfG58PkclooBxU4JOp1rJOPqXCIOuxduIBUzHkKmPOCsnnqiGAJU7lNjvV8+KGV0sRS
 SNqQ1xdheiFSdUG9HWe7O4C+8ql+uip94nrR6I4+xPjSn9rXpRD0VYYTlxcJg428Rq9AHj
 a9k51tyhHpZG7EukMdOYPlDgiS5O7zM=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-uMJAHmX3NtmqFOwzeZvBDw-1; Tue, 09 Jan 2024 21:17:04 -0500
X-MC-Unique: uMJAHmX3NtmqFOwzeZvBDw-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2cce8b0c9acso24689221fa.3
 for <ltp@lists.linux.it>; Tue, 09 Jan 2024 18:17:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704853023; x=1705457823;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jm46x/uPgzlY8Za1JoSZfS/IPwRu6fYH6VWuH/Q4w6I=;
 b=Cjp2gvQfmqTeHm7pyS6wW6CXjtj4LPus+tSMcKC0DTKG4doCCjpAPj2rflqmNIV6ko
 7O/Xb8uedX0hr4Eqtd5Z/bFestPFmr+lp2yds5t5s53lGXqJ6hBl0ItwthmtDnm1xSso
 Dk82/aX+5lLtI2ReZ8FkTb6fkDBDjm0IPdEOUuIVywUk/xU6roZYSPCsPGZGcfuJESwz
 yxt2pOwQqa6vK70XqpYVy0OH8E1CIdnl5dGa7bYLKArohe3r8QW/uqBn/jM3LdiCmwXl
 A0nDO5iNRn73m8zPDl/9SXrdUVKttFmVJqOsSW/U0Qd34LSldKYDYwI45upiK3Kbba6J
 PVAg==
X-Gm-Message-State: AOJu0YzvXRiupMKosfnk5P47AhA434SpGSL20Yg8KtMIp0CAAN9t+CZC
 ql7Ks+Mm4peGcHawC3oS7SRvSssm7lxbV+yI79NfkYgSsK3iH1BKClEs/+4xSim2dru5ap5HkY6
 HLfqSm0EqBu1U86GT8Is/mHJ1S/OUHzNzRos=
X-Received: by 2002:a2e:9015:0:b0:2cc:eb35:29f3 with SMTP id
 h21-20020a2e9015000000b002cceb3529f3mr78217ljg.77.1704853022822; 
 Tue, 09 Jan 2024 18:17:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjAchwkvuCeDQYwqF6SGk7myRT8vo3I/tp72ko4ZSin+27LqoxDXfaN9LhVdLQf3qUyjqwm4OMnAv9xrqBfYs=
X-Received: by 2002:a2e:9015:0:b0:2cc:eb35:29f3 with SMTP id
 h21-20020a2e9015000000b002cceb3529f3mr78214ljg.77.1704853022493; Tue, 09 Jan
 2024 18:17:02 -0800 (PST)
MIME-Version: 1.0
References: <CAEemH2dJyfhEg4opn3v1c_P1Ewao+s33_PzoVMyP0siEy+0cxA@mail.gmail.com>
 <3b638b9e-6269-459d-bcc8-2bad7b538de1@gmx.de> <20240109172016.GB1661159@pevik>
In-Reply-To: <20240109172016.GB1661159@pevik>
From: Li Wang <liwang@redhat.com>
Date: Wed, 10 Jan 2024 10:16:50 +0800
Message-ID: <CAEemH2c2AJPCyT0EbD0XrbqJ7c26ocyMjFzCvm5ntD8bGKs_cg@mail.gmail.com>
To: Petr Vorel <petr.vorel@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] Cleanup IA-64 related code?
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQWxsLAoKT24gV2VkLCBKYW4gMTAsIDIwMjQgYXQgMToyMOKAr0FNIFBldHIgVm9yZWwgPHBl
dHIudm9yZWxAZ21haWwuY29tPiB3cm90ZToKCj4gSGkgSGVsZ2UsIExpLAo+Cj4gPiBPbiAxMS8y
MC8yMyAwOToxMSwgTGkgV2FuZyB3cm90ZToKPiA+ID4gSGkgYWxsLAo+Cj4gPiA+IEkgbm90aWNl
ZCB0aGF0IHRoZSBtYWlubGluZSBrZXJuZWwgaXMgZGVjbGFyaW5nIHRvIGRyb3BwIHN1cHBvcnQg
Zm9yCj4gPiA+IEl0YW5pdW0gSUEtNjQsIGFjdHVhbGx5LCB0aGUgY29tbWl0WzFdIGhhcyBiZWVu
IG1lcmdlZCBpbiB2Ni43LXJjMi4KPgo+ID4gPiBJIGFtIG5vdyB0aGlua2luZyBzaG91bGQgd2Ug
ZG8gdGhlIHNhbWUgYWN0aW9uIGZvciBMVFAgaW4gdGhlCj4gPiA+IG1haW4gYnJhbmNoIHRvIGtl
ZXAgY29uc2lzdGVudCB3aXRoIHRoZSBtYWlubGluZSBrZXJuZWw/Cj4KPiA+IFVwc3RyZWFtIGtl
cm5lbCBkcm9wcGVkIElBLTY0IGZvciBmdXR1cmUgcmVsZWFzZXMsIGJ1dCBpdCdzIHN0aWxsIGJl
aW5nCj4gPiB1c2VkIHRoZSBuZXh0IGZldyB5ZWFycyB3aXRoIGV4aXN0aW5nIGtlcm5lbHMsIG1h
Y2hpbmVzIGFuZAo+IGRpc3RyaWJ1dGlvbnMsCj4gPiBzbyBJIHN1Z2dlc3QgdG8gbm90ICpwcm8t
YWN0aXZlbHkqIGRyb3BwaW5nIGV4aXN0aW5nIGNvZGUgeWV0Lgo+ID4gRS5nLiBpdCdzIHN0aWxs
IHN1cHBvcnRlZCBvbiBkZWJpYW4gdW50aWwgZW5kIG9mIHRoZSBjdXJyZW50IGRlYmlhbgo+IHJl
bGVhc2VzLgo+Cj4gPiBKdXN0IG15IDJjLgo+Cj4gSSB3b3VsZCBrZWVwIGl0IGF0IGxlYXN0IGlu
IHRoaXMgdXBjb21pbmcgcmVsZWFzZS4gSSBhbHNvIHdvbmRlciBpZiBhbnlib2R5Cj4gdGVzdHMg
SUEtNjQgd2l0aCBuZXcgTFRQLCBpLmUuIGhvdyBsb25nIHdlIHNob3VsZCBrZWVwIGl0IGluIExU
UCBiZWZvcmUKPiByZW1vdmluZy4KPgoKR29vZCBxdWVzdGlvbi4gSSBoYXZlIHRoZSBzYW1lIHF1
ZXJ5LgoKRnJvbSB3aGF0IEkgdGhpbmssIHdlJ2QgYmV0dGVyIGtlZXAgdGhlIGFyY2ggc3VwcG9y
dCBsaXN0IGNvbnNpc3RlbnQKd2l0aCB0aGUgbWFpbmxpbmUga2VybmVsLiBJZiBzb21lIGFkZGl0
aW9uYWwgZGlzdHJvcyAoZS5nIERlYmlhbikKaG9wZSB0byBleHRlbmQgdGhlIGxpZmUgb2YgSUE2
NCBzdXBwb3J0LCBjaG9vc2luZyB0aGUgb2xkIExUUCByZWxlYXNlCnBhY2thZ2Ugc2hvdWxkIHdv
cmsuCgpUaGUgbGF0ZXN0IG1haW4gYnJhbmNoIG9mIExUUCBtYWludGFpbnMgYXBwcm9wcmlhdGUg
Y29tcGF0aWJpbGl0eQphbmQgZG9uJ3Qgd2FudCB0b28gbXVjaCwgd2hpY2ggbWlnaHQgYmUgdGhl
IHJpZ2h0IHdheSB0byBkZXZlbG9wLgoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
