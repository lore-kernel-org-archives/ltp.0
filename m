Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A78C55175
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 09:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785749430; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=1qTuow1oo3qhwdJsU964iKnYOQxJorgt7pCM5E9ZhFw=;
 b=oME18FKfnxHBS8XT9sGQ7r+DGZsOBYx3nQ/FbFf18y5SD8kV09ImYmNq4WghvqYxTKRK8
 fEagRK6x9b0QrUxDpG6NQMelhvqgfFE/2/LyFs/REgPQ+UbbiVsMs13lggUzxN+sHD3g71k
 UHsDza8BZV2eAkJiVtzUN0ERqQqnlik=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD6F53E4B7F
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 11:30:30 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9C3D93C27B3
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 11:30:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B32F81000619
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 11:30:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785749409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jNBIiLQPUnYGy8j15m7MgCIPW2IIz0fkX4+wXAZsLU8=;
 b=HmrdcKc6usiG4z2+tvwHaIYtilOsCdIcD9tD7bTPYzCdMO0E2NVCc463r04as0Zu2xhCuf
 Gb5vDllcO0UbQzpPLezLMakBpe0QBTdRfhQlTSqwyAw1xaD4grpDREXKOGxC98m+nGUPrH
 9risqgSh/5z0M2UIcHxH1t4SIEdU/q0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-qQ8U-ikPPZu4lpB743lgog-1; Mon, 03 Aug 2026 05:30:07 -0400
X-MC-Unique: qQ8U-ikPPZu4lpB743lgog-1
X-Mimecast-MFC-AGG-ID: qQ8U-ikPPZu4lpB743lgog_1785749407
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-473ac08a6a4so2515183f8f.0
 for <ltp@lists.linux.it>; Mon, 03 Aug 2026 02:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785749406; x=1786354206;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jNBIiLQPUnYGy8j15m7MgCIPW2IIz0fkX4+wXAZsLU8=;
 b=mVpva5hKp35kNG3EjKem01LgaoWwiC+EvmaIKWQNAYiDatkGGxIDUc7F+pKQddtQPw
 YrEzsPG41GR3IAuLAzTg47ypYTmadkGHckp9ptDE1mCnwEiHxYYuX7mj1kLTV2kBRMjh
 jHNz0SJj/FGG+9Fy1Nhv7nIkA9Q/7xmVpTsHEYBd2gXH7fYMyTg2go4GieCl4wngWkmd
 gVC5SnfUgEKkJ8CmKo/5lLQzqztGc72W7XNFM2yklguEr6bjBp5PrjwGWyqEREBqq/G3
 SoMYJpxV97nS0goeLyOa07ALugZ5koErnbFvPmhV1hMHW8yLQf7EMUqw0X5Ok6QLiXjr
 wLtA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrVtMPa2W9l9NFPaaFnNlPE+4Ev4Rqc9VTnHu5pUzijQTA9AbfLMPb/iXYSxYREAF1/Ce8=@lists.linux.it
X-Gm-Message-State: AOJu0Yx2AtWat//8pGM+34d0bRkA2x1E4IBkqyF8C7rQNSWV8g/LzaDK
 IeF37hhtQKJaXH60t9muwVZyeQYicpTYBcPCBrcy56WSD7b8F2il/eEoi1taP95XgHwW5h5Ggbc
 0FXPH7VV4QeetZ7vAHy23e03UfmQv7jZkzE/J4zdRhkHgoAJQuHMguubclIl8qHOhcGUlNS2sQX
 +FdQE3oWP5U5NYa/0D57UjKCiDJPM=
X-Gm-Gg: AR+sD12/sJEnL8WrprJ8m4Q7O/pOK8p4Ea5YczShYOzmFEDs5aFbSGd2t7Wp8tW2bGb
 a7sb1gEBCuer1ArSGZZldz20KDtFxHxC+hG9eq/2jaGoLCtB2s/EHyILeO29v21I6dUuUTk1ExF
 nbaBBQqTg+F7Yj4yiTS3JIusGmUGJSroyQrgRdD4fjwE2OdWD64p7I90NT
X-Received: by 2002:a05:6000:29d7:b0:46e:230f:d095 with SMTP id
 ffacd0b85a97d-47fd72ab2e7mr13915778f8f.7.1785749406671; 
 Mon, 03 Aug 2026 02:30:06 -0700 (PDT)
X-Received: by 2002:a05:6000:29d7:b0:46e:230f:d095 with SMTP id
 ffacd0b85a97d-47fd72ab2e7mr13915721f8f.7.1785749406221; Mon, 03 Aug 2026
 02:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260731054548.133241-1-pvorel@suse.cz>
 <6a6c5226.d5b2c389.166717.d42a@mx.google.com>
 <20260803091348.GA216243@pevik>
