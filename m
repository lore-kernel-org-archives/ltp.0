Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45427C433FE
	for <ltp@archiver.kernel.org>; Mon, 21 Nov 2022 15:04:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3FC973CCBDE
	for <ltp@archiver.kernel.org>; Mon, 21 Nov 2022 16:04:02 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 366583CCB8E
 for <ltp@lists.linux.it>; Mon, 21 Nov 2022 16:03:52 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 98C867D15AC
 for <ltp@lists.linux.it>; Mon, 21 Nov 2022 16:03:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669043030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fDvGekn5ZJebZyOp1niQngO/i+X3ZD8ZBHmBAiQ89ws=;
 b=NpU4zObKe7SoEhJi/6mL/AGXy8XK6YvBHEriR6xWhh6WkL5Q6BrOoWgds3Q7PC7kk565yK
 Xsrh18WqApxwvLBQ98UhINZ5KFq+M+XhNMv2JM770lEj0K8WcABk73oJGdZKalv64t3HFj
 BVIC57zcnl7Yte6pB6k+vlqVKK3Cuv4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-1-IvetFvu0PmSQHWGatsiA8Q-1; Mon, 21 Nov 2022 10:03:47 -0500
X-MC-Unique: IvetFvu0PmSQHWGatsiA8Q-1
Received: by mail-wr1-f70.google.com with SMTP id
 s25-20020adf9799000000b00241d0801f31so1171020wrb.11
 for <ltp@lists.linux.it>; Mon, 21 Nov 2022 07:03:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fDvGekn5ZJebZyOp1niQngO/i+X3ZD8ZBHmBAiQ89ws=;
 b=rdlObCa7rphkZs42gDImLp7HMPR6Snm4jtp/kKlyhLfljmhykm2mOpu1tVjORGtGlE
 nF8M242pbWtwst0yhdbwNqk0BlBVgOInpU1CbYsNyk/l44qLJ9Ug7HKkFQ6DviGtnG35
 LydBq9ea2grBYYrr4VWAeuF6B3spe85D7Dn4F+r7lzDPuogOMtc8/cS59mA5Tf/LV3fW
 ok9zMArY6zbu/WEMhHf4dt4LKw1jRUOfzQChcRsrnFpW4zKNrlQHstSTOHIH+PXbElgN
 1hC8BZsOPJm4rLkFM2o3jl3zgxPJA6AKVq94416JN02yYQPOKtljEjdf+8rmfUvLhLBN
 KJkw==
X-Gm-Message-State: ANoB5pnqOV8wcU5PmOcMnAc6NTQ5yQaDVb08qyitnoyZ94PtNsOWJZuV
 8GQAoya5jbvadHrnZh+Rg9lbma60ndzbBFZHpPhSw6PGebdIa+FhaJOGkeyGk7BGTvVyHV1H+Mr
 PCuOM2LbrdGc=
X-Received: by 2002:a5d:458e:0:b0:241:d11e:fd2e with SMTP id
 p14-20020a5d458e000000b00241d11efd2emr4498622wrq.296.1669043026584; 
 Mon, 21 Nov 2022 07:03:46 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7qeYkZg/bkd8paNA22MXGE+AW8hoWwyyv8fKvNnykzbG8nj81HvosPSnXOvQne14cbRrouZA==
X-Received: by 2002:a5d:458e:0:b0:241:d11e:fd2e with SMTP id
 p14-20020a5d458e000000b00241d11efd2emr4498597wrq.296.1669043026218; 
 Mon, 21 Nov 2022 07:03:46 -0800 (PST)
Received: from [192.168.3.108] (p5b0c67dc.dip0.t-ipconnect.de. [91.12.103.220])
 by smtp.gmail.com with ESMTPSA id
 t11-20020adff60b000000b0022e035a4e93sm11651575wrp.87.2022.11.21.07.03.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Nov 2022 07:03:45 -0800 (PST)
Message-ID: <2eae994a-fc89-8ccd-a77c-944776372671@redhat.com>
Date: Mon, 21 Nov 2022 16:03:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
From: David Hildenbrand <david@redhat.com>
To: Cyril Hrubis <chrubis@suse.cz>
References: <20221117121409.179210-1-david@redhat.com> <Y3eI0Q5BTE12+4zO@yuki>
 <34f4e1af-8b1f-fd6b-8345-5b1948de7f14@redhat.com>
