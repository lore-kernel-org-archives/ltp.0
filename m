Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2EB4C678D4
	for <ltp@archiver.kernel.org>; Tue,  7 Mar 2023 12:48:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 605AB3CDA11
	for <ltp@archiver.kernel.org>; Tue,  7 Mar 2023 13:48:43 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1072B3CB855
 for <ltp@lists.linux.it>; Tue,  7 Mar 2023 13:48:33 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6F4B72000D3
 for <ltp@lists.linux.it>; Tue,  7 Mar 2023 13:48:31 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 66378219AA;
 Tue,  7 Mar 2023 12:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1678193311;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SZXZLt2vGZJysS02f9Hev4LVO5qqGGTm8oHC4hYy6bI=;
 b=pw6B2lgHuJM2nIuAhwgpYY4G99OQ2aZuxBXPK/uHMY98Cn7271EWxq5TCRae3uRKQqMTph
 irP0A1576vBIjvUXjgAQY8SURpFdlVZ/SpumYBXGO1oK86SzIBMP3kmNKTq4Bo6ld0AiAR
 TZTiaRdqSW21gvbmK+EW/vj0H9wiAW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1678193311;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SZXZLt2vGZJysS02f9Hev4LVO5qqGGTm8oHC4hYy6bI=;
 b=ZzCgLMZEijHbrov8j3Stx7TPw/BiakvmrZSu5Nfk92pV1+acxqrBNlG6PLRWljkeRfB/+T
 Id8FSjNbbtnVnOBg==
Received: from g78 (unknown [10.100.204.110])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 9066B2C141;
 Tue,  7 Mar 2023 12:48:30 +0000 (UTC)
References: <20230216114745.2389810-1-andrei.gherzan@canonical.com>
 <Y++c8fBZxmUIR3Lb@pevik>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 07 Mar 2023 12:43:14 +0000
Organization: Linux Private Site
In-reply-to: <Y++c8fBZxmUIR3Lb@pevik>
Message-ID: <87ttyw7mn6.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fs_fill: Fix test when running on a 256 CPU+
 machine
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
Cc: ltp@lists.linux.it, Andrei Gherzan <andrei.gherzan@canonical.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Petr Vorel <pvorel@suse.cz> writes:

> Hi Andrei,
>
>> The fs_fill test runs a fill test on all the supported filesystems. One
>> of them being vfat. This filesystem is configured dynamically or through
>> flags/arguments for its file allocation table type (12/16/32).
>
>> The size of the test device (which is a loop-mounted fs) is 300MB. When not
>> instructed, mkfs will "automatically select between 12, 16 and 32 bit,
>> whatever fits better for the filesystem size"[1]. In the case of a 300Mb that
>> would end up as FAT16.
> Interesting. BTW we plan to change 300 MB to minimal filesystem which would fit
> to all existing tests (255 MB was for Btrfs, 300 MB was for XFS, but there might
> be minimal systems which can use vfat, ext4, ... with smaller resources, e.g.
> 16 MB for filesystem). Therefore I wonder what is minimal reasonable required
> size for vfat. i.e. what MB is required for FAT32? (I guess we don't want to
> check FAT12 or FAT16).
>
>> This is linked with another configuration that is the actual impact on
>> this issue: the maximum number of directories in the root of the
>> filesystem. FAT12 and FAT16 use a special system region: "Root Directory
>> Region". And by default (there is also an argument to configure this at
>> mkfs-time) this ends up being 256 when no custom arguments are provided.
>
>> On the other hand, the test sets up the filesystem with a
>> "tst_ncpus_conf + 2" number of directories in the test filesystem's root
>> which can break the limit explained above on systems with a number of
>> CPUs that would amount above the limit.
>
>> This change addresses this situation by using a subdirectory in the test
>> filesystem which is not subject to this limit.
>
>> Signed-off-by: Andrei Gherzan <andrei.gherzan@canonical.com>
>> ---
>>  testcases/kernel/fs/fs_fill/fs_fill.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>
>> diff --git a/testcases/kernel/fs/fs_fill/fs_fill.c b/testcases/kernel/fs/fs_fill/fs_fill.c
>> index 2027b6df1..dd8ad2935 100644
>> --- a/testcases/kernel/fs/fs_fill/fs_fill.c
>> +++ b/testcases/kernel/fs/fs_fill/fs_fill.c
>> @@ -18,6 +18,7 @@
>>  #include "tst_test.h"
>
>>  #define MNTPOINT "mntpoint"
>> +#define THREADS_SUBDIR "subdir"
>
>>  static volatile int run;
>>  static unsigned int nthreads;
>> @@ -99,9 +100,13 @@ static void setup(void)
>>  	nthreads = tst_ncpus_conf() + 2;
>>  	workers = SAFE_MALLOC(sizeof(struct worker) * nthreads);
>
>> +	// Avoid creating the thread directories in the root of the filesystem
>> +	// to not hit the root entries limit on a  FAT16 filesystem.
>> +	SAFE_MKDIR(MNTPOINT "/" THREADS_SUBDIR, 0700);
>> +
>>  	for (i = 0; i < nthreads; i++) {
>>  		snprintf(workers[i].dir, sizeof(workers[i].dir),
>> -			 MNTPOINT "/thread%i", i + 1);
>> +			 MNTPOINT "/" THREADS_SUBDIR "/thread%i", i + 1);
>>  		SAFE_MKDIR(workers[i].dir, 0700);
>>  	}
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> If you don't mind, I suggest to merge slightly changed patch.
>
> Kind regards,
> Petr
>
> +++ testcases/kernel/fs/fs_fill/fs_fill.c
> @@ -18,6 +18,7 @@
>  #include "tst_test.h"
>  
>  #define MNTPOINT "mntpoint"
> +#define THREADS_DIR MNTPOINT "/subdir"
>  
>  static volatile int run;
>  static unsigned int nthreads;
> @@ -99,9 +100,15 @@ static void setup(void)
>  	nthreads = tst_ncpus_conf() + 2;
>  	workers = SAFE_MALLOC(sizeof(struct worker) * nthreads);
>  
> +	/*
> +	 * Avoid creating the thread directories in the root of the filesystem
> +	 * to not hit the root entries limit on a FAT16 filesystem.
> +	 */
> +	SAFE_MKDIR(THREADS_DIR, 0700);
> +
>  	for (i = 0; i < nthreads; i++) {
>  		snprintf(workers[i].dir, sizeof(workers[i].dir),
> -			 MNTPOINT "/thread%i", i + 1);
> +			 THREADS_DIR "/thread%i", i + 1);
>  		SAFE_MKDIR(workers[i].dir, 0700);
>  	}

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

FWIW I think you could have merged this after a few days or even
straight away.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
