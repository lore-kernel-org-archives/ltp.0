Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ECE5C6FD1F
	for <ltp@archiver.kernel.org>; Thu, 16 Mar 2023 10:51:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2CCF53CE5F9
	for <ltp@archiver.kernel.org>; Thu, 16 Mar 2023 11:51:08 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A568F3CAC7B
 for <ltp@lists.linux.it>; Thu, 16 Mar 2023 11:50:57 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E48BE600E38
 for <ltp@lists.linux.it>; Thu, 16 Mar 2023 11:50:56 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 8C8C821A32;
 Thu, 16 Mar 2023 10:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1678963855;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yW+2+GYSItvxqwAJ2wgo/8B0uLbm9zAowgc7l0jOs4U=;
 b=1d/Ih2HP55ZQLcVKkFPuQvAUzlacm3bowDQoDX4G/IdSF2md1eFCWYfeqK3gKFIWJrPbxt
 n40dT4gFT06ray/vypCHzvzNpRog3uf1rxoHM62J4D4jI6XIonJ6qZs2UVwd5rbvDI6PEY
 /nEtdrz9A9YgowBLeQEtpJ3ikDmLQVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1678963855;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yW+2+GYSItvxqwAJ2wgo/8B0uLbm9zAowgc7l0jOs4U=;
 b=iII7iMw/zzjR9ZwH4I4Vsa5CTjbptA2904j4AELXk3caYwoYETQRognf7uB7j47Xf+866N
 z/L0JvcugftpaQAg==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 3F08F2C141;
 Thu, 16 Mar 2023 10:50:54 +0000 (UTC)
References: <20230314114037.25581-1-rpalethorpe@suse.com>
 <ZBB0P/nfffbrMFme@yuki>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 16 Mar 2023 10:18:20 +0000
Organization: Linux Private Site
In-reply-to: <ZBB0P/nfffbrMFme@yuki>
Message-ID: <87sfe52cms.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> I see two options for patch review. Either we have a single senior
>> maintainer who does most of or it is distributed.
>> 
>> For now I think it needs to be distributed which is beyond the scope
>> of this commit.
>> 
>> In order to distribute it we need new contributors to review each
>> others' work at least for the first few revisions.
>> 
>> I think that anyone can review a patch if they put the work in to test
>> it and try to break it. Then understand why it is broken.
>> 
>> This commit states some ideas about how to do that, plus some tips for
>> more advanced patch review.
>> 
>> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
>> Cc: Cyril Hrubis <chrubis@suse.cz>
>> Cc: Andrea Cervesato <andrea.cervesato@suse.de>
>> Cc: Avinesh Kumar <akumar@suse.de>
>> Cc: Wei Gao <wegao@suse.com>
>> Cc: Petr Vorel <pvorel@suse.cz>
>> ---
>>  doc/maintainer-patch-review-checklist.txt | 78 ++++++++++++++++++++++-
>>  1 file changed, 77 insertions(+), 1 deletion(-)
>> 
>> diff --git a/doc/maintainer-patch-review-checklist.txt b/doc/maintainer-patch-review-checklist.txt
>> index 706b0a516..be0cd0961 100644
>> --- a/doc/maintainer-patch-review-checklist.txt
>> +++ b/doc/maintainer-patch-review-checklist.txt
>> @@ -1,4 +1,80 @@
>> -# Maintainer Patch Review Checklist
>> +# Patch Review
>> +
>> +Anyone can and should review patches. It's the only way to get good at
>> +patch review and for the project to scale.
>> +
>> +## Goals of patch review
>> +
>
> Maybe start with:
>
> 1. Catch typos and obvious mistakes
>
> Everyone does these and usually they are easy to spot for anyone but the
> author.
>
>> +1. Prevent false positive test results
>> +2. Prevent false negative test results
>> +3. Make future changes as easy as possible
>
> I would say that number 3 maybe be a bit controversial, I've seen cases
> where attempts to futureproof the code caused steep increase in the
> test
> complexity. So maybe:
>
> 3. Keep the code as simple as possible as well as futureproof

Perhaps just

3. Keep the code as simple as possibe, but no simpler

This is possibly paraphrasing Einstein:
https://quoteinvestigator.com/2011/05/13/einstein-simple/


NOTE: I think future proofing is actually very dangerous. What I
      probably meant was

      3. Keep the code as simple as possible, while maintaining optionality,
         but if there appears to be a disproportionate increase in complexity
         for an increase in optionality then simplicity takes priority because
         identifying relevant optionality is hard.

      but "optionality" does not have a nice dictionary definition. I guess
      you could substitute it with "freedom". In any case it's not something I
      would want to write in documentation. There is no easy way to
      express it.

>
> Or something along the lines.

>
>> +## How to find clear errors
>> +
>> +A clear error is one where there is unlikely to be any argument if you
>> +provide evidence of it. Evidence being an error trace or logical proof
>> +that an error will occur in a common situation.
>> +
>> +The following are examples and may not be appropriate for all tests.
>> +
>> +* Merge the patch. It should apply cleanly to master.
>> +* Compile the patch with default and non-default configurations.
>> +  - Use sanitizers e.g. undefined behaviour, address.
>> +  - Compile on non-x86
>> +  - Compile on x86 with -m32
>
> Maybe note here that some tests trigger undefined behavior
> intentionally, we do have a few tests that dereference NULL to trigger
> crash, etc.

Indeed the address sanitizer completely breaks a lot of tests and
produces a lot of noise.

>
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
>> +* Are we testing undefined behaviour?
>> +  - Could future kernel behaviour change without "breaking userland"?
>> +  - Does the kernel behave differently depending on hardware?
>> +  - Does it behave differently depending kernel on configuration?
>> +  - Does it behave differently depending on the compiler?
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
>> +
>> +Once you think a patch is good enough you should add your Reviewed-by
>> +tags. This means you will get some credit for getting the patch
>> +merged. Also some blame if there are problems.
>
> Maybe we should mention the Tested-by: tag explicitly here as well.

I'm not sure how we interpret Tested-by when deciding to merge; does it
mean someone is happy for the test to be merged or not?

Should someone add both tags if they have reviewed and tested it?

>
>> +In addition you can expect others to review your patches and add their
>> +tags. This will speed up the process of getting your patches merged.
>> +
>> +## Maintainers Checklist
>>  
>>  Patchset should be tested locally and ideally also in maintainer's fork in
>>  GitHub Actions on GitHub.
>> -- 
>> 2.39.2
>> 


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
