Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F0FC36008
	for <ltp@archiver.kernel.org>; Tue, 25 Mar 2025 20:47:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A2E03C9BE3
	for <ltp@archiver.kernel.org>; Tue, 25 Mar 2025 21:47:19 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5FB803C98BA
 for <ltp@lists.linux.it>; Tue, 25 Mar 2025 21:47:02 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 86835610212
 for <ltp@lists.linux.it>; Tue, 25 Mar 2025 21:47:01 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7BC431F397;
 Tue, 25 Mar 2025 20:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1742935619;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AU3g4DfWCz6edGSp9917+tS9RMjvSiTrf50uLl+U/r0=;
 b=22Tz7iIY5F4xXyABteLoE1RuQQappSsgcIiJi6He4wGsByH3wSeca5RIY4oyiWK+82nPui
 C2ZARP114u+NYBVPD7XZ4Hdi3v1vIaTuEDyfT7gY1CLj3sKkuBY7UTLaVxpUVt+6S8eiEV
 07ovPPpyTmMtwsYQZ7kCHuwHejwdVPA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1742935619;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AU3g4DfWCz6edGSp9917+tS9RMjvSiTrf50uLl+U/r0=;
 b=ow+NqmT+sG6Wp3lwr0v7CJrHjWJuvXec1+Y4JM4WFqfiYnKWpX0bHXOC1M4Iq/UmuWPz+G
 Hhn1GulF/oHx61Cg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=22Tz7iIY;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ow+NqmT+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1742935619;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AU3g4DfWCz6edGSp9917+tS9RMjvSiTrf50uLl+U/r0=;
 b=22Tz7iIY5F4xXyABteLoE1RuQQappSsgcIiJi6He4wGsByH3wSeca5RIY4oyiWK+82nPui
 C2ZARP114u+NYBVPD7XZ4Hdi3v1vIaTuEDyfT7gY1CLj3sKkuBY7UTLaVxpUVt+6S8eiEV
 07ovPPpyTmMtwsYQZ7kCHuwHejwdVPA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1742935619;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AU3g4DfWCz6edGSp9917+tS9RMjvSiTrf50uLl+U/r0=;
 b=ow+NqmT+sG6Wp3lwr0v7CJrHjWJuvXec1+Y4JM4WFqfiYnKWpX0bHXOC1M4Iq/UmuWPz+G
 Hhn1GulF/oHx61Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4239C137AC;
 Tue, 25 Mar 2025 20:46:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NYByDkMW42cQFgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 25 Mar 2025 20:46:59 +0000
Date: Tue, 25 Mar 2025 21:46:53 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jan Kara <jack@suse.cz>
Message-ID: <20250325204653.GA501592@pevik>
References: <20250319192742.999506-1-amir73il@gmail.com>
 <20250319192742.999506-2-amir73il@gmail.com>
 <xogk7anduhuifpdgrnjilfojrdtoupltfoy24fxoknjceeluac@emwvchf4gn4z>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <xogk7anduhuifpdgrnjilfojrdtoupltfoy24fxoknjceeluac@emwvchf4gn4z>
X-Rspamd-Queue-Id: 7BC431F397
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,suse.cz,lists.linux.it];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,suse.cz:email];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] fanotify24: remove redundant event_count field
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

Hi Amir, Jan,

> On Wed 19-03-25 20:27:40, Amir Goldstein wrote:
> > treat the event-set as a null terminated array.

> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>

> Looks good. Feel free to add:

> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks Jan, merged this one.

Amir, because Jan plans to have look on the remaining two, I'll wait for him.

Kind regards,
Petr

> 								Honza

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
