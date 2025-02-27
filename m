Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2364C021BE
	for <ltp@archiver.kernel.org>; Thu, 27 Feb 2025 09:28:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E4DA33C9DA2
	for <ltp@archiver.kernel.org>; Thu, 27 Feb 2025 10:28:16 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B09293C29CB
 for <ltp@lists.linux.it>; Thu, 27 Feb 2025 10:28:00 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CCF8B6296D8
 for <ltp@lists.linux.it>; Thu, 27 Feb 2025 10:27:59 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E03211F38F;
 Thu, 27 Feb 2025 09:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740648479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5V9l4Lwa+fu4bRqRbdbX29g28ShAjT2ZnJLIiIzqjgo=;
 b=lQZ4HuEbvpzO/LC3gC/pV/BCPtmIYiHivoSPNoL96x/MaAJVRpd/6V8Z5ewfveCqjdMeHO
 jH0uqG5VPCNmnSqr4UvYCnElgfNgMYbPahOut79jhburEsSWXpCatnGJ7qIiMBIjKYZ9Eo
 BSPZR3cHXbbqyfkHcUeVEU7cQqA3sQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740648479;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5V9l4Lwa+fu4bRqRbdbX29g28ShAjT2ZnJLIiIzqjgo=;
 b=WQK4hreVif/PGMB4etyDoA3PHbj5dL9ChaNi5/kBFdoLP11zlypVbFvmx5TsA3I1SRIgQB
 5nP5hWQ2tC8/uXDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740648478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5V9l4Lwa+fu4bRqRbdbX29g28ShAjT2ZnJLIiIzqjgo=;
 b=dmEBnyYh0o3XbqanOo52VLzt70Zs8gl8j7FgokFYk0mPv6y4Kqqaw4D2MQ4876MQWK2AeW
 WwolZ9JOu6QH5qos0dgM7hPyhUJvlk2VT3G3CbuPAaXmwvdhodMr7wdeyAVVOGvjtdIaQt
 KmiznTyriVOT0a6dxZEff7y6s6M1XyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740648478;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5V9l4Lwa+fu4bRqRbdbX29g28ShAjT2ZnJLIiIzqjgo=;
 b=Dw7ZERnJiSIfeaFhpZIDIZgN0iVEt7RDNR0zS9ON+R674tSva0YeevCvHIynohckmyjarP
 VVmNnVvq5HpA8JCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB0EA13888;
 Thu, 27 Feb 2025 09:27:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jGqbMB4wwGfdEwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 27 Feb 2025 09:27:58 +0000
Date: Thu, 27 Feb 2025 10:28:07 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Ricardo =?iso-8859-1?Q?B=2E_Marli=E8re?= <ricardo@marliere.net>
Message-ID: <Z8AwJ2Aobzm2FVVw@yuki.lan>
References: <20250224-conversions-pause-v3-0-5e3989d37f1d@suse.com>
 <20250224-conversions-pause-v3-3-5e3989d37f1d@suse.com>
 <D80X6ZHMZ1SX.1KAXYMYMDCHKO@suse.com> <Z788OcCPwPz17CDM@yuki.lan>
 <D82IOHFBAC1P.1DMBD7WPNMXUW@suse.com> <Z79CtMlApmlZxcav@yuki.lan>
 <D82IYV81YNX5.2CLR90X81HYPS@marliere.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <D82IYV81YNX5.2CLR90X81HYPS@marliere.net>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/5] syscalls/pause02: Delete duplicated test
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
Cc: Linux Test Project <ltp@lists.linux.it>,
 Ricardo =?iso-8859-1?Q?B=2E_Marli=E8re?= <rbm@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> BTW, there's one final modification needed, below.

I did the change locally, but failed to --amend properly, that's what I
get for applying patches at the end of the day... I will push a fix.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
