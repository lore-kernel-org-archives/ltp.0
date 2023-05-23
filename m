Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF68C7EE23
	for <ltp@archiver.kernel.org>; Tue, 23 May 2023 12:18:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7C7A23CD358
	for <ltp@archiver.kernel.org>; Tue, 23 May 2023 14:18:35 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 89E233C04A5
 for <ltp@lists.linux.it>; Tue, 23 May 2023 14:18:25 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 33AEB1400255
 for <ltp@lists.linux.it>; Tue, 23 May 2023 14:18:23 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6229322A29;
 Tue, 23 May 2023 12:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1684844303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q0YTzAjIduj+TP2W9JL4vbLMrQpfkyFQgdH4H+TnYr4=;
 b=dfTc8UqhpEYGjLCfkR0LvPhHKjVG0TeJ9GZ582ILzH1bbUDjCc+0tte6xbzvXIvzcKPJgh
 VDJrgCCIfe4gBfVlqCCGcL8POAF3pBTIp28HrUYQYMnD/NHtkhoLUFflbe/23a/NSWnDuU
 DUiXUimF82kobms2g/+z6Jf7OQFh2E8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1684844303;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q0YTzAjIduj+TP2W9JL4vbLMrQpfkyFQgdH4H+TnYr4=;
 b=2R+BszUbEBFxnzhNsrGcYSJiCyZt3RiwM9Wlnm09xQZdEc4p5AO5FK+XoxdbUoMwOo0AOn
 8L638xL0qd6QQ5Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4C36513588;
 Tue, 23 May 2023 12:18:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id sdCxEQ+vbGSxJQAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Tue, 23 May 2023 12:18:23 +0000
Message-ID: <f51db601-9f0c-cf1d-dc29-b80b478ca44c@suse.cz>
Date: Tue, 23 May 2023 14:18:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: Cyril Hrubis <chrubis@suse.cz>
References: <20230517153642.26919-1-mdoucha@suse.cz>
 <20230517153642.26919-5-mdoucha@suse.cz> <ZGyt9l8lKwBk1z7d@yuki>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <ZGyt9l8lKwBk1z7d@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/7] KVM: Add async communication helper functions
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
Cc: ltp@lists.linux.it, Nicolai Stange <nstange@suse.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 23. 05. 23 14:13, Cyril Hrubis wrote:
> Hi!
>> +int tst_kvm_wait_guest(struct tst_kvm_instance *inst, int timeout)
>> +{
>> +	volatile struct tst_kvm_result *result = inst->result;
>> +	int32_t res;
>> +	time_t start = time(NULL);
>> +
>> +	while ((res = result->result) != KVM_TSYNC) {
>> +		if (res == KVM_TEXIT)
>> +			return res;
>> +
>> +		if (timeout >= 0 && start + timeout <= time(NULL))
>> +			return -1;
> 
> Can we please avoid using wall clock time for timeouts? That is broken
> by desing, since the time is continually adjusted by ntp daemon these
> days and can jump back and forth...

Yes, I'll change it to tst_clock_gettime() in v2. But I'll wait a bit 
for other patches to get merged before resubmitting.

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
