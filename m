Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79417C4725D
	for <ltp@archiver.kernel.org>; Fri, 19 Jan 2024 14:53:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EB9E83CE2C0
	for <ltp@archiver.kernel.org>; Fri, 19 Jan 2024 15:53:31 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DACBB3CC864
 for <ltp@lists.linux.it>; Fri, 19 Jan 2024 15:53:17 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3B855140013F
 for <ltp@lists.linux.it>; Fri, 19 Jan 2024 15:53:16 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1F55821E3E;
 Fri, 19 Jan 2024 14:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705675996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FiDWYt0NCn33L2A764ktS9B8B4USaRbdOZO+5LxN0AA=;
 b=d28BMTB0uyxibF7iZjGVNDevuBT+jtoMGmKWquXCYtxUUy0yfVnwOk+r0mlfo6blpdIaIq
 Txw18416yf+HNuUFKxa4Cnrt5qg8IfV0RDN90YZLRn4ynZFvLjVwcxHA+G+8btOaWS1GVW
 DfS40KVMBV68QTMT/bAxaGL/fi/5Sjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705675996;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FiDWYt0NCn33L2A764ktS9B8B4USaRbdOZO+5LxN0AA=;
 b=tzs2ZhFlRiyTY7QgdVzU+SIUdThHqciEP4MiGN8klg4xotg49Tro6zc6YyurPmnhNHU/zU
 AUSn8IwJwkwaRVAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705675996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FiDWYt0NCn33L2A764ktS9B8B4USaRbdOZO+5LxN0AA=;
 b=d28BMTB0uyxibF7iZjGVNDevuBT+jtoMGmKWquXCYtxUUy0yfVnwOk+r0mlfo6blpdIaIq
 Txw18416yf+HNuUFKxa4Cnrt5qg8IfV0RDN90YZLRn4ynZFvLjVwcxHA+G+8btOaWS1GVW
 DfS40KVMBV68QTMT/bAxaGL/fi/5Sjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705675996;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FiDWYt0NCn33L2A764ktS9B8B4USaRbdOZO+5LxN0AA=;
 b=tzs2ZhFlRiyTY7QgdVzU+SIUdThHqciEP4MiGN8klg4xotg49Tro6zc6YyurPmnhNHU/zU
 AUSn8IwJwkwaRVAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F6C6136F5;
 Fri, 19 Jan 2024 14:53:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6EXHAtyMqmVsOgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 19 Jan 2024 14:53:16 +0000
Date: Fri, 19 Jan 2024 15:53:26 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZaqM5o2u6huhz3j7@yuki>
References: <20231011162428.583911-1-pvorel@suse.cz>
 <20231011162428.583911-2-pvorel@suse.cz> <ZapgEnqfXwdL7_Pu@yuki>
 <CAEemH2dAvum4rHr1FpX7Tcii=U9gph+eHGW3rfYzev3S88Cfrg@mail.gmail.com>
 <20240119143329.GA8075@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240119143329.GA8075@pevik>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=d28BMTB0;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=tzs2ZhFl
X-Spamd-Result: default: False [0.19 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[20.85%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1F55821E3E
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] swapon01: Test on all filesystems
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
> > > For the previous iteration of this patch Li wasn't sure if this adds
> > > enough value since there isn't ton of filesystem specific code involved
> > > unless we actually start writing to the swapfile.
> 
> I wonder how to force. We could setup
> 
> sysctl vm.swappiness=100
> 
> But how to consume enough RAM to be actually written?

One way is put the process into a cgroup with fairly small RAM limit and
then allocate and fault memory, getting this right is not that easy
though.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
