Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 494E2C3DA49
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 07:40:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 354813D1C97
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 09:40:31 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 53F6C3CF05A
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 09:40:16 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3E1F21008601
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 09:40:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721979613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MjTffjgOWeuRqmDirN18LO3gEq30aELJduNdwIExz88=;
 b=dIHkDF2mWtwHLq8sCHITSSvnD8ZEAKaUT2NVI1VHLkKmTKZGZv7RJAyvAzSsthpT/fA6d6
 SIOIMQLSeelEzDF4x7N1uTpEGfS3FfOyVGVaE4ozTXJl1J0TJbQKmh4xIlcDbl4R0nNp6K
 HZRFcVX2kQNeULjFjrqCAJcihju+4mI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-iCNy5M2PP2eX05fJ7k1tGA-1; Fri, 26 Jul 2024 03:40:11 -0400
X-MC-Unique: iCNy5M2PP2eX05fJ7k1tGA-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2cb5ab2f274so828967a91.3
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 00:40:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721979611; x=1722584411;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MjTffjgOWeuRqmDirN18LO3gEq30aELJduNdwIExz88=;
 b=GmQvmrEIO1Vs70IWJHODkcLZsyyDufDMb2Rg0pWhCF+4BJ1+OGuwYXTocxs6GO7O4C
 IXZHAMafk5D3tESzafvFty5NPMklCr+f31RVe42CbAh1vAl8ENgNuzWv/W1oEUCR8VXd
 uOJkC0cDLEQMhvqJ+1vpWFvszcyDcq4rQH4PDB2FWCDJro1ZHFERrZoxNhcjMWbBBU1d
 wVv85u3XyVlEtVn9m0AY+a6Y0z5gE1YQNtmne1/iAg6Rs2wIuUxOY2DfH1sALqg4DNBG
 WoxjcckdiK8/yjl5/vN1h+I09i4MWhagi8j1iXD6SbIUnE1Pg+4Zqqfhv+ncHXsiKZuQ
 xcfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRim3Jbgr1U14iX2YygKLwCfHFHhoQc4L7MdBmBIgfivxpCMbttKJ9JN6VSKvsGpNd5iSzD+6iMlaFSY9DnuK86oo=
X-Gm-Message-State: AOJu0YyZI2FP2b8CNxvXL9Mq9lad0xF4j6czGqkcOqnF5IoRi/bTtWWN
 q0jreG0tOMs6yGe4isjbgVaQIhRYFhsAaDIYtj0ic9fVavD2DoN9wQvTIDM6Unb6ds8EJ9U9gh9
 OMe8RK34knJ+NnUMTTjxwbWpUrOsLs9xWe8/W9NZtxokYmYbg6efvPkfx/lZz6HPBbkBALVpjl4
 i+dpksYn3i844M3Po4Q2HKGN8=
X-Received: by 2002:a17:90a:c290:b0:2c7:aba6:d32f with SMTP id
 98e67ed59e1d1-2cf2ea2a3e8mr5240106a91.22.1721979609114; 
 Fri, 26 Jul 2024 00:40:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7LeeLW113zDKRNb3ROcQRYYQ0gjkKzfOILHGQD+hbT5Ga4dkbskkA3OZaMqWUjRyAxpASH/jKOHx32O4boU8=
X-Received: by 2002:a17:90a:c290:b0:2c7:aba6:d32f with SMTP id
 98e67ed59e1d1-2cf2ea2a3e8mr5240083a91.22.1721979608700; Fri, 26 Jul 2024
 00:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240726072009.1021599-1-pvorel@suse.cz>
In-Reply-To: <20240726072009.1021599-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Fri, 26 Jul 2024 15:39:56 +0800
Message-ID: <CAEemH2d2gR72XeWcHU4R1g2vNV8a2hrzPN_DpdSh79Wu24DwCQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] MAINTAINERS: Update LTP members and web
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
Cc: linux-kernel@vger.kernel.org, ltp@lists.linux.it,
 Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBKdWwgMjYsIDIwMjQgYXQgMzoyMOKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gTFRQIHByb2plY3QgdXNlcyBub3cgcmVhZHRoZWRvY3Mub3JnIGluc3Rh
bmNlIGluc3RlYWQgb2YgR2l0SHViIHdpa2kuCj4KPiBMVFAgbWFpbnRhaW5lcnMgYXJlIGxpc3Rl
ZCBpbiBhbHBoYWJldGljYWwgb3JkZXIuCj4KPiBTaWduZWQtb2ZmLWJ5OiBQZXRyIFZvcmVsIDxw
dm9yZWxAc3VzZS5jej4KPiBTaWduZWQtb2ZmLWJ5OiBQZXRyIFZvcmVsIDxwZXRyLnZvcmVsQGdt
YWlsLmNvbT4KPgoKUmV2aWV3ZWQtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPgoKLS0t
Cj4gIE1BSU5UQUlORVJTIHwgNCArKystCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlO
RVJTCj4gaW5kZXggYzBhM2Q5ZTkzNjg5Li5mYTUxNDE3NzEyNWIgMTAwNjQ0Cj4gLS0tIGEvTUFJ
TlRBSU5FUlMKPiArKysgYi9NQUlOVEFJTkVSUwo+IEBAIC0xMzMyMiwxNCArMTMzMjIsMTYgQEAg
RjoKPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaTJjL2kyYy1tdXgtbHRjNDMw
Ni50eHQKPiAgRjogICAgIGRyaXZlcnMvaTJjL211eGVzL2kyYy1tdXgtbHRjNDMwNi5jCj4KPiAg
TFRQIChMaW51eCBUZXN0IFByb2plY3QpCj4gK006ICAgICBBbmRyZWEgQ2VydmVzYXRvIDxhbmRy
ZWEuY2VydmVzYXRvQHN1c2UuY29tPgo+ICBNOiAgICAgQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1
c2UuY3o+Cj4gIE06ICAgICBKYW4gU3RhbmNlayA8anN0YW5jZWtAcmVkaGF0LmNvbT4KPiAgTTog
ICAgIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pgo+ICBNOiAgICAgTGkgV2FuZyA8bGl3YW5n
QHJlZGhhdC5jb20+Cj4gIE06ICAgICBZYW5nIFh1IDx4dXlhbmcyMDE4Lmp5QGZ1aml0c3UuY29t
Pgo+ICtNOiAgICAgWGlhbyBZYW5nIDx5YW5neC5qeUBmdWppdHN1LmNvbT4KPiAgTDogICAgIGx0
cEBsaXN0cy5saW51eC5pdCAoc3Vic2NyaWJlcnMtb25seSkKPiAgUzogICAgIE1haW50YWluZWQK
PiAtVzogICAgIGh0dHA6Ly9saW51eC10ZXN0LXByb2plY3QuZ2l0aHViLmlvLwo+ICtXOiAgICAg
aHR0cHM6Ly9saW51eC10ZXN0LXByb2plY3QucmVhZHRoZWRvY3MuaW8vCj4gIFQ6ICAgICBnaXQg
aHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVjdC9sdHAuZ2l0Cj4KPiAgTFRSMzkw
IEFNQklFTlQvVVYgTElHSFQgU0VOU09SIERSSVZFUgo+IC0tCj4gMi40NS4yCj4KPgoKLS0gClJl
Z2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
