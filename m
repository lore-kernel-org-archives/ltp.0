Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 423B6C27C5E
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 09:32:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B93E53D0B15
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 11:32:50 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5AC923C9430
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 11:32:35 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 865FA608A8E
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 11:32:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4C24221A5A;
 Mon, 10 Jun 2024 09:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718011952;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Trhqn76FhOYmCczavcQ95NQJipPCX/dXyNkHBE30s80=;
 b=dn5YcdVsYaZOWxb9nW6c/AuovE+MhnawfJYDHg+G9e57tC6shPAGk51XvULkNxus7/dz7h
 gdkoSX49q3x8h/gszNEAFBRBy/WUSDS6jRv+Akw+c6xjoBsvkSoa0AXOWcUKRy1X95Qd7/
 ygCMDzTGbj8F5xClnPuVmrdymLNmpus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718011952;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Trhqn76FhOYmCczavcQ95NQJipPCX/dXyNkHBE30s80=;
 b=Hhhj+K0jub+4Eu0YEBhAqaunj+1rP6iy81YphZuccxVAHGAoyUQd7rZxd40kSByQVbx6Li
 70P/OlDzw/eJmXAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dn5YcdVs;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Hhhj+K0j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718011952;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Trhqn76FhOYmCczavcQ95NQJipPCX/dXyNkHBE30s80=;
 b=dn5YcdVsYaZOWxb9nW6c/AuovE+MhnawfJYDHg+G9e57tC6shPAGk51XvULkNxus7/dz7h
 gdkoSX49q3x8h/gszNEAFBRBy/WUSDS6jRv+Akw+c6xjoBsvkSoa0AXOWcUKRy1X95Qd7/
 ygCMDzTGbj8F5xClnPuVmrdymLNmpus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718011952;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Trhqn76FhOYmCczavcQ95NQJipPCX/dXyNkHBE30s80=;
 b=Hhhj+K0jub+4Eu0YEBhAqaunj+1rP6iy81YphZuccxVAHGAoyUQd7rZxd40kSByQVbx6Li
 70P/OlDzw/eJmXAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1EB0913A7F;
 Mon, 10 Jun 2024 09:32:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iIM6BTDIZmbJawAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 10 Jun 2024 09:32:32 +0000
Date: Mon, 10 Jun 2024 11:32:26 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20240610093226.GA705643@pevik>
References: <20240607115304.86028-1-pvorel@suse.cz>
 <6521fb41-3ac4-4487-8cf4-e1faff1e86b7@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6521fb41-3ac4-4487-8cf4-e1faff1e86b7@suse.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4C24221A5A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; REPLYTO_EQ_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [KIRK PATCH 1/1] README: Document passing environment
 variables
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

Hi Andrea,

> Hi!

> LGTM

> Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
Thanks, merged as
https://github.com/linux-test-project/kirk/commit/5e8c8064a0b2cee465f2a1dca1cfebef5ade36a2

BTW I wonder if recent kirk commits (SSH fixes) are strong enough to release
kirk and update LTP. WDYT? Or do you wait for ltx improvements before releasing
new version?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
