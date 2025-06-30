Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0659CC8302B
	for <ltp@archiver.kernel.org>; Mon, 30 Jun 2025 14:40:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 749853C5DF1
	for <ltp@archiver.kernel.org>; Mon, 30 Jun 2025 16:40:50 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B37F93C56F4
 for <ltp@lists.linux.it>; Mon, 30 Jun 2025 16:40:33 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F014F2001DE
 for <ltp@lists.linux.it>; Mon, 30 Jun 2025 16:40:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 53AF121163;
 Mon, 30 Jun 2025 14:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1751294431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+qafeY7N6ppFUSpztcU33ad/8/R3XUbYX59OTKAuVbU=;
 b=FrVyQJEfYJl6WKKfP/7rhIrGaHdycA00nvBbPIvBzHcDwJXt2rupYr0i5em0AqslrwX/z2
 NquGjSDvsArZ9A9T+j033RV7gMS7hBsQd4SxHL7xhDwfA0/bkQwYTH5QL/opqlWLTG4PSa
 W0z11sHHd9R32HSuBSbjIqfLV3Qh/as=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1751294431;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+qafeY7N6ppFUSpztcU33ad/8/R3XUbYX59OTKAuVbU=;
 b=B/+5E7NIzky0V9oTeOjUXymI4yTuMapmA1pyC0O98R71Wf46+8/n9KRyKHB0NzMZCOE1Kl
 5NWjdRG8P/zdzyDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1751294430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+qafeY7N6ppFUSpztcU33ad/8/R3XUbYX59OTKAuVbU=;
 b=hVHblXvQNeDKhyos7Pc7X358fgpOHjfpUrn60gr57SkJrSmBfotKkD3eD8c6CPqBkL5AMV
 X3TlErxNdRBf8LGzWuD6v/Wkz6geuYsPyruy88xBb92llUImWpt/Z/OC8/FjfUChuJo1xU
 h+Az8+A4EPYWRF2v8UCEjIWt1vIo7uU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1751294430;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+qafeY7N6ppFUSpztcU33ad/8/R3XUbYX59OTKAuVbU=;
 b=pbX+gpD62napT1kjfMXYUY1nzEr5VyjRZeKqcIPR4Tx4y60MB+cTzehzUxaMjeC/kGkrP6
 63bBzMCZpIEfaEDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 42F441399F;
 Mon, 30 Jun 2025 14:40:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TfTRDt6hYmh3dAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 30 Jun 2025 14:40:30 +0000
Date: Mon, 30 Jun 2025 16:41:11 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <aGKiB73K8c3S4Tiu@yuki.lan>
References: <20250624-crash02_rewrite-v2-1-c4eaeee8598f@suse.com>
 <39406791-8bbd-4447-bbcd-0b25710a55e8@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <39406791-8bbd-4447-bbcd-0b25710a55e8@suse.cz>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.cz:email,
 yuki.lan:mid]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] misc: rewrite crash02 test
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
> > +	.forks_child = 1,
> > +	.runtime = 40,
> 
> Runtime should be calculated from num_tries. The default 1000 tries 
> probably don't need .runtime at all.

Or just loop until runtime is exhausted and set the runtime to a second
or two. And possibly print a TINFO message once 1000, 10000, 100000, ...
calls were done.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
