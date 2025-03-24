Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15707C36002
	for <ltp@archiver.kernel.org>; Mon, 24 Mar 2025 13:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742821591; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=ZlyZI1cnSBL/D9ZbSeELNLAaxtBTp7Usvp2KBqN1Uuw=;
 b=cysVDbv/KKJmecbwwryx/OIU0DbffcD8/he2feII0KrP4Vg9CueZCmfpMhf6DPixD+E1k
 YJMWoW3NLKrVK6SmoMduc+PG+SMR3OYk6yF/4llWztbQGXvdqsW6oaqVXvfxhs6+s6wfwTj
 dZhhWBTmnU1yyMVuXHlzB/xmOUqCqvY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 43CA13C8EC7
	for <ltp@archiver.kernel.org>; Mon, 24 Mar 2025 14:06:31 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 000523C85D0
 for <ltp@lists.linux.it>; Mon, 24 Mar 2025 14:06:08 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4D07C201180
 for <ltp@lists.linux.it>; Mon, 24 Mar 2025 14:06:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742821566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hVmPsmWtX2sioQDm8RaAaiv5MP3cvscLMUiIVBglfno=;
 b=Que3wFLanqmwjO7G+ZdUfsLMW1E1ho/B+Eypy8RN9Ex1BX9pCuFGafB6rwHVQYeqcB2wmO
 cqayYHUCGT2q9HwlRrohrn4jyo1Cb7re1Ynhi4dvFFTrBLDAwlorrCog7a0qOnTSYtkKNA
 tViM7XtrvaTXdN5VoVv+Fx5aWvUwvdo=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-uaLpYsWGPnaiYrjmigf4_w-1; Mon, 24 Mar 2025 09:06:04 -0400
X-MC-Unique: uaLpYsWGPnaiYrjmigf4_w-1
X-Mimecast-MFC-AGG-ID: uaLpYsWGPnaiYrjmigf4_w_1742821563
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2ff5296726fso12737989a91.0
 for <ltp@lists.linux.it>; Mon, 24 Mar 2025 06:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742821563; x=1743426363;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hVmPsmWtX2sioQDm8RaAaiv5MP3cvscLMUiIVBglfno=;
 b=X4yPt+LRGAV5OGVjCJpuVMw1D56As14Df0z4dHCGwoHrBYHNMoZh5Ef7J1v6gJiBL+
 /hF8/+KBA0onAwOomNLfQZAXGWW4ppyTh7TbfuFwJIu07SRmWduKVBl5DQlfp5pnQbsj
 WA+0CYlRNeQVBi8Rbg28yYuS+a8WWLZLZPe8+KSQXno+fUwYJKh+4dHHP+u60nqH2MgX
 g9gMT55NxZVNSE3KNxFnKIiJt49nLjg/I+tPDhY2schqRfPaXcNaGlodceDMrqRyg1bW
 dPLx1dk/kcuh/q6W7OeEErXTbR1QXkg5VmtttBEjxEOK6pNDqGMDFEM3q1UuwOPFyJ40
 +0lw==
X-Gm-Message-State: AOJu0YzH656hs056iCAGrQ+Ha0zTqwF1AFWTHxNeT71ekOWBWm/f53Kz
 SM+6u+ZOapuMyM5xujX/BXd/ZIkaLSXHQ0ajktW0BqsTvAXw34IexGHNCpGr1QV2Twbl4UNYED+
 Ip5nS0P8pI3xwXEyvubx5oh0QmPNkJC7ayrJUcTcnjeEJe5NZFXLJ77dyKGzMbHO46PxBNZfV5t
 3mrdKvjbg1/urJRjfeKpcqg4w=
X-Gm-Gg: ASbGnctPQuzwy9tQkOHH1/8f/6TDmIrDEqavCqDt66F4Ecb+quvIE4IrQe8wLlK9DAZ
 9oyUeWVhbKVOQ/pYu42fC+lVaRm8n8eRB3C6urck5AEFbFncXz5EZr6+s27j8kdWXHMv5LHMtSQ
 ==
X-Received: by 2002:a17:90b:3b84:b0:301:98fc:9b5a with SMTP id
 98e67ed59e1d1-3030fe856e2mr16717591a91.6.1742821563389; 
 Mon, 24 Mar 2025 06:06:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHZvZbXter7ahPkME2oEkVYqQaaWAf3dS6gyvRF631oBcqFplT0+nxFwWoo8G9zvvmNlfrt6EZbgWTljzfCVc=
X-Received: by 2002:a17:90b:3b84:b0:301:98fc:9b5a with SMTP id
 98e67ed59e1d1-3030fe856e2mr16717540a91.6.1742821562804; Mon, 24 Mar 2025
 06:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250319172424.42961-1-mdoucha@suse.cz>
 <CAEemH2c8=bE6DkNXbS13-wNUXUYp1wSXiBEHNd+c5NNYKKfOdg@mail.gmail.com>
