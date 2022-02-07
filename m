Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FDC5C433F5
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 11:14:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B7053C9AC7
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 12:14:48 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4A08A3C06E5
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 12:14:38 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6B96520032C
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 12:14:37 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id B860F210F6
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 11:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1644232476;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IcpiQBaQBsKoWDnLrzmQnKzrmG4EToI8016r/5zJdz8=;
 b=WokjVC8wAZsV6857ojqrWwAYo7rGXF7KVWm9b3RwjHZ1hRGHGAvOOYELsJ9PwvyNswdgJn
 TBHhvIyIHk0kyIYFeLcTob/50koc8OP0hpHlerP/PWNwMI3ZXPlkquMBiajr2Z+4TQLyPB
 B1DzjIMpW8+QcPLg66MQBiHhbsYRe7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1644232476;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IcpiQBaQBsKoWDnLrzmQnKzrmG4EToI8016r/5zJdz8=;
 b=e0Ms4ceIrTWHHPBDFTJSqKq/kXfMBOM+I9XFVz5ZGWF2zdrl3eMBSGzzLYXSINDsp6W88i
 Ig4G/TzzGM1ujNBw==
Received: from g78 (rpalethorpe.udp.ovpn1.nue.suse.de [10.163.24.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 7368BA3B8C;
 Mon,  7 Feb 2022 11:14:36 +0000 (UTC)
References: <20220203081820.29521-1-rpalethorpe@suse.com>
 <20220203081820.29521-7-rpalethorpe@suse.com> <YfveE3QtrfAQvTac@yuki>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 07 Feb 2022 09:46:52 +0000
In-reply-to: <YfveE3QtrfAQvTac@yuki>
Message-ID: <87tudbvsh2.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 5/5] memcontrol03: Copy from kselftest
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

>> +
>> +static void alloc_anon_in_child(const struct tst_cgroup_group *const cg,
>> +				const size_t size, const int expect_oom)
>> +{
>> +	int status;
>> +	const pid_t pid = SAFE_FORK();
>> +
>> +	if (!pid) {
>> +		SAFE_CGROUP_PRINTF(cg, "cgroup.procs", "%d", getpid());
>> +
>> +		tst_res(TINFO, "%d in %s: Allocating anon: %"PRIdPTR,
>> +		getpid(), tst_cgroup_group_name(cg), size);
>> +		alloc_anon(size);
>> +		exit(0);
>> +	}
>> +
>> +	SAFE_WAITPID(pid, &status, 0);
>> +
>> +	if (!expect_oom) {
>> +		if (WIFEXITED(status) && WEXITSTATUS(status) == 0)
>> +			return;
>> +	} else {
>> +		if (WIFSIGNALED(status) && WTERMSIG(status) == SIGKILL)
>> +			return;
>> +	}
>
> Maybe we should print TPASS in these as well to complement the TFAIL
> below. Also the negation in !expect_oom is kind of useless since we
> handle both cases anyways.

Can't hurt I guess.

>
>> +	tst_res(TFAIL,
>> +		"Expected child %d to %s, but instead %s",
>> +		pid,
>> +		expect_oom ? "be killed" : "exit(0)",
>> +		tst_strstatus(status));
>> +}
>> +
>> +static void alloc_pagecache_in_child(const struct tst_cgroup_group *const cg,
>> +				     const size_t size)
>> +{
>> +	const pid_t pid = SAFE_FORK();
>> +
>> +	if (pid) {
>> +		TST_CHECKPOINT_WAIT(CHILD_IDLE);
>> +		return;
>> +	}
>> +
>> +	SAFE_CGROUP_PRINTF(cg, "cgroup.procs", "%d", getpid());
>> +
>> +	tst_res(TINFO, "PID %d in %s: Allocating pagecache: %"PRIdPTR,
>> +		getpid(), tst_cgroup_group_name(cg), size);
>> +	alloc_pagecache(fd, size);
>> +
>> +	TST_CHECKPOINT_WAKE(CHILD_IDLE);
>> +	TST_CHECKPOINT_WAIT(TEST_DONE);
>> +	exit(0);
>> +}
>> +
>> +static void test_memcg_min(void)
>> +{
>> +	long c[4];
>> +	unsigned int i;
>> +	size_t attempts;
>> +
>> +	fd = SAFE_OPEN(TMPDIR"/tmpfile", O_RDWR | O_CREAT, 0600);
>> +	trunk_cg[A] = tst_cgroup_group_mk(tst_cgroup, "trunk_A");
>> +
>> +	SAFE_CGROUP_SCANF(trunk_cg[A], "memory.min", "%ld", c);
>> +	if (c[0]) {
>> +		tst_brk(TCONF,
>> +			"memory.min already set to %ld on parent group", c[0]);
>> +	}
>> +
>> +	if (!TST_CGROUP_VER_IS_V1(trunk_cg[A], "memory")) {
>> +		SAFE_CGROUP_PRINT(trunk_cg[A], "cgroup.subtree_control",
>> +				  "+memory");
>> +	}
>> +	SAFE_CGROUP_PRINT(trunk_cg[A], "memory.max", "200M");
>> +	SAFE_CGROUP_PRINT(trunk_cg[A], "memory.swap.max", "0");
>> +
>> +	trunk_cg[B] = tst_cgroup_group_mk(trunk_cg[A], "trunk_B");
>> +	if (!TST_CGROUP_VER_IS_V1(trunk_cg[A], "memory")) {
>> +		SAFE_CGROUP_PRINT(trunk_cg[B], "cgroup.subtree_control",
>> +				  "+memory");
>> +	}
>
> Don't we require V2 for the whole test anyways?

+1

>
> Also I think I asked if this si really needed in v1, don't we enable the
> required subgroups in group_mk() anyways?

No, we only automatically add the controllers to subtree_control in the
test's group. Note that this is not the same as enabling the
controller. The controller becomes active as soon as it is added to the
root node's subtree control. Adding it to subtree_control means that the
direct children get their own allotments in addition to sharing the
parent's. I assume that for some tests we don't want that, we want the
children to fully compete over the parent's resources.

Also subtree_control can effect whether a group is a threaded
domain... We could perhaps add a variant of `tst_cgroup_group_mk` which
enables subtrees by default. I just don't want it to be hidden that we
are enabling it.


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
