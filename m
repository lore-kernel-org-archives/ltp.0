Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A093DC19F2D
	for <ltp@archiver.kernel.org>; Sat, 13 Aug 2022 20:28:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 228D53C95DC
	for <ltp@archiver.kernel.org>; Sat, 13 Aug 2022 22:28:15 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA7153C00BE
 for <ltp@lists.linux.it>; Sat, 13 Aug 2022 22:28:04 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7427860007A
 for <ltp@lists.linux.it>; Sat, 13 Aug 2022 22:28:03 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 851F820870;
 Sat, 13 Aug 2022 20:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660422483;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=waKR5978V73tGm1CAUjjZfbCsZNLTevUWg9aKmLugHw=;
 b=UnOGgf2SfUdj1/UR4fbdvo8TSGF+vBd5KQww4Ag4M1yDh/F+iFyYqb0ofy8rjyyoUYP/Za
 JJ750CJQH9ddN/p9/Gd0hofMe4f4VEnmstiETdSe8T1jZKNipLmdv5mVt9bda1cB/es8dO
 +IP42DmG5j2Z7qbB7e1jh8Y7CcgDwkk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660422483;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=waKR5978V73tGm1CAUjjZfbCsZNLTevUWg9aKmLugHw=;
 b=Jd6ChC4DqZtg8mAbm7qMxjfI+6n5N/OcAgmVlLhLqwHDSiWMQ1H0kQIuRf9tqsL2lkGSwZ
 53h07o7K1ke7U0CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 579B51341F;
 Sat, 13 Aug 2022 20:28:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id vCaQE1MJ+GK9fAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Sat, 13 Aug 2022 20:28:03 +0000
Date: Sat, 13 Aug 2022 22:28:01 +0200
From: Petr Vorel <pvorel@suse.cz>
To: William Roche <william.roche@oracle.com>
Message-ID: <YvgJUbaAfdO8Gtrh@pevik>
References: <1659975072-29808-1-git-send-email-william.roche@oracle.com>
 <1659975072-29808-2-git-send-email-william.roche@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1659975072-29808-2-git-send-email-william.roche@oracle.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [LTP PATCH v1 1/1] syscalls/madvise11: Add some memory
 page soft-offlining control
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
Cc: Liam Merwick <liam.merwick@oracle.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi William,

> +/*\
> + * [Description]
> + * Stress the VMM and soft-offline code by spawning N threads which
> + * allocate memory pages and soft-offline them repeatedly.
> + * Control that soft-offlined pages get correctly replaced: with the
> + * same content and without SIGBUS generation when accessed.
> + * Could be used for example as a regression test-case for the
> + * poisoned soft-offlined pages case fixed by upstream commit
> + * d4ae9916ea29 (mm: soft-offline: close the race against page allocation)
d4ae9916ea29 is from v4.19. I haven't found this commit in git log
in stable linux-4.14.y and linux-4.9.y and it cannot be cherry-picked.
I wonder whether it was fixed differently or it endup as not easily fixable.
(4.9 EOL in 4 months, but 4.14 in Jan 2024).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
