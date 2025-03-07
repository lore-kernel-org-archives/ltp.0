Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD982C19F32
	for <ltp@archiver.kernel.org>; Fri,  7 Mar 2025 09:32:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A0AFA3CA128
	for <ltp@archiver.kernel.org>; Fri,  7 Mar 2025 10:32:51 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F9DF3CA11A
 for <ltp@lists.linux.it>; Fri,  7 Mar 2025 10:32:35 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4A0EE600391
 for <ltp@lists.linux.it>; Fri,  7 Mar 2025 10:32:34 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 74EB31F38E;
 Fri,  7 Mar 2025 09:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741339952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z7PeVMJqNZy0EB/iRFrDTAXUjVvT8/TPl3ktzYi3T/c=;
 b=EpPkW3SiQVfrZTfS4KRLiyitMhlwdf7jgEu1kGFMDyQqXpVFqea94j4MuuHUPqiSVI/vHX
 cjvHIGJpmUEg/uAo7PtslA1C4/dL44V++Rb70WvWBR5+h6xzLKH6AaaUqKy7f3TbB4A/VF
 FBtIy45+OL16l/DkcAdMswFhVyAZU+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741339952;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z7PeVMJqNZy0EB/iRFrDTAXUjVvT8/TPl3ktzYi3T/c=;
 b=YcGFzax9HQUtcsSosEmIRI55T8LFm/zEeAxagPe8BGIgoEeKh3/J+5YKGUKWy57x7RGWsk
 xN+rZWq19GH/vUAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741339952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z7PeVMJqNZy0EB/iRFrDTAXUjVvT8/TPl3ktzYi3T/c=;
 b=EpPkW3SiQVfrZTfS4KRLiyitMhlwdf7jgEu1kGFMDyQqXpVFqea94j4MuuHUPqiSVI/vHX
 cjvHIGJpmUEg/uAo7PtslA1C4/dL44V++Rb70WvWBR5+h6xzLKH6AaaUqKy7f3TbB4A/VF
 FBtIy45+OL16l/DkcAdMswFhVyAZU+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741339952;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z7PeVMJqNZy0EB/iRFrDTAXUjVvT8/TPl3ktzYi3T/c=;
 b=YcGFzax9HQUtcsSosEmIRI55T8LFm/zEeAxagPe8BGIgoEeKh3/J+5YKGUKWy57x7RGWsk
 xN+rZWq19GH/vUAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6467613A22;
 Fri,  7 Mar 2025 09:32:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UgOPFzC9ymdVSAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 07 Mar 2025 09:32:32 +0000
Date: Fri, 7 Mar 2025 10:32:48 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z8q9QFilTbSc7QAw@yuki.lan>
References: <67cabd64-fb43-4d1a-a471-995fd51a0e2b@suse.com>
 <20250307092606.GA263657@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250307092606.GA263657@pevik>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_SEVEN(0.00)[8]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Meetings schedule
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
Cc: Xiao Yang <yangx.jy@fujitsu.com>, "Ricardo B. Marliere" <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > - Monthly meetings
> > - Meetings every two months
> > - Meetings after each release
> 
> I guess once a month is OK. Or, if it's too much to somebody once every 2
> months. I'm not sure if it should be aimed before the release or after the
> release.

Agree here, monthly is fine.

> > I suggest we aim to hold our meetings during the first week of the month. If
> > a meeting cannot be held due to public holidays, we can consider
> > rescheduling it for the following week.
> 
> LGTM. Which day? I would prefer not Friday.
> 
> Also, I would prefer it not clash with OATS monthly call: which is  *second*
> Thursday in month, 14:00 UTC (15h CET).

I guess that we will keep the meetings in the CET/CEST morning as we
did, which is more timezone friendly with Asia.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
