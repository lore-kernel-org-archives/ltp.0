Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D96C433F5
	for <ltp@archiver.kernel.org>; Thu, 19 May 2022 09:48:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 86AAA3CAADA
	for <ltp@archiver.kernel.org>; Thu, 19 May 2022 11:48:01 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8CB3E3CA9B6
 for <ltp@lists.linux.it>; Thu, 19 May 2022 11:47:52 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 00CCC1400972
 for <ltp@lists.linux.it>; Thu, 19 May 2022 11:47:51 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4591321B4C;
 Thu, 19 May 2022 09:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652953671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g5br+7GOjNMiQaHvyZG5RwTiX3xl/PxUWR4eM8qIB4k=;
 b=AFduDTbK6JcjYu5krhaIi53QHYsF5n+g402O5CYEM8a3h89+2c2C3Rob0Q7swAOlxjFEma
 1kKFfvt1cH/n+oTu0Ljk1WE8NE1gZOCPNHLuZ/gGyemkspDwBFg265lMBeLclQeGvtJ46o
 8HWhuJlHQkjgEtIUyTlGOja+CVotiyI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652953671;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g5br+7GOjNMiQaHvyZG5RwTiX3xl/PxUWR4eM8qIB4k=;
 b=8foAtnBbVolBoEK9sbCWCLyvLROwIyAYxwVAckL4adzmSiE1Jon9UsIC5xSIFcK9vJPk7g
 mvNwPP8yyy8varBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C90013456;
 Thu, 19 May 2022 09:47:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id b95QCkcShmL+NgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 19 May 2022 09:47:51 +0000
Date: Thu, 19 May 2022 11:50:02 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <YoYSyilDnoypaFXF@yuki>
References: <47bc8106e2c6f59e297e7cdabea3eef16e65cf44.1652950191.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <47bc8106e2c6f59e297e7cdabea3eef16e65cf44.1652950191.git.jstancek@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/set_mempolicy04: fix node available
 memory check
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
> diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c
> index 4399503c3054..2a1d2e1b9ad0 100644
> --- a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c
> +++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c
> @@ -40,9 +40,11 @@ static struct tst_nodemap *nodes;
>  
>  static void setup(void)
>  {
> +	int node_min_pages = FILES * (FILES + 1) / 2 * 10 + FILES * 10;
                             ^                              ^
			     10 * sum of 1 .. FILES         |
							And I guess this is
							upper bound for
							FILES * (j%10)

Looks good. I guess that I forget to update the estimate when the
allocation pattern got more complex.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Also I guess that this should go in before the release.

>  	page_size = getpagesize();
>  
> -	nodes = tst_get_nodemap(TST_NUMA_MEM, 20 * FILES * page_size / 1024);
> +	nodes = tst_get_nodemap(TST_NUMA_MEM, node_min_pages * page_size / 1024);
>  	if (nodes->cnt <= 1)
>  		tst_brk(TCONF, "Test requires at least two NUMA memory nodes");
>  }
> -- 
> 2.27.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
