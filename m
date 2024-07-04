Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A72C3065C
	for <ltp@archiver.kernel.org>; Thu,  4 Jul 2024 09:23:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1F6473D3CD9
	for <ltp@archiver.kernel.org>; Thu,  4 Jul 2024 11:23:39 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F3CD3D0F62
 for <ltp@lists.linux.it>; Thu,  4 Jul 2024 11:23:23 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BB8902010F0
 for <ltp@lists.linux.it>; Thu,  4 Jul 2024 11:23:21 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9F47B21C08;
 Thu,  4 Jul 2024 09:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720085000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hcAUxIp0QizzHa05XsUAA1ORbirhtBRfpHC5DM6uCU0=;
 b=w8t9LvkpLmeL0erYkxcW4nSDPrrhgdZYAhvwfvoJpe8QNlnee4YsKkaE6I/Dy4DhYVLQfw
 IJzvgWjDZiZKTv5pt8hRL95EWRqqPK/n46OwJ2G/l+K/cjibPEAcWfYYbshl7Kt/spBqhn
 L1CMq4y1/cH3L8tDwPpEAlPmNGikpyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720085000;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hcAUxIp0QizzHa05XsUAA1ORbirhtBRfpHC5DM6uCU0=;
 b=7qIFUB5FF/63Uo5x9pHKk9nGJULhZhLT8DjijFRoX9YJqApJc+OCPzfWIJfptU0OOEzeql
 v+R6okqPuMg1RsAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=w8t9Lvkp;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7qIFUB5F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720085000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hcAUxIp0QizzHa05XsUAA1ORbirhtBRfpHC5DM6uCU0=;
 b=w8t9LvkpLmeL0erYkxcW4nSDPrrhgdZYAhvwfvoJpe8QNlnee4YsKkaE6I/Dy4DhYVLQfw
 IJzvgWjDZiZKTv5pt8hRL95EWRqqPK/n46OwJ2G/l+K/cjibPEAcWfYYbshl7Kt/spBqhn
 L1CMq4y1/cH3L8tDwPpEAlPmNGikpyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720085000;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hcAUxIp0QizzHa05XsUAA1ORbirhtBRfpHC5DM6uCU0=;
 b=7qIFUB5FF/63Uo5x9pHKk9nGJULhZhLT8DjijFRoX9YJqApJc+OCPzfWIJfptU0OOEzeql
 v+R6okqPuMg1RsAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90E2D1369F;
 Thu,  4 Jul 2024 09:23:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MSu5IghqhmZPVQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 04 Jul 2024 09:23:20 +0000
Date: Thu, 4 Jul 2024 11:23:08 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <ZoZp_DbLtR-Y4NIh@yuki>
References: <20240702-stat04-v1-0-e27d9953210d@suse.com>
 <20240702-stat04-v1-1-e27d9953210d@suse.com>
 <CAEemH2dcP695G=Lef+kJfusLoKMZSti_rFYPyEGBHATbnVzKiQ@mail.gmail.com>
 <ZoZov55YEzVMogMd@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZoZov55YEzVMogMd@yuki>
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9F47B21C08
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/5] Add stat04 test
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
> > > +       /* change st_atime / st_mtime / st_ctime */
> > > +       sleep(1);
> > >
> > 
> > Does this 1sec sleep make real sense to the test? Can we remove it?
> 
> With utimensat we can easily change access time and modification time
> but you can't change status change time. So we either sleep here or set
> the system clock back, change the file and then reset the system clock
> back.

And if you are asking if the test will run fine without the sleep, it
will run and it will pass, but the timestamps will be same for the link
and the file, so if kernel picks up wrong timestamp we will not find
out.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
