Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C2F4EB64D7
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 08:38:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E14BF3CD332
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 10:38:10 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3CD663CA8D7
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 10:37:59 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4F0C36008DD
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 10:37:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687250277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rTPH8Pqkmn9baCjfEafiLZxVdJE0wCoXEVWVmXnLqoY=;
 b=cZSk03YmQ1QixdgTZn6F08df8iA2C9kbiT5iSAYhUPnmdTMnRRVgWt+LPCh8Glr8O0ec7o
 LRxgY/+MTJMFJltXP/sK9/Rw8gOCrGdoHSbcokZCSRhe+gqkxkPQFlzfnrWpJDjh8cdxhU
 IAXW+qxOfIhR81uAnUM16QRyKVxBaUo=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-OeasXDm8MsWYplMwO3mxyA-1; Tue, 20 Jun 2023 04:37:56 -0400
X-MC-Unique: OeasXDm8MsWYplMwO3mxyA-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b46d3eb01fso20532281fa.2
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 01:37:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687250275; x=1689842275;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rTPH8Pqkmn9baCjfEafiLZxVdJE0wCoXEVWVmXnLqoY=;
 b=Yu+k0ItbuxnMHCps0ts/+Bg1eVf+25wtGSKCUl+k0BJKtTwmaN8Jmm7HZpYcfTpYsi
 5c0+vTw0l9mBJAkPej/lYYufHITDqUQIGUaGL+Pf7bTkzFs1LUNdeOF1XwRZKD7fwjFH
 1HO6B6piFLSnStndkt6aTj6Muxe7+NrQ6LFq3wLFknZ9NgwfsvnmS2jlvZl4j+0HXUBo
 b3eeb7uFA7+QLZWZ5zFuRMJ39NpWDKW343ZMdHIaKLjicRg3bBI8Y4QX1d+ePpoAVnc+
 jZFn8aMxZKC07gjk4+M/m+JZ4P4XxSQ365SxHBa3/xvBk6Ssy47uZ2ZAozUHF7TMP4rs
 yeVw==
X-Gm-Message-State: AC+VfDwvYPe0MqBayXiIXuJJihzew0lHsZ1c8Tuujw27RoC8pyqy/Cmi
 zXcuulPNGSmdKP4ic+68LyJ3Abe/INmIFNvPu/znW9ORipfDIPkuJiHRGQPpQsBM94EZw/81ivG
 +LYlCSAt4BjBk5jjSZ6qebjjr2xM=
X-Received: by 2002:a2e:7e0e:0:b0:2b4:49e7:d443 with SMTP id
 z14-20020a2e7e0e000000b002b449e7d443mr6564830ljc.3.1687250274957; 
 Tue, 20 Jun 2023 01:37:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5V/WBDCopirsGDV1/d+Y9mJSie7qsDxQBGe/TYUeFb4LG1I/VQARdIVU3bMn02P8xPZdSZ8Fz5vicsLHzdK9U=
X-Received: by 2002:a2e:7e0e:0:b0:2b4:49e7:d443 with SMTP id
 z14-20020a2e7e0e000000b002b449e7d443mr6564683ljc.3.1687250271311; Tue, 20 Jun
 2023 01:37:51 -0700 (PDT)
MIME-Version: 1.0
References: <84e75a194e19b8519badb8a5db29b928150cca14.1687247631.git.souta.kawahara@miraclelinux.com>
 <CAEemH2cyEdy0QVZQTuH9hHhkPtgBfV+Aswp6QRCX0hBEUOZfQw@mail.gmail.com>
In-Reply-To: <CAEemH2cyEdy0QVZQTuH9hHhkPtgBfV+Aswp6QRCX0hBEUOZfQw@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 20 Jun 2023 16:37:39 +0800
Message-ID: <CAEemH2ejYND502tSx7fQ2XPNkRmWtOS4keGM2sQsG1vOLYOKoA@mail.gmail.com>
To: Souta Kawahara <souta.kawahara@miraclelinux.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v1 1/2] testcases/kernel: Add CVE tag to some
 existing tests.
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

SGksCgpPbiBUdWUsIEp1biAyMCwgMjAyMyBhdCA0OjMw4oCvUE0gTGkgV2FuZyA8bGl3YW5nQHJl
ZGhhdC5jb20+IHdyb3RlOgoKPgo+Cj4gT24gVHVlLCBKdW4gMjAsIDIwMjMgYXQgNDoxN+KAr1BN
IFNvdXRhIEthd2FoYXJhIDwKPiBzb3V0YS5rYXdhaGFyYUBtaXJhY2xlbGludXguY29tPiB3cm90
ZToKPgo+PiBTaWduZWQtb2ZmLWJ5OiBTb3V0YSBLYXdhaGFyYSA8c291dGEua2F3YWhhcmFAbWly
YWNsZWxpbnV4LmNvbT4KPj4KPgo+Cgo+IFJldmlld2VkLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVk
aGF0LmNvbT4KPgoKCj4gLS0tCj4+ICB0ZXN0Y2FzZXMva2VybmVsL21lbS9rc20va3NtMDUuYyAg
ICAgICAgICAgICAgICAgICAgfCA0ICsrKysKPj4gIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
aXBjL3NobWF0L3NobWF0MDMuYyAgICAgICB8IDEgKwo+Pgo+Ck15ICdSZXZpZWR3ZWQtYnknIGFw
cGxpZXMgdG8gYWxsIGV4Y2VwdCB0aGlzIHNobWF0MDMgY2hhbmdlLgoKCi0tIApSZWdhcmRzLApM
aSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlz
dGluZm8vbHRwCg==
