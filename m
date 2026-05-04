Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710E6CD3427
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 16:00:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1895A3E620F
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 18:00:04 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 107013E5C80
 for <ltp@lists.linux.it>; Mon,  4 May 2026 17:59:45 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8B587140012C
 for <ltp@lists.linux.it>; Mon,  4 May 2026 17:59:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E2FFA6B3C4;
 Mon,  4 May 2026 15:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777910384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eYQH0qAOCBonWyN5qLDxeoHJ/6IMwdJEOsBWZDsleow=;
 b=05hGymPqr/Jd+rUzGsF62EY/Pbc3bUX/H9gYnqfWGw0oFjalPxFiE50iUPIgTq5meH/AD7
 EPzkxC7FGVVQ6EiftIMEqOtwNn+Orb9FHFsDi2JMGADIrmhWKsnsV4vmmcDcA8ErdKRc6C
 ODOx7jC0iub2KkzVAj9RiJMrhfm0e4Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777910384;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eYQH0qAOCBonWyN5qLDxeoHJ/6IMwdJEOsBWZDsleow=;
 b=1mI0iV0Qbzeeo1vD9C1GPk48Pbgrf1TVTwpJRyPizLlruOoGICRaKCO0lSw6HTF3Koo7gx
 b1IxnURUbl4QeeBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777910384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eYQH0qAOCBonWyN5qLDxeoHJ/6IMwdJEOsBWZDsleow=;
 b=05hGymPqr/Jd+rUzGsF62EY/Pbc3bUX/H9gYnqfWGw0oFjalPxFiE50iUPIgTq5meH/AD7
 EPzkxC7FGVVQ6EiftIMEqOtwNn+Orb9FHFsDi2JMGADIrmhWKsnsV4vmmcDcA8ErdKRc6C
 ODOx7jC0iub2KkzVAj9RiJMrhfm0e4Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777910384;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eYQH0qAOCBonWyN5qLDxeoHJ/6IMwdJEOsBWZDsleow=;
 b=1mI0iV0Qbzeeo1vD9C1GPk48Pbgrf1TVTwpJRyPizLlruOoGICRaKCO0lSw6HTF3Koo7gx
 b1IxnURUbl4QeeBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C484C593A3;
 Mon,  4 May 2026 15:59:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YCQdLnDC+GmXNQAAD6G6ig
 (envelope-from <rbranco@suse.de>); Mon, 04 May 2026 15:59:44 +0000
Message-ID: <bc75c487-59db-47a8-a2f3-db860919b35b@suse.de>
Date: Mon, 4 May 2026 17:59:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>
References: <20260411092452.211540-1-rbranco@suse.de>
 <20260415080623.164440-1-rbranco@suse.de> <afjANI7jr23hP4IJ@yuki.lan>
From: Ricardo Branco <rbranco@suse.de>
In-Reply-To: <afjANI7jr23hP4IJ@yuki.lan>
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] userfaultfd: Use two-step handshake to probe
 features
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



On 5/4/26 5:50 PM, Cyril Hrubis wrote:
>> +	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, false);
>> +	uffdio_api.api = UFFD_API;
>> +	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
>> +	if (!(uffdio_api.features & UFFD_FEATURE_PAGEFAULT_FLAG_WP))
>> +		tst_brk(TCONF, "UFFD_FEATURE_PAGEFAULT_FLAG_WP not supported");
>> +	SAFE_CLOSE(uffd);
> I do not get why are we adding this code when we do the same just a few
> lines below. Shouldn't just this suffice?

That's why the comment is needed because it isn't obvious.

We need to do the 2 step handshake, first with uffdio_api.features set 
to zero,
then again with the desired features.

>> index 5b1252c35..e1b3c2f6f 100644
>> --- a/testcases/kernel/syscalls/userfaultfd/userfaultfd06.c
>> +++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd06.c
>> @@ -97,18 +97,25 @@ static void run(void)
>>   
>>   	poison_fault_seen = 0;
>>   	sigbus_seen = 0;
>> -	set_pages();
>>   
>> +	/*
>> +	 * Two-step handshake to check if feature is available
>> +	 */
>>   	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, false);
>> +	uffdio_api.api = UFFD_API;
>> +	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
>> +	if (!(uffdio_api.features & UFFD_FEATURE_POISON))
>> +		tst_brk(TCONF, "UFFD_FEATURE_POISON not supported");
>> +	SAFE_CLOSE(uffd);
>>   
>> +	set_pages();
>> +
>> +	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, false);
>>   	uffdio_api.api = UFFD_API;
>>   	uffdio_api.features = UFFD_FEATURE_POISON;
>>
>>   	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
>>   
>> -	if (!(uffdio_api.features & UFFD_FEATURE_POISON))
>> -		tst_brk(TCONF, "UFFD_FEATURE_POISON not supported");
>> -
> This does not seem to make any sense. The code already checks for the
> feature, or do I miss something?

Context: https://github.com/linux-test-project/ltp/issues/1289

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
