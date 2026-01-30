Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6669FD73EA8
	for <ltp@archiver.kernel.org>; Fri, 30 Jan 2026 00:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1769731304; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=21vlBFgxOkDgKTgXwujRYaB0075IglCq34R186sndEs=;
 b=JENBpqoRl0tN5wNN5veIEoFuClCIom+/lorqdCgSSbKWSbgLBSnVTA4P2EDC+fUG1NRFL
 Nj9j6FYapLcPA0P6j755+xszn7MVjSswYudTiOER/wd2bJVedNk30JNmgK5DimGad8djxEC
 I0uVmL3BUcM4dl7EoTQ+cCCnnXZZelg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 186CA3CB429
	for <ltp@archiver.kernel.org>; Fri, 30 Jan 2026 01:01:44 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1557A3C99DA
 for <ltp@lists.linux.it>; Fri, 30 Jan 2026 01:01:20 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 20BED14010D7
 for <ltp@lists.linux.it>; Fri, 30 Jan 2026 01:01:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769731277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4KxPRGdfegMBwQ/hLbFpzMjegW3BRDqHYNTfj1PyaQA=;
 b=aaoVDCjA7fpabXFrVn3KtpDL+c09eQ9hQI+c7rfmnQJGE/Ui0hWG8Foetfn9NQKTCOaZYV
 RfT33CTNZzkC9cinQ3gjAJCGCZm33sQH2qTzzHp6lsk/K4UVJ+FxGFTRs+kiM1XjqozKsz
 BKlwkU8JPsdwCm2qf1vhcW6/Y7AUHdw=
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com
 [74.125.82.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-AGYEVlJEPrCDJjafb3OI7g-1; Thu, 29 Jan 2026 19:01:16 -0500
X-MC-Unique: AGYEVlJEPrCDJjafb3OI7g-1
X-Mimecast-MFC-AGG-ID: AGYEVlJEPrCDJjafb3OI7g_1769731275
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-124a5098029so8297146c88.0
 for <ltp@lists.linux.it>; Thu, 29 Jan 2026 16:01:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769731274; x=1770336074;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4KxPRGdfegMBwQ/hLbFpzMjegW3BRDqHYNTfj1PyaQA=;
 b=JOQqokeC6eA+fkz2IQlClOoGEngzyH5fwk7Gr6aiLvpvaR/7QkmEYUn6I+jJYwNglL
 DA8f+PuvfJJ6OTKzsUXENjzD6NSl7Y9s74aYZ8ZOGbL7/iCNVK7/sZkO2oI1heAxyz3O
 kJaT/A1AjUeAFt5VivZN3EEBsUvxIeMZKD/34uuCtpicy+B/FCdp2jfAUEOEvEWmcjzp
 SxBN+eiMO5qrxTpsPAy7eAT+T3Jmf7VZUoKC9urR+aRpmHxC667Ho7wgSV3691fGyGGI
 DL8efmTOLAXxZb/mU49+SzAS6oeyK1fi0aSTFEcrI6T1G93St6D4BMIgI55s/PDjN6Cq
 ng8g==
X-Gm-Message-State: AOJu0YzeiQK13rCKXhdqvBiWj95BUCPSStZDKRMqGlZli7X89gD0prsT
 BJjYLtE0XS1gBzo8eJxQeZseAKiTiiwKlCgIxSvE2bfcWEwvGRqHFPDCySa84QJhVlCAycSQQtj
 aTRTFb9BTLDngySO0rJaOCb0syDUGa3d1iAFBpcKX8xPErkIGJP5Yzq4lVmJ+UiHl+q0vvqbYrO
 9asjc4/g5lqOgp06ghW5PCvrJaIDcsSEI2dRA=
X-Gm-Gg: AZuq6aL6Hd4nIaMjJzaiZ0eTfrMg88CYHYL8B6ZPhiN7lU97E7/1aYpSKUbT6VKhNIK
 12wgQOA1XICiLr1IONbLjB3zeh4qcyvPiFVteo4O3J/KlgWZd+msWKY3cBK5zkLgmzQEOwOBdFM
 qUkZUoTcB5dqnFx5kOd9P2lSN9Gsif0hW4UHwm1JSV3HOZf8v81tnBWQdWmEy9k1IZ5y0=
X-Received: by 2002:a05:7022:6899:b0:123:3584:de40 with SMTP id
 a92af1059eb24-125c10769aamr630119c88.50.1769731273780; 
 Thu, 29 Jan 2026 16:01:13 -0800 (PST)
X-Received: by 2002:a05:7022:6899:b0:123:3584:de40 with SMTP id
 a92af1059eb24-125c10769aamr630097c88.50.1769731273096; Thu, 29 Jan 2026
 16:01:13 -0800 (PST)
MIME-Version: 1.0
References: <20260129100011.72437-1-liwang@redhat.com>
 <CAEemH2fppgf4iJE4h1n3XSMw9v-hMF11BZAYjz_-9dHgKv0iFg@mail.gmail.com>
 <aXtttXRzAF7Qj0Ea@yuki.lan>
In-Reply-To: <aXtttXRzAF7Qj0Ea@yuki.lan>
Date: Fri, 30 Jan 2026 08:01:01 +0800
X-Gm-Features: AZwV_QhZiWOe_ellrS4PypCgHyOtegs7OxxdtzhyOZJZzVRjPRpaUW-6B14dX-4
Message-ID: <CAEemH2c2veKPDH1WhHsR8XGoSV8dhXMBot-y1W9YT0jxRb6Vtg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Y13Wfa3ZfpbwrhZ0l61b2Bd3k1o-qrpmhsirC3IsBvc_1769731275
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] cve-2017-17052: tolerate ENOMEM during test
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

