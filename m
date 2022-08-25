Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBC7C28D13
	for <ltp@archiver.kernel.org>; Thu, 25 Aug 2022 06:42:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E6F2C3CA417
	for <ltp@archiver.kernel.org>; Thu, 25 Aug 2022 08:42:06 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DBA123C941C
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 08:41:55 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BC944200C6D
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 08:41:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661409713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SnRGgUUehtI16T785sfGREjFhyN78UXi6fpoRdTOHys=;
 b=eREvHp/ixcTz6HNNKyRQ9BKC0k9D8kKM7+RyilnVwNTc63euDmqwUut9EMtoYryTtlnPCq
 e0FPtYBsbgETm9vMgfgpx14n11dbM9w9x+kHCC+2RPLHbMwhRWcVYaYqx979IorL4nL2Gd
 1rP/iYE6c2eCMn4hjrNlD+I0QqdiS5s=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-8-uafwPPMeNIyDl-sRA6BA8g-1; Thu, 25 Aug 2022 02:41:49 -0400
X-MC-Unique: uafwPPMeNIyDl-sRA6BA8g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BDD461C05153;
 Thu, 25 Aug 2022 06:41:48 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.36])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BAC4A492CA5;
 Thu, 25 Aug 2022 06:41:43 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <20220824185505.56382-1-alx.manpages@gmail.com>
 <CAADnVQKiEVL9zRtN4WY2+cTD2b3b3buV8BQb83yQw13pWq4OGQ@mail.gmail.com>
 <c06008bc-0c13-12f1-df85-3814b74e47f9@gmail.com>
 <YwcPQ987poRYjfoL@kroah.com>
Date: Thu, 25 Aug 2022 08:41:41 +0200
In-Reply-To: <YwcPQ987poRYjfoL@kroah.com> (Greg Kroah-Hartman's message of
 "Thu, 25 Aug 2022 07:57:23 +0200")
Message-ID: <87ilmgddui.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
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

* Greg Kroah-Hartman:

> On Thu, Aug 25, 2022 at 01:36:10AM +0200, Alejandro Colomar wrote:
>> But from your side what do we have?  Just direct NAKs without much
>> explanation.  The only one who gave some explanation was Greg, and he
>> vaguely pointed to Linus's comments about it in the past, with no precise
>> pointer to it.  I investigated a lot before v2, and could not find anything
>> strong enough to recommend using kernel types in user space, so I pushed v2,
>> and the discussion was kept.
>
> So despite me saying that "this is not ok", and many other maintainers
> saying "this is not ok", you applied a patch with our objections on it?
> That is very odd and a bit rude.

The justifications brought forward are just regurgitating previous
misinformation.  If you do that, it's hard to take you seriously.

There is actually a good reason for using __u64: it's always based on
long long, so the format strings are no longer architecture-specific,
and those ugly macro hacks are not needed to achieve portability.  But
that's really the only reason I'm aware of.  Admittedly, it's a pretty
good reason.

>> I would like that if you still oppose to the patch, at least were able to
>> provide some facts to this discussion.
>
> The fact is that the kernel can not use the namespace that userspace has
> with ISO C names.  It's that simple as the ISO standard does NOT
> describe the variable types for an ABI that can cross the user/kernel
> boundry.

You cannot avoid using certain ISO C names with current GCC or Clang,
however hard you try.  But currently, the kernel does not try at all,
not really: it is not using -ffreestanding and -fno-builtin, at least
not consistently.  This means that if the compiler sees a known function
(with the right name and a compatible prototype), it will optimize based
on that.  What kind of headers you use does not matter.

<stdarg.h>, <stddef.h>, <stdint.h> are compiler-provided headers that
are designed to be safe to use for bare-metal contexts (like in
kernels).  Avoiding them is not necessary per se.  However, <stdint.h>
is not particularly useful if you want to use your own printf-style
functions with the usual format specifiers (see above for __u64).  But
on its own, it's perfectly safe to use.  You have problems with
<stdint.h> *because* you use well-known, standard facilities in kernel
space (the printf format specifiers), not because you avoid them.  So
exactly the opposite of what you say.

> But until then, we have to stick to our variable name types,
> just like all other operating systems have to (we are not alone here.)

FreeBSD uses <stdint.h> and the <inttypes.h> formatting macros in kernel
space.  I don't think that's unusual at all for current kernels.  It's
particularly safe for FreeBSD because they use a monorepo and toolchain
variance among developers is greatly reduced.  Linux would need to
provide its own <inttypes.h> equivalent for the formatting macros
(as it's not a compiler header; FreeBSD has <machine/_inttypes.h>).

At this point and with the current ABIs we have for Linux, it makes
equal (maybe more) sense to avoid the <stdint.h> types altogether and
use Linux-specific typedefs with have architecture-independent format
strings.

Thanks,
Florian


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
