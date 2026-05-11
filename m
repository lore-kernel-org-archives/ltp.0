Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078CBCD37B9
	for <ltp@archiver.kernel.org>; Mon, 11 May 2026 11:38:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B46D3CBE68
	for <ltp@archiver.kernel.org>; Mon, 11 May 2026 13:38:41 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 57E693CAF08
 for <ltp@lists.linux.it>; Mon, 11 May 2026 13:38:23 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D5E7620092E
 for <ltp@lists.linux.it>; Mon, 11 May 2026 13:38:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B37976AAAC;
 Mon, 11 May 2026 11:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778499496;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RKgp6MAsZUHsY0Rzd8VWqia/+9WzFUR+ZuRJc5IL1GM=;
 b=kG4bOdN8MdjvNHBL94E156lBJbIno83OiD90dzy6ZawrstM/jDIDoe/6MFEODzL66MX7ct
 39YNzK2nBspFqrl4yoM8ZTgaMHW9s6olqhZQKbRcfvbhmxgNr9GnR8cM7ZlqHxU4zQxsmu
 Q1XA0xnf4HI4NWp1M898aM7m651otJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778499496;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RKgp6MAsZUHsY0Rzd8VWqia/+9WzFUR+ZuRJc5IL1GM=;
 b=MQyE56/uIBQKI2tOUbuUWdaJcCxeSjpFxI/YVJl0keS8q8I3GvQKDDMi/QEAFAFfECNljA
 7VxfTYekQpR9G3CQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kG4bOdN8;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="MQyE56/u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778499496;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RKgp6MAsZUHsY0Rzd8VWqia/+9WzFUR+ZuRJc5IL1GM=;
 b=kG4bOdN8MdjvNHBL94E156lBJbIno83OiD90dzy6ZawrstM/jDIDoe/6MFEODzL66MX7ct
 39YNzK2nBspFqrl4yoM8ZTgaMHW9s6olqhZQKbRcfvbhmxgNr9GnR8cM7ZlqHxU4zQxsmu
 Q1XA0xnf4HI4NWp1M898aM7m651otJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778499496;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RKgp6MAsZUHsY0Rzd8VWqia/+9WzFUR+ZuRJc5IL1GM=;
 b=MQyE56/uIBQKI2tOUbuUWdaJcCxeSjpFxI/YVJl0keS8q8I3GvQKDDMi/QEAFAFfECNljA
 7VxfTYekQpR9G3CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99768593A3;
 Mon, 11 May 2026 11:38:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id THJaJKi/AWpSNAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 11 May 2026 11:38:16 +0000
Date: Mon, 11 May 2026 13:38:07 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Sachin Sant <sachinp@linux.ibm.com>
Message-ID: <20260511113807.GA6399@pevik>
References: <20260511070852.90379-1-pvorel@suse.cz>
 <dbf74dbf-b326-4c70-b12c-371a51cec232@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <dbf74dbf-b326-4c70-b12c-371a51cec232@linux.ibm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.31 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 URL_IN_SUBJECT(0.40)[www.cve.org];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[cve.org:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B37976AAAC
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc/cve_catalog: Link CVE to www.cve.org
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

> > Hi Sachin, Andrea,

> > thanks a lot for implementing the CVE list page. Very simple change to
> > it but I prefer not to modify the page without your ack.
> I am okay with this change. In-fact I had this change included in one of the
> intermediate versions of the CVE catalog patch.

Thanks! Feel free to add your Acked-by: or Reviewed-by: tag.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
