Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3233EE4993
	for <ltp@archiver.kernel.org>; Wed, 23 Aug 2023 13:45:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B8B13CC66C
	for <ltp@archiver.kernel.org>; Wed, 23 Aug 2023 15:45:32 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E2153CC5AE
 for <ltp@lists.linux.it>; Wed, 23 Aug 2023 15:45:20 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CEAAD1000EC4
 for <ltp@lists.linux.it>; Wed, 23 Aug 2023 15:45:19 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C2B5322367;
 Wed, 23 Aug 2023 13:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1692798318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2C/v5QWAXOO++y+PtmHjZk1QohNbG7OtxOy7XlJ0Ulo=;
 b=jqE+oVGrfXCozLIBEiUknTj0nOf9ihZ1iRXBGNgkq6EtkP2vVyDJS1/po5Jt3a457De/L2
 qjZ6pqfVU96jwo6/Jb7vQtIO59OECcRZOyKyUuC+1NRyJUUy4N4LWMGT8oGrUEnCDSowL5
 LiKxvYKkKHdEVHhsWNPeDuTb8v39Yhw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A778413458;
 Wed, 23 Aug 2023 13:45:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id plFvJ24N5mQydwAAMHmgww
 (envelope-from <ybonatakis@suse.com>); Wed, 23 Aug 2023 13:45:18 +0000
References: <20230822101333.16993-1-rpalethorpe@suse.com>
 <ZOXZarakyIoZeqQ-@yuki>
User-agent: mu4e 1.10.6; emacs 29.1
To: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 23 Aug 2023 15:37:58 +0200
Organization: Linux Private Site
In-reply-to: <ZOXZarakyIoZeqQ-@yuki>
Message-ID: <87pm3deutt.fsf@anais.suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
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
From: iob via ltp <ltp@lists.linux.it>
Reply-To: iob <ybonatakis@suse.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


Cyril Hrubis <chrubis@suse.cz> writes:

>> diff --git a/doc/maintainer-patch-review-checklist.txt b/doc/maintainer-patch-review-checklist.txt
>> index 61eb06c5f..b11c7b546 100644
>> --- a/doc/maintainer-patch-review-checklist.txt
>> +++ b/doc/maintainer-patch-review-checklist.txt
>> @@ -1,4 +1,84 @@
>> -# Maintainer Patch Review Checklist
>> +# Patch Review
>> +
>> +Anyone can and should review patches. It's the only way to get good at
>> +patch review and for the project to scale.
>> +
>> +## Goals of patch review
>> +
>> +1. Prevent false positive test results
>> +2. Prevent false negative test results
>> +3. Keep the code as simple as possible, but no simpler
>> +
>> +## How to find clear errors
>> +
>> +A clear error is one where there is unlikely to be any argument if you
>> +provide evidence of it. Evidence being an error trace or logical proof
>> +that an error will occur in a common situation.
>> +
>> +The following are examples and may not be appropriate for all tests.
>> +
>> +* Merge the patch. It should apply cleanly to master.

As a newbie with LTP I am still struggling to understand some things
like this one. How is possible to merge to master in order to review?

>> +* Compile the patch with default and non-default configurations.
>> +  - Use sanitizers e.g. undefined behaviour, address.
>> +  - Compile on non-x86
>> +  - Compile on x86 with -m32
>> +* Use `make check`
>> +* Run effected tests in a VM
>> +  - Use single vCPU
>> +  - Use many vCPUs and enable NUMA
>> +  - Restrict RAM to < 1GB.
>> +* Run effected tests on an embedded device
>> +* Run effected tests on non-x86 machine in general
>> +* Run reproducers on a kernel where the bug is present
>> +* Run tests with "-i0"
>> +* Compare usage of system calls with man page descriptions
>> +* Compare usage of system calls with kernel code
>> +* Search the LTP library for existing helper functions
>> +
>> +## How to find subtle errors
>> +
>> +A subtle error is one where you can expect some argument because you
>> +do not have clear evidence of an error. It is best to state these as
>> +questions and not make assertions if possible.
>> +
>> +Although if it is a matter of style or "taste" then senior maintainers
>> +can assert what is correct to avoid bike shedding.
>> +
>> +* Ask what happens if there is an error, could it be debugged just
>> +  with the test output?
>> +* Are we testing undefined behavior?
>> +  - Could future kernel behaviour change without "breaking userland"?
>> +  - Does the kernel behave differently depending on hardware?
>> +  - Does it behave differently depending kernel on configuration?
>> +  - Does it behave differently depending on the compiler?
>   - Does it behave differently when order of checks on syscall
>     parameters change in kernel?
>
> We used to have quite some tests that passed two or more invalid
> parameters to a sysycall expecting one of them would be checked first...
>
>> +* Will it scale to tiny and huge systems?
>> +  - What happens if there are 100+ CPUs?
>> +  - What happens if each CPU core is very slow?
>> +  - What happens if there are 2TB or RAM?
>> +* Are we repeating a pattern that can be turned into a library function?
>> +* Is a single test trying to do too much?
>> +* Could multiple similar tests be merged?
>> +* Race conditions
>> +  - What happens if a process gets preempted?
>> +  - Could checkpoints or fuzzsync by used instead?
>> +  - Note, usually you can insert a sleep to prove a race condition
>> +    exists however finding them is hard
>> +* Is there a simpler way to achieve the same kernel coverage?
>> +
>> +## How to get patches merged

Again from my POV the description is more about what you should do as a
reviewer than how to get a patch merged.

>> +
>> +Once you think a patch is good enough you should add your Reviewed-by
>> +and/or Tested-by tags. This means you will get some credit for getting
>> +the patch merged. Also some blame if there are problems.
>> +
>> +If you ran the test you can add the Tested-by tag. If you read the
>> +code or used static analysis tools on it, you can add the Reviewed-by
>> +tag.
>> +
>> +In addition you can expect others to review your patches and add their
>> +tags. This will speed up the process of getting your patches merged.
>> +
>> +## Maintainers Checklist
>
> Looks very nice, thanks for writing this out.
>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
>
> -- 
> Cyril Hrubis
> chrubis@suse.cz

I feel that this is more an overview and reminder of already
contributors. Not sure how helpful is it for new comers like myself

-- 
Sent with my mu4e

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
