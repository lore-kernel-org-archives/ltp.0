Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82CBEC433F5
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 12:53:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C37C73C9B2C
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 13:53:56 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 37A1E3C0720
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 13:53:47 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C123E60076F
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 13:53:46 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 05098210E9;
 Mon,  7 Feb 2022 12:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644238426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aNGoO7QhCFxG+ZgebljzoBJROUbObdcMaqsvlg9NqZc=;
 b=Mp7eMAyW9Sb8PHy3UtV2E6vHduDoDBBCYpfStWS8HpQJSILn4pa34iU9g4a7bAq0vFC9B2
 8a8tp8etiFTyVANwrvQG3VCuqAaAIzpUHaEZy2mUbo5ByaLWThYMxL3IlGN01Mx0kjv/W+
 aE3IPnaGb0WbJk2ZDXTIy2NCxnl0F14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644238426;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aNGoO7QhCFxG+ZgebljzoBJROUbObdcMaqsvlg9NqZc=;
 b=/jl/c40FvlgI2OvsXE3YHTScs8SAuQ6b3tyqyWVYE461beER1gccABvoGhZg2xZAXv0LIy
 C1xdoW8MMNC+UmDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DA9D913BF5;
 Mon,  7 Feb 2022 12:53:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id LJ7EL1kWAWLbDwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 07 Feb 2022 12:53:45 +0000
Date: Mon, 7 Feb 2022 13:55:47 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <YgEW0xQU46sy30uU@yuki>
References: <cover.1643980361.git.jstancek@redhat.com>
 <c59ce5a253c3c8022fe465027c9310c29827ffa6.1643980361.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c59ce5a253c3c8022fe465027c9310c29827ffa6.1643980361.git.jstancek@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] syscalls/mkdir09: rewrite in new LTP API
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
> +/*
> + * Child routine which attempts to remove directories from the
> + * test directory which do not exist.
> + */
> +static void test2(int child_num)
>  {
> -	/* Child routine which attempts to remove directories from the
> -	 * test directory which do not exist. Runs until a SIGTERM
> -	 * signal is received. Exits with an error if the proper
> -	 * error is not detected or if the remove operation is
> -	 * successful.
> -	 */
>  

This empty line here looks a bit strange and the same for the test3().
Other than that and the suggestion from Li it looks good.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