In-Reply-To: <20260803091348.GA216243@pevik>
Date: Mon, 3 Aug 2026 11:29:49 +0200
X-Gm-Features: AUfX_mzwGOdKQHk-qPAqaGMQIK2wEJYXUT-PAFb_ocHYodtsU3zMsNF9TcEAcAc
Message-ID: <CAASaF6xC0wxDm+UDBVpmoZesPHuGsP5kEnpRqL=zLeDxNxTcMw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MNswUF4zy-Swr58a2SKEjz8ybBGMgVVIm69Y9FC6Tyk_1785749407
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] Switch to patchwork.kernel.org
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
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBBdWcgMywgMjAyNiBhdCAxMToxNOKAr0FNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IEhpIGFsbCwKPgo+IHNpbmNlIHdlIGhhdmUgYWxsIGFjdGl2ZSBMVFAg
bWFpbnRhaW5lcnMgZW5hYmxlZCBhcyBwYXRjaHdvcmsgbWFpbnRhaW5lcnMgaW4gdGhlCj4ga2Vy
bmVsLm9yZyBpbnN0YW5jZSBbMV0gSSdkIGxpa2UgaW4gZmV3IGhvdXJzIG1lcmdlIHRoaXMgcGF0
Y2ggdG8gZmluYWxseSBtb3ZlCj4gdG8gcGF0Y2h3b3JrLmtlcm5lbC5vcmcuIEZZSSB3ZSBhbHJl
YWR5IGhhdmUgMTggcGF0Y2hlcyBvbiBpdCwgQUkgcmV2aWV3IGlzCj4gdGhlcmUgYXMgd2VsbC4K
Pgo+IEBDeXJpbCBATGkgQEphbjogQ291bGQgeW91IHBsZWFzZSBhY2sgdGhpcyBwYXRjaD8KCkFj
a2VkLWJ5OiBKYW4gU3RhbmNlayA8anN0YW5jZWtAcmVkaGF0LmNvbT4KCj4KPiBJIHdvbmRlciB3
aGVuIHRvIHN0b3AgcmVjZWl2aW5nIHBhdGNoZXMgb24gdGhlIG9sZCBvemxhYnMgaW5zdGFuY2Ug
WzJdIFdlIHNob3VsZAo+IHByb2JhYmx5IGFzayBmb3IgaXQgc29vbiBzbyB0aGF0IHBlb3BsZSBk
b24ndCB0aGluayB3ZSBzdG9wIG1haW50YWluaW5nIGl0LiBJCgpBZ3JlZWQsIEkgdGhpbmsgd2Ug
YWxyZWFkeSBjYW4gYXNrIGZvciB0aGF0LgoKPiBob3BlZCB0aGF0IHRoZSBsYXN0IHBhdGNoIG9u
IHRoYXQgaW5zdGFuY2Ugd291bGQgYmUgIlN3aXRjaCB0bwo+IHBhdGNod29yay5rZXJuZWwub3Jn
IiBbM10sIGJ1dCB0aGVyZSBhcmUgbmV3IHBhdGNoZXMgbm93LiBPVE9IIHdlIHRoZW4gbm8gbG9u
Z2VyCj4gZ2V0IHVwZGF0ZXMgZm9yIHRoZSBvbGQgcGF0Y2hzZXRzICh0aGVyZSBhcmUgNTQgcGF0
Y2hlcyB3aGljaCBhcmVuJ3Qgb24gdGhlIG5ldwo+IGtlcm5lbC5vcmcgaW5zdGFuY2UgKyBhbHJl
YWR5IDYgZHVwbGljYXRlcykuCj4KPiBPdGhlciBxdWVzdGlvbiBpcyB3aGVuIHRvIGFzayBhYm91
dCBmb3IgcmVtb3ZpbmcgdGhlIG9sZCBpbnN0YW5jZS4gSSdkIGtlZXAgaXQKPiBhdCBsZWFzdCBm
b3Igc29tZSB0aW1lIChjYW4gYmUgdXNlZnVsICsgdGhlcmUgbWlnaHQgYmUgYm9va21hcmtzLCBp
bnN0YW5jZSBoYXMKPiAxMzA3OSBwYXRjaGVzLCBmaXJzdCBvbmUgaW4gMjAxOC0wMi0yOCkuIFdE
WVQ/CgpJJ2Qga2VlcCBpdCB0b28gZm9yIG5vdy4KCj4KPiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgo+
Cj4gWzFdIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9sdHAvCj4gWzJdIGh0
dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC9sdHAvbGlzdC8KPiBbM10gaHR0cHM6
Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L2x0cC9wYXRjaC8yMDI2MDczMTA1NDU0OC4x
MzMyNDEtMS1wdm9yZWxAc3VzZS5jei8KPgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6
Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
