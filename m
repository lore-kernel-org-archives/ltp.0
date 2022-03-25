Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 303E2C433EF
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 10:24:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A76C3C895D
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 11:24:51 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 360B03C5E40
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 11:24:41 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A125120100C
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 11:24:40 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B7595210DF;
 Fri, 25 Mar 2022 10:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1648203879;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uyo7/7+Ecr6R4srl+3JD6rQGkNnuDG1Ni4qS/mtyfwA=;
 b=K/Hr4Hh+r9aNw/NGFzy60/80sbkv5Y3SkZmLnr9/y9YrBlufmi8Kq4HI2aQHRxYF+yCuHh
 XCdhvWAtDBT8kUHDEiOoXucMI92xSZc2mnQmh4GzWz8BQgpNnH29whICsMNSVq2tEEl/mK
 iEzPxlLlqqI6p0LJ+CzTo8tBfcyGDVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1648203879;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uyo7/7+Ecr6R4srl+3JD6rQGkNnuDG1Ni4qS/mtyfwA=;
 b=ry1TY9yBJfQ1VU+z9QfgnkVz1Le35Up9hWqsqCd9t+uIl2k0SXVKytFnwFcILeSW3mX8Rs
 4y1YRyKBfIsFNNCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9845613A30;
 Fri, 25 Mar 2022 10:24:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id k6vNI2eYPWK/GwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 25 Mar 2022 10:24:39 +0000
Date: Fri, 25 Mar 2022 11:24:37 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Yj2YZWJqGL2R7oja@pevik>
References: <20220325093626.11114-1-andrea.cervesato@suse.de>
 <20220325093626.11114-2-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220325093626.11114-2-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/9] Rewrite userns01.c using new LTP API
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

> diff --git a/testcases/kernel/containers/userns/userns01.c b/testcases/kernel/containers/userns/userns01.c

> -/*
> - * Verify that:
> - *  If a user ID has no mapping inside the namespace, user ID and group
> - * ID will be the value defined in the file /proc/sys/kernel/overflowuid(65534)
> - * and /proc/sys/kernel/overflowgid(65534). A child process has a full set
> - * of permitted and effective capabilities, even though the program was
> - * run from an unprivileged account.
> +/*\
> + * [Description]
> + *
> + * Verify that if a user ID has no mapping inside the namespace, user ID and
> + * group ID will be the value defined in the file /proc/sys/kernel/overflowuid(65534)
> + * and /proc/sys/kernel/overflowgid(65534). A child process has a full set of
> + * permitted and effective capabilities, even though the program was run from an
> + * unprivileged account.
>   */
nit:
-/proc/sys/kernel/overflowuid(65534)
+/proc/sys/kernel/overflowuid (defaults 65534)
and to overflowgid.

to make it a bit more readable. Can be done before merge.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
