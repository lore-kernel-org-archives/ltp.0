Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA6AFF8873
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 12:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777553415; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=zfNq/80nfD0BMel6rwGTZ8iEc1MO/Fv9kftXPWAYa7g=;
 b=qNVMeVGtwBCdr54OyxTRPuLmaJPL7WOeoHX++bXUBFDnEl4T+IXxRhILrsaNaGFG494/1
 rOHvywSUOI7Gk+XLWbovHPVBQ40TM84CvbNHy59apQv/J/+9BxbwNj1n+8Dz8HGP13Og47f
 uh4SSHA1YOSV20Nq0aRlT8ew3aKgkzM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 08CED3E5955
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 14:50:15 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 06B003E2ACC
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 14:49:50 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7A6D41400F2A
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 14:49:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777553388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zDkMECwfljvjCniRRH51HcIZ1eCg6idjPGR2YouCmBI=;
 b=EHkFu+FCqECYm2lmuu9T9yKfZrFbpJOw6iYaA//KWiJqtWf6/r4lnjfLYIS1SCb8djk7tc
 n096RJjUgyyMe+dS7vEPOt0hFjslywWCBLIq2uuoGE0eRqXNaXSoY+441hNKZLw/x4awyb
 6izghqpE/p/oJI82uCGQXz/MoXz6O40=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-711-Vl9QAnaEPSWoVPbQ1OvT4w-1; Thu, 30 Apr 2026 08:49:45 -0400
X-MC-Unique: Vl9QAnaEPSWoVPbQ1OvT4w-1
X-Mimecast-MFC-AGG-ID: Vl9QAnaEPSWoVPbQ1OvT4w_1777553384
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-488e097a270so6005785e9.1
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 05:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777553384; x=1778158184;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zDkMECwfljvjCniRRH51HcIZ1eCg6idjPGR2YouCmBI=;
 b=l7YQTp3F5ulC+KkhnAeSL40axLpGVbU1bpt0vyBnjLrbWKfQWSZyVT8JTXygrMq3pm
 Nar6+3NZ5C8bg5Dpnc/bxd36Sh4cSp/Q4iyfndhc6BdnKAXzXlNx6h2+PKb/QU8VNULA
 tVg7lpvQ3VQMa+bNfAuCx96ZflW+ilfcWPjaQQOfT5qp6+xNbbj1Y9Z2xmRgafT09CQP
 nvOvKIuNSusewZo0qaGf6r6QVsahQkJuCgMci80qnNZevMwcgB4roAVMW0u2NctT/sEV
 BKfOsq7vlbuMtDeNpCXKWDfebFQOUQlkvr6RtqkpNC8/W9JO8WNYZrFTSTWLxhcZgjio
 EqfA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+XS40BdhA3bWZg8Mq85r5djZFOZcFJqxCcHp4I8o9b4CrLvO7AEc0XLckfNCRP4KYiofw=@lists.linux.it
X-Gm-Message-State: AOJu0YxdJFotLARjdvYK4C5kUTpb9/h6lW7KbF6vNwSUv/MFtr9KNuq7
 owWgnkLnxXn1VY2q6U7Jo8SsTiqdl5SBTqku08HMoVddpY1iNKO1B3L2+CZZDB5fLC2vJe9MXG4
 UeNsIn4r5Fe24Z28aRibPaDoF8matIScGH8VzG//1RXT7WfPhFbwpFL++3HugNgP5DXq9XiNmdf
 Cj08wP8Wzpt73yY5iOv2Tj8CvCptM=
X-Gm-Gg: AeBDievrGWdHmx/XY4Alj5c4jyqbFG3hfIxDOF9su14nNaNMJpMBkMr5oUOCq003AQR
 qiRGTbZjaEku7/qE9Y98hsG4huH+q9cn8PbHGM6oY+/aQKKpnccRJEp+hOQBXmSuH9NTuIvm1tQ
 6ADhtYeXVNAK+qDO3UQa8pxGx6qgJ7uNWM9JduenC/M6vZdj2Qo08zRRQv15cmqf51DyBusP/ED
 xt4z/Y4VqsD4qwB
