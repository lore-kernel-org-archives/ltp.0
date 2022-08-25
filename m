Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC79ECAAD2
	for <ltp@archiver.kernel.org>; Mon, 29 Aug 2022 09:18:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D8D83CA572
	for <ltp@archiver.kernel.org>; Mon, 29 Aug 2022 11:18:16 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B5E383C8CA7
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 10:09:52 +0200 (CEST)
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A0D131A00996
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 10:09:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
 s=default; t=1661414988;
 bh=Ey9GW0PV5iG2eKxKqte4kaBuQ9z7RLnssn2v4uBnuIE=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=UsqsoMRKTq44PTH9LXGKRrjAFo0QlgSWy8k+pvMx7kNR+xyR320PQ4CF153ciVAzK
 VY0buArQ9R02ARFWWWvIcHC4rrNqwjoaDXKH4rPcIIPDb5KZSAexd8Tm55PvvXAFHb
 lJbOrcXWsXMObhUsj4gMHHGvr52T6NNM8xBzZ1r4=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature ECDSA (P-384))
 (Client did not present a certificate)
 (Authenticated sender: xry111@xry111.site)
 by xry111.site (Postfix) with ESMTPSA id C0F0266850;
 Thu, 25 Aug 2022 04:09:43 -0400 (EDT)
Message-ID: <c02a6b7e4f8e377178b25c30d544420906346816.camel@xry111.site>
To: Alejandro Colomar <alx.manpages@gmail.com>, Linus Torvalds
 <torvalds@linux-foundation.org>
Date: Thu, 25 Aug 2022 16:09:42 +0800
In-Reply-To: <017d77b8-8be3-a0a8-ce2e-17c7b6a16758@gmail.com>
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <20220824185505.56382-1-alx.manpages@gmail.com>
 <CAADnVQKiEVL9zRtN4WY2+cTD2b3b3buV8BQb83yQw13pWq4OGQ@mail.gmail.com>
 <c06008bc-0c13-12f1-df85-3814b74e47f9@gmail.com>
 <CAHk-=whfft=qpCiQ=mkaCz+X1MEfGK5hpUWYoM5zWK=2EQMwyw@mail.gmail.com>
 <20d93962-538c-d2c9-1696-a1bdbffa87f8@gmail.com>
 <5a3ce36a284fe988694d2e75117aca5f9af66194.camel@xry111.site>
 <017d77b8-8be3-a0a8-ce2e-17c7b6a16758@gmail.com>
User-Agent: Evolution 3.45.2 
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 29 Aug 2022 11:17:28 +0200
Subject: Re: [LTP] [PATCH v3] Many pages: Document fixed-width types with
 ISO C naming
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
From: Xi Ruoyao via ltp <ltp@lists.linux.it>
Reply-To: Xi Ruoyao <xry111@xry111.site>
Cc: linux-man <linux-man@vger.kernel.org>, Rich Felker <dalias@libc.org>,
 Alexei Starovoitov <ast@kernel.org>, David Howells <dhowells@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Joseph Myers <joseph@codesourcery.com>,
 linux-arch <linux-arch@vger.kernel.org>, Zack Weinberg <zackw@panix.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Alex Colomar <alx@kernel.org>,
 Michael Kerrisk <mtk.manpages@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 GCC <gcc-patches@gcc.gnu.org>, LTP List <ltp@lists.linux.it>,
 glibc <libc-alpha@sourceware.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, David Laight <David.Laight@aculab.com>,
 Linux API <linux-api@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCAyMDIyLTA4LTI1IGF0IDA5OjQ4ICswMjAwLCBBbGVqYW5kcm8gQ29sb21hciB3cm90
