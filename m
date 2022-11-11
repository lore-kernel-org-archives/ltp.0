Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E9E6C433FE
	for <ltp@archiver.kernel.org>; Fri, 11 Nov 2022 14:02:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D19523CD5F7
	for <ltp@archiver.kernel.org>; Fri, 11 Nov 2022 15:02:46 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 721993CD574
 for <ltp@lists.linux.it>; Fri, 11 Nov 2022 15:02:37 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 860E614011A2
 for <ltp@lists.linux.it>; Fri, 11 Nov 2022 15:02:36 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 281A521CB1;
 Fri, 11 Nov 2022 14:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1668175355;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6Rkj0TeITLEmxUyxxofB76uf5xNHbrHjWmlq5viIXvA=;
 b=HJRLJU3aFrpBpqhStAHvZ3DQ+tZyt1uCpD213T5yrnSl32p3Qtjmpxkd+FQi9ynzpvCrwO
 8Mra31mjt+L15cAASIEdwntbnhz/AmJ/xxuYOhEtf3zg4gitfzAzfxBbLcAiUEZnYRPIBJ
 MIm4slrdYF/HZtJuuEwFzJYadck2MUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1668175355;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6Rkj0TeITLEmxUyxxofB76uf5xNHbrHjWmlq5viIXvA=;
 b=Ras6tPfHCkZGDtfPZYE+5SnJvO8asWr9FyOm/uumygWmiElWWNpzeMPuwk4/c0DpMXs0EC
 1uk/GdY0X4TVBdDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DEA5213273;
 Fri, 11 Nov 2022 14:02:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id LU60MvpVbmP6fwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 11 Nov 2022 14:02:34 +0000
Date: Fri, 11 Nov 2022 15:02:32 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Y25V+CGv2GVd/LXW@pevik>
References: <20221110135442.14501-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221110135442.14501-1-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Allow graceful subtest cleanup in shell tests
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

Hi Martin,

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Thanks!

> The new shell test timeout code sends SIGTERM to any subprocesses when
> the main script hits timeout. SIGTERM isn't handled by the LTP library
> which means that tools like netstress will be instantly killed without
> performing any cleanup. Handle SIGTERM like SIGINT in LTP library
> to allow graceful cleanup.

Besides this, Cyril some time ago suggested to define TST_NO_DEFAULT_MAIN in
nfs05_make_tree.c [1], which is also helper like netstress.c.

Looking what this would be required for netstress.c: implement function it's own
tst_brk(), which would call cleanup() function before calling library's
tst_brk(), parsing getopt parameters, calling setup() in main() etc.
The only thing which works is tst_res() and tst_brk() printing.
I'm not sure if this is worth just to avoid problematic timeout.

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/YqxFo1iFzHatNRIl@yuki/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
