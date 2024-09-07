Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86396E6FE49
	for <ltp@archiver.kernel.org>; Sat,  7 Sep 2024 01:30:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 52ED13C04ED
	for <ltp@archiver.kernel.org>; Sat,  7 Sep 2024 03:30:22 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 746293C02D1
 for <ltp@lists.linux.it>; Sat,  7 Sep 2024 03:30:06 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 56A8E200AE6
 for <ltp@lists.linux.it>; Sat,  7 Sep 2024 03:30:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725672602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gs0NaJx4XBU732f0uMTxFOn863S76FU76hh4y0Yn/Go=;
 b=VQreqgU4nw0lFdnqDfSxG9XOJyD95rn2KL77Mogr3pbG076B2+osm8lI07stbD6qog/bOH
 kPcKUgn7YVk2mgsMOSBpm5OX+tr4SyD5XsfEjTjDNzdxZphtiWySRyLYrtinSYpdNPoF8h
 rxhzVoOqTnCgmQrCS3kQHGdz8q24zz4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-CoelwPT2MZyh1YvCM5vOhQ-1; Fri, 06 Sep 2024 21:30:01 -0400
X-MC-Unique: CoelwPT2MZyh1YvCM5vOhQ-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2d882c11ce4so2991105a91.2
 for <ltp@lists.linux.it>; Fri, 06 Sep 2024 18:30:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725672600; x=1726277400;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gs0NaJx4XBU732f0uMTxFOn863S76FU76hh4y0Yn/Go=;
 b=JMQGA6fHl3fmhxQ6LCnLrxXkAdtMpgEdDPDewEHj41consPRpeLGHCDFWBVlsAwDqA
 EcyBwvV9IDras8Y0wbbP0L64BhtANvjMiE1/s24KuyI7GJZfmCM/NZR653eMhbGK/TfI
 W/r9qO16WV8nf05tCBGZ0xlNhcd/PtUJEzz2a81xOANJRPKb8LtpJpAow/CWLt9mrxUo
 QGF41LN7QO1v9dvovlP1qQW4Z6kAXMUDIzIHURPV17DZQc9c/kAhKxeUQcR0+/XFeSdC
 ik7f9w3WWqI2o8p/HBpOStTOCsENgrp4sam2lpEFz1Hb6zDUt/CELhbymtut96EwXv6H
 zvDQ==
X-Gm-Message-State: AOJu0YzPyKldl7JqiEvzBDEUAdznfrBPyjH9W6xQF8jvgKgpx5ejlwuk
 85ing1v/MlOcehy/dpPc/+S5WmAGg0l8AF7Zx5oVSeLJTBiqN/qu1e+3aABLZVBlzGZvYJcafqv
 P+BjOX+wE3Df4HhtHh7fYUc0qYALL0c3leuXN+sqZkSD9fBSU2syEvU3gopqfHsfjz0IGehc7Vq
 HP6EEC0hAp5GPiXA2K8czV0o0=
X-Received: by 2002:a17:90b:4a0b:b0:2d3:d414:4511 with SMTP id
 98e67ed59e1d1-2dad5022bc3mr5577846a91.24.1725672600027; 
 Fri, 06 Sep 2024 18:30:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuNc1B7FHtGYwU9WYo03QRPK6zNA/1DMilUpBwnoM7YfN3W64RdOf7EzqBxoNxW8MZLCLiE+d6VZukuOnCGqA=
X-Received: by 2002:a17:90b:4a0b:b0:2d3:d414:4511 with SMTP id
 98e67ed59e1d1-2dad5022bc3mr5577824a91.24.1725672599430; Fri, 06 Sep 2024
 18:29:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240827120237.25805-1-chrubis@suse.cz>
 <20240827120237.25805-3-chrubis@suse.cz>
 <CAEemH2eQQfhTfVo5xrBHFjzuf4dn=VqK2M=9Y3+hy+r8yzMtAA@mail.gmail.com>
 <ZtrRCVxNKuu5ZdHN@yuki.lan>
 <CAEemH2eHa10SCrdVrPPTWZfQFpyDZ1poFEC=BL1raQECgpjf7g@mail.gmail.com>
 <ZtrmCfp5dPTx6vk_@yuki.lan> <ZtsDheQySS4co49v@yuki.lan>
