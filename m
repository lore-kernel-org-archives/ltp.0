Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18C1C433EF
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 15:52:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 85ACF3C881F
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 16:52:44 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 591573C0FBC
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 16:52:34 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DABAE200923
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 16:52:33 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 08F7021101;
 Thu, 10 Mar 2022 15:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646927553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x/1q1zgmiIhXFNAvYpPy7Lfq6o0yK/x/u2YGUjUYjVM=;
 b=h3nqAxecpTz/eodZPO5fAFm1OCnMmB8fyIITxFuqeVxtlgs5Ay0077quPJmsIrLOA6r+vk
 LVaF0U0b+KNlkPDu4PmVLOm3nMJxRcNGLdMMD/jvoB82gbLuSu5GuV+41gCiz4q+BnLkwG
 tDxuHs89EEyYE0796JMCcHRTzVnE+xE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646927553;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x/1q1zgmiIhXFNAvYpPy7Lfq6o0yK/x/u2YGUjUYjVM=;
 b=tu5r+LriSgdwHvHBpf5HyKqFDqNX/I1mxFfZD0uR4CkcBL/lFvavauTsX3QnAziKYSac1W
 Jnek9xfI1UHL2kAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DFAA413FA3;
 Thu, 10 Mar 2022 15:52:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id sNoQNcAeKmL2BQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 10 Mar 2022 15:52:32 +0000
Date: Thu, 10 Mar 2022 16:54:51 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <YiofSy6GPq9Z/3rC@yuki>
References: <20220310105916.7960-1-andrea.cervesato@suse.de>
 <20220310105916.7960-5-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220310105916.7960-5-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 04/10] Rewrite sem_nstest.c using new LTP API
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
> +	ipc_id = semget(MY_KEY, 1, IPC_CREAT | IPC_EXCL | 0666);
> +	if (ipc_id < 0) {
> +		tst_res(TINFO, "Semaphore already exists");
> +		ipc_id = SAFE_SEMGET(MY_KEY, 1, 0);
>  	}
> +}

Same here, I do not think that we should blindly reuse existing
semaphore.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
