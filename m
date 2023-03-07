Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B01E2C678D5
	for <ltp@archiver.kernel.org>; Tue,  7 Mar 2023 10:17:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B2CA3CD9D8
	for <ltp@archiver.kernel.org>; Tue,  7 Mar 2023 11:17:18 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C9123C30A8
 for <ltp@lists.linux.it>; Tue,  7 Mar 2023 11:17:07 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2C81F200C2E
 for <ltp@lists.linux.it>; Tue,  7 Mar 2023 11:17:06 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 88087219FD;
 Tue,  7 Mar 2023 10:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1678184226;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V1kuxM/jdy+Bo6R6ARYH7Vk4r9A7VoevkUzYk+8sx3M=;
 b=Qp2DkPP3tI7h6dgnDrFVPgUsaEhL69xkrXoO3OuHZm/FG8BrZnIv7SIAaIzWa+Y26Lb5gq
 LGyFThD1001a3QuT3m/5jak/UzTf/u2YYE+0rLk8D4npLnFStrGRG5189wY1iIaBwXLyJ6
 Q7dvfOomH8/3bHxxLw+DNN2oHeWg3qE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1678184226;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V1kuxM/jdy+Bo6R6ARYH7Vk4r9A7VoevkUzYk+8sx3M=;
 b=mQrnGGLUyYPGvyIdzc0SVysFEtXFsfw8InLgwhYih8RfsMgLiAUFwaqR3a1B3e/sJRL93I
 xztyGTxc0RWJl4AA==
Received: from g78 (unknown [10.100.204.110])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 842E42C141;
 Tue,  7 Mar 2023 10:17:05 +0000 (UTC)
References: <87bkl67xxa.fsf@suse.de>
 <1678169395-4584-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <877cvt7xtq.fsf@suse.de>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: rpalethorpe@suse.de
Date: Tue, 07 Mar 2023 10:16:42 +0000
Organization: Linux Private Site
In-reply-to: <877cvt7xtq.fsf@suse.de>
Message-ID: <87356g9881.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] containers/utsname04: don't use TST_EXP_EQ_LI
 for tst_clone
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

Merged, thanks!

Richard Palethorpe <rpalethorpe@suse.de> writes:

> Hello,
>
> Yang Xu <xuyang2018.jy@fujitsu.com> writes:
>
>> For old kernel(below 5.3) that doesn't support clone3, tst_clone returns
>> -2 instead of -1. So we can't use TST_EXP_EQ_LI api.
>>
>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>
> Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>
>
> Thanks, I suppose this could be avoided in the future by hinting that
> the return type is more complex than the usual for clone
>
> typedef tst_clone_return_t pid_t;
>
> enum tst_clone_error {
>   TST_CLONE_ERROR = -2,
>   TST_CLONE3_ERROR = -1
> };
>
> Possibly we could force a cast somehow? Otherwise it's just a hint.
>
>> ---
>>  testcases/kernel/containers/utsname/utsname04.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/testcases/kernel/containers/utsname/utsname04.c b/testcases/kernel/containers/utsname/utsname04.c
>> index e8d636d0d..61cc066d8 100644
>> --- a/testcases/kernel/containers/utsname/utsname04.c
>> +++ b/testcases/kernel/containers/utsname/utsname04.c
>> @@ -29,7 +29,13 @@ static void run(void)
>>  	SAFE_SETRESUID(pw->pw_uid, pw->pw_uid, pw->pw_uid);
>>  
>>  	if (!str_op || !strcmp(str_op, "clone")) {
>> -		TST_EXP_EQ_LI(tst_clone(&cargs), -1);
>> +		TEST(tst_clone(&cargs));
>> +		if (TST_RET == -1)
>> +			tst_res(TPASS, "clone3() fails as expected");
>> +		else if (TST_RET == -2)
>> +			tst_res(TPASS, "clone() fails as expected");
>> +		else
>> +			tst_res(TFAIL, "tst_clone returns %ld", TST_RET);
>>  		TST_EXP_PASS(errno == EPERM);
>>  	} else {
>>  		if (!SAFE_FORK()) {
>> -- 
>> 2.39.1
>
>
> -- 
> Thank you,
> Richard.


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