Organization: Red Hat
In-Reply-To: <34f4e1af-8b1f-fd6b-8345-5b1948de7f14@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] security/dirtyc0w_shmem: Add new test for
 CVE-2022-2590
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 21.11.22 15:59, David Hildenbrand wrote:
> On 18.11.22 14:29, Cyril Hrubis wrote:
>> Hi!
> 
> Hi Cyril,
> 
> thanks for your review!
> 
> [...]
> 
>>> +
>>> +/*
>>> + * CVE-2022-2590
>>> + *
>>> + * This is a regression test for a write race that allows unprivileged programs
>>> + * to change readonly files located on tmpfs/shmem on the system.
>>> + *
>>> + * Fixed by:
>>> + *
>>> + *   commit 5535be3099717646781ce1540cf725965d680e7b
>>> + *   Author: David Hildenbrand <david@redhat.com>
>>> + *   Date:   Tue Aug 9 22:56:40 2022 +0200
>>> + *
>>> + *   mm/gup: fix FOLL_FORCE COW security issue and remove FOLL_COW
>>> + */
>>
>> This is not a proper documentation comment. We do have a system in place
>> that picks up ascii-doc formatted documentation comments and builds a
>> documentation based on that.
>>
>> The documentation comment has to start with:
>>
>> /*\
>>    * [Description]
>>    *
>>
>>
>> Also the CVE and kernel commit are picked from tags when documentation
>> is build, so they do not need to be part of the documentation comment.
>>
> 
> I used dirtyc0w.c as orientation, which probably wasn't a good idea.
> 
> I'll use a simple
> 
> /*\
>    * [Description]
>    *
>    * This is a regression test for a write race that allowed unprivileged programs
>    * to change readonly files located on tmpfs/shmem on the system using
>    * userfaultfd "minor fault handling" (CVE-2022-2590).
>    */
> 
>>> +#include "config.h"
>>> +
>>> +#include <pthread.h>
>>> +#include <unistd.h>
>>> +#include <sys/stat.h>
>>> +#include <string.h>
>>> +#include <stdlib.h>
>>> +#include <stdbool.h>
>>> +#include <pwd.h>
>>> +
>>> +#include "tst_test.h"
>>> +
>>> +#define TMP_DIR "tmp_dirtyc0w_shmem"
>>> +#define TEST_FILE TMP_DIR"/testfile"
>>> +#define STR "this is not a test\n"
>>> +
>>> +static uid_t nobody_uid;
>>> +static gid_t nobody_gid;
>>> +static bool child_early_exit;
>>
>> Anything that is changed from signal handler should be volatile
>> otherwise it may end up optimized out.
> 
> Ack.
> 
>>
>>> +static void sighandler(int sig)
>>> +{
>>> +	if (sig == SIGCHLD) {
>>> +		child_early_exit = true;
>>> +		return;
>>> +	}
>>> +
>>> +	_exit(0);
>>> +}
>>> +
>>> +static void setup(void)
>>> +{
>>> +	struct passwd *pw;
>>> +
>>> +	umask(0);
>>> +
>>> +	pw = SAFE_GETPWNAM("nobody");
>>> +
>>> +	nobody_uid = pw->pw_uid;
>>> +	nobody_gid = pw->pw_gid;
>>> +
>>> +	SAFE_MKDIR(TMP_DIR, 0664);
>>> +	SAFE_MOUNT(TMP_DIR, TMP_DIR, "tmpfs", 0, NULL);
>>> +}
>>> +
>>> +static void dirtyc0w_shmem_test(void)
>>> +{
>>> +	bool failed = false;
>>> +	int fd, pid;
>>> +	char c;
>>> +
>>> +	fd = SAFE_OPEN(TEST_FILE, O_WRONLY|O_CREAT|O_EXCL, 0444);
>>> +	SAFE_WRITE(SAFE_WRITE_ALL, fd, STR, sizeof(STR)-1);
>>> +	SAFE_CLOSE(fd);
>>
>> SAFE_FILE_PRINTF() ?
> 
> AFAIU, that would mean
> 
> SAFE_FILE_PRINTF(TEST_FILE, "%s", STR);

SAFE_FILE_PRINTF(TEST_FILE, STR);

to be precise.

Seems to get the job done.

-- 
Thanks,

David / dhildenb


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
