Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58352C4345F
	for <ltp@archiver.kernel.org>; Thu, 18 Apr 2024 11:32:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 759FC3CFBD6
	for <ltp@archiver.kernel.org>; Thu, 18 Apr 2024 13:32:25 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0DB5C3CF517
 for <ltp@lists.linux.it>; Thu, 18 Apr 2024 13:32:09 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D0C86100112D
 for <ltp@lists.linux.it>; Thu, 18 Apr 2024 13:32:08 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7D1DF34E32;
 Thu, 18 Apr 2024 11:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713439927;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=94JtpPqP2qxtmjaB2YTGVg6BGZ8g7P9teM+fp8Q5bVI=;
 b=PyV3WGALAWPNZ0NAOO/pIB+kQhJPJ8qN8uj73Kk0pN8yumjQdA0UWIetDRLBMnDph96kM1
 5h++/+Dfo/5nk8zwEY8Q7cLDfDPIg6yr99+EmZBq1hi1L6umTbrQEGjm9vqk2BAwJb/yyL
 yyiTl8LY/XA3LBtE9SOMQ4tmBK4WssY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713439927;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=94JtpPqP2qxtmjaB2YTGVg6BGZ8g7P9teM+fp8Q5bVI=;
 b=Vqu9H2m6HH9sbPo+1xp1FBtV8yfZvpJvO3oOS1QxAFjt+6YuFFjIAqEbX9P5csJrnJHK4O
 u/DRKw8fHEVV/pCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zUj5ZHlW;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6KteF+fj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713439926;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=94JtpPqP2qxtmjaB2YTGVg6BGZ8g7P9teM+fp8Q5bVI=;
 b=zUj5ZHlW2CJzQgh5yCNAKj6dXfj+0r8rOT4Vngco1iulI2OGjfghs0TqfNL8Nj24PSH5V/
 GIQJmIchnjfZHf4ckjgO7Q7RPJRlzwSjtnNNgeAX46v71pAp7EkVrcAzBivPakEkFNTN7w
 Z6EOUjAjettgXZgJvNIw1Is2rNPcgjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713439926;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=94JtpPqP2qxtmjaB2YTGVg6BGZ8g7P9teM+fp8Q5bVI=;
 b=6KteF+fjHMHS3+3yKKrzhqJtHp+tx3l9W+x5RH8zT5+Z0CqhljdH5FjEnDzfz6msrnNZRI
 KkIddWJcLWHjR9Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 281361384C;
 Thu, 18 Apr 2024 11:32:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Sqc4B7YEIWa4ZAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 18 Apr 2024 11:32:06 +0000
Date: Thu, 18 Apr 2024 13:32:04 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20240418113204.GA70047@pevik>
References: <b5872e1e-723f-4444-ae9c-39fd8b9d39fd@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b5872e1e-723f-4444-ae9c-39fd8b9d39fd@suse.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7D1DF34E32
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.17 / 50.00]; BAYES_HAM(-1.46)[91.40%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_EQ_ADDR_SOME(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_SEVEN(0.00)[10];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Open monthly meeting 8th of May 09:00 UTC
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea, all,

> Hello everyone,

> this is a friendly reminder for the LTP mailing list about monthly meeting.
> As previously discussed.

> Next meeting will be on the 8th of May 09:00 UTC.
> Platform: https://meet.google.com/jon-gytf-uei

8th May is a public holiday in the Czech Republic. I guess some of us will not
be available in the call (definitely not me). Could we postpone a week later?
(although it would work for me, there might be people taking 2 days of vacation
on following Thursday and Friday).

Also, I wonder if 9 UTC is not too late for those working from Asia. If yes,
please speak up what would be better time for you. I personally could start
earlier (8 UTC or even 7 UTC).

Kind regards,
Petr

> Thank you,
> Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
