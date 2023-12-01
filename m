Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 523BBC4167B
	for <ltp@archiver.kernel.org>; Fri,  1 Dec 2023 20:06:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4DBE93CF621
	for <ltp@archiver.kernel.org>; Fri,  1 Dec 2023 21:06:30 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 719323CD933
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 21:06:18 +0100 (CET)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2496360250E
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 21:06:15 +0100 (CET)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 3C2715C0067;
 Fri,  1 Dec 2023 15:06:14 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Fri, 01 Dec 2023 15:06:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
 cc:cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm2; t=1701461174; x=1701547574; bh=3M
 pnxnJ9p0dPBD2wAv8t1shHRqUJ2V2PQWkP1HkspCo=; b=E09av+jX+JsoZNWG27
 8IQprqDZgcVWWb/SyxbR19/47u4cYGJp1dAwqp4Q7vE2ohrZflLFqvhqYAYwiEHA
 tY5FuvnStXDC0SdAfgT6iWTllZ6ZeKwwliQS8NyJNpqPSiA6sv8w/WIVpoZtdYdf
 +fDpjhd5yVKF99ttFaxU6NuzaXnb4UXz+XIcL96Mdunv2/BzJB1VM+V9ez7EsePp
 j8/Y1O8yFUup965slU/hPMnLsizGEhyKPBtzgg1pkhYqtOmWOLPg0BU0hezqNj3t
 zPmWXSZHUHuFvTdEGWcbVtfAtCMmKn7tuOtZivvuow6rT+Z7W9V1syV7rfTBoQ+j
 AarA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1701461174; x=1701547574; bh=3MpnxnJ9p0dPB
 D2wAv8t1shHRqUJ2V2PQWkP1HkspCo=; b=mtlVJD/TKcPDDgVo4BuvO7DKBD17G
 OucQlT2mkYx4S8w87TMsD1dBh83o9JSapTEemex+BDWaIhA3lDURbfAgBoi2rEOS
 pCLbcTjMXyyHH85iDg1Js1HCdcbRSStvEWkpeiJSAds9jlAnILqnjFFOHrSfE4UK
 9xaU/J6+h29ENY1ev7noYBdrIqDAUR3P9N+SiR7WHXUAlNaG2WF0hgm9FqyzxSj+
 hM208Lct5/2Y9tmuWJf1JwO/+u8bgsJinCl6UJeoZrEZ9K6GpW3hwEPCdMRJsN5F
 RhV6a9TMuYQWbWj/++rui+MavMtfbmGY1S+0/3BymmApqai7+OOeGcaCg==
X-ME-Sender: <xms:tTxqZVq2bL6Z6Vmkm1ll23zM9xNb5XWn0nv-SGpBnSmvRHu86uTyjA>
 <xme:tTxqZXqcDC9QSuEtshLJSqdjrUFg8pqWQhb7zZAIOJ1XG8zR0ZEcLdULbAmIGw0Rc
 1_T9yAtBu68L1HecVc>
X-ME-Received: <xmr:tTxqZSOUzGBJRE_bUNpd7JcOcGXn0YWeWXevKSABvfWvyO1R2IVhdZh9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiledgudeffecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpehffgfhvfevufffjgfkgggtsehttdertddtredtnecuhfhrohhmpefuthgv
 fhgrnhcutfhovghstghhuceoshhhrhesuggvvhhkvghrnhgvlhdrihhoqeenucggtffrrg
 htthgvrhhnpeegtedvkeegleefffeuueevjeeijefhjeelhfefheeiheeiveehveevhfej
 tdfhieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenuc
 evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehshhhrsegu
 vghvkhgvrhhnvghlrdhioh
X-ME-Proxy: <xmx:tTxqZQ7xWTNF4Q58JEUMrMbnSSqFH74PmUZ2HjUwdDqhgAtz7TWNAQ>
 <xmx:tTxqZU77CUX9mutzLA71wP4UgjCx30gp_jnLfTWgYrGhqWQ16RntcQ>
 <xmx:tTxqZYiw1i25RQeqo39xGOHtIHtbkkIsUEuKXTghR8L2bmybkkzglg>
 <xmx:tjxqZf05L6c-Rmxn0yJVqi1BSRdQvRFHLsJsIoFgiyalsRRLWPSqUg>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Dec 2023 15:06:11 -0500 (EST)
