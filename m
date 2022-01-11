Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E22C433FE
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 10:54:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1636B3C93FA
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 11:54:31 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 315463C90AA
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 11:54:20 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3075E1000D3D
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 11:54:19 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4E3221F3B1;
 Tue, 11 Jan 2022 10:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641898459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2TpCWWPAR46SccVIMKED1x6C3qmfG3HwJNUnZqxkIYA=;
 b=n8mU5T3WLnLoyBjHrAv3f+Eg68Vf3VseYhbt1yOcDLBNM12NL96PNjExantWJxkthwZQ5C
 B5Alt5Vfojyi+FdVogcsRMMCrCJRyentCFrbUbsck4H0DVgMGx/lvqNwTIoAqEjBBnhxGz
 K7Kv68o21CjZhjp7y999TzqyzMrydHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641898459;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2TpCWWPAR46SccVIMKED1x6C3qmfG3HwJNUnZqxkIYA=;
 b=eKx9jtbwIQqQzzhhVn2NrlSY8B3e3zJTVYL/OlYBfkTCYlJg2j19fzCn2SGbcb4kYLBdTx
 ena8jOwPegH856DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3C06C13AC9;
 Tue, 11 Jan 2022 10:54:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wSlfDdth3WELbQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 11 Jan 2022 10:54:19 +0000
Date: Tue, 11 Jan 2022 11:55:54 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <Yd1iOp2I5LrJtJDz@yuki>
References: <YY0o7jAxgIHvmczq@yuki>
 <1639380414-24390-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639380414-24390-5-git-send-email-xuyang2018.jy@fujitsu.com>
 <YdhhTeot7Z9861B0@yuki> <61DBD6D0.1000104@fujitsu.com>
 <YdxGrO40TwVJmeWG@yuki> <61DD2937.6060609@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <61DD2937.6060609@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 5/6] syscalls/quotactl09: Test error when quota
 info hidden in filesystem
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> >So we pass a fd that
> > points to a device and we expect ENOTBLK if tst_variant == 1 and
> > exp_err == ENOTBLK? That does not sound fine, what do I miss?
> We skip ENOTBLK error test when tst_variant ==1
> 
>    	if (tst_variant) {
>    		if (tc->exp_err == ENOTBLK) {
>    			tst_res(TCONF, "quotactl_fd() doesn't have this error, skip");
>    			return;
>    		}
>    	}

Ah, that's what I have missed. But still, what happen if we pass fd to a
regular file to the quotactl_fd()? Shouldn't we test that case too?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
