Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA78D5B172
	for <ltp@archiver.kernel.org>; Mon, 15 Dec 2025 14:31:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6392D3D008F
	for <ltp@archiver.kernel.org>; Mon, 15 Dec 2025 15:31:29 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A0E503C1817
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 15:31:11 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1DDC320090F
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 15:31:06 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8DBBA5BD29;
 Mon, 15 Dec 2025 14:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765809065;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vYfjJHzWB+siA9kZp+31eUkGtJ1UFJuuvsxD6u5zdlU=;
 b=gx8nLMybiuLeViU15Z0A45d0YIQsVT5ZpUMnx8lOrcMz7ZuxTzkaasHGs3IOe5kf5mWq0N
 YbKXroG3nKF/aen9d0fM4dDCOHFXp/vIy1zPGz5LKs2gCZR92fQeeGI6YDHdmDmzObMdoD
 IOTS9InrJ54K7K4ddOHhYwWdXKctZgk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765809065;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vYfjJHzWB+siA9kZp+31eUkGtJ1UFJuuvsxD6u5zdlU=;
 b=xvbfUUFVF9eShr5N9Vo+sigivhIahcEKG4vYY8O7sXWN9A9ZfJ7tzRJvXgLylN9h7RfH8P
 f2S3Hz+eo4l8N0Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765809065;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vYfjJHzWB+siA9kZp+31eUkGtJ1UFJuuvsxD6u5zdlU=;
 b=gx8nLMybiuLeViU15Z0A45d0YIQsVT5ZpUMnx8lOrcMz7ZuxTzkaasHGs3IOe5kf5mWq0N
 YbKXroG3nKF/aen9d0fM4dDCOHFXp/vIy1zPGz5LKs2gCZR92fQeeGI6YDHdmDmzObMdoD
 IOTS9InrJ54K7K4ddOHhYwWdXKctZgk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765809065;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vYfjJHzWB+siA9kZp+31eUkGtJ1UFJuuvsxD6u5zdlU=;
 b=xvbfUUFVF9eShr5N9Vo+sigivhIahcEKG4vYY8O7sXWN9A9ZfJ7tzRJvXgLylN9h7RfH8P
 f2S3Hz+eo4l8N0Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E1F23EA63;
 Mon, 15 Dec 2025 14:31:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zarkE6kbQGlBIwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 15 Dec 2025 14:31:05 +0000
Date: Mon, 15 Dec 2025 15:30:48 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20251215143048.GA267467@pevik>
References: <20251215124404.16395-1-chrubis@suse.cz>
 <20251215124404.16395-2-chrubis@suse.cz>
 <CAEemH2eDJf1OAF1q6WEegF4ZpSVjerYa2O7hp8hfd+7q=75gQQ@mail.gmail.com>
 <CAEemH2eoJ9v88TE63ScjZB2xw73_hgZF90BPDQq72_HX4OobLw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2eoJ9v88TE63ScjZB2xw73_hgZF90BPDQq72_HX4OobLw@mail.gmail.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] doc: Add ground rules page
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

> Another *important* rule concerns artificial intelligence. I've noticed
> some beginners submitting LTP patches directly generated by AI tools.
> This puts a significant burden on patch review, as AI can sometimes
> introduce a weird/unreliable perspective into the code.

> Be careful when using AI tools
+1 I like this title.

> ========================
> AI tools can be useful for executing, summarizing, or suggesting approaches,
> but they can also be confidently wrong and give an illusion of correctness.
> Treat AI output as untrusted: verify claims against the code, documentation,
> and actual behavior on a reproducer.

> Do not send AI-generated changes as raw patches. AI-generated diffs often
> contain
> irrelevant churn, incorrect assumptions, inconsistent style, or subtle
> bugs, which
> creates additional burden for maintainers to review and fix.

> Best practice is to write your own patches and have them reviewed by AI
> before
> submitting them, which helps add beneficial improvements to your work.

Hopefully the last paragraph will be understand how it is meant. Because we
really don't want to encourage people to send something generated by AI they
don't really understand at all. I'd consider not suggesting any AI.

I remember briefly reading kernel folks discussing their policy [1]:

> We cannot keep complaining about maintainer overload and, at the same
> time, encourage people to bombard us with even more of that stuff.

And another one I can't find any more talking that it's about the trust. If
somebody sends wrong patches generated by AI he risks patches will be simply
ignored.

Kind regards,
Petr

[1] https://lore.kernel.org/all/1bd04ce1-87c0-4e23-b155-84f7235f6072@redhat.com/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