References: <20231127174517.2369593-1-shr@devkernel.io>
 <20231128074626.GA298624@pevik>
User-agent: mu4e 1.10.3; emacs 29.1
From: Stefan Roesch <shr@devkernel.io>
To: Petr Vorel <pvorel@suse.cz>
Date: Fri, 01 Dec 2023 12:02:22 -0800
In-reply-to: <20231128074626.GA298624@pevik>
Message-ID: <878r6d6633.fsf@devkernel.io>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mem: disable KSM smart scan for ksm tests
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
Cc: linux-mm@kvack.org, kernel-team@fb.com, oliver.sang@intel.com,
 ltp@lists.linux.it, david@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


Petr Vorel <pvorel@suse.cz> writes:

> Hi Stefan,
>
>> This disables the "smart scan" KSM feature to make sure that the volatile
>> count remains at 0.
>
>> Signed-off-by: Stefan Roesch <devkernel.io>
> nit: you forgot 'shr@'
> Signed-off-by: Stefan Roesch <shr@devkernel.io>
>

Thanks, will be fixed with the next version.

>> Reported-by: kernel test robot <oliver.sang@intel.com>
>> Closes: https://lore.kernel.org/oe-lkp/202311161132.13d8ce5a-oliver.sang@intel.com
>> ---
>>  testcases/kernel/mem/lib/mem.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>
>> diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
>> index fbfeef026..ef274a3ac 100644
>> --- a/testcases/kernel/mem/lib/mem.c
>> +++ b/testcases/kernel/mem/lib/mem.c
>> @@ -454,6 +454,9 @@ void create_same_memory(int size, int num, int unit)
>>  	       {'a', size*MB}, {'a', size*MB}, {'d', size*MB}, {'d', size*MB},
>>  	};
>
>> +  /* Disable smart scan for correct volatile counts. */
>> +  SAFE_FILE_PRINTF(PATH_KSM "smart_scan", "0");
> NOTE, this fails on the systems without /sys/kernel/mm/ksm/smart_scan:
>
> mem.c:458: TBROK: Failed to open FILE '/sys/kernel/mm/ksm/smart_scan' for writing: EACCES (13)
>
> NOTE, we normally handle the setup like this in test setup function.
>
> But new API has .save_restore which is more robust for tasks  like this.
> It's already used in ksm01.c, you need just to add this line:
> 	{"/sys/kernel/mm/ksm/smart_scan", "0", TST_SR_SKIP},
>

I'll add it with the next version

> (instead of both SAFE_FILE_PRINTF)
>
> See:
> https://github.com/linux-test-project/ltp/wiki/C-Test-API#127-saving--restoring-procsys-values
>
> I wonder if ksm01.c is the only ksm test which needs to disable this.
>

Other tests will also need it. They also use the create_same_memory()
function.

> also nit: there is a wrong indent (spaces instead of tabs), please be consistent
> with the file content.
>
> NOTE: while this fixes problem on 6.7.0-rc1-2.g86e46c2-default (openSUSE),
> it does not fixes other problem on 6.5.10 on Debian (16 errors like these below):
>
> mem.c:252: TFAIL: pages_shared is not 2 but 5038.
> mem.c:252: TFAIL: pages_sharing is not 98302 but 593629.
> mem.c:252: TFAIL: pages_volatile is not 0 but 391.
> mem.c:252: TFAIL: pages_unshared is not 0 but 149157.
>
> I have no idea if this is a real bug which needs to be fixed or test false
> positive to be fixed, or whether the problem has already been fixed in newer
> kernels.
>

This is a different problem. "Smart scan was introduced with 6.7"

>> +
>>  	ps = sysconf(_SC_PAGE_SIZE);
>>  	pages = MB / ps;
>
>> @@ -526,6 +529,7 @@ void create_same_memory(int size, int num, int unit)
>
>>  	tst_res(TINFO, "stop KSM.");
>>  	SAFE_FILE_PRINTF(PATH_KSM "run", "0");
>> +  SAFE_FILE_PRINTF(PATH_KSM "smart_scan", "1");
> nit: Again, wrong indent. You could have seen it also in the generated patch.
>
> Kind regards,
> Petr
>
>>  	final_group_check(0, 0, 0, 0, 0, 0, size * pages * num);
>
>>  	while (waitpid(-1, &status, 0) > 0)
>
>> base-commit: 8c89ef3d451087ed6e18750bd5eedd10e5ab3d2e

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
