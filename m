Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81869FF60FF
	for <ltp@archiver.kernel.org>; Tue, 31 Mar 2026 10:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774953939; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=xQs8Bi2fKm78bUN+7BHoXj/+99walh3Xt8ZkQ9O3aOU=;
 b=JEkOjWqF8UKcJV/vIbpC4rr9wVNlELsYXN5ivQUZSN1jRkCkJW1i2F3vtlcoofS5zjowc
 NUqKFkSu1mNqhJemeQXV8OK9a0OHGZW+SBWfiyu1C6Qn1CaFnVEzfg/5x3g9yI1WLll2XzB
 BlBwNmmz64zyzdLona54X5HTrkNXasE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF3C53E2A71
	for <ltp@archiver.kernel.org>; Tue, 31 Mar 2026 12:45:39 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C20303E26ED
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 12:45:16 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1B87E1A008AF
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 12:45:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774953914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DoCUeEjwRV110KR1tPvoMtwaqFPYjVL7tuOZqnldsoo=;
 b=ZRlgFkf3x1NxCTuCJwuRgg8EA2o4aauWFGpPNQdDOxOSv2C4mDejB2RUDRrFYEXVUTwd6s
 P//tz3+2RpePdq9r6zLfyT+Rp1Zz0A6eqscEXCYcn6FBSdjB/p1He58P8BfTPixOgl+etc
 Qjw+yvbhfdSDc9UZE/x8pU9haiHCVD8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-oogi8Xs9MPG_9g25XHe6SQ-1; Tue, 31 Mar 2026 06:45:11 -0400
X-MC-Unique: oogi8Xs9MPG_9g25XHe6SQ-1
X-Mimecast-MFC-AGG-ID: oogi8Xs9MPG_9g25XHe6SQ_1774953910
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4836abfc742so47297735e9.0
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 03:45:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774953910; x=1775558710;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DoCUeEjwRV110KR1tPvoMtwaqFPYjVL7tuOZqnldsoo=;
 b=C/cAY7wAzoNWk/6GcThDMY5R7OmGbE2LFkukwZg0PzvdV4LlTFvSdQGIFcc2c+Tzpi
 FAPPm016t3EBQDLbpl272fE7B/Au3Hn6nJHhDBHHtCmznM/nvno1RRIeUco67iB95l2b
 VT4tz0HceuK1RQ+jPTEcHfYqIfhkSL9EJ4IkPciA+018rEoQ+EMsybNQG6b1CGySi5XL
 PXgVTphPKkM57XNu9MPYCKgO9t34eRoiNFkIOXJoLL/zu7q4Hk4WeouGEiR2XXmomxiA
 TTMdURe2lSc+os4djN1DV/pi8aHMNOj6DLpULt28K676jIEY3aKDfzFaMiBopdMFCtJb
 96lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9C1OzyFFU1+gzNtTD0gzh0LCJy4/CTQXikTaeBBL0pR0gyFSq/GPpW23P8YCXc8+Uzkg=@lists.linux.it
X-Gm-Message-State: AOJu0YzoKMz3PDhLLFUJCdqpje29fvKqu0YvrhG1LoQX7nGUec+prjDE
 PWfsTwJS04lq+QFGgNv/0ojuMvANiuJh0dsYbZjS+2vLylvOzkb50FkXqZ/0bKI8j0x+Pq1jQTw
 BsOIpfjfJq7m7fgMJlWijHxl7Djk3etHkVD7UNTZilUCgBTI1nnVX+hFmVjZzmymsvoVKnjpZU2
 AXhrdWMjei+pQWtRWgRLTKiU0h9rs=
X-Gm-Gg: ATEYQzwyc1JL2VEiIO8VH/N+qHnmQhein4zfO5+SLlFGZ6bl8OMjEZfE+/FXWnridy/
 WNAfMuLirhhFo9sUKcNQIWH1YS41wd6ZlKWmrFKOtL+ZecUbj6H6KllwCpHx2hfk8rvm8opCWaT
 HhuyFb9KVbcAhEDpkECwG7A3SamUbqPY9L7ZOQth6NRJDnBvlG/sdSURRncYodn7C4awEuVJaBT
 M1g
X-Received: by 2002:a05:600c:1d1e:b0:486:ffa3:55f with SMTP id
 5b1f17b1804b1-48727f069eemr272615375e9.27.1774953909985; 
 Tue, 31 Mar 2026 03:45:09 -0700 (PDT)
