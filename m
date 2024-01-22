Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17254C47DAF
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 10:23:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 701B73CE228
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 11:23:10 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2D5E73CC7B7
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 11:22:54 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BC594600BBD
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 11:22:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705918972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vSVBsZid9x3sBxakojbDR5/EfJXUujYBTDllFTENiok=;
 b=U17vLRVTkQYZaCvQ+VmxGJh4boj3C66rVMUciTjYbwk48/IZB/2sQE/I5vX+uDg0B6Qn37
 6DZOHsMpdIf/jLptIkf5YSFSERFUnEmWOicg3nWHo2Rn9FnTfoUNKv0mtjzgkOEdwK8PQ4
 hJqfulmIyfgCd9SSB38FZ2d7V48+BTg=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-neYnUjdVPpWYrvchBHczHw-1; Mon, 22 Jan 2024 05:22:49 -0500
X-MC-Unique: neYnUjdVPpWYrvchBHczHw-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-6d9b082bb80so4999152b3a.0
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 02:22:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705918967; x=1706523767;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vSVBsZid9x3sBxakojbDR5/EfJXUujYBTDllFTENiok=;
 b=R79+gf6UaZJ0IGLiXrz+k5YAlmuJ8UW9Uy2ML2oGGMmp6ZMAKwDsyIxIgqAzaJyyin
 lGUCH3/nLYhyVUhZ0FksouxI4JZUwLH6I2qcKj1UZwr092hP9P7VEUFuRvElFbcfo8al
 mCbtoLfpl0qfKf0gXUF2hbjNeeB2iaQfhBac5g62Jn/MNOLOWkHOjTXUMdxyj7ys09qJ
 KAgwhly3XvID0CswZ9avsM0BPWJTspijhkh90J3B/nnqMcMZsLc6irYf6wIqzEfdY6Bt
 ANpnYWT9Akph4t3yaPqXx23VQzq5jcOSPmtgBuupnRRrOlQXTCQ27BLllmA//xZJ8Tqa
 nwwg==
X-Gm-Message-State: AOJu0YzfKbGqcuwArJiQ/IUwQz4xalzSQynY6/GgazcvP/A/CKeMODA1
 /J5jOpS6+4Yt+XESWEBCLQWKAGag6qRElJiOCTwWju/aOkVjfToGf8rf2jeWm2ByuHXbPZlqcbQ
 AZbgygX/Jb3XiolxSdsmhgRdpldwrZjphsm8SaSaUFVUlj8Y1uqM9Ef8+4TdZjQi7prAwSYo7TD
 ksCsU8gdNJ6y4QTMpmeunDVeGf5UxgIkxVrGUj
X-Received: by 2002:a05:6a20:3d23:b0:19c:4d0d:5b3c with SMTP id
 y35-20020a056a203d2300b0019c4d0d5b3cmr676962pzi.76.1705918966998; 
 Mon, 22 Jan 2024 02:22:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlb3P0nNIkfd8aNfdrIrdHsaudqH77+Mfn+Jrz4w3jeOwCIHMv7TG0sUA6CCjxn6n8/mMkI0sg2Rc2JUP8ZsQ=
X-Received: by 2002:a05:6a20:3d23:b0:19c:4d0d:5b3c with SMTP id
 y35-20020a056a203d2300b0019c4d0d5b3cmr676961pzi.76.1705918966773; Mon, 22 Jan
 2024 02:22:46 -0800 (PST)
MIME-Version: 1.0
References: <20240122072948.2568801-1-liwang@redhat.com>
 <20240122090349.GD76754@pevik> <20240122094126.GG76754@pevik>
In-Reply-To: <20240122094126.GG76754@pevik>
From: Li Wang <liwang@redhat.com>
Date: Mon, 22 Jan 2024 18:22:34 +0800
Message-ID: <CAEemH2d285KmMy99_EkLFt14mNWJegs05tNtraRn7Eh7=Vp1fw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/4] libswap: add known swap supported fs check
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

