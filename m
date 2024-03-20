Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D38C54E68
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 02:53:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5283D3D00BB
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 03:53:14 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E5E13CE6A4
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 03:52:59 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2E7FB1400FB5
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 03:52:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710903177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bu0kvnffL35n+cPDDk8tH6+m5MS1VerN6bGeTj7i3Io=;
 b=UZvrRmJIsWP1my/BMjzXCg7x2EHn8tioLL3JEzddxCw53c+5sbSUq6765oz0d26sNzj7fT
 BNNLvyc5rFXHupeLoleJBcKhLtYxOcwzjZM7c6Ts4Pio1q0xS0bHF8cA8+hhipSpXT8yR+
 WxrPrg90w5kcltFRVrQjUGTUqYZ1rm0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-jFZazdTPPiOwr7eVhQJJAA-1; Tue, 19 Mar 2024 22:52:54 -0400
X-MC-Unique: jFZazdTPPiOwr7eVhQJJAA-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-29de02b98caso5243889a91.0
 for <ltp@lists.linux.it>; Tue, 19 Mar 2024 19:52:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710903173; x=1711507973;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bu0kvnffL35n+cPDDk8tH6+m5MS1VerN6bGeTj7i3Io=;
 b=EDQkddhPQIRy4FVLwkcXNRZJDederm5VCAUwKLJ9aGHap0qkRi43MIY43DEouYvHuC
 BarMYcqahbY0eyXjFRQBJ+q6ZleEcbS/rphSkcz1JZn2+pok84BZoARunz8MUoTg7QRj
 Kb2Ys4SxtPlcXHux9D4NQdKdnt4jmwscJatgFWWs62z3Q2VWusHhNCJOruAGsrSbBfyA
 C078bYh8HSochzRqfsVxyPcr8sstVA8T14O4xBHB/U4ofqzrp1VJ5GPhlmuiZmGSrrGp
 FztW4djS5cyMEw+ABzhnxayo/Ht7PdHl0L9O1d4XEcYht8006cpJDNUZu2cws70s3qXb
 9YdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcUB+DtFUom/pDLnOz1BbjRLUlzyrrO9VBVHxXET9gtrNFY/2mIJut3VUZXuPz6vTFB9vlYWjg8JA3886tax53JdU=
X-Gm-Message-State: AOJu0Yyv0zMnxipnWo6leMAVkNjG91Z5XKOOZSigYMvt3gKis/WNtKA0
 wFx6AfaeKtht26WaWzDN2jVv2cO2W7F5LaYRcbn89qv82JWyallbecu2gfvLlqzWtABcQLCFpjG
 boTOzOkVCuqJ+ObX5B9vU1TgPNa0QBzmpcsdxNDmMfJT9gncn2z6ogyVBhiQBeB+fIaMcEIy1Ua
 cV6zMSq996DlEdxkzR4s4f1S0=
X-Received: by 2002:a17:90b:4f85:b0:29d:e6a2:9b3 with SMTP id
 qe5-20020a17090b4f8500b0029de6a209b3mr4759233pjb.23.1710903173092; 
 Tue, 19 Mar 2024 19:52:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtCvwnDmLQ0MZmSkB6hbWKbCDgy+SHKmhA46anjkvZT4wYvfw0b1PMiSiAoLpc3RbKD4IbMV6P8diHZ39R6Jg=
X-Received: by 2002:a17:90b:4f85:b0:29d:e6a2:9b3 with SMTP id
 qe5-20020a17090b4f8500b0029de6a209b3mr4759225pjb.23.1710903172732; Tue, 19
 Mar 2024 19:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <6868ae95-b004-4fb2-8aac-7ccf96b32f90@suse.com>
 <CAEemH2eDT6gN3hw=Lz2qgnwFnnHmNYai9tqbKduSkcWfNjpERQ@mail.gmail.com>
 <Zfmj28EpMH_S0uOo@yuki>
In-Reply-To: <Zfmj28EpMH_S0uOo@yuki>
From: Li Wang <liwang@redhat.com>
Date: Wed, 20 Mar 2024 10:52:40 +0800
Message-ID: <CAEemH2ci5r_PKq_tOSrFC4Vk9ju3xnrGzZ=smOT+8PGBXtWCGg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] New LTP documentation!
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBNYXIgMTksIDIwMjQgYXQgMTA6NDHigK9QTSBDeXJpbCBIcnViaXMgPGNocnViaXNA
c3VzZS5jej4gd3JvdGU6Cgo+IEhpIQo+ID4gQW5kIEkganVzdCB0cmllZCB0aGF0IHRoZSBsYXRl
c3QgTFRQIGNvbXBpbGVkICYgZXhlY3V0ZWQgc3VjY2VlZCBvbgo+ID4gUkhFTC03LjkuCj4gPiBD
YW4geW91IHVwZGF0ZSB0aGUgIk9sZGVzdCB0ZXN0ZWQgZGlzdHJpYnV0aW9ucyIgWzFdIHBhcnQg
YnkgYWRkaW5nOgo+ID4KPiA+ICAgUkhFTC03LjkgTWFpcG8gKERpc3RybykgIDMuMTAgKGtlcm5l
bCkgIDQuOC41KGdjYykgIDIuMTcoZ2xpYmMpCj4gLShjbGFuZykKPgo+IFN1cmUgd2UgY2FuIGFk
ZCB0aGlzLCBob3dldmVyIHlvdSB3aWxsIGJlIHJlc3BvbnNpYmxlIGZvciBtYWtpbmcgc3VyZSBp
dAo+IHdvcmtzIGFuZCBhdCBsZWFzdCBkbyBwcmUtcmVsZWFzZSB0ZXN0aW5nLgo+CgpZZXMsIG9m
IGNvdXJzZS4gVGhhbmtzIGZvciByZW1pbmRpbmcgbWUuCgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcK
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