ZToKPiBIaSBYaSwKPiAKPiBPbiA4LzI1LzIyIDA5OjI4LCBYaSBSdW95YW8gd3JvdGU6Cj4gPiBP
biBUaHUsIDIwMjItMDgtMjUgYXQgMDk6MjAgKzAyMDAsIEFsZWphbmRybyBDb2xvbWFyIHZpYSBH
Y2MtcGF0Y2hlcwo+ID4gd3JvdGU6Cj4gPiA+IEkgZG9uJ3Qga25vdyBmb3Igc3VyZSwgYW5kIEkg
bmV2ZXIgcHJldGVuZGVkIHRvIHNheSBvdGhlcndpc2UuwqAgQnV0IHdoYXQKPiA+ID4gSU1ITyB0
aGUga2VybmVsIGNvdWxkIGRvIGlzIHRvIG1ha2UgdGhlIHR5cGVzIGNvbXBhdGlibGUsIGJ5IHR5
cGVkZWZpbmcKPiA+ID4gdG8gdGhlIHNhbWUgZnVuZGFtZW50YWwgdHlwZXMgKGkuZS4sIGxvbmcg
b3IgbG9uZyBsb25nKSB0aGF0IHVzZXItc3BhY2UKPiA+ID4gdHlwZXMgZG8uCj4gPiAKPiA+IElu
IHVzZXItc3BhY2UgdGhpbmdzIGFyZSBhbHJlYWR5IGluY29uc2lzdGVudCBhcyB3ZSBoYXZlIG11
bHRpcGxlIGxpYmMKPiA+IGltcGxlbWVudGF0aW9ucy7CoCBUZWxsaW5nIGV2ZXJ5IGxpYmMgaW1w
bGVtZW50YXRpb24gdG8gc3luYyB0aGVpcgo+ID4gdHlwZWRlZiB3L28gYSBXRzE0IGRlY2lzaW9u
IHdpbGwgb25seSBjYXVzZSAiYWdncmVzc2l2ZSBkaXNjdXNzaW9uIiAoZmFyCj4gPiBtb3JlIGFn
Z3Jlc3NpdmUgdGhhbiB0aGlzIHRocmVhZCwgSSdkIHNheSkuCj4gPiAKPiA+IElmIGludDY0X3Qg
ZXRjLiB3ZXJlIGRlZmluZWQgYXMgYnVpbHRpbiB0eXBlcyBzaW5jZSBlcG9jaCwgdGhpbmdzIHdv
dWxkCj4gPiBiZSBhIGxvdCBlYXNpZXIuwqAgQnV0IHdlIGNhbid0IGNoYW5nZSBoaXN0b3J5Lgo+
IAo+IFRoaXMgd291bGQgYmUgZ3JlYXQuwqAgSSBtZWFuLCB0aGUgZnVuZGFtZW50YWwgdHlwZXMg
c2hvdWxkIGJlIHU4LCB1MTYsCj4gLi4uIGFuZCBpbnQsIGxvbmcsIC4uLiB0eXBlZGVmcyBmb3Ig
dGhlc2UsIGFuZCBub3QgdGhlIG90aGVyIHdheSBhcm91bmQsIAo+IGlmIHRoZSBsYW5ndWFnZSB3
YXMgZGVzaWduZWQgdG9kYXkuCj4gCj4gTWF5YmUgR0NDIGNvdWxkIGNvbnNpZGVyIHNvbWV0aGlu
ZyBsaWtlIHRoYXQuCgpHQ0MgYWxyZWFkeSBoYXZlIF9fVUlOVDhfVFlQRV9fIGV0Yy4gYnV0IGFn
YWluIHRlbGxpbmcgYWxsIGxpYmMKaW1wbGVtZW50YXRpb25zIHRvIHVzZSAidHlwZWRlZiBfX1VJ
TlQ4X1RZUEVfXyB1aW50OF90IiBldGMuIHdpbGwgbWFrZQpubyBlZmZlY3QgZXhwZWN0IGFubm95
aW5nIHRoZWlyIG1haW50YWluZXJzLgoKLS0gClhpIFJ1b3lhbyA8eHJ5MTExQHhyeTExMS5zaXRl
PgpTY2hvb2wgb2YgQWVyb3NwYWNlIFNjaWVuY2UgYW5kIFRlY2hub2xvZ3ksIFhpZGlhbiBVbml2
ZXJzaXR5CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlz
dGluZm8vbHRwCg==
