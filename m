Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E07B0C47073
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 03:32:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A26F03CE773
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 04:32:47 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 557F63C8125
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 04:32:37 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AF97B1A02369
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 04:32:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704339154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gYUEFOrGyj2+mMkbB5xFYhQhtI74TKEGOZHCKy0sgsk=;
 b=bHCWr6CHQxG2WlUDQxrQRDnxmJ+YBhzFuTxNYG9M6zOJoXEFQM6OwBEgBIDhDBbwykGwar
 7ZPqcSaZ/9ilTa+WqKTkbPajQg3oSQmKRKxcdZ0loeiy16jn0X1d9T/W5f6gGe2WS5TOs/
 RkCcVZ4inONDd4WCLfSLt5iTdtkpaUk=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-KLh1ei9kObOmAAXQhk1m7Q-1; Wed, 03 Jan 2024 22:32:30 -0500
X-MC-Unique: KLh1ei9kObOmAAXQhk1m7Q-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2ccbddbc79fso710661fa.2
 for <ltp@lists.linux.it>; Wed, 03 Jan 2024 19:32:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704339149; x=1704943949;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gYUEFOrGyj2+mMkbB5xFYhQhtI74TKEGOZHCKy0sgsk=;
 b=LNOIsHUEaMDrlnNC9PJIy5MGsnOfm/U81fDkl3AFrYbCs3TLgWSI/ggzhVnErfKGN7
 FEcAoLeHjKAoXx0dP5iAckVhFOf8R9i/ermDoE9DEfvSMgEOrCqXTG49IC/ISL6O/6gE
 bCKJhGzlJS3hbG6NSnJViVuvVP2RmktUmN4ZAQxYW8WVJH0cINmCIuRpnBJEzNtIiZeG
 qNFTn5nY5+Oek7B0I1rG3sCV0YTE8m3JR39BRsyLt/AIFQa0yTDyEZcgt4DBq/6CTPYd
 RIzFQm6Y5icLOoxLOnkCAelArR9+hW799dJ9BqgZw/WLLQnQnuXQ6P8MMQkvEbv1IDGJ
 nEBw==
X-Gm-Message-State: AOJu0Yzl84wxTw8Haqi+YIF3eZcyLel8HYg32baEqWOGfv7iAALkn756
 IOTWhghrSI5HXKut8cRgZYEp+lmreV8s8GU7aeVSt8eSl3XJFWly+mjDhyb2wlpbnGJJljQJvxc
 oo7MeFnr9YMDBmAAJRaUiFELEgSeukqQqdi8=
X-Received: by 2002:a2e:a229:0:b0:2cc:e177:fa68 with SMTP id
 i9-20020a2ea229000000b002cce177fa68mr5100280ljm.21.1704339149070; 
 Wed, 03 Jan 2024 19:32:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPdcTNRK5qUSVs/vydtR1S4eFusU8+VwGCTNvePi4VWkwFaaUNNKCNNolG7AbhgzfWPQKYL0QpjrXxHcXogZA=
X-Received: by 2002:a2e:a229:0:b0:2cc:e177:fa68 with SMTP id
 i9-20020a2ea229000000b002cce177fa68mr5100272ljm.21.1704339148738; Wed, 03 Jan
 2024 19:32:28 -0800 (PST)
MIME-Version: 1.0
References: <20231207194011.273027-1-pvorel@suse.cz>
 <20231207194011.273027-4-pvorel@suse.cz>
 <20231213024617.vx3epsav2n2lxozi@moria.home.lan>
In-Reply-To: <20231213024617.vx3epsav2n2lxozi@moria.home.lan>
From: Li Wang <liwang@redhat.com>
Date: Thu, 4 Jan 2024 11:32:16 +0800
Message-ID: <CAEemH2ebg4D2n-OKZXyv52A+wCXSJqV7ZFU_CC9Laauvq3CjyA@mail.gmail.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 3/3] statx04: Skip STATX_ATTR_COMPRESSED on
 Bcachefs
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
Cc: linux-bcachefs@vger.kernel.org, Brian Foster <bfoster@redhat.com>,
 fstests@vger.kernel.org, Richard Palethorpe <rpalethorpe@suse.com>,
 Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgS2VudCwKCk9uIFdlZCwgRGVjIDEzLCAyMDIzIGF0IDEwOjU14oCvQU0gS2VudCBPdmVyc3Ry
ZWV0IDxrZW50Lm92ZXJzdHJlZXRAbGludXguZGV2Pgp3cm90ZToKCj4gT24gVGh1LCBEZWMgMDcs
IDIwMjMgYXQgMDg6NDA6MTFQTSArMDEwMCwgUGV0ciBWb3JlbCB3cm90ZToKPiA+IFNUQVRYX0FU
VFJfQ09NUFJFU1NFRCBpcyBub3Qgc3VwcG9ydGVkIG9uIEJjYWNoZWZzLCB0aHVzIHNraXAgaXQK
PiA+IChpdCdzIGFscmVhZHkgc2tpcHBlZCBvbiB0bXBmcyBhbmQgWEZTKS4KPgo+IEhhbmcgb24s
IGJjYWNoZWZzIG1vc3QgZGVmaW5pdGVseSBkb2VzIGhhZSBjb21wcmVzc2lvbi4gVGhpcyB3b3Vs
ZCBiZQo+IGp1c3QgYmVjYXVzZSBzdGF0eCBpc24ndCBwbHVtYmVkIHRocm91Z2g/Cj4KClNlZW1z
IG5vdCwgSSBndWVzcyB0aGF0IGlzIG9ubHkgYmVjYXVzZSBiY2FjaGVmcyBkb2Vzbid0IHN1cHBv
cnQgdGhlIGZsYWcKaW4gYmNoMl9nZXRhdHRyKCk/CgpzZWU6IGh0dHBzOi8vZWxpeGlyLmJvb3Rs
aW4uY29tL2xpbnV4L3Y2LjctcmM4L3NvdXJjZS9mcy9iY2FjaGVmcy9mcy5jI0w3NDEKCgotLSAK
UmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo=
