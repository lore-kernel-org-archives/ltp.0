Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D19C433EF
	for <ltp@archiver.kernel.org>; Thu, 16 Dec 2021 07:50:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C77433C8F6A
	for <ltp@archiver.kernel.org>; Thu, 16 Dec 2021 08:50:07 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7A51B3C8E6B
 for <ltp@lists.linux.it>; Thu, 16 Dec 2021 08:49:57 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5BDA81A00791
 for <ltp@lists.linux.it>; Thu, 16 Dec 2021 08:49:56 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1AD29212B6;
 Thu, 16 Dec 2021 07:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639640996;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q9YAApfaRKOqkZavGmuxG6jHot5oAnqys9akM8dCCbM=;
 b=0qPogoFfO50amvTcpXewwIjvtvhSx7poHS1+j6liEypNqLgJ+djNFwWhNdixuKBRM4TYd6
 0NJx3MyfQgTlIaHWFoKuTTsb0Rn3qQsvV2/1DQ3fXaD11e2qfUapMdlukQmh9xNviwWAXN
 98R5jTBvUsy1DyBgyPcQ3RtVxfZyfEk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639640996;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q9YAApfaRKOqkZavGmuxG6jHot5oAnqys9akM8dCCbM=;
 b=c2EtL0lIpul9D99i78kdbsUaaoOzQpLa6MJ9BhsPpr8em8H0+n+fETwAsI0sA397iNldpm
 FsiPWl7Pt4+IF2Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E5FA813C0C;
 Thu, 16 Dec 2021 07:49:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ME7zNaPvumG+NQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 16 Dec 2021 07:49:55 +0000
Date: Thu, 16 Dec 2021 08:49:54 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YbrvolVYj7io6rOm@pevik>
References: <CAEemH2d+-rqscLPdn8q0AEkKaCSkCZ-pET_E=eWWN7Z=aB1k0w@mail.gmail.com>
 <20211216034125.255907-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211216034125.255907-1-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] lib: add functions to adjust oom score
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

> This introduces function to LTP for adjusting the oom_score_adj of
> target process, which may be helpful in OOM tests to prevent kernel
> killing the main or lib process during test running.
very good idea.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> The exported global tst_enable_oom_protection function can be used
> at anywhere you want to protect, but please remember that if you
> do enable protection on a process($PID) that all the children will
> inherit its score and be ignored by OOM Killer as well. So that's
> why tst_cancel_oom_protection is recommended to combination in use.

BTW deliberately not documenting it as it should not be commonly
used in tests? Also although oom_score_adj inheritance should be known to
person who will want to add it somewhere, I'd move it from commit message to
source code (into header docs or or C API doc).

> +static void set_oom_score_adj(pid_t pid, int value)
> +{
> +	int val;
> +	char score_path[64];
> +
> +	if (access("/proc/self/oom_score_adj", F_OK) == -1) {
> +		tst_res(TINFO, "Warning: oom_score_adj is not exist");
nit: IMHO "does not exist" or just "not exist"

...

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
