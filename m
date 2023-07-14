Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C6A5EB64DA
	for <ltp@archiver.kernel.org>; Fri, 14 Jul 2023 11:15:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5863E3CE558
	for <ltp@archiver.kernel.org>; Fri, 14 Jul 2023 13:15:31 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB74E3CAB8D
 for <ltp@lists.linux.it>; Fri, 14 Jul 2023 13:15:19 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F00571000BD9
 for <ltp@lists.linux.it>; Fri, 14 Jul 2023 13:15:18 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5EACE1F86B;
 Fri, 14 Jul 2023 11:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689333317;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vB+Uf4QhxBzrZ31Qyo9Mh+wFghS0RJ7REWo6FKuMZsc=;
 b=dP9ZN6WlkGKDp+l5uIZVEyjO9vtyhskDyGBAe7oqwI0e45GKyMhjnxKGnnZXBIJmAIPbxB
 8qTy/Ic0oj7/sViAEu7rt5Zxl8hONeuK8WWTKMeH1UNGYIMvkA+6+eWrj/eg3Smhmd27Fl
 NKHWE+WUmwz65y91CERxXmcdAfQ/iYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689333317;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vB+Uf4QhxBzrZ31Qyo9Mh+wFghS0RJ7REWo6FKuMZsc=;
 b=fjIjUPE846Hqtb+ULpHggH2ZG7SqhzDUhydi+9xHGDQbXdxYv4aDWz/ysaGs2jcRYGI/4/
 CvVqyl3MhKvZfyCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 303A0138F8;
 Fri, 14 Jul 2023 11:15:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +NBoCkUusWT3LAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 14 Jul 2023 11:15:17 +0000
Date: Fri, 14 Jul 2023 13:15:15 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <20230714111515.GA958548@pevik>
References: <20230712084720.4261-1-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230712084720.4261-1-akumar@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] pipe10.c: Rewrite the test using new LTP API
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

Hi Avinesh,

> +	int pid;
...
> +	pid = SAFE_FORK();

...
> +	if (pid == 0) {
Because pid is not needed for anything else, I just changed this to:
	if (!SAFE_FORK()) {

and merged.

Thank you!

Kind regards,
Petr

> +		rd_cnt = SAFE_READ(1, fds[0], rdbuf, wr_cnt);
> +		TST_EXP_EQ_LU(wr_cnt, rd_cnt);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