In-Reply-To: <ZtsDheQySS4co49v@yuki.lan>
From: Li Wang <liwang@redhat.com>
Date: Sat, 7 Sep 2024 09:29:46 +0800
Message-ID: <CAEemH2cGN6YedNZf95Et3gfrcpxGzSq_ZfqWyXOWqdUs_=1kVg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3 2/4] Add support for mixing C and shell code
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBTZXAgNiwgMjAyNCBhdCA5OjMw4oCvUE0gQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1
c2UuY3o+IHdyb3RlOgoKPiBIaSEKPiA+IFRoZSBkaWZmZXJlbmNlIGlzIHRoYXQgL2Jpbi9zaCBs
aW5rcyB0byBkYXNoIGluIGRlYmlhbi4gQnV0IGFzIHlvdQo+ID4gcG9pbnRlZCBvdXQgZXZlbiBp
ZiBhbGwgL2Jpbi9zaCBpcyBjaGFuZ2VkIHRvIC9iaW4vYmFzaCBpbiB0aGUgc2NyaXB0cwo+ID4g
dGhlIHRlc3RzIHN0aWwgZmFpbHMuCj4gPgo+ID4gSXQgbG9va3MgbGlrZSBvbiBSUGkgYWxpYXMg
d2l0aCB2YXJpYWJsZXMgZG9lcyBub3Qgd29yayBhdCBhbGwuCj4KPiBTbyBpdCBsb29rcyBsaWtl
IGFsaWFzZXMgbWF5IG5vdCBiZSBleHBhbmRlZCBvbiBub24taW50ZXJhY3RpdmUgc2hlbGxzCj4g
dW5sZXNzIGl0J3MgZW5hYmxlZCBleHBsaWNpdGVseS4KPgo+IFRoaXMgcGF0Y2ggdXNlcyBzaG9w
dCB0byBlbmFibGUgdGhhdCBhbmQgYWxzbyB3b3JrcyBhcm91bmQgZGFzaCB0aGF0Cj4gZG9lcyBu
b3Qgc3VwcG9ydCAkTElORU5POgo+Cj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9saWIvdHN0X2Vu
di5zaCBiL3Rlc3RjYXNlcy9saWIvdHN0X2Vudi5zaAo+IGluZGV4IDY3YmE4MDc0NC4uYmIwYzU4
NmQ3IDEwMDY0NAo+IC0tLSBhL3Rlc3RjYXNlcy9saWIvdHN0X2Vudi5zaAo+ICsrKyBiL3Rlc3Rj
YXNlcy9saWIvdHN0X2Vudi5zaAo+IEBAIC02LDYgKzYsMTYgQEAKPgo+ICB0c3Rfc2NyaXB0X25h
bWU9JChiYXNlbmFtZSAkMCkKPgo+ICsjIGJhc2ggZG9lcyBub3QgZXhwYW5kIGFsaWFzZXMgaW4g
bm9uLWl0ZXJhY3RpdmUgbW9kZSwgZW5hYmxlIGl0Cj4gK2lmIFsgLW4gIiRCQVNIX1ZFUlNJT04i
IF07IHRoZW4KPiArICAgICAgIHNob3B0IC1zIGV4cGFuZF9hbGlhc2VzCj4gK2ZpCj4gKwo+ICsj
IGRhc2ggZG9lcyBub3Qgc3VwcG9ydCBsaW5lIG51bWJlcnMgZXZlbiB0aG91Z2ggdGhpcyBpcyBt
YW5kYXRlZCBieSBQT1NJWAo+ICtpZiBbIC16ICIkTElORU5PIiBdOyB0aGVuCj4gKyAgICAgICBM
SU5FTk89LTEKPiArZmkKPiArCj4gIGlmIFsgLXogIiRMVFBfSVBDX1BBVEgiIF07IHRoZW4KPiAg
ICAgICAgIGVjaG8gIlRoaXMgc2NyaXB0IGhhcyB0byBiZSBleGVjdXRlZCBmcm9tIGEgTFRQIGxv
YWRlciEiCj4gICAgICAgICBleGl0IDEKCgpMR1RNLgoKVGhpcyBlbnN1cmVzIHRoYXQgdGhlIHNj
cmlwdCB3aWxsIHdvcmsgaW4gYm90aCBiYXNoICh3aXRoIGFsaWFzIGV4cGFuc2lvbgplbmFibGVk
KQphbmQgZGFzaCAod2l0aCBhIGZhbGxiYWNrIGZvciBMSU5FTk8pLiBJIGNvbmZpcm1lZCB0aGF0
IHdvcmtzIGNvcnJlY3RseSBpbgpteSBSUGk0LgpUaGFua3MhCgoKLS0gClJlZ2FyZHMsCkxpIFdh
bmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5m
by9sdHAK
