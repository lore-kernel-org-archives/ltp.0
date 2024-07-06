Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588D0C2BD09
	for <ltp@archiver.kernel.org>; Sat,  6 Jul 2024 07:11:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F7D13D3B4F
	for <ltp@archiver.kernel.org>; Sat,  6 Jul 2024 09:11:27 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B58903D0F9C
 for <ltp@lists.linux.it>; Sat,  6 Jul 2024 09:11:13 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kroah.com (client-ip=103.168.172.156;
 helo=fhigh5-smtp.messagingengine.com; envelope-from=greg@kroah.com;
 receiver=lists.linux.it)
Received: from fhigh5-smtp.messagingengine.com
 (fhigh5-smtp.messagingengine.com [103.168.172.156])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E9DB6618FE1
 for <ltp@lists.linux.it>; Sat,  6 Jul 2024 09:11:11 +0200 (CEST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 2A4A31140091;
 Sat,  6 Jul 2024 03:11:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Sat, 06 Jul 2024 03:11:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1720249870;
 x=1720336270; bh=DZNLD/IW5otGUh4hw/mSAd6wKC+4YoRkqCUTzyDywq0=; b=
 X1YogIQYdt02lx4L6ENwXj8iCHklT3eYseveIV/rBG9DN5UpUJFJfg7Rd7UxwlL3
 e5Y2N8kZE/FG2uYPCeY3VxbQ7m0fYVXVUNHDIavX8ZL6nTGMMMWK0k3GOWtjOTBs
 OsT5J3ndh6b8XMQHSDHuDUOgfBRtg/pYy9V4YAYOH34q0lowo6UcKHsH0g2e5tHD
 lNUF079R45fG6gM5S4KAsubJwyS0xoW/Qa8KX/o2GEcZFxqRBQlZUgeF4EU1oquT
 DpAE9F4zh9y7d7FuGHkr5c4RomK+Igz6hoBIFkFjMgSYuTV3Axr36LmPrVwTh3Y0
 7awObc4pUtcl5X1L0l1J/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1720249870; x=
 1720336270; bh=DZNLD/IW5otGUh4hw/mSAd6wKC+4YoRkqCUTzyDywq0=; b=Y
 fcBYP3+Gzm74S1nQgh//3AqD0kHErf4RPURR+qwvYxjFmL/8sK8eDaxm0Zc/h3R4
 faPug7TzgR8lr83SviBkgqT5rq1dmFYew2800E8H7g+J6u3FjY7YcxbawNtUq8ea
 Oqa/B4C8FWZkpTr5V7vC1U5+mPCtP1eK861EnD4CaqWSRXVM8j5CUe5u3T9xmg+y
 nMRNg4wuDJWx+EW3SD5C5L+WwvUgja/vHkMsKkB6HjF2vEJJ/O9Hnkqyt3Hg/kiu
 5g/iWuK2rTa/I5CIrd9PdpFyBpd+AhkLJXkjNFyBuo2RdxuB2FfTPOjb40kbhXDX
 RODgsHD5NpZY2xhTGCOcw==
X-ME-Sender: <xms:De6IZsaXiIs4ZM0N5W6kfw61zpqrtvEKzNvpwzqG-lH2Usp1O267Pg>
 <xme:De6IZnafAgizcH6ivca3z5VyUKvBOhtjAn9RZ4sel2QoUbMv9oqPz_RWwWUmAPTLW
 sMjxv5gfx-6vg>
X-ME-Received: <xmr:De6IZm9BihC0ujcc-ws9a2pS8Wp25QlrFx5iOHEKBP3qomp3SZVcTP8o-5cQpFp-y9Eh18s1GChj63cVvimUI-JTaVsNyFtJ5bVoBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvgdduudehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefirhgv
 ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpefgke
 ffieefieevkeelteejvdetvddtledugfdvhfetjeejieduledtfefffedvieenucevlhhu
 shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
 grhhdrtghomh
X-ME-Proxy: <xmx:De6IZmoC3xo9Ec7oAZWYF7T6dirRsAsPObMAiz5slz0_i-LcY69S8Q>
 <xmx:De6IZnoHGy9CiEvt4sfVBL3UXBmaHIJESBHYxIQaIBDMABFm73CC_Q>
 <xmx:De6IZkRnmIiuzjPmNcS1sPj6XZrDTz_0ccjnOCL2iW25n9aTqlorcQ>
 <xmx:De6IZnqh-LJht9MMQFwj8cA3ydIDv50QfS2YzB3uqZjEr9TyQnFLKg>
 <xmx:Du6IZqVP5vpaY-aR56MsCw-N2ew4rDLUKjkZjR4hF_pEvznfgTkNyvhk>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Jul 2024 03:11:08 -0400 (EDT)
Date: Sat, 6 Jul 2024 09:11:05 +0200
From: Greg KH <greg@kroah.com>
To: Chuck Lever III <chuck.lever@oracle.com>
Message-ID: <2024070638-shale-avalanche-1b51@gregkh>
References: <d4b235df-4ee5-4824-9d48-e3b3c1f1f4d1@oracle.com>
 <2fc3a3fd-7433-45ba-b281-578355dca64c@oracle.com>
 <296EA0E6-0E72-4EA1-8B31-B025EB531F9B@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <296EA0E6-0E72-4EA1-8B31-B025EB531F9B@oracle.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] nfsstat01: Update client RPC calls for kernel
 6.9
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
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 Neil Brown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
 Sherry Yang <sherry.yang@oracle.com>, linux-stable <stable@vger.kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, Anna Schumaker <anna@kernel.org>,
 Trond Myklebust <trondmy@hammerspace.com>,
 Calum Mackay <calum.mackay@oracle.com>,
 "kernel-team@fb.com" <kernel-team@fb.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBKdWwgMDUsIDIwMjQgYXQgMDI6MTk6MThQTSArMDAwMCwgQ2h1Y2sgTGV2ZXIgSUlJ
