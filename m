Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF8BC47DDB
	for <ltp@archiver.kernel.org>; Thu,  1 Feb 2024 04:02:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3FBD03CF941
	for <ltp@archiver.kernel.org>; Thu,  1 Feb 2024 05:02:33 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F03DC3CACD6
 for <ltp@lists.linux.it>; Thu,  1 Feb 2024 05:00:20 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E844D600C61
 for <ltp@lists.linux.it>; Thu,  1 Feb 2024 05:00:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706760018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O1y7Wa+otevZxiDmCoUwIP3EcoTeTpreym0dz7uebs4=;
 b=JJkuRFTw09OQykBKgPts4bBh8krX2VU1yrUNya+7fNkCJz1urNbZbn23pX98uC5SvjPxru
 wbJcMe8+2vGhoshv0fCijsIqEpqIne7S7Sb6uBo1P433Gs0SkY3PIceAIOGi1s7GkWlzKD
 TxiHcxorhOE7q+wUKMfA/dz+0U4jytQ=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-r-TKXuFBMb26OUu0EIYW7g-1; Wed, 31 Jan 2024 23:00:16 -0500
X-MC-Unique: r-TKXuFBMb26OUu0EIYW7g-1
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-7d611256c4fso239600241.2
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 20:00:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706760014; x=1707364814;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O1y7Wa+otevZxiDmCoUwIP3EcoTeTpreym0dz7uebs4=;
 b=JAqkDqsAXjSBnPDqn40M1xGbC+OBBK9ncxc3wC9CiBJf7DOq7DOmPlIrWfx0tW1k4w
 crHQJiKaW170i1vQmoEuL3HDkuumgr41aD1JMf4I+7wA/gNstq96sk/mdH93Jg5Nvry5
 fKJI1eZXvt7XE1SBZ/z80rdTKW2O3JFvYZrkJ+hQnuOBkTxto12+oKaTvBXzoM34WVUv
 q8fQ0Rld5VappA93DP5BKpZ9gnf9wqFuYVLfcrIAWRYx701/5vf5zY7J1g+KEGVGFek9
 4a+T02lPduSeqz2BqEKCB4LOWg7g6kX96+tNsFSipKd0revWdhopn3MkakP6PaxRFpPN
 TFUg==
X-Gm-Message-State: AOJu0YwnBXu8Qz1IbnnWKblB5ZZMcXiJpbMcFb/Ol75QJ3HJHpb5EWO/
 pa31lAd9oY/iMcm570R1m46e05zVNEwknmtnoDL81ZlxwwVE+siXzI7KaCJ+I5KzMZgjGnyHvep
 zNkXOLAGQndP5nWMsUmIynNhkTB918GhEvOLCVdVa5SiztdlXUSQgORbR1Onn38VS9X3apPkiB5
 IXJh00Pxk1YEKkpsq+Mz3K3us0nl4fsAU=
X-Received: by 2002:a05:6102:34eb:b0:46a:fd10:45a5 with SMTP id
 bi11-20020a05610234eb00b0046afd1045a5mr3032929vsb.34.1706760014698; 
 Wed, 31 Jan 2024 20:00:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFuyX6EppeLWGKhtKDqg8mXQW46os1WhOqA/ac90yfZB7WpwryiiOsE2geG2EODdnXEft7UFeuzv2BDLLHSSUQ=
X-Received: by 2002:a05:6102:34eb:b0:46a:fd10:45a5 with SMTP id
 bi11-20020a05610234eb00b0046afd1045a5mr3032913vsb.34.1706760014463; Wed, 31
 Jan 2024 20:00:14 -0800 (PST)
MIME-Version: 1.0
References: <20240131102514.2739270-1-liwang@redhat.com>
 <20240131102514.2739270-8-liwang@redhat.com>
 <20240131173840.GA18869@pevik> <20240131185310.GA30901@pevik>
In-Reply-To: <20240131185310.GA30901@pevik>
From: Li Wang <liwang@redhat.com>
Date: Thu, 1 Feb 2024 12:00:02 +0800
Message-ID: <CAEemH2cHF3zdv7aP84oreZv_A-WaMivbHAD-FQnJbgcUpLruiQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [Patch v6 7/8] swapon/off: enable all_filesystem in swap
 test
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

