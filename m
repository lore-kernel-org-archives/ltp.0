Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9636EC27C4F
	for <ltp@archiver.kernel.org>; Thu, 27 Jun 2024 03:32:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0771C3D1220
	for <ltp@archiver.kernel.org>; Thu, 27 Jun 2024 05:32:48 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BA5393D0B04
 for <ltp@lists.linux.it>; Thu, 27 Jun 2024 05:32:32 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C79FD20EB2F
 for <ltp@lists.linux.it>; Thu, 27 Jun 2024 05:32:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719459150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TSSwYmH1+4Ab17uza+vFFflvG8UfbI5BnW1xaFWjJoE=;
 b=ZTtBIxcI4YzEHxzwzr+eNNLWwdnYQWlQlr7GRwRQLC2XtIlodZloPFxQDOEGqs7UDVVv1s
 a0ypVDuSdipYa2q7GnKKOCZFbx1dPE4MBQBQSjqSKKfPfiyxc7YdDkzLlGdZL1rCfJRRzR
 fSqXEFmepLXFyxhAYpcoYeFG+aQyBWQ=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-XqfWTM0zMkeQdcrSaRC_gg-1; Wed, 26 Jun 2024 23:32:27 -0400
X-MC-Unique: XqfWTM0zMkeQdcrSaRC_gg-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-7163489149fso7652693a12.3
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 20:32:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719459146; x=1720063946;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TSSwYmH1+4Ab17uza+vFFflvG8UfbI5BnW1xaFWjJoE=;
 b=sneEtjOrJveQUQdI093+hPGjzAyWFfWoMGTV/qrDrNum7DbXbtUT53GpsGCH+bdZHl
 rmmNAxnM0cRSwA/cZZv6x4ERpKC1K//xmlC9FRjG3nui9+WUyP36BXpVjY4eUS9ZyLiB
 XBlnq2YskTIQHvFOS19ldTmuJS7jK9Bcnq9O28i0hEXiXl+jFTIe71QeyH4s31pFy7MD
 ftfxBq1/3kv9eQ7B+o+a9CZJaLGBICTyKZRnq/iwGniacdZHR55+7GtOzI3AbdB1hgSD
 4JAsGrdkwehUcNPZUOAyRo//a84ldrBhM+ffQlDYyNb0/nNYAba4V3YEoyx5GuNF9ZYL
 Em6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDHwYTvUOND86QgdYR1dBkr5DcAC2A0szT5smyV1liP01UTP9FVZtnPBVD/yuXQni9nWii7KXJYNgXUMbAWwiT9tU=
X-Gm-Message-State: AOJu0YxiPrOSjCNZQCq4ErFvljgHP6UwrNy3tpwF//gzBgoezbv19bsM
 bPZGWtbcbGqsKXAsfa+DmSnwiJk7JHxAIVKHK+9nNTkr0RlPLXbzWQnhc3PkkON/Tf9esmYi1qF
 8/K/go2gy+3KpqVsoN0pZZRSCHrbzJT1lAYn/FZcSLUqyiPQWTK6WJnsSJYjwoTYxNtoXQUPgL0
 9pRt4dUKMtDk9sVuyYYQZGGCg=
X-Received: by 2002:a05:6a21:6d96:b0:1b8:44af:dab7 with SMTP id
 adf61e73a8af0-1bcf44dc9bemr16513305637.35.1719459146645; 
 Wed, 26 Jun 2024 20:32:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJJ3JQn/rH6UVJ6mHLlXKcp8WT1WLofz6RQgFp0zceweeclTxVRqsC5yX0uvf4l2b+fEpFYcRpOc+TMW79QrQ=
