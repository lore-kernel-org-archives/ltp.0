Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B89C43334
	for <ltp@archiver.kernel.org>; Mon, 11 Jul 2022 15:08:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BE42D3C9A4D
	for <ltp@archiver.kernel.org>; Mon, 11 Jul 2022 17:08:53 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 743E73C039E
 for <ltp@lists.linux.it>; Mon, 11 Jul 2022 17:08:43 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E99DD1A008B2
 for <ltp@lists.linux.it>; Mon, 11 Jul 2022 17:08:42 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1A6612291B;
 Mon, 11 Jul 2022 15:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1657552122;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dtikuyI7ocoYg32UJ/6PpZewwe2BWv9rbFYqahOuSok=;
 b=U7mBbap8BFaaCJceZ4RRRjfoetonq7Ue61ZEv5PAYng7s28MgBD/4uXSOkWjH3O/2c4KHD
 Q3aB2lUEZ7sljkTT1JGoZRcKVwfJOcStXXE5ZskUxeKS/okwj0yL2yLo0x36bt/jG7dN1A
 JgSMNmxOzOOSXTZr2X56s5J5Ted+v14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1657552122;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dtikuyI7ocoYg32UJ/6PpZewwe2BWv9rbFYqahOuSok=;
 b=Rwo2pUIJ5zoPht8OqJhBf0w/kosdvZnUiete3FmD8xt/tq3JBtg/770o4rI9skNlZ47CGW
 IZw2rNrxKvLMNxAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E575013322;
 Mon, 11 Jul 2022 15:08:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id M1T4Nfk8zGKxWgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 11 Jul 2022 15:08:41 +0000
Date: Mon, 11 Jul 2022 17:08:40 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Ysw8+JLSELXuS0MI@pevik>
References: <20220609214223.4608-1-pvorel@suse.cz>
 <20220609214223.4608-10-pvorel@suse.cz> <YqyU8goDyTwJjXM4@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YqyU8goDyTwJjXM4@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC][PATCH v2 9/9] nfs: Use TST_ALL_FILESYSTEMS=1
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
Cc: linux-nfs@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> > +	systemctl restart nfs-server

> I wonder do we stil have to care for systems without systemd?
That'd be a question for embedded people. I myself wonder if they all moved to
systemd. But at least Alpine and Buildroot distros allow to use Busybox as init,
thus I'd still care.

> We do have daemonlib.sh in LTP that has restart_daemon() function that
> branches to systemctl|service|/etc/init.d/ that is used by a few tests.
That's exactly what I'm planning to use.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
