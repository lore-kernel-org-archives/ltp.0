Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEAE0C433EF
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 08:47:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2A7033C5A9E
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 09:47:13 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8F7293C067B
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 09:47:02 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0706A601AB1
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 09:47:01 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 31B751F38D;
 Fri, 25 Mar 2022 08:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1648198021;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZgBU5WgR7nALl8kHXwgLdGNP+tQO44WpatgsgEjqEqU=;
 b=igIi4P/OXUgPk/BztFPCa8cRkheYyYBp5OH+lQ8UAL1FaUNUA4A4W8Pcp7eDmcVUFPKpp9
 hkbNfozy45OzPHTnYi0LF8yDldP3+cLfYZZoZJWJeDUmnD+QCnnQNd+pX/q5rKQNijp1Yf
 QppTV45lbpvC5oHf85z+7y1LsozDL3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1648198021;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZgBU5WgR7nALl8kHXwgLdGNP+tQO44WpatgsgEjqEqU=;
 b=Z6NxquJZd4zSzGJBGX+FwOsIpBOqIJ3c66zWkk4EAQVMdJaHOenHqxGIQcuBbiufi6vKVu
 apgiE3jNuS1WB7Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EA9EA13A30;
 Fri, 25 Mar 2022 08:47:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id VavrNYSBPWL2bwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 25 Mar 2022 08:47:00 +0000
Date: Fri, 25 Mar 2022 09:46:58 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Dai Shili <daisl.fnst@fujitsu.com>
Message-ID: <Yj2Bgop84e5X0Bzl@pevik>
References: <Yjw13F9Tc2m8Hz6k@pevik>
 <1648229367-3124-1-git-send-email-daisl.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1648229367-3124-1-git-send-email-daisl.fnst@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] syscalls/umount2: Convert to new API and use
 SAFE_ACCESS
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

Hi Dai,

> v4->v5:
>   - Add changelog from previous version
nit: You don't have mention in changelog that you're adding it.
(note anything after --- is not in the commit message)

>   - Make commit message order more reasonable
>   - Fix description format
>   - Merge umount2.h into umount2_02
>   - Use macro to not repeat flag and exp_errno
>   - Make test_umount2() more compact
Thanks for implementing all this!

I merged it with few minor changes, added Xu's Reviewed-by: tag
(he reviewed v2 and v3).

...
> +++ b/testcases/kernel/syscalls/umount2/umount2_02.c
> +#define FLAG_DESC(x, y) .flag = x, .exp_errno = 0, .desc = "umount2("y") with "#x" expected success"
> +#define FLAG_EXP_ERRNO_DESC(x, y, z) .flag = x, .exp_errno = y, \
> +				     .desc = "umount2("z") with "#x" expected "#y
I cleaned whitespace here.

...
> +	const char *mntpoint;
> +	int do_access;
> +} tcases[] = {
> +	{FLAG_EXP_ERRNO_DESC(MNT_EXPIRE | MNT_FORCE, EINVAL, ""), MNTPOINT, 0},

I removed blank lines in here.

...
> +static inline int umount2_retry(const char *target, int flags)
I removed this inline (required for *.h, but not needed here).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
