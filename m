Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62ACEC46CD2
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 16:54:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE7D73CF98B
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 17:54:06 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D329B3CF973
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 17:53:51 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F12E32002B2
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 17:53:50 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BCD961F848;
 Tue, 30 Jan 2024 16:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706633629;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fRtzwkxq1jHn07bmRjijr1rjMkDTBrl7qP72+e2ABrk=;
 b=EiT0i+uiANWePGfQUQfqqnPnR1mS0hya3+TD/yRk40uBf1BlcNUL1JO3pru6Ze1HxdKmg4
 uQfrzPxKtxL4Y34yI7NmxKk4NvCq0ja0DivHneQPDrXt9AwcAnyCUMFCGP7SrY0xlYR0IM
 Ywdf45vOBDTDG/ZS8hDDsuDkTpUTYaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706633629;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fRtzwkxq1jHn07bmRjijr1rjMkDTBrl7qP72+e2ABrk=;
 b=7K+ndXzyHUzXuRbt/nJP0he0duVr6ej3t/xmqPivGwNKtNQVgQfJ8pCvw3hIZStJDBqR9v
 kVg/TyssHqRQGCCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706633629;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fRtzwkxq1jHn07bmRjijr1rjMkDTBrl7qP72+e2ABrk=;
 b=EiT0i+uiANWePGfQUQfqqnPnR1mS0hya3+TD/yRk40uBf1BlcNUL1JO3pru6Ze1HxdKmg4
 uQfrzPxKtxL4Y34yI7NmxKk4NvCq0ja0DivHneQPDrXt9AwcAnyCUMFCGP7SrY0xlYR0IM
 Ywdf45vOBDTDG/ZS8hDDsuDkTpUTYaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706633629;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fRtzwkxq1jHn07bmRjijr1rjMkDTBrl7qP72+e2ABrk=;
 b=7K+ndXzyHUzXuRbt/nJP0he0duVr6ej3t/xmqPivGwNKtNQVgQfJ8pCvw3hIZStJDBqR9v
 kVg/TyssHqRQGCCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 92FC113212;
 Tue, 30 Jan 2024 16:53:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id IjKsIp0puWUUXgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 30 Jan 2024 16:53:49 +0000
Date: Tue, 30 Jan 2024 17:53:46 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240130165346.GA824958@pevik>
References: <20240117173006.31521-1-mdoucha@suse.cz>
 <20240117173006.31521-2-mdoucha@suse.cz>
 <20240130163042.GA791887@pevik>
 <d4211df8-9eef-48c0-9d76-0b69da0bef21@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d4211df8-9eef-48c0-9d76-0b69da0bef21@suse.cz>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.89 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; RCVD_COUNT_THREE(0.00)[3];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.59)[81.62%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] Add test for ASLRn't bug
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

Hi Martin,
...

> > If you don't mind, I'll join it before merge to a single line:

> Please do.

Good, merged.
Thank you!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
