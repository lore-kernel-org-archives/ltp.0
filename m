Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E945606A325
	for <ltp@archiver.kernel.org>; Thu, 19 Nov 2026 11:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=g6Zh+UXL;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=FhDROuX7;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Ayvjp5Ek;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=2Np85040
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B9A6B3EA969
	for <ltp@archiver.kernel.org>; Thu, 19 Nov 2026 12:21:34 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BFE0C3E9FD5
 for <ltp@lists.linux.it>; Thu, 19 Nov 2026 12:21:18 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 743351A001D8
 for <ltp@lists.linux.it>; Thu, 19 Nov 2026 12:21:16 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E923B1F798;
 Thu, 19 Nov 2026 11:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1795087275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=znmUCRoZ/Ty93XdA7VayA4ONJzJcAKhYNv8GkRpST10=;
 b=g6Zh+UXL1mhksv0G8m8+Ng4StWvJwn277GSch75Ee9NyEVoW3+Esx5XMU27DuBzc+7f2Ew
 Y3whryvJWh6QQn1CsK6a+9DnG6rqnOk8NVTPD7kc7oy1iAyBsdlkN+ertHkPu5VqAqlg4A
 LjYIpSC7T5Rdyi/rU5LsAet0Y73GclU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1795087275;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=znmUCRoZ/Ty93XdA7VayA4ONJzJcAKhYNv8GkRpST10=;
 b=FhDROuX7QKY+zyxYfUr+XhpNDvN4JhWhiavsm6hxiUIiXqprj6xfpZFrz9DJC4HJj/CqXl
 QsBknJ5z+Fw/gGDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1795087274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=znmUCRoZ/Ty93XdA7VayA4ONJzJcAKhYNv8GkRpST10=;
 b=Ayvjp5Ekdmtc/HTMNuGTpQrpycKUtp28nB/kC5+m/sG4BAQXzk5pXro0pMJW+58fWJN5iM
 N4Nh5WfJYD9AOtDkFcCVjaNAKzRUZ5BfllShPJh3poNF0fLaISq8NpKvWF/BQL+IXRvcvh
 RkQlDb+bn5Bnz1o6O2NbLSdnYGV6KrU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1795087274;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=znmUCRoZ/Ty93XdA7VayA4ONJzJcAKhYNv8GkRpST10=;
 b=2Np85040K2s/lK5o6opNFPAfG5ctI0Gp1LAnCK81WWQQpVKo9MdF2lDS2BKqxxVJLvEV+t
 9IiesREFf1HAwcAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BAF421334C;
 Thu, 19 Nov 2026 11:21:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UOBbJarb/mqGRQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 19 Nov 2026 11:21:14 +0000
Date: Thu, 19 Nov 2026 12:21:43 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Darren Chang <chihsheng@google.com>
Message-ID: <av7bx1Jlg71UMVeE@yuki.lan>
References: <20261118063445.2137150-1-chihsheng@google.com>
 <20261118163322.3334900-1-chihsheng@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261118163322.3334900-1-chihsheng@google.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-13.30 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.30
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sys_block_queue01: Accept plain "none" in
 queue/scheduler
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > This does not make any sense. Why haven't you simply added "none" to the
> > sched_allowed array instead?
> 
> "none" is already in sched_allowed[] (line 35 before this patch).
> 
> The test fails because elv_iosched_show() prints "none\n" without brackets,
> not "[none]\n". TST_SYSFS_ASSERT_CHOICE() requires one bracketed token, so
> it fails with "0 selected tokens, expected exactly 1".

Sorry missed, that, I should have read the commit message better.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
