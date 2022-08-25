Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862D4ECAAD4
	for <ltp@archiver.kernel.org>; Mon, 29 Aug 2022 09:18:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5BFC13CA5F8
	for <ltp@archiver.kernel.org>; Mon, 29 Aug 2022 11:18:38 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A45E3C8854
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 17:37:45 +0200 (CEST)
Received: from esa4.mentor.iphmx.com (esa4.mentor.iphmx.com [68.232.137.252])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9863460072A
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 17:37:44 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.93,263,1654588800"; d="scan'208";a="81949478"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
 by esa4.mentor.iphmx.com with ESMTP; 25 Aug 2022 07:37:35 -0800
IronPort-SDR: gqfyrLBj4obLayYIodUELOeYAABsqQvo8uOyOawchBB2Q8+w5UxlnjBrn460q3ycd6wHjJqmjd
 gh7T7w/QcDRQ6tORaMlE5kUTFcOMmSI30/IrpvCk5Qd/qmt7O9jkSwCyju+AieGSqCOkgrFf0W
 SQJu/53xgPnTrY4XPza5ZHuv1txMaVQqNKYA+Dwut3Ev6jvZD46k0K/9jtxIlvngRv31VMDc5g
 PzxQEqscK8aPSncjQkN92X4fOOyz2DX2qWOKXKw1t+6Wr0Z6OmFLRCVUkUOLkHjinfKI7N5oFW
 iBQ=
Date: Thu, 25 Aug 2022 15:37:27 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: David Laight <David.Laight@ACULAB.COM>
In-Reply-To: <5e10ac07e63e41639b3113d12c264447@AcuMS.aculab.com>
Message-ID: <alpine.DEB.2.22.394.2208251533340.108545@digraph.polyomino.org.uk>
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <20220824185505.56382-1-alx.manpages@gmail.com>
 <CAADnVQKiEVL9zRtN4WY2+cTD2b3b3buV8BQb83yQw13pWq4OGQ@mail.gmail.com>
 <c06008bc-0c13-12f1-df85-3814b74e47f9@gmail.com> <YwcPQ987poRYjfoL@kroah.com>
 <87ilmgddui.fsf@oldenburg.str.redhat.com>
 <CAHk-=whsETo4kc2Ec1Nf4HQY5vKYmRi9et243kyqN4E-=PgKJw@mail.gmail.com>
 <alpine.DEB.2.22.394.2208251435370.104368@digraph.polyomino.org.uk>
 <5e10ac07e63e41639b3113d12c264447@AcuMS.aculab.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-15.mgc.mentorg.com (139.181.222.15) To
 svr-ies-mbx-10.mgc.mentorg.com (139.181.222.10)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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
Cc: Alejandro Colomar <alx.manpages@gmail.com>,
 linux-man <linux-man@vger.kernel.org>, Rich Felker <dalias@libc.org>,
 Alexei Starovoitov <ast@kernel.org>, David Howells <dhowells@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 linux-arch <linux-arch@vger.kernel.org>, Zack Weinberg <zackw@panix.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Alex Colomar <alx@kernel.org>,
 Michael Kerrisk <mtk.manpages@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 GCC <gcc-patches@gcc.gnu.org>, LTP List <ltp@lists.linux.it>,
 glibc <libc-alpha@sourceware.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Adhemerval Zanella <adhemerval.zanella@linaro.org>,
 Linux API <linux-api@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, 25 Aug 2022, David Laight wrote:

> From: Joseph Myers
> > Sent: 25 August 2022 15:39
> > 
> > On Thu, 25 Aug 2022, Linus Torvalds wrote:
> > 
> > > That's a small detail that yes, we've tried to avoid the absolute
> > > humongous mess that the C standard library has with their horrendous
> > > 'PRId*' mess, but honestly, it's just a tiny detail.
> > 
> > I've not yet implemented it for glibc or for GCC format checking, but C23
> > adds 'wN' format length modifiers so you will be able to e.g. use "%w64d"
> > with printf to print an int64_t and won't need those PRI macros any more.
> 
> Is that meant to work regardless of whether the type is
> int, long or long long provided the size is correct?
> 
> Or does it require the compiler know which type inttypes.h
> uses for uint32_t and uint64_t?

The type passed needs to be that used for the relevant stdint.h typedef, 
not another of the same size.  (For format checking, that means the 
compiler needs to know what the types used in stdint.h are.)

It's now required that if int32_t exists, int_least32_t must have the same 
type, so int_least32_t can also be used with that format (and there are 
'wfN' formats for int_fastN_t / uint_fastN_t as well).

-- 
Joseph S. Myers
joseph@codesourcery.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
