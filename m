Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 249FCCD6E4A
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 09:05:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC64E3E30BF
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 11:05:12 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 508833D0861
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 11:04:54 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C00A0100203B
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 11:04:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0E7876BD15;
 Tue,  2 Jun 2026 09:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780391093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SxMoYJleNLkMld/eaDv5WrQM+0LrVAQxCO2JQZIZoTM=;
 b=CfWixVEPb5YDFMZ25diLlcYDTSxOpVa7FxhynSQ7ijOFrkj/iXKMH3ViRAz/lK8Yrg2Rto
 VBh6U0Q+KP4NXBIg4jLrA4VYa03kTlu9YFfr5t3+MbZtqRzivlsp+xytwOw13kJVwzkeRO
 WvaY6K3wj5k1eWzMgjaoKzXPiPUAWoo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780391093;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SxMoYJleNLkMld/eaDv5WrQM+0LrVAQxCO2JQZIZoTM=;
 b=AQJGZMv9CIjqVlWjeiJ4aCOo1G6UPWhPuiM1xS2IXMoKe335J/jPlOD72f15lOYWa58XvK
 9CTTCG7JvUgKmKBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780391093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SxMoYJleNLkMld/eaDv5WrQM+0LrVAQxCO2JQZIZoTM=;
 b=CfWixVEPb5YDFMZ25diLlcYDTSxOpVa7FxhynSQ7ijOFrkj/iXKMH3ViRAz/lK8Yrg2Rto
 VBh6U0Q+KP4NXBIg4jLrA4VYa03kTlu9YFfr5t3+MbZtqRzivlsp+xytwOw13kJVwzkeRO
 WvaY6K3wj5k1eWzMgjaoKzXPiPUAWoo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780391093;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SxMoYJleNLkMld/eaDv5WrQM+0LrVAQxCO2JQZIZoTM=;
 b=AQJGZMv9CIjqVlWjeiJ4aCOo1G6UPWhPuiM1xS2IXMoKe335J/jPlOD72f15lOYWa58XvK
 9CTTCG7JvUgKmKBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E661B779A7;
 Tue,  2 Jun 2026 09:04:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rWyINrScHmqrNQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 02 Jun 2026 09:04:52 +0000
Date: Tue, 2 Jun 2026 11:04:48 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ah6csOP7O9R0L2hO@yuki.lan>
References: <20260601-doc_update-v1-0-b0f59834fbae@suse.com>
 <20260601-doc_update-v1-3-b0f59834fbae@suse.com>
 <20260601140901.GD3391768@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260601140901.GD3391768@pevik>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/4] include: Fix kernel-doc warnings in header
 comments
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > Downgrade kernel-doc comments to plain comments for struct tst_cmd
> > and TST_CAP() macro to avoid name collisions with the tst_cmd()
> > function and struct tst_cap respectively. The kernel-doc parser
> > flattens names case-insensitively, causing 'name used several times'
> > errors and duplicate target warnings.
> 
> Hm ...
> 
> ...
> > +++ b/include/tst_capability.h
> > @@ -67,7 +67,7 @@ struct tst_cap {
> >  	char *name;
> >  };
> 
> > -/**
> > +/*
> >   * TST_CAP() - Create a struct tst_cap entry.
> 
> This is the only warning I'd prefer to stay unfixed (i.e. it was kept in the
> docs). I wonder if we shouldn't jus rename struct or macro. Because TST_CAP()
> should be documented. Cyril @WDYT?

Looking at the resulting html pages both the structure and the function
is documented properly there. Also as long as we use c:func: and c:type:
in referencies everything should work. So I vote for ignoring this as
well.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
