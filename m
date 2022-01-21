Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1FA4C433EF
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 10:43:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E1BD73C9707
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 11:43:48 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B097E3C922E
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 11:43:40 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1E512200D40
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 11:43:39 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5319C1F884;
 Fri, 21 Jan 2022 10:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642761819;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vZWH2FWi/NSIIib2dJ70vvwNBl5CiNKW0QEsW2PshPU=;
 b=dD69NHMCFSNMRSVWCGyCZMnnRiHx6+laODqOllJHcWvzUNelNdUxfvGGIvTXbBt/6jvFeJ
 IPdXePRVK52wk9yXbSQNNHpWILoVf4n20JLQbaTQcJYN0FEdHMVRPMuhUKnO8amgXc3edt
 YFWo88WcR1aPaDfLHEwBuy8UiUtMDu0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642761819;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vZWH2FWi/NSIIib2dJ70vvwNBl5CiNKW0QEsW2PshPU=;
 b=Vpae1n6co43XeN9mjkdY9/8zoS9BWSkJOInweigs35SHLhL65VQdlb0i06fo1vpq55t4zh
 cjdKqTvWQ6ixxuAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0EADE13CFE;
 Fri, 21 Jan 2022 10:43:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id AFOQAVuO6mFFdgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 21 Jan 2022 10:43:39 +0000
Date: Fri, 21 Jan 2022 11:43:37 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YeqOWdTJ+vNUHnzY@pevik>
References: <20220121100604.1072-1-pvorel@suse.cz>
 <YeqOFoxhwiZqfnID@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YeqOFoxhwiZqfnID@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] aiodio: Skip tests on tmpfs
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

> Hi!
> Looks good to me, but since we are right before release I would be more
> happier if this gets more than one review before it gets pushed.
Definitely. Li, Andrea, Martin, could you please have a look?

Kind regards,
Petr

> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
