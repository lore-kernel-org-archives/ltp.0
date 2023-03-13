Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AEB9C74A4B
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 11:00:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 399323CADA9
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 12:00:00 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B7A393CADA9
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 11:59:49 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 762931A000B9
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 11:59:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678705186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N2x9vSDgh/6s2+uHdBRgn2vlPfI0M0d2Di3uQR0io0U=;
 b=InKhUJjdykRV8xdZ96mUu1de64KTb6uIHrzwGzalPOcawn/TSfDCjndrcqCjR8MLZ/9atv
 UWDNTR+XwKbsj5dS7VXNlVglsMwrqNEpRwENP8B3eix7jdOVsab/Pv3nC0cBrHa/P//7UU
 mlnJ6Rucf3LgLz/oYek1f8kXmY+ysZ4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-y3vUq9BtMfa2inh6qWZ6fg-1; Mon, 13 Mar 2023 06:59:42 -0400
X-MC-Unique: y3vUq9BtMfa2inh6qWZ6fg-1
Received: by mail-wm1-f70.google.com with SMTP id
 z6-20020a7bc7c6000000b003e0107732f4so4034422wmk.1
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 03:59:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678705181;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N2x9vSDgh/6s2+uHdBRgn2vlPfI0M0d2Di3uQR0io0U=;
 b=aw9luGWA3FkBuywpvfsrFqC7YpellGhx1s5h1/EgHOaD8OAaSvT17QbK5lMNoaIUNE
 g+EpvQTGu2fx2tu+4X0UxhpXWYI1o5mAbxXBbkTsK8+NP6s+DrIaB2RalMLQqGx9DAkD
 c+StfHHB53Q0VxUplPjcmRa5RuFIfN/nymv4otpWD3guoumCowgKl7SzJI46WsyeYkQF
 YhsZrkRdEKC5+6oTjKSr5YqGfu6alpvsq/zqyJl/C6r0M8x8liG2U2xE7GlWFOMN06It
 FpjX+DB6iuPfFWDPkOrZQqsacG7VL2iN8xROfiQ1Xck4uA19Mtb/z/qnCz8Aj6JdcByj
 WAfg==
X-Gm-Message-State: AO0yUKW/EzVVu/3Gbb7erQV9d/V5MZpR0m75zgwQcHhtni7+IGdpsIXE
 q6NfFLFGCxdc8Qq7xztSCp7cKoMTOcCyi6Hw/rUtRvQ/Wt9S9VK9rSnEDY3v1bUYV3GwOI/RqiB
 zM6PMb+uHDWfQ0O/z8T/shDSx2kw=
X-Received: by 2002:a05:600c:3d8f:b0:3e2:1a3f:4ea2 with SMTP id
 bi15-20020a05600c3d8f00b003e21a3f4ea2mr2990332wmb.7.1678705181090; 
 Mon, 13 Mar 2023 03:59:41 -0700 (PDT)
X-Google-Smtp-Source: AK7set+xOZ+Y2+HhpTYOkqmxxuEJoTTvz21+cRes2U8UnalGirjgJc6t1jLLUXWH1spoNhPsTf9QOrc1S7UzRFcUyqw=
X-Received: by 2002:a05:600c:3d8f:b0:3e2:1a3f:4ea2 with SMTP id
 bi15-20020a05600c3d8f00b003e21a3f4ea2mr2990329wmb.7.1678705180803; Mon, 13
 Mar 2023 03:59:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAEemH2esqAP+kfEgwXkSkw6V7ubFn+uq2_QdF_Nx1gF2t-WXzA@mail.gmail.com>
 <20230302074123.567654-1-liwang@redhat.com> <20230303083822.GB4255@pevik>
 <CAEemH2ffqNxiOMyGx1m+7RmAcj2OHk2vdCyA2ZVDEnU0PGOytw@mail.gmail.com>
 <8735696jhv.fsf@suse.de>
In-Reply-To: <8735696jhv.fsf@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Mon, 13 Mar 2023 18:59:29 +0800
Message-ID: <CAEemH2eTSKN6n-UzfNQ5P7VL6e2CuMmEAjepw7YZrVRZFzz+Ag@mail.gmail.com>
To: rpalethorpe@suse.de
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCh v2] madvise06: stop throwing failure when
 MADV_WILLNEED is ignored
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
Cc: Yongqiang Liu <liuyongqiang13@huawei.com>, Paul Bunyan <pbunyan@redhat.com>,
 Eirik Fuller <efuller@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBNYXIgMTMsIDIwMjMgYXQgNjoyMOKAr1BNIFJpY2hhcmQgUGFsZXRob3JwZSA8cnBh
bGV0aG9ycGVAc3VzZS5kZT4Kd3JvdGU6Cgo+IEhlbGxvLAo+Cj4gTGkgV2FuZyA8bGl3YW5nQHJl
ZGhhdC5jb20+IHdyaXRlczoKPgo+ID4gSGksCj4gPgo+ID4gT24gRnJpLCBNYXIgMywgMjAyMyBh
dCAzOjQ04oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgo+ID4KPiA+PiBI
aSBMaSwKPiA+Pgo+ID4+IExHVE0uCj4gPj4gQWNrZWQtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBz
dXNlLmN6Pgo+ID4+Cj4gPgo+ID4gVGhhbmsgeW91IGZvciB5b3VyIGFjaywgUGV0ci4KPiA+Cj4g
PiBJIHN0aWxsIHdhbnQgUmljaGFyZCBnaXZlcyBtZSBhIGZpbmFsIGNoZWNrLgo+ID4KPiA+IEBS
aWNoYXJkLCBkbyB5b3UgYWdyZWUgd2l0aCBwdXNoaW5nIGl0LCBvciBvdGhlciB0aG91Z2h0cz8K
Pgo+IEkgdGhpbmsgaXQgbmVlZHMgYXQgbGVhc3Qgb25lIHVuY29uZGl0aW9uYWwgdHN0X3JlcyhU
UEFTUywgLi4uKQo+IG90aGVyd2lzZSB0aGUgbGlicmFyeSB3aWxsIHJlcG9ydCBUQlJPSyBpZiB0
aGVyZSBpcyBubyBwYXNzIG9yIGZhaWwKPiByZXN1bHQuCj4KPiBQb3NzaWJseSBqdXN0IHRzdF9y
ZXMoVFBBU1MsICJOb3RoaW5nIGJhZCBoYXBwZW5kIHByb2JhYmx5IikgYXQgdGhlIGVuZAo+IG9y
IGNoZWNrIGZvciBrZXJuZWwgdGFpbnRzLgo+CgpHb29kIHBvaW50ISEhCgpJIGFkZGVkIHRoZSBr
ZXJuZWwgdGFpbnQgY2hlY2sgYW5kIHB1c2hlZC4gVGhhbmtzfgoKCgo+Cj4gV2l0aCB0aGF0Ogo+
IFJldmlld2VkLWJ5OiBSaWNoYXJkIFBhbGV0aG9ycGUgPHJwYWxldGhvcnBlQHN1c2UuY29tPgo+
Cj4gU29ycnkgZm9yIHNsb3cgcmVzcG9uc2UuCj4KPiAtLQo+IFRoYW5rIHlvdSwKPiBSaWNoYXJk
Lgo+Cj4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBz
Oi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
