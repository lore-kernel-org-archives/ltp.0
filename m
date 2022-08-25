Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92831C28D13
	for <ltp@archiver.kernel.org>; Thu, 25 Aug 2022 15:03:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 78DD53CA2B5
	for <ltp@archiver.kernel.org>; Thu, 25 Aug 2022 17:03:31 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0824A3C8854
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 17:03:19 +0200 (CEST)
Received: from eu-smtp-delivery-151.mimecast.com
 (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 057B6200385
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 17:03:18 +0200 (CEST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-6-CLGAEFtmMmq-sFQCCbZ85g-1; Thu, 25 Aug 2022 16:03:04 +0100
X-MC-Unique: CLGAEFtmMmq-sFQCCbZ85g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.38; Thu, 25 Aug 2022 16:01:31 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.040; Thu, 25 Aug 2022 16:01:31 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Joseph Myers' <joseph@codesourcery.com>, Linus Torvalds
 <torvalds@linux-foundation.org>
Thread-Topic: [PATCH v3] Many pages: Document fixed-width types with ISO C
 naming
Thread-Index: AQHYuJCLMClw4u4WnUme2jwTdxYRD62/tSSA
Date: Thu, 25 Aug 2022 15:01:31 +0000
Message-ID: <5e10ac07e63e41639b3113d12c264447@AcuMS.aculab.com>
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <20220824185505.56382-1-alx.manpages@gmail.com>
 <CAADnVQKiEVL9zRtN4WY2+cTD2b3b3buV8BQb83yQw13pWq4OGQ@mail.gmail.com>
 <c06008bc-0c13-12f1-df85-3814b74e47f9@gmail.com> <YwcPQ987poRYjfoL@kroah.com>
 <87ilmgddui.fsf@oldenburg.str.redhat.com>
 <CAHk-=whsETo4kc2Ec1Nf4HQY5vKYmRi9et243kyqN4E-=PgKJw@mail.gmail.com>
 <alpine.DEB.2.22.394.2208251435370.104368@digraph.polyomino.org.uk>
In-Reply-To: <alpine.DEB.2.22.394.2208251435370.104368@digraph.polyomino.org.uk>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
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
Cc: Alejandro Colomar <alx.manpages@gmail.com>,
 linux-man <linux-man@vger.kernel.org>, Rich Felker <dalias@libc.org>,
 Alexei Starovoitov <ast@kernel.org>, David Howells <dhowells@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 linux-arch <linux-arch@vger.kernel.org>, Zack
 Weinberg <zackw@panix.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Alex Colomar <alx@kernel.org>, Michael Kerrisk <mtk.manpages@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, GCC <gcc-patches@gcc.gnu.org>,
 LTP List <ltp@lists.linux.it>, glibc <libc-alpha@sourceware.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Adhemerval Zanella <adhemerval.zanella@linaro.org>,
 Linux API <linux-api@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Joseph Myers
> Sent: 25 August 2022 15:39
> 
> On Thu, 25 Aug 2022, Linus Torvalds wrote:
> 
> > That's a small detail that yes, we've tried to avoid the absolute
> > humongous mess that the C standard library has with their horrendous
> > 'PRId*' mess, but honestly, it's just a tiny detail.
> 
> I've not yet implemented it for glibc or for GCC format checking, but C23
> adds 'wN' format length modifiers so you will be able to e.g. use "%w64d"
> with printf to print an int64_t and won't need those PRI macros any more.

Is that meant to work regardless of whether the type is
int, long or long long provided the size is correct?

Or does it require the compiler know which type inttypes.h
uses for uint32_t and uint64_t?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
