Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A886C28D13
	for <ltp@archiver.kernel.org>; Thu, 25 Aug 2022 05:57:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C9F2B3CA478
	for <ltp@archiver.kernel.org>; Thu, 25 Aug 2022 07:57:25 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D36903C136F
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 07:57:15 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EF9FD600C35
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 07:57:14 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id BECF861862;
 Thu, 25 Aug 2022 05:57:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E63CC433C1;
 Thu, 25 Aug 2022 05:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1661407032;
 bh=BzxcFbEfQ/Yeo0E0e2sHS9CwVB1n9JHMHeKD1IhcYQE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WEt6QVjfJvyXaIx6HafON24CGsg9kBIx410clN6sJBNxvMYqYT3t69Qvv8fUydCii
 VOwmEd+zP/S8e5fTVek0cwEzoI7qPe3LRWV7/keV37Vli2wwYtB4pRJJqPwFYcThG8
 Wop0557JL/SJdBKCbpMCKDMgvC3WMpgcPTgoiaFA=
Date: Thu, 25 Aug 2022 07:57:23 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alejandro Colomar <alx.manpages@gmail.com>
Message-ID: <YwcPQ987poRYjfoL@kroah.com>
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <20220824185505.56382-1-alx.manpages@gmail.com>
 <CAADnVQKiEVL9zRtN4WY2+cTD2b3b3buV8BQb83yQw13pWq4OGQ@mail.gmail.com>
 <c06008bc-0c13-12f1-df85-3814b74e47f9@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c06008bc-0c13-12f1-df85-3814b74e47f9@gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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
Cc: linux-man <linux-man@vger.kernel.org>, Rich Felker <dalias@libc.org>,
 Alexei Starovoitov <ast@kernel.org>, David Howells <dhowells@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Joseph Myers <joseph@codesourcery.com>,
 linux-arch <linux-arch@vger.kernel.org>, Zack Weinberg <zackw@panix.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Alex Colomar <alx@kernel.org>,
 Michael Kerrisk <mtk.manpages@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 GCC <gcc-patches@gcc.gnu.org>, LTP List <ltp@lists.linux.it>,
 glibc <libc-alpha@sourceware.org>, Linux API <linux-api@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, David Laight <David.Laight@aculab.com>,
 Adhemerval Zanella <adhemerval.zanella@linaro.org>, bpf <bpf@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Aug 25, 2022 at 01:36:10AM +0200, Alejandro Colomar wrote:
> But from your side what do we have?  Just direct NAKs without much
> explanation.  The only one who gave some explanation was Greg, and he
> vaguely pointed to Linus's comments about it in the past, with no precise
> pointer to it.  I investigated a lot before v2, and could not find anything
> strong enough to recommend using kernel types in user space, so I pushed v2,
> and the discussion was kept.

So despite me saying that "this is not ok", and many other maintainers
saying "this is not ok", you applied a patch with our objections on it?
That is very odd and a bit rude.

> I would like that if you still oppose to the patch, at least were able to
> provide some facts to this discussion.

The fact is that the kernel can not use the namespace that userspace has
with ISO C names.  It's that simple as the ISO standard does NOT
describe the variable types for an ABI that can cross the user/kernel
boundry.

Work with the ISO C standard if you wish to document such type usage,
and get it approved and then we would be willing to consider such a
change.  But until then, we have to stick to our variable name types,
just like all other operating systems have to (we are not alone here.)

Please revert your change.

greg k-h

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
