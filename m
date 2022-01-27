Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6732C433EF
	for <ltp@archiver.kernel.org>; Thu, 27 Jan 2022 13:58:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1C19D3C9726
	for <ltp@archiver.kernel.org>; Thu, 27 Jan 2022 14:58:10 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8E4213C96EC
 for <ltp@lists.linux.it>; Thu, 27 Jan 2022 14:58:00 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1BB6E100047A
 for <ltp@lists.linux.it>; Thu, 27 Jan 2022 14:57:59 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 32B38218B8;
 Thu, 27 Jan 2022 13:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643291879;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UX7N3W2Onft+qWb7wGZCSLK2ukLeae/Pa70RD+k/hAU=;
 b=cHCtxpaDgHsaxl7VM1mYUZwj5gW8H+6GFwNXO2EgecBratGgaMzSj8hSOsKyLwhDG1F+0L
 tXFBhOyS2HGcucStGMI4bvrI1bLqdX2UJG0zPwQnqrMJzWIt4jCReurcWzphaCHBTqT96J
 caM1BL7sDfGkCTGH7v/oW0/WDjFYNyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643291879;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UX7N3W2Onft+qWb7wGZCSLK2ukLeae/Pa70RD+k/hAU=;
 b=XxKN3pkXMvc3/Q3Xsco5MAS+VW3C4rJ1WEHr9IetkXxIweWHIJcF//1zQh++FsBpppzzHa
 eI86HV++yGh97nBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 026C913BE5;
 Thu, 27 Jan 2022 13:57:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YfiEOuak8mH1LwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 27 Jan 2022 13:57:58 +0000
Date: Thu, 27 Jan 2022 14:57:57 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Message-ID: <YfKk5fcxJkDY+5Zt@pevik>
References: <20220126150824.19331-1-pvorel@suse.cz>
 <7e0628fd-0815-ac51-79e3-9c544da55cb0@bell-sw.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7e0628fd-0815-ac51-79e3-9c544da55cb0@bell-sw.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] tst_net.sh: Print help ASAP
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

Hi Alexey,

thanks for you review, merged.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
