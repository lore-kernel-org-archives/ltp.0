Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CEBC4332F
	for <ltp@archiver.kernel.org>; Fri, 14 Oct 2022 15:49:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3DEEB3CAF67
	for <ltp@archiver.kernel.org>; Fri, 14 Oct 2022 17:49:41 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 430AC3CADA7
 for <ltp@lists.linux.it>; Fri, 14 Oct 2022 17:49:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 89AB1600736
 for <ltp@lists.linux.it>; Fri, 14 Oct 2022 17:49:29 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E7FBA1F8B5;
 Fri, 14 Oct 2022 15:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1665762568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jKbgiTXmfRflJ4VPWSlNnquM8Dugdv6RbnrIC25SkUQ=;
 b=lwsDYK4Wiu/ObAzdpoZZ7acHHtdg2TqCzR5nUix9AdHeoYQk0uGidCNfLkrnQYhtzNbF1G
 RcWU7r6pATuwBvcenlAbe19ArG5s3s1J3Z+T7n3oRgWn4ORh4PkyHMQXfIhGBst+rDR9Lk
 zyAPVj2+QgibNv0k+h5am9yOzXkGMQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1665762568;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jKbgiTXmfRflJ4VPWSlNnquM8Dugdv6RbnrIC25SkUQ=;
 b=BouELkwrFkdQifyAONzk+tWAYyRKdrrEtNvOsTHifvMeZx2hnPQ0djajNiMf+OCOqQ/TZy
 rx7TohATQcOsjaCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D1C4113451;
 Fri, 14 Oct 2022 15:49:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Xn81MgiFSWM1egAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 14 Oct 2022 15:49:28 +0000
Message-ID: <275830ad-6830-c9b1-3573-3c97b1d1f21a@suse.cz>
Date: Fri, 14 Oct 2022 17:49:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
To: Petr Vorel <pvorel@suse.cz>
References: <20221013154935.20461-1-mdoucha@suse.cz>
 <20221013154935.20461-2-mdoucha@suse.cz> <Y0iE3bfMBC56Hi8r@pevik>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <Y0iE3bfMBC56Hi8r@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/4] fanotify14: Print human-readable test case
 flags
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

On 13. 10. 22 23:36, Petr Vorel wrote:
> Hi Martin,
> 
>> It's hard to tell which test case is failing from the current fanotify14
>> output. Print test case flags to make failure analysis easier.
> 
>> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
>> ---
>>   .../kernel/syscalls/fanotify/fanotify14.c     | 194 ++++++++++--------
>>   1 file changed, 108 insertions(+), 86 deletions(-)
> 
>> diff --git a/testcases/kernel/syscalls/fanotify/fanotify14.c b/testcases/kernel/syscalls/fanotify/fanotify14.c
>> index 594259ccf..ee42aaf68 100644
>> --- a/testcases/kernel/syscalls/fanotify/fanotify14.c
>> +++ b/testcases/kernel/syscalls/fanotify/fanotify14.c
>> @@ -38,6 +38,8 @@
>>   #define INODE_EVENTS (FAN_ATTRIB | FAN_CREATE | FAN_DELETE | FAN_MOVE | \
>>   		      FAN_DELETE_SELF | FAN_MOVE_SELF)
> 
>> +#define FLAGS_DESC(flags) (flags), (#flags)
> +1 for add ing description. But macro like this gets false positive in make
> check:
> 
> fanotify14.c:41: ERROR: Macros with complex values should be enclosed in parentheses
> 
> Also quite recently, in dbb9db6ec ("syscalls/fanotify09: Make test case
> definitions more readable") was single test migrated to use
> .foo = value, .bar = value struct setup. This is about source code readability,
> you aim for test output readability, IMHO both is important.

I can't use that approach here because I'm using the macro to initialize 
3 different pairs of attributes in the same structure. What I could do 
is change the flags/desc pairs into a nested struct of
{unsigned long, const char *} and the macro would change to
#define FLAGS_DESC(flags) {(flags), (#flags)}

>> @@ -155,8 +169,14 @@ static void do_test(unsigned int number)
>>   		return;
>>   	}
> 
>> -	TST_EXP_FD_OR_FAIL(fanotify_fd = fanotify_init(tc->init_flags, O_RDONLY),
>> -			   !tc->mask && tc->expected_errno ? tc->expected_errno : 0);
> TST_EXP_FD_OR_FAIL was added only to be used by fanotify tests.
> What's wrong with it?

I got a headache trying to figure out when this call was expected to 
pass and when it was expected to fail. The more verbose version below is 
far easier to understand.

>> +	if (!tc->mask && tc->expected_errno) {
>> +		TST_EXP_FAIL(fanotify_init(tc->init_flags, O_RDONLY),
>> +			tc->expected_errno);
>> +	} else {
>> +		TST_EXP_FD(fanotify_init(tc->init_flags, O_RDONLY));
>> +	}
>> +
>> +	fanotify_fd = TST_RET;

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
