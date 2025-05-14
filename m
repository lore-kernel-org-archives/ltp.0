Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4312C3ABCC
	for <ltp@archiver.kernel.org>; Wed, 14 May 2025 13:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747228122; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Bc3710QZqFQGQbdj4LXIVruHfMv5+BUN9ZzCHgzCfOE=;
 b=ocm/VTbuXXlerYvSCwxgI5UqCpP56UjE7dBLycAujucYv/CpVU2J+TyoSYrMID6FC7Xtb
 iHJowphc9fkXaaDKKpeIWjJJD5/cTFmLdvDPplUHSH3NICbBYVVny1nUezhdDZNCPVMNdKW
 Z4gdJi76sAPyNa1jKoCO9dbatjkchn8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E4D83CC3C7
	for <ltp@archiver.kernel.org>; Wed, 14 May 2025 15:08:42 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9C67E3C9F55
 for <ltp@lists.linux.it>; Wed, 14 May 2025 15:08:21 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 02E702000B2
 for <ltp@lists.linux.it>; Wed, 14 May 2025 15:08:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747228099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=11LgvUE7wL813vmX47BYYeHtk5zQRKbrrxb7ocs8SSo=;
 b=SYWCUPZiSi8nNocvfw9RNCRJ2KZqcdTUbnPm3mWIzeepKkTclz8Zb6rREclRGzIGjyeTzH
 6uolh0xsNaApkX6maiRXQf7Sz42uikYvg3TJ4ZVoh7KDJ1V2JGC04d/33QiTtEQemmtOvn
 dG3kJBsj2B4qKTu/y24yJ7bmbK/5gf4=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-zr21KIpCOweAw7mJn_aiqg-1; Wed, 14 May 2025 09:08:17 -0400
X-MC-Unique: zr21KIpCOweAw7mJn_aiqg-1
X-Mimecast-MFC-AGG-ID: zr21KIpCOweAw7mJn_aiqg_1747228096
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b1fa2cad5c9so4089765a12.2
 for <ltp@lists.linux.it>; Wed, 14 May 2025 06:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747228096; x=1747832896;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=11LgvUE7wL813vmX47BYYeHtk5zQRKbrrxb7ocs8SSo=;
 b=X6miHolh5t67nbMNe2QmiPNkIdtpHFBHU3+4aGEaZGej+btpnP5iLWGNkUjxzZlPjZ
 Arl2UgVMjSDxU4QigXRTFNpztsQg/MYurdr/2xqDkE/hAXTXNzywMLPLHI7Xc6kYqcuO
 y0pk+RscRZHv0VNNR1zdIo1lS0s3YXv8+suR1zu8KMZy0vZErc/DFwvJpCqUisG4wQYV
 ytSifHlvl23iEYhDLWVn/9QN7uoqKmcDiRIgxSWsF7vmxoKpQMeQ7AF/MvxqPgHMBccP
 7EM6Mutk6W1y14xr9k+BPDWgOvMZyn25aU6pyg7+2j59EsHYZo7zgv9KEcLDvEpWy5XR
 fSXQ==
X-Gm-Message-State: AOJu0Yw+t0vjiJ5NuSFMDkwhkWsRM53xsRo7yOtvf0fyUhZ0em9TqFvP
 T8uQiaXUa7GC1ENMltPP/oP/RnyQOwlN30G7oRm1qTUGKKdCEmOafgiAi6DLJHOHyuaRLiXdg/p
 70SSAeh76yz2SYr78SUohZt97hsclxU0bb3LpLs/8S0w03BDNvKTg41mr2rcXb+DQzvBtPcpxCA
 2ROkNuwoLDARi6U+IhOr+EOqE=
X-Gm-Gg: ASbGnctSk0DnWWTBOrCKHrFReeFeKHebiFSXWm00xXKTmlRdKf4iKLlRbfJslLO8GNn
 kKgxnbwHNRvQ6gGdQT4qyXaQG2uwy4acQokp8Lok7vwAMb7yQYQlntUh+fL7sm5Ms9KbyLA==
X-Received: by 2002:a17:903:3c26:b0:220:d909:1734 with SMTP id
 d9443c01a7336-23198125634mr50757565ad.14.1747228095778; 
 Wed, 14 May 2025 06:08:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERz1Wz3rvSailsAaptjNXA9814iigz/Q0cGMRbLHPjc8vQ515lvbfcov0W22g2DjOF7fT/XDScSKKzhbBzxXI=
X-Received: by 2002:a17:903:3c26:b0:220:d909:1734 with SMTP id
 d9443c01a7336-23198125634mr50757195ad.14.1747228095438; Wed, 14 May 2025
 06:08:15 -0700 (PDT)
