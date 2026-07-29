Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22DC7C53200
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 12:25:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E44293E4BE4
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 14:25:25 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8BA643E138C
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 14:25:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0ABF7140035E
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 14:25:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CF79B3E0C;
 Wed, 29 Jul 2026 12:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785327904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LwLB0BK/xZ8QagoyPml/5rtPCQi0DyVYAI5jP1Y3jxU=;
 b=rOz9LziHXwl3dNKE+sJKeefYTFx53Z4ILQ13LJ5Sy3tvfwzRMiC4xJ9LVusPl2nfXecJsZ
 W85QBWZI3PJI9adjYia1SFY6eATndScC3hR6pKzrJGQ1HsMeRZNdSG7GErjaSHE4eZ3GRg
 x/A9abOUwMpI8vkzrk4B2s/kZi/vLg4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785327904;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LwLB0BK/xZ8QagoyPml/5rtPCQi0DyVYAI5jP1Y3jxU=;
 b=WnFwTSImNT6Kz3RlVT6lHrl8zBSc577pLqmzTyH7UdG1XncWMvC4YFZ6v8iISPA2KH/L5t
 qsg001dkjVHS/gDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=a46CQxBJ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=41WL3zYX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785327900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LwLB0BK/xZ8QagoyPml/5rtPCQi0DyVYAI5jP1Y3jxU=;
 b=a46CQxBJFC7njHpATeXkkEbhg2k8eOF0ZABiLwupL550w1EAy+vIQnhYinyljZDjmfb9+T
 f7ADTUIQZWWANGKjZGdTJZuF6bFRCs4eYci6jaJD64gJhcjIRKaM/QLPVe2PWY7PdFBAq4
 iEL0+Ev0YkzgxR6d2KMXisR2mQ0B/A4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785327900;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LwLB0BK/xZ8QagoyPml/5rtPCQi0DyVYAI5jP1Y3jxU=;
 b=41WL3zYXGZddOte2BeD+nyzaijdteE2GYDSkLUoINCplVZ1mNuJyoVsEOX/UJLHifzFPMI
 3e28R/Ji73OuxqBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC04A779B1;
 Wed, 29 Jul 2026 12:25:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id m5EbLRzxaWqoOgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 29 Jul 2026 12:25:00 +0000
Date: Wed, 29 Jul 2026 14:24:55 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Sachin Sant <sachinp@linux.ibm.com>
Message-ID: <amnxF9DZ5u2UYL95@yuki.lan>
References: <20260616045414.9081-1-sachinp@linux.ibm.com>
 <20260616045414.9081-2-sachinp@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260616045414.9081-2-sachinp@linux.ibm.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: CF79B3E0C
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.cz:dkim,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v12 1/8] fs/acl: Add ACL_USER_OBJ permission test
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
I've cleaned up the patchset and pushed all the acl_* tests, thanks.

We already have xattr tests in syscalls/{set,get}_xattr that cover basic
xattr operations I haven't xattr_test01 for that reason. If coverage is
lacking there the xattr tests should be put there.

The main changes:

Added SAFE_ACL_SET_FILE() since the code to handle EOPNOTSUPP was
repeated in each test. I've also weeded out some of the cleanup, there
is no point in unlinking files or freeing memory before we call
tst_brk() since that will be handled by the test cleanup and OS process
memory teardown.

Also weeded out the file removal in various branches in the middle of
the test and in the test setup(). Each test cleans up the files at the
start of the test function. With that there is no point in doing the
cleanup anywhere else but cleanup().

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
