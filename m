Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A3ECDB482
	for <ltp@archiver.kernel.org>; Thu, 12 Oct 2023 09:13:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8563C3CD404
	for <ltp@archiver.kernel.org>; Thu, 12 Oct 2023 11:13:01 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8CEA33C888A
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 11:12:51 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 55780600442
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 11:12:50 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 41091216DA;
 Thu, 12 Oct 2023 09:12:49 +0000 (UTC)
Received: from g78 (unknown [10.163.25.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id DBA682C92F;
 Thu, 12 Oct 2023 09:12:48 +0000 (UTC)
References: <20231004121149.30849-1-rpalethorpe@suse.com>
 <20231005090034.GA102472@pevik>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 12 Oct 2023 10:09:17 +0100
Organization: Linux Private Site
In-reply-to: <20231005090034.GA102472@pevik>
Message-ID: <8734ygyzjl.fsf@suse.de>
MIME-Version: 1.0
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de; dkim=none; dmarc=none;
 spf=softfail (smtp-out1.suse.de: 149.44.160.134 is neither permitted nor
 denied by domain of rpalethorpe@suse.de) smtp.mailfrom=rpalethorpe@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [0.79 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[rpalethorpe@suse.de]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 NEURAL_HAM_LONG(-3.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 REPLYTO_ADDR_EQ_FROM(0.00)[]; DMARC_NA(0.20)[suse.de];
 R_SPF_SOFTFAIL(0.60)[~all:c]; HAS_ORG_HEADER(0.00)[];
 TO_MATCH_ENVRCPT_SOME(0.00)[]; VIOLATED_DIRECT_SPF(3.50)[];
 MX_GOOD(-0.01)[]; NEURAL_HAM_SHORT(-1.00)[-1.000];
 RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
 RCVD_NO_TLS_LAST(0.10)[]; FROM_EQ_ENVFROM(0.00)[];
 R_DKIM_NA(0.20)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: 41091216DA
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] memcg: Account for pages in the per-cpu cache
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
Cc: Martin Doucha <mdoucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Merged, thanks!

As discussed on bz, it may be better to drain the stocks
instead. However there is no direct way to do it.

My idea would be to find the batch size emperically, but it requires a
rewrite of the test IMO. So let's see if this works for now.

Petr Vorel <pvorel@suse.cz> writes:

> Hi Richie,
>
> [ Cc Li ]
>
>> PAGESIZES is one greater than the batch size for charging pages from
>> the per CPU cache. So with MEM_TO_ALLOC=2*PAGESIZES we have two pages
>> that are below the threshold for being charged.
>
>> Sometimes something triggers a flush and the pages get charged to the
>> global counter anyway and the test passes. We have seen cases where
>> the test times out waiting for this to happen.
>
>> So this patch sets a lower bound to allow those cases to pass. It'll
>> probably speed the test up as well.
>
> LGTM.
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> Kind regards,
> Petr
>
>> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
>> ---
>>  .../controllers/memcg/functional/memcg_subgroup_charge.sh    | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>
>> diff --git a/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh b/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh
>> index 9bcc01258..3b7311422 100755
>> --- a/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh
>> +++ b/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh
>> @@ -33,8 +33,8 @@ test_subgroup()
>>  	fi
>
>>  	echo $MEMCG_PROCESS_PID > tasks
>> -	signal_memcg_process $MEM_TO_ALLOC
>> -	check_mem_stat "rss" $MEM_TO_ALLOC
>> +	signal_memcg_process $MIN_CHARGED
>> +	check_mem_stat "rss" $MIN_CHARGED $MEM_TO_ALLOC
>
>>  	cd subgroup
>>  	echo $MEMCG_PROCESS_PID > tasks
>> @@ -66,5 +66,6 @@ test3()
>
>>  # Allocate memory bigger than per-cpu kernel memory
>>  MEM_TO_ALLOC=$((PAGESIZES * 2))
>> +MIN_CHARGED=$((2 * (PAGESIZES - 1)))
>
>>  tst_run


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
