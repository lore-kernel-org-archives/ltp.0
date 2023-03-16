Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B92C6FD19
	for <ltp@archiver.kernel.org>; Thu, 16 Mar 2023 11:07:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 13E383CD479
	for <ltp@archiver.kernel.org>; Thu, 16 Mar 2023 12:07:28 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 182CF3CAC3E
 for <ltp@lists.linux.it>; Thu, 16 Mar 2023 12:07:17 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 32CA41A01145
 for <ltp@lists.linux.it>; Thu, 16 Mar 2023 12:07:16 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id B7C3021A36;
 Thu, 16 Mar 2023 11:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1678964834;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+SCIrk1pGK9ZuJlrw+3Mm5hcW/bRm0UlHnsdnKhGBiw=;
 b=1hSjNRwkL6D7U/BEooJXB4T3O/3v3ZHWOOgXccmr7JljR7WtwDKEz36z6zk0fY6USKW8BE
 yq7C6f3phsLHwla+2TYD5M8YyvGAzb7znN7M3sPvKjSSNpd7Rr629wATT8pMRGPF3F+hKc
 LZvn3LJsNJf5zjriMNKo8Rq94kiTsrs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1678964834;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+SCIrk1pGK9ZuJlrw+3Mm5hcW/bRm0UlHnsdnKhGBiw=;
 b=1hEXg91lp91yUJUGmUkx1nmiWhR+ZR8Jb8fZmBHvtCPTkECIPUcfdkIbZ/bCUlObkWl22A
 7nE7o1pMQemkQfCw==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 6C7362C141;
 Thu, 16 Mar 2023 11:07:13 +0000 (UTC)
References: <20230314114037.25581-1-rpalethorpe@suse.com>
 <20230314175438.GB79562@pevik>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 16 Mar 2023 10:51:34 +0000
Organization: Linux Private Site
In-reply-to: <20230314175438.GB79562@pevik>
Message-ID: <87o7ot2bvk.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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

Petr Vorel <pvorel@suse.cz> writes:

> Hi Richie,
>
>> I see two options for patch review. Either we have a single senior
>> maintainer who does most of or it is distributed.
>
>> For now I think it needs to be distributed which is beyond the scope
>> of this commit.
>
>> In order to distribute it we need new contributors to review each
>> others' work at least for the first few revisions.
>
>> I think that anyone can review a patch if they put the work in to test
>> it and try to break it. Then understand why it is broken.
>
>> This commit states some ideas about how to do that, plus some tips for
>> more advanced patch review.
>
> Very nice improvements, thanks!
> I agree with points Cyril already raised.
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
>> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
>> Cc: Cyril Hrubis <chrubis@suse.cz>
>> Cc: Andrea Cervesato <andrea.cervesato@suse.de>
>> Cc: Avinesh Kumar <akumar@suse.de>
>> Cc: Wei Gao <wegao@suse.com>
>> Cc: Petr Vorel <pvorel@suse.cz>
>> ---
>>  doc/maintainer-patch-review-checklist.txt | 78 ++++++++++++++++++++++-
>>  1 file changed, 77 insertions(+), 1 deletion(-)
>
>> diff --git a/doc/maintainer-patch-review-checklist.txt b/doc/maintainer-patch-review-checklist.txt
>> index 706b0a516..be0cd0961 100644
>> --- a/doc/maintainer-patch-review-checklist.txt
>> +++ b/doc/maintainer-patch-review-checklist.txt
>> @@ -1,4 +1,80 @@
>> -# Maintainer Patch Review Checklist
>> +# Patch Review
>
> I'd rename the page to patch-review.txt (can be done later).
>
>> +
>> +Anyone can and should review patches. It's the only way to get good at
>> +patch review and for the project to scale.
>> +
>> +## Goals of patch review
>> +
>> +1. Prevent false positive test results
>> +2. Prevent false negative test results
>> +3. Make future changes as easy as possible
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
>> +* Compile the patch with default and non-default configurations.
> very nit: you sometimes put dot at the end of list item, sometimes not.
>
>> +  - Use sanitizers e.g. undefined behaviour, address.
>> +  - Compile on non-x86
>> +  - Compile on x86 with -m32
> BTW: I suppose nobody bothers about 32bit arm or even other archs.
> It's definitely out of scope in SUSE.

Possibly it is in scope; 32bit makes a lot of sense on small cloud
VMs. It's also possible for ppc64 IIRC.

The only reason I mentioned x86 is because IIRC the flag is different on
some arches. These are just examples, but I could change the wording to
make it less specific?

>
>> +* Use `make check`
>> +* Run effected tests in a VM
>> +  - Use single vCPU
>> +  - Use many vCPUs and enable NUMA
>> +  - Restrict RAM to < 1GB.
>> +* Run effected tests on an embedded device
>> +* Run effected tests on non-x86 machine in general
> Very nice list, which show how hard would be to do a proper testing
> (not being run for most of the patches - it's found afterwards, but it's very
> good you list it there).
>
>> +* Run reproducers on a kernel where the bug is present
>> +* Run tests with "-i0"
> `-i0` (for better syntax).
>
> I'd also mention -i100 (or even higher, e.g. -i1100 to catch errors like get
> file descriptors exhausted due missing SAFE_CLOSE(fd)).

+1

>
> Also, both of these are already somehow mentioned at "New tests" section, I'd
> remove it from there (enough to mention them just once).

I didn't remove it because I am not sure if the "new tests" section is a
list of demands. Whereas these are just suggestions.

>
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
>
> Again, very good points, even it's hard to test all of these before.
>
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
>> +
>> +In addition you can expect others to review your patches and add their
>> +tags. This will speed up the process of getting your patches merged.
>> +
>> +## Maintainers Checklist
>
>>  Patchset should be tested locally and ideally also in maintainer's fork in
>>  GitHub Actions on GitHub.
> I'd encourage people to enable GitHub Actions in their forks (I'm not sure how
> many maintainers do this; best would be automation [1] [2], but nobody bothers
> about CI and I'm sort of burn out driving it myself).

I use it a lot. I don't remember having to enable anything, it seemed to
just work.

It provides a huge benefit I would say.

>
> Kind regards,
> Petr
>
> [1] https://github.com/linux-test-project/ltp/issues/599
> [2] https://github.com/linux-test-project/ltp/issues/600


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
