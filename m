Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC4BC021AA
	for <ltp@archiver.kernel.org>; Tue, 18 Feb 2025 12:29:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 933403C9C7E
	for <ltp@archiver.kernel.org>; Tue, 18 Feb 2025 13:29:06 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A27743C91B5
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 13:28:49 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ipv4:195.135.223.131/32) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E0BA1652595
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 13:28:48 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CEFE31F396;
 Tue, 18 Feb 2025 12:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739881726;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9tYncQ9Ug+pHSxz8LXAPkMJPdagc4Y3pgg425t33bGs=;
 b=U+rtR60A/iQocDlKJlqGhpoCAQiTYN093KOWuJt6/iKiyzGA45fTQydvNvm6wjiRDHpVHC
 SW63wzEtiuDtggB7QKXGPS6rw1Xq8TbbeJHV8gLuvFq+4GfFwndALIGj7gh1aeUtaacBjy
 /QUeyblne04brvfYz77SBp/Zw4Yna7Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739881726;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9tYncQ9Ug+pHSxz8LXAPkMJPdagc4Y3pgg425t33bGs=;
 b=OkxR3FD0sV7+y2pQC12vIAflcOFM9V/OKW4VrFsBlCRMKzZbu41pntrm31GMZS3QSob0AF
 99+dQpFKwGAwApAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wvWpwal2;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="sqZe/d9i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739881725;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9tYncQ9Ug+pHSxz8LXAPkMJPdagc4Y3pgg425t33bGs=;
 b=wvWpwal2rumNKS+vFmUNgDRO6sHHgfiRfqbSvyebct5JyOsQookuCdIC00krF4GyqnFg4i
 v+GoNHj1k8Ic6WP2CH/LvHbfYWGh2flo7NpbDlWOi9JFmrsKLKod1yoZJiHr00qkAMdugY
 xQc9cMhR9J5fc8GVkJ8ondPjMcMrIRU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739881725;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9tYncQ9Ug+pHSxz8LXAPkMJPdagc4Y3pgg425t33bGs=;
 b=sqZe/d9iJuhNkkZ09QULPeSAmOAwMEuZ4QACorMhOJBhKIEiuq0oOPl+Vz6vCtYGyv8T3n
 tgfEjIDhiCQonDCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 986D3132C7;
 Tue, 18 Feb 2025 12:28:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hIhZI/18tGe1NgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 18 Feb 2025 12:28:45 +0000
Date: Tue, 18 Feb 2025 13:28:44 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20250218122844.GA2473190@pevik>
References: <20250207105551.1736356-1-pvorel@suse.cz>
 <6ecf5daa-95e3-43b9-9d04-fd7d2b2a0778@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6ecf5daa-95e3-43b9-9d04-fd7d2b2a0778@suse.com>
X-Rspamd-Queue-Id: CEFE31F396
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto,suse.cz:dkim];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[3];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/6] Remove asciidoc{,tor} doc
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

Hi Andrea, all,

> Hi Petr,

> On 2/7/25 11:55, Petr Vorel wrote:
> > Hi,

> > This is a follow up for Andrea's 1bf344a3db ("doc: add tests catalog page").

> > Besides these changes I plan:

> > 1) Configure readthedocs to generate html/pdf doc for user to be able to
> > download it.
> +1

Done already.

> > 2) Generate html/pdf documentation as a part of the release process
> > (build it locally with sphinx), to be able to add it to the release
> > as we did with the doc generated by asciidoc{,tor}.
> This is a bit tricky. Did you try already?

No. Not a big priority, but I'd like to do it before the release so that we can
upload generated archive again.

> > 3) Andrea refused to do have virtualenv support in Makefile.
> > https://lore.kernel.org/ltp/3032b376-8f7a-4b1c-8422-f5a61e59b680@suse.com/
> > I would still prefer to have it, as optional, when some variable is
> > passed to make. It's better than copy paste the commands all the time,
> > also it would help 2).

> Yeah, we can have sphinx + dependences packages installed in the system, via
> pip or using a Dockerfile. virtualenv is just an optional tool we don't want
> to be dependent from.

FYI implemented here (let's keep the discussion there)
https://patchwork.ozlabs.org/project/ltp/patch/20250211233552.1990618-1-pvorel@suse.cz/

...
> >   delete mode 100755 docparse/testinfo.pl
> >   delete mode 100644 m4/ax_prog_perl_modules.m4
> >   delete mode 100644 m4/ltp-docparse.m4
> >   rename {docparse => metadata}/README.md (100%)

> The rest looks good. Feel free to push it:

> Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

Thanks! FYI merged.

Kind regards,
Petr

> Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
