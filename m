Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 250DFCDB46F
	for <ltp@archiver.kernel.org>; Mon, 22 Jun 2026 11:15:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9DB163E698E
	for <ltp@archiver.kernel.org>; Mon, 22 Jun 2026 13:15:39 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 990923E53A7
 for <ltp@lists.linux.it>; Mon, 22 Jun 2026 13:15:24 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 26D436003C1
 for <ltp@lists.linux.it>; Mon, 22 Jun 2026 13:15:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6866F7077E;
 Mon, 22 Jun 2026 11:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782126923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QUb++t4deqZ2oh1pi3EAr5TRrNDMvhC11aYNEIh10Hg=;
 b=GxGafOtI0BrSZ8fz5wyf4J0zfXqXSehyvQkIzK7K/n3mqbOuFyeSmslnaWxbvJZrWVFRH0
 oiBvczIDbg3STGPvqSCGKQY2Dy/VjoeQYVWAOAbCDvxvXO55ENqFrwMgjNBS0KOZ/o6fja
 74A6okMzFnop2NtyPnv+K24HtfuvhXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782126923;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QUb++t4deqZ2oh1pi3EAr5TRrNDMvhC11aYNEIh10Hg=;
 b=4uORR8ciVPMPqbog/YjKf57NbTEPzYnlHlrCzywz3h6meEzfWZA7Wbv1UpGFLkmc6xlED5
 eVltV+zgJ4/BuBAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782126923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QUb++t4deqZ2oh1pi3EAr5TRrNDMvhC11aYNEIh10Hg=;
 b=GxGafOtI0BrSZ8fz5wyf4J0zfXqXSehyvQkIzK7K/n3mqbOuFyeSmslnaWxbvJZrWVFRH0
 oiBvczIDbg3STGPvqSCGKQY2Dy/VjoeQYVWAOAbCDvxvXO55ENqFrwMgjNBS0KOZ/o6fja
 74A6okMzFnop2NtyPnv+K24HtfuvhXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782126923;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QUb++t4deqZ2oh1pi3EAr5TRrNDMvhC11aYNEIh10Hg=;
 b=4uORR8ciVPMPqbog/YjKf57NbTEPzYnlHlrCzywz3h6meEzfWZA7Wbv1UpGFLkmc6xlED5
 eVltV+zgJ4/BuBAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5829A779A8;
 Mon, 22 Jun 2026 11:15:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id o/kAFEsZOWoGIAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 22 Jun 2026 11:15:23 +0000
Date: Mon, 22 Jun 2026 13:15:26 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ajkZTtYM1TeYRSTf@yuki.lan>
References: <20260622-metadata_groups-v3-0-45651d685c3c@suse.com>
 <20260622-metadata_groups-v3-1-45651d685c3c@suse.com>
 <ajkHmVoetXBnSDD7@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ajkHmVoetXBnSDD7@yuki.lan>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] metadata: add tests grouping support
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
I'm looking at the metadata and we will need at least one follow up.

For tests that are under cve/ directory we add a 'cve' group now, but
tests that have cve tag but are in a different place we do not do so.

For consistency we should do:

* Filter out cve as we do with kernel in the group by path

* Possibly add cve group based on cve tag (I would call this optional as
  it kind of duplicates the cve tag)

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
