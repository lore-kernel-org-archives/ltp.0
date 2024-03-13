Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4EFCC54791
	for <ltp@archiver.kernel.org>; Wed, 13 Mar 2024 21:03:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 768833D05EC
	for <ltp@archiver.kernel.org>; Wed, 13 Mar 2024 22:03:51 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 346603CB808
 for <ltp@lists.linux.it>; Wed, 13 Mar 2024 22:03:36 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6F765100079C
 for <ltp@lists.linux.it>; Wed, 13 Mar 2024 22:03:36 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 238B61F7F0;
 Wed, 13 Mar 2024 21:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710363814;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pHN0HCNkq+EWGjX6KPOiRBdchwdZct+JEdLYvyX5hyo=;
 b=wWNVp2wjTELYKuDnxjnGV1rXFP7a3kFNyn1YPTyHiuCHp5m7otqVh2weBs7TgUkGjl4IY4
 WOOYNcYdzC/UqU65Iizm1zlUlXI9YfUhN9DD4SVbfqJU338lG7T4MXOzg6tqs5n0vQQ2wB
 mpMoAl6TTKYsFxf0FtWpsJQ8CPvp/eI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710363814;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pHN0HCNkq+EWGjX6KPOiRBdchwdZct+JEdLYvyX5hyo=;
 b=BeRRjKTTi4mGXDXjHFlQhzKGd9WsEeHRvhGfvDhfsDPozuT4Sh5Yi6IhEtjTxjB9ZBqh9l
 KiMblDp2VbLpxwCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710363814;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pHN0HCNkq+EWGjX6KPOiRBdchwdZct+JEdLYvyX5hyo=;
 b=wWNVp2wjTELYKuDnxjnGV1rXFP7a3kFNyn1YPTyHiuCHp5m7otqVh2weBs7TgUkGjl4IY4
 WOOYNcYdzC/UqU65Iizm1zlUlXI9YfUhN9DD4SVbfqJU338lG7T4MXOzg6tqs5n0vQQ2wB
 mpMoAl6TTKYsFxf0FtWpsJQ8CPvp/eI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710363814;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pHN0HCNkq+EWGjX6KPOiRBdchwdZct+JEdLYvyX5hyo=;
 b=BeRRjKTTi4mGXDXjHFlQhzKGd9WsEeHRvhGfvDhfsDPozuT4Sh5Yi6IhEtjTxjB9ZBqh9l
 KiMblDp2VbLpxwCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 011C2139B3;
 Wed, 13 Mar 2024 21:03:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FCIhOqUU8mXmXgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 13 Mar 2024 21:03:33 +0000
Date: Wed, 13 Mar 2024 22:03:32 +0100
From: Petr Vorel <pvorel@suse.cz>
To: lufei <lufei@uniontech.com>
Message-ID: <20240313210332.GA605403@pevik>
References: <20240305020247.1727828-1-lufei@uniontech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240305020247.1727828-1-lufei@uniontech.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.50 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[30.66%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Rewrite logrotate case with using `tst_test.sh`
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

> 1. Rewrite case with using `tst_test.sh`
> 2. Enable steps in test#2 in old case (`test02` not called in old
>    code).

Thanks a lot, merged with some style cleanup + follow up simplification.

NOTE: I realized for running less than 1 min we would have to define more rows +
sleep, e.g. for each 10 sec:

("* * * * * $(command -v logrotate) $(pwd)/tst_largelog.conf")
("* * * * * (sleep 10; $(command -v logrotate) $(pwd)/tst_largelog.conf)")
("* * * * * (sleep 20; $(command -v logrotate) $(pwd)/tst_largelog.conf)")
("* * * * * (sleep 30; $(command -v logrotate) $(pwd)/tst_largelog.conf)")
("* * * * * (sleep 40; $(command -v logrotate) $(pwd)/tst_largelog.conf)")
("* * * * * (sleep 50; $(command -v logrotate) $(pwd)/tst_largelog.conf)")

But I guess first min would still be waiting, thus not implementing it.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
