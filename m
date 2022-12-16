Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD09C4332F
	for <ltp@archiver.kernel.org>; Fri, 16 Dec 2022 10:36:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A6BEE3CBC4C
	for <ltp@archiver.kernel.org>; Fri, 16 Dec 2022 11:36:49 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4A22A3C913E
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 11:36:40 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 97F0D600D18
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 11:36:39 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 909115CCAB;
 Fri, 16 Dec 2022 10:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1671186998;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=diOXd7G2pAjBplRolkW5xd/dwO0uHy9HkbS5ctMrm7I=;
 b=v1uBXN8f0PhWNkiHJNv+4USs7clk3Wpvmq4H/F0Rtsp5x85NDCtuzGTu4HaS2AKkJwP2Bh
 NGt6NiD2yY4FZZlAWaCXaNe0acIupZa9CAMgY8ih3142S+bunk2oO6qvQ9tMqOeFCnxQt7
 rDEvyM8GhUEbM4zALL8M+HJlq1RtdJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1671186998;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=diOXd7G2pAjBplRolkW5xd/dwO0uHy9HkbS5ctMrm7I=;
 b=vGVXiyE2vpxoNesTJyDALiNAFWrI1olJmdhuZS7G5T7ZJ7aAyVlV5a3RhU1KvR75kfa8L7
 8Gw5gq97f9gsWbDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5CE4B138FD;
 Fri, 16 Dec 2022 10:36:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 76XyFDZKnGOHcAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 16 Dec 2022 10:36:38 +0000
Date: Fri, 16 Dec 2022 11:36:36 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <Y5xKNPLwIRTzXC8t@pevik>
References: <1671166923-2173-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1671166923-2173-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <Y5w0DtP9yETeJl2T@pevik>
 <ac355bae-ae8f-811d-ff18-24534cf94031@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ac355bae-ae8f-811d-ff18-24534cf94031@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/7] cgroup_regression_test.sh: Remove obselte
 test_6
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu,

> >> test_6 is a test case when kernel version is less than 3.0.
> >> Since the oldest supported kernel version is 3.0, so the case
> >> is useless. Remove it.

It would be worth to note here:
CONFIG_CGROUP_NS is not supported in kernel >= 3.0

Because tests have comments with kernel versions which are a bit misleading
(all comments have 2.6.x).

Also note typo on the subject: obselte => obsolete.

> >> Also rename test9 to test6. modify TST_CNT.
> > I wonder if rename is a good thing to do, because it complicates git history.
> > I'd keep old names.
> > Also in the past we didn't rename, e.g. in 1c44244849 ("getuid, getgid, setuid,
> > setgid: fixed 16-bit versions")
> > testcases/kernel/syscalls/getuid/getuid02.c was renamed to
> > testcases/kernel/syscalls/geteuid/geteuid02.c to match the new test coverage,
> > but testcases/kernel/syscalls/getuid/getuid03.c stayed the same (not renamed to
> > testcases/kernel/syscalls/getuid/getuid02.c, which was then free).

> > Or maybe better example: testcases/kernel/syscalls/kill/kill01.c got deleted
> > in eafdc5dd83 ("syscalls/kill01: Remove it"), but test names did not shift.

> I can understand,  but I used the same renamed way because we did this 
> case for test_5 in 2019[1].

> [1]https://github.com/linux-test-project/ltp/commit/9b8f841ced26cd0d19dc9a007d0efd941929abde

OK, due TST_CNT it must be shifted, I'm sorry.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
