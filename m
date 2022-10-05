Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E82FCC433F5
	for <ltp@archiver.kernel.org>; Wed,  5 Oct 2022 10:19:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C8EB3CADE6
	for <ltp@archiver.kernel.org>; Wed,  5 Oct 2022 12:19:48 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 80AC03C2FD5
 for <ltp@lists.linux.it>; Wed,  5 Oct 2022 12:19:38 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EE39E200119
 for <ltp@lists.linux.it>; Wed,  5 Oct 2022 12:19:37 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A38BC1F88F;
 Wed,  5 Oct 2022 10:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1664965176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zj1HsB6TU6ek+9n9RUMENN/rDGL8WhfgQwDRWeaGSRg=;
 b=wGdpdt6T5742HgWsRletm6nP0QSl4VTlyb9gu6ahqTmhG/OAcK9yuWAkcksOa1cVnX9xPs
 EFSZtIjpstXBO4e4l44G6pNPBcuhQVne26y6bVdLTGvCljeGkbsM0mfn/PboHwvcbuc1z+
 VQzP4TrpbYAiH2jYjNtFpgTP8Z1qzvU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1664965176;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zj1HsB6TU6ek+9n9RUMENN/rDGL8WhfgQwDRWeaGSRg=;
 b=/ZWcj1kQHJC8ndY1+1jz9hEIz1yJ/EkzkLcCZCfkkAuYDxn4ULjIEtbBbawmK+qFuG/F0L
 ZRwNeZiVKDVkr1CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8F97F13ABD;
 Wed,  5 Oct 2022 10:19:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id hYzjIjhaPWOALgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 05 Oct 2022 10:19:36 +0000
Date: Wed, 5 Oct 2022 12:21:27 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Edward Liaw <edliaw@google.com>
Message-ID: <Yz1apwbYCuUkLotX@yuki>
References: <20221004182040.1859774-1-edliaw@google.com>
 <20221004182040.1859774-10-edliaw@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221004182040.1859774-10-edliaw@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 9/9] mmapstress01: reorder vars and functions
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
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> diff --git a/testcases/kernel/mem/mmapstress/mmapstress01.c b/testcases/kernel/mem/mmapstress/mmapstress01.c
> index 9eced3526..f68193706 100644
> --- a/testcases/kernel/mem/mmapstress/mmapstress01.c
> +++ b/testcases/kernel/mem/mmapstress/mmapstress01.c
> @@ -72,26 +72,27 @@
>  #define roundup(x, y)	((((x)+((y)-1))/(y))*(y))
>  
>  static unsigned int initrand(void);
> -static void finish(int sig);
>  static void child_mapper(char *file, unsigned int procno, unsigned int nprocs);
>  static void fileokay(char *file, unsigned char *expbuf);
> +static void sighandler(int sig);

Most of these can be dropped now. The only that needs to stay is
initrand().

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
