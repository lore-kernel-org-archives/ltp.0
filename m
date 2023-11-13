Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A531DC4332F
	for <ltp@archiver.kernel.org>; Mon, 13 Nov 2023 16:02:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D081F3CE5E3
	for <ltp@archiver.kernel.org>; Mon, 13 Nov 2023 17:02:14 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 02A1E3CE550
 for <ltp@lists.linux.it>; Mon, 13 Nov 2023 17:02:03 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 726AD1A02381
 for <ltp@lists.linux.it>; Mon, 13 Nov 2023 17:02:02 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0B685216DC;
 Mon, 13 Nov 2023 16:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1699891322;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M1iStFSNdaUcxqOTt9yYCrRVVkbgeQB9nuOxTqB3wiQ=;
 b=kFrdpi4qr8KvIth+aOs1SXtsnUTMxTtJ3AkTMjLwnTzx0bRn96Z2EG+K0zryr5R3E+b/lf
 q2nRoohquZFcPE+yAGw//7prShGWmzZMX+8m2Xl075oLYaatYXOjg3FzaMOeDMMQTp5Wxx
 RQ//o0xMCWeRGR6SOpL0KjNmCTmPgrw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1699891322;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M1iStFSNdaUcxqOTt9yYCrRVVkbgeQB9nuOxTqB3wiQ=;
 b=uvQckcjudZ1pePtvq+vMlkTwgeh0oyHpYkx3VWsjqG8diXauZMsg6wv+uMCSXFMB4gDjKI
 o9SM5mHGY3vQOpAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC6F613398;
 Mon, 13 Nov 2023 16:02:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jsWQNHlIUmUlXQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 13 Nov 2023 16:02:01 +0000
Date: Mon, 13 Nov 2023 17:02:00 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20231113160200.GD2231337@pevik>
References: <20231030110107.4528-1-andrea.cervesato@suse.de>
 <20231030110107.4528-3-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231030110107.4528-3-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] Remove fsx runtest suite
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

runltp also has fsx part, which needs to be deleted:

    # The fsx-linux tests use the SCRATCHDEV environment variable as a location
    # that can be reformatted and run on.  Set SCRATCHDEV if you want to run
    # these tests.  As a safeguard, this is disabled.
    unset SCRATCHDEV
    [ -n "$SCRATCHDEV" ] && \
    {
         cat ${LTPROOT}/runtest/fsx >> ${TMP}/alltests ||
         {
             echo "FATAL: unable to create  fsx-linux tests command file"
             exit 1
         }
    }

With that removed, you can add:
Reviewed-by: Petr Vorel <pvorel@suse.cz>

BTW I also wonder if we still need testscripts/ltp-aiodio.sh.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
