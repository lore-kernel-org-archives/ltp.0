Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49134C4332F
	for <ltp@archiver.kernel.org>; Fri, 16 Dec 2022 09:02:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D2C773CBC2B
	for <ltp@archiver.kernel.org>; Fri, 16 Dec 2022 10:02:26 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 37C6F3CBC0A
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 10:02:15 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 38C941A00F25
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 10:02:14 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EB8F65CB39;
 Fri, 16 Dec 2022 09:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1671181333;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4FGPAOS08kg9D4yh3j+XFHF5/gLvSkVHDW719SKFwcI=;
 b=vNE8fidbL2NmwqaDzSVCPB/b34vr4Fn3QWAkhTzjnnZAImP8AGYqgXVBNTLmYq0sSZey4M
 ZsL7PqB8vH92zMYD7blSSfK0NGnrTR8fvrMGzte39opqH0DXSEmcar0E8118cmBC5522rG
 coY7/ym4y9hLz+p/PHGmw15w8xJYjj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1671181333;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4FGPAOS08kg9D4yh3j+XFHF5/gLvSkVHDW719SKFwcI=;
 b=FXvUXyE5F2szP7QcNYaLx3uKgxcQ9Kv4Te0hWcXK5zZfXAN/DnnpCGwwvCSOcUp2nDC4rB
 V9vAd+pyVIC99+BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B7BEA138FD;
 Fri, 16 Dec 2022 09:02:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EBB6KRU0nGN7PwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 16 Dec 2022 09:02:13 +0000
Date: Fri, 16 Dec 2022 10:02:06 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <Y5w0DtP9yETeJl2T@pevik>
References: <1671166923-2173-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1671166923-2173-3-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1671166923-2173-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> test_6 is a test case when kernel version is less than 3.0.
> Since the oldest supported kernel version is 3.0, so the case
> is useless. Remove it.

Acked-by: Petr Vorel <pvorel@suse.cz>

> Also rename test9 to test6. modify TST_CNT.
I wonder if rename is a good thing to do, because it complicates git history.
I'd keep old names.
Also in the past we didn't rename, e.g. in 1c44244849 ("getuid, getgid, setuid,
setgid: fixed 16-bit versions")
testcases/kernel/syscalls/getuid/getuid02.c was renamed to
testcases/kernel/syscalls/geteuid/geteuid02.c to match the new test coverage,
but testcases/kernel/syscalls/getuid/getuid03.c stayed the same (not renamed to
testcases/kernel/syscalls/getuid/getuid02.c, which was then free).

Or maybe better example: testcases/kernel/syscalls/kill/kill01.c got deleted
in eafdc5dd83 ("syscalls/kill01: Remove it"), but test names did not shift.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
