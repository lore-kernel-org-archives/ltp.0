Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B9BE66884
	for <ltp@archiver.kernel.org>; Fri, 19 Dec 2025 21:37:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 090943D057B
	for <ltp@archiver.kernel.org>; Fri, 19 Dec 2025 22:37:48 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 55BDC3C5624
 for <ltp@lists.linux.it>; Fri, 19 Dec 2025 22:37:28 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A86E810000C3
 for <ltp@lists.linux.it>; Fri, 19 Dec 2025 22:37:23 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C617C5BD1D;
 Fri, 19 Dec 2025 21:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1766180242;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D3+soLGcaudPw7kU7+mu8aD6VVUxfgpwv9VfC34xm8M=;
 b=bxwlPWIQkdt1BRPqT4bbtqsC2f5gvKJfl94dyDyCjHwjVbs0iZbtMEm6fSpZjPsaCLY9lT
 C59txJKCNB/eFu6HBKETNKIPNWm/3uxL6AcLMASAsysEH1pwuMEdgupwptE9OzU58vXMOU
 M/V4Jvjxu6sea+scAsENOka/22qWSOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1766180242;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D3+soLGcaudPw7kU7+mu8aD6VVUxfgpwv9VfC34xm8M=;
 b=ewEjMpBYM24njXnXo27jTWbjB05/2/4JIPQpLLV2KuRnZ50jhwb4G+V2Kp0y5doqk3k93e
 PcbjYLBCLrVnxXDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pmL5hh6x;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="v/clDg4Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1766180240;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D3+soLGcaudPw7kU7+mu8aD6VVUxfgpwv9VfC34xm8M=;
 b=pmL5hh6xUP2V47fWkFBmzam2Y5Ecdimvz0orMABfer6H1jL8j7yB+JOdUru42f+M9u+bCm
 Woj2XmFUXEVLGs8oojbJMRzDgJEc+auOhec6qsq1liSPAzQkJFn+fBD1flqNoFaZ6zd4iW
 XulEMuFiHiWGzugU5mvxuR3ia7EIVfk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1766180240;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D3+soLGcaudPw7kU7+mu8aD6VVUxfgpwv9VfC34xm8M=;
 b=v/clDg4YhdYPkQkkPvgKoz0zzBTzFzhxQW2ztk8woBNB1DvwUZfVar658QAILeHtqZ7VJ7
 kwV0+wyLF8X00TCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D93D3EA63;
 Fri, 19 Dec 2025 21:37:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HiKyCJDFRWldDAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 19 Dec 2025 21:37:20 +0000
Date: Fri, 19 Dec 2025 22:37:03 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
Message-ID: <20251219213703.GB15539@pevik>
References: <20251219155732.46696-1-vasileios.almpanis@virtuozzo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251219155732.46696-1-vasileios.almpanis@virtuozzo.com>
X-Rspamd-Queue-Id: C617C5BD1D
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 REPLYTO_EQ_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,virtuozzo.com:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ssh-stress: disable resource penalties
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

Hi Vasileios,

first, our ML requires subscription (unlike kernel's lore). I subscribed you
then. I'm replying to your second mail which got to ML.

FYI these tests are probably not run by many people (most of the people run
tests from runtest/syscalls or other C based tests).

> Our tests create a number of ssh sessions in the
> background which are immediately killed. Some of
> them haven't finished the authentication stage yet
> and they close the connection incurring penalties from
> the ssh daemon.

> debug1: srclimit_penalise: active penalty for ipv4 10.0.0.1/32
> already exists, 16 seconds remaining

> Then when we try to reconnect to the daemon we are bounced
> because of the active penalty which leads to a failed test.

> ssh-stress 1 TINFO: Killing all ssh sessions
> kex_exchange_identification: read: Connection reset by peer
> Connection reset by fd00:1:1:1::2 port 58373
> ssh-stress 1 TFAIL: SSH not reachable

> From the sshd logs we can see

> debug1: srclimit_penalise: active penalty for ipv4 10.0.0.1/32
> already exists, 16 seconds remaining

> This feature was added to OpenSSH 9.8 in the 2024 release in the
> 81c1099d2 commit. Lets disable penalties for the versions that
> support them.

> Signed-off-by: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
> ---
>  testcases/network/stress/ssh/ssh-stress.sh | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

> diff --git a/testcases/network/stress/ssh/ssh-stress.sh b/testcases/network/stress/ssh/ssh-stress.sh
> index c27c27a28..cb6659ed5 100755
> --- a/testcases/network/stress/ssh/ssh-stress.sh
> +++ b/testcases/network/stress/ssh/ssh-stress.sh
> @@ -39,8 +39,12 @@ cleanup()

>  setup()
>  {
> -	local port rc
> +	local port rc version major minor

> +	version=$(sshd -V 2>&1 | sed -nE 's/^.*OpenSSH_([0-9]+)\.([0-9]+).*$/\1 \2/p' | head -n1)
> +	set -- $version
> +	major=$1
> +	minor=$2

Interesting, I never used set like this.  FYI we suppose POSIX shell
compatibility, i.e. it should work on dash and busybox sh. At least
checkbashisms does not complain therefore it looks to be valid. Testing just
this part locally on both dash and busybox sh shows it's working.

>  	port=$(tst_rhost_run -c "tst_get_unused_port ipv${TST_IPVER} stream")

> @@ -60,6 +64,13 @@ HostKey $TST_TMPDIR/ssh_host_ecdsa_key
>  HostKey $TST_TMPDIR/ssh_host_ed25519_key
>  EOF

> +	if ([ -n "$major" ] && [ -n "$minor" ]); then
	if [ -n "$major" ] && [ -n "$minor" ]; then
nit: IMHO this could be without curly brackets, right? ( ). Any reason to add
them?

> +		if ([ "$major" -gt 9 ] || ([ "$major" -eq 9 ] && [ "$minor" -ge 8 ])); then
I never tried ( ) to force evaluation. I hope it works on POSIX only shell
(dash, busybox sh). BTW IMHO it should work as (which is POSIX compatible):

		if [ "$major" -gt 9 ] || [ "$major" -eq 9 -a "$minor" -ge 8 ]; then

Kind regards,
Petr

> +			cat << EOF >> sshd_config
> +PerSourcePenalties no
> +EOF
> +		fi
> +	fi
>  	ssh-keygen -q -N "" -t rsa -b 4096 -f $TST_TMPDIR/ssh_host_rsa_key
>  	ssh-keygen -q -N "" -t ecdsa -f $TST_TMPDIR/ssh_host_ecdsa_key
>  	ssh-keygen -q -N "" -t ed25519 -f $TST_TMPDIR/ssh_host_ed25519_key

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
