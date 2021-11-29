Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F6F5C433EF
	for <ltp@archiver.kernel.org>; Mon, 29 Nov 2021 11:57:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 22F703C4E1D
	for <ltp@archiver.kernel.org>; Mon, 29 Nov 2021 12:57:54 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AAA8F3C1044
 for <ltp@lists.linux.it>; Mon, 29 Nov 2021 12:57:44 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3D3A51000A3A
 for <ltp@lists.linux.it>; Mon, 29 Nov 2021 12:57:43 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8CB431FD38;
 Mon, 29 Nov 2021 11:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1638187063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FVDQcZLHC3tPkZdXshg+mfyHdXB90Lp7oCFBvM1e3JM=;
 b=AgaHeOHi1NsfHACoVX9xaT0TLBu4DfbDjvMkx0ruxufTKt4Al869dicbkc4oyuYIWMfZAt
 Jcd2+zlemTc2ncDC3oNQzTeNv3eDbHylTIwO/BDjDyxqnHP0nouQoHHRsUW8dblF3goFwa
 Ma3rWyALvggnm3YxqsikVuB/YZtVlDM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1638187063;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FVDQcZLHC3tPkZdXshg+mfyHdXB90Lp7oCFBvM1e3JM=;
 b=wsq6sBFCJOr1290Umq666MEOHGFk3VCCUzpG0XAs3oWuvGVeb2B5L/Gy2XELaCcNbX988M
 GTN1EwBL0nBeQMDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 696BD13A86;
 Mon, 29 Nov 2021 11:57:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 47rlFjfApGG+IgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 29 Nov 2021 11:57:43 +0000
Date: Mon, 29 Nov 2021 12:58:53 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: David Laight <David.Laight@ACULAB.COM>
Message-ID: <YaTAffbvzxGGsVIv@yuki>
References: <YZvIlz7J6vOEY+Xu@yuki> <1618289.1637686052@warthog.procyon.org.uk>
 <ff8fc4470c8f45678e546cafe9980eff@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ff8fc4470c8f45678e546cafe9980eff@AcuMS.aculab.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] uapi: Make __{u, s}64 match {u,
 }int64_t in userspace
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
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 'David Howells' <dhowells@redhat.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > > This changes the __u64 and __s64 in userspace on 64bit platforms from
> > > long long (unsigned) int to just long (unsigned) int in order to match
> > > the uint64_t and int64_t size in userspace.
> 
> That is a massive UAPI change you can't do.

Understood.

However it can still be changed if user asks for it explicitly right?

What about guarding the change with __STDINT_COMPATIBLE_TYPES__ as:

#if defined(__STDINT_COMPATIBLE_TYPES__)
# include <stdint.h>

typedef __u64 uint64_t;
...

#else
# include <asm-generic/int-ll64.h>
#endif

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
