Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B22CAC599
	for <ltp@archiver.kernel.org>; Wed, 17 Sep 2025 14:59:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E7CC53CDC8A
	for <ltp@archiver.kernel.org>; Wed, 17 Sep 2025 16:59:49 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 90B163CDC09
 for <ltp@lists.linux.it>; Wed, 17 Sep 2025 16:59:34 +0200 (CEST)
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BD027100035A
 for <ltp@lists.linux.it>; Wed, 17 Sep 2025 16:59:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=naotchy.com;
 s=protonmail; t=1758121171; x=1758380371;
 bh=KS8oMjgfWGJ+M/M+iBq8niJkLt5M6HfPKH3Udi5eqzU=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=meQyduWdUaWxuVtIcrhM4VH+ScJSj0EdEBUeEVB+oJLU7HmZppu2VZ2lx+hCD6PIk
 qNGp2MJWXSOD8tErrH+u2mYz5ZZ/Rlq+q6iFCZo2VwDjgD3F9zRQbpeaty9sYDG0qG
 Xz7HRzXD7GCXOHdmii5+VAvUFZKPoLY1vUn3GoWbnjWuAibpXC5gjBQ6bj0fjwJQZm
 mysEl+7asCUCslvhbpoDMqnB9YJns7beRfGD/78v3K5ag7ZSqyrn64zIpt6M6LV8Bo
 yQacYJuAL8I4SSMNvhO3NWbxzymazSyg6r+VjOsX8vQPegCY4g07dg5X9VuH0fqM0r
 OKGKenJobDxDA==
Date: Wed, 17 Sep 2025 14:59:25 +0000
To: Cyril Hrubis <chrubis@suse.cz>
From: Jack Morgan <jmorgan@naotchy.com>
Message-ID: <c614d626-aa36-49b6-b853-a6660e849b83@naotchy.com>
In-Reply-To: <aMfZOzQWQLh82r6y@yuki.lan>
References: <20250913005759.2946000-1-jmorgan@naotchy.com>
 <aMfW_bP12FUgR15H@yuki.lan> <aMfZOzQWQLh82r6y@yuki.lan>
Feedback-ID: 96944049:user:proton
X-Pm-Message-ID: 557f982d34e2c4210518ce163c18eb7cc57423af
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] statmount.h: add check for STATMOUNT_MNT_NS_ID
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 9/15/25 02:15, Cyril Hrubis wrote:
> Hi!
>>> +/* Enable mnt_ns_id check when system struct statmount is not defined. */
>>> +#if !defined(HAVE_STRUCT_STATMOUNT) && !defined(LTP_HAVE_STATMOUNT_MNT_NS_ID)
>>> +#define LTP_HAVE_STATMOUNT_MNT_NS_ID 1
>>> +#endif
> 
> On a second look this looks like you are working around the
> fallback definition we have. But there is no configure check for
> STATMOUNT_MNT_NS_ID that has to be added to configure.ac, we need
> something as:
> 
> AC_CHECK_MEMBERS([struct statmount.mnt_ns_id],,,[#include <unistd.h>])
> 
> That would define HAVE_STRUCT_STATMOUNT_MNT_NS_ID if that field is
> present in the system headers.
> 
> And then we can use that with:
> 
> #if !defined(HAVE_STRUCT_STATMOUNT) || defined(HAVE_STRUCT_STATMOUNT_MNT_NS_ID)
> # define LTP_HAVE_STRUCT_STATMOUNT_MNT_NS_ID 1
> #endif

Thanks for the feedback. I'll send v2 of patches.

Cheers,
jmorgan



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
