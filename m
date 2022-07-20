Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A05C433EF
	for <ltp@archiver.kernel.org>; Wed, 20 Jul 2022 11:55:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B8163C98E2
	for <ltp@archiver.kernel.org>; Wed, 20 Jul 2022 13:55:01 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 46B1A3C215A
 for <ltp@lists.linux.it>; Wed, 20 Jul 2022 13:54:52 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 40D321400DCA
 for <ltp@lists.linux.it>; Wed, 20 Jul 2022 13:54:50 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1D9FD1FD65;
 Wed, 20 Jul 2022 11:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1658318089; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4ZhmeJIbLI8A5FHY5caLwZoStLl4FqrfcS4p+s5n7mo=;
 b=TrP1wN7O3sv5np0JAmRMLUnGedgxNjMOwPpZEePX5QN4EKz/Z1llfitKStXzN+WqAbb1GV
 Raj2OqbLRhpCYbvxl7mYMUPLwQ+fvxLd1QoFAqaVpe+QUz7rBFomPzboeBnGjeUyB4dtGm
 pI0D6MmCYttVRTy/ZtBakNFkyr0/58o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1658318089;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4ZhmeJIbLI8A5FHY5caLwZoStLl4FqrfcS4p+s5n7mo=;
 b=Sj505n/iwZmyMG0Af2AXmofMxhAYgkTEuQOJK/uH9h1AXqMDDS0qIY2vOtaO/FHPjW4uMW
 S2r3fhCzDswkt8Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0764813AA1;
 Wed, 20 Jul 2022 11:54:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2eRTAAnt12JPUwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 20 Jul 2022 11:54:49 +0000
Date: Wed, 20 Jul 2022 13:56:02 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <YtftUlDCvP5uchp9@rei>
References: <19d19a5d6bbf5b19940a936b62db6dfdd29a085f.1658313770.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <19d19a5d6bbf5b19940a936b62db6dfdd29a085f.1658313770.git.jstancek@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/fsync02: restore runtime to 5m
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
> Test allows up to 240 seconds for PASS result (depending if its VM or not),
> but on slower systems library now kills it after a minute. Restore
> runtime to 5 minutes.

Looking at the test itself it's a bit messed up too.

The test uses rand(); to initialize the buffer size but without
initializing the seed which is not random at all. It also uses number of
available disk blocks as a upper limit, which makes the test runtime
completely unpredictable.

I guess that it would make sense to randomize the buffer sizes but in
certain bounds to make the test more predictable and print the numbers
we are going to use too. Maybe run the test with a few different sizes
and time limits. Maybe the size of the buffers can be function of the
test runtime.

All in all I think that we should really rething what we are doing here
since the current code does not make that much sense to me.

> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  testcases/kernel/syscalls/fsync/fsync02.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/fsync/fsync02.c b/testcases/kernel/syscalls/fsync/fsync02.c
> index e13ba89f1b63..55c7a71c1d65 100644
> --- a/testcases/kernel/syscalls/fsync/fsync02.c
> +++ b/testcases/kernel/syscalls/fsync/fsync02.c
> @@ -114,5 +114,6 @@ static struct tst_test test = {
>  	.test_all = run,
>  	.setup = setup,
>  	.cleanup = cleanup,
> -	.needs_tmpdir = 1
> +	.needs_tmpdir = 1,
> +	.max_runtime = 300,
>  };



-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
