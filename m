Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6808C3DA42
	for <ltp@archiver.kernel.org>; Wed, 17 Jul 2024 10:22:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 399BD3D1AC7
	for <ltp@archiver.kernel.org>; Wed, 17 Jul 2024 12:22:06 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E9CB53D1A6A
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 12:21:51 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2FAC1604850
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 12:21:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721211708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PykuZ1FYzlzbC9Y5BYCXoagJwVtPyl+s/aaA0g5WrpM=;
 b=JiQkHSR2FpSqsxo3v4ksvhIkCmPhRAk7R92dgsU5o5kDzJltSHjjWWzt2WMf67stG2/ocN
 ir2t9FAPRw325oUGwuK3LlgKUwJOdHUBy5zOwNZXFeUibs7fz84SjgXVt/isITaroQ2b1i
 La7sMm+p7fgDPZ5JYszUU10bzuIU5m8=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-ovNr3xkQNX2rXZqw73hX3Q-1; Wed, 17 Jul 2024 06:21:46 -0400
X-MC-Unique: ovNr3xkQNX2rXZqw73hX3Q-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-75fa4278316so4437677a12.3
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 03:21:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721211704; x=1721816504;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PykuZ1FYzlzbC9Y5BYCXoagJwVtPyl+s/aaA0g5WrpM=;
 b=l4p1FTQtfgE1PRznMd/PiEGo9DMnaEDOn5s+GW7zpfOT3b9duYJhAuZdBknYHE9cS/
 6nJEW2geyxwCT59POwuuuFxf/hhLHHYmoClRU5/QS1MH2WDQKG6HAYiZrLBHLfd1IZm9
 FT69YVcq2L0L0iKimj/LID83nDOoTYvCKuBPQItfDybWFTTvdzT3qwfCFstaYcTuTjB9
 tjmRk3MJmF3VJw3ogopFiJPDhfB+/sbUGMrDJaZCqRwPyVe1g6oS4mAtZFwuD4oiyCnY
 REEUSvj2GnINor2+lYbnJ0Oy9CxK5Mk31TdNgRTm7AadvY+xY4PU835VqpMoMbEDO3Wj
 Tl9g==
X-Gm-Message-State: AOJu0Ywn8zh4SsIu2droG1ehgVxJ11+hqXXqvyzVTeqEZSdiir8xWnBK
 YDTfE0AXHdq9uUtcMvWzIzLYupiK79dtDI1X1i5jQ9LotJ2Lw0b6ZN/6ZlGdZpqN3FvV4CTEadm
 hhxAriWHs0G/clKkopbTeh/rqhlkhZknCP/+ZGyXGl/FkD7IxfFGvR1M/HwvzHdTVaKE44J1FmG
 EDk3bj0ICVCAx2+ACrdbS0xQGCGSaQA01xDOpb
X-Received: by 2002:a05:6a20:3d81:b0:1c2:92a1:9320 with SMTP id
 adf61e73a8af0-1c3fdcbfddemr1680470637.7.1721211704121; 
 Wed, 17 Jul 2024 03:21:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUe2GxxkNcrZtDqgE/DfP1tt0KDcYMtptFO1PspvwcOD57nO3/qpb/iBqlhi9aTMNHrvfjM9lwLaQO41DiqmM=
X-Received: by 2002:a05:6a20:3d81:b0:1c2:92a1:9320 with SMTP id
 adf61e73a8af0-1c3fdcbfddemr1680454637.7.1721211703769; Wed, 17 Jul 2024
 03:21:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240716153604.22984-1-chrubis@suse.cz>
 <20240716153604.22984-2-chrubis@suse.cz>
 <CAEemH2cAfjhGLv3GWPA_5xgsFNYiRf-oQwyLPhbWWSPKn=yAhw@mail.gmail.com>
 <ZpeGRluc-U1NHjNY@rei>
In-Reply-To: <ZpeGRluc-U1NHjNY@rei>
From: Li Wang <liwang@redhat.com>
Date: Wed, 17 Jul 2024 18:21:31 +0800
Message-ID: <CAEemH2f4sO40tJxT2wokw=SDaeAvNhR-z8NOqW0=xWSKSv3Wsg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [RFC PATCH 1/2] Add support for mixing C and shell code
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

T24gV2VkLCBKdWwgMTcsIDIwMjQgYXQgNDo0OeKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiBTaW5jZSBleGVjdnBlKCkgaXMgYSBHTlUgZXh0ZW5z
aW9uLCB3ZSBuZWVkIHRvIGVuc3VyZSB0aGF0Cj4gPiB3ZSBhcmUgY29tcGlsaW5nIHdpdGggR05V
IGV4dGVuc2lvbnMgZW5hYmxlZC4KPiA+Cj4gPiBhZGQgdGhpcyBsaW5lIGludG8gdGhlIGhlYWQg
b2YgdHN0X3Rlc3QuYzoKPiA+ICNkZWZpbmUgX0dOVV9TT1VSQ0UKPgo+IEFzIGZvciB0aGUgZXhl
Y3ZwZSgpIEkndmUgdXNlZCB0aGF0IGZvciB0aGUgcHJvdG90eXBlIGJ1dCBJJ20gdW5zdXJlIGlm
Cj4gaXQgY291bGQgYmUgdXNlZCBpbiB0aGUgZmluYWwgcHJvZHVjdCwgc2luY2UgdGhpcyBpcyB0
aGUgdGVzdCBsaWJyYXJ5IGl0Cj4gaGFzIHRvIGNvbXBpbGUgb24gYWxsIGtpbmRzIG9mIGxpYmMg
b3V0IHRoZXJlLiBJdCBsb29rcyBsaWtlIG11c2wgZG9lcwo+IHN1cHBvcnQgaXQgYnV0IEkgaGF2
ZW4ndCBjaGVja2VkIEFuZHJvaWQgYmlvbmljLgoKCj4gU28gd2UgbWF5IG5lZWQgdG8gd3JpdGUg
b3VyIG93biBpbXBsZW10YW50aW9uIG9uIHRoZSB0b3Agb2YgdGhlIGV4ZWN2ZSgpCj4gc3lzY2Fs
bC4gQnV0IHRoYXQgc2hvdWxkIGJlIGFzIGVhc3kgYXMgZ2V0dGluZyB0aGUgcGF0aCB0byB0aGUg
c2NyaXB0Cj4gYmVmb3JlIHdlIHBhc3MgaXQgdG8gZXhlY3ZlKCkuCj4KCkluZGVlZC4gIFdlIG5l
ZWQgdG8gY3JlYXRlIGEgbHRwX2V4ZWN2cGUoKSBiYXNlZCBvbiBleGVjdmUoKS4KCi0tIApSZWdh
cmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
