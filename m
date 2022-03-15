Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A30C433EF
	for <ltp@archiver.kernel.org>; Tue, 15 Mar 2022 16:05:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AAEBF3C9350
	for <ltp@archiver.kernel.org>; Tue, 15 Mar 2022 17:05:03 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A94023C54F7
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 17:04:53 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CE961140013E
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 17:04:52 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 2A9DB210ED
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 16:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1647360292;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BoKNMAAZCNzrru7hu6sFL9YJ/aTQ3o+bfHQav6ZGUyo=;
 b=p8H4PEpQZSTqg/FiPIp2QNfzpnyBwVWjHcP6vz3NGe7VOCoYzPS0sCdj6gYkH383qIa4UK
 gqRwA1mN0O+888B0uc2znE8U8UKQOnn4jHzMCava3IdSd1iZg+uYti5ITtcuc/l4rKCJ/j
 GM+9ROK3OKgbbEBw0Nl2sunMCcMuO4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1647360292;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BoKNMAAZCNzrru7hu6sFL9YJ/aTQ3o+bfHQav6ZGUyo=;
 b=kBjCcpJF8U0ozSNRiB7paeQP5R4Khyn5GAz58x4epqpOqmjCnuLL9hLIuuHqxWo2zPAK34
 Ynuo3PelY2GSBQDQ==
Received: from g78 (unknown [10.163.24.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id EBC26A3B83;
 Tue, 15 Mar 2022 16:04:51 +0000 (UTC)
References: <20220309164954.23751-1-mdoucha@suse.cz>
 <20220309164954.23751-2-mdoucha@suse.cz> <87o8275lbi.fsf@suse.de>
 <f7972d11-de50-d9bc-3abc-dcba53dc3936@suse.cz>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 15 Mar 2022 15:44:36 +0000
In-reply-to: <f7972d11-de50-d9bc-3abc-dcba53dc3936@suse.cz>
Message-ID: <87fsnj5hi9.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] Add test for CVE 2021-38198
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

Martin Doucha <mdoucha@suse.cz> writes:

> On 15. 03. 22 15:19, Richard Palethorpe wrote:
>> Hi Martin,
>> 
>> Martin Doucha <mdoucha@suse.cz> writes:
>>> +	if (isdigit(buf[0])) {
>>> +		sscanf(buf, "%d", &ret);
>> 
>> checkpatch complains that the return value is not checked. Also it wants
>> you to use tst_parse_int.
>
> if (isdigit()) above ensures that the return value does not matter. But
> I'll change it to tst_parse_int() in v2.
>
>>> +static void disable_tdp(void)
>>> +{
>>> +	if (!access(TDP_MMU_SYSFILE, F_OK)) {
>>> +		/* FIXME: Is this sufficient to disable TDP? */
>> 
>> What happens if this doesn't work and TDP is enabled? I seem to have it
>> enabled and the test still passes even if I comment out the call
>> to disable_tdp.
>> 
>> I'm wondering whether it will be easy to tell if a test failure is due
>> to TDP or if it can result in silent false negatives?
>
> AFAIK, the kernel bug was fixed before the tdp_mmu sysfile was
> introduced.

Ah I see TDP is very new https://lwn.net/Articles/832835/

> So somebody will have to revert the fix and run the test on
> custom kernel to answer that question.

Did you reproduce the bug?

I could try this next week.

>
> The bug is not reproducible with TDP enabled.
>
>>> +	.save_restore = (const char *const []) {
>>> +		"?/sys/module/kvm/parameters/tdp_mmu",
>> 
>> This needs updating to use struct tst_path_val.
>
> Yes, the patch was sent before the .save_restore structure was changed.


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
