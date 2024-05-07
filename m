Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 013C8C25B10
	for <ltp@archiver.kernel.org>; Tue,  7 May 2024 01:30:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 39D8E3CDBBA
	for <ltp@archiver.kernel.org>; Tue,  7 May 2024 03:30:04 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2E4BB3C8658
 for <ltp@lists.linux.it>; Tue,  7 May 2024 03:29:49 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 51DF16225DB
 for <ltp@lists.linux.it>; Tue,  7 May 2024 03:29:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715045386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MoOQZ6PljpK4uCFcN/bAicMtv6s6R3mWBD9dqlBYdUs=;
 b=iv7si+SbG0CU4U6m/J2KWFYSKgkphZJO0dYBmrbnTvqGXqNGG4L1+L7VHeRSPRFEcxdiYs
 kcB87d/6av5fUwJeBLw9f6XvAdFsSfhcRH46IzifI9xIQT4LfGcaU16upOuwKQOBSPn8Ud
 IwX5OxkB543MlDq1aJPF0m7A6MacD1s=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-lF4LtSGaN_yYKNsw_O-EzQ-1; Mon, 06 May 2024 21:29:43 -0400
X-MC-Unique: lF4LtSGaN_yYKNsw_O-EzQ-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-61a119df58fso1778259a12.1
 for <ltp@lists.linux.it>; Mon, 06 May 2024 18:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715045381; x=1715650181;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MoOQZ6PljpK4uCFcN/bAicMtv6s6R3mWBD9dqlBYdUs=;
 b=WG6CZkzM/nL2NgguwFbYEc6Bx556wkcZqP0B0o5mdzsCHe+x81CbMh/8HfFLRBqW/c
 rKwCKSkOqUWCG2HfsD9vNeo1Lh99XEmVAKNcRn556XhYriaPO9E/TN+FisK25AFn+1Zf
 /BzRJgR9zEtXWZehUHfTzJNDk6Vh/ZZi9bCzDOLQQCs+kVUWMMe0y0F099AFdS4E9L3K
 hcOyY4Cg+JA0/Xv67+/WGbJRkQ14caM24FIaGlU2un8ZOCYdoK1rhR4zSX3RmaYXFtkR
 eUiyYnqEtSikn64l7+eUW1Ei/h+s0r8rFXPTvuxSkqxHVB6aq7JSEXhT2AUI6rrjX3uV
 OfBA==
X-Gm-Message-State: AOJu0Yx236TyzvaOsanR1JVV78g3/AmLWEcWMdRWSKDBXK9gUxdbqqc3
 Ijn50K2bwT3wsGBUyfBvg5lsDmpKiV/fz72L3S4htDtddEE69ttkWHWQvyJ1xJhED3pMoae8xZs
 zWajcimOCDVwYLreKBwOvV5jFRxbHTnG65lYAV8VL/pwK4tq3dgVQUHJpA2uMotXkXhVRF4uWF1
 SrUcq8HdEBmb+JqKdSb3yHbx6t/qR0N2u4Qtmv
X-Received: by 2002:a05:6a21:151a:b0:1af:814f:ce69 with SMTP id
 nq26-20020a056a21151a00b001af814fce69mr13203834pzb.38.1715045381614; 
 Mon, 06 May 2024 18:29:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVZlgukZHx7h9/NY4qMNh0wI5UL4B58ltocanP7TKgZGhKeKYLKKdDOcO+vZvjXDpsYrwkynHU3kdR7X4ABwo=
X-Received: by 2002:a05:6a21:151a:b0:1af:814f:ce69 with SMTP id
 nq26-20020a056a21151a00b001af814fce69mr13203810pzb.38.1715045380918; Mon, 06
 May 2024 18:29:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240506204324.63215-1-pvorel@suse.cz>
In-Reply-To: <20240506204324.63215-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Tue, 7 May 2024 09:29:28 +0800
Message-ID: <CAEemH2dwXryEpUN0rLPVaKP9CJw6N0AJmvkMa+dZJ1atWvwXAA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] mmap15: Enable in compat mode
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

T24gVHVlLCBNYXkgNywgMjAyNCBhdCA0OjQz4oCvQU0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgoKPiBUZXN0IGFjdHVhbGx5IHJ1bnMgd2VsbCBpbiBjb21wYXQgbW9kZS4gU2tp
cHBpbmcgaW4gMzIgYml0IHdhcwo+IG9yaWdpbmFsbHkgYWRkZWQgYmM4ZDQ1YTQzIChpbiAyMDA0
LCBpbiBodWdlbW1hcDAzLmMpLCBsaWtlbHkga2VybmVsIG9yCj4gbGliYyBmdW5jdGlvbmFsaXR5
IGNoYW5nZWQuCj4KPiBUZXN0ZWQgb24gcmVjZW50IDYuNyBrZXJuZWwgYW5kIHZlcnkgb2xkIDQu
NCBrZXJuZWwuCj4KPiBTaWduZWQtb2ZmLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4K
PgoKUmV2aWV3ZWQtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPgoKCj4gLS0tCj4gIHRl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbW1hcC9tbWFwMTUuYyB8IDEgLQo+ICAxIGZpbGUgY2hh
bmdlZCwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvbW1hcC9tbWFwMTUuYwo+IGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tbWFwL21t
YXAxNS5jCj4gaW5kZXggNzFjMThhMTBhLi4yMTI4ZTBiNTcgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9tbWFwL21tYXAxNS5jCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9tbWFwL21tYXAxNS5jCj4gQEAgLTYxLDYgKzYxLDUgQEAgc3RhdGljIHN0cnVj
dCB0c3RfdGVzdCB0ZXN0ID0gewo+ICAgICAgICAgLnNldHVwID0gc2V0dXAsCj4gICAgICAgICAu
Y2xlYW51cCA9IGNsZWFudXAsCj4gICAgICAgICAudGVzdF9hbGwgPSBydW4sCj4gLSAgICAgICAu
c2tpcF9pbl9jb21wYXQgPSAxLAo+ICAgICAgICAgLm5lZWRzX3RtcGRpciA9IDEKPiAgfTsKPiAt
LQo+IDIuNDMuMAo+Cj4KPiAtLQo+IE1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo+Cj4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