MIME-Version: 1.0
References: <08c85cf64d703dfaba31398ab9d9b480488fe338.1747227481.git.jstancek@redhat.com>
In-Reply-To: <08c85cf64d703dfaba31398ab9d9b480488fe338.1747227481.git.jstancek@redhat.com>
Date: Wed, 14 May 2025 21:08:03 +0800
X-Gm-Features: AX0GCFu2a5TKKanaFMo5X2f9g8rIv-m1Gz9iHLft0DHRrEVMJPyKIkhDjdNh3mU
Message-ID: <CAEemH2eK5S=xbr-guG9cQiah5CyjAFPpN3X3H+jfCXhF6hiamA@mail.gmail.com>
To: Jan Stancek <jstancek@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: y7DlhJrkKHe0T-ekppySXGaDis8J1E_bNzBiZbJlr54_1747228096
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/mmap22: set also memory.swap.max
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
Reply-To: Li Wang <liwan@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBNYXkgMTQsIDIwMjUgYXQgODo1OOKAr1BNIEphbiBTdGFuY2VrIDxqc3RhbmNla0By
ZWRoYXQuY29tPiB3cm90ZToKPgo+IEluIHNvbWUgZW52aXJvbm1lbnRzLCB0aGUgc3lzdGVtIGFw
cGVhcnMgdG8gYmUgYWJsZSB0bwo+IHN3YXAgaW4gZmFzdGVyIHBhY2UgdGhhbiB3aGF0J3MgbmVl
ZGVkIGZvciBhbGxvY2F0aW9uCj4gdG8gYmUgRFJPUFBFRC4gU28sIHNldCBsaW1pdCBhbHNvIGZv
ciBtZW1vcnkuc3dhcC5tYXggdG8KPiBhdm9pZCBzd2FwIHVzYWdlLgo+Cj4gU2lnbmVkLW9mZi1i
eTogSmFuIFN0YW5jZWsgPGpzdGFuY2VrQHJlZGhhdC5jb20+CgpBY2tlZC1ieTogTGkgV2FuZyA8
bGl3YW5nQHJlZGhhdC5jb20+CgpBbmQgSSB2b3RlIHRvIG1lcmdlIHRoaXMgb25lIGJlZm9yZSB0
aGUgTFRQIE1heSByZWxlYXNlLgoKPiAtLS0KPiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9t
bWFwL21tYXAyMi5jIHwgNCArKysrCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykK
Pgo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21tYXAvbW1hcDIyLmMg
Yi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21tYXAvbW1hcDIyLmMKPiBpbmRleCAwZTU4OWRm
YWJmNDUuLjE1MDdmZGZhNzhjMyAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL21tYXAvbW1hcDIyLmMKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21tYXAv
bW1hcDIyLmMKPiBAQCAtMzIsNiArMzIsMTAgQEAgc3RhdGljIHZvaWQgdGVzdF9tbWFwKHZvaWQp
Cj4KPiAgICAgICAgIGNnX2NoaWxkID0gdHN0X2NnX2dyb3VwX21rKHRzdF9jZywgImNoaWxkIik7
Cj4gICAgICAgICBTQUZFX0NHX1BSSU5URih0c3RfY2csICJtZW1vcnkubWF4IiwgIiVkIiwgTUVN
X0xJTUlUKTsKPiArICAgICAgIGlmICghVFNUX0NHX1ZFUl9JU19WMSh0c3RfY2csICJtZW1vcnki
KSkKPiArICAgICAgICAgICAgICAgU0FGRV9DR19QUklOVEYodHN0X2NnLCAibWVtb3J5LnN3YXAu
bWF4IiwgIiVkIiwgMCk7Cj4gKyAgICAgICBlbHNlCj4gKyAgICAgICAgICAgICAgIFNBRkVfQ0df
UFJJTlRGKHRzdF9jZywgIm1lbW9yeS5zd2FwLm1heCIsICIlZCIsIE1FTV9MSU1JVCk7Cj4gICAg
ICAgICBTQUZFX0NHX1BSSU5URihjZ19jaGlsZCwgImNncm91cC5wcm9jcyIsICIlZCIsIGdldHBp
ZCgpKTsKPgo+ICAgICAgICAgYWxsb2MgPSBTQUZFX01NQVAoMCwgYWxsb2Nfc2l6ZSwgUFJPVF9S
RUFEIHwgUFJPVF9XUklURSwKPiAtLQo+IDIuNDcuMQo+CgoKLS0gCk1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
