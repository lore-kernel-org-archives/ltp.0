Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA63C4167B
	for <ltp@archiver.kernel.org>; Thu,  7 Dec 2023 12:45:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B273B3CBBDF
	for <ltp@archiver.kernel.org>; Thu,  7 Dec 2023 13:45:10 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE48C3CBB62
 for <ltp@lists.linux.it>; Thu,  7 Dec 2023 13:45:00 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B6E1560070A
 for <ltp@lists.linux.it>; Thu,  7 Dec 2023 13:44:59 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B6F7F1FB4E;
 Thu,  7 Dec 2023 12:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1701953098; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HPR8vPRt59in08ytEZoKgz4nz9Ar+P+jfMZfJrjhj7M=;
 b=yLzHNWxhEKtOKB1EuteSNB5UQUPKZtI7kYfhZ3sl+N/nwwH7UkHh8zJ10AiByFqOcWIBS6
 Utx9fUFgwYALFKXzuoJwFZKJWCWT/0YQdP4CGq62VMb30hK+Cf2n1dBdnv1UqojENMeMoq
 aPr4PihZxlcQ94wluc9iKYFGn/jT93s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1701953098;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HPR8vPRt59in08ytEZoKgz4nz9Ar+P+jfMZfJrjhj7M=;
 b=Qrqo9hCkC4GyXq3tLgBsfgsrUwfp2r/+bjM7idDNTOP+gyctFoR4cyn4MvHymM+22IGZUa
 Ku7ydnxhu64xQtDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C3BB13976;
 Thu,  7 Dec 2023 12:44:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SHASEkq+cWWlEAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 07 Dec 2023 12:44:58 +0000
Date: Thu, 7 Dec 2023 13:44:47 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ZXG-P2wOLjrt24Ie@rei>
References: <20231207111223.234170-1-pvorel@suse.cz>
 <20231207111844.GA234785@pevik> <ZXGrB76MCu0-0K0y@yuki>
 <aecb0e4c-9042-463d-9888-7f4508e277fb@suse.com>
 <ZXG5x8R56fISvCLW@rei>
 <164f3362-ef24-4bc8-a27e-56d28ecdb60e@suse.com>
 <ZXG7d_ImcsTa_a0_@rei>
 <72e80847-aa5d-4180-8f55-fa2fd06aeec7@suse.com>
 <ZXG9EcGc60JGVnD3@rei>
 <6bee08e7-e57f-4d0f-b1a7-3c5441454d9f@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6bee08e7-e57f-4d0f-b1a7-3c5441454d9f@suse.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-1.97 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-1.17)[88.93%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] fsx-linux: Reduce log output
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > The difference is that TERRNO is applicable to all other types such as
> > TPASS, TFAIL, TBROK, TWARN. This does not make sense for TVERB, you
> > probably do not want to hide passed messages and you certainly do not
> > want to hide falures, bereakages and warnings...
> >
> I was thinking more about TWARN and TINFO.

I'm not sure that we would want to add lesser warnings, i.e. TWARN |
TVERB. We use TWARN mostly in cases where cleanup failed in test
cleanup() and possibly the OS is in an inconsistent state. Also TWARN is
used in places where we would have used TBROK but the test is somehow
able to continue at least partially. I do not think that I have a use
for TWARN | TVERB.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