X-Received: by 2002:a05:600c:1d1e:b0:486:ffa3:55f with SMTP id
 5b1f17b1804b1-48727f069eemr272614925e9.27.1774953909484; Tue, 31 Mar 2026
 03:45:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260331072051.GA5254@pevik>
 <CAASaF6xPzR3KWCd=aUTPWVgzfyi1SkftgQ8HG_kvphY2fWMe_g@mail.gmail.com>
 <20260331093110.GA37783@pevik>
In-Reply-To: <20260331093110.GA37783@pevik>
Date: Tue, 31 Mar 2026 12:44:51 +0200
X-Gm-Features: AQROBzCZt2JBmaXz-b7B7opZHowQ2JpIxiCYcGGdxtfDaH0D-XChAmgxLJEKs_U
Message-ID: <CAASaF6xgitWDpquGfcALptj+Rv8iNg=FEifXzw+1dfXNVYNVxw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: F51cRSfgTpJsJrJNQD_KX6_Q16A6QJN09D0yQK4uqgA_1774953910
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] linux-git: using whole sha1 hash
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

T24gVHVlLCBNYXIgMzEsIDIwMjYgYXQgMTE6MzHigK9BTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3Vz
ZS5jej4gd3JvdGU6Cj4KPiA+IE9uIFR1ZSwgTWFyIDMxLCAyMDI2IGF0IDk6MjHigK9BTSBQZXRy
IFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cj4KPiA+ID4gSGkgYWxsLAo+Cj4gPiA+IGFu
eXRoaW5nIGFnYWluc3Qgc3RhcnRpbmcgdG8gdXNlIHdob2xlIHNoYTEgaGFzaCBpbiBsaW51eC1n
aXQgdGFnPyBpLmUuIDQwIGNoYXJzLgo+ID4gPiBJdCBjYW4gYmUgc2hvcnRlbiBieSB0aGUgZG9j
L2NvbmYucHkgc2NyaXB0ICh1c2Ugd2hvbGUgaGFzaCBmb3IgVVJMLCBidXQgc2hvcnRlbgo+ID4g
PiB0aGUgdmlzaWJsZSBwYXJ0IG9mIDxhPiB0YWcpLgo+Cj4gPiBJbiBtZXRkYXRhLCBjb21taXQg
bWVzc2FnZXMgb3IgZXZlcnl3aGVyZT8KPgo+IEluIG1ldGFkYXRhLgoKTm8gb2JqZWN0aW9ucy4K
Cj4KPiBJbnN0ZWFkIG9mOgo+ICAgICAgICAgLnRhZ3MgPSAoY29uc3Qgc3RydWN0IHRzdF90YWdb
XSkgewo+ICAgICAgICAgICAgICAgICB7ImxpbnV4LWdpdCIsICIwOTFkMGQ1NWIyODYifSwKPiAg
ICAgICAgICAgICAgICAgLi4uCj4KPiBIYXZlOgo+ICAgICAgICAgLnRhZ3MgPSAoY29uc3Qgc3Ry
dWN0IHRzdF90YWdbXSkgewo+ICAgICAgICAgICAgICAgICB7ImxpbnV4LWdpdCIsICIwOTFkMGQ1
NWIyODZjOTM0MDIwMWI0ZWQ0NDcwYmU4N2ZjNTY4MjI4In0sCj4KPiBLaW5kIHJlZ2FyZHMsCj4g
UGV0cgo+Cj4gPiA+IFdlIG5vcm1hbGx5IHVzZSBvbmx5IDEyIGNoYXJzIDA5MWQwZDU1YjI4Niwg
YnV0IHNvbWUgdXNlcnMgZHVyaW5nIHJld3JpdGUgdXNlZAo+ID4gPiBbMV0gcmVhbGx5IHNtYWxs
IGhhc2ggKDcgY2hhcnMpIGZyb20gb3JpZ2luYWwgdGVzdC4KPgo+ID4gPiBLaW5kIHJlZ2FyZHMs
Cj4gPiA+IFBldHIKPgo+ID4gPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbHRwLzIwMjYw
MzMxMDE1NTM4LjUzMzI2LTEtbHVmZWlAdW5pb250ZWNoLmNvbS8KPgo+CgoKLS0gCk1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
