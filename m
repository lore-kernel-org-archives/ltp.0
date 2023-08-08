Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75BCDC001DB
	for <ltp@archiver.kernel.org>; Tue,  8 Aug 2023 10:03:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A5B903CD103
	for <ltp@archiver.kernel.org>; Tue,  8 Aug 2023 12:03:10 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C78D3C8524
 for <ltp@lists.linux.it>; Tue,  8 Aug 2023 12:03:00 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 97FD1600CF6
 for <ltp@lists.linux.it>; Tue,  8 Aug 2023 12:02:59 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AC11C2031C;
 Tue,  8 Aug 2023 10:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1691488978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+Khz9JlQsOct3rCgHH8/FCpbs4nSIQXkH5vSMlWv+o8=;
 b=obnqm5ZY0Dobkz+BqKD5j3g5aqFqz84CqPgTupRMt9CZzs6mvqiAIXcoz3aNhonpBQhHOf
 RTeoCj7KI4jpVunWP/aE8foBFPgU200lRsPr0nTIH55s/v+9Pf7aDjwzXkYa15DG/Tg+W8
 g75VMdFY5CBX8VK1JCvGt0dR+bHWlKw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1691488978;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+Khz9JlQsOct3rCgHH8/FCpbs4nSIQXkH5vSMlWv+o8=;
 b=aRq2t4L/F4/3ob5E/id+6EtaSHNqJNOgjjDlIcxoAhCbfy9uYVInT7eaPYhjc6v35vMLJM
 aliOwTcm8knOXSCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9026613451;
 Tue,  8 Aug 2023 10:02:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XcFmItIS0mQ+KgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 08 Aug 2023 10:02:58 +0000
Date: Tue, 8 Aug 2023 12:03:56 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: ybonatakis <ybonatakis@suse.com>
Message-ID: <ZNITDLQL-0f6dpEY@yuki>
References: <20230807132017.26568-1-ybonatakis@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230807132017.26568-1-ybonatakis@suse.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Rewrite the gethostname01 using new LTP API
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
> +/*
> + * [Description]
> + *
> + * This is a Phase I test for the gethostname(2) system call. It is intended
> + * to provide a limited exposure of the system call, for now. It
> + * should/will be extended when full functional tests are written for
> + * gethostname(2).

I've removed this useless part of the description and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
