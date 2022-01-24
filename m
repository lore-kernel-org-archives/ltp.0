Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 098F0C433F5
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 15:19:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B1AAF3C8DD9
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 16:19:20 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BB1BC3C6F26
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 16:19:10 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 51E7D200381
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 16:19:09 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9B64D212BF;
 Mon, 24 Jan 2022 15:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643037549;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Af/f6InLjnwpNk8++e3nkXj7lbvo4up8C7OSQBX5K4A=;
 b=S9OzAl4ACI0gO5mfqou9InGSV54zkwUsx8MvvdhIp0CHKsZixcDVHtU3/635L4RT6k8iAV
 IJPkjbAbl/gYpbaETGkcd/O1d90sUpp6C7p37Fl8KQWbK+WfMPQPfG8iry23xx2SMGnwvZ
 6YZ32Ol26N+gi3W/iG7z0Ggus7avCDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643037549;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Af/f6InLjnwpNk8++e3nkXj7lbvo4up8C7OSQBX5K4A=;
 b=Hj5dru6R52SFV28MXmWr50O5y4uoMLbA+hMdLeaxcMoV5YRTcu5SOSjKcbU+uLTp/Q6UsU
 CRjVoWl3KvHmZoDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 73ACD13C1B;
 Mon, 24 Jan 2022 15:19:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4IIfG23D7mF5FwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 24 Jan 2022 15:19:09 +0000
Date: Mon, 24 Jan 2022 16:19:08 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Ye7DbPmw1rq5wEhy@pevik>
References: <20220119195519.3117-1-pvorel@suse.cz>
 <20220119195519.3117-2-pvorel@suse.cz>
 <3611b369-89b8-c9bc-92b7-ea69f91fea13@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3611b369-89b8-c9bc-92b7-ea69f91fea13@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/2] tst_net.sh: Fix for disabled IPv6
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

Hi Martin,

> tst_net_detect_ipv6() should probably run each check only once and cache
> the result. The function is called multiple times and tst_rhost_run()
> could be quite slow if the remote side is on a different physical machine.
You're right, ssh result needs to be cached. Thanks for a review!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
