Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BABC433EF
	for <ltp@archiver.kernel.org>; Thu,  3 Mar 2022 14:04:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 465323CA343
	for <ltp@archiver.kernel.org>; Thu,  3 Mar 2022 15:04:43 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7A75B3C08D0
 for <ltp@lists.linux.it>; Thu,  3 Mar 2022 15:04:34 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 57FBB1000F10
 for <ltp@lists.linux.it>; Thu,  3 Mar 2022 15:04:32 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 745911F388;
 Thu,  3 Mar 2022 14:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646316272;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8OM9NqQDOEo0rUjnAnViTzC52L/KCX37Psjq7tEI4Mg=;
 b=e81boYqJwZvQCV3ksI80IcFKcwXXPUvJ5jfPQKlkre+wZohj+8MNTBi0NIip2ceL16dkye
 H98+uTJpQ/MC0VK19YNFOkK43WwS+8VfJshY0rFDg1NnTB/UlS33kQO3aak6rA2y8eQOMR
 4c24M5FTWTjkHf/IckTvLDdVBK4Ags4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646316272;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8OM9NqQDOEo0rUjnAnViTzC52L/KCX37Psjq7tEI4Mg=;
 b=SvGgxHY01oeAVnNxsVQD5H9WMMBLEKAO1yQZz0l+xLbBrt9qYBbS84SiOstDM64exZPF8/
 Pydi+6FlJaWdlpDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5187113C35;
 Thu,  3 Mar 2022 14:04:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id hFskEvDKIGI4bQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 03 Mar 2022 14:04:32 +0000
Date: Thu, 3 Mar 2022 15:04:30 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YiDK7g1pwLj2aXBD@pevik>
References: <1646297678-2141-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1646297678-2141-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/setsockopt09: Add another linux git
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu,

> On centos7.9ga, I still hit another crash problem because of use-after-free in
> prb_retire_rx_blk_timer_expired(). Since we free it when timer expired, so this
> case will crash after we print TPASS info.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

LGTM.
I tested two old kernels, the one with patch survives, the other got reboot.

BTW funny enough the affected system manages to print "TPASS: Nothing bad
happened, probably" before reboot :).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
