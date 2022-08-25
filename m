Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49A2ECAAD2
	for <ltp@archiver.kernel.org>; Mon, 29 Aug 2022 09:18:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA1D63CA58C
	for <ltp@archiver.kernel.org>; Mon, 29 Aug 2022 11:18:03 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BEE8F3C3090
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 09:28:42 +0200 (CEST)
Received: from xry111.site (xry111.site [89.208.246.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0B276200AF5
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 09:28:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
 s=default; t=1661412519;
 bh=9K2f0e10ZANjjOudPs4B7euHG9H2+iiRuaYv5ZJbA1k=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=nmfnx0FO7b7ckLx4wu28ch41hPeeFb8cw/Rec9LmSdOzvBzyZRKWr29E2ij+mZidq
 p+PyBUS94RPQ8ZVOQohv/ssSTzNWvFVIBOAK2oXYYvF8PxE+ncWh8Qc0BRBwiC+nYu
 1x1J2Ybes6HSKUHLHDFj3IlLEWTGqKVW0tWQGC4U=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest
 SHA384) (Client did not present a certificate)
 (Authenticated sender: xry111@xry111.site)
 by xry111.site (Postfix) with ESMTPSA id 1A8FD6684B;
 Thu, 25 Aug 2022 03:28:33 -0400 (EDT)
Message-ID: <5a3ce36a284fe988694d2e75117aca5f9af66194.camel@xry111.site>
To: Alejandro Colomar <alx.manpages@gmail.com>, Linus Torvalds
 <torvalds@linux-foundation.org>
Date: Thu, 25 Aug 2022 15:28:32 +0800
In-Reply-To: <20d93962-538c-d2c9-1696-a1bdbffa87f8@gmail.com>
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <20220824185505.56382-1-alx.manpages@gmail.com>
 <CAADnVQKiEVL9zRtN4WY2+cTD2b3b3buV8BQb83yQw13pWq4OGQ@mail.gmail.com>
 <c06008bc-0c13-12f1-df85-3814b74e47f9@gmail.com>
 <CAHk-=whfft=qpCiQ=mkaCz+X1MEfGK5hpUWYoM5zWK=2EQMwyw@mail.gmail.com>
 <20d93962-538c-d2c9-1696-a1bdbffa87f8@gmail.com>
User-Agent: Evolution 3.45.2 
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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

T24gVGh1LCAyMDIyLTA4LTI1IGF0IDA5OjIwICswMjAwLCBBbGVqYW5kcm8gQ29sb21hciB2aWEg
R2NjLXBhdGNoZXMKd3JvdGU6Cj4gSSBkb24ndCBrbm93IGZvciBzdXJlLCBhbmQgSSBuZXZlciBw
cmV0ZW5kZWQgdG8gc2F5IG90aGVyd2lzZS7CoCBCdXQgd2hhdCAKPiBJTUhPIHRoZSBrZXJuZWwg
Y291bGQgZG8gaXMgdG8gbWFrZSB0aGUgdHlwZXMgY29tcGF0aWJsZSwgYnkgdHlwZWRlZmluZyAK
PiB0byB0aGUgc2FtZSBmdW5kYW1lbnRhbCB0eXBlcyAoaS5lLiwgbG9uZyBvciBsb25nIGxvbmcp
IHRoYXQgdXNlci1zcGFjZSAKPiB0eXBlcyBkby4KCkluIHVzZXItc3BhY2UgdGhpbmdzIGFyZSBh
bHJlYWR5IGluY29uc2lzdGVudCBhcyB3ZSBoYXZlIG11bHRpcGxlIGxpYmMKaW1wbGVtZW50YXRp
b25zLiAgVGVsbGluZyBldmVyeSBsaWJjIGltcGxlbWVudGF0aW9uIHRvIHN5bmMgdGhlaXIKdHlw
ZWRlZiB3L28gYSBXRzE0IGRlY2lzaW9uIHdpbGwgb25seSBjYXVzZSAiYWdncmVzc2l2ZSBkaXNj
dXNzaW9uIiAoZmFyCm1vcmUgYWdncmVzc2l2ZSB0aGFuIHRoaXMgdGhyZWFkLCBJJ2Qgc2F5KS4K
CklmIGludDY0X3QgZXRjLiB3ZXJlIGRlZmluZWQgYXMgYnVpbHRpbiB0eXBlcyBzaW5jZSBlcG9j
aCwgdGhpbmdzIHdvdWxkCmJlIGEgbG90IGVhc2llci4gIEJ1dCB3ZSBjYW4ndCBjaGFuZ2UgaGlz
dG9yeS4KCi0tIApYaSBSdW95YW8gPHhyeTExMUB4cnkxMTEuc2l0ZT4KU2Nob29sIG9mIEFlcm9z
cGFjZSBTY2llbmNlIGFuZCBUZWNobm9sb2d5LCBYaWRpYW4gVW5pdmVyc2l0eQoKLS0gCk1haWxp
bmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