IHdyb3RlOgo+IAo+IAo+ID4gT24gSnVsIDIsIDIwMjQsIGF0IDY6NTXigK9QTSwgQ2FsdW0gTWFj
a2F5IDxjYWx1bS5tYWNrYXlAb3JhY2xlLmNvbT4gd3JvdGU6Cj4gPiAKPiA+IFRvIGNsYXJpZnni
gKYKPiA+IAo+ID4gT24gMDIvMDcvMjAyNCA1OjU0IHBtLCBDYWx1bSBNYWNrYXkgd3JvdGU6Cj4g
Pj4gaGkgUGV0ciwKPiA+PiBJIG5vdGljZWQgeW91ciBMVFAgcGF0Y2ggWzFdWzJdIHdoaWNoIGFk
anVzdHMgdGhlIG5mc3N0YXQwMSB0ZXN0IG9uIHY2Ljkga2VybmVscywgdG8gYWNjb3VudCBmb3Ig
Sm9zZWYncyBjaGFuZ2VzIFszXSwgd2hpY2ggcmVzdHJpY3QgdGhlIE5GUy9SUEMgc3RhdHMgcGVy
LW5hbWVzcGFjZS4KPiA+PiBJIHNlZSB0aGF0IEpvc2VmJ3MgY2hhbmdlcyB3ZXJlIGJhY2twb3J0
ZWQsIGFzIGZhciBiYWNrIGFzIGxvbmd0ZXJtIHY1LjQsCj4gPiAKPiA+IFNvcnJ5LCB0aGF0J3Mg
bm90IHF1aXRlIGFjY3VyYXRlLgo+ID4gCj4gPiBKb3NlZidzIE5GUyBjbGllbnQgY2hhbmdlcyB3
ZXJlIGFsbCBiYWNrcG9ydGVkIGZyb20gdjYuOSwgYXMgZmFyIGFzIGxvbmd0ZXJtIHY1LjQueToK
PiA+IAo+ID4gMjA1N2E0OGQwZGQwIHN1bnJwYzogYWRkIGEgc3RydWN0IHJwY19zdGF0cyBhcmcg
dG8gcnBjX2NyZWF0ZV9hcmdzCj4gPiBkNDcxNTFiNzllMzIgbmZzOiBleHBvc2UgL3Byb2MvbmV0
L3N1bnJwYy9uZnMgaW4gbmV0IG5hbWVzcGFjZXMKPiA+IDE1NDgwMzZlZjEyMCBuZnM6IG1ha2Ug
dGhlIHJwY19zdGF0IHBlciBuZXQgbmFtZXNwYWNlCj4gPiAKPiA+IAo+ID4gT2YgSm9zZWYncyBO
RlMgc2VydmVyIGNoYW5nZXMsIGZvdXIgd2VyZSBiYWNrcG9ydGVkIGZyb20gdjYuOSB0byB2Ni44
Ogo+ID4gCj4gPiA0MThiOTY4N2RlY2Ugc3VucnBjOiB1c2UgdGhlIHN0cnVjdCBuZXQgYXMgdGhl
IHN2YyBwcm9jIHByaXZhdGUKPiA+IGQ5ODQxNmNjMjE1NCBuZnNkOiByZW5hbWUgTkZTRF9ORVRf
KiB0byBORlNEX1NUQVRTXyoKPiA+IDkzNDgzYWM1ZmVjNiBuZnNkOiBleHBvc2UgL3Byb2MvbmV0
L3N1bnJwYy9uZnNkIGluIG5ldCBuYW1lc3BhY2VzCj4gPiA0YjE0ODg1NDExZjcgbmZzZDogbWFr
ZSBhbGwgb2YgdGhlIG5mc2Qgc3RhdHMgcGVyLW5ldHdvcmsgbmFtZXNwYWNlCj4gPiAKPiA+IGFu
ZCB0aGUgb3RoZXJzIHJlbWFpbmVkIG9ubHkgaW4gdjYuOToKPiA+IAo+ID4gYWI0MmY0ZDlhMjZm
IHN1bnJwYzogZG9uJ3QgY2hhbmdlIC0+c3Zfc3RhdHMgaWYgaXQgZG9lc24ndCBleGlzdAo+ID4g
YTIyMTRlZDU4OGZiIG5mc2Q6IHN0b3Agc2V0dGluZyAtPnBnX3N0YXRzIGZvciB1bnVzZWQgc3Rh
dHMKPiA+IGYwOTQzMjM4Njc2NiBzdW5ycGM6IHBhc3MgaW4gdGhlIHN2X3N0YXRzIHN0cnVjdCB0
aHJvdWdoIHN2Y19jcmVhdGVfcG9vbGVkCj4gPiAzZjZlZjE4MmYxNDQgc3VucnBjOiByZW1vdmUg
LT5wZ19zdGF0cyBmcm9tIHN2Y19wcm9ncmFtCj4gPiBlNDFlZTQ0Y2M2YTQgbmZzZDogcmVtb3Zl
IG5mc2Rfc3RhdHMsIG1ha2UgdGhfY250IGEgZ2xvYmFsIGNvdW50ZXIKPiA+IDE2ZmI5ODA4YWIy
YyBuZnNkOiBtYWtlIHN2Y19zdGF0IHBlci1uZXR3b3JrIG5hbWVzcGFjZSBpbnN0ZWFkIG9mIGds
b2JhbAo+ID4gCj4gPiAKPiA+IAo+ID4gSSdtIHdvbmRlcmluZyBpZiB0aGlzIGRpZmZlcmVuY2Ug
YmV0d2VlbiBORlMgY2xpZW50LCBhbmQgTkZTIHNlcnZlciwgc3RhdCBiZWhhdmlvdXIsIGFjcm9z
cyBrZXJuZWwgdmVyc2lvbnMsIG1heSBwZXJoYXBzIGNhdXNlIHNvbWUgdXNlciBjb25mdXNpb24/
Cj4gCj4gQXMgYSByZWZyZXNoZXIgZm9yIHRoZSBzdGFibGUgZm9sa2VuLCBKb3NlZidzIGNoYW5n
ZXMgbWFrZQo+IG5mc3N0YXRzIHNpbG8nZCwgc28gdGhleSBubyBsb25nZXIgc2hvdyBjb3VudHMg
ZnJvbSB0aGUgd2hvbGUKPiBzeXN0ZW0sIGJ1dCBvbmx5IGZvciBORlMgb3BlcmF0aW9ucyByZWxh
dGluZyB0byB0aGUgbG9jYWwgbmV0Cj4gbmFtZXNwYWNlLiBUaGF0IGlzIGEgc3VycHJpc2luZyBj
aGFuZ2UgZm9yIHNvbWUgdXNlcnMsIHRvb2xzLAo+IGFuZCB0ZXN0aW5nLgo+IAo+IEknbSBub3Qg
Y2xlYXIgb24gd2hldGhlciB0aGVyZSBhcmUgYW55IHJ1bGVzL2d1aWRlbGluZXMgYXJvdW5kCj4g
TFRTIGJhY2twb3J0cyBjYXVzaW5nIGJlaGF2aW9yIGNoYW5nZXMgdGhhdCB1c2VyIHRvb2xzLCBs
aWtlCj4gbmZzc3RhdCwgbWlnaHQgYmUgaW1wYWN0ZWQgYnkuCgpUaGUgc2FtZSBydWxlcyB0aGF0
IGFwcGx5IGZvciBMaW51cydzIHRyZWUgKGkuZS4gbm8gdXNlcnNwYWNlCnJlZ3Jlc3Npb25zLikK
CnRoYW5rcywKCmdyZWcgay1oCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCg==
