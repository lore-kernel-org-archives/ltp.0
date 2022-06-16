Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87112C433EF
	for <ltp@archiver.kernel.org>; Thu, 16 Jun 2022 21:43:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 63AE43C7730
	for <ltp@archiver.kernel.org>; Thu, 16 Jun 2022 23:43:23 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 71C873C0611
 for <ltp@lists.linux.it>; Thu, 16 Jun 2022 23:43:13 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C4D546019BA
 for <ltp@lists.linux.it>; Thu, 16 Jun 2022 23:43:12 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A2E0B1F8BB;
 Thu, 16 Jun 2022 21:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655415791;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JLyk2c8oTu74ZAH8zpRvLLf+udG2nn39qky28m7s72c=;
 b=X36tu04V5AQ2DZuvkVRYtYk4740Q4XDXW0/MyjFXTKvojnb4EDFJnXCAwkDHqgGyFxBfyS
 sSH5gWT2SSmAWo4sPoq3tF4x+rO+JmED2zFOS4vhLGEwLWpCPvUxX3y8Uu1I6nA3gLjNIp
 YsD94zExi1wvdkGxlWCTFV6Lq41SZZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655415791;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JLyk2c8oTu74ZAH8zpRvLLf+udG2nn39qky28m7s72c=;
 b=3PcYd1ujAwNKPpB1hfnPkSFDqSBLBdaEN/KIbzTu20MfhpFaibh+OYxP5/U4EHR8/wbi+g
 HHyCuR4TWA92guDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8203C1344E;
 Thu, 16 Jun 2022 21:43:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id V3f5He+jq2JxPQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 16 Jun 2022 21:43:11 +0000
Date: Thu, 16 Jun 2022 23:43:10 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Yquj7iln/+uDUnhV@pevik>
References: <20220616134919.8248-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220616134919.8248-1-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/fork13: Rewrite to new API + add
 .max_runtime
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

Hi Cyril,

> This fixes a problem we had for years, the test can run for more than
> half an hour on slow systems and it used to timeout quite often.
+1

> This commit introduces a max_runtime with a 10 minute limit which is
> more than enough for the test to complete on a modern hardware but at
> the same time it limits the runtime to a sensible value on older
> hardware and embedded.
+1

Original implementation was quite nicely written (at least some parts were
reused), which clearly demonstrates advantages of new LTP API.

LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

I'd just formatted the doc differently:

/*\
 * [Description]
 *
 * A race in pid generation that causes pids to be reused immediately
 *
 * From the mainline commit 5fdee8c4a5e1800489ce61963208f8cc55e42ea1:
 *
 * A program that repeatedly forks and waits is susceptible to having
 * the same pid repeated, especially when it competes with another
 * instance of the same program.  This is really bad for bash
 * implementation.  Furthermore, many shell scripts assume that pid
 * numbers will not be used for some length of time.
 *
 * [Race Description]
 * ---------------------------------------------------------------------
 * A                                   B
 *
 * // pid == offset == n               // pid == offset == n + 1
 * test_and_set_bit(offset, map->page)
 *                                     test_and_set_bit(offset, map->page);
 *                                     pid_ns->last_pid = pid;
 * pid_ns->last_pid = pid;
 *                                     // pid == n + 1 is freed (wait())
 *
 *                                     // Next fork()...
 *                                     last = pid_ns->last_pid; // == n
 *                                     pid = last + 1;
 * ---------------------------------------------------------------------
 */

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
