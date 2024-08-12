Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E65C3DA7F
	for <ltp@archiver.kernel.org>; Mon, 12 Aug 2024 14:03:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AF99E3D2110
	for <ltp@archiver.kernel.org>; Mon, 12 Aug 2024 16:02:59 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AEFEE3D20FE
 for <ltp@lists.linux.it>; Mon, 12 Aug 2024 16:02:45 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kroah.com (client-ip=103.168.172.150;
 helo=fout7-smtp.messagingengine.com; envelope-from=greg@kroah.com;
 receiver=lists.linux.it)
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com
 [103.168.172.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BA2B914004E9
 for <ltp@lists.linux.it>; Mon, 12 Aug 2024 16:02:43 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal
 [10.202.2.42])
 by mailfout.nyi.internal (Postfix) with ESMTP id E7BE1138D6F6;
 Mon, 12 Aug 2024 10:02:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Mon, 12 Aug 2024 10:02:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1723471361;
 x=1723557761; bh=9lY9JDS7kGr4Oa679bFMiFw2WgTYDNc/F/B4G4Uormc=; b=
 d9q1Uvf6+OjRUU23Yw4LLTquf8nPj3n19IMunxwQussv73RFDOMG9vI2aoV5Mt4P
 EVkXVeqSnxEXd9o0G+iKmnUE5MxkV40o022GIRNtHtrgvmQLf9NOLbU26ggbM1jV
 HO4zv+CsEStaccugHj+auj+P+a7Lz8D+JX6m47/qm8jX02Tc73BXjKDsRZmzS7pg
 4JdRcPrSNDffPJ0eVRqsOEepZIja1PPfHbQ68wlprM2De/Vhktjle8qHqticB1G/
 ye+WRbXd+bVp6ScxUpeYFLXXh+YVS5dcEGoL9o1upUwb7jQjeyz8WJBVelPJ215j
 QVqgxaMQdNdkfxhPq0dhEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723471361; x=
 1723557761; bh=9lY9JDS7kGr4Oa679bFMiFw2WgTYDNc/F/B4G4Uormc=; b=h
 BKrlmcKLs5emDkxVdZOrtM6ramG9Tr7e0e3YBzP9ziJg3LTfnm4dPmHr+vqwfdFF
 theksbOUoTr7lDoOaHJT+TZNsCv/iZh5qgg533v/jIHYPdH+XxIa2Uu1DEvbCi0M
 T9XpKLEECsWv+gLNzScjNoMkas070P9qqBJzQkxQEi/ntXfF3iGwiCDAFlEttYTx
 /ISNkkABw1AQKsFUSA1H0xYc0HEm9aH2C0K8hwtYd8owQQjg/I1OxwhW2t52Rszm
 5AJWJ1dejkxo3qVhZ1gG2RDuwVUfvg3EvUNVCScXWZXgEutGpQPw0Pm8mjO3zwZH
 NBPAtljuaGmiPLII1pfwg==
X-ME-Sender: <xms:ARa6ZvkSC_WlmjhP3EjUL4YzjRxRLx59BhpB3cUdLzV6SWI4WR6f9A>
 <xme:ARa6Zi3mRPztZZR3Tv2QyY2MFjHsH1b3_XCDzJkkRW8J0SWOKu-QNp_ufzynNqCdQ
 AIE3UIUrcejQA>
X-ME-Received: <xmr:ARa6ZlrH_n7wnCNCuR0l_NJKMQMLf06bE8Gx22CrRT_R85Q2d7QRf9C-HYKpi9o0O05UW5bdn3AM98Vdf7tD_p57pr20QPTI_Jgbrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddttddgjeduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
 necuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtf
 frrghtthgvrhhnpeelkeehjeejieehjedvteehjeevkedugeeuiefgfedufefgfffhfeet
 ueeikedufeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
 iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
 pdhnsggprhgtphhtthhopedvtddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptg
 hhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepshgrshhhrghl
 sehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtvghlsehkvghrnhgvlhdrohhrghdprh
 gtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
 pehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepph
 hvohhrvghlsehsuhhsvgdrtgiipdhrtghpthhtohepshhhvghrrhihrdihrghnghesohhr
 rggtlhgvrdgtohhmpdhrtghpthhtoheptggrlhhumhdrmhgrtghkrgihsehorhgrtghlvg
 drtghomhdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:ARa6ZnkpcRFeY6dxaoazyBjJ-EI9nIpPTvinRORYP9u7dxtR5Jcg3w>
 <xmx:ARa6Zt0iQX5W9p_XnM8LeZbsSSGcFQZCwIe-2i6VA4aiuxyQRnu8Dw>
 <xmx:ARa6ZmsCsZFKkJxh8JD7Lv2rPJayxop72BJdqoac3_QoMDpSDCE4MA>
 <xmx:ARa6ZhW7y4eRVhkys2FtsJKQsOP0hy6568UluJiu0hgN4haWM-eTzw>
 <xmx:ARa6ZvXAkuWOaAieq5EgXlF62yyQ1dEDFxAdm3n-pGXaapdyiGm4Hco6>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Aug 2024 10:02:40 -0400 (EDT)
