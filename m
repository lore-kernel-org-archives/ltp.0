Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D7B8CD4851
	for <ltp@archiver.kernel.org>; Wed, 13 May 2026 12:10:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D0B613E2948
	for <ltp@archiver.kernel.org>; Wed, 13 May 2026 14:10:54 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E0F583CAE38
 for <ltp@lists.linux.it>; Wed, 13 May 2026 14:10:36 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0D7C520004A
 for <ltp@lists.linux.it>; Wed, 13 May 2026 14:10:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7055E765D8;
 Wed, 13 May 2026 12:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778674235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qJhH03IJ2qHIkjoym87bQPmysFKpNuMm/Y9npnkFtCU=;
 b=x+TZ2555DuFmaLj2TPGC/F/sK2w8GhOo/zsLxzY1ZG1zUHt2CWpUgojUXZek1a0T6EUywk
 5C5g1/l7PvCU5kkWos/E8l93vlVtfYmrQcB9tTZUuzPn1vCz1yD54wGZVsKjmgzh/dX7d9
 ++oA7p+jZkxCmmqebbu2/zLqtczULZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778674235;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qJhH03IJ2qHIkjoym87bQPmysFKpNuMm/Y9npnkFtCU=;
 b=NOiHGmbo8ywH4yORgRRM3XCZeLYFfQlbr6oylfvrZrW5FEOzqLpNkEFpzov4EJIQ4I5Zyo
 jh8+DRk6zACyYnCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778674235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qJhH03IJ2qHIkjoym87bQPmysFKpNuMm/Y9npnkFtCU=;
 b=x+TZ2555DuFmaLj2TPGC/F/sK2w8GhOo/zsLxzY1ZG1zUHt2CWpUgojUXZek1a0T6EUywk
 5C5g1/l7PvCU5kkWos/E8l93vlVtfYmrQcB9tTZUuzPn1vCz1yD54wGZVsKjmgzh/dX7d9
 ++oA7p+jZkxCmmqebbu2/zLqtczULZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778674235;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qJhH03IJ2qHIkjoym87bQPmysFKpNuMm/Y9npnkFtCU=;
 b=NOiHGmbo8ywH4yORgRRM3XCZeLYFfQlbr6oylfvrZrW5FEOzqLpNkEFpzov4EJIQ4I5Zyo
 jh8+DRk6zACyYnCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5CDB7593A9;
 Wed, 13 May 2026 12:10:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fvpYFTtqBGoNDwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 13 May 2026 12:10:35 +0000
Date: Wed, 13 May 2026 14:10:36 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: lepillai@linux.ibm.com
Message-ID: <agRqPN5shKzr9XLX@yuki.lan>
References: <20260513064818.1596754-1-lepillai@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260513064818.1596754-1-lepillai@linux.ibm.com>
X-Spamd-Result: default: False [-1.30 / 50.00]; LONG_SUBJ(3.00)[741];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Patch:V2:creat07():Added new_behavior flag to
 detect kernel version > 6.11 : Tests that creat() succeeds (write to
 executed file allowed) Removed the old skip logic that did TCONF on kernel
 >= 6.11 Added one static variable exp_errno to store expected result: -1
 means creat() should succeed ETXTBSY means it should fail with that errno
 setup() now sets exp_errno from kernel version Simplified verify_creat():
 if expected is success, call creat(), close fd,
 print TPASS if expected is failure,
 use TST_EXP_FAIL2() for ETXTBSY Removed extra verbose kernel-info messages
 Removed exec of external child binary and replaced it with an in-process
 forked child using TST_CHECKPOINT_WAKE() + pause() Removed .resource_files
 from test
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
Cc: lekshmi-cpillai <lekshmi@ktes.isst.tadn.ibm.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
I think the best solution is to change this test not to run on newer
kernel and write a new test that checks the new behavior. Combining the
two different expectations in a single test is going to be inherently
messy.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
