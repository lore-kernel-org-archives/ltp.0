Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD12D35179
	for <ltp@archiver.kernel.org>; Wed,  1 Apr 2026 12:04:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 431093E5BEC
	for <ltp@archiver.kernel.org>; Wed,  1 Apr 2026 14:04:43 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 91F633CC387
 for <ltp@lists.linux.it>; Wed,  1 Apr 2026 14:04:25 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1DE4B20119D
 for <ltp@lists.linux.it>; Wed,  1 Apr 2026 14:04:24 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C31C64D2E1;
 Wed,  1 Apr 2026 12:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775045063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C2PGPLs+EyqGiSOqy+a2PwbuQXbNo9gTdeEXzThOTNQ=;
 b=Sf+nIuZsWFQMWnFT8yWZWZTnS+BTHp1e8doMSn0KG+ktQVw2i6JGJl9HIF4zNv1XBqBPO9
 lMlK8hzslRNeH/DTkmAHCmW5Gs1i6FXHgfI6jOxMTuqf2930RM0KlcSPpCnyzpIG2ddsIO
 nr91i0DaqRd/M/6Qb7Rdl7et0NUrJpI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775045063;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C2PGPLs+EyqGiSOqy+a2PwbuQXbNo9gTdeEXzThOTNQ=;
 b=vft5c28b3zBvKu2R3FRi8uJnkT72M2iAOMCQ5OeGuC4oOtAKVTqfTwc151gtYeNVBShWIn
 pJhcHQAaL9hbkYAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Sf+nIuZs;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vft5c28b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775045063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C2PGPLs+EyqGiSOqy+a2PwbuQXbNo9gTdeEXzThOTNQ=;
 b=Sf+nIuZsWFQMWnFT8yWZWZTnS+BTHp1e8doMSn0KG+ktQVw2i6JGJl9HIF4zNv1XBqBPO9
 lMlK8hzslRNeH/DTkmAHCmW5Gs1i6FXHgfI6jOxMTuqf2930RM0KlcSPpCnyzpIG2ddsIO
 nr91i0DaqRd/M/6Qb7Rdl7et0NUrJpI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775045063;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C2PGPLs+EyqGiSOqy+a2PwbuQXbNo9gTdeEXzThOTNQ=;
 b=vft5c28b3zBvKu2R3FRi8uJnkT72M2iAOMCQ5OeGuC4oOtAKVTqfTwc151gtYeNVBShWIn
 pJhcHQAaL9hbkYAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1F164A0B0;
 Wed,  1 Apr 2026 12:04:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FaYQKscJzWmvagAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 01 Apr 2026 12:04:23 +0000
Date: Wed, 1 Apr 2026 14:04:31 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Michael Menasherov <mmenashe@redhat.com>
Message-ID: <ac0Jz9RnHrOlf93j@yuki.lan>
References: <CAHGiOXfj60hbfgVPBUYwTicuD9HMkdpjDwx9CLRLKHQ+BYO58A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHGiOXfj60hbfgVPBUYwTicuD9HMkdpjDwx9CLRLKHQ+BYO58A@mail.gmail.com>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C31C64D2E1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] PATCH] futex: Add error coverage tests for wait,
 wake and cmp_requeue
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
Cc: Stephen Bertram <sbertram@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> The test's cover are as follows.
> futex_wait06: EFAULT for bad uaddr and timeout pointers
> futex_wait07: EINTR when interrupted by a signal
> futex_wake05: EFAULT for unmapped and PROT_NONE addresses
> futex_cmp_requeue03: EFAULT for bad uaddr/uaddr2, and EACCES
> 
> This is my first patch contribution to LTP, any feedback and suggestions
> will be welcomed.

I suppose that this pull request is created by you:

https://github.com/linux-test-project/ltp/pull/1301

We can either review the pull or you can send the patches to this
mailing list with git-send-email. If you want to continue on the github,
someone will pick up the patches and review them once we get to it in
the patch queue.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
