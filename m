Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE25AC433EF
	for <ltp@archiver.kernel.org>; Fri, 20 May 2022 12:01:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 92EDC3CABA9
	for <ltp@archiver.kernel.org>; Fri, 20 May 2022 14:01:33 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3AA1A3C001D
 for <ltp@lists.linux.it>; Fri, 20 May 2022 14:01:23 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4E8C2140111B
 for <ltp@lists.linux.it>; Fri, 20 May 2022 14:01:22 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 786F41FA42;
 Fri, 20 May 2022 12:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1653048082;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eLplvZF4V70e1v4/r0QKJRgbN/UtmdYl5PmA6eZGYC8=;
 b=MYBHdcH2rxJYgLlz0PUM+skefh3bUd/QF9HEbtcS26pLnzH5bnLbaZkVrWpjiPcbem2j8i
 YTpmngMcDAQjjEnoH6PhBCw8bG5pkCGzQ+GSCIN0SNfTsUb+x6N0dDqsxW6MOvgoUOmPR1
 kd+awaf0ukKUk7H7llV4Glv1g86CiIc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1653048082;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eLplvZF4V70e1v4/r0QKJRgbN/UtmdYl5PmA6eZGYC8=;
 b=MUplYjkW0ass3yxbPxn53HCeN5LZqMXWzz8cGmBpZveolw6VHo5IPnXE8480F/jaotBCf3
 4tV7wXY8zxdcb7CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C76E13AF4;
 Fri, 20 May 2022 12:01:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Wp0UCBKDh2JKOgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 20 May 2022 12:01:22 +0000
Date: Fri, 20 May 2022 14:01:19 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YoeDD1LxiDYJ1vRc@pevik>
References: <20220519174151.14114-1-andrea.cervesato@suse.de>
 <YoddOjuTgALjgdP9@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YoddOjuTgALjgdP9@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Fix ltp-aiodio tests failing on s390
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

Hi all,

> Hi!
> > run_child flag is commonly used by aiodio tests in order to check if
> > tests are passed or not and compiler seems to optimize run_child flag
>             ^
> 	    test has finished?

> > because it's not defined as volatile. With this patch we ensure that the
> > flag is set as volatile so tests will work as expected on s390.

> > Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.de>

> The change itself looks fine and should go in before the release.

Merged with amended commit message. Thanks Andrea!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
