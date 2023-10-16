Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F206DCDB482
	for <ltp@archiver.kernel.org>; Mon, 16 Oct 2023 08:09:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 404603CD1AA
	for <ltp@archiver.kernel.org>; Mon, 16 Oct 2023 10:09:27 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5BA3B3C869D
 for <ltp@lists.linux.it>; Mon, 16 Oct 2023 10:09:16 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4EA001A010F6
 for <ltp@lists.linux.it>; Mon, 16 Oct 2023 10:09:15 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 25E7F1FEAE;
 Mon, 16 Oct 2023 08:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697443755;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=301AbsXqpArVZFf9LTvnSoanZCKp/ZZsRv5mZvEe8p0=;
 b=Sb6bxli4Zal7P1YP0wBGLf2aoNhkid0dKVyIdj3+TC2NsOHqWtFgR8xkUdtf2hnNBFGFbh
 Mzvzda4kDAc5xwujNuFelHnxl6pWjBqODWqFcdZ30jL7iGrVMPjU5Oia9w34N+BS+FMoTz
 7Sbrmcg9B5cW+0SqmiypOFu/uVLG0WY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697443755;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=301AbsXqpArVZFf9LTvnSoanZCKp/ZZsRv5mZvEe8p0=;
 b=OBdag5aH4jV6RoZfGapsIHjH9I/kJz9LWi7rdytIvSA7KJgwm6B/5olJ/OPknqySkw2ARJ
 BZP7JDRkecgii3Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 01FA2133B7;
 Mon, 16 Oct 2023 08:09:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id C3HcOqrvLGXxBAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 16 Oct 2023 08:09:14 +0000
Date: Mon, 16 Oct 2023 10:09:13 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20231016080913.GB840411@pevik>
References: <1694770631-9547-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1694770631-9547-1-git-send-email-xuyang2018.jy@fujitsu.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [2.55 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; NEURAL_SPAM_LONG(3.00)[1.000];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.15)[68.99%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/4] readlinkat: Remove readlinkat fallback
 definition
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

Hi Yang,

> Looking at man readlinkat, it was added into kernel 2.6.16 and since the
> oldest kernel we support is 3.10 (see doc/supported-kernel-libc-versions
> .txt) we can as well completely drop this fallback definition.

Again, as I mentioned in v2 renameat() patch [1], the real reason for this lapi
function was IMHO missing glibc wrapper.  The correct git commit message should
have been glibc wrapper was added in ...

Also, without kernel support the function would not work at all, therefore it is
irrelevant when readlinkat was added into kernel. That applies to all git commit
messages. Due me merged v2 renameat() first, this is not applicable (patch must
be modified, I'm sorry).

This particular patch would deserve to note that since these 2 commits the lapi
is not even used (both released in 20230929 - a proof it can be really deleted):

0959b893a ("syscalls/readlinkat01: Convert to new API")
bcafe2971 ("syscalls/readlinkat02: Convert to new API")

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/20231016080349.GA844528@pevik/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
