Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D06BE7543E
	for <ltp@archiver.kernel.org>; Tue,  3 Oct 2023 09:52:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 855D23CDD62
	for <ltp@archiver.kernel.org>; Tue,  3 Oct 2023 11:52:01 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 28FFB3CBF23
 for <ltp@lists.linux.it>; Tue,  3 Oct 2023 11:51:50 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 374A51000365
 for <ltp@lists.linux.it>; Tue,  3 Oct 2023 11:51:49 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 31AB61F45B
 for <ltp@lists.linux.it>; Tue,  3 Oct 2023 09:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696326709;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8q7Pam1GyA9i9xAEAZF9GVgbTRcBxCiLunHm2lLpjwQ=;
 b=BnLqo6+aBfcGmgu4Ps/TaCQu0V1n5exZbs5iNZ53CXB/X6O/BlVr9gijXE02Y7lefTXv+J
 MMOa01XZU4/8PCol7k0j2RXT6ru/womdMuYDTGOkFmeSJslMeVEtz4YkPtJRZB51vCKhLX
 a065s5Bt7dxpojCgshy4QZGSydfmpBY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696326709;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8q7Pam1GyA9i9xAEAZF9GVgbTRcBxCiLunHm2lLpjwQ=;
 b=Hr8+vpVKlD8LL/6SmBBDdmkYe0fY0Owiq7tNtxJ3xMadcXi9m3ot6nwdvoDMws5l1ZiOYF
 NVkNJ0VVLU0ciWDQ==
Received: from g78 (rpalethorpe.udp.ovpn2.prg.suse.de [10.100.204.110])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id D1BD92C142;
 Tue,  3 Oct 2023 09:51:48 +0000 (UTC)
References: <20230901144433.2526-1-chrubis@suse.cz> <87cyxx2tna.fsf@suse.de>
 <ZRqk47qqtquBw3XQ@yuki>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 03 Oct 2023 09:18:01 +0100
Organization: Linux Private Site
In-reply-to: <ZRqk47qqtquBw3XQ@yuki>
Message-ID: <874jj82fuz.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sched: add sched sysctl sanity test
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

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> > +static void rt_runtime_us_einval(void)
>> > +{
>> > +	TST_EXP_FAIL(write(runtime_fd, "-2", 2), EINVAL,
>> > +	             "echo -2 > "RT_RUNTIME_US);
>> > +}
>> 
>> I would happily add my tags to the test except that as a general
>> principal, I don't want to deal with tests that fail if an unexpected
>> error number is returned.
>> 
>> Unless something can be done (e.g. with meta-data), so that TST_EXP_FAIL
>> and similar can be reduced to a TCONF when the wrong errno is returned.
>> 
>> For instance, this would allow running the tests with a seccomp BPF
>> profile, LSM, CGroup or /proc bind mount that blocks the write.
>> 
>> Or you could just seperate the tests I guess. Then the reset can be
>> checked while skipping the errno checks.
>
> Hmm, so I guess that with LSM we are able to open these files R/W but we
> can stil get EPERM from the write() right?

Sorry, I thought there was an LSM hook in read, but AFAICT there is
not. It's possible that another hook get's called
(e.g. security_inode_getattr), but it's not immediately clear to me.

This still leaves seccomp bpf, FUSE, kernel module, etc. whatever is
mounted at /proc doesn't have to be the original file system. Container
runtimes do something with /proc to filter it. This situation seems to
get more complicated each year.

> I'm reluctant to add wildcard
> TCONF on any errno, but I guess that we can add a TST_EXP_FAIL macro
> version that would have one errno for PASS and one errno for TCONF.

I'm leaning increasingly towards partitioning the test, so that bits can
be filtered out somehow. Then people can focus on the bits they really
care about.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
