Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DA8E7717D
	for <ltp@archiver.kernel.org>; Tue, 10 Dec 2024 02:07:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 170D53E8588
	for <ltp@archiver.kernel.org>; Tue, 10 Dec 2024 03:07:47 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8170A3E857E
 for <ltp@lists.linux.it>; Tue, 10 Dec 2024 03:07:31 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 76DFB6215A5
 for <ltp@lists.linux.it>; Tue, 10 Dec 2024 03:07:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733796448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4/66/C7eD/OcAt2xZWEEWaHKq6VUl0qI1p2C7QT2W24=;
 b=FlpGzWZyeoWkUYYVWH6tOmninl0DF+1GxQ1Z284lsoGqSy4UCprbw955j1D8GW5tAqP2en
 jQNwD7lRXV8w5bRD6jdOCOm3GOEjGgRpT5/8BGHv1R8fc8jS23S1RyypLgg/ISgICBZmMy
 OCXXf0QWOI/FygwXtQxdHqK/9hfV/vs=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-mdn_UAA6OdaqbsJv3juigA-1; Mon, 09 Dec 2024 21:07:26 -0500
X-MC-Unique: mdn_UAA6OdaqbsJv3juigA-1
X-Mimecast-MFC-AGG-ID: mdn_UAA6OdaqbsJv3juigA
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2ef8c7ef51dso2097038a91.1
 for <ltp@lists.linux.it>; Mon, 09 Dec 2024 18:07:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733796445; x=1734401245;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4/66/C7eD/OcAt2xZWEEWaHKq6VUl0qI1p2C7QT2W24=;
 b=IQRKeUNQWI1V9ml9B/ndYOZvB4N4C+WJAmdkuDrGU9FrdiR3uMX3++CzlJJ3JZt2M3
 Di1jisLmg0HCIbCRIyKkg1G/hxyiuo8O7oBRYWN8wiSUK8JYCBqoa9IoZ0NOm4gqyBNZ
 POGeoICZWnXZK/AGUZMhBvd2klbAAeDdSvlEsPOvUQei0IIiXTBGcnRizvBlgkb+71GG
 8muTvjMrrhrZYpdKTnsKzfQN4AzGMJfCV+Jm5QesovGNgon2/f2D6ysw+13n4b0ATLZg
 ljVSorQDZ5aeITV+0RYHIVnyxSrc4A2yHDQ0RuT2oj+7DVCRTUDdADKiXESFkjDxKUwV
 y61Q==
X-Gm-Message-State: AOJu0YweLt8ZLyO1fcKTkaD6KYavkui6fZkClrTDxty+F7WmhVwumcbM
 It0iE5qX/YzUYY+GcSIyd87LWQp76cGVBmn4GuzIboveZV2+NizDTb6Xr7hhW8II+EfSsFRD2cy
 YDtHxZhwHpv5DeT/nIvbvaN/LFvA7ZiPMGih/+enC3vkfW6JKCH0TYF+PmFewBaKCkTuGFBeITn
 yJnUTpgmy1YiBqC1Cct/6Rxo4=
X-Gm-Gg: ASbGncvgWD7MjDoi0BrsYiTKk0LKsV0nLmlZChOrFWyDyT+nVSbi23acKepw/DWLzZw
 FOzvBi4dt2B7LWqdTVRvO2U+f12v/m3kRba6e
X-Received: by 2002:a17:90a:cf18:b0:2ea:4c4d:95a1 with SMTP id
 98e67ed59e1d1-2efd5b76f1bmr2461141a91.17.1733796445126; 
 Mon, 09 Dec 2024 18:07:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGanvUF/1KlD0oD1rrhtRQ0Js9H8TllDc3SiF0pcPqS80/YZBVJl/m8Gz+JabO/WJm1HzIMvVfKJKXTrh3tyi8=
X-Received: by 2002:a17:90a:cf18:b0:2ea:4c4d:95a1 with SMTP id
 98e67ed59e1d1-2efd5b76f1bmr2461106a91.17.1733796444680; Mon, 09 Dec 2024
 18:07:24 -0800 (PST)
MIME-Version: 1.0
References: <20241206094938.92895-1-pvorel@suse.cz>
 <20241206094938.92895-2-pvorel@suse.cz>
 <CAEemH2fC96s866abHj7mk315GBP3Y1c+uSC-NhuG7P5ia2obKA@mail.gmail.com>
 <20241209101348.GA206052@pevik>
