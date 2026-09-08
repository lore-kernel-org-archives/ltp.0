Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC0CC79FA1
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 10:48:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 087F93E7359
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 12:47:59 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 006AD3E1895
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 12:47:42 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 245546008CC
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 12:47:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BFBE71F449;
 Tue,  8 Sep 2026 10:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788864450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2q5vT9cVyP4ebHIP2dsDfmcy8o6BSke1Keh0BHcnMoY=;
 b=ARI9utPwUGaN2oqDxoyI7bhuLYWC/XBjmyzFUx/mJgnZhNyTfAhou3C3JXCNf9C23Xabqs
 rXdILLz87puUxwL7xa4XsNHdC3qoP07rUJ0jxH78x4UkSnxuIG6xljmCdZuQdeHLvS6XkZ
 uYEVA7uQmkFhRPP/zdoncbJ7IgzVgYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788864450;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2q5vT9cVyP4ebHIP2dsDfmcy8o6BSke1Keh0BHcnMoY=;
 b=bN6MXqkeDQLbMt4E3lSBrsU37ecwRrsZ+uASxuF7k8IPpHjeSZwLVhv/WjOpqWst8Xog1y
 KYx6DXjdBhc5HtBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788864446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2q5vT9cVyP4ebHIP2dsDfmcy8o6BSke1Keh0BHcnMoY=;
 b=vGl952c9P4c0MWqcgMURWtuIuthWTEHnu6VfzzqTuSU+Jf1Lcea2aY3gg3+PTxs9dEvXII
 2fjdMaeshBvVmnXG7vNnA0K4BTATZ0i7BzaennXVWKaHdnGcGPgdiyQltOIK8HcXyq5tqq
 znNZ1itZX9t4PJEQU1+oMOGitQspfT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788864446;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2q5vT9cVyP4ebHIP2dsDfmcy8o6BSke1Keh0BHcnMoY=;
 b=6HFNb0JNKXQe7v56aww6UCOmrieZZX8LtQZ8pGU1Qbp4k/3MMLHzHirGVzNinXi+SbJPKp
 lmNBpVkdN8lNx7Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D31A1364A;
 Tue,  8 Sep 2026 10:47:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cj9YJr7nn2pzKgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 08 Sep 2026 10:47:26 +0000
Date: Tue, 8 Sep 2026 12:47:35 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Victor Cheng-Yen Yang <cyyang772@andestech.com>
Message-ID: <ap_nx7AZvluXzW-i@yuki.lan>
References: <20260908023121.1895897-1-cyyang772@andestech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260908023121.1895897-1-cyyang772@andestech.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mmap21: Check for free space before mapping the
 file
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
> The test creates a sparse file with lseek() and a one byte write, so
> mmap() allocates no blocks. The child then touches every byte and ext4
> fills the holes inside ext4_page_mkwrite(). A store instruction has no
> error return, so an ENOSPC there becomes VM_FAULT_SIGBUS and the test
> reports only
> 
>   tst_test.c:536: TBROK: Child (13042) killed by signal SIGBUS
> 
> which says nothing about the full filesystem. The information is
> available before the mapping and gone after it, so check it in setup
> and report TCONF earlier as convention.

Depending on the page size this is either 4MB or 64MB, I would say that
if you run LTP on a machine with less than 4MB of free space many tests
would fail.

Maybe it would make sense to print a warning from the test library for
any tests that has needs_tmpdir == 1 and the free space at the test
temporary directory is less than a few megabytes.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
