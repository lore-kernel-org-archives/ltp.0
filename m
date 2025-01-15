Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F58C02180
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 22:42:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 552A53C7BA4
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 23:42:12 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8EF9C3C7A70
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 23:41:57 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F402A1182548
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 23:41:56 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D4ADD2170E;
 Wed, 15 Jan 2025 22:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736980916;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u+fOyp0FqzYAgpp0Ih3NkNrIWpqx8vtSKLxy0guzi3s=;
 b=0pIJAFAoDNBOACo6/YX9Pfdu22dGbb7Sr4+/sI1zC1jqsJpSC3ffT+qZcBpC7/Y2psa/yp
 3SyHdzlsnb8elpZ9FgqSOMH5Mjh/GLcOlsz8QM8l1+71B2cwoDfDQQlgfe/IDgpMOjmIHe
 HbpWQIF9dgGvJmNHYf1U+kYrM5GB/6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736980916;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u+fOyp0FqzYAgpp0Ih3NkNrIWpqx8vtSKLxy0guzi3s=;
 b=m01cSuf24KlDfuzh219DJvgRitq+F1gYnPAif5HEAtgX5MNG0xh8sbbQHMM84wXdHgN6w1
 6RtIwQbdmM58NhCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736980915;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u+fOyp0FqzYAgpp0Ih3NkNrIWpqx8vtSKLxy0guzi3s=;
 b=mbn/cR3me9r6+xr+Q4tTQy5pjqX7l+cMU8HKwzTshoBXjD+owk+8XfgvV7FX4/YM2JzNre
 M/UXMXf98CMtWZh/XBbb/ltq3043biW+mUAVrA6cd/s9DZCMWiEBfk6laoyiZG1NRPUo12
 x+4cI93wHFRtkIB4Re4YKXnr2lNZCGw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736980915;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u+fOyp0FqzYAgpp0Ih3NkNrIWpqx8vtSKLxy0guzi3s=;
 b=lfVLGmhif1zrBeekpKbUch3FfJ9xh9xu9WXuNCM7xABWeSS7svq2sUeMplSvaZbMwyyTFv
 G+/RljkLs3dEuPAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D5CA139CB;
 Wed, 15 Jan 2025 22:41:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id B4vqJLM5iGeVBAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 15 Jan 2025 22:41:55 +0000
Date: Wed, 15 Jan 2025 23:41:54 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>, Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250115224154.GA664782@pevik>
References: <20241222072251.13150-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241222072251.13150-1-liwang@redhat.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] Broken tests using tst_net.sh by 893ca0abe7
 (was: [PATCH 1/2] lib: multiply the timeout if detect slow kconfigs)
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li, Cyril, all,

...
> +++ b/lib/tst_test.c
> @@ -555,9 +555,6 @@ static int multiply_runtime(int max_runtime)

>  	parse_mul(&runtime_mul, "LTP_RUNTIME_MUL", 0.0099, 100);

> -	if (tst_has_slow_kconfig())
> -		max_runtime *= 4;
> -
>  	return max_runtime * runtime_mul;
>  }

> @@ -1706,6 +1703,9 @@ unsigned int tst_multiply_timeout(unsigned int timeout)
>  	if (timeout < 1)
>  		tst_brk(TBROK, "timeout must to be >= 1! (%d)", timeout);

> +	if (tst_has_slow_kconfig())
> +		timeout *= 4;

FYI this change, merged as 893ca0abe7 ("lib: multiply the timeout if detect slow
kconfigs") caused a regression on *all* tests which use tst_net.sh.

First, it detects slow config on everything which uses struct tst_test,
which are unfortunately some tools at testcases/lib/:

$ git grep -l "struct tst_test" testcases/lib/*.c
testcases/lib/tst_device.c // not obvious reason, might be removed
testcases/lib/tst_get_free_pids.c // force messages to be printed from new library
testcases/lib/tst_ns_create.c // .forks_child = 1, Needed by SAFE_CLONE
testcases/lib/tst_ns_exec.c  // .forks_child = 1, Needed by SAFE_CLONE
testcases/lib/tst_run_shell.c // not obvious reason, might be removed

Besides unimportant fact that slow config detection is an unnecessary slowdown
on these tools, the problem is that it prints messages to stderr, which causes
breakage.

Previously tst_ns_exec.c run just command passed by -c parameter:

$ ./tst_ns_exec 14536 net,mnt sh -c " cat /proc/sys/net/ipv6/conf/ltp_ns_veth1/disable_ipv6"
0

Now it prints TINFO:
$ ./tst_ns_exec 14536 net,mnt sh -c " cat /proc/sys/net/ipv6/conf/ltp_ns_veth1/disable_ipv6"
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:667: TINFO: CONFIG_LATENCYTOP kernel option detected which might slow the execution
0

tst_rhost_run() in tst_net.sh runs binary on remote host:

	output=$($rcmd "$sh_cmd" $out 2>&1 || echo 'RTERR')

Redirect stderr to stdout (2>&1) is likely needed for some tests. But
tst_rhost_run() output is often parsed including therefore certain tools in
testcases/lib/ have to print only expected output:

init_ltp_netspace()
{
	...
		pid="$(ROD tst_ns_create net,mnt)"
	...
	export LTP_NETNS="${LTP_NETNS:-tst_ns_exec $pid net,mnt}"

I will probably solve it by adding yet another parameter to tst_rhost_run(),
which ignores stderr and use it for tst_ns_{create,exec}. But maybe there is
another solution (or another problem).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
