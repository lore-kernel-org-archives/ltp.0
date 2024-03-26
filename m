Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A69CD11DD
	for <ltp@archiver.kernel.org>; Tue, 26 Mar 2024 11:44:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6DF493CFB33
	for <ltp@archiver.kernel.org>; Tue, 26 Mar 2024 12:44:50 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C43F33CC514
 for <ltp@lists.linux.it>; Tue, 26 Mar 2024 12:44:35 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 50411201188
 for <ltp@lists.linux.it>; Tue, 26 Mar 2024 12:44:34 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 04E4C5D518;
 Tue, 26 Mar 2024 11:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711453474;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i9Wqc+hp6YGoXcTRFYqVmpbjvyjID8ff4PnBAeiJ/t8=;
 b=YKjFXQiQJIANSK+tVdTe7By3m4AnUIDiwinPmavSoJ8b82vu3u9kBZ7URU55NKpqp8StrT
 icW8zPgt8WWXI+qyOEds2gGUmtZXx1HmwqZPGBzxQ2CywFKRVj8ggRR75fC1jz3gjxtCbL
 qNpHXznPmukqHBh6189Sxpp85oqO6jM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711453474;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i9Wqc+hp6YGoXcTRFYqVmpbjvyjID8ff4PnBAeiJ/t8=;
 b=c7c/D34YslLlwP7pYWVUi5zG+tTsFNd1c1kRp012VZfQT11LQZAJP7YB7fkZTWQj5qSxue
 zoG8FCaiajAALlAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711453474;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i9Wqc+hp6YGoXcTRFYqVmpbjvyjID8ff4PnBAeiJ/t8=;
 b=YKjFXQiQJIANSK+tVdTe7By3m4AnUIDiwinPmavSoJ8b82vu3u9kBZ7URU55NKpqp8StrT
 icW8zPgt8WWXI+qyOEds2gGUmtZXx1HmwqZPGBzxQ2CywFKRVj8ggRR75fC1jz3gjxtCbL
 qNpHXznPmukqHBh6189Sxpp85oqO6jM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711453474;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i9Wqc+hp6YGoXcTRFYqVmpbjvyjID8ff4PnBAeiJ/t8=;
 b=c7c/D34YslLlwP7pYWVUi5zG+tTsFNd1c1kRp012VZfQT11LQZAJP7YB7fkZTWQj5qSxue
 zoG8FCaiajAALlAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9983D13587;
 Tue, 26 Mar 2024 11:44:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id ulSUICG1AmbnIQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 26 Mar 2024 11:44:33 +0000
Date: Tue, 26 Mar 2024 12:44:31 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240326114431.GC715328@pevik>
References: <20240320102204.475230-1-pvorel@suse.cz>
 <20240320102204.475230-2-pvorel@suse.cz> <ZgKiUH2_0o0diAH0@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZgKiUH2_0o0diAH0@yuki>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-5.67 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-1.17)[88.84%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/3] lib: Merge security related sources
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
Cc: Mete Durlu <meted@linux.ibm.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

FYI merged this independent cleanup.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
