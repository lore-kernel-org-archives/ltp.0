Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB5D0C021B2
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 19:02:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E4CCE3C0430
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 20:02:42 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 42ADB3C0430
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 20:02:26 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DD5841401197
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 20:02:25 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4C11D1F387;
 Thu, 20 Feb 2025 19:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740078144;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ciRI9kF05ab4dzKr2iurSHt4iXIUuz3B0YUChzh4DW8=;
 b=CUeiATSNBBqJEzfxw4BeY6a9AgcnMKgc+HYwtXxJir51saIfcz7o9jvsYqV+7KjZ85dsW0
 ql2FtB2Z7pjanaPfBFOODGY+andg+gPD03PSwynRkejPJJILQ8F2B1686DI+cd4EwVpFGP
 AdDTEixaL6TaS/fQCRbpu0CfFgP2YdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740078144;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ciRI9kF05ab4dzKr2iurSHt4iXIUuz3B0YUChzh4DW8=;
 b=yu9tkbF2A4eeu0gDdEu7IYPHlA+kmJ9CV6u91QvOLdBzJEQWu7eZyTkIkCsJ5bTFcMIsiG
 PQTGpL7dDBJtIiAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740078144;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ciRI9kF05ab4dzKr2iurSHt4iXIUuz3B0YUChzh4DW8=;
 b=CUeiATSNBBqJEzfxw4BeY6a9AgcnMKgc+HYwtXxJir51saIfcz7o9jvsYqV+7KjZ85dsW0
 ql2FtB2Z7pjanaPfBFOODGY+andg+gPD03PSwynRkejPJJILQ8F2B1686DI+cd4EwVpFGP
 AdDTEixaL6TaS/fQCRbpu0CfFgP2YdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740078144;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ciRI9kF05ab4dzKr2iurSHt4iXIUuz3B0YUChzh4DW8=;
 b=yu9tkbF2A4eeu0gDdEu7IYPHlA+kmJ9CV6u91QvOLdBzJEQWu7eZyTkIkCsJ5bTFcMIsiG
 PQTGpL7dDBJtIiAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C57913301;
 Thu, 20 Feb 2025 19:02:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id i2t7BUB8t2eBMwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 20 Feb 2025 19:02:24 +0000
Date: Thu, 20 Feb 2025 20:02:18 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Message-ID: <20250220190218.GB2712942@pevik>
References: <20250220160054.12149-1-zohar@linux.ibm.com>
 <20250220160054.12149-2-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250220160054.12149-2-zohar@linux.ibm.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 2/3] ima: additional open-writer violation
 tests
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
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it,
 Stefan Berger <stefanb@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Mimi,

> Kernel patch "ima: limit the number of open-writers integrity
> violations" prevents superfluous "open-writers" violations.  Add
> corresponding LTP tests.

> Link: https://lore.kernel.org/linux-integrity/20250219162131.416719-2-zohar@linux.ibm.com/
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  .../integrity/ima/tests/ima_violations.sh     | 87 ++++++++++++++++++-
>  1 file changed, 86 insertions(+), 1 deletion(-)

> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> index 7f0382fb8..65c5c3a92 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> @@ -8,7 +8,7 @@

>  TST_SETUP="setup"
>  TST_CLEANUP="cleanup"
> -TST_CNT=3
> +TST_CNT=6

>  REQUIRED_BUILTIN_POLICY="tcb"
>  REQUIRED_POLICY_CONTENT='violations.policy'
> @@ -60,6 +60,17 @@ close_file_write()
>  	exec 4>&-
>  }

> +open_file_write2()
> +{
> +	exec 5> $FILE || exit 1
maybe:
	exec 5> $FILE || tst_brk TBROK "exec 5> $FILE failed"

Because tst_brk TBROK calls test cleanup. Plain exit kills everything.
We also have ROD, but that requires binaries ('exec' is a shell builtin).
(It applies to the third patch as well.)

> +	echo 'test writing2' >&5
> +}
> +
> +close_file_write2()
> +{
> +	exec 5>&-
> +}
> +
>  get_count()
>  {
>  	local search="$1"
> @@ -160,6 +171,80 @@ test3()
>  	tst_sleep 2s
>  }

> +test4()
> +{
> +	tst_res TINFO "verify limiting single open writer violation"
> +
> +	local search="open_writers"
> +	local count num_violations
> +
> +	read num_violations < $IMA_VIOLATIONS
> +	count="$(get_count $search)"
> +
> +	open_file_write
> +	open_file_read
> +	close_file_read
> +
> +	open_file_read
> +	close_file_read
> +
> +	close_file_write
> +
> +	validate $num_violations $count $search 1
> +}
> +
> +test5()
> +{
> +	tst_res TINFO "verify limiting multiple open writers violations"
> +
> +	local search="open_writers"
> +	local count num_violations
> +
> +	read num_violations < $IMA_VIOLATIONS
> +	count="$(get_count $search)"
> +
> +	open_file_write
> +	open_file_read
> +	close_file_read
> +
> +	open_file_write2
> +	open_file_read
> +	close_file_read
> +	close_file_write2
> +
> +	open_file_read
> +	close_file_read
> +
> +	close_file_write
> +
> +	validate $num_violations $count $search 1
nit: safer to quote
	validate "$num_violations" "$count" "$search" 1
> +}
> +
> +test6()
> +{
> +	tst_res TINFO "verify new open writer causes additional violation"
> +
> +	local search="open_writers"
> +	local count num_violations
> +
> +	read num_violations < $IMA_VIOLATIONS
> +	count="$(get_count $search)"
> +
> +	open_file_write
> +	open_file_read
> +	close_file_read
> +
> +	open_file_read
> +	close_file_read
> +	close_file_write
> +
> +	open_file_write
> +	open_file_read
> +	close_file_read
> +	close_file_write
> +	validate $num_violations $count $search 2
And here.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
