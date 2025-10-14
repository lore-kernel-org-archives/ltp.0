Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 925ADCCD187
	for <ltp@archiver.kernel.org>; Tue, 14 Oct 2025 08:39:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E9A123CE817
	for <ltp@archiver.kernel.org>; Tue, 14 Oct 2025 10:39:52 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B42D93CDF40
 for <ltp@lists.linux.it>; Tue, 14 Oct 2025 10:39:35 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 26A14600A0F
 for <ltp@lists.linux.it>; Tue, 14 Oct 2025 10:39:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3C5D01F79B;
 Tue, 14 Oct 2025 08:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760431174;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aAdESOg0Yl41/m8yzShq9wcYZOs+Az7mZ7GqbjUXSQY=;
 b=IIKE0gg7Bq6ab6OscXwPgkXt9XfKXf3ObB4ywUNmhywZY9eROK4kNjRic8Td2zYybHFIK5
 tBJR3lgIo1SWnbpAceR6cI20FnxhbVc3kWoU8z/kPjsgY+i20QNcPaaJBpge2rLQT5pFfy
 I+uURYeVPsTWAGuXkM2FoX97nh3ywds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760431174;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aAdESOg0Yl41/m8yzShq9wcYZOs+Az7mZ7GqbjUXSQY=;
 b=ick0CABHweDO0Pw70LGcHN8ovTW3fMny7qbt0BqLOiQDF8/ig0Nq/wbzfxnaRC4lUY40py
 XTOQYP/JgPO59YCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760431173;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aAdESOg0Yl41/m8yzShq9wcYZOs+Az7mZ7GqbjUXSQY=;
 b=B3pzP7doZbx3LB+GpV3UptYemobd/kIPdSzCilRyv13OQ/yc6fWgsTqze6vYDAigIIxxLt
 hbIj23L+51rpCcCu1vwcXrfvW764hnERccvBATc80GpiC2/X36iONaCN9J1Qi24Bn+a7VB
 j66McP7X2uvDN7z5Klwn1HfpXbMhBik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760431173;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aAdESOg0Yl41/m8yzShq9wcYZOs+Az7mZ7GqbjUXSQY=;
 b=Sgj1kcPp36sVsKmgjGnz6h0ePQ45e8jk8vLdoi9d4blj3xCKFacSnH8uKhMUtURUqo8UO1
 lrzuokZvzMeSnbCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 194CA13A44;
 Tue, 14 Oct 2025 08:39:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id i4YpBUUM7mhfHgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 14 Oct 2025 08:39:33 +0000
Date: Tue, 14 Oct 2025 10:39:31 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20251014083931.GA133774@pevik>
References: <20251014-remove_todo-v4-1-168fcfa74221@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251014-remove_todo-v4-1-168fcfa74221@suse.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] Remove TODO
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

Hi Andrea,

> Changes in v4:
> - fix commit message
> - point to tst_run_shell.c
> - moved to developers
> - fix git grep command
> - Link to v3: https://lore.kernel.org/r/20251013-remove_todo-v3-1-533e47439a94@suse.com

Thanks!

...
> --- /dev/null
> +++ b/doc/developers/todo.rst
> @@ -0,0 +1,73 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +List of ongoing tasks
> +=====================
> +
> +This is a comprehensive list of tasks where LTP maintainers are currently
> +working on. Priorities might change over time, but these are the most important
> +points which are currently being achieved.
> +
> +Fade out old tests runner
> +-------------------------
> +
> +``runltp`` script is old and unmaintaned. We are slowly shifting to
nit: even this could be a link to script (to show newcomers the ugliness of the
script and the need to replace it :)).

:master:`runltp` script ..

> +`kirk <https://github.com/linux-test-project/kirk>`_, that will be our official
> +tests runner in the next future.

...
> +LTP maintainers are working on converting shell scripts to plain-C tests, in
> +order to reduce the impact that shell scripts might have on the overall kernel
> +testing.
> +
> +For a complete list of shell tests, please run the following command inside the
> +LTP root folder:
> +
> +.. code-block:: bash
> +
> +        git --no-pager grep -l -e '^\. .*_lib\.sh' -e '^\. .*test.sh'
> +
> +LTP also provides a shell loader implementation for plain-C tests using
> +:master:`testcases/lib/tst_run_shell.c`.

I would get wrong impression from this. Although shell loader allows have unique
tst_{res,brk} counter when mixing C and shell tests, it can be used for tests
solely written in shell. In that case the key point is to use LTP C library.

And when mixing C and shell, it's a shell test which uses C "test" (a tool which
uses C API). i.e. test driven by shell test.

Anyway, unless Cyril comes with it's own definition, I'm ok with this. We should
write a shell loader doc anyway and then it'll be linked here.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
