Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8343C44507
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 11:30:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F26233E5683
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 13:30:43 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D4AC43E1766
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 13:30:28 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2F353600909
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 13:30:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7F5983E34;
 Wed, 15 Jul 2026 11:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784115027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P7yjhLVyjZ0VoCGQtVgasOPJKVW1Ig14U40yJRO+dDE=;
 b=14j7vyS9L2XCbq4Kp6mtqXXl09kThLkN9XU2Q46ZZ1Yr1BtC4+dq2QnrfCrXs6//tdwGvy
 E/OHI2wGzDeH/K6AddWM7CB+OT12kprYBkcXt4ZAGj+F2es0flu6m0L0EeAKqR1jkFjbB0
 cwSP+O+ZN/7qKGr/x2qvH0aoXGjFNys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784115027;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P7yjhLVyjZ0VoCGQtVgasOPJKVW1Ig14U40yJRO+dDE=;
 b=1EWzjGnbt+CrKyFJSBC7E9hqHhx3mCWPG+Zbit6zpTZCX6Wnx2TO/47eBct4X9YJyqA6xG
 uXpXx/iBOAugOOCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784115027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P7yjhLVyjZ0VoCGQtVgasOPJKVW1Ig14U40yJRO+dDE=;
 b=14j7vyS9L2XCbq4Kp6mtqXXl09kThLkN9XU2Q46ZZ1Yr1BtC4+dq2QnrfCrXs6//tdwGvy
 E/OHI2wGzDeH/K6AddWM7CB+OT12kprYBkcXt4ZAGj+F2es0flu6m0L0EeAKqR1jkFjbB0
 cwSP+O+ZN/7qKGr/x2qvH0aoXGjFNys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784115027;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P7yjhLVyjZ0VoCGQtVgasOPJKVW1Ig14U40yJRO+dDE=;
 b=1EWzjGnbt+CrKyFJSBC7E9hqHhx3mCWPG+Zbit6zpTZCX6Wnx2TO/47eBct4X9YJyqA6xG
 uXpXx/iBOAugOOCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C72C779AD;
 Wed, 15 Jul 2026 11:30:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id v9tME1NvV2rwGAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 15 Jul 2026 11:30:27 +0000
Date: Wed, 15 Jul 2026 13:30:22 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aldvThABy_u7ppuP@yuki.lan>
References: <20260715094138.1679456-1-chrubis@suse.cz>
 <6a576e39.5dfca4bd.1671aa.39e8@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a576e39.5dfca4bd.1671aa.39e8@mx.google.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/5] Even more epoll tests
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
> the patch doesn't compile in opensuse 42.2. We need to define
> EPOLLEXCLUSIVE because it's undeclared.
> 
> https://github.com/linux-test-project/ltp/actions/runs/29408205713/job/87328746756
> 
> Moving the patch-set to changes request.

Indeed I will fix the other typos that were pointed out by ltp-agent and
send v2.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
