Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B196BE7717F
	for <ltp@archiver.kernel.org>; Tue, 10 Dec 2024 23:55:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C36C3E9266
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 00:55:01 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9D5163E1410
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 00:54:45 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 61C8A141035B
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 00:54:43 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A09581F38C;
 Tue, 10 Dec 2024 23:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733874882;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0WfZ3TSJGMO8X+iYuoeiEymh5EZri4zSQeGcrtZRAmg=;
 b=de1bNtG7zF5kcAqncrtwj3s9rW8pjCZDSRqA34cDtGO8s8ePb8NF221xJUp7u6ME8UAlAd
 fntzMwRpv5IyhfAT9loIGjmfo6Lyszdo2LZxk3XkXKaOIMyh69h6TmgvbbjSODg9BE+F7r
 juticNEBJKPC+r1o/o+Nkaqav1umsfQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733874882;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0WfZ3TSJGMO8X+iYuoeiEymh5EZri4zSQeGcrtZRAmg=;
 b=extn7AxDdrcgPc+fE64huWC76UoJ+pNbV/l9qnTRYtvZhuyCG0Xz85uLyFLMSJdB9xjbYi
 ZiNLWhQvrjsgqWDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733874881;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0WfZ3TSJGMO8X+iYuoeiEymh5EZri4zSQeGcrtZRAmg=;
 b=Tq8SYipxPrsgrBrbtQA9FkUFLXavNCV61Fn+6tiaHOo8vSdLItLukaHC/JPnK/oIEW+r5m
 jJKzzeEcYBqSphB+dl0smKVr53AWsWTF4lHkRIADsbXGbZO/Xd6kvYXy956qnmCKnv0uHi
 60qPvs/7fHoiIJ2ay2krkqaGAPOZpOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733874881;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0WfZ3TSJGMO8X+iYuoeiEymh5EZri4zSQeGcrtZRAmg=;
 b=HDu0yMOndCE5DpG6ggFouleCZlHL5/UDmtcouFZI30sX6k0edqp/XhPxRkeqETZia87LkD
 CC6pO93AmN1KhfBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81DCD138D2;
 Tue, 10 Dec 2024 23:54:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gZEOHsHUWGePNwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 10 Dec 2024 23:54:41 +0000
Date: Wed, 11 Dec 2024 00:54:36 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20241210235436.GC386508@pevik>
References: <20241203151530.16882-1-chrubis@suse.cz>
 <20241203151530.16882-6-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241203151530.16882-6-chrubis@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[vma05.sh:url,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/5] mem/vma05.sh: Convert to the new shell library
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

Hi Cyril,

> +# env
> +# {
> +#  "needs_root": true,
> +#  "needs_tmpdir": true,
> +#  "needs_cmds": ["gdb"],
Maybe to add here also "uname" ?

> +#  "save_restore": [
> +#   ["/proc/sys/kernel/core_pattern", "TBROK"],
> +#   ["/proc/sys/kernel/core_uses_pid", "TBROK"]
> +#  ],
> +#  "tags": [
> +#   ["linux-git", "103efcd9aac1"],
> +#   ["linux-git", "b6558c4a2378"],
> +#   ["linux-git", "e5b97dde514f"]
> +#  ]
> +# }
> +# ---

...
> -vma_report_check()
> -{
> -	if [ $(uname -m) = "x86_64" ]; then
> -		if LINE=$(grep "vsyscall" /proc/self/maps); then
> -			RIGHT="ffffffffff600000-ffffffffff601000[[:space:]][r-]-xp"
> -			if echo "$LINE" | grep -q "$RIGHT"; then
> -				tst_res TPASS "[vsyscall] reported correctly"
> -			else
> -				tst_res TFAIL "[vsyscall] reporting wrong"
> -			fi
> +if [ $(uname -m) = "x86_64" ]; then
> +	if LINE=$(grep "vsyscall" /proc/self/maps); then
> +		RIGHT="ffffffffff600000-ffffffffff601000[[:space:]][r-]-xp"
> +		if echo "$LINE" | grep -q "$RIGHT"; then
> +			tst_res TPASS "[vsyscall] reported correctly"
> +		else
> +			tst_res TFAIL "[vsyscall] reporting wrong"
>  		fi
>  	fi
> +fi

> -	rm -rf core*
> -	{ vma05_vdso; } > /dev/null 2>&1
> -	[ -f core ] || tst_brk TBROK "missing core file"
> +rm -rf core*
> +{ vma05_vdso; } > /dev/null 2>&1
> +[ -f core ] || tst_brk TBROK "missing core file"

Test timeouts for me:
# PATH=.:~/ltp.git/testcases/lib/:$PATH vma05.sh
tst_tmpdir.c:316: TINFO: Using /tmp/LTP_vmaN8CQtx as tmpdir (tmpfs filesystem)
tst_test.c:1890: TINFO: LTP version: 20240930-113-gffde06520
tst_test.c:1894: TINFO: Tested kernel: 6.13.0-rc1-1.g492f944-default #1 SMP PREEMPT_DYNAMIC Mon Dec  2 08:55:00 UTC 2024 (492f944) x86_64
tst_test.c:1725: TINFO: Timeout per run is 0h 00m 30s
vma05.sh:57: TPASS: [vsyscall] reported correctly

Test timeouted, sending SIGKILL!
tst_test.c:1775: TINFO: Killed the leftover descendant processes
tst_test.c:1781: TINFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
tst_test.c:1783: TBROK: Test killed! (timeout?)

HINT: You _MAY_ be missing kernel fixes:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=103efcd9aac1
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b6558c4a2378
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e5b97dde514f

Summary:
passed   1
failed   0
broken   1
skipped  0
warnings 0

But it fails on master, therefore problem on the system I test. Although on
master it was more obvious that the problem is due core dump file not being
created. In new version it just timeouts.

PATH=.:~/ltp.git/testcases/lib/:$PATH LTPROOT=$LTPROOT vma05.sh
vma05 1 TINFO: Running: vma05.sh
vma05 1 TINFO: Tested kernel: Linux ts 6.13.0-rc1-1.g492f944-default #1 SMP PREEMPT_DYNAMIC Mon Dec  2 08:55:00 UTC 2024 (492f944) x86_64 x86_64 x86_64 GNU/Linux
vma05 1 TINFO: Using /tmp/LTP_vma05.I8VXfhyFt6 as tmpdir (tmpfs filesystem)
vma05 1 TINFO: timeout per run is 0h 5m 0s
vma05 1 TPASS: [vsyscall] reported correctly
vma05 1 TBROK: missing core file
vma05 1 TINFO: AppArmor enabled, this may affect test results
vma05 1 TINFO: it can be disabled with TST_DISABLE_APPARMOR=1 (requires super/root)
vma05 1 TINFO: loaded AppArmor profiles: none

Summary:
passed   1
failed   0
broken   1
skipped  0
warnings 0

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
