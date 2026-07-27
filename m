Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31BC8C531D0
	for <ltp@archiver.kernel.org>; Mon, 27 Jul 2026 18:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785177936; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=QTYCw8a7ZVNPVa1bYfQHM8uAshKR3aw1T+XaW+amUU0=;
 b=NrEf82akGCytqUOkSA8+AcrfMFl0q03shMdN7QiUMVdWUmDgFKi1axB5iaWzg65M3StEb
 TIdR0SBZE7B5Nbg8fxPckkjB3nUMvTFO0oOpoK35MmdXIiEDna3GjuGFF2D0Ui1R9XJfLlM
 /pHMJNKQNsVLkSkujnNC9hzTGs9Z+XY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE5993E6232
	for <ltp@archiver.kernel.org>; Mon, 27 Jul 2026 20:45:35 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5B2333C0401
 for <ltp@lists.linux.it>; Mon, 27 Jul 2026 20:45:13 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8D3C0600219
 for <ltp@lists.linux.it>; Mon, 27 Jul 2026 20:45:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785177910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Up5p5oOkZ/pE09F9Rvx/QF+X4+TIYT3YcEjjVosgOJM=;
 b=Yjt5wM/MMlz1gXtrwAM2+61b3B6r7TMwQVTsbqn2rR7fOYzO090osy0Eo5BKixJPcYZNhG
 iVc+ovcfE3pl+7q8acym+aQrB7B1FhnZuN86746lu1o/QlP9+qBrdtWnXdb9hMXAEueitq
 OUm4X4f76feAEcwBME9FhlpWMkmsQN8=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-XDpC_aA2PzydRasl43wThQ-1; Mon, 27 Jul 2026 14:45:06 -0400
X-MC-Unique: XDpC_aA2PzydRasl43wThQ-1
X-Mimecast-MFC-AGG-ID: XDpC_aA2PzydRasl43wThQ_1785177905
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cb4bd11ddf8so3529444a12.3
 for <ltp@lists.linux.it>; Mon, 27 Jul 2026 11:45:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785177905; x=1785782705;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Up5p5oOkZ/pE09F9Rvx/QF+X4+TIYT3YcEjjVosgOJM=;
 b=Vocg09VPhCPKlSB/3Ljbb9C1sy97KQeVVogLAe+/eQofVX0oUNau0zAn0aNrfHKc4b
 ax2qLaPvrvRKIpLodDdaSqRMqun2OEGOQ1GCMXS/3rqfab5qa/iQYP1SA1iJjngJXIyB
 shvLhfZJ1SeATRNOxv0zirZ3YdvgJOe0+UWsVzvhgeqLHGKknrdsMi1QJseJo23KUS/L
 mtPhjT9f4pTOGzqbOWKV3Qi99suYjgSFju5DAqrKEz3z3Wig3iVdsd6ds8YHq/Yzdv0Q
 2syZJn5QK1AQmJpO8nssBEXlqbkTLu7nY3KKFVDv1fOu6aiDVMEfR7iDwgLm4g2Gbppe
 yOUQ==
X-Gm-Message-State: AOJu0YzWaJFmyKXfaCJ7e4xinKoeyTLK538GY5LlDORj3jYuC7XF/jG9
 6Lymsk4kPXzt0mCoIhO6ZTiQ9KCie9pLmUpCqRK30K5sIQCcNh5eqW4R58X/ELvpYKbPDPh58ga
 DzaTUl8mQ0NQGSs3xA/pSWVwIBKtLahJmxSe/hYkfWVKIkY0VuXsCu84z9ZjQInDjH9rRT+JoQI
 pGKxrEf78XAolRh5jhsDn46or2034=
X-Gm-Gg: AR+sD10pUTqz7etaNvGHZ9qlb1iEFo1/V/iVQQUqIVG/GJaRux7gYjaUV4aoYA71GfE
 ufNlZAsteTpioiOT5CGWwHR9c5ngPqLskvqINe0BfgnOfaScaOKK4R24GsdOib3XekCsfzu81Az
 SxHsZdo6aguGr9cXYT5q9t+PGEGUc8KyAwv0HDYT7Be13p0Ck58FsrdildZBJb5yRVsGb5mTGwL
 oSn/yJ+WzEUaXxWJVVxBEfsBxVH51GVAaZz1w7FDcx0qEUi
X-Received: by 2002:a17:90b:3812:b0:380:f34a:6ff1 with SMTP id
 98e67ed59e1d1-38f29533026mr9688419a91.17.1785177905378; 
 Mon, 27 Jul 2026 11:45:05 -0700 (PDT)
X-Received: by 2002:a17:90b:3812:b0:380:f34a:6ff1 with SMTP id
 98e67ed59e1d1-38f29533026mr9688391a91.17.1785177904772; Mon, 27 Jul 2026
 11:45:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260722192052.3975-1-linuxtestproject.agent@gmail.com>
 <20260722212646.2340340-1-bgrech@redhat.com> <20260727082240.GA1010349@pevik>
In-Reply-To: <20260727082240.GA1010349@pevik>
Date: Mon, 27 Jul 2026 13:44:48 -0500
X-Gm-Features: AUfX_mxtSVuiAk_MGSmOE6VgExGj-HvlIIlQH81AJc9XalMLMDSrogtnnp6rqqk
Message-ID: <CAA835F7iF91Hrb099kbpG0+CR3WOBCH34C7tiB-4uJfNWjva8w@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Tx9qbqLy6RNpMM1Jcw5ofRZKhxAX0BeetnJuZnT8-Bw_1785177905
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] cve/icmp_rate_limit01: Lower icmp_msgs_per_sec
 for debug kernel reliability
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
From: Brian Grech via ltp <ltp@lists.linux.it>
Reply-To: Brian Grech <bgrech@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwKCkhhcHB5IHRvIGNvbnRyaWJ1dGUhCgpUaGFuayB5b3UgZm9yIGxldHRpbmcgbWUg
a25vdywgdGhhdCBpcyBzdHJhbmdlLiBPbiBteSBzeXN0ZW0gaXQncwpjb25maWd1cmVkIGNvcnJl
Y3RseS4gRGlnZ2luZyBhIGxpdHRsZSBkZWVwZXIsIEkgdGhpbmsgaXQgbWlnaHQgYmUgYQpjb3Jw
b3JhdGUgc210cCBpc3N1ZS4KCk9uIE1vbiwgSnVsIDI3LCAyMDI2IGF0IDM6MjnigK9BTSBQZXRy
IFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+IEhpIEJyaWFuLAo+Cj4gdGhhbmsgeW91
LCBtZXJnZWQhCj4KPiBCVFcgeW91IGhhdmUgd3JvbmcgZ2l0IHNlbmQtZW1haWwgc2V0dXAsIHRo
ZXJlZm9yZSBwYXRjaGVzIGFyZSBzZW50IHdpdGgKPiBhdXRob3I6Cj4gJ0JyaWFuIEdyZWNoIHZp
YSBsdHAgPGx0cEBsaXN0cy5saW51eC5pdD4nLiBZb3UncmUgbm90IGFsb25lIHdpdGggdGhpcwo+
IHNldHVwLgo+IEkgd29uZGVyIHdoYXQgaXMgY2F1c2luZyBpdCAoaXQnZCBiZSBuaWNlIHRvIGhh
dmUgaXQgZml4ZWQpLgo+Cj4gS2luZCByZWdhcmRzLAo+IFBldHIKPgo+CgotLSAKCi1CcmlhbgoK
LS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0
cAo=
