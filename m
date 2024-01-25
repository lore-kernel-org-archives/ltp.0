Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB92DC47258
	for <ltp@archiver.kernel.org>; Thu, 25 Jan 2024 10:26:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4A3883CE1EF
	for <ltp@archiver.kernel.org>; Thu, 25 Jan 2024 11:26:10 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 894483C62AC
 for <ltp@lists.linux.it>; Thu, 25 Jan 2024 11:25:55 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 003DB600121
 for <ltp@lists.linux.it>; Thu, 25 Jan 2024 11:25:54 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EE8FC1F839;
 Thu, 25 Jan 2024 10:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706178354;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S2Dfju/1sonkZt+KjTtDxot92b/Q/saYhcQhWwrda0w=;
 b=fOS0bN0qKehnh8enZ9aP6q3ovmLkMD9yQ3xHzx6KoLsc37McBDlFQgq6Axx0wWLjeOlS5s
 WKQS53hETI/XAlDbclmn95riyvSQ2C6+g5nXVAlE6qNzSLfludTQXAj2RFXzjy4LDomaCh
 EkWyJWFlZ1Oon4FhxmDRCbmiWxMztUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706178354;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S2Dfju/1sonkZt+KjTtDxot92b/Q/saYhcQhWwrda0w=;
 b=j7KmCnxYm9KHqs9XLeSbsHgyNnRY3J8manRon9J+O3ETYd8jec2YWPU5z2zxfLcruwIXC5
 lxq4eJpv4OY9J7AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706178353;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S2Dfju/1sonkZt+KjTtDxot92b/Q/saYhcQhWwrda0w=;
 b=sXk8BWbWgqGxQmkkSxLbvTzaFRBigAloapOEKt4nhWKTFl4/XR+y7YweXqI9pWlAzOvLnk
 lxbe/W9aVDq/Gxcy+OeAA7Y89LRccGag/5Y8kI6aaSwjxAbjnJlGwydBGts+1SPuD9SHQa
 puIwnYKaih6ES9mdUTw/QuXuINzKBBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706178353;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S2Dfju/1sonkZt+KjTtDxot92b/Q/saYhcQhWwrda0w=;
 b=nqJXHGM1Hzix7DTgKz+N6VAYqgrel/NxN06J7WCcDa8K+jl8Ce+ocqBYJiTKMihULWXXdD
 NgWBwr3IaKthivDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C90CC134C3;
 Thu, 25 Jan 2024 10:25:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id erGwLzE3smU9ZQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 25 Jan 2024 10:25:53 +0000
Date: Thu, 25 Jan 2024 11:25:52 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240125102552.GA389091@pevik>
References: <20240125100009.387096-1-pvorel@suse.cz>
 <ZbIyh-kyBMTE5OA5@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZbIyh-kyBMTE5OA5@yuki>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.35 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 RCVD_COUNT_THREE(0.00)[3]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.05)[59.81%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] fs_fill: Increase timeout to 5 min
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

> Hi!
> Shouldn't this have fixes tag for:

> "fs_fill: Increase test loop device size to 1GB"

The timeout was during 300 MB, that's why I would not add it.
But I can be wrong.

I'm not sure if increasing to 1 GB makes test run slightly faster.
Maybe device size and runtime are related.

Kind regards,
Petr

> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Thanks!

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
