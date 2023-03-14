Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A3D3C6FD1F
	for <ltp@archiver.kernel.org>; Tue, 14 Mar 2023 17:54:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7DFD93CD4E1
	for <ltp@archiver.kernel.org>; Tue, 14 Mar 2023 18:54:53 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2D8CA3CA013
 for <ltp@lists.linux.it>; Tue, 14 Mar 2023 18:54:42 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 449E11000342
 for <ltp@lists.linux.it>; Tue, 14 Mar 2023 18:54:40 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 240EE1F37E;
 Tue, 14 Mar 2023 17:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1678816480;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pqz8SVUYfSifS3HJ/jICgAJW/mSQso2DEKPYAJEcfyw=;
 b=JtZEnOeEX0ZypxO0EuMTaXRcSqCPlCP1ZL+gf+oVeL2Qd39c4vLU4b+4mDW0I2sFDAebo1
 jmaigXB/1Og+D24QzWTrMw5fDfV43Rq9PjfSmQLcFXgN4YNYpmMfeXO9iLqeA61m8iRjjw
 TXSoOEGH2mmY4OzvO52vCzdnlUr1e+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1678816480;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pqz8SVUYfSifS3HJ/jICgAJW/mSQso2DEKPYAJEcfyw=;
 b=4fV7s51XUU1B/vbroKqurooglyJkTIVVARiCTW9ro7ix6Lpww2da64/ySq9syuQW06aSHX
 nubHb4YcK/K39yBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AE45413A1B;
 Tue, 14 Mar 2023 17:54:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6fhbKN+0EGSDFQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 14 Mar 2023 17:54:39 +0000
Date: Tue, 14 Mar 2023 18:54:38 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.com>
Message-ID: <20230314175438.GB79562@pevik>
References: <20230314114037.25581-1-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230314114037.25581-1-rpalethorpe@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add goals of patch review and tips
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Richie,

> I see two options for patch review. Either we have a single senior
> maintainer who does most of or it is distributed.

> For now I think it needs to be distributed which is beyond the scope
> of this commit.

> In order to distribute it we need new contributors to review each
> others' work at least for the first few revisions.

> I think that anyone can review a patch if they put the work in to test
> it and try to break it. Then understand why it is broken.

> This commit states some ideas about how to do that, plus some tips for
> more advanced patch review.

Very nice improvements, thanks!
I agree with points Cyril already raised.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> Cc: Cyril Hrubis <chrubis@suse.cz>
> Cc: Andrea Cervesato <andrea.cervesato@suse.de>
> Cc: Avinesh Kumar <akumar@suse.de>
> Cc: Wei Gao <wegao@suse.com>
> Cc: Petr Vorel <pvorel@suse.cz>
> ---
>  doc/maintainer-patch-review-checklist.txt | 78 ++++++++++++++++++++++-
>  1 file changed, 77 insertions(+), 1 deletion(-)

> diff --git a/doc/maintainer-patch-review-checklist.txt b/doc/maintainer-patch-review-checklist.txt
> index 706b0a516..be0cd0961 100644
> --- a/doc/maintainer-patch-review-checklist.txt
> +++ b/doc/maintainer-patch-review-checklist.txt
> @@ -1,4 +1,80 @@
> -# Maintainer Patch Review Checklist
> +# Patch Review

I'd rename the page to patch-review.txt (can be done later).

> +
> +Anyone can and should review patches. It's the only way to get good at
> +patch review and for the project to scale.
> +
> +## Goals of patch review
> +
> +1. Prevent false positive test results
> +2. Prevent false negative test results
> +3. Make future changes as easy as possible
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
very nit: you sometimes put dot at the end of list item, sometimes not.

> +  - Use sanitizers e.g. undefined behaviour, address.
> +  - Compile on non-x86
> +  - Compile on x86 with -m32
BTW: I suppose nobody bothers about 32bit arm or even other archs.
It's definitely out of scope in SUSE.

> +* Use `make check`
> +* Run effected tests in a VM
> +  - Use single vCPU
> +  - Use many vCPUs and enable NUMA
> +  - Restrict RAM to < 1GB.
> +* Run effected tests on an embedded device
> +* Run effected tests on non-x86 machine in general
Very nice list, which show how hard would be to do a proper testing
(not being run for most of the patches - it's found afterwards, but it's very
good you list it there).

> +* Run reproducers on a kernel where the bug is present
> +* Run tests with "-i0"
`-i0` (for better syntax).

I'd also mention -i100 (or even higher, e.g. -i1100 to catch errors like get
file descriptors exhausted due missing SAFE_CLOSE(fd)).

Also, both of these are already somehow mentioned at "New tests" section, I'd
remove it from there (enough to mention them just once).

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
> +* Are we testing undefined behaviour?
> +  - Could future kernel behaviour change without "breaking userland"?
> +  - Does the kernel behave differently depending on hardware?
> +  - Does it behave differently depending kernel on configuration?
> +  - Does it behave differently depending on the compiler?
> +* Will it scale to tiny and huge systems?
> +  - What happens if there are 100+ CPUs?
> +  - What happens if each CPU core is very slow?
> +  - What happens if there are 2TB or RAM?

Again, very good points, even it's hard to test all of these before.

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
> +tags. This means you will get some credit for getting the patch
> +merged. Also some blame if there are problems.
> +
> +In addition you can expect others to review your patches and add their
> +tags. This will speed up the process of getting your patches merged.
> +
> +## Maintainers Checklist

>  Patchset should be tested locally and ideally also in maintainer's fork in
>  GitHub Actions on GitHub.
I'd encourage people to enable GitHub Actions in their forks (I'm not sure how
many maintainers do this; best would be automation [1] [2], but nobody bothers
about CI and I'm sort of burn out driving it myself).

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/issues/599
[2] https://github.com/linux-test-project/ltp/issues/600

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
