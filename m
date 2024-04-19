Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B6CC4345F
	for <ltp@archiver.kernel.org>; Fri, 19 Apr 2024 08:37:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 980C63CFD7E
	for <ltp@archiver.kernel.org>; Fri, 19 Apr 2024 10:37:22 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1DA543CFB9B
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 10:37:08 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7112460A782
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 10:37:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6441B5D487;
 Fri, 19 Apr 2024 08:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713515825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WWhDQgHU/WGCnJHaYNaQY+UVds1okdkEFMpblvUydQA=;
 b=X0X6tj1RM+mRiUPcbJeDM8mUr7ZeWU2ps9pXcipm15zqCT60DaoRLCz6YYZ4bP6ytF4Inu
 OiPgcIHXnOzUB7Um79xpzzWcezVcY4Z220ggSdP6HSIZCE2ez95Zv5IzllDEui+nofwpPX
 SlzTyalFoLSqKGc3oWqE9RMq/MoIlkc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713515825;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WWhDQgHU/WGCnJHaYNaQY+UVds1okdkEFMpblvUydQA=;
 b=k/ONHAqgFAMA8dvzmLEhGOsCqrwmYLqtFcU9fTYekwFPcSH8ntTzMNDnD5GXyLcHWgfZyf
 Kj8u0I8Ux0lV4hAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713515825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WWhDQgHU/WGCnJHaYNaQY+UVds1okdkEFMpblvUydQA=;
 b=X0X6tj1RM+mRiUPcbJeDM8mUr7ZeWU2ps9pXcipm15zqCT60DaoRLCz6YYZ4bP6ytF4Inu
 OiPgcIHXnOzUB7Um79xpzzWcezVcY4Z220ggSdP6HSIZCE2ez95Zv5IzllDEui+nofwpPX
 SlzTyalFoLSqKGc3oWqE9RMq/MoIlkc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713515825;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WWhDQgHU/WGCnJHaYNaQY+UVds1okdkEFMpblvUydQA=;
 b=k/ONHAqgFAMA8dvzmLEhGOsCqrwmYLqtFcU9fTYekwFPcSH8ntTzMNDnD5GXyLcHWgfZyf
 Kj8u0I8Ux0lV4hAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 553E113687;
 Fri, 19 Apr 2024 08:37:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ioeyEzEtImZPbAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 19 Apr 2024 08:37:05 +0000
Date: Fri, 19 Apr 2024 10:36:19 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Vlastimil Babka <vbabka@suse.com>
Message-ID: <ZiItA8Rm0hFzTSAd@yuki>
References: <20240418071422.10221-1-wegao@suse.com> <ZiFLikOzOFDwfR2d@yuki>
 <cef1a016-f47c-4785-adea-c9eb9cd88f4c@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cef1a016-f47c-4785-adea-c9eb9cd88f4c@suse.com>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] swapping01.c: Add sleeps in the loop that
 dirties the memory
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
> Yeah I proposed you can try to reduce the sleep time/frequency to basically
> to lowest value (with some margin) that resolves the issue reliably in your
> testing. That 10ms per MB was just a possible starting point.

The usuall practice we do in LTP is to measure the minimal value
required for the test to pass and then double that for the final value.
But even with that I suppose that the value should be less than 10s.

Wei can you please try to measure how long are the shortest sleeps we
need in order to make the test pass?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
