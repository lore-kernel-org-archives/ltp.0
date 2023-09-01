Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4113CCA0FE1
	for <ltp@archiver.kernel.org>; Fri,  1 Sep 2023 09:04:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2FF073CE035
	for <ltp@archiver.kernel.org>; Fri,  1 Sep 2023 11:04:02 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5C9CE3CBBBE
 for <ltp@lists.linux.it>; Fri,  1 Sep 2023 11:03:50 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9EC2D20F7CF
 for <ltp@lists.linux.it>; Fri,  1 Sep 2023 11:03:49 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AE5371F459;
 Fri,  1 Sep 2023 09:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1693559026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CDKHSAOCJbqj3r6yy0ujHJd+zw6lwUty+zqV+PgLceM=;
 b=ZLlVRRs3x1ouUd70mUvyUcFcGCXlMTteOWb/r9IwCJQYUDdKvDXP8LopBr+58vYUs5ge4f
 iSYpi2Fq0B0c9YKppV6ZRu53/dLIHQiyj0PoEqQaYjx3aeiZEd6xWS+f1jm0JH/02mi855
 zuQxuMKOnFEl53K832aK0vBepngGzsk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1693559026;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CDKHSAOCJbqj3r6yy0ujHJd+zw6lwUty+zqV+PgLceM=;
 b=f7Bv4x3oLH9cTB88dpiyHfY+SY7jsSsxDm/z1KSSg6u+v018qeJpGbDLcirZfyxKHxZ6Ga
 6RlhbCAoySKZaXDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9ABC913582;
 Fri,  1 Sep 2023 09:03:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0CyZJPKo8WRyMwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 01 Sep 2023 09:03:46 +0000
Date: Fri, 1 Sep 2023 11:04:21 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <ZPGpFfGjj5kxgFY_@yuki>
References: <20230825063932.30875-1-akumar@suse.de>
 <20230825063932.30875-2-akumar@suse.de> <87fs3yguhw.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87fs3yguhw.fsf@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/5] syscalls/mmap09: Rewrite the test using new
 LTP API
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
> > +	addr = mmap(0, mapsize, PROT_READ | PROT_WRITE, MAP_FILE |
> > MAP_SHARED, fd, 0);
> 
> Why don't we use SAFE_MMAP?

I guess mainly because that would produce TBROK instead of TFAIL.

> Can we use all file systems?
> 
> The test is mapping a file and performing an operation on it. So this is
> basically a file system test.
> 
> BTW this test seems weak. I don't know what truncating the file without
> then trying to access the newly OOB memory achieves. However it's what
> the original test did, so it's up to you if you want to change anything.

I would vote for adding additional checks like this. I suppose that you
will get SIGBUS when accessing pages beyond new file size, so we should
probably fork a child, let it touch the truncated part of the file, and
check that it was killed by SIGBUS.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
