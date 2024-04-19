Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03152C05052
	for <ltp@archiver.kernel.org>; Fri, 19 Apr 2024 08:48:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E374B3CFD74
	for <ltp@archiver.kernel.org>; Fri, 19 Apr 2024 10:48:31 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F8AC3CFB9B
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 10:48:18 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2A816600A3E
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 10:48:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713516495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qclGYAskjU61m43ToYDDBtZMwweLsQa5T0993IUWBWY=;
 b=FnUNn1A57hhTpMLcBDJLqGaW6fK9xi4DM2W1VQ2pfTxLLkbmlmnf8xu3NOtoTM9dIREBan
 vaxxNT5PtanrYFP0dud/zoLmB8xNbrzAEk+C6R4qK5y2T5Qk+4pYDf28OHqVL6GTwg+CW/
 8nRgmGoWn800pqBVy9bxnb7FwHuJDIU=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-a9Mc9KUwPeGLmQcYrwMfLg-1; Fri, 19 Apr 2024 04:48:13 -0400
X-MC-Unique: a9Mc9KUwPeGLmQcYrwMfLg-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5cec090b2bdso1798356a12.0
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 01:48:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713516492; x=1714121292;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qclGYAskjU61m43ToYDDBtZMwweLsQa5T0993IUWBWY=;
 b=EE2fDbw5Lg0kK5ywKGdp4Xcvfw4QuumElzCDoD1gG9UjLu3/2KV1op3gsIp8wnzZjZ
 2dJIA24xntpv6FnzOlH7Gaimclp9SjBSbO0oCjOSD7o8cKjx22wxMSj58DOUjbt5UjCg
 psPNqlkLsNXAvefP9+D9x85kVi85qqKfr+Fqq5Z/+Xjfbq7HDwpT6osKrXPz5C8L7JyN
 QjKMU6u8aBi6i84SeEuINs/HKtg6wSJjJFK3K4n+PU3hRSb/w7HeFiB6inOXd6pgYR8k
 Vk2AA1+E7pasi/CTcgsU5x/U9sFO+m3IZ8ptW/jDB8ySjS/tiWoTh3BqKp68Yw0mWWn1
 f4NQ==
X-Gm-Message-State: AOJu0YwG2jEmL+GGCJJCHARiDxcz7vPUKE9xOgCpULVxubkF8RtEF7Xw
 X+w+8nxGglWRoLoF1RwzOJwaUuXMv9eDbsw9XFbUntAWzwE5+55HTqkpBs7zeM7lbeXIbXa64o3
 /NHBeEYwCVVY/OlA0L17tsWvEbNHFsmD0VflOMZpv0MAf8/mohzzERo+9N2wYr+109PGuuTTeCP
 YAVfTBItKsbif1ZQMd6JFhHK8=
X-Received: by 2002:a05:6a21:7887:b0:1a9:d9bb:acdc with SMTP id
 bf7-20020a056a21788700b001a9d9bbacdcmr1989353pzc.28.1713516492034; 
 Fri, 19 Apr 2024 01:48:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGahbN1SUwJ88UL9V/gX+7/zmlI3lzGhHwxdGkkXb+DG8RhYbuh3aK7CgtGsGkcSUGGxZM95Uu1AiZRsmWCI2I=
X-Received: by 2002:a05:6a21:7887:b0:1a9:d9bb:acdc with SMTP id
 bf7-20020a056a21788700b001a9d9bbacdcmr1989338pzc.28.1713516491709; Fri, 19
 Apr 2024 01:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240418185210.132137-1-pvorel@suse.cz>
 <20240418185210.132137-2-pvorel@suse.cz>
 <CAEemH2dw83UCUg7tXnVuKqwDZtFfc8zEWq=SvLuRtzcA_4AV=w@mail.gmail.com>
 <CAEemH2fr5+L0UK4McWf7Aos9TciME7wHMQmVujNX8xQtZYUsqQ@mail.gmail.com>
 <20240419061206.GA143961@pevik>
In-Reply-To: <20240419061206.GA143961@pevik>
From: Li Wang <liwang@redhat.com>
Date: Fri, 19 Apr 2024 16:47:58 +0800
Message-ID: <CAEemH2fOvSCmnQfS2+w_mWxm6cxMy_-EVjT0-c6WL_w6krNF4Q@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 1/2] libswap: Add {SAFE_,
 }MAKE_MINIMAL_SWAPFILE() macros
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

T24gRnJpLCBBcHIgMTksIDIwMjQgYXQgMjoxMuKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gPiBPbiBGcmksIEFwciAxOSwgMjAyNCBhdCA5OjUw4oCvQU0gTGkgV2Fu
ZyA8bGl3YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gPiA+IEhpIFBldHIsIEN5cmlsLAo+Cj4g
PiA+IFRoZSBwYXRjaHNldCBnZW5lcmFsbHkgbG9va3MgZ29vZC4KPgo+ID4gPiBCdXQgSSBoYXZl
IGEgY29uY2VybiBhYm91dCB0aGUgbWFjcm8gbmFtZSAiTUlOSU1BTCIgd29yZCwKPiA+ID4gd2hp
Y2ggbWlzbGVkIHBlb3BsZSB0byB0aGluayB0aGF0IGlzIHRoZSBtaW5pbWFsIHN3YXBmaWxlIHNp
emUgd2UKPiA+ID4gY2FuIG1ha2Ugb24gdGhlIHN5c3RlbSwgYnV0IG9idmlvdXNseSBpdCBpcyBu
b3QsIHdlIGNvdWxkIGV2ZW4KPiA+ID4gY3JlYXRlIGEgc21hbGxlciBvbmUsIHJpZ2h0Pwo+Cj4g
PiA+IENhbiB3ZSByZW5hbWUgaXQgd2l0aCBhIGJldHRlciBvbmU/Cj4KPgo+ID4gV2hhdCBhYm91
dCBNQUtFX0RFRkFVTFRfU1dBUEZJTEUsIG9yIE1BS0VfVEVTVF9TV0FQRklMRT8KPgo+IEkgd2Fu
dCB0byBzb21laG93IGV4cHJlc3MgdGhhdCBpdCdzIGEgcmVhbGx5IHNtYWxsIHN3YXAgZmlsZQo+
IChhbHRob3VnaCBzdXJlLCBub3QgbWluaW1hbCkuIFN1cmUsIGl0IGNhbiBiZSAiZGVmYXVsdCIg
b3IgInRlc3QiLAo+IGJ1dCBpdCBkb2VzIG5vdCBzYXkgYW55dGhpbmcgYWJvdXQgdGhlIHNpemUu
Cj4KCldoeSBkbyB3ZSBoYXZlIHRvIGVtcGhhc2l6ZSB0aGUgInNtYWxsIiBzd2FwIGZpbGU/Cklm
IHdlIGNob29zZSB0byB1c2Ugb2YgImRlZmF1bHQiIDFNQiBmb3IgTFRQIHRlc3QgYnV0IG5vdApl
eHBsaWNpdGx5IGRlY2xhcmFudCBpbiB0aGUgbmFtZSwgdGhhdCdzIG9rYXksIHBlb3BsZSBjYW4K
Y2hlY2sgdGhlIGRlZmluZWQgdmFsdWUgaWYgdGhleSBhcmUgaW50ZXJlc3RlZC4KCgoKPgo+IEtp
bmQgcmVnYXJkcywKPiBQZXRyCj4KPgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
