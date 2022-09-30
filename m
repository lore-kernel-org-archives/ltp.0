Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DFCEC433FE
	for <ltp@archiver.kernel.org>; Fri, 30 Sep 2022 09:02:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 926A33CA6A9
	for <ltp@archiver.kernel.org>; Fri, 30 Sep 2022 11:02:39 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 35F4C3C0B82
 for <ltp@lists.linux.it>; Fri, 30 Sep 2022 11:02:29 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5D420602132
 for <ltp@lists.linux.it>; Fri, 30 Sep 2022 11:02:28 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 580E221905;
 Fri, 30 Sep 2022 09:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1664528548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TygVZOcai6IyqIdr6NyPZCQfUHUWsjYVLQa0e8j62QQ=;
 b=aeArPYHZxnfk/qE811+Ig60Tk85vTuz6V2Ad2p5FLmJ+cMGiqyNTfvkaTc6xNCURTwdWa3
 AfBeYBRqtc5q1eXWzoIQTTYu4TWpXsthDPe+kTAY2ocwJvWRkGcyigWYiyuZvXI9j0ZxBR
 SPyQnsfcFnxuBnS+i5MOGOWAXKty+J4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1664528548;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TygVZOcai6IyqIdr6NyPZCQfUHUWsjYVLQa0e8j62QQ=;
 b=RHFaLnr8IhgespyrCgXL4cazJaEoPSZ6pT/0qyfdKrNqIIn0ZVUqjHqxrua+TGbljb0FFb
 fCw2rMH07Gm67fBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1DD2213776;
 Fri, 30 Sep 2022 09:02:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id w+jhAaSwNmPmUgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 30 Sep 2022 09:02:28 +0000
Date: Fri, 30 Sep 2022 11:04:21 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YzaxFda/gGg1TIBR@yuki>
References: <20220929192047.22125-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220929192047.22125-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] zram01.sh: Fix minimal size for XFS on kernel
 5.19
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

Hi!
> mkfs.xfs for kernel 5.19 bumps minimum filesystems 300 MB. Due this we
> already updated minimal filesystem size for all_filesystems /
> $TST_ALL_FILESYSTEMS in 66e05c841. But zram01.sh does not use the API,
> thus update it now.
> 
> Check for RAM size was added for f18c8fd3a for Btrfs on ppc64le due to
> larger page size. Hopefully this is not needed.

Looks to me like that check is there to make sure we have enough RAM to
run the system and create the filesystem at the same time.

It does check if we have more than 1G of memory, which seems sensible
if we are going to allocate ~300MB for a RAM based filesystem.

I would say that we should really do the same for xfs, i.e. rename the
check_space_for_brtfs to check_space_for_fs and pass the fs in the first
argument so that it can appear in the tst_res message.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
