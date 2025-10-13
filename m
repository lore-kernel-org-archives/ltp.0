Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30AB1CCD183
	for <ltp@archiver.kernel.org>; Mon, 13 Oct 2025 13:53:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD5A33CEBCC
	for <ltp@archiver.kernel.org>; Mon, 13 Oct 2025 15:53:36 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E7C4A3CEB97
 for <ltp@lists.linux.it>; Mon, 13 Oct 2025 15:53:20 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7ECBB1000464
 for <ltp@lists.linux.it>; Mon, 13 Oct 2025 15:53:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 49C07219C6;
 Mon, 13 Oct 2025 13:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760363599;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A2hCmj5iFg0IYDLxsfd38U1/85+fQHEj+Ruy/eq3pmI=;
 b=m1MS6itLUSdllQNuiF/nh0LV2P3ZH8KcwMYVeyHYozRxARKGkmSMkVqcBBlDOxn9HyB1Ul
 Ypg5DCMZCF56oW1KnDYkRRPexJKaYFg5JCFSp/N6aMwGbyFlUh06/y4OMTZf6DRzg67q73
 ev8GtHMrH1d4yS91CHpu30YGDBQoAPA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760363599;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A2hCmj5iFg0IYDLxsfd38U1/85+fQHEj+Ruy/eq3pmI=;
 b=nu1Hd2zI2bhKOHePlfutkfQUCiNf0Xz7h3HnMwSq/3PkGyNuZXCknqIB+TZlO3nW66gf/z
 u5DFp4dq+h0NK1Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760363599;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A2hCmj5iFg0IYDLxsfd38U1/85+fQHEj+Ruy/eq3pmI=;
 b=m1MS6itLUSdllQNuiF/nh0LV2P3ZH8KcwMYVeyHYozRxARKGkmSMkVqcBBlDOxn9HyB1Ul
 Ypg5DCMZCF56oW1KnDYkRRPexJKaYFg5JCFSp/N6aMwGbyFlUh06/y4OMTZf6DRzg67q73
 ev8GtHMrH1d4yS91CHpu30YGDBQoAPA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760363599;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A2hCmj5iFg0IYDLxsfd38U1/85+fQHEj+Ruy/eq3pmI=;
 b=nu1Hd2zI2bhKOHePlfutkfQUCiNf0Xz7h3HnMwSq/3PkGyNuZXCknqIB+TZlO3nW66gf/z
 u5DFp4dq+h0NK1Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0C7513874;
 Mon, 13 Oct 2025 13:53:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id waKpOU4E7WjwdAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 13 Oct 2025 13:53:18 +0000
Date: Mon, 13 Oct 2025 15:53:17 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20251013135317.GA97127@pevik>
References: <20251013-remove_todo-v2-1-d0a46ad14e34@suse.com>
 <DDH8HIERQ0BT.1Y67BJEQ4THGD@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DDH8HIERQ0BT.1Y67BJEQ4THGD@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Remove TODO
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

> Hi,

> I'm thinking that maybe we can even generate the list of tests which are
> currently using the old API and show it. WDYT?

Even it's trivial I would be ok with git grep example and invest the energy into
finishing the transition of the docs to REST (at least the C API part would be
nice to finish). But up to you of course.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
