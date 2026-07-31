Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F726C5516D
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 12:44:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8CA243E7205
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 14:44:10 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F129B3E145D
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 14:43:55 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 33EEC1A00CC5
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 14:43:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 379D84109;
 Fri, 31 Jul 2026 12:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785501830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QbgpKLo1/T5stuzOhXuIb29IgpEMR6Q/dMGfjBlsjCQ=;
 b=rlIl/DMKw00nr8t9862akFcO+67892RMGTo+eQMWkYPfYskR0s84A8cQEl3KZwCUQ5eN1d
 axF7LnNPnwvUYCEzWrY3gb+QzBdi9NMUatyl34oCbFsfZPzSEK8m9/NgcZO7IfCbAAdN0M
 MyN91vLlVjuWApSFiu8oY+T+Q5SDF+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785501830;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QbgpKLo1/T5stuzOhXuIb29IgpEMR6Q/dMGfjBlsjCQ=;
 b=VSLMn66QkyIbv5eR6uTxvU2ylPFouzNtx1g2uLf0WhzjL3dV4ixvboETJjUnOfiDNvf4cf
 F6rsei/055XtXHCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785501826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QbgpKLo1/T5stuzOhXuIb29IgpEMR6Q/dMGfjBlsjCQ=;
 b=hJUEDf5cUTis1LeymSVYz1hYYvzLJmvWiQ3zAlW/DqxCSkZaa91iYN/FJXcR+ooakSwFrR
 aLm710w8ulAHfGzBJSQoS4HCoJrsXcQAqjGbDnp3SmN6hF9Xbiwr8OtEeUROivp7amjAEH
 votHuTUvsKGX4n3ox05r/fzJDN1lPBI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785501826;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QbgpKLo1/T5stuzOhXuIb29IgpEMR6Q/dMGfjBlsjCQ=;
 b=iiIMm6jo3TxKOcD61NZLbvzrHYMPxjGYyzaVwT5X2WYk8X+fgO4Ge36cr35cKM7Qp7+uG/
 PQznLLY/nJ3d/nAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2825E779B0;
 Fri, 31 Jul 2026 12:43:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gEi5CIKYbGpLFwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 31 Jul 2026 12:43:46 +0000
Date: Fri, 31 Jul 2026 14:43:41 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <amyYfXkXuDDj2shh@yuki.lan>
References: <20260715123612.1684984-6-chrubis@suse.cz>
 <6a6b32c6.cfe55ba5.193c31.b821@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a6b32c6.cfe55ba5.193c31.b821@mx.google.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo, yuki.lan:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 5/5] syscalls: Add epoll_wait16 EPOLLEXCLUSIVE
 test
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
> CHECK testcases/kernel/syscalls/epoll_wait/epoll_wait16.c
> epoll_wait16.c:91: CHECK: spaces preferred around that '+' (ctx:VxV)
> epoll_wait16.c:94: CHECK: spaces preferred around that '+' (ctx:VxV)

Fixed.

> Same comment of epoll_wait15. Otherwise:

Fixed in a similar way to epoll_wait14.

> Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

And pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
