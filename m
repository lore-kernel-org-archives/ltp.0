Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E164C2BA1A
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 14:27:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C5D373D0EC7
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 16:26:58 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7BAF43C00E4
 for <ltp@lists.linux.it>; Fri, 21 Jun 2024 14:24:01 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=bell.net (client-ip=209.71.212.28; helo=cmx-torrgo001.bell.net;
 envelope-from=dave.anglin@bell.net; receiver=lists.linux.it)
Received: from cmx-torrgo001.bell.net (mta-tor-001.bell.net [209.71.212.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E545D208D29
 for <ltp@lists.linux.it>; Fri, 21 Jun 2024 14:23:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bell.net; s=selector1;
 t=1718972640; bh=4BexjXnCLKq50SSuz100skGcAaq1IqURNAr0X4nDn9U=;
 h=Message-ID:Date:MIME-Version:Subject:To:References:From:In-Reply-To:Content-Type;
 b=mYIu24cb3sC1UqEMEdgMc97Tx1IEsJkvDVvwJGfLwHyjn6/j4lINvId4fOu6mesq9+cQ7gEry6jNdjyVLrhvDtuzDAeLwhOwOe5+c6eq3fqpXOkvNR361EJA673Fby5m83+d6QCiUXSbGYiaI/Qd+YXIWMe+ND0o6J+MgBdbAwoS4SNSNMRn+Hnrn/OGxqPN5nLuLuGucJswai6NQnC1XhDO85lnUN7EZL7dCD+GzTg54ZGtKTrSN83AHeUheQHmHQ2vrCONJeMV9sgpCEz7TIOvt90IR91+pklp9PzKfGPcILZtsOzEiPhiPt1QWAnrwF0s3B2ui/P8RzjL5YgoSg==
X-RG-SOPHOS: Clean
X-RG-VADE-SC: 0
X-RG-VADE: Clean
X-Originating-IP: [70.52.162.67]
X-RG-Env-Sender: dave.anglin@bell.net
X-RG-Rigid: 66756720000522AE
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvledrfeefgedgheduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuuefgnffnpdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomheplfhohhhnucffrghvihguucetnhhglhhinhcuoegurghvvgdrrghnghhlihhnsegsvghllhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeelffffjeehgffgueehleegfeegueeigedtkeffgeduueetffegffejudekgfeunecukfhppeejtddrhedvrdduiedvrdeijeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedrvddrgeelngdpihhnvghtpeejtddrhedvrdduiedvrdeijedpmhgrihhlfhhrohhmpegurghvvgdrrghnghhlihhnsegsvghllhdrnhgvthdpnhgspghrtghpthhtohepfeegpdhrtghpthhtoheprgguhhgvmhgvrhhvrghlrdiirghnvghllhgrsehlihhnrghrohdrohhrghdprhgtphhtthhopegrnhgurhgvrghssehgrghishhlvghrrdgtohhmpdhrtghpthhtoheprghrnhgusegrrhhnuggsrdguvgdprhgtphhtthhopegrrhhnugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggtrghinhesqhhuihgtihhntgdrtghomhdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrgh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received-SPF: softfail (cmx-torrgo001.bell.net: domain bell.net does not
 designate 70.52.162.67 as permitted sender) identity=mailfrom;
 receiver=cmx-torrgo001.bell.net; client-ip=70.52.162.67;
 envelope-from=dave.anglin@bell.net; helo=[192.168.2.49];
Received: from [192.168.2.49] (70.52.162.67) by cmx-torrgo001.bell.net
 (authenticated as dave.anglin@bell.net)
 id 66756720000522AE; Fri, 21 Jun 2024 08:22:45 -0400
Message-ID: <761c5902-9f6e-404e-8265-3060946368c9@bell.net>
Date: Fri, 21 Jun 2024 08:22:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Arnd Bergmann <arnd@arndb.de>,
 LEROY Christophe <christophe.leroy2@cs-soprasteria.com>,
 Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240620162316.3674955-1-arnd@kernel.org>
 <20240620162316.3674955-8-arnd@kernel.org>
 <e80809ba-ee81-47a5-9b08-54b11f118a78@gmx.de>
 <e22d7cd7-d247-4426-9506-a3a644ae03c4@cs-soprasteria.com>
 <1308b23a-d7c0-449e-becd-53c42114661e@app.fastmail.com>
 <3444b93ce46c7e7c156f912495e5c35ccf275549.camel@physik.fu-berlin.de>
Content-Language: en-US
From: John David Anglin <dave.anglin@bell.net>
Autocrypt: addr=dave.anglin@bell.net; keydata=
 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
 T70V9SSrl2hiw38vRzsl
In-Reply-To: <3444b93ce46c7e7c156f912495e5c35ccf275549.camel@physik.fu-berlin.de>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 21 Jun 2024 16:26:16 +0200
Subject: Re: [LTP] [PATCH 07/15] parisc: use generic sys_fanotify_mark
 implementation
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
Cc: Rich Felker <dalias@libc.org>, Andreas Larsson <andreas@gaisler.com>,
 guoren <guoren@kernel.org>,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 "musl@lists.openwall.com" <musl@lists.openwall.com>,
 Nicholas Piggin <npiggin@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 LTP List <ltp@lists.linux.it>, Brian Cain <bcain@quicinc.com>,
 Christian Brauner <brauner@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Xi Ruoyao <libc-alpha@sourceware.org>,
 "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "David S . Miller" <davem@davemloft.net>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gMjAyNC0wNi0yMSA0OjU0IGEubS4sIEpvaG4gUGF1bCBBZHJpYW4gR2xhdWJpdHogd3JvdGU6
Cj4gSGksCj4KPiBPbiBGcmksIDIwMjQtMDYtMjEgYXQgMDg6MjggKzAyMDAsIEFybmQgQmVyZ21h
bm4gd3JvdGU6Cj4+IEl0J3MgbW9yZSBsaWtlbHkgdG8gYmUgcmVsYXRlZCB0byB0aGUgdXB3YXJk
IGdyb3dpbmcgc3RhY2suCj4+IEkgY2hlY2tlZCB0aGUgZ2NjIHNvdXJjZXMgYW5kIGZvdW5kIHRo
YXQgb3V0IG9mIHRoZSA1MCBzdXBwb3J0ZWQKPj4gYXJjaGl0ZWN0dXJlcywgQVJHU19HUk9XX0RP
V05XQVJEIGlzIHNldCBvbiBldmVyeXRoaW5nIGV4Y2VwdAo+PiBmb3IgZ2NuLCBzdG9ybXkxNiBh
bmQgIDMyLWJpdCBwYXJpc2MuIFRoZSBvdGhlciB0d28gYXJlCj4+IGxpdHRsZS1lbmRpYW4gdGhv
dWdoLiBTVEFDS19HUk9XU19ET1dOV0FSRCBpbiB0dXJuIGlzIHNldCBvbgo+PiBldmVyeXRoaW5n
IG90aGVyIHRoYW4gcGFyaXNjIChib3RoIDMyLWJpdCBhbmQgNjQtYml0KS4KPiBXYWl0IGEgc2Vj
b25kISBEb2VzIHRoYXQgbWVhbiB0aGF0IG9uIDY0LWJpdCBQQS1SSVNDLCB0aGUgc3RhY2sgaXMK
PiBhY3R1YWxseSBncm93aW5nIGRvd253YXJkcz8gSWYgeWVzLCB0aGF0IHdvdWxkIGJlIGEgc3Ry
b25nIGFyZ3VtZW50Cj4gZm9yIGNyZWF0aW5nIGEgNjQtYml0IFBBLVJJU0MgcG9ydCBpbiBEZWJp
YW4gYW5kIHJlcGxhY2luZyB0aGUgMzItYml0Cj4gcG9ydC4KTm8sIHRoZSBzdGFjayBncm93cyB1
cHdhcmQgb24gYm90aCAzMiBhbmQgNjQtYml0IHBhcmlzYy7CoCBCdXQgc3RhY2sgYXJndW1lbnRz
Cmdyb3cgdXB3YXJkcyBvbiA2NC1iaXQgcGFyaXNjLsKgIFRoZSBhcmd1bWVudCBwb2ludGVyIGlz
IG5lZWRlZCB0byBhY2Nlc3MgdGhlc2UKYXJndW1lbnRzLsKgIEluIDMyLWJpdCBwYXJpc2MsIHRo
ZSBhcmd1bWVudCBwb2ludGVyIGlzIGF0IGEgZml4ZWQgb2Zmc2V0IHJlbGF0aXZlIHRvIHRoZQpz
dGFjayBwb2ludGVyIGFuZCBpdCBjYW4gYmUgZWxpbWluYXRlZC4KCkRhdmUKCi0tIApKb2huIERh
dmlkIEFuZ2xpbiAgZGF2ZS5hbmdsaW5AYmVsbC5uZXQKCgotLSAKTWFpbGluZyBsaXN0IGluZm86
IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