X-Received: by 2002:a05:600c:4f0b:b0:488:d376:42cd with SMTP id
 5b1f17b1804b1-48a8445e86amr41106995e9.22.1777553383737; 
 Thu, 30 Apr 2026 05:49:43 -0700 (PDT)
X-Received: by 2002:a05:600c:4f0b:b0:488:d376:42cd with SMTP id
 5b1f17b1804b1-48a8445e86amr41106655e9.22.1777553383291; Thu, 30 Apr 2026
 05:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260430094142.37777-1-fushuai.wang@linux.dev>
In-Reply-To: <20260430094142.37777-1-fushuai.wang@linux.dev>
Date: Thu, 30 Apr 2026 14:49:26 +0200
X-Gm-Features: AVHnY4JlTA5IyNIxaVPW7J2MLXIDhYif1Yul7I9jo4bGFioZRBRBkvwP68OVBck
Message-ID: <CAASaF6z-JePtxPKj7=Ph6bq31i5YNm4iqj0WyFRSSY53cHD=JA@mail.gmail.com>
To: Fushuai Wang <fushuai.wang@linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: E4XINLQStDw7Axoe6XHo1BZDaEfgZmm1E68wClX8j-w_1777553384
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] read_all: Add /dev/fuse to default blacklist
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
Cc: yangx.jy@fujitsu.com, wangfushuai@baidu.com, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBBcHIgMzAsIDIwMjYgYXQgMTE6NDnigK9BTSBGdXNodWFpIFdhbmcgPGZ1c2h1YWku
d2FuZ0BsaW51eC5kZXY+IHdyb3RlOgo+Cj4gRnJvbTogRnVzaHVhaSBXYW5nIDx3YW5nZnVzaHVh
aUBiYWlkdS5jb20+Cj4KPiBSZWFkaW5nIC9kZXYvZnVzZSB3aXRob3V0IGEgY29ycmVzcG9uZGlu
ZyBGVVNFIGRhZW1vbiBwcm9jZXNzCj4gd2lsbCBtYWtlIHRoZSB0ZXN0IGhhbmcuIFNvIGFkZCAi
L2Rldi9mdXNlIiB0byBibGFja2xpc3QuCj4KPiBTaWduZWQtb2ZmLWJ5OiBGdXNodWFpIFdhbmcg
PHdhbmdmdXNodWFpQGJhaWR1LmNvbT4KCkFja2VkLWJ5OiBKYW4gU3RhbmNlayA8anN0YW5jZWtA
cmVkaGF0LmNvbT4KCj4gLS0tCj4gIHRlc3RjYXNlcy9rZXJuZWwvZnMvcmVhZF9hbGwvcmVhZF9h
bGwuYyB8IDEgKwo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPgo+IGRpZmYgLS1n
aXQgYS90ZXN0Y2FzZXMva2VybmVsL2ZzL3JlYWRfYWxsL3JlYWRfYWxsLmMgYi90ZXN0Y2FzZXMv
a2VybmVsL2ZzL3JlYWRfYWxsL3JlYWRfYWxsLmMKPiBpbmRleCBlMTg5NDVhMzQuLjU3MjBmZmI5
OSAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL2ZzL3JlYWRfYWxsL3JlYWRfYWxsLmMK
PiArKysgYi90ZXN0Y2FzZXMva2VybmVsL2ZzL3JlYWRfYWxsL3JlYWRfYWxsLmMKPiBAQCAtOTks
NiArOTksNyBAQCBzdGF0aWMgY2hhciAqYmxhY2tsaXN0W10gPSB7Cj4gICAgICAgICAiL3N5cy9k
ZXZpY2VzL3BsYXRmb3JtLyovZWVwcm9tIiwKPiAgICAgICAgICIvc3lzL2RldmljZXMvcGxhdGZv
cm0vKi9udm1lbSIsCj4gICAgICAgICAiL3N5cy8qL2NwdT8/Kig/KS8qIiwgICAvKiBjcHUqIGVu
dHJpZXMgd2l0aCAyIG9yIG1vcmUgZGlnaXRzICovCj4gKyAgICAgICAiL2Rldi9mdXNlIiwKPiAg
ICAgICAgIE5VTEwKPiAgfTsKPgo+IC0tCj4gMi4zNi4xCj4KCgotLSAKTWFpbGluZyBsaXN0IGlu
Zm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
