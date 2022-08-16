Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E3F3C2BB41
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 09:07:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A67AC3C981C
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 11:07:02 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A2F0D3C1FED
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 11:06:52 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 39F7020014C
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 11:06:51 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 529331FB00;
 Tue, 16 Aug 2022 09:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660640811;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=drvi9Ts531WB7YbVuvc2iUVNLKHPhznSGbXtuqgdEM4=;
 b=MF1zGli1cpaZMc2TCJwfWCsKwZ7i45gMRmOHkdK4tv44KnIPpGtn74unMi/4ClY9Ctt+ve
 eThc6TGBKuAVHEBhl0VBLZTkjt5H/Lu6ckJLWFKOdgsHQkCGWAmuMWsarStSZZJIqlIgRk
 a13S0OEe2w5D+zsudihL+qwxWTUm2Ag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660640811;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=drvi9Ts531WB7YbVuvc2iUVNLKHPhznSGbXtuqgdEM4=;
 b=2iQhifK/RZe27CDJ/xCfd6GfIpCMkUZFRXbB/5oKxrwBJwVYqJpwHJsQbk+oaGp1XdhG5c
 pB5ORmQ2+GPdSABQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1EEC9139B7;
 Tue, 16 Aug 2022 09:06:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id WQ+0BCte+2K5bwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 16 Aug 2022 09:06:51 +0000
Date: Tue, 16 Aug 2022 11:06:49 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YvteKeEbQ9aSLwnm@pevik>
References: <20220811135731.2228-1-pvorel@suse.cz>
 <765b4f35-2cd0-04e1-e405-04261b5ef645@fujitsu.com>
 <YvnqZfyByO42kAX9@pevik>
 <09a4ff13-eaf1-6a97-f868-893c56ac6b4c@fujitsu.com>
 <YvtcmjNXd1P18V1g@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YvtcmjNXd1P18V1g@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 0/2] mount03: Convert to new API
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > So I think you should use  SAFE_SETREUID(nobody_uid, nobody_uid);
> > and then use code as below:

> > 	if (WIFEXITED(status)) {
> > 		switch (WEXITSTATUS(status)) {
> > 		case EXIT_FAILURE:
> > 			tst_res(TPASS, "%s passed", TESTBIN);
> > 			return;
> > 		case EXIT_SUCCESS:
> > 			tst_res(TFAIL, "%s failed", TESTBIN);
> > 			return;
> > 		default:
> > 		case TBROK:
> > 			break;
> > 		}
> > 	}

> Can we please stop propagating test success/failure via the exit value?

> The problem have been solved years ago by the new test library, the
> child just need to call tst_reinit() and tst_res() will work directly
> from the child as well. See execlp01.c for example how that works.

Ah, thanks! I should have read C API docs once more (it's in "1.8 Doing the test
in the child process"). At this point there are so many changes => I'll post v4
and cleanup the child as well.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
