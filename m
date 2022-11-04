Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12321C4332F
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 15:33:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 271193CAFC8
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 16:33:47 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 14C623C0135
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 16:33:30 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BD9891A00CCD
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 16:33:28 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7A4B11F8DB;
 Fri,  4 Nov 2022 15:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1667576008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WZNH1kEen5/oS9MmYwGE1TZ70/yMCgxe3RvL6r8r+2s=;
 b=bYxvUUWzj5b6T1KejcZcPgkNomJ3Ha0JRgCbMqKmItMhRGrnV3R6sOAXPLrF0j/X1x1Hyl
 ZbpsoypQddVwoWA4WDdh0B0J1F5+AC3o3wOJWcLIcn/4galSxzG2CJxznYxcgF6n4hUOGS
 Tde8ZkXiuuarHmle+DzqyCF0O4Sfk8A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1667576008;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WZNH1kEen5/oS9MmYwGE1TZ70/yMCgxe3RvL6r8r+2s=;
 b=C7u+fzbLD1gMsDBVkplLnZZflKGlDiGGmVapuraxIviw9eA/hrDyHjYGpTbVyrAaRmXK6u
 d+iLIJdgimysYeDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 657CB13216;
 Fri,  4 Nov 2022 15:33:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0x70F8gwZWMNVQAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 04 Nov 2022 15:33:28 +0000
Message-ID: <b0091247-3c27-49f5-351a-6ba06e0cfc24@suse.cz>
Date: Fri, 4 Nov 2022 16:33:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>,
 Andrea Cervesato <andrea.cervesato@suse.com>
References: <20221104092411.5446-1-andrea.cervesato@suse.com>
 <Y2UeAGj58zSd47Rt@yuki>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <Y2UeAGj58zSd47Rt@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Correctly handle user time in setitimer01
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

On 04. 11. 22 15:13, Cyril Hrubis wrote:
> Hi!
>> Since ITIMER_VIRTUAL and ITIMER_PROF are counting down in user time, we
>> need to take in consideration CLOCK_MONOTONIC_COARSE resolution. This is
>> requested by the syscall, since it's considering context switch from
>> user to kernel mode by using a higher clock resolution.
> 
> What exactly do you mean by this? I do not think that there is "user"
> and "kernel" time, just different in-kernel timers/counters with
> different precisions.
> 
> As ITIMER_VIRTUAL and ITIMER_PROF counts CPU time the precision would be
> the same as the COARSE clocks which depends on jiffies and on the
> compile time option CONFIG_HZ. That is because in the scheduller the CPU
> time is quantized into chunks based on CONFIG_HZ.
> 
> And the ITIMER_REAL runs on hrtimers which would be the same precision
> as CLOCK_REALTIME or CLOCK_MONOTONIC.

The kernel mangles the new timer values for ITIMER_PROF and 
ITIMER_VIRTUAL. It'll always add one extra jiffy to the actual timer 
value you've passed. For ITIMER_REAL, the timer value gets set as is.

 From set_cpu_itimer() in kernel/time/itimer.c:

if (oval || nval) {
	if (nval > 0)
		nval += TICK_NSEC;
	set_process_cpu_timer(tsk, clock_id, &nval, &oval);
}

nval = new timer value passed to setitimer() converted to nanoseconds
TICK_NSEC = 1 jiffy in nanoseconds

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