X-Received: by 2002:a05:6a21:6d96:b0:1b8:44af:dab7 with SMTP id
 adf61e73a8af0-1bcf44dc9bemr16513288637.35.1719459146290; Wed, 26 Jun 2024
 20:32:26 -0700 (PDT)
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
In-Reply-To: <CANDhNCpYjncxr-fn8o5vDDYScf4zvVmH_w_Ms1Jhg9tsn-UgDQ@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 27 Jun 2024 11:32:12 +0800
Message-ID: <CAEemH2eQwPSQrHKY3AxT03Nf9Y7NoKpY3y+XE8donjLhHYbP2Q@mail.gmail.com>
To: John Stultz <jstultz@google.com>, Cyril Hrubis <chrubis@suse.cz>,
 Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
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
Cc: kernel-team@android.com, Darren Hart <darren@os.amperecomputing.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgSm9obiwKCk9uIFRodSwgSnVuIDI3LCAyMDI0IGF0IDE6MDHigK9BTSBKb2huIFN0dWx0eiA8
anN0dWx0ekBnb29nbGUuY29tPiB3cm90ZToKCj4gT24gVHVlLCBKdW4gMjUsIDIwMjQgYXQgNzoy
NuKAr1BNIExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+IEpvaG4gU3R1bHR6
IDxqc3R1bHR6QGdvb2dsZS5jb20+IHdyb3RlOgo+ID4+Cj4gPj4gU2hvdWxkIHRoZSBvbGQgLS13
aXRoLXJlYWx0aW1lLXRlc3RzdWl0ZSBvcHRpb24gYmUgcmVtb3ZlZCB0aGVuPwo+ID4KPiA+Cj4g
PiBObywgd2UgbmVlZCBpdC4KPiA+Cj4gPiBXaGVuIGNvbmZpZ3VyaW5nIExUUCB3aXRob3V0IHRo
ZSAtLXdpdGgtcmVhbHRpbWUtdGVzdHN1aXRlIG9wdGlvbiwgaXQKPiB3aWxsCj4gPiBza2lwIGJ1
aWxkaW5nIHRoZSBzdHVmZiB1bmRlciB0ZXN0Y2FzZXMvcmVhbHRpbWUvIGJ5IGRlZmF1bHQuCj4K
PiBSaWdodC4gQnV0IGFzIEkgbWVudGlvbmVkIGVhcmxpZXIsIGJ1aWxkaW5nIHdpdGggaXQgc2Vl
bXMgdG8gYmUgYnJva2VuCj4gY3VycmVudGx5Pwo+CgpOb3QgYnJva2VuLCB0aGF0J3MgYmVjYXVz
ZSB5b3UgZGlkbid0IGJ1aWxkIGluIGNvcnJlY3Qgd2F5LgonbWFrZSBhdXRvdG9vbHMnIGlzIHRo
ZSBmaXJzdCBuZWNlc3Nhcnkgc3RlcCBmb3IgdGhlIGJ1aWxkLgoKCj4gPiBVbmxlc3MgeW91IGJ1
aWxkIGl0IG1hbnVhbGx5IGxpa2U6IG1ha2UgLUMgdGVzdGNhc2UvcmVhbHRpbWUvLgo+Cj4gU2hv
dWxkIG1heWJlIHRoZSByZWFsdGltZSB0ZXN0cyBqdXN0IGJlIGluY2x1ZGVkIGluIHRoZSBub3Jt
YWwgYnVpbGQKPiBub3c/IE9yIGlzIGl0IHN0aWxsIHVzZWZ1bCB0byBrZWVwIGl0IHNlcGFyYXRl
IGR1ZSB0byBzb21lIG9mIHRoZQo+IGFkZGl0aW9uYWwgZGVwZW5kZW5jaWVzIGl0IG5lZWRzPwo+
CgpIbW0sIGF0IGxlYXN0IGluIHRoZSBidWlsZC5zaCBzY3JpcHQsIGl0IGVuYWJsZXMgaW4gdGhl
IGNvbmZpZ3VyYXRpb24gcGhhc2UsCmlmIHlvdSBidWlsZCBieSB0aGF0ICguL2J1aWxkLnNoKSBp
dCBzaG91bGQgYmUgaW5jbHVkZWQuCgpCdXQgSSdtIG5vdCB2ZXJ5IHN1cmUgaWYgaXQncyB3b3J0
aCB0byBlbmFibGUgYnkgZGVmYXVsdC4gIEBDcnlpbCwgQFBldHIuCgpTZWU6IGh0dHBzOi8vZ2l0
aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwL2Jsb2IvbWFzdGVyL2J1aWxkLnNoI0wxNAoK
LS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9saXN0aW5mby9sdHAK
