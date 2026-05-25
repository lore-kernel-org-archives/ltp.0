Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14595CD5BBF
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 09:37:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BF88C3E23E7
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 11:37:19 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7144D3C72D9
 for <ltp@lists.linux.it>; Mon, 25 May 2026 11:37:01 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C5F5C140021F
 for <ltp@lists.linux.it>; Mon, 25 May 2026 11:37:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 36F6564B8D;
 Mon, 25 May 2026 09:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779701819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X4/qh5GKfvn7RlEfbB1Bk6mHjABtUuWz3RWogcAsdQc=;
 b=TzzLLhPb/M6Ls720GajG5CWBsQWIyMWon9CKwnqMJQIGfzc0d3CHQ+5Cgrk8A0zMvK+zsN
 /8OrtFIdm8pf3Ed481nh2I4FVc0YuzHdTkmVTf1LW8DCVv/GIHW0d7mDQOpz+p+mWFh5/E
 UNcBDafx/gP0TjN7ShiqC2XPhh/NVY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779701819;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X4/qh5GKfvn7RlEfbB1Bk6mHjABtUuWz3RWogcAsdQc=;
 b=Ich9O5od3Vh/BFDXxRd96TaRy93Hwm3hrO9LHD1nP+bojNDyhKdNQs1626FfAb1LmXMFLM
 QbEUPjiMqbMydqAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sV0vRajs;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=QTyQe0Tc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779701818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X4/qh5GKfvn7RlEfbB1Bk6mHjABtUuWz3RWogcAsdQc=;
 b=sV0vRajsiuvzpPWbIlWhGXrlJFhgFu8YsTyE898ze5IgTQfGkP7OYS54Jdz1yyoxwfId9/
 lHd0o9KBB8PBSA3CTpzQJCFLtp5RknkiMV7Jvoyr+d9et85qQCCZhwbdqgqg8sFdFEzte2
 8OypoSEGH+E0CXUKdSzlQBxeQUxOyPA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779701818;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X4/qh5GKfvn7RlEfbB1Bk6mHjABtUuWz3RWogcAsdQc=;
 b=QTyQe0TcJ4JdYdzpy/GsoobMwtd1W+cLlTx2dWUIr+MtqJGtIoLfaRaEfaRB/GpXi5Bj62
 5KDEafBpUkhlC+Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 28CE759B94;
 Mon, 25 May 2026 09:36:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kTvvCDoYFGpTFAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 25 May 2026 09:36:58 +0000
Date: Mon, 25 May 2026 11:36:50 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: linuxtestproject.agent@gmail.com
Message-ID: <ahQYMv2x55-sotGZ@yuki.lan>
References: <20260523101749.27657-1-sebastian.chlad@suse.com>
 <20260523111948.4053-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260523111948.4053-1-linuxtestproject.agent@gmail.com>
X-Rspamd-Queue-Id: 36F6564B8D
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FREEMAIL_TO(0.00)[gmail.com]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[gmail.com,lists.linux.it]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[];
 internal_greylist_whitelist(0.00)[2a07:de40:b281:104:10:150:64:97];
 TAGGED_RCPT(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.cz:dkim, suse.com:email,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo, yuki.lan:mid]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] io_uring/pintheft: Add CVE-2026-43494 regression test
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
> The commit author address (sebastianchlad@gmail.com) does not match the
> Signed-off-by address (sebastian.chlad@suse.com).  Either add a .mailmap
> entry or re-send with a consistent identity.
> 
> > diff --git a/include/lapi/io_uring.h b/include/lapi/io_uring.h
> > [...]
> > +#ifndef IORING_REGISTER_CLONE_BUFFERS
> > +# define IORING_REGISTER_CLONE_BUFFERS 30
> > +#endif
> 
> Use `#define` without the extra space after `#`.  All other fallback
> defines in this file use `#define`, not `# define`.

This one is actually wrong. For historical reasons macros are indented
with spaces after the hash.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