T24gVGh1LCBKYW4gMjksIDIwMjYgYXQgMTA6MjPigK9QTSBDeXJpbCBIcnViaXMgPGNocnViaXNA
c3VzZS5jej4gd3JvdGU6Cgo+IEhpIQo+ID4gICAgICAgICBmb3IgKDs7KSB7Cj4gPiAtICAgICAg
ICAgICAgICAgU0FGRV9NTUFQKE5VTEwsIDB4MTAwMDAwMCwgUFJPVF9SRUFELAo+ID4gKyAgICAg
ICAgICAgICAgIHB0ciA9IG1tYXAoTlVMTCwgMHgxMDAwMDAwLCBQUk9UX1JFQUQsCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1BUF9QT1BVTEFURXxNQVBfQU5PTllNT1VTfE1B
UF9QUklWQVRFLAo+IC0xLCAwKTsKPiA+ICsKPiA+ICsgICAgICAgICAgICAgICBpZiAocHRyID09
IE1BUF9GQUlMRUQpIHsKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGlmIChlcnJubyA9PSBF
Tk9NRU0pIHsKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdXNsZWVwKDEwMDAp
Owo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsKPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgIH0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHRzdF9icmso
VEJST0sgfCBUVEVSUk5PLCAiVW5leHBlY3RlZCBtbWFwKCkKPiBlcnJvciIpOwo+Cj4gTWF5YmUg
dGhpcyBwYXJ0IHdvdWxkIGJlIG1vcmUgcmVhZGFibGUgd2l0aCBhbiBlbHNlIGJyYW5jaDoKPgo+
ICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChlcnJubyA9PSBFTk9NRU0pCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB1c2xlZXAoMTAwMCk7Cj4gICAgICAgICAgICAgICAgICAg
ICAgICAgZWxzZQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdHN0X2JyayhUQlJP
SyB8IFRURVJSTk8sICJtbWFwKCkgZmFpbGVkIik7Cj4KCkdvb2Qgc3VnZ2VzdGlvbiwgcGF0Y2gg
bWVyZ2VkIGxpa2UgdGhpcy4gVGhhbmtzIQoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFp
bGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
