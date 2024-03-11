Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F40C54E58
	for <ltp@archiver.kernel.org>; Mon, 11 Mar 2024 14:12:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1C2153CE85E
	for <ltp@archiver.kernel.org>; Mon, 11 Mar 2024 15:12:07 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A33D93C601B
 for <ltp@lists.linux.it>; Mon, 11 Mar 2024 15:11:51 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7008F200965
 for <ltp@lists.linux.it>; Mon, 11 Mar 2024 15:11:49 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8701034D17;
 Mon, 11 Mar 2024 14:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710166308;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aVCKQRwJu2e37WBjNOxhmkcAiwAA23tVZ1jIAbFy1/k=;
 b=vQf0FY1FlnQlHhGICghOu0QHp1avof3Tv2avEmhJHhlDsDPGK0CQqAerJYNnEwf+DlO6Dg
 D22cxkj7BmNhcRlxMNhiGa85UWHuuutd0PCMU+VScokeNz9YvozqwPfV/0U9AFGXKiXcKu
 Xojuwrug5ahcpc3L5gF+wd2HKLtDe7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710166308;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aVCKQRwJu2e37WBjNOxhmkcAiwAA23tVZ1jIAbFy1/k=;
 b=1DANzSiE/Zy2p2HWfEpNVfaEQ4FJLmhO6UUOjZqh86b7jOTLCmCerHxnuCMgZb5bJqU8k/
 4i/16Nyf3gzrZzAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710166308;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aVCKQRwJu2e37WBjNOxhmkcAiwAA23tVZ1jIAbFy1/k=;
 b=vQf0FY1FlnQlHhGICghOu0QHp1avof3Tv2avEmhJHhlDsDPGK0CQqAerJYNnEwf+DlO6Dg
 D22cxkj7BmNhcRlxMNhiGa85UWHuuutd0PCMU+VScokeNz9YvozqwPfV/0U9AFGXKiXcKu
 Xojuwrug5ahcpc3L5gF+wd2HKLtDe7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710166308;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aVCKQRwJu2e37WBjNOxhmkcAiwAA23tVZ1jIAbFy1/k=;
 b=1DANzSiE/Zy2p2HWfEpNVfaEQ4FJLmhO6UUOjZqh86b7jOTLCmCerHxnuCMgZb5bJqU8k/
 4i/16Nyf3gzrZzAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B27B136BA;
 Mon, 11 Mar 2024 14:11:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id v/k8FSQR72V3ZgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 11 Mar 2024 14:11:48 +0000
Date: Mon, 11 Mar 2024 15:11:47 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240311141147.GA431476@pevik>
References: <20240306104609.17141-1-wegao@suse.com>
 <6285aaad-79ca-4d7c-8be0-6d846d165df2@suse.cz>
 <ZepL4jcbj6zmc0E1@wegao>
 <c7027971-9aab-4261-bbd7-f9f221c9387c@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c7027971-9aab-4261-bbd7-f9f221c9387c@suse.cz>
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vQf0FY1F;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1DANzSiE
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.76 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MX_GOOD(-0.01)[]; DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.05)[59.76%]
X-Rspamd-Queue-Id: 8701034D17
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] chdir01.c: set umask to 0 within setup
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

> On 08. 03. 24 0:21, Wei Gao wrote:
> > On Thu, Mar 07, 2024 at 04:18:35PM +0100, Martin Doucha wrote:
> > > Hi,
> > > you're trying to fix a vfat mount quirk. We should fix that in the LTP
> > > library instead, e.g. by setting umask(0) and then restoring the original
> > > value inside safe_mount().

> > Thanks for your feedback.

> > For chdir case i just use Petr's below suggestion(Detail info you can check patch link
> > in below):

> > "2) tests, which set .mount_device = 1 and have more restrictive umask will not
> > work. Workaround would be to not use it and mount manually in the setup().
> > Or, reset umask with umask(0)."

> > https://patchwork.ozlabs.org/project/ltp/patch/20240219134845.22171-1-wegao@suse.com/

> I'd rather avoid mounting in setup unless you need to set special mount
> parameters.

> Mount-time umask does not matter for most filesystem. The exception are vfat
> and exfat which don't have any internal concept of access permissions and
> instead you need to either pass mount options that'll define access
> permissions for all files and directories, otherwise current process umask
> value will be used as the default.

+1

> So resetting umask to 0 before mount and restoring immediately after is
> perfectly safe. But we should later fix it properly by implementing
> per-filesystem mount options.

Yeah, I was thinking about it, but haven't implement it yet because not many
tests need it and it can be mostly workarounded. Do you know tests (beside this
one) which need it?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
