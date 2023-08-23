Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6B2EE49B2
	for <ltp@archiver.kernel.org>; Wed, 23 Aug 2023 10:03:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A37343CC5AE
	for <ltp@archiver.kernel.org>; Wed, 23 Aug 2023 12:03:03 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE2EB3C9947
 for <ltp@lists.linux.it>; Wed, 23 Aug 2023 12:02:51 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F34A52010F4
 for <ltp@lists.linux.it>; Wed, 23 Aug 2023 12:02:50 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3F84C206FD;
 Wed, 23 Aug 2023 10:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1692784970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ADgy71ZfFbMsacwC9YF/Cas8Xo8MDTsILffGemE+/JY=;
 b=jWnex9bFmVL7g7rPbwCRVCm9DK20+0M5Jh2pFeSR2qhhOjgg/ItLAmvNLVzi509+nnyi2L
 t8BEKxvcgavZWk75y2oHAgX3v3nfR8ZmLoUaKBiGUdvl380cEWCva1kj3LzPeuHIEXuzXd
 5NdB6ouETOcYnamR8JYhzC2GwA4OAZc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1692784970;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ADgy71ZfFbMsacwC9YF/Cas8Xo8MDTsILffGemE+/JY=;
 b=g6Ko768Wh2c+IjZiD50pEYtlsD88F85Ny1JuTTAfe0WlFlInArmDyvnVVeZY8W9Aj57Qgk
 UlktbK3V7W/q3BBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 17D9C1351F;
 Wed, 23 Aug 2023 10:02:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id hUfEAkrZ5WQBCwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 23 Aug 2023 10:02:50 +0000
Date: Wed, 23 Aug 2023 12:03:22 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.com>
Message-ID: <ZOXZarakyIoZeqQ-@yuki>
References: <20230822101333.16993-1-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230822101333.16993-1-rpalethorpe@suse.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Add goals of patch review and tips
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

> diff --git a/doc/maintainer-patch-review-checklist.txt b/doc/maintainer-patch-review-checklist.txt
> index 61eb06c5f..b11c7b546 100644
> --- a/doc/maintainer-patch-review-checklist.txt
> +++ b/doc/maintainer-patch-review-checklist.txt
> @@ -1,4 +1,84 @@
> -# Maintainer Patch Review Checklist
> +# Patch Review
> +
> +Anyone can and should review patches. It's the only way to get good at
> +patch review and for the project to scale.
> +
> +## Goals of patch review
> +
> +1. Prevent false positive test results
> +2. Prevent false negative test results
> +3. Keep the code as simple as possible, but no simpler
> +
> +## How to find clear errors
> +
> +A clear error is one where there is unlikely to be any argument if you
> +provide evidence of it. Evidence being an error trace or logical proof
> +that an error will occur in a common situation.
> +
> +The following are examples and may not be appropriate for all tests.
> +
> +* Merge the patch. It should apply cleanly to master.
> +* Compile the patch with default and non-default configurations.
> +  - Use sanitizers e.g. undefined behaviour, address.
> +  - Compile on non-x86
> +  - Compile on x86 with -m32
> +* Use `make check`
> +* Run effected tests in a VM
> +  - Use single vCPU
> +  - Use many vCPUs and enable NUMA
> +  - Restrict RAM to < 1GB.
> +* Run effected tests on an embedded device
> +* Run effected tests on non-x86 machine in general
> +* Run reproducers on a kernel where the bug is present
> +* Run tests with "-i0"
> +* Compare usage of system calls with man page descriptions
> +* Compare usage of system calls with kernel code
> +* Search the LTP library for existing helper functions
> +
> +## How to find subtle errors
> +
> +A subtle error is one where you can expect some argument because you
> +do not have clear evidence of an error. It is best to state these as
> +questions and not make assertions if possible.
> +
> +Although if it is a matter of style or "taste" then senior maintainers
> +can assert what is correct to avoid bike shedding.
> +
> +* Ask what happens if there is an error, could it be debugged just
> +  with the test output?
> +* Are we testing undefined behavior?
> +  - Could future kernel behaviour change without "breaking userland"?
> +  - Does the kernel behave differently depending on hardware?
> +  - Does it behave differently depending kernel on configuration?
> +  - Does it behave differently depending on the compiler?
  - Does it behave differently when order of checks on syscall
    parameters change in kernel?

We used to have quite some tests that passed two or more invalid
parameters to a sysycall expecting one of them would be checked first...

> +* Will it scale to tiny and huge systems?
> +  - What happens if there are 100+ CPUs?
> +  - What happens if each CPU core is very slow?
> +  - What happens if there are 2TB or RAM?
> +* Are we repeating a pattern that can be turned into a library function?
> +* Is a single test trying to do too much?
> +* Could multiple similar tests be merged?
> +* Race conditions
> +  - What happens if a process gets preempted?
> +  - Could checkpoints or fuzzsync by used instead?
> +  - Note, usually you can insert a sleep to prove a race condition
> +    exists however finding them is hard
> +* Is there a simpler way to achieve the same kernel coverage?
> +
> +## How to get patches merged
> +
> +Once you think a patch is good enough you should add your Reviewed-by
> +and/or Tested-by tags. This means you will get some credit for getting
> +the patch merged. Also some blame if there are problems.
> +
> +If you ran the test you can add the Tested-by tag. If you read the
> +code or used static analysis tools on it, you can add the Reviewed-by
> +tag.
> +
> +In addition you can expect others to review your patches and add their
> +tags. This will speed up the process of getting your patches merged.
> +
> +## Maintainers Checklist

Looks very nice, thanks for writing this out.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
