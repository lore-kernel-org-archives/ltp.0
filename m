Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E56EC282EC
	for <ltp@archiver.kernel.org>; Tue, 18 Mar 2025 11:04:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E5343CABE9
	for <ltp@archiver.kernel.org>; Tue, 18 Mar 2025 12:04:44 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 017013CABAF
 for <ltp@lists.linux.it>; Tue, 18 Mar 2025 12:04:26 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A32066008A6
 for <ltp@lists.linux.it>; Tue, 18 Mar 2025 12:04:25 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9A9F81F770;
 Tue, 18 Mar 2025 11:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1742295864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eLRLPE+NvlG+5PR3c6OFPXLZAu2q0z8BifiEv0ESiHE=;
 b=wYrkpVIVbvZ7ZpxSWluD0nb+0Md6avqJohGqBBoS+y6DixmQ9IQDiU6XEFvjx42LTC+9hK
 CEWqKcP0ohxwKDcYZDhuXwAYyp4nqHs/nAk7XcOHr5qBnEfkbvnnxmMBmPeIuMF9hMNdkl
 TzDw1yxaucdnhneT/S8NAJSBTMCV4PI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1742295864;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eLRLPE+NvlG+5PR3c6OFPXLZAu2q0z8BifiEv0ESiHE=;
 b=IAO3QoVcCml1qYu26wW5Lad3YqG+aYnS8IVUtnsBUr8iR6CoHOrKUE8bcMWgC67zGA61Z8
 Sfnh9y8WLMJ7EVAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1742295864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eLRLPE+NvlG+5PR3c6OFPXLZAu2q0z8BifiEv0ESiHE=;
 b=wYrkpVIVbvZ7ZpxSWluD0nb+0Md6avqJohGqBBoS+y6DixmQ9IQDiU6XEFvjx42LTC+9hK
 CEWqKcP0ohxwKDcYZDhuXwAYyp4nqHs/nAk7XcOHr5qBnEfkbvnnxmMBmPeIuMF9hMNdkl
 TzDw1yxaucdnhneT/S8NAJSBTMCV4PI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1742295864;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eLRLPE+NvlG+5PR3c6OFPXLZAu2q0z8BifiEv0ESiHE=;
 b=IAO3QoVcCml1qYu26wW5Lad3YqG+aYnS8IVUtnsBUr8iR6CoHOrKUE8bcMWgC67zGA61Z8
 Sfnh9y8WLMJ7EVAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A229139D2;
 Tue, 18 Mar 2025 11:04:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZAXMIDhT2WdTQwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 18 Mar 2025 11:04:24 +0000
Date: Tue, 18 Mar 2025 12:04:45 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Jacob Martin <jacob.martin@canonical.com>
Message-ID: <Z9lTTX4BrkpFhmQV@yuki.lan>
References: <20250307225804.380166-1-jacob.martin@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250307225804.380166-1-jacob.martin@canonical.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cpuset_memory_testset.sh: Give SIGUSR1 handler
 time to run before changing target mapping node in tests 12 and 13
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Fixes: 70259d6e7
> Signed-off-by: Jacob Martin <jacob.martin@canonical.com>
> ---
>  .../cpuset/cpuset_memory_test/cpuset_memory_testset.sh          | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
> index c1e7cea8f..04d7cc877 100755
> --- a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
> +++ b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
> @@ -383,7 +383,7 @@ talk2memory_test_for_case_12_13()
>  	sleep 1
>  	echo $1 > "$2/tasks"
>  	/bin/kill -s SIGUSR1 $1
> -
> +	sleep 1

This is just another workaround that does not fix the real issue and
that is that the C child does not communicate properly with the shell
code. The best solution here would be to rewrite these tests into C.
There is not that much work the shell does and we would avoid parsing
files written by the C helper in the shell as well.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
