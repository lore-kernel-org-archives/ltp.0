Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC774C27C4F
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 09:08:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D6E93D0F57
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 11:08:07 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED7EE3D0096
 for <ltp@lists.linux.it>; Fri, 21 Jun 2024 08:30:18 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=arndb.de (client-ip=103.168.172.145;
 helo=fout2-smtp.messagingengine.com; envelope-from=arnd@arndb.de;
 receiver=lists.linux.it)
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com
 [103.168.172.145])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BC41014052DC
 for <ltp@lists.linux.it>; Fri, 21 Jun 2024 08:30:16 +0200 (CEST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfout.nyi.internal (Postfix) with ESMTP id 84F2B138026C;
 Fri, 21 Jun 2024 02:30:14 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
 by compute5.internal (MEProxy); Fri, 21 Jun 2024 02:30:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1718951414;
 x=1719037814; bh=0NAp6YpmQQzb+XaqCHOddozx1CwlQxt9qQHhSQdm/eM=; b=
 YUfcwoBSCsdr4lbdFToY1N/Zs4J4ckS/QAFHkFhDVLoMlvGNE9DG/Up12YB02Xt2
 EvdhpTEPC4jKy9ytn/wkuqfYy4S1cppgeD4oj7WA+/5sqCNg/z+lPwlRbPyO/Flv
 86iciY4yavDos8ifYZIvOfII9G79cFp+BbP22J8pM9RrD+d18AtMZbn8j9nT03bV
 c7xQT06XqtjmkNTJ3loldGGvKZUIHFOFW5y31AIvhjBqlktBLCcT2CdKqNOYzmSV
 sMmQF4/bSVH0PEqvVO/XPs0/1B6SgKYgXBpAog/xndEaqaywJvgFOBJuhrryZ4PT
 p2/5cEIyG3XclTxM5zIk6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1718951414; x=
 1719037814; bh=0NAp6YpmQQzb+XaqCHOddozx1CwlQxt9qQHhSQdm/eM=; b=T
 sA19tgeRrtyO5cROFsAr3JW3gCmvjTkfGvoIFyTvlgeMHOUsPYhUf63dPMHGumOG
 SIVUOPVMYqUiSDU81ctnvLlpO9PEmKT5nYGuN8Yk6mi2deAmhqwvD8T8lcVqcfB1
 GPqL5qicjYl82FohTt6bsxJU60LE/Hsa42KrOIywf7lBtaIPivddS4cPuSL9Zm6B
 LHiJJ7dQip90rRSAu8Rm0KDbhCZ/X7xYsJbH8aqLdEew+kE5apOFPvumBP+Yp5Fz
 Rr5E19oZ7V3IGyh5IXREy5PC+msQ9aq0CnRgKaDNrD+E/iA5xot89u78VGuhZWhK
 zW007umSQsVkCbMOwZN5A==
X-ME-Sender: <xms:9B11ZuBxjRBAW0tNynq8H1-YRQjdkmL-JPoLIbLq-orE5Mdjc1QF6A>
 <xme:9B11ZojY_qLmvoF_ar3eB4_lK44-YnS7iEik2csxzA9Ys1vKqB1JAHCw16DZLb5Ul
 cdeR1H2mE3zhLekbAU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeeffedgudduudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
 tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
 grthhtvghrnhepueelffeiudevhfettedvhfevkeekveevffehveehhefftdeiheduledu
 iedtvdffnecuffhomhgrihhnpegrkhgrrdhmshenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:9B11Zhm6zOHfU1WuWgDdoSU71qsQzLDsjAJ7Nhxw117RxV0KzM2GHQ>
 <xmx:9B11ZsweTZURJjYSmpSNhPg_buY1pvgdHiULQsyQVa-AcYIqIMlFBA>
 <xmx:9B11ZjQp1WOoJc2XCjVhKQs5UkDHi7Xc0oSg1RRu1sY5kpyhJuIyfA>
 <xmx:9B11ZnbfnZmS9DMt_cIsivY9q90FCfqmpn7bFXeT3Vnm0PLjcHHdDQ>
 <xmx:9h11Zm92tL5faK9ZKeseMNCfbg9AEZegZt4gth5vlZ0KCBBhZQ4GEtV8>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 60EDBB6008D; Fri, 21 Jun 2024 02:30:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-522-ga39cca1d5-fm-20240610.002-ga39cca1d
MIME-Version: 1.0
Message-Id: <1308b23a-d7c0-449e-becd-53c42114661e@app.fastmail.com>
In-Reply-To: <e22d7cd7-d247-4426-9506-a3a644ae03c4@cs-soprasteria.com>
References: <20240620162316.3674955-1-arnd@kernel.org>
 <20240620162316.3674955-8-arnd@kernel.org>
 <e80809ba-ee81-47a5-9b08-54b11f118a78@gmx.de>
 <e22d7cd7-d247-4426-9506-a3a644ae03c4@cs-soprasteria.com>
Date: Fri, 21 Jun 2024 08:28:40 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "LEROY Christophe" <christophe.leroy2@cs-soprasteria.com>,
 "Helge Deller" <deller@gmx.de>, "Arnd Bergmann" <arnd@kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 21 Jun 2024 11:00:08 +0200
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
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBKdW4gMjEsIDIwMjQsIGF0IDA3OjI2LCBMRVJPWSBDaHJpc3RvcGhlIHdyb3RlOgo+
IExlIDIwLzA2LzIwMjQgw6AgMjM6MjEsIEhlbGdlIERlbGxlciBhIMOpY3JpdCA6Cj4+IFtWb3Vz
IG5lIHJlY2V2ZXogcGFzIHNvdXZlbnQgZGUgY291cnJpZXJzIGRlIGRlbGxlckBnbXguZGUuIETD
qWNvdXZyZXoKPj4gcG91cnF1b2kgY2VjaSBlc3QgaW1wb3J0YW50IMOgCj4+IGh0dHBzOi8vYWth
Lm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdCj4+Cj4+IE9uIDYvMjAvMjQgMTg6
MjMsIEFybmQgQmVyZ21hbm4gd3JvdGU6Cj4+PiBGcm9tOiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFy
bmRiLmRlPgo+Pj4KPj4+IFRoZSBzeXNfZmFub3RpZnlfbWFyaygpIHN5c2NhbGwgb24gcGFyaXNj
IHVzZXMgdGhlIHJldmVyc2Ugd29yZCBvcmRlcgo+Pj4gZm9yIHRoZSB0d28gaGFsdmVzIG9mIHRo
ZSA2NC1iaXQgYXJndW1lbnQgY29tcGFyZWQgdG8gYWxsIHN5c2NhbGxzIG9uCj4+PiBhbGwgMzIt
Yml0IGFyY2hpdGVjdHVyZXMuIEFzIGZhciBhcyBJIGNhbiB0ZWxsLCB0aGUgcHJvYmxlbSBpcyB0
aGF0Cj4+PiB0aGUgZnVuY3Rpb24gYXJndW1lbnRzIG9uIHBhcmlzYyBhcmUgc29ydGVkIGJhY2t3
YXJkcyAoMjYsIDI1LCAyNCwgMjMsCj4+PiAuLi4pIGNvbXBhcmVkIHRvIGV2ZXJ5b25lIGVsc2Us
Cj4+Cj4+IHIyNiBpcyBhcmcwLCByMjUgaXMgYXJnMSwgYW5kIHNvIG9uLgo+PiBJJ20gbm90IHN1
cmUgSSB3b3VsZCBjYWxsIHRoaXMgInNvcnRlZCBiYWNrd2FyZHMiLgo+PiBJIHRoaW5rIHRoZSBy
ZWFzb24gaXMgc2ltcGx5IHRoYXQgaHBwYSBpcyB0aGUgb25seSAzMi1iaXQgYmlnLWVuZGlhbgo+
PiBhcmNoIGxlZnQuLi4KPgo+IHBvd2VycGMvMzIgaXMgYmlnLWVuZGlhbjogcjMgaXMgYXJnMCwg
cjQgaXMgYXJnMSwgLi4uIHIxMCBpcyBhcmc3LgoKUmlnaHQsIEknbSBwcmV0dHkgc3VyZSB0aGUg
b3JkZXJpbmcgaXMgdGhlIHNhbWUgb24gYXJtLCBtaXBzLApzMzkwLCBtNjhrLCBvcGVucmlzYywg
c2ggYW5kIHNwYXJjIHdoZW4gcnVubmluZyAzMi1iaXQgYmlnLWVuZGlhbgpjb2RlLgoKSXQncyBt
b3JlIGxpa2VseSB0byBiZSByZWxhdGVkIHRvIHRoZSB1cHdhcmQgZ3Jvd2luZyBzdGFjay4KSSBj
aGVja2VkIHRoZSBnY2Mgc291cmNlcyBhbmQgZm91bmQgdGhhdCBvdXQgb2YgdGhlIDUwIHN1cHBv
cnRlZAphcmNoaXRlY3R1cmVzLCBBUkdTX0dST1dfRE9XTldBUkQgaXMgc2V0IG9uIGV2ZXJ5dGhp
bmcgZXhjZXB0CmZvciBnY24sIHN0b3JteTE2IGFuZCAgMzItYml0IHBhcmlzYy4gVGhlIG90aGVy
IHR3byBhcmUKbGl0dGxlLWVuZGlhbiB0aG91Z2guIFNUQUNLX0dST1dTX0RPV05XQVJEIGluIHR1
cm4gaXMgc2V0IG9uCmV2ZXJ5dGhpbmcgb3RoZXIgdGhhbiBwYXJpc2MgKGJvdGggMzItYml0IGFu
ZCA2NC1iaXQpLgoKICAgICAgQXJuZAoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