SGkgUGV0ciwKCk9uIFRodSwgRmViIDEsIDIwMjQgYXQgMjo1M+KAr0FNIFBldHIgVm9yZWwgPHB2
b3JlbEBzdXNlLmN6PiB3cm90ZToKCj4gSGkgTGksCj4KPiBGaXJzdCwgSSBzdXBwb3NlIHlvdSB3
YWl0IGZvciBDeXJpbCwgb3RoZXJ3aXNlIEkgd291bGQgYmUgZm9yIG1lcmdpbmcgdXAgdG8KPiBw
cmV2aW91cyBjb21taXQgKCJsaWJzd2FwOiBjdXN0b21pemUgc3dhcGZpbGUgc2l6ZSIpLgoKClN1
cmUsIEkgbWVyZ2VkIHRoZSBwYXRjaCB0byA1LzguIFRvIGJldHRlciBmb2N1cyBvbiB0aGUgbmV3
IGNoYW5nZXMuCgpJIGZvdW5kIGEgcHJvYmxlbSBpbiB0aGlzIGNvbW1pdC4gSXQgbG9va3MgbGlr
ZSB0aGlzIHBhdGNoIGJyZWFrcyB0ZXN0aW5nIG9uCj4gVE1QRElSIG9uIHRtcGZzIG9uIFR1bWJs
ZXdlZWQga2VybmVsIDYuOC4wLXJjMS0yLmdmNGJhNWRiLWRlZmF1bHQ6Cj4KPiBUTVBESVI9L3Rt
cCBMVFBfU0lOR0xFX0ZTX1RZUEU9bnRmcyAuL3N3YXBvZmYwMQo+IHRzdF90ZXN0LmM6MTcwMTog
VElORk86ID09PSBUZXN0aW5nIG9uIG50ZnMgPT09Cj4gdHN0X3Rlc3QuYzoxMTE3OiBUSU5GTzog
Rm9ybWF0dGluZyAvZGV2L2xvb3AwIHdpdGggbnRmcyBvcHRzPScnIGV4dHJhCj4gb3B0cz0nJwo+
IFRoZSBwYXJ0aXRpb24gc3RhcnQgc2VjdG9yIHdhcyBub3Qgc3BlY2lmaWVkIGZvciAvZGV2L2xv
b3AwIGFuZCBpdCBjb3VsZAo+IG5vdCBiZSBvYnRhaW5lZCBhdXRvbWF0aWNhbGx5LiAgSXQgaGFz
IGJlZW4gc2V0IHRvIDAuCj4gVGhlIG51bWJlciBvZiBzZWN0b3JzIHBlciB0cmFjayB3YXMgbm90
IHNwZWNpZmllZCBmb3IgL2Rldi9sb29wMCBhbmQgaXQKPiBjb3VsZCBub3QgYmUgb2J0YWluZWQg
YXV0b21hdGljYWxseS4gIEl0IGhhcyBiZWVuIHNldCB0byAwLgo+IFRoZSBudW1iZXIgb2YgaGVh
ZHMgd2FzIG5vdCBzcGVjaWZpZWQgZm9yIC9kZXYvbG9vcDAgYW5kIGl0IGNvdWxkIG5vdCBiZQo+
IG9idGFpbmVkIGF1dG9tYXRpY2FsbHkuICBJdCBoYXMgYmVlbiBzZXQgdG8gMC4KPiBUbyBib290
IGZyb20gYSBkZXZpY2UsIFdpbmRvd3MgbmVlZHMgdGhlICdwYXJ0aXRpb24gc3RhcnQgc2VjdG9y
JywgdGhlCj4gJ3NlY3RvcnMgcGVyIHRyYWNrJyBhbmQgdGhlICdudW1iZXIgb2YgaGVhZHMnIHRv
IGJlIHNldC4KPiBXaW5kb3dzIHdpbGwgbm90IGJlIGFibGUgdG8gYm9vdCBmcm9tIHRoaXMgZGV2
aWNlLgo+IHRzdF90ZXN0LmM6MTEzMTogVElORk86IE1vdW50aW5nIC9kZXYvbG9vcDAgdG8gL3Rt
cC9MVFBfc3dhd0RPYU16L21udHBvaW50Cj4gZnN0eXA9bnRmcyBmbGFncz0wCj4gdHN0X3Rlc3Qu
YzoxMTMxOiBUSU5GTzogVHJ5aW5nIEZVU0UuLi4KPiB0c3RfaW9jdGwuYzoyNjogVElORk86IEZJ
Qk1BUCBpb2N0bCBpcyBzdXBwb3J0ZWQKPiBsaWJzd2FwLmM6MTQ0OiBUQlJPSzogSW5zdWZmaWNp
ZW50IGRpc2sgc3BhY2UgdG8gY3JlYXRlIHN3YXAgZmlsZQo+Cj4gZGYgLWhUIC90bXAvCj4gRmls
ZXN5c3RlbSAgICAgVHlwZSAgIFNpemUgIFVzZWQgQXZhaWwgVXNlJSBNb3VudGVkIG9uCj4gdG1w
ZnMgICAgICAgICAgdG1wZnMgIDcxN00gICAgIDAgIDcxN00gICAwJSAvdG1wCj4KPiBUZXN0IHdv
cmtzIG9uIDYuNi54IHN0YWJsZSBrZXJuZWwsIGJ1dCB0aGF0J3MgZHVlIGJpZ2dlciB0bXBmcy4K
PiBDb3VsZCB3ZSBhdCBsZWFzdCBUQ09ORiAoc2VlIGJlbG93KT8KPgoKKzEKCgoKPgo+IEkgYWxz
byB3b25kZXIgaWYgd2UgY291bGQgbWFrZSB3aG9sZSBkaXNrIHNpemUgYSBiaXQgc21hbGxlci4K
PiBUaGUgZGVmYXVsdCAzMDAgTUIgaXMgbm90IGVub3VnaCBmb3IgWEZTLCByaWdodD8gQnV0IHdo
eSA1MTIgTUI/Cj4gT242LjguMC1yYzEtMi5nZjRiYTVkYi1kZWZhdWx0IDM1MCBNQiBpcyBlbm91
Z2ggdG8gdGVzdCBldmVyeXRoaW5nOgo+CgpZZXMsIDM1ME1CIGlzIGVub3VnaCwgSSBjb3VudGVk
IHRoYXQgYnkgcGFnZV9zaXplIChzaG91bGQgdXNlIGJsa19zaXplKQp3cm9uZ2x5IG9uIGFhcmNo
NjQuCgoKCj4KPiAuLi4KPiB0c3RfdGVzdC5jOjE3MDE6IFRJTkZPOiA9PT0gVGVzdGluZyBvbiBu
dGZzID09PQo+IHRzdF90ZXN0LmM6MTExNzogVElORk86IEZvcm1hdHRpbmcgL2Rldi9sb29wMCB3
aXRoIG50ZnMgb3B0cz0nJyBleHRyYQo+IG9wdHM9JycKPiBUaGUgcGFydGl0aW9uIHN0YXJ0IHNl
Y3RvciB3YXMgbm90IHNwZWNpZmllZCBmb3IgL2Rldi9sb29wMCBhbmQgaXQgY291bGQKPiBub3Qg
YmUgb2J0YWluZWQgYXV0b21hdGljYWxseS4gIEl0IGhhcyBiZWVuIHNldCB0byAwLgo+IFRoZSBu
dW1iZXIgb2Ygc2VjdG9ycyBwZXIgdHJhY2sgd2FzIG5vdCBzcGVjaWZpZWQgZm9yIC9kZXYvbG9v
cDAgYW5kIGl0Cj4gY291bGQgbm90IGJlIG9idGFpbmVkIGF1dG9tYXRpY2FsbHkuICBJdCBoYXMg
YmVlbiBzZXQgdG8gMC4KPiBUaGUgbnVtYmVyIG9mIGhlYWRzIHdhcyBub3Qgc3BlY2lmaWVkIGZv
ciAvZGV2L2xvb3AwIGFuZCBpdCBjb3VsZCBub3QgYmUKPiBvYnRhaW5lZCBhdXRvbWF0aWNhbGx5
LiAgSXQgaGFzIGJlZW4gc2V0IHRvIDAuCj4gVG8gYm9vdCBmcm9tIGEgZGV2aWNlLCBXaW5kb3dz
IG5lZWRzIHRoZSAncGFydGl0aW9uIHN0YXJ0IHNlY3RvcicsIHRoZQo+ICdzZWN0b3JzIHBlciB0
cmFjaycgYW5kIHRoZSAnbnVtYmVyIG9mIGhlYWRzJyB0byBiZSBzZXQuCj4gV2luZG93cyB3aWxs
IG5vdCBiZSBhYmxlIHRvIGJvb3QgZnJvbSB0aGlzIGRldmljZS4KPiB0c3RfdGVzdC5jOjExMzE6
IFRJTkZPOiBNb3VudGluZyAvZGV2L2xvb3AwIHRvIC90bXAvTFRQX3N3YVdFWXp6di9tbnRwb2lu
dAo+IGZzdHlwPW50ZnMgZmxhZ3M9MAo+IHRzdF90ZXN0LmM6MTEzMTogVElORk86IFRyeWluZyBG
VVNFLi4uCj4gdHN0X2lvY3RsLmM6MjY6IFRJTkZPOiBGSUJNQVAgaW9jdGwgaXMgc3VwcG9ydGVk
Cj4gc3dhcG9mZjAxLmM6Mzk6IFRQQVNTOiBTdWNjZWVkZWQgdG8gdHVybiBvZmYgc3dhcGZpbGUK
PiB0c3RfdGVzdC5jOjE3MDE6IFRJTkZPOiA9PT0gVGVzdGluZyBvbiB0bXBmcyA9PT0KPiB0c3Rf
dGVzdC5jOjExMTc6IFRJTkZPOiBTa2lwcGluZyBta2ZzIGZvciBUTVBGUyBmaWxlc3lzdGVtCj4g
dHN0X3Rlc3QuYzoxMDk4OiBUSU5GTzogTGltaXRpbmcgdG1wZnMgc2l6ZSB0byA1MTJNQgo+IHRz
dF90ZXN0LmM6MTEzMTogVElORk86IE1vdW50aW5nIGx0cC10bXBmcyB0byAvdG1wL0xUUF9zd2FX
RVl6enYvbW50cG9pbnQKPiBmc3R5cD10bXBmcyBmbGFncz0wCj4gdHN0X2lvY3RsLmM6MjE6IFRJ
TkZPOiBGSUJNQVAgaW9jdGwgaXMgTk9UIHN1cHBvcnRlZDogRUlOVkFMICgyMikKPiBsaWJzd2Fw
LmM6MTk4OiBUQ09ORjogU3dhcGZpbGUgb24gdG1wZnMgbm90IGltcGxlbWVudGVkCj4KPiBTdW1t
YXJ5Ogo+IHBhc3NlZCAgIDgKPiBmYWlsZWQgICAwCj4gYnJva2VuICAgMAo+IHNraXBwZWQgIDEK
PiB3YXJuaW5ncyAwCj4KPiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgo+Cj4gZGlmZiAtLWdpdCBhL3Rl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc3dhcG9mZi9zd2Fwb2ZmMDEuYwo+IGIvdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy9zd2Fwb2ZmL3N3YXBvZmYwMS5jCj4gaW5kZXggYWYyYTc1OWNiLi5i
ZGU1OWRmNzcgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zd2Fwb2Zm
L3N3YXBvZmYwMS5jCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zd2Fwb2ZmL3N3
YXBvZmYwMS5jCj4gQEAgLTQ1LDggKzQ1LDcgQEAgc3RhdGljIHZvaWQgc2V0dXAodm9pZCkKPiAg
ICAgICAgIGlzX3N3YXBfc3VwcG9ydGVkKFRFU1RfRklMRSk7Cj4KPiAgICAgICAgIGlmICghdHN0
X2ZzX2hhc19mcmVlKCIuIiwgNjQsIFRTVF9NQikpCj4gLSAgICAgICAgICAgICAgIHRzdF9icmso
VEJST0ssCj4gLSAgICAgICAgICAgICAgICAgICAgICAgIkluc3VmZmljaWVudCBkaXNrIHNwYWNl
IHRvIGNyZWF0ZSBzd2FwIGZpbGUiKTsKPiArICAgICAgICAgICAgICAgdHN0X2JyayhUQ09ORiwg
Ikluc3VmZmljaWVudCBkaXNrIHNwYWNlIHRvIGNyZWF0ZSBzd2FwCj4gZmlsZSIpOwo+CgpUaGlz
IGlzIG5vdCBuZWVkZWQsIGxpYnN3YXAuYyBoYXMgYSBmcmVlIHNwYWNlIGNoZWNrIGFscmVhZHku
CgoKPgo+ICAgICAgICAgaWYgKG1ha2Vfc3dhcGZpbGUoU1dBUF9GSUxFLCA2NTUzNiwgMSkpCj4g
ICAgICAgICAgICAgICAgIHRzdF9icmsoVEJST0ssICJGYWlsZWQgdG8gY3JlYXRlIGZpbGUgZm9y
IHN3YXAiKTsKPgo+CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