In-Reply-To: <20241209101348.GA206052@pevik>
From: Li Wang <liwang@redhat.com>
Date: Tue, 10 Dec 2024 10:07:12 +0800
Message-ID: <CAEemH2dpExk4HqzGEkpC-oBwnc-fRVMnwy0_n4LbfbS9OoJ1oA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eFt--uW_ns4ZTQx2Pv6whAUe8af8kMOGU1k07Y0WU80_1733796445
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/4] testcases/lib/run_tests.sh: Check expected
 results
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

T24gTW9uLCBEZWMgOSwgMjAyNCBhdCA2OjE04oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgoKPiBIaSBMaSwgYWxsLAo+Cj4gLi4uCj4gPiBXZSBjb3VsZCBhZGQgYSBibGFu
ayBsaW5lIHByaW50IGhlcmUgdG8gbWFrZSB0aGUgb3V0cHV0IGJldHRlciByZWFkYWJsZS4KPgo+
ID4gICBlY2hvICIiCj4KPiA+ICsgICAgICAgICAgICAgICBlY2hvICIqKiogUnVubmluZyAnJHRl
c3QnIChleHA6ICQodHN0X21hc2syZmxhZyAkZXhwKSkKPiAqKioiCj4KPiArMQo+Cj4KPiA+ID4g
KyAgICAgICAgICAgICAgICR0ZXN0Cj4gPiA+ICsgICAgICAgICAgICAgICByYz0kPwo+ID4gPiAr
ICAgICAgICAgICAgICAgaWYgWyAkcmMgPSAxMjcgXTsgdGhlbgo+ID4gPiArICAgICAgICAgICAg
ICAgICAgICAgICBlY2hvICJUZXN0ICckdGVzdCcgbm90IGZvdW5kLCBtYXliZSBvdXQtb2YtdHJl
ZQo+ID4gPiBidWlsZCBhbmQgdW5zZXQgYnVpbGRkaXI/IiA+JjIKPiA+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgZXhpdCAxCj4gPiA+ICsgICAgICAgICAgICAgICBlbGlmIFsgJHJjID0gMiAt
YSAkV0hJVEVMSVNUX0dJVEhVQiA9IDEgLWEKPiA+ID4gIiRHSVRIVUJfQUNUSU9OUyIgXTsgdGhl
bgo+Cj4KPiA+IElmIG9uZSBvciBtb3JlIHZhcmlhYmxlcyB1c2VkIGluIHRoZSBjb25kaXRpb25h
bCB0ZXN0IGFyZQo+ID4gZWl0aGVyIHVuc2V0IG9yIGVtcHR5LCB0aGF0IHdpbGwgbGVhZCB0byBp
bnZhbGlkIHN5bnRheC4KPgo+ID4gU28gSSB3b3VsZCBzdWdnZXN0IHVzaW5nIFsgLi4uIF0gYW5k
ICYmOgo+Cj4gPiAgIGVsaWYgWyAkcmMgPSAyIF0gJiYgWyAkV0hJVEVMSVNUX0dJVEhVQiA9IDEg
XSAmJiBbIC1uICIkR0lUSFVCX0FDVElPTlMiCj4gPiBdOyB0aGVuCj4KPiBHb29kIHBvaW50LiBP
ciBtYXliZSBqdXN0IHF1b3RlPwo+Cj4gZWxpZiBbICIkcmMiID0gMiAtYSAiJFdISVRFTElTVF9H
SVRIVUIiID0gMSAtYSAiJEdJVEhVQl9BQ1RJT05TIiBdOyB0aGVuCj4KClRoaXMgY2FuIHdvcmss
ICBidXQgdXNpbmcgLWEgY2FuIGxlYWQgdG8gYW1iaWd1b3VzIG9yIGhhcmQtdG8tZGlhZ25vc2UK
YmVoYXZpb3IuIEEgYmV0dGVyIGFwcHJvYWNoIHdvdWxkIGJlIHRvIHJlcGxhY2UgLWEgd2l0aCAm
Ji4KCk1heWJlIHRoZSBiZXN0IHdheSBpczoKCmVsaWYgWyAiJHJjIiA9IDIgXSAmJiBbICIkV0hJ
VEVMSVNUX0dJVEhVQiIgPSAxIF0gJiYgWyAtbiAiJEdJVEhVQl9BQ1RJT05TIgpdOyB0aGVuCgoK
Cj4KPiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgo+Cj4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAK
TWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
