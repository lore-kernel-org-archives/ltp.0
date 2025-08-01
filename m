Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE32C87FCA
	for <ltp@archiver.kernel.org>; Fri,  1 Aug 2025 14:05:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 995D03CCE0B
	for <ltp@archiver.kernel.org>; Fri,  1 Aug 2025 16:05:29 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EFC143CCD13
 for <ltp@lists.linux.it>; Fri,  1 Aug 2025 16:05:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3ED94600A6D
 for <ltp@lists.linux.it>; Fri,  1 Aug 2025 16:05:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 566411F38C;
 Fri,  1 Aug 2025 14:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754057107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wJDUesCus+GPXcYbA97y7IjRhJtWgezpx1LF8y8aB64=;
 b=A8HIKglRBJxmwMVmarRw+rzW9XiG25J92he03yhgcl/mKaT0WSjHi35cNYMtahdjcfTlpt
 TWgfPvsysb4oLyZjnUdw13fTHvIk8bxr1ExnfzuWI36pmLlbY5uCuw9V+8dxcbM8Hlcbt6
 fhAPqdO5yqUGl/d2cgtzhCUy12PArVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754057107;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wJDUesCus+GPXcYbA97y7IjRhJtWgezpx1LF8y8aB64=;
 b=LzybaHmsHcaLvuViHkCpBidNgYXgL9QI8T1wCZPSVsLJNyt57dV7ppV1ZvDMTM+XUI7Wvd
 My1wKTA+GxZEniBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754057106; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wJDUesCus+GPXcYbA97y7IjRhJtWgezpx1LF8y8aB64=;
 b=i1zSKYT7UPX7yrePHRvc9Wn+4cbIB2NWdfzcCYDOHAZFZgI/WXleBtrQihB9gyrzclwEh4
 nHGpvH1aQ4XjG09gUzGxsPPluMhWnO7uE5dYlRVwDact3y8+QKDQLJPnzr4pe2IOh8vj7I
 SAbkManVfGiA3S/5vuzhl0zGuMD+NjU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754057106;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wJDUesCus+GPXcYbA97y7IjRhJtWgezpx1LF8y8aB64=;
 b=JYWjji6ZXgmRUro7aBTXM3iRP2KwuL1IetdTo/Wfgt58AF69GQf7uXjxsnMAhDUak0JbK4
 ASTt8FFgHSWz7iBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 40ADF138A5;
 Fri,  1 Aug 2025 14:05:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id p9wJDpLJjGhQFQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 01 Aug 2025 14:05:06 +0000
Date: Fri, 1 Aug 2025 16:05:49 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aIzJvWzydhiNty87@yuki.lan>
References: <20250717-clock_nanosleep05-v4-0-78bc62df960f@suse.com>
 <20250717-clock_nanosleep05-v4-2-78bc62df960f@suse.com>
 <aIjUY9_MhWC3KMaN@yuki.lan>
 <b0a34ad9-9e59-4d46-b202-2eada747b791@suse.com>
 <aIy16j72Yke0W69n@yuki.lan>
 <33bb23db-b6f3-4566-918d-64400427a21e@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <33bb23db-b6f3-4566-918d-64400427a21e@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 URIBL_BLOCKED(0.00)[yuki.lan:mid,suse.cz:email];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/2] Add clock_settime04 test
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
> Ok feel free to push with Co-developed.

Done, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
