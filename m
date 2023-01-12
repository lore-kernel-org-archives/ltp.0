Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC13C61DB3
	for <ltp@archiver.kernel.org>; Thu, 12 Jan 2023 10:33:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE6663CCA69
	for <ltp@archiver.kernel.org>; Thu, 12 Jan 2023 11:33:30 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 01F593CB53A
 for <ltp@lists.linux.it>; Thu, 12 Jan 2023 11:33:21 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4E286600BAC
 for <ltp@lists.linux.it>; Thu, 12 Jan 2023 11:33:20 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 7360F580F
 for <ltp@lists.linux.it>; Thu, 12 Jan 2023 10:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1673519600;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=16mwbMyoSgL2rdFDy39lHrEYLnMX3ZxSn9t5u1BQIGY=;
 b=AzqVCTOdcwH/IpXiXNufdBaQBPCFqcu/BKhtRg3ALXMuURNkd9Iv9fKkk18CzLIEeBvUuE
 tDxdpcAZUqyho2C8c+diDPr9m+VDtY8K3Z1d2d/AMrPP33PWfsjKW+T1gyGutbISelQwTK
 3HVo32FaA+TJDTZ9Aiqcj0wWJaPdRM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1673519600;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=16mwbMyoSgL2rdFDy39lHrEYLnMX3ZxSn9t5u1BQIGY=;
 b=gSiukkBN3EpjCkhh/OkGKcPLjCGDxv+gq/RitC2FKhjyR5beYUQSd4M4QTez1iJAiNRdEJ
 kFzf/T15Z1H7vXCA==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 43F532C141;
 Thu, 12 Jan 2023 10:33:20 +0000 (UTC)
References: <20230110183555.6915-1-pvorel@suse.cz>
 <2068101.vSGb3dL7Gk@localhost>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Avinesh Kumar <akumar@suse.de>
Date: Thu, 12 Jan 2023 10:33:13 +0000
Organization: Linux Private Site
In-reply-to: <2068101.vSGb3dL7Gk@localhost>
Message-ID: <87tu0whwk0.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] tst_tmpdir: Add 'LTP_' prefix
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

Avinesh Kumar <akumar@suse.de> writes:

> Hi,
>
> Reviewed-by: Avinesh Kumar <akumar@suse.de>
>
> On Wednesday, January 11, 2023 12:05:55 AM IST Petr Vorel wrote:
>> Follow the approach of the shell API:
>> 
>>     TST_TMPDIR=$(mktemp -d "$TMPDIR/LTP_$TST_ID.XXXXXXXXXX")
>> 
>> Prefix helps to see directories mounted by LTP.
>> 
>> Signed-off-by: Petr Vorel <pvorel@suse.cz>
>> ---
>>  lib/tst_tmpdir.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
>> index d1419a1a40..b73b5c66f7 100644
>> --- a/lib/tst_tmpdir.c
>> +++ b/lib/tst_tmpdir.c
>> @@ -269,7 +269,7 @@ void tst_tmpdir(void)
>>  	 * use our default TEMPDIR.
>>  	 */
>>  	env_tmpdir = tst_get_tmpdir_root();
>> -	snprintf(template, PATH_MAX, "%s/%.3sXXXXXX", env_tmpdir, TCID);
>> +	snprintf(template, PATH_MAX, "%s/LTP_%.3sXXXXXX", env_tmpdir, TCID);
>>  
>>  	/* Make the temporary directory in one shot using mkdtemp. */
>>  	if (mkdtemp(template) == NULL) {
>> 
>
> Regards,
> Avinesh


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
