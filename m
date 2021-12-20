Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3143C433EF
	for <ltp@archiver.kernel.org>; Mon, 20 Dec 2021 18:34:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EA6633C919F
	for <ltp@archiver.kernel.org>; Mon, 20 Dec 2021 19:34:16 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 05C7F3C918D
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 19:34:07 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 764D6601702
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 19:34:07 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A5BEF1F388;
 Mon, 20 Dec 2021 18:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1640025246;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6EiLwvoOXKRfRx8sBlPDXrRtjWReVryWQ6URzCPZUEY=;
 b=clpTl25WPzL/HW9TQV30D7dF+Cd9nL6McLvYnGAPLUMdJladwDkGnC7iKXCoLyEYD2Su5w
 gVL3qMBxY93qKAmC89jQ85iN/RGzxwysy9083ED3uYFhVJ6qhLJBAi/AuVQaEZmGCpMmDx
 l//B4/WFUChkGYgx6zc6l0s64+arKkc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1640025246;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6EiLwvoOXKRfRx8sBlPDXrRtjWReVryWQ6URzCPZUEY=;
 b=rCkfNf1vN+jcUxOXRJxcX5bf57UXqDwWlNnfA5RKoivrrutGkvsDZlH4vLwrtXvV6CEHUL
 UtXKbUeTo/pAYjAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6814013DBD;
 Mon, 20 Dec 2021 18:34:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1oafFp7MwGHqBwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 20 Dec 2021 18:34:06 +0000
Date: Mon, 20 Dec 2021 19:34:04 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YcDMnDRgsac/q8D9@pevik>
References: <20211220095416.583323-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211220095416.583323-1-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/3] lib: add functions to adjust oom score
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

Hi Li,

>     v2 --> v3
>     	* rename to tst_disable_oom_protection
>     	* support set PID as 0 to protect current process

> +static void set_oom_score_adj(pid_t pid, int value)
> +{
> +	int val;
> +	char score_path[64];
> +
> +	if (access("/proc/self/oom_score_adj", F_OK) == -1) {
We need to check here also /proc/PID/oom_score_adj, i.e. score_path.

Otherwise tests without root fail fail.
lib/tst_memutils.c:111: TBROK: Failed to close FILE '/proc/26980/oom_score_adj': EACCES (13)

Kind regards,
Petr


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
