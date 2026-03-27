Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1AFB10F285E
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 17:44:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 749C23DB86E
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 18:44:17 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A41B3CFB7B
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 18:43:56 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5D909140124B
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 18:43:55 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4D77D4D205;
 Fri, 27 Mar 2026 17:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774633435;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RuqiZpapQLKOTthgyI+x7iewkuO+ccQbZ9lX8KMK4q8=;
 b=TFMHD+Gnk+rhuU4RC9bdpmZnF6O/PG+OKBcYvDMv+i5JHhdqd2l4971j8AhLpbr5kDGCqg
 gjCw6ABl6wyihd3gtINClRob+ULljQEnYAjaZEFA0oSqeI9VwjYRKNdPabBjitNT9KvAia
 8xoAZBVh9BV+e3RI7eJ621zmZwdF4Yc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774633435;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RuqiZpapQLKOTthgyI+x7iewkuO+ccQbZ9lX8KMK4q8=;
 b=T6NFn+UIctTbT3a3TejuFLkNkIg9b9jKCAX7PHGNrvW68SJWsj2miOuFCAindALTOFB2G2
 V7BjAV1cwuGtNjDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774633435;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RuqiZpapQLKOTthgyI+x7iewkuO+ccQbZ9lX8KMK4q8=;
 b=TFMHD+Gnk+rhuU4RC9bdpmZnF6O/PG+OKBcYvDMv+i5JHhdqd2l4971j8AhLpbr5kDGCqg
 gjCw6ABl6wyihd3gtINClRob+ULljQEnYAjaZEFA0oSqeI9VwjYRKNdPabBjitNT9KvAia
 8xoAZBVh9BV+e3RI7eJ621zmZwdF4Yc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774633435;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RuqiZpapQLKOTthgyI+x7iewkuO+ccQbZ9lX8KMK4q8=;
 b=T6NFn+UIctTbT3a3TejuFLkNkIg9b9jKCAX7PHGNrvW68SJWsj2miOuFCAindALTOFB2G2
 V7BjAV1cwuGtNjDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D551B4A0A2;
 Fri, 27 Mar 2026 17:43:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BLaOMdrBxmluGQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 27 Mar 2026 17:43:54 +0000
Date: Fri, 27 Mar 2026 18:43:38 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260327174338.GB1097030@pevik>
References: <20260327123351.GA1083266@pevik>
 <69c68890.7b0a0220.33fc19.bf70@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <69c68890.7b0a0220.33fc19.bf70@mx.google.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,checkpatch.pl:url,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] editorconfig: add consistent formatting
 rules for LTP
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi Petr,

> > FYI I asked for 4 in v1 [1], Jan had originally 8 and I'm ok with following
> > kernel. It's just my personal preference to display tab as 4 spaces and not 8
> > (IMHO editorconfig plugins don't allow certain setup to be overwritten).

> Sorry I missed that. I'm just wondering if editor configuration is applied
> only for visualization or also for typing. If it's applied for typing then we
> can't use 4 chars, otherwise we will have many issues with checkpatch.pl when
> verifying the source code.

To be honest I don't know (I haven't installed the plugin for my editor yet).
But I'd suspect that on indent_style = tab it just adds a tab and indent_size = 8
is only the representation.

https://github.com/editorconfig/editorconfig/wiki/EditorConfig-Properties#indent_size

	Indentation Size (in single-spaced characters)

	Possible Values

		an integer
		tab

	If indent_size equals to tab, the indent_size will be set to the tab size,
	which should be tab_width if tab_width is specified, or the tab size set by
	editor if tab_width is not specified.

I wonder if it worked for us to set indent_size = unset for all indent_style = tab
(of course not for indent_style = space).

https://github.com/editorconfig/editorconfig/wiki/EditorConfig-Properties#current-universal-properties

	For any property, a value of unset is to remove the effect of that property,
	even if it has been set before. For example, add indent_size = unset to undefine
	indent_size property (and use editor default).

@Jan?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
