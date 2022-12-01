Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24CAAC43217
	for <ltp@archiver.kernel.org>; Thu,  1 Dec 2022 09:55:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DACA43CC4A9
	for <ltp@archiver.kernel.org>; Thu,  1 Dec 2022 10:55:44 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BBF323CC450
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 10:55:35 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D2E286024E7
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 10:55:34 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 23C211FD72;
 Thu,  1 Dec 2022 09:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1669888534;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ef4kmlIO+LA5lo0X11B2ZRoOmckLnqR0YVEKDBUfgdc=;
 b=kMfThYCTuFkuH9wrOaUqpLygTmX64RWcFB+9S4YQ7vV0kZYSo9PQD/IQGEAmSgR4N4p74t
 FwmC4G7pQoAmaMbfeUXUGjJJtbH8ZxmHHUqdjqTfQe3mhid4TO5Rpzau+AZpHJ++TaCV2S
 QJGCdAH9xcBXKwHeWOwgfQAvDLTvkcM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1669888534;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ef4kmlIO+LA5lo0X11B2ZRoOmckLnqR0YVEKDBUfgdc=;
 b=C8XWro7FGhjGFOpt3iEmjSv5AB7JybaTgR4fGGkC6JZInt8tMDSbbfN/RG/RZMsoJzqXaA
 VLjCduf/IgLum7DQ==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id EDDB42C141;
 Thu,  1 Dec 2022 09:55:33 +0000 (UTC)
References: <1669375875-1943-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1669375875-1943-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <875yexua2w.fsf@suse.de>
 <1ac38da9-21a1-2c37-2c08-593c0b337927@fujitsu.com>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Date: Thu, 01 Dec 2022 09:48:52 +0000
Organization: Linux Private Site
In-reply-to: <1ac38da9-21a1-2c37-2c08-593c0b337927@fujitsu.com>
Message-ID: <87tu2fih2i.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 2/2] syscalls/mount03: Add MS_STRICTATIME
 subcase
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


"xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com> writes:

> Hi Richard
>
>> Hello,
>> 
>> Yang Xu <xuyang2018.jy@fujitsu.com> writes:
>> 
>>> This case should check MS_NOATIME and MS_RELATIME are
>>> not inside stat f_flags[1] .
>>>
>>> [1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d0adde57
>>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>>> ---
>>>   testcases/kernel/syscalls/mount/mount03.c | 16 ++++++++++++++++
>>>   1 file changed, 16 insertions(+)
>>>
>>> diff --git a/testcases/kernel/syscalls/mount/mount03.c b/testcases/kernel/syscalls/mount/mount03.c
>>> index 31a858c35..60f9963da 100644
>>> --- a/testcases/kernel/syscalls/mount/mount03.c
>>> +++ b/testcases/kernel/syscalls/mount/mount03.c
>>> @@ -19,6 +19,7 @@
>>>    * - MS_NOSUID - ignore suid and sgid bits
>>>    * - MS_NOATIME - do not update access times
>>>    * - MS_NODIRATIME - only update access_time for directory instead of all types
>>> + * - MS_STRICTATIME - always update access times
>>>    */
>>>   
>>>   #include <stdio.h>
>>> @@ -164,6 +165,11 @@ static void test_nodiratime(void)
>>>   	test_file_dir_noatime(1, 0);
>>>   }
>>>   
>>> +static void test_strictatime(void)
>>> +{
>>> +	test_file_dir_noatime(1, 1);
>>> +}
>>> +
>>>   #define FLAG_DESC(x) .flag = x, .flag2 = x, .desc = #x
>>>   #define FLAG_DESC2(x) .flag2 = x, .desc = #x
>>>   static struct tcase {
>>> @@ -179,6 +185,7 @@ static struct tcase {
>>>   	{FLAG_DESC(MS_NOSUID), test_nosuid},
>>>   	{FLAG_DESC(MS_NOATIME), test_noatime},
>>>   	{FLAG_DESC(MS_NODIRATIME), test_nodiratime},
>>> +	{FLAG_DESC(MS_STRICTATIME), test_strictatime}
>>>   };
>>>   
>>>   static void setup(void)
>>> @@ -215,6 +222,15 @@ static void run(unsigned int n)
>>>   		tc->test();
>>>   
>>>   	SAFE_STATFS(MNTPOINT, &stfs);
>>> +	if (tc->flag == MS_STRICTATIME) {
>>> +		if (stfs.f_flags & (MS_NOATIME | MS_RELATIME))
>>> +			tst_res(TFAIL, "statfs() gets the incorrect mount flag");
>>> +		else
>>> +			tst_res(TPASS, "statfs() gets the correct mount flag");
>>> +		cleanup();
>>> +		return;
>>> +	}
>> 
>> We don't need this branch.
>> 
>>> +
>>>   	if (stfs.f_flags & tc->flag2)
>> 
>> Could change this to something like
>> 
>> if (stfs.f_flags & tc->flag2
>>     && !(stfs.f_flags & MS_STRICTATIME && stfs.f_flags & (MS_NOATIME | MS_RELATIME))
>
> I try it, but case reports fail because stfs.f_flags doesn't contain 
> MS_STRICTATIME flag.  Sorry, I guess my commit message only mentioned

Ah, sorry, it should be something like:

if (stfs.f_flags & tc->flag2
     && (tc->flag2 != MS_STRICTATIME || !(stfs.f_flags & MS_STRICTATIME
     && stfs.f_flags & (MS_NOATIME | MS_RELATIME)))

but actually this is getting kind of messy now. So I'll merge it as you
sent it. Thanks!

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