Date: Mon, 12 Aug 2024 16:02:39 +0200
From: Greg KH <greg@kroah.com>
To: Chuck Lever III <chuck.lever@oracle.com>
Message-ID: <2024081214-sizzle-repave-65f5@gregkh>
References: <20240810200009.9882-1-cel@kernel.org> <ZrnzLoZ8Tj9GhRSO@sashalap>
 <A0BF8EAF-A16D-4200-8362-E833BA23159D@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <A0BF8EAF-A16D-4200-8362-E833BA23159D@oracle.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 6.1.y 00/18] Backport "make svc_stat per-net
 instead of global"
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
Cc: Sasha Levin <sashal@kernel.org>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 Chuck Lever <cel@kernel.org>, Sherry Yang <sherry.yang@oracle.com>,
 linux-stable <stable@vger.kernel.org>, Calum Mackay <calum.mackay@oracle.com>,
 "kernel-team@fb.com" <kernel-team@fb.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBBdWcgMTIsIDIwMjQgYXQgMDE6NTI6MThQTSArMDAwMCwgQ2h1Y2sgTGV2ZXIgSUlJ
IHdyb3RlOgo+IAo+IAo+ID4gT24gQXVnIDEyLCAyMDI0LCBhdCA3OjM04oCvQU0sIFNhc2hhIExl
dmluIDxzYXNoYWxAa2VybmVsLm9yZz4gd3JvdGU6Cj4gPiAKPiA+IE9uIFNhdCwgQXVnIDEwLCAy
MDI0IGF0IDAzOjU5OjUxUE0gLTA0MDAsIGNlbEBrZXJuZWwub3JnIHdyb3RlOgo+ID4+IEZyb206
IENodWNrIExldmVyIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPgo+ID4+IAo+ID4+IEZvbGxvd2lu
ZyB1cCBvbgo+ID4+IAo+ID4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LW5mcy9kNGIy
MzVkZi00ZWU1LTQ4MjQtOWQ0OC1lM2IzYzFmMWY0ZDFAb3JhY2xlLmNvbS8KPiA+PiAKPiA+PiBI
ZXJlIGlzIGEgYmFja3BvcnQgc2VyaWVzIHRhcmdldGluZyBvcmlnaW4vbGludXgtNi4xLnkgdGhh
dCBjbG9zZXMKPiA+PiB0aGUgaW5mb3JtYXRpb24gbGVhayBkZXNjcmliZWQgaW4gdGhlIGFib3Zl
IHRocmVhZC4KPiA+PiAKPiA+PiBJIHN0YXJ0ZWQgd2l0aCB2Ni4xLnkgYmVjYXVzZSB0aGF0IGlz
IHRoZSBtb3N0IHJlY2VudCBMVFMga2VybmVsCj4gPj4gYW5kIHRodXMgdGhlIGNsb3Nlc3QgdG8g
dXBzdHJlYW0uIEkgcGxhbiB0byBsb29rIGF0IDUuMTUgYW5kIDUuMTAKPiA+PiBMVFMgdG9vIGlm
IHRoaXMgc2VyaWVzIGlzIGFwcGxpZWQgdG8gdjYuMS55Lgo+ID4gCj4gPiA2LjYgd291bGQgYmUg
dGhlIG1vc3QgcmVjZW50IExUUywgYW5kIHdlIHdvdWxkIG5lZWQgdG8gaGF2ZSB0aGlzIHNlcmll
cwo+ID4gb24gdG9wIG9mIDYuNiBmaXJzdCBiZWZvcmUgd2UgY2FuIGJhY2twb3J0IGl0IHRvIG9s
ZGVyIHRyZWVzIDopCj4gCj4gRmFpciBlbm91Z2ggLS0gSSB3YXMgdG9sZCB0aGlzIHdvcmsgd2Fz
IGFscmVhZHkgaW4gNi42LnksIHdoaWNoCj4gaXMgd2h5IEkgc3RhcnRlZCB3aXRoIHY2LjEuIEkn
bGwgdGFrZSBjYXJlIG9mIGl0LgoKT25seSB0aGUgZmlyc3QgZmV3IGNvbW1pdHMgYXJlIGluIDYu
Ni55IGFscmVhZHksIGFuZCB0aG9zZSBkb24ndCBtYWtlCm11Y2ggc2Vuc2UgdG8gdGFrZSBpbnRv
IDYuMS55IG5vdyBhcyB0aGV5IGRvbid0IGRvIGFueXRoaW5nIG9uIHRoZWlyCm93bi4KCnRoYW5r
cywKCmdyZWcgay1oCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