In-Reply-To: <CAEemH2c8=bE6DkNXbS13-wNUXUYp1wSXiBEHNd+c5NNYKKfOdg@mail.gmail.com>
Date: Mon, 24 Mar 2025 21:05:50 +0800
X-Gm-Features: AQ5f1Jrw5viaBm0oKMs6La2WlHKhL-SfbHoWiXcCRKZxP0NDC28JFEQT_owQ8jE
Message-ID: <CAEemH2fpibu2d5EY8yvWRM57F1fKk6RHfNef7zKZExB7Zn-_iw@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bfdDd6oD2A2xr9Au8rsrwqv-VV7HASYI--8EDBCjAUA_1742821563
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/2] move_pages12: Ignore ENOMEM from
 madvise(MADV_SOFT_OFFLINE)
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

UGF0Y2hzZXQgbWVyZ2VkLCB0aGFua3MhCgpPbiBUaHUsIE1hciAyMCwgMjAyNSBhdCA5OjQy4oCv
QU0gTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+IHdyb3RlOgoKPiBIaSBNYXJ0aW4sCj4KPiBJ
IGhhZCBldmVyIGFkZGVkIGEgY29tcHJlc3NlZCBtZW1vcnkgc3RlcCB0byBkaXMgZnJhZ21lbnRh
bAo+IGJlZm9yZSBkb2luZyBodWdlcGFnZSBhbGxvY2F0aW9ucyAoaW4gY29tbWl0IGU5N2Y0MTk3
MDU4MiApLAo+IGJ1dCB0aGF0IGRpZG4ndCBzZWVtIHRvIHNvbHZlIHRoZSBwcm9ibGVtIGlkZWFs
bHkuCj4KPiBBbnl3YXksIHRoaXMgcGF0Y2ggbG9va3MgZ29vZC4KPiBSZXZpZXdlZC1ieTogTGkg
V2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+Cj4KPgo+IE9uIFRodSwgTWFyIDIwLCAyMDI1IGF0IDE6
MjXigK9BTSBNYXJ0aW4gRG91Y2hhIDxtZG91Y2hhQHN1c2UuY3o+IHdyb3RlOgo+Cj4+IFRoZSB0
ZXN0IGRpc3NvbHZlcyBodWdlcGFnZXMgd2hpY2ggcmVzdWx0cyBpbiBzb2Z0LW9mZmxpbmUgbWFk
dmlzZSgpIGNhbGwKPj4gcmV0dXJuaW5nIEVOT01FTSBhZnRlciBhIGZldyBpdGVyYXRpb25zLiBU
aGlzIGlzIGV4cGVjdGVkIGJlaGF2aW9yLgo+PiBIb3dldmVyLAo+PiB0cnlpbmcgdG8gcHJlYWxs
b2NhdGUgbW9yZSBodWdlcGFnZXMgdG8gcHJldmVudCB0aGUgZXJyb3Igd2lsbCBicmVhawo+PiB0
aGUgYWJpbGl0eSB0byByZXByb2R1Y2UgdGhlIFNJR0JVUyBidWcuIFNpbXBseSBpZ25vcmluZyB0
aGUgRU5PTUVNIGVycm9yCj4+IGlzIGdvb2QgZW5vdWdoLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBN
YXJ0aW4gRG91Y2hhIDxtZG91Y2hhQHN1c2UuY3o+Cj4+IC0tLQo+PiAgdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9tb3ZlX3BhZ2VzL21vdmVfcGFnZXMxMi5jIHwgMiArLQo+PiAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS90
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21vdmVfcGFnZXMvbW92ZV9wYWdlczEyLmMKPj4gYi90
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21vdmVfcGFnZXMvbW92ZV9wYWdlczEyLmMKPj4gaW5k
ZXggODc5YTg5YjZmLi5hNTQ1NGIxZWMgMTAwNjQ0Cj4+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvbW92ZV9wYWdlcy9tb3ZlX3BhZ2VzMTIuYwo+PiArKysgYi90ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL21vdmVfcGFnZXMvbW92ZV9wYWdlczEyLmMKPj4gQEAgLTEwMCw3ICsxMDAs
NyBAQCBzdGF0aWMgdm9pZCAqYWRkcjsKPj4gIHN0YXRpYyBpbnQgZG9fc29mdF9vZmZsaW5lKGlu
dCB0cGdzKQo+PiAgewo+PiAgICAgICAgIGlmIChtYWR2aXNlKGFkZHIsIHRwZ3MgKiBocHN6LCBN
QURWX1NPRlRfT0ZGTElORSkgPT0gLTEpIHsKPj4gLSAgICAgICAgICAgICAgIGlmIChlcnJubyAh
PSBFSU5WQUwgJiYgZXJybm8gIT0gRUJVU1kpCj4+ICsgICAgICAgICAgICAgICBpZiAoZXJybm8g
IT0gRUlOVkFMICYmIGVycm5vICE9IEVCVVNZICYmIGVycm5vICE9IEVOT01FTSkKPj4gICAgICAg
ICAgICAgICAgICAgICAgICAgdHN0X3JlcyhURkFJTCB8IFRFUlJOTywgIm1hZHZpc2UgZmFpbGVk
Iik7Cj4+ICAgICAgICAgICAgICAgICByZXR1cm4gZXJybm87Cj4+ICAgICAgICAgfQo+PiAtLQo+
PiAyLjQ3LjAKPj4KPj4KPj4gLS0KPj4gTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCj4+Cj4+Cj4KPiAtLQo+IFJlZ2FyZHMsCj4gTGkgV2FuZwo+
CgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9s
aXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
