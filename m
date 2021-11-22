Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D99C433EF
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 09:50:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 88AC53C8D9C
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 10:50:18 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 130EE3C06B2
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 10:50:07 +0100 (CET)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8C0941000AE9
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 10:50:06 +0100 (CET)
Received: from [192.168.178.40] (unknown [188.195.115.12])
 by mail.jv-coder.de (Postfix) with ESMTPSA id CAF969F6A0;
 Mon, 22 Nov 2021 09:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1637574601; bh=3KmcqPops+qf1w79BAWwFqu0Vlnokt3Op5ubEiZ/mh8=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=EFfvov8UT/YuXWqoMe8dwVrSKoM2w3fRdAext6Y7V+02Z9Hj/glys71PM2G/JFzin
 5vpCPYonz+9FnegIdhOYor64K78AMBEJpDZ4zRqvevjhXo2oHYAQSbzwNm0e0YgPGO
 QQ/ee5M0ESYJ4iM9jc3hin2is6DppY983RWqmFz8=
Message-ID: <107071aa-80e3-1cb5-ec50-f5a2a83027c1@jv-coder.de>
Date: Mon, 22 Nov 2021 10:50:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>
References: <20211122072601.4096577-1-lkml@jv-coder.de> <YZtlxQZn06aplsvw@yuki>
From: Joerg Vehlow <lkml@jv-coder.de>
In-Reply-To: <YZtlxQZn06aplsvw@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/4] posix/conformance/interfaces/fork/7-1: Fix
 test
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
Cc: Joerg Vehlow <joerg.vehlow@aox-tech.de>, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cytil,

On 11/22/2021 10:41 AM, Cyril Hrubis wrote:
> Hi!
>> -static void read_catalog(nl_catd cat, char *who)
>> +static int read_catalog(nl_catd cat)
>>   {
>> +	static const char *notfound = "not found";
> Why static here?
Right, could be dropped. It doesn't really make a difference, but 
doesn't hurt either.
Remove it if you like.
>
>>   	char *msg = NULL;
>>   	int i, j;
>>   
>> -#if VERBOSE > 0
>> -	output("Reading the message catalog from %s...\n", who);
>> -#endif
>> -
>> -	errno = 0;
>> -
>> -	for (i = 1; i <= 2; i++) {
>> +	for (i = 1; i <= 3; i++) {
> Actually this change makes the test fail for me since there is no set 3.
>
> Have you modified this to check if the test fails and then forget to
> change it back?
Yes sorry, that is exactly what happened...
>
>
> Other than these two the changes looks good to me. If you agreen I can
> fix the two small issues before pushing it to the repo.
Perfect, thanks

Joerg

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
