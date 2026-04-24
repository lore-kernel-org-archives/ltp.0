Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F1A7FE5200
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 10:23:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 61C6A3E28CD
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 12:23:03 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E68E3E15D7
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 12:22:42 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 69C061000B76
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 12:22:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EA66E5BD7F;
 Fri, 24 Apr 2026 10:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777026160;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A+Qnhc1OxImYnuPhP1JZcdqsDs8Lw/qugC3jrPEHRjQ=;
 b=sBUyl5b6RrMy67BFik1w+N//Olb4QWI4Y1AeIgn7K0H9DIixWy22vHXJ5jYNlnVb1kK+xM
 p2XD1STAyYOxjT6irkDFVJGWDTMcHqZ4/A4ES9ic8FqYSPqMQgamqYLKANT6J8PjqG2HrX
 BaBxxqX7iZB3dH+Ogw2KrMnWMmE8yi0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777026160;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A+Qnhc1OxImYnuPhP1JZcdqsDs8Lw/qugC3jrPEHRjQ=;
 b=Ind8PLi06OqiB2KB4kodqqI7RoT9AfNqpaqjGTlp6AuH0wyWfW+YsCX1Q1vd9KWeTnlFGD
 /EqsfSuEb9X7j0AA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Z2WbzK3Z;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=dOGZxqXA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777026159;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A+Qnhc1OxImYnuPhP1JZcdqsDs8Lw/qugC3jrPEHRjQ=;
 b=Z2WbzK3Z8Q8b/NLFF+pzgUW4ARkb84nSEoT2qR6DLMjZ6nzofKnEHYJtTgOfMV/vXeAND4
 nbrNHh9WIu4mNZr+/SKqZ++dn/bk8mvrV++tOe+QApR7E+wWzw0NDi0we2vYNy8jUmomHe
 WlLQ+WptVeHRd8HSAC2kUhYiZnH80OM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777026159;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A+Qnhc1OxImYnuPhP1JZcdqsDs8Lw/qugC3jrPEHRjQ=;
 b=dOGZxqXAMAjW/uRwX5aoYhPfslDY8+YJKk5QZrOY4+WR8bq8yDUJ5K8tGSa78rGnXJp8AK
 q+S0H1vieygBnkAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3AC0593A4;
 Fri, 24 Apr 2026 10:22:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wt8UI29E62leeAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 24 Apr 2026 10:22:39 +0000
Date: Fri, 24 Apr 2026 12:22:38 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20260424102238.GC505126@pevik>
References: <20260406023538.14739-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260406023538.14739-1-wegao@suse.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: EA66E5BD7F
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] ioctl_pidfd06: Accept both ESRCH and EREMOTE
 for PIDFD_GET_INFO
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

Hi,

I have no idea what superseded this patch. But as Wai prefers it [1] I set state
new.  Alternative patch [2] [3], with discussion under v1 [4] [5].

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/20260424095900.GA500158@pevik/T/#m58cbc2ecf73d7448bcb466a4a84b6845f147c1b9
[2] https://patchwork.ozlabs.org/project/ltp/patch/20260424101508.505501-1-pvorel@suse.cz/
[3] https://lore.kernel.org/ltp/20260424101508.505501-1-pvorel@suse.cz/T/#u
[4] https://patchwork.ozlabs.org/project/ltp/patch/20260424060543.462475-1-pvorel@suse.cz/
[5] https://lore.kernel.org/ltp/20260424095900.GA500158@pevik/T/#m58cbc2ecf73d7448bcb466a4a84b6845f147c1b9

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
