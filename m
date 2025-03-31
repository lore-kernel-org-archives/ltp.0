Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F43C36017
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 07:46:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 20BB53CAB8C
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 09:46:02 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 739363C199A
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 09:45:44 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linutronix.de (client-ip=193.142.43.55;
 helo=galois.linutronix.de; envelope-from=bigeasy@linutronix.de;
 receiver=lists.linux.it)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CCADC1400974
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 09:45:43 +0200 (CEST)
Date: Mon, 31 Mar 2025 09:45:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1743407142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QQ/BW6GXmNSlhD+uZ4t2ZYkR1yvCJQ3S7CnL9jv1y1Y=;
 b=Vl23Tf117IRS0N8GCZpT3mpyI5f/8m/vdIZDlPBiKzoW0ZvlR/RLSm2fdecTpsk84JwZPO
 aqNWOlx+pzRXNWB8wgjq3E68MYDFTi2vqduq8C5yTkhDptkEcmfZiwV5AK5R9isk/8WJlC
 tIpKx4XVHoWt70JOrKScwLPytPUqgTMt+vlCJQK5arjVjXP6o8BxVRSqwZLO7Y/nrFje0V
 gissUjTnI0dZac4Eha2AFcE7g+E1xOkaenLwx/UO81iVt0BC67QHK5tE09UjKQZu0Ijx3p
 SCT2Ds0mdtaq7SND1we5DRnSyzK/cHA9t8Emvi/RLKS4HYGFFfvfIoqTo6JttA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1743407142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QQ/BW6GXmNSlhD+uZ4t2ZYkR1yvCJQ3S7CnL9jv1y1Y=;
 b=aIf8YGPqFS8UpqoKhqvAU7P9fA10ugdQ1RoPIZishJZJx9R1P54CgoFNcGw4uRtGF1SuST
 aXDqXRwiAaj1LDDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Luis Chamberlain <mcgrof@kernel.org>
Message-ID: <20250331074541.gK4N_A2Q@linutronix.de>
References: <Z9wF57eEBR-42K9a@bombadil.infradead.org>
 <20250322231440.GA1894930@cmpxchg.org>
 <Z99dk_ZMNRFgaaH8@bombadil.infradead.org>
 <Z9-zL3pRpCHm5a0w@bombadil.infradead.org>
 <Z+JSwb8BT0tZrSrx@xsang-OptiPlex-9020>
 <Z-X_FiXDTSvRSksp@bombadil.infradead.org>
 <Z-YjyBF-M9ciJC7X@bombadil.infradead.org>
 <Z-ZwToVfJbdTVRtG@bombadil.infradead.org>
 <Z-bz0IZuTtwNYPBq@bombadil.infradead.org>
 <Z-c6BqCSmAnNxb57@bombadil.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z-c6BqCSmAnNxb57@bombadil.infradead.org>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [linux-next:master] [block/bdev] 3c20917120:
 BUG:sleeping_function_called_from_invalid_context_at_mm/util.c
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
Cc: Ritesh Harjani <ritesh.list@gmail.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Jan Kara <jack@suse.cz>,
 David Hildenbrand <david@redhat.com>, Dave Chinner <david@fromorbit.com>,
 linux-mm@kvack.org, David Bueso <dave@stgolabs.net>, lkp@intel.com,
 gost.dev@samsung.com, Alistair Popple <apopple@nvidia.com>,
 Matthew Wilcox <willy@infradead.org>, Pankaj Raghav <p.raghav@samsung.com>,
 John Garry <john.g.garry@oracle.com>, Daniel Gomez <da.gomez@samsung.com>,
 Hannes Reinecke <hare@suse.de>, ltp@lists.linux.it,
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 Tso Ted <tytso@mit.edu>, Oliver Sang <oliver.sang@intel.com>,
 Johannes Weiner <hannes@cmpxchg.org>, oe-lkp@lists.linux.dev
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gMjAyNS0wMy0yOCAxNzowODozOCBbLTA3MDBdLCBMdWlzIENoYW1iZXJsYWluIHdyb3RlOgri
gKYKPiA+IEFyZSB0aGVyZSBzb21lIHByZWVtcHRpb24gY29uZmlncyB1bmRlciB3aGljaCBjb25k
X3Jlc2NoZWQoKSB3b24ndAo+ID4gdHJpZ2dlciBhIGtlcm5lbCBzcGxhdCB3aGVyZSBleHBlY3Rl
ZCBzbyB0aGUgb25seSB0aGluZyBJIGNhbiB0aGluayBvZgo+ID4gaXMgcGVyaGFwcyBzb21lIHBy
ZWVtcHQgY29uZmlncyBkb24ndCBpbXBsaWNhdGUgYSBzbGVlcD8gSWYgdHJ1ZSwKPiA+IGluc3Rl
YWQgb2YgYWRkaW5nIG1pZ2h0X3NsZWVwKCkgdG8gb25lIHBpZWNlIG9mIGNvZGUgKGluIHRoaXMg
Y2FzZQo+ID4gZm9pb19tY19jb3B5KCkpIEkgd29uZGVyIGlmIGluc3RlYWQganVzdCBhZGRpbmcg
aXQgdG8gY29uZF9yZXNjaGVkKCkgbWF5Cj4gPiBiZSB1c2VmdWwuCj4gCj4gSSB0aGluayB0aGUg
YW5zd2VyIHRvIHRoZSBhYm92ZSBpcyAibm8iLgoKSSB3b3VsZCBzYXkgc28uIFlvdSBuZWVkIENP
TkZJR19ERUJVR19BVE9NSUNfU0xFRVAgZm9yIHRoZSBtaWdodC1zbGVlcAptYWdpYyB0byB3b3Jr
LiBBbmQgdGhlbiB0aGUgc3BsYXQgZnJvbSBtaWdodF9zbGVlcCgpIGlzbid0IGRpZmZlcmVudAp0
aGFuIHRoZSBvbmUgZnJvbSBjb25kX3Jlc2NoZWQoKS4gCgo+IAo+ICAgTHVpcwoKU2ViYXN0aWFu
CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8v
bHRwCg==
