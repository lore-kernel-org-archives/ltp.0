Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04270C433F5
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 10:59:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6AC3C3CAE81
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 12:59:11 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 90AB43C28F3
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 12:59:02 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DBE2D1400548
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 12:59:01 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id D7EB72198C;
 Mon, 10 Oct 2022 10:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1665399540;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/aPgwFbJpxt8teSjcFrgakH1+CTtFRKHIHPgStqS95s=;
 b=r50AnDtbkNSzfNmvaKCfjKBU34kB5k7RO4XrgH1gZkKk2CzmY4QJUCX+UGUsMExmJ7Hlek
 wATBiEXzioC3ajJOIWBe26sVzIH871an5JmT7mfEBKvf1KwasAXjFOfUqIC87efwNKOE4E
 y9zd4P+qvg5ivOvHP3RcguxP+dDIykk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1665399540;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/aPgwFbJpxt8teSjcFrgakH1+CTtFRKHIHPgStqS95s=;
 b=3By5R3k7vbjJ+8pDh7UAu6+zLzYsdcRUJF1mttLkv++g4tturf6ekjROkaciDXolxMIwEX
 HxzeKSmY04oWZqCw==
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id F414C2C141;
 Mon, 10 Oct 2022 10:58:59 +0000 (UTC)
References: <20220411094048.1143292-1-liwang@redhat.com>
 <20220411094048.1143292-2-liwang@redhat.com>
 <CAASaF6wZSGKi+ePOcYYiuvQ=RNhu5mPTrY-FFiRMA0UhMaO1Zw@mail.gmail.com>
 <CAEemH2djWZ5ZPj8uYWESy+CGLo7zFD_V==1ROMRLZW78itY51A@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Mon, 10 Oct 2022 11:45:28 +0100
In-reply-to: <CAEemH2djWZ5ZPj8uYWESy+CGLo7zFD_V==1ROMRLZW78itY51A@mail.gmail.com>
Message-ID: <87mta49c7k.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] pkey: correct the PKEY_DISABLE_ACCESS
 definitions on PowerPC
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
Reply-To: rpalethorpe@suse.de
Cc: Ram Pai <linuxram@us.ibm.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Li Wang <liwang@redhat.com> writes:

> On Mon, Apr 11, 2022 at 6:57 PM Jan Stancek <jstancek@redhat.com> wrote:
>
>  On Mon, Apr 11, 2022 at 11:41 AM Li Wang <liwang@redhat.com> wrote:
>  >
>  > Reference: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e9506394a159
>  >
>  > Signed-off-by: Li Wang <liwang@redhat.com>
>  > ---
>  >  testcases/kernel/syscalls/pkeys/pkey.h | 7 +++++++
>  >  1 file changed, 7 insertions(+)
>  >
>  > diff --git a/testcases/kernel/syscalls/pkeys/pkey.h b/testcases/kernel/syscalls/pkeys/pkey.h
>  > index 6e32326b6..6cda88ff1 100644
>  > --- a/testcases/kernel/syscalls/pkeys/pkey.h
>  > +++ b/testcases/kernel/syscalls/pkeys/pkey.h
>  > @@ -11,6 +11,13 @@
>  >  #include "lapi/syscalls.h"
>  >  #include "lapi/mmap.h"
>  >
>  > +#if defined(__powerpc__) || defined(__ppc__)
>  > +# undef PKEY_DISABLE_ACCESS
>  > +# define PKEY_DISABLE_ACCESS 0x3
>
>  Where does powerpc define PKEY_DISABLE_ACCESS as 0x3?
>
> Good question, I previously thought that was officially defined as 0x3 on PowerPC (per Ram's patch).
>
> But after looking at 'powerpc/include/uapi/asm/mman.h' it still includes
> header which define PKEY_DISABLE_ACCESS as 0x1. 
>     #include <asm-generic/mman-common.h>
>
> @Ram Pai, could you explain why you're using 0x3 in kselftest?
> Did I miss anything?

No response and I guess pkey01 would fail on some systems if it weren't
0x1. So I'll mark this as rejected in patchwork.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
