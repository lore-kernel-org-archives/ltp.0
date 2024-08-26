Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A7CCC5321E
	for <ltp@archiver.kernel.org>; Mon, 26 Aug 2024 11:51:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 551743D2745
	for <ltp@archiver.kernel.org>; Mon, 26 Aug 2024 13:51:52 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 906EA3CAF97
 for <ltp@lists.linux.it>; Mon, 26 Aug 2024 13:51:36 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B7C891400FB6
 for <ltp@lists.linux.it>; Mon, 26 Aug 2024 13:51:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B5B111F854;
 Mon, 26 Aug 2024 11:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1724673093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZBqFjnYK/zcPmL18fj3LAwoiKNXvhLLcwXbD2WiVZIU=;
 b=mUINxik0n4LWpPhTQ9DJUxd6Yiug1OcOkuu6s+w7YcyDe2FOFsCAgG+VtiTPZ1n43j+hOS
 4O2ao+R4RGKLYV9aUTiWNPXyTffa/Dg6Y8P6TcN8XIloCvUOePAToVm/pof3LlxXMd9XWM
 AfULZD1mTYmOwHBK+H46JAcIQUb8CXo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1724673093;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZBqFjnYK/zcPmL18fj3LAwoiKNXvhLLcwXbD2WiVZIU=;
 b=t4XMZ/wAZfk/p3BcIa4NwbrFV5nlPbMY8/G/iFT3Mw68fiPjZw602Qw7XFH/P0lIIASq6e
 u3k/Ckx2WJh47tCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mUINxik0;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="t4XMZ/wA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1724673093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZBqFjnYK/zcPmL18fj3LAwoiKNXvhLLcwXbD2WiVZIU=;
 b=mUINxik0n4LWpPhTQ9DJUxd6Yiug1OcOkuu6s+w7YcyDe2FOFsCAgG+VtiTPZ1n43j+hOS
 4O2ao+R4RGKLYV9aUTiWNPXyTffa/Dg6Y8P6TcN8XIloCvUOePAToVm/pof3LlxXMd9XWM
 AfULZD1mTYmOwHBK+H46JAcIQUb8CXo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1724673093;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZBqFjnYK/zcPmL18fj3LAwoiKNXvhLLcwXbD2WiVZIU=;
 b=t4XMZ/wAZfk/p3BcIa4NwbrFV5nlPbMY8/G/iFT3Mw68fiPjZw602Qw7XFH/P0lIIASq6e
 u3k/Ckx2WJh47tCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A36041398D;
 Mon, 26 Aug 2024 11:51:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id DpjJJUVszGYYHwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 26 Aug 2024 11:51:33 +0000
Date: Mon, 26 Aug 2024 13:50:16 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Indumathi Raju <Indumathi.r@exaleapsemi.com>
Message-ID: <Zsxr-N1XKJeNo2CL@yuki.lan>
References: <PN2PR01MB95699F92D98659C10E6D19A6F0872@PN2PR01MB9569.INDPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <PN2PR01MB95699F92D98659C10E6D19A6F0872@PN2PR01MB9569.INDPRD01.PROD.OUTLOOK.COM>
X-Rspamd-Queue-Id: B5B111F854
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_EQ_ADDR_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] (no subject)
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
>  Hi am Doing LTP build and execution at Riscv64 on Linux platform There am facing issue with controllers.cgroups here the log "CONFIG_LOCKDEP is not enabled
> 
> 
> CONFIG_LOCKDEP is not enabled
> 
> 
> HINT: You _MAY_ be missing kernel fixes:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1756d7994ad8
> 
> HINT: You _MAY_ be vulnerable to CVE(s):
> 
> https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-4197
> tst_cgroup.c:878: TCONF: V2 'memory' controller required, but it's mounted on V1
> cgroup_core03.c:90: TCONF: cgroup.kill is not supported on your distribution
> tst_cgroup.c:862: TCONF: 'debug' controller required, but not available
> cgroup_fj_stress 1 TCONF: 'tst_cgctl require' exited. Controller is probably not available?
> cgroup_fj_stress 1 TINFO: Re
> tst_cgroup.c:878: TCONF: V2 'memory' controller required, but it's mounted on V1
> 
> Summary:
> passed   0
> failed   0
> broken   0
> skipped  1
> warnings 0
> <<<execution_status>>>
> initiation_status="ok"
> duration=0 termination_type=exited termination_id=32 corefile=no
> cutime=0 cstime=1
> <<<test_end>>>

This looks like a perfecly valid test result, the test is skipped
because the controller is bound to V1 hierarchy. Nothing to worry about.

> <<<test_start>>>
> tag=cgroup_core03 stime=2083218808
> cmdline="cgroup_core03"
> contacts=""
> analysis=exit
> <<<test_output>>>
> tst_test.c:1690: TINFO: LTP version: 20230929
> tst_test.c:1574: TINFO: Timeout per run is 0h 00m 50s
> tst_buffers.c:56: TINFO: Test is using guarded buffers
> cgroup_core03.c:90: TCONF: cgroup.kill is not supported on your distribution

Here as well, the feature is not available hence it's not tested.

> Summary:
> passed   0
> failed   0
> broken   0
> skipped  1
> warnings 0
> <<<execution_status>>>
> initiation_status="ok"
> duration=0 termination_type=exited termination_id=32 corefile=no
> cutime=0 cstime=0
> <<<test_end>>>
> <<<test_start>>>
> tag=cgroup stime=2083218808
> cmdline="cgroup_regression_test.sh"
> contacts=""
> analysis=exit
> <<<test_output>>>
> cgroup_regression_test 1 TINFO: timeout per run is 0h 5m 0s
> cgroup_regression_test 1 TPASS: no kernel bug was found
> cgroup_regression_test 2 TPASS: notify_on_release is inherited
> mkdir: cannot create directory '/sys/fs/cgroup/cpu,cpuacct/0': File exists

This is a bug either in the kernel or in the test, you have to figure
out what created the directory '0' before this test. My guess is that
one of tests that did exit with TCONF haven't cleaned up properly. So I
would run the cgroup tests one by one by hand and watch the
'/sys/fs/cgroup/cpu,cpuacct/' directory to see which test fails to
remove the '0' directory. Once we have the test pinned out we can debug
it further.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
