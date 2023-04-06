Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A4BC7618D
	for <ltp@archiver.kernel.org>; Thu,  6 Apr 2023 09:49:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E8EE3CC74F
	for <ltp@archiver.kernel.org>; Thu,  6 Apr 2023 11:49:10 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E8893C01AA
 for <ltp@lists.linux.it>; Thu,  6 Apr 2023 11:48:59 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4541B600058
 for <ltp@lists.linux.it>; Thu,  6 Apr 2023 11:48:58 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 67B0222398;
 Thu,  6 Apr 2023 09:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1680774538;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g2l/8xp97JgfmsbE3qOY0gf0lytRsVcBZ6LFjebZ9vI=;
 b=IMs7hbmnr1pWnQVLUkEUAEEsNRmbVCNYbOmIax93qz8+PZMtK4JfqditzeK19Qjc18NMBI
 HpYC49qLLzA4xavfr2GB22NdEo3ocpSgE15MLl2A66vAiLVtf7stMBApMkdg+Uy6h9DYZY
 /JypTl/WweZsn8XujZ4LjUIa3wzjeco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1680774538;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g2l/8xp97JgfmsbE3qOY0gf0lytRsVcBZ6LFjebZ9vI=;
 b=8UMgoblTJsS+w799Mk7V2ADtFkL2qTqSTYyyTfH6loy6uND3g9zPn/1sESCuBetDDgWk9U
 +Ddp1Tx7FRsIjcCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 081281351F;
 Thu,  6 Apr 2023 09:48:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id L7lqO4mVLmScEAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 06 Apr 2023 09:48:57 +0000
Date: Thu, 6 Apr 2023 11:48:53 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20230406094853.GA1545779@pevik>
References: <20230404112852.1271969-1-pvorel@suse.cz>
 <CAEemH2fNLRxhj7NxRvxOr-XYe+gbXiEsYiKosm855_z+jdO5hA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fNLRxhj7NxRvxOr-XYe+gbXiEsYiKosm855_z+jdO5hA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] mmap20: Fix invalid address
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Paulson Raja L <paulson@zilogic.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Hi Petr,

> (1<<9) is also used by another flag on alpha, but it said not
> linux-specific,
> so I guess it won't be a problem (at least for now).
>   alpha/include/uapi/asm/mman.h:#define _MAP_HASSEMAPHORE 0x0200

Good point! I checked only glibc/musl headers, obviously checking kernel sources
is better as it contains old archs. It affects alpha, ia64 and sparc
(well, they might not even compile current LTP, we were dropping ia64 fixes
anyway).

$ git grep -w 0x0200 arch/*/include/uapi/asm/mman.h
arch/alpha/include/uapi/asm/mman.h:#define _MAP_HASSEMAPHORE 0x0200
arch/ia64/include/uapi/asm/mman.h:#define MAP_GROWSUP   0x0200          /* register stack-like segment */
arch/sparc/include/uapi/asm/mman.h:#define MAP_GROWSDOWN        0x0200          /* stack-like segment */

But as 0x400 (1 << 10) is not used anywhere, I merged it with this value.

It'd be good to follow Jan's solution (don't map a file, and then add MAP_SYNC
to flags), but I'll postpone it to later/when needed/never (there are other
tests which needs to be fixed.

Thanks a lot both!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
