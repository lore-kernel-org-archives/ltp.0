Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08544C3DA61
	for <ltp@archiver.kernel.org>; Mon, 29 Jul 2024 07:32:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3EC1B3D1C01
	for <ltp@archiver.kernel.org>; Mon, 29 Jul 2024 09:32:46 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 95B443CD80A
 for <ltp@lists.linux.it>; Mon, 29 Jul 2024 09:32:29 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6D8D11A01447
 for <ltp@lists.linux.it>; Mon, 29 Jul 2024 09:32:27 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4B9D81F78C;
 Mon, 29 Jul 2024 07:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722238347;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rxmoAm0qn1hbL+jubArmDfVoHygkgxVEKqRITYubenw=;
 b=MDvR/wYx/GLg93iHHVPJZ66cEV/4enXa3GceMGa9FqdQQpfYYK1Pc7WfF4BhpHoWTxYiDD
 sI71GLVSHcLVDlSiYsrGbpgjwtSuWsg62ZJllpyMR7KVjzvQHvy+b/o7lhCP5DaTlKXgBV
 S8MXYuvDFYACElmDiGi8+u+KbJSuLbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722238347;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rxmoAm0qn1hbL+jubArmDfVoHygkgxVEKqRITYubenw=;
 b=AV/kQwFMSdZmHd9O3xXZGRz7x77jVvzRUPjmSX4VsbYlgz9SN9zte4TQxrUlE3Jr+Byy61
 bPVbJO7qHjRRecCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722238347;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rxmoAm0qn1hbL+jubArmDfVoHygkgxVEKqRITYubenw=;
 b=MDvR/wYx/GLg93iHHVPJZ66cEV/4enXa3GceMGa9FqdQQpfYYK1Pc7WfF4BhpHoWTxYiDD
 sI71GLVSHcLVDlSiYsrGbpgjwtSuWsg62ZJllpyMR7KVjzvQHvy+b/o7lhCP5DaTlKXgBV
 S8MXYuvDFYACElmDiGi8+u+KbJSuLbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722238347;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rxmoAm0qn1hbL+jubArmDfVoHygkgxVEKqRITYubenw=;
 b=AV/kQwFMSdZmHd9O3xXZGRz7x77jVvzRUPjmSX4VsbYlgz9SN9zte4TQxrUlE3Jr+Byy61
 bPVbJO7qHjRRecCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C40E81368A;
 Mon, 29 Jul 2024 07:32:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id DXxsK4pFp2YuZgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 29 Jul 2024 07:32:26 +0000
Date: Mon, 29 Jul 2024 09:32:26 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20240729073226.GA1223191@pevik>
References: <20240717171713.687339-1-pvorel@suse.cz>
 <20240717171713.687339-6-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240717171713.687339-6-pvorel@suse.cz>
X-Spamd-Result: default: False [-0.30 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/6] runtest/sched: Add sched_football
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
Cc: Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> sched_football is useful not only for testing realtime,
> therefore add it also to runtest/sched.

> This depends on previous commit which enabled realtime by default.
> We ignore the possibility realtime tests are disabled.

> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  runtest/sched | 2 ++
>  1 file changed, 2 insertions(+)

> diff --git a/runtest/sched b/runtest/sched
> index 5dab7a4c27..ecedd1a92b 100644
> --- a/runtest/sched
> +++ b/runtest/sched
> @@ -18,3 +18,5 @@ sched_cli_serv run_sched_cliserv.sh
>  sched_stress sched_stress.sh

>  autogroup01 autogroup01
> +
> +sched_football sched_football

I'm sorry, I haven't noticed, that realtime installs into a different directory:

cd ltp/testcases/realtime/func/sched_football
# make install
mkdir -p "/opt/ltp/testcases/realtime/func/sched_football"
install -m 00775   "ltp/testcases/realtime/func/sched_football/run_auto.sh" /opt/ltp/testcases/realtime/func/sched_football/run_auto.sh
install -m 00775   "ltp/testcases/realtime/func/sched_football/sched_football" /opt/ltp/testcases/realtime/func/sched_football/sched_football

Therefore scripts which expect it to have in the usual path $LTPROOT/testcases/bin
(e.g. /opt/ltp/testcases/bin) fail.

As temporary solution is to add $LTPROOT/testcases/realtime/func/sched_football/
to $PATH, for proper fix we have possibilities:

1) Either move sched_football.c out of realtime package (thus have some
duplicity, because it needs some of librealtime.a code),
2) or fully integrate realtime testsuite to LTP (e.g. convert librealtime.a to
normal LTP library in libs/ directory).
3) Change realtime make install target to install to $LTPROOT/testcases/bin and
ignore that some tests are not much useful for non-realtime kernels.

Just a reminder, to help which decision is better we have ticket for realtime
where is Mel Gorman's realtime usability investigation [1].

Because some time ago we planned to move tests to rt-tests testsuite [2] (we did
not consider to run them for non-realtime kernels, but recently Cyril saw
sched_football useful also for non-realtime kernels).

Do we plan to keep only sched_football in LTP or all tests? I suppose LTP should
only contains tests which are useful also for non-realtime kernels.

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/issues/1078#issuecomment-2212913818
[2] https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
