Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4252C28B2E
	for <ltp@archiver.kernel.org>; Mon, 10 Mar 2025 08:37:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D0923CA1E2
	for <ltp@archiver.kernel.org>; Mon, 10 Mar 2025 09:37:02 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5800F3CA1A7
 for <ltp@lists.linux.it>; Mon, 10 Mar 2025 09:36:44 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 30F72200928
 for <ltp@lists.linux.it>; Mon, 10 Mar 2025 09:36:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741595801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5fwZmq0Yq7N/jVit170a8kp6P2ujwbY1Om+0cFj+ulE=;
 b=UgVafXaD8M6ebLgp6OxPe9BZByaHpnQM9HaiyD41KPygexci/DlSwe0Peye+MFOuW2vVVq
 /ijtVq9hshi2LocQJmH1nFDlXBspgcLbCip4MHDCHtB+sQBpdicERv9aOEh2p8ZclFBomT
 QAXWTL+HCy/yLG2nKZ7kGYDeqZ2vxhc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-GbDwVg20NOa7Xf_z83P_ew-1; Mon, 10 Mar 2025 04:36:39 -0400
X-MC-Unique: GbDwVg20NOa7Xf_z83P_ew-1
X-Mimecast-MFC-AGG-ID: GbDwVg20NOa7Xf_z83P_ew_1741595799
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2ff6af1e264so11052499a91.3
 for <ltp@lists.linux.it>; Mon, 10 Mar 2025 01:36:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741595797; x=1742200597;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5fwZmq0Yq7N/jVit170a8kp6P2ujwbY1Om+0cFj+ulE=;
 b=IjxgT/3MKWZx2HR67JKMx9EhDC1X3TbzSHnLn/BIm4UugByXYxDgPckdftGolCcdBV
 467MPc1tOUeQeDd0vqIRcYf0SIiYQJiVFtICtb1uDlqXndrhuUs27QjvFGE5PvNj6KpQ
 d+lCIBAt8TlB2/GqjvdD+1iWR435i9cereFCFfWaW4FvWnhxp1vc+MD/+kGPC3fd7UgD
 EERWiQgvkoQQIH2ej7YqT2l71sQfoiFNtwx8M4LqEHJMAZYBJuviLs41A+69rf6hBOA6
 7XI5zMTiM64mze6MovJ8BiUx2M52kXsQUbXl6llYzyaJDEpS7qWRm05xqd773AWJZdcu
 0keg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUX1TH6al+bmTHIYxEhyE+jS78x/eyZwm01QzIc5Q5beMSbX9vkH6aoxBw3f6wS1fyU0dY=@lists.linux.it
X-Gm-Message-State: AOJu0Yzs/JYygtNp/TmAoVfNushWHRWEfCPm9G+gsX3G5qJ6OpB2SG6D
 i6epTm9mUhJWMR+IR0EoOkjN1mqtJKmhL1TlWiRCVM5q1+SmgjooGLK8GttwJBkpImbryglgS19
 KkO6WEJy1pVyWBsSIeqnh1rrqnPPj/thkIL0q+Ky1zylxA5N3CcD9rkTjdlrt+ZoYTFva5wNVkj
 aZs7DHVu3Yom7UVKFvcAu7yZ0SD0Zchwdxgy4r
X-Gm-Gg: ASbGncvfS8yNJKdEvduC/mPba2jIaIrEicny5bjkbgjH1mOxdam9063mu/gmLSmEgPd
 KHalU1G6hl18u/Jq5zyVTTjSHB6wfjTvZvwW6Bq/jcMjzYF5Vnmme4DSCZzvduu2our43zh/wcg
 ==
X-Received: by 2002:a17:90b:2782:b0:2ef:2f49:7d7f with SMTP id
 98e67ed59e1d1-2ff7ce938b6mr23823229a91.18.1741595796253; 
 Mon, 10 Mar 2025 01:36:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYUXwvIXBmJAm2pQxly7F6xM5fyMWzVqL6TQlB8q11e6TX8v8aG3GpN8GUkihgB8/3d7mg9jJfAkVKMLzXqao=
X-Received: by 2002:a17:90b:2782:b0:2ef:2f49:7d7f with SMTP id
 98e67ed59e1d1-2ff7ce938b6mr23823193a91.18.1741595795850; Mon, 10 Mar 2025
 01:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <202503101538.84c33cd4-lkp@intel.com>