T24gTW9uLCBKYW4gMjIsIDIwMjQgYXQgNTo0MeKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgTGksIEN5cmlsLAo+Cj4gPiBIaSBMaSwgQ3lyaWwsCj4gLi4uCj4g
PiA+ICB2b2lkIGlzX3N3YXBfc3VwcG9ydGVkKGNvbnN0IGNoYXIgKmZpbGVuYW1lKQo+ID4gPiAg
ewo+ID4gPiArICAgaW50IGksIHN3X3N1cHBvcnQgPSAwOwo+ID4gPiAgICAgaW50IGZpYm1hcCA9
IHRzdF9maWJtYXAoZmlsZW5hbWUpOwo+ID4gSnVzdCBhIG5vdGUgdW5yZWxhdGVkIHRvIHRoaXMg
cGF0Y2hzZXQuIFdoZW4gdGVzdGluZyBvbiBTTEVTIGtlcm5lbAo+IGJhc2VkIG9uCj4gPiA1LjMu
MTggd2Ugc3RpbGwgZ2V0IFRDT05GIGR1ZSBtaXNzaW5nIEZJQk1BUCBpb2N0bCBzdXBwb3J0Ogo+
Cj4gPiB0c3RfdGVzdC5jOjE2Njk6IFRJTkZPOiA9PT0gVGVzdGluZyBvbiBidHJmcyA9PT0KPiA+
IHRzdF90ZXN0LmM6MTExODogVElORk86IEZvcm1hdHRpbmcgL2Rldi9sb29wMCB3aXRoIGJ0cmZz
IG9wdHM9JycgZXh0cmEKPiBvcHRzPScnCj4gPiB0c3RfdGVzdC5jOjExMzI6IFRJTkZPOiBNb3Vu
dGluZyAvZGV2L2xvb3AwIHRvCj4gL3RtcC9MVFBfc3dhemFxRjFML21udHBvaW50IGZzdHlwPWJ0
cmZzIGZsYWdzPTAKPiA+IHRzdF9pb2N0bC5jOjIxOiBUSU5GTzogRklCTUFQIGlvY3RsIGlzIE5P
VCBzdXBwb3J0ZWQ6IEVJTlZBTCAoMjIpCj4gPiBsaWJzd2FwLmM6NDU6IFRJTkZPOiBGU19OT0NP
V19GTCBhdHRyaWJ1dGUgc2V0IG9uIG1udHBvaW50L3N3YXBmaWxlMDEKPgo+ID4gbGlic3dhcC5j
OjExNDogVENPTkY6IFN3YXBmaWxlIG9uIGJ0cmZzIG5vdCBpbXBsZW1lbnRlZAo+Cj4gSG0sIHdo
YXQgbWFrZXMgbWUgd29uZGVyIGlzIHRoYXQgYnRyZnMgZG9lcyBub3Qgc3VwcG9ydCBGSUJNQVAg
ZXZlbiBvbgo+IGN1cnJlbnQKPiBvcGVuU1VTRSBUdW1ibGV3ZWVkIHdpdGggNi43LjAga2VybmVs
Ogo+CgoKV2hhdCB3ZSBtYWRlIHVzZSBvZiBGSUJNQVAgaXMganVzdCB0byBkZXRlcm1pbmUgdGhl
CmZpbGUncyBibG9ja3MgYXJlIGNvbnRpZ3VvdXMgb24gdGhlIGRpc2sgdGhlbiB3ZSBjYW4gYXNz
dW1lCnRoZSBzd2FwZmlsZSBzdXBwb3J0IG9yIG5vdCB3aXRoIHRoYXQgZmlsZXN5c3RlbS4KCkFz
IHlvdSBtZW50aW9uZWQsIG1heWJlIEZJRU1BUCBpcyBhbiBhZGRpdGlvbmFsIHdheQp0byBjaGVj
ayBpZiBhIGZpbGUncyBibG9ja3MgYXJlIGNvbnRpZ3VvdXMsIEkgZ3Vlc3Mgd2UgbWlnaHQKbmVl
ZCB0byBpbXByb3ZlIHRoZSBjaGVjayBpbiBhIHNpbXBsZSBmdW5jdGlvbiB3aXRoIGJvdGgKRklF
TUFQIGFuZCBGSUJNQVAgdG8gZ3VhcmFudGVlIHdlIGdldCB0aGUgbmVjZXNzYXJ5IGluZm8uCgpB
bmQgeWVzLCBpdCBjYW4gYmUgYWNoaWV2ZWQgaW4gYSBzZXBhcmF0ZSBwYXRjaC4KCgoKCgo+Cj4g
IyBUTVBESVI9L3Zhci90bXAvIExUUF9TSU5HTEVfRlNfVFlQRT1idHJmcyAuL3N3YXBvbjAxCj4g
Li4uCj4gdHN0X3Rlc3QuYzoxNjY5OiBUSU5GTzogPT09IFRlc3Rpbmcgb24gYnRyZnMgPT09Cj4g
dHN0X3Rlc3QuYzoxMTE3OiBUSU5GTzogRm9ybWF0dGluZyAvZGV2L2xvb3AwIHdpdGggYnRyZnMg
b3B0cz0nJyBleHRyYQo+IG9wdHM9JycKPiB0c3RfdGVzdC5jOjExMzE6IFRJTkZPOiBNb3VudGlu
ZyAvZGV2L2xvb3AwIHRvCj4gL3Zhci90bXAvTFRQX3N3YU1CY3RwcS9tbnRwb2ludCBmc3R5cD1i
dHJmcyBmbGFncz0wCj4gdHN0X2lvY3RsLmM6MjE6IFRJTkZPOiBGSUJNQVAgaW9jdGwgaXMgTk9U
IHN1cHBvcnRlZDogRUlOVkFMICgyMikKPiBsaWJzd2FwLmM6NDU6IFRJTkZPOiBGU19OT0NPV19G
TCBhdHRyaWJ1dGUgc2V0IG9uIG1udHBvaW50L3N3YXBmaWxlMDEKPgo+IGxpYnN3YXAuYzoxMTQ6
IFRDT05GOiBTd2FwZmlsZSBvbiBidHJmcyBub3QgaW1wbGVtZW50ZWQKPgo+ICQgZGYgLWhUIC92
YXIvdG1wCj4gRmlsZXN5c3RlbSAgICAgVHlwZSAgIFNpemUgIFVzZWQgQXZhaWwgVXNlJSBNb3Vu
dGVkIG9uCj4gL2Rldi92ZGEyICAgICAgYnRyZnMgICAyOEcgICAxOUcgIDMuM0cgIDg2JSAvdmFy
Cj4KPiAkIHVuYW1lIC1yCj4gNi43LjAtOS5nYWVkZGE4MC1kZWZhdWx0Cj4KPiBJIHRob3VnaHQg
dGhlIHByb2JsZW0gaXMgdGhhdCB1bmRlcmx5aW5nIGZzIGlzIGJ0cmZzLCBidXQgdGVzdGluZyBv
biBEZWJpYW4KPiBvbiA2LjYueCB3aXRoIFRNUERJUiBvbiBleHQ0IGRvZXMgbm90IGJyaW5nIEZJ
Qk1BUCBzdXBwb3J0Ogo+Cj4gIyBUTVBESVI9L3Zhci90bXAgTFRQX1NJTkdMRV9GU19UWVBFPWJ0
cmZzIC9vcHQvbHRwL3Rlc3RjYXNlcy9iaW4vc3dhcG9uMDEKPgo+IHRzdF90ZXN0LmM6MTY2OTog
VElORk86ID09PSBUZXN0aW5nIG9uIGJ0cmZzID09PQo+IHRzdF90ZXN0LmM6MTExNzogVElORk86
IEZvcm1hdHRpbmcgL2Rldi9sb29wMCB3aXRoIGJ0cmZzIG9wdHM9JycgZXh0cmEKPiBvcHRzPScn
Cj4gdHN0X3Rlc3QuYzoxMTMxOiBUSU5GTzogTW91bnRpbmcgL2Rldi9sb29wMCB0bwo+IC92YXIv
dG1wL0xUUF9zd2FaZjhGTjYvbW50cG9pbnQgZnN0eXA9YnRyZnMgZmxhZ3M9MAo+IHRzdF9pb2N0
bC5jOjIxOiBUSU5GTzogRklCTUFQIGlvY3RsIGlzIE5PVCBzdXBwb3J0ZWQ6IEVJTlZBTCAoMjIp
Cj4gbGlic3dhcC5jOjQ1OiBUSU5GTzogRlNfTk9DT1dfRkwgYXR0cmlidXRlIHNldCBvbiBtbnRw
b2ludC9zd2FwZmlsZTAxCj4KPiBsaWJzd2FwLmM6MTE0OiBUQ09ORjogU3dhcGZpbGUgb24gYnRy
ZnMgbm90IGltcGxlbWVudGVkCj4KPiAuLi4KPgo+IEtpbmQgcmVnYXJkcywKPiBQZXRyCj4KPgoK
LS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9saXN0aW5mby9sdHAK
