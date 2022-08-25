Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB3EECAAD2
	for <ltp@archiver.kernel.org>; Mon, 29 Aug 2022 09:18:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AAD803CA5E5
	for <ltp@archiver.kernel.org>; Mon, 29 Aug 2022 11:18:28 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 93C7A3C0367
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 16:38:58 +0200 (CEST)
Received: from esa3.mentor.iphmx.com (esa3.mentor.iphmx.com [68.232.137.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E7A5360022B
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 16:38:56 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.93,263,1654588800"; d="scan'208";a="81807984"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
 by esa3.mentor.iphmx.com with ESMTP; 25 Aug 2022 06:38:49 -0800
IronPort-SDR: x1Ixj9xEowfDaxB+rCmYv+GSCPnGqKWu+UVR1/d2bXu884TLkcyorKTAOJ3GIdG2sZcAKPnr8C
 HrDpsKuUuy/7A3YVdzDaX/MsrZX96NDhq5JOA2b7iEqcFgR8p++itQnfXWYEalx8sudUp7WR3Q
 um6mcl43b7D6ol4iQIF2NVNDO6kFKAVM4x0sDavVBXMjnIhpFoTzJo4nALK+MjLYUthu9lkmIN
 xkDupHA97VMp7y+qdLBmrdVJnKzGutKQCtTsZdyiix3T/aUpRWC6kZou1GuriOnoXxFN8q1rQH
 aYs=
Date: Thu, 25 Aug 2022 14:38:40 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <CAHk-=whsETo4kc2Ec1Nf4HQY5vKYmRi9et243kyqN4E-=PgKJw@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2208251435370.104368@digraph.polyomino.org.uk>
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <20220824185505.56382-1-alx.manpages@gmail.com>
 <CAADnVQKiEVL9zRtN4WY2+cTD2b3b3buV8BQb83yQw13pWq4OGQ@mail.gmail.com>
 <c06008bc-0c13-12f1-df85-3814b74e47f9@gmail.com> <YwcPQ987poRYjfoL@kroah.com>
 <87ilmgddui.fsf@oldenburg.str.redhat.com>
 <CAHk-=whsETo4kc2Ec1Nf4HQY5vKYmRi9et243kyqN4E-=PgKJw@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-11.mgc.mentorg.com (139.181.222.11) To
 svr-ies-mbx-10.mgc.mentorg.com (139.181.222.10)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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
 LKML <linux-kernel@vger.kernel.org>, David Laight <David.Laight@aculab.com>,
 Adhemerval Zanella <adhemerval.zanella@linaro.org>,
 Linux API <linux-api@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, 25 Aug 2022, Linus Torvalds wrote:

> That's a small detail that yes, we've tried to avoid the absolute
> humongous mess that the C standard library has with their horrendous
> 'PRId*' mess, but honestly, it's just a tiny detail.

I've not yet implemented it for glibc or for GCC format checking, but C23 
adds 'wN' format length modifiers so you will be able to e.g. use "%w64d" 
with printf to print an int64_t and won't need those PRI macros any more.

-- 
Joseph S. Myers
joseph@codesourcery.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
