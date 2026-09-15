Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C9FC88E75
	for <ltp@archiver.kernel.org>; Tue, 15 Sep 2026 12:43:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1EC4D3E8CB2
	for <ltp@archiver.kernel.org>; Tue, 15 Sep 2026 14:43:07 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 38A103E20C0
 for <ltp@lists.linux.it>; Tue, 15 Sep 2026 14:42:52 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D39241000610
 for <ltp@lists.linux.it>; Tue, 15 Sep 2026 14:42:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 457FA1FD70;
 Tue, 15 Sep 2026 12:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789476171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=paIGy37lbv50O6XQFGJohNM5R5PoX/7fIjJzLWCkfiU=;
 b=hNjCyQd7nFKKqZboRxUQ2YpB1fUNgziu6pvMhnD86dVjmG6lW5aS/xXEy5vMDsuU0MWQ9A
 HLgC5RaPuBg0b2IqL5akGE2gk0+mHnYZEkf0HGLJjWXVRbtBDadRmjzKjJdwjnnGwkrzWj
 JgCACGOlM+pFDMFRckBu3X68NvcYb5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789476171;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=paIGy37lbv50O6XQFGJohNM5R5PoX/7fIjJzLWCkfiU=;
 b=dpjYhmqY/1ITKgLjzLypKLWbeTBLfS/b+1HlBLguygJ9btd0UnrslyPQJs6PZJ/hrNqwIA
 TOz+4t/b24T5tsBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789476171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=paIGy37lbv50O6XQFGJohNM5R5PoX/7fIjJzLWCkfiU=;
 b=hNjCyQd7nFKKqZboRxUQ2YpB1fUNgziu6pvMhnD86dVjmG6lW5aS/xXEy5vMDsuU0MWQ9A
 HLgC5RaPuBg0b2IqL5akGE2gk0+mHnYZEkf0HGLJjWXVRbtBDadRmjzKjJdwjnnGwkrzWj
 JgCACGOlM+pFDMFRckBu3X68NvcYb5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789476171;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=paIGy37lbv50O6XQFGJohNM5R5PoX/7fIjJzLWCkfiU=;
 b=dpjYhmqY/1ITKgLjzLypKLWbeTBLfS/b+1HlBLguygJ9btd0UnrslyPQJs6PZJ/hrNqwIA
 TOz+4t/b24T5tsBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1061313432;
 Tue, 15 Sep 2026 12:42:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5uRDN0o9qWqLQAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 15 Sep 2026 12:42:51 +0000
Date: Tue, 15 Sep 2026 14:43:02 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aqk9ViBFQHAT691o@yuki.lan>
References: <aqkjv-oIgNgHYROA@yuki.lan>
 <20260915113733.47046-1-avinesh.kumar@suse.com>
 <20260915123641.GA1678037@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260915123641.GA1678037@pevik>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] uevents: introduce wait_for_uevents_unordered()
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
> LGTM, thanks!
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

Sorry, I've pushed the patch before this email arrived...

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