In-Reply-To: <202503101538.84c33cd4-lkp@intel.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 10 Mar 2025 16:36:23 +0800
X-Gm-Features: AQ5f1JpoFar89aH58dXevz3rUzSwyT1VZtVndvhvymaWq69cZh_jCWypaThTx3U
Message-ID: <CAEemH2egF6ehr7B_5KDLuBQqoUJ5k7bVZkid-ERDBkxkChi7fw@mail.gmail.com>
To: kernel test robot <oliver.sang@intel.com>, LTP List <ltp@lists.linux.it>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: f8UF5PGz1l2bpVBqpXTG9CUZ0B7c5fxxN2kSl1V9kfo_1741595799
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [linux-next:master] [block/bdev] 47dd675323:
 ltp.ioctl_loop06.fail
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
Cc: Christian Brauner <brauner@kernel.org>, lkp@intel.com,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>, linux-block@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>, Hannes Reinecke <hare@suse.de>,
 oe-lkp@lists.linux.dev
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGksCgpUaGUgaW9jdGxfbG9vcDA2IHRlc3QgZXhwZWN0cyBQQUdFX1NJWkUgdG8gYmUgdGhlIHVw
cGVyIGxpbWl0LCBidXQgdGhlCmtlcm5lbApub3cgYWxsb3dzIHVwIHRvIDY0SyAoU1pfNjRLKS4g
SWYgUEFHRV9TSVpFIDwgNjRLIChlLmcuLCA0SyBvbiB4ODYpLAp0aGUgdGVzdCB3cm9uZ2x5IGFz
c3VtZXMgYW55dGhpbmcgYWJvdmUgUEFHRV9TSVpFIHNob3VsZCBiZSByZWplY3RlZCwKYnV0IHRo
ZSBrZXJuZWwgbm93IGFsbG93cyB1cCB0byA2NEsuCgpJIGd1ZXNzIHdlIHByb2JhYmx5IG5lZWQg
dG8gYWRqdXN0IHRlc3RjYXNlIHRvIGR5bmFtaWNhbGx5IGRlZmluZSBhbgpFWFBFQ1RFRF9NQVhf
QkxPQ0tfU0laRSBhY2NvcmRpbmcgdG8ga2VybmVsIHZlcnNpb25zLgpJIHdpbGwgc2VuZCBvdXQg
YSBwYXRjaCB0byBMVFAgTUwuCgoKCk9uIE1vbiwgTWFyIDEwLCAyMDI1IGF0IDM6NDHigK9QTSBr
ZXJuZWwgdGVzdCByb2JvdCA8b2xpdmVyLnNhbmdAaW50ZWwuY29tPgp3cm90ZToKCj4KPgo+IEhl
bGxvLAo+Cj4ga2VybmVsIHRlc3Qgcm9ib3Qgbm90aWNlZCAibHRwLmlvY3RsX2xvb3AwNi5mYWls
IiBvbjoKPgo+IGNvbW1pdDogNDdkZDY3NTMyMzAzODAzYTg3ZjQzMTk1ZTA4OGIzYjRiY2YwNDU0
ZCAoImJsb2NrL2JkZXY6IGxpZnQgYmxvY2sKPiBzaXplIHJlc3RyaWN0aW9ucyB0byA2NGsiKQo+
IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvY2dpdC9saW51eC9rZXJuZWwvZ2l0L25leHQvbGludXgt
bmV4dC5naXQgbWFzdGVyCj4KPiBpbiB0ZXN0Y2FzZTogbHRwCj4gdmVyc2lvbjogbHRwLXg4Nl82
NC0wZjlkODE3YTMtMV8yMDI1MDIyMgo+IHdpdGggZm9sbG93aW5nIHBhcmFtZXRlcnM6Cj4KPiAg
ICAgICAgIGRpc2s6IDFIREQKPiAgICAgICAgIGZzOiB4ZnMKPiAgICAgICAgIHRlc3Q6IHN5c2Nh
bGxzLTAxL2lvY3RsX2xvb3AwNgo+Cj4KPgo+IGNvbmZpZzogeDg2XzY0LXJoZWwtOS40LWx0cAo+
IGNvbXBpbGVyOiBnY2MtMTIKPiB0ZXN0IG1hY2hpbmU6IDQgdGhyZWFkcyAxIHNvY2tldHMgSW50
ZWwoUikgQ29yZShUTSkgaTMtMzIyMCBDUFUgQCAzLjMwR0h6Cj4gKEl2eSBCcmlkZ2UpIHdpdGgg
OEcgbWVtb3J5Cj4KPiAocGxlYXNlIHJlZmVyIHRvIGF0dGFjaGVkIGRtZXNnL2ttc2cgZm9yIGVu
dGlyZSBsb2cvYmFja3RyYWNlKQo+Cj4KPgo+Cj4gSWYgeW91IGZpeCB0aGUgaXNzdWUgaW4gYSBz
ZXBhcmF0ZSBwYXRjaC9jb21taXQgKGkuZS4gbm90IGp1c3QgYSBuZXcKPiB2ZXJzaW9uIG9mCj4g
dGhlIHNhbWUgcGF0Y2gvY29tbWl0KSwga2luZGx5IGFkZCBmb2xsb3dpbmcgdGFncwo+IHwgUmVw
b3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPgo+IHwgQ2xvc2VzOgo+
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL29lLWxrcC8yMDI1MDMxMDE1MzguODRjMzNjZDQtbGtw
QGludGVsLmNvbQo+Cj4KPiBSdW5uaW5nIHRlc3RzLi4uLi4uLgo+IDw8PHRlc3Rfc3RhcnQ+Pj4K
PiB0YWc9aW9jdGxfbG9vcDA2IHN0aW1lPTE3NDEzMjIzODgKPiBjbWRsaW5lPSJpb2N0bF9sb29w
MDYiCj4gY29udGFjdHM9IiIKPiBhbmFseXNpcz1leGl0Cj4gPDw8dGVzdF9vdXRwdXQ+Pj4KPiB0
c3RfdG1wZGlyLmM6MzE2OiBUSU5GTzogVXNpbmcKPiAvZnMvc2RhMi90bXBkaXIvbHRwLWY1dUVD
MVRIVm0vTFRQX2lvY2JCeWNwaiBhcyB0bXBkaXIgKHhmcyBmaWxlc3lzdGVtKQo+IHRzdF90ZXN0
LmM6MTkwMDogVElORk86IExUUCB2ZXJzaW9uOiAyMDI1MDEzMC0xMTgtZzBmOWQ4MTdhMwo+IHRz
dF90ZXN0LmM6MTkwNDogVElORk86IFRlc3RlZCBrZXJuZWw6IDYuMTQuMC1yYzEtMDAwMDctZzQ3
ZGQ2NzUzMjMwMyAjMQo+IFNNUCBQUkVFTVBUX0RZTkFNSUMgRnJpIE1hciAgNyAxMToyNTo1MCBD
U1QgMjAyNSB4ODZfNjQKPiB0c3Rfa2NvbmZpZy5jOjg4OiBUSU5GTzogUGFyc2luZyBrZXJuZWwg
Y29uZmlnICcvcHJvYy9jb25maWcuZ3onCj4gdHN0X2tjb25maWcuYzo2NzY6IFRJTkZPOiBDT05G
SUdfS0FTQU4ga2VybmVsIG9wdGlvbiBkZXRlY3RlZCB3aGljaCBtaWdodAo+IHNsb3cgdGhlIGV4
ZWN1dGlvbgo+IHRzdF90ZXN0LmM6MTcyMjogVElORk86IE92ZXJhbGwgdGltZW91dCBwZXIgcnVu
IGlzIDBoIDEwbSAwMHMKPiB0c3RfZGV2aWNlLmM6OTc6IFRJTkZPOiBGb3VuZCBmcmVlIGRldmlj
ZSAwICcvZGV2L2xvb3AwJwo+IGlvY3RsX2xvb3AwNi5jOjc0OiBUSU5GTzogVXNpbmcgTE9PUF9T
RVRfQkxPQ0tfU0laRSB3aXRoIGFyZyA8IDUxMgo+IGlvY3RsX2xvb3AwNi5jOjY1OiBUUEFTUzog
U2V0IGJsb2NrIHNpemUgZmFpbGVkIGFzIGV4cGVjdGVkOiBFSU5WQUwgKDIyKQo+IGlvY3RsX2xv
b3AwNi5jOjc0OiBUSU5GTzogVXNpbmcgTE9PUF9TRVRfQkxPQ0tfU0laRSB3aXRoIGFyZyA+IFBB
R0VfU0laRQo+IGlvY3RsX2xvb3AwNi5jOjU3OiBURkFJTDogU2V0IGJsb2NrIHNpemUgc3VjY2Vl
ZCB1bmV4cGVjdGVkbHkKPiBpb2N0bF9sb29wMDYuYzo3NDogVElORk86IFVzaW5nIExPT1BfU0VU
X0JMT0NLX1NJWkUgd2l0aCBhcmcgIT0gcG93ZXJfb2ZfMgo+IGlvY3RsX2xvb3AwNi5jOjY1OiBU
UEFTUzogU2V0IGJsb2NrIHNpemUgZmFpbGVkIGFzIGV4cGVjdGVkOiBFSU5WQUwgKDIyKQo+IGlv
Y3RsX2xvb3AwNi5jOjc0OiBUSU5GTzogVXNpbmcgTE9PUF9DT05GSUdVUkUgd2l0aCBibG9ja19z
aXplIDwgNTEyCj4gaW9jdGxfbG9vcDA2LmM6NjU6IFRQQVNTOiBTZXQgYmxvY2sgc2l6ZSBmYWls
ZWQgYXMgZXhwZWN0ZWQ6IEVJTlZBTCAoMjIpCj4gaW9jdGxfbG9vcDA2LmM6NzQ6IFRJTkZPOiBV
c2luZyBMT09QX0NPTkZJR1VSRSB3aXRoIGJsb2NrX3NpemUgPiBQQUdFX1NJWkUKPiBpb2N0bF9s
b29wMDYuYzo1NzogVEZBSUw6IFNldCBibG9jayBzaXplIHN1Y2NlZWQgdW5leHBlY3RlZGx5Cj4g
aW9jdGxfbG9vcDA2LmM6NzQ6IFRJTkZPOiBVc2luZyBMT09QX0NPTkZJR1VSRSB3aXRoIGJsb2Nr
X3NpemUgIT0KPiBwb3dlcl9vZl8yCj4gaW9jdGxfbG9vcDA2LmM6NjU6IFRQQVNTOiBTZXQgYmxv
Y2sgc2l6ZSBmYWlsZWQgYXMgZXhwZWN0ZWQ6IEVJTlZBTCAoMjIpCj4KPiBTdW1tYXJ5Ogo+IHBh
c3NlZCAgIDQKPiBmYWlsZWQgICAyCj4gYnJva2VuICAgMAo+IHNraXBwZWQgIDAKPiB3YXJuaW5n
cyAwCj4gaW5jcmVtZW50aW5nIHN0b3AKPiA8PDxleGVjdXRpb25fc3RhdHVzPj4+Cj4gaW5pdGlh
dGlvbl9zdGF0dXM9Im9rIgo+IGR1cmF0aW9uPTEgdGVybWluYXRpb25fdHlwZT1leGl0ZWQgdGVy
bWluYXRpb25faWQ9MSBjb3JlZmlsZT1ubwo+IGN1dGltZT0wIGNzdGltZT02Cj4gPDw8dGVzdF9l
bmQ+Pj4KPiBJTkZPOiBsdHAtcGFuIHJlcG9ydGVkIHNvbWUgdGVzdHMgRkFJTAo+IExUUCBWZXJz
aW9uOiAyMDI1MDEzMC0xMTgtZzBmOWQ4MTdhMwo+Cj4gICAgICAgICMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwo+Cj4gICAgICAg
ICAgICAgRG9uZSBleGVjdXRpbmcgdGVzdGNhc2VzLgo+ICAgICAgICAgICAgIExUUCBWZXJzaW9u
OiAgMjAyNTAxMzAtMTE4LWcwZjlkODE3YTMKPiAgICAgICAgIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjCj4KPgo+Cj4KPiBUaGUg
a2VybmVsIGNvbmZpZyBhbmQgbWF0ZXJpYWxzIHRvIHJlcHJvZHVjZSBhcmUgYXZhaWxhYmxlIGF0
Ogo+Cj4gaHR0cHM6Ly9kb3dubG9hZC4wMS5vcmcvMGRheS1jaS9hcmNoaXZlLzIwMjUwMzEwLzIw
MjUwMzEwMTUzOC44NGMzM2NkNC1sa3BAaW50ZWwuY29tCj4KPgo+Cj4gLS0KPiAwLURBWSBDSSBL
ZXJuZWwgVGVzdCBTZXJ2aWNlCj4gaHR0cHM6Ly9naXRodWIuY29tL2ludGVsL2xrcC10ZXN0cy93
aWtpCj4KPgo+IC0tCj4gTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQv
bGlzdGluZm8vbHRwCj4KPgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
