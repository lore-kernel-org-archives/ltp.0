Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E74C19F2D
	for <ltp@archiver.kernel.org>; Thu, 11 Aug 2022 08:10:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 753973C954C
	for <ltp@archiver.kernel.org>; Thu, 11 Aug 2022 10:10:42 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 213393C1B55
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 10:10:32 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3B60B600845
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 10:10:31 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0053F2200D;
 Thu, 11 Aug 2022 08:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660205339;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ou7E9tMY1eaP+pJ6yaavaaDmHDjTlQySoQXUdbxJ7po=;
 b=QfFhdoJDCb9br3xZC7O5lAc3FdbyjSUJCoAqsxIbmvEwLsYBweFeJEmz1v1Lca8i2Xn35G
 xobbuEyTms0Qh1nSgKGIYKvFUTDnAYGopH6l05b+YoCnZUxuaS7+H2v7IpRqvvYbd+xJFZ
 i6/CSrTqzIXOoCKze+HDjilcEs0F/2I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660205339;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ou7E9tMY1eaP+pJ6yaavaaDmHDjTlQySoQXUdbxJ7po=;
 b=IljQxy/+yijiaNpQxTDJhQwS1XYeELvfJgBNniYPrYY3ddXW7UnnPMSXvlTBm46sMMnAnG
 tzUXA9p5SFdLQVDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CD7EE13A9B;
 Thu, 11 Aug 2022 08:08:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EwXjMBu59GLXSQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 11 Aug 2022 08:08:59 +0000
Date: Thu, 11 Aug 2022 10:08:58 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YvS5GomHJ4FOlzFI@pevik>
References: <20220808113756.11582-1-pvorel@suse.cz>
 <20220808113756.11582-4-pvorel@suse.cz>
 <7d501d57-2438-cd28-5e49-019ea06fb8f2@suse.cz>
 <YvPdB6YhTlDAlPBR@pevik>
 <18ff8839-7a73-306f-9c3d-1078e8e309d3@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <18ff8839-7a73-306f-9c3d-1078e8e309d3@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 3/4] tst_test.sh: Fix _tst_cleanup_timer() on
 set -e
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

> On 10. 08. 22 18:29, Petr Vorel wrote:
> > Hi Martin,

> >> Hi,
> >> a comment explaining why this is needed would be nice, otherwise looks
> >> good. For patches 2 and 3:

> >> Reviewed-by: Martin Doucha <mdoucha@suse.cz>

> >> On 08. 08. 22 13:37, Petr Vorel wrote:
> >>> If test exits on time (i.e. no timeout) kill in _tst_cleanup_timer()
> >>> have nothing to kill therefore following wait exits 143.
> > I thought this is the explanation. Or would you prefer anything else to add?

> The commit message will get buried deep in Git history. It's better to
> comment this in the code because it's not obvious why the "|| true" is
> needed after "wait ..."
Ah, didn't get "comment" means comment in the code. Makes sense, thx!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
