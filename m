Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2634C5CFDB
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 11:46:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4249C3E6C09
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 13:46:08 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 79EC43D9E8C
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 13:45:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B99B9140076E
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 13:45:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9679282872;
 Thu, 13 Aug 2026 11:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786621546;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1gIQ/gUk3YvaKgGxGIlsvYp41iyWLQiqWJAHIPW3hIY=;
 b=E6PZWahI0fywYp1VX7AFK/M0+OgTMaWYncgEVlUO4K45X7/8DF+bDIhz6MYiadK6QgciMv
 Jsn53icLFQ723up8OhOfZIPD6aX5DyJBgvPM++nqwzwovlM5gQ0gY+AWi323WZ3JdNUi4b
 thUBRTlj8ioRWyUc2UUN/1niumEv8I0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786621546;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1gIQ/gUk3YvaKgGxGIlsvYp41iyWLQiqWJAHIPW3hIY=;
 b=XYQnQi9/TBRpyZSM49DCe1vUsKbS7BIBRP0TYzQZRyrVk9j68hWxwOHnlEm/ZqflO7dmqf
 0WwVkb4yGrXGIWCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786621542;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1gIQ/gUk3YvaKgGxGIlsvYp41iyWLQiqWJAHIPW3hIY=;
 b=W41royVT8ZudDls1u6fMlIC80AakA7JQdbWj7It3T0HD8H0Bf4u5ZkcnD2hh0/MRnKdobL
 WWe3+VZUc+7m2o+fUvx7FsScdRrpAbaeWanyu+aJTmCMQdDTxrm1ts1E0ttYLgF6NKEIoi
 mEP0kWGEbkYrhEqIqs9eH2Xwt5XCSNA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786621542;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1gIQ/gUk3YvaKgGxGIlsvYp41iyWLQiqWJAHIPW3hIY=;
 b=T52momvuGgtlQmCQAa3/+dilPajf0BgLsSYo+xmsRmjrn/ID+f0rZaBBgf8wt0+uTlcXfA
 oGYN3DGRqR/Tq7DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70A8977DD4;
 Thu, 13 Aug 2026 11:45:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KCIhGmaufWqBKAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 13 Aug 2026 11:45:42 +0000
Date: Thu, 13 Aug 2026 13:45:41 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20260813114541.GD1843300@pevik>
References: <20260803-cve-ghostlock-v3-0-cde83fa429b7@suse.com>
 <20260803-cve-ghostlock-v3-2-cde83fa429b7@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260803-cve-ghostlock-v3-2-cde83fa429b7@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] cve: add CVE-2026-43499 reproducer
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

Hi Andrea,

OK, I rebased myself to speedup: branch andrea/ghostlock [1] in my fork
(with linux-tag longer hash as well).

LGTM, but I want to have a deeper look.

Kind regards,
Petr

[1] https://github.com/pevik/ltp/commits/refs/heads/andrea/ghostlock/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
