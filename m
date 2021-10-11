Return-Path: <SRS0=Ux39=O7=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C77C433EF
	for <ltp@archiver.kernel.org>; Mon, 11 Oct 2021 10:09:05 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E2F660E78
	for <ltp@archiver.kernel.org>; Mon, 11 Oct 2021 10:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4E2F660E78
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C42E3C0BBE
	for <ltp@archiver.kernel.org>; Mon, 11 Oct 2021 12:08:59 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B5A73C00A6
 for <ltp@lists.linux.it>; Mon, 11 Oct 2021 12:08:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B4DBE60132F
 for <ltp@lists.linux.it>; Mon, 11 Oct 2021 12:08:43 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 11E8C2004D
 for <ltp@lists.linux.it>; Mon, 11 Oct 2021 10:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1633946923;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GZWimQ4H8YO9W2TsCBWY6AIc84vVZSap7+FgGMK92ps=;
 b=NPgkmuSyxiEWPdfhpVscEU6Sd1IjNGNghzS0zflZteJk28tJ63bg0uw1GmmI9ZWtNS4Fg3
 57JpdwDWk8MpTLmARZdwjObtZA8DjURZ9dCL+z3JbvuMk36bS/BRzIJTk6GUfb41NfXCXE
 RI1TI+rYZ5Gee9Gdcz8FMZvgEU3aeog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1633946923;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GZWimQ4H8YO9W2TsCBWY6AIc84vVZSap7+FgGMK92ps=;
 b=bmZDT/xIHndvdkQQzSIGSmwgJ6WIrdY5V9uAMZUdOz/GngJuXm5wmDiDiU7m5eLn4ILDue
 2ytFjyzUe2IT+DAw==
Received: from g78 (unknown [10.163.24.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id CFA69A3B83;
 Mon, 11 Oct 2021 10:08:42 +0000 (UTC)
References: <20210909140911.44EC9A4308@relay2.suse.de>
 <20210916123248.4974-1-rpalethorpe@suse.com> <YV//+xhzYHN5349v@yuki>
User-agent: mu4e 1.6.5; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 11 Oct 2021 10:22:56 +0100
In-reply-to: <YV//+xhzYHN5349v@yuki>
Message-ID: <87o87van6e.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] kernel/irq: Add irqbalance01
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

Hello Cyril,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> +	/* Read the CPU affinity masks for each IRQ. The first CPU is in the
>> +	 * right most (least significant) bit. See bitmap_string() in the kernel
>> +	 * (%*pb)
>> +	 */
>> +	for (row = 0; row < nr_irqs; row++) {
>> +		sprintf(path, "/proc/irq/%u/smp_affinity", irq_ids[row]);
>> +		buf = read_proc_file(path);
>> +		c = buf;
>> +		col = 0;
>> +
>> +		while (*c != '\0')
>> +			c++;
>
> A minor nit, we alredy know the lenght, but we do not return it from the
> read_proc_file() we may as well change this so taht the read_proc_file
> returns both buffer pointer and the size. E.g. add size_t *len parameter
> to the read_proc_file() and set it if it's not NULL.

+1

>
> Other than that the parsing looks good now.
>
>> +static void evidence_of_change(void)
>> +{
>> +	size_t row, col, changed = 0;
>> +
>> +	for (row = 0; row < nr_irqs; row++) {
>> +		for (col = 0; col < nr_cpus; col++) {
>> +			if (!irq_stats[row * nr_cpus + col])
>> +				continue;
>> +
>> +			if (irq_affinity[row * nr_cpus + col] == ALLOW)
>> +				continue;
>> +
>> +			changed++;
>> +		}
>> +	}
>> +
>> +	tst_res(changed ? TPASS : TFAIL,
>> +		"Heuristic: Detected %zu irq-cpu pairs have been dissallowed",
>> +		changed);
>> +}
>
> I'm still unusure about this part though.
>
> The test fails on my workstation where the IRQs are nicely distributed
> by the hardware/BIOS.

You don't need irqbalance then :-p

The original bug this is intened to avoid was caused by the irqbalance
deamon silently failing.

>
> Maybe we should check if IRQs are distributed somehow evenly and PASS
> the test if that is the case as well.

My plan was to have a second heuristic based on the IRQ
distribution. However the intention was to make detection more sensitve
to bad setups. I think what you are suggesting is the opposite. So that
users can blindly run the test and let it figure out if it is
appropriate for the hardware.

>
> In my case there is 27 IRQs, 18 of them have non-zero counters and there
> is 12 CPUs. For active IRQs that gives 18/12 = 1.5 IRQ per CPU and there
> are 7 CPUs that handle 2 IRQs, 4 CPUs that handle 1 IRQ and 1 CPU that
> doesn't handle anything. I wonder if we can figure out some kind of
> heuristic, but I guess that in the end it wouldn't be worth the
> effort.

I general I think it is best to write tests which figure out if they are
in the right environment. This makes all our lives easier. The problem
with this test in particular is the number of assumptions we have to
make about what a good IRQ distirbution looks like.

IRQs are (usually) evenly distributed for "performance". However not all
IRQs are equal, you might get better performance through an uneven
distribution. Especially if you only care about the performance some
tasks and not others. Also there are some reasons to isolate some CPUs
from IRQs regardless of performance.

Having said that we can probably find a heuristic for what a very bad
setup looks like i.e. (almost) all NIC IRQs on one CPU when there are
30+ CPUs and multiple NICs. That is one CPU is totally saturated with
IRQs from different NICs. This is a bit speculative so I'd like some
feedback from testing/community before putting effort into that.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
