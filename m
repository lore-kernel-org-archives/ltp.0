Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A9BECA0FE1
	for <ltp@archiver.kernel.org>; Fri, 30 Aug 2024 11:56:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 59B2F3D285F
	for <ltp@archiver.kernel.org>; Fri, 30 Aug 2024 13:56:10 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B47F33D1ADC
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 13:55:52 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 12208200142
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 13:55:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 49955219AD;
 Fri, 30 Aug 2024 11:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725018949;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MVjUmo9MNg8gnGhmkuYf5G09VD46d3cO1h1n2PovD6Q=;
 b=cwUJ6mlc9EliiReUrBvlR3+HV2ebsy1gh0c9NrAfNBAR8XF2irUIhXd1PFnnG6CdOypWnr
 g400CwK5BpfgVYiCT9qPAzsMlkBvc+5vx9buiRG4iAJdeAiCQDgmlcKGh2XBb+s0Sj1R3H
 EB10aqFv0BhTery42nKgqgjx7p8EzU4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725018949;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MVjUmo9MNg8gnGhmkuYf5G09VD46d3cO1h1n2PovD6Q=;
 b=FOETRlkONyuA/PwYE7h6F46sxXgWZl8vFU1PdQsFhFcrNSXD9YI5JHJfWyoantFumaYYup
 3X71uSYjMBhuGUBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cwUJ6mlc;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=FOETRlkO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725018949;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MVjUmo9MNg8gnGhmkuYf5G09VD46d3cO1h1n2PovD6Q=;
 b=cwUJ6mlc9EliiReUrBvlR3+HV2ebsy1gh0c9NrAfNBAR8XF2irUIhXd1PFnnG6CdOypWnr
 g400CwK5BpfgVYiCT9qPAzsMlkBvc+5vx9buiRG4iAJdeAiCQDgmlcKGh2XBb+s0Sj1R3H
 EB10aqFv0BhTery42nKgqgjx7p8EzU4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725018949;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MVjUmo9MNg8gnGhmkuYf5G09VD46d3cO1h1n2PovD6Q=;
 b=FOETRlkONyuA/PwYE7h6F46sxXgWZl8vFU1PdQsFhFcrNSXD9YI5JHJfWyoantFumaYYup
 3X71uSYjMBhuGUBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2472613A44;
 Fri, 30 Aug 2024 11:55:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ITHeBkWz0WaeOAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 30 Aug 2024 11:55:49 +0000
Date: Fri, 30 Aug 2024 13:55:39 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20240830115539.GA34405@pevik>
References: <20240828134551.6344-1-wegao@suse.com>
 <20240829065933.21902-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240829065933.21902-1-wegao@suse.com>
X-Rspamd-Queue-Id: 49955219AD
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[3];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] isofs.sh: Create group and user before check
 mount option
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

Hi Wei, Cyril,

> Case will failed if default system has no group named "bin", such
> as suse sle-micro, so this patch will create specific group for test
> instead of fixed "bin" group.

I suggested an alternative solution, which does not force user creation on all
distros.

https://patchwork.ozlabs.org/project/ltp/patch/20240830113913.49675-1-pvorel@suse.cz/

I proposed (long term) library solution:

https://github.com/linux-test-project/ltp/issues/468#issuecomment-2320992135

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
