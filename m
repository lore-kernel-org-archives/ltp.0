Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 219A9C4332F
	for <ltp@archiver.kernel.org>; Thu, 15 Dec 2022 10:01:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DCD363CBCBF
	for <ltp@archiver.kernel.org>; Thu, 15 Dec 2022 11:01:17 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BB3E63CBC7D
 for <ltp@lists.linux.it>; Thu, 15 Dec 2022 11:01:07 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D57C8200AF3
 for <ltp@lists.linux.it>; Thu, 15 Dec 2022 11:01:06 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id BABE521C7A;
 Thu, 15 Dec 2022 10:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1671098464;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TFtnWPHs16wXPLE/26f9hpEMqBTqeL1slH6KxK8iQe0=;
 b=WsyRoG1004UaFJNQeuzLjO4xEPyq5VNrsoqKNjX0sVpM163AggKGAPpYDDFdOaBOR5GH84
 DiBzbQ9P9QskPVU2OJhtKIbckWVHcEMLij8D3kD4pww2A3kNH7STp8Q1Jwe8UKDkox4BI7
 0nGkmxTrQ8GW7VCzTeuFEUtz2jh4y20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1671098464;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TFtnWPHs16wXPLE/26f9hpEMqBTqeL1slH6KxK8iQe0=;
 b=teHdqXm2HH93qn3DDW7DC2CA85DRDigoJmVrPBmK0OaMBYnjKNfxX1Q55a4bw2fhZXsD4T
 OHb/EPWkdkhi9DCw==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 8A95D2C141;
 Thu, 15 Dec 2022 10:01:04 +0000 (UTC)
References: <1670901258-1995-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <87y1rbr2e9.fsf@suse.de>
 <ba8c6bd3-1a74-ec37-4ab5-f299975bd823@fujitsu.com>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Date: Thu, 15 Dec 2022 09:58:18 +0000
Organization: Linux Private Site
In-reply-to: <ba8c6bd3-1a74-ec37-4ab5-f299975bd823@fujitsu.com>
Message-ID: <87y1r9oujj.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/statx01: Add exit condition when
 parsing /proc/self/mountinfo
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

"xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com> writes:

> Hi Richard
>
>
>> Hello,
>> 
>> Yang Xu <xuyang2018.jy@fujitsu.com> writes:
>> 
>>> When using user filesystem such as overlayfs, the current parsing way can't
>>> work well.
>>>
>>> 63 66 8:3 / /sysroot rw,relatime - ext4 /dev/sda3 rw,seclabel
>>> 43 66 8:3 /ostree/deploy/rhivos/var /var rw,relatime shared:3 - ext4 /dev/sda3 rw,seclabel
>>>
>>> So add the exit condition for statx.mnt_id check so it can skip the
>>> underflying filesystem and parse the correct user fileystem's mnt_id.
>>>
>>> Fixes: #1001
>>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>>> ---
>>> v1-v2: change the fail message
>>>   testcases/kernel/syscalls/statx/statx01.c | 7 ++++---
>>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/testcases/kernel/syscalls/statx/statx01.c b/testcases/kernel/syscalls/statx/statx01.c
>>> index 60b50958b..e9677475a 100644
>>> --- a/testcases/kernel/syscalls/statx/statx01.c
>>> +++ b/testcases/kernel/syscalls/statx/statx01.c
>>> @@ -68,7 +68,8 @@ static void test_mnt_id(struct statx *buf)
>>>   		if (sscanf(line, "%"SCNu64" %*d %d:%d", &mnt_id, &line_mjr, &line_mnr) != 3)
>>>   			continue;
>>>   
>>> -		if (line_mjr == buf->stx_dev_major && line_mnr == buf->stx_dev_minor)
>>> +		if (line_mjr == buf->stx_dev_major && line_mnr == buf->stx_dev_minor &&
>>> +				mnt_id == buf->stx_mnt_id)
>>>   			break;
>>>   	}
>>>   
>>> @@ -80,8 +81,8 @@ static void test_mnt_id(struct statx *buf)
>>>   			mnt_id);
>>>   	else
>>>   		tst_res(TFAIL,
>>> -			"statx.stx_mnt_id(%"PRIu64") is different from mount_id(%"PRIu64") in /proc/self/mountinfo",
>>> -			(uint64_t)buf->stx_mnt_id, mnt_id);
>>> +			"statx.stx_mnt_id(%"PRIu64") doesn't exist in /proc/self/mountinfo",
>>> +			(uint64_t)buf->stx_mnt_id);
>> 
>> The mnt_id may exist in mountinfo, but not the triple (mnt_id,
>> dev_major, dev_minor). So really we should print all three here (unless
>> we already display that somewhere else).
>> 
>
> Yes, so how about the following changes:
>
> diff --git a/testcases/kernel/syscalls/statx/statx01.c 
> b/testcases/kernel/syscalls/statx/statx01.c
> index 60b50958b..8f3b01b32 100644
> --- a/testcases/kernel/syscalls/statx/statx01.c
> +++ b/testcases/kernel/syscalls/statx/statx01.c
> @@ -53,7 +53,7 @@ static void test_mnt_id(struct statx *buf)
>   {
>          FILE *file;
>          char line[PATH_MAX];
> -       int pid;
> +       int pid, flag = 0;
>          unsigned int line_mjr, line_mnr;
>          uint64_t mnt_id;
>
> @@ -68,20 +68,26 @@ static void test_mnt_id(struct statx *buf)
>                  if (sscanf(line, "%"SCNu64" %*d %d:%d", &mnt_id, 
> &line_mjr, &line_mnr) != 3)
>                          continue;
>
> -               if (line_mjr == buf->stx_dev_major && line_mnr == 
> buf->stx_dev_minor)
> -                       break;
> +               if (line_mjr == buf->stx_dev_major && line_mnr == 
> buf->stx_dev_minor) {
> +                       if (buf->stx_mnt_id == mnt_id) {
> +                               flag = 1;
> +                               break
> +                       }
> +                       tst_res(TINFO, "%s doesn't contain (%"PRIu64") 
> %d:%d",
> +                               line, (uint64_t)buf->stx_mnt_id, 
> buf->stx_dev_major, buf->stx_dev_minor);
> +               }
>          }
>
>          SAFE_FCLOSE(file);
>
> -       if (buf->stx_mnt_id == mnt_id)
> +       if (flag)
>                  tst_res(TPASS,
>                          "statx.stx_mnt_id equals to mount_id(%"PRIu64") 
> in /proc/self/mountinfo",
>                          mnt_id);
>          else
>                  tst_res(TFAIL,
> -                       "statx.stx_mnt_id(%"PRIu64") is different from 
> mount_id(%"PRIu64") in /proc/self/mountinfo",
> -                       (uint64_t)buf->stx_mnt_id, mnt_id);
> +                       "statx.stx_mnt_id(%"PRIu64") doesn't exist in 
> /proc/self/mountinfo",
> +                       (uint64_t)buf->stx_mnt_id);

Looks good, (except for the line wrap). With that

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

>
>          pid = getpid();
>          snprintf(line, PATH_MAX, "/proc/%d/fdinfo/%d", pid, file_fd);
>
> Best Regards
> Yang Xu
>>>   
>>>   	pid = getpid();
>>>   	snprintf(line, PATH_MAX, "/proc/%d/fdinfo/%d", pid, file_fd);
>>> -- 
>>> 2.27.0
>> 
>> 


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
