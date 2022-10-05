Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF91C433F5
	for <ltp@archiver.kernel.org>; Wed,  5 Oct 2022 11:22:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 069AB3CAE06
	for <ltp@archiver.kernel.org>; Wed,  5 Oct 2022 13:22:56 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 37E1F3C9669
 for <ltp@lists.linux.it>; Wed,  5 Oct 2022 13:22:46 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3F606200119
 for <ltp@lists.linux.it>; Wed,  5 Oct 2022 13:22:45 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2FF6F1F8B6;
 Wed,  5 Oct 2022 11:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1664968965;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=glIn+LEDysLJi5sA853bICNktQoSwiylJxTjDkCSrB8=;
 b=k3CWJnqLlDLQCKwmrkSObQ0ePSnsGL2Nk3NLZffyvypyg4PVdVjNZYwRSxrN02OzCNZJx8
 OIaHtPeacb8hcMkCJYxHIgjkAsZRwIwi67qktbF7gpDqywFFE4M7rrN5ITWvhlVrD0r6/2
 +4Ez9TdeK5aBtEKjgHXrh5t0FaC6T/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1664968965;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=glIn+LEDysLJi5sA853bICNktQoSwiylJxTjDkCSrB8=;
 b=eLiwoApW7fGToQSmagTs6ltleAUZdHk1uWE4BX+SeUIWY0XbfllM9KcYzx2APwNsj0y2Hm
 qeSKiS6/+IcMiVBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0438313345;
 Wed,  5 Oct 2022 11:22:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id q1w8OwRpPWPWSwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 05 Oct 2022 11:22:44 +0000
Date: Wed, 5 Oct 2022 13:22:43 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Yz1pA9slozqE09GE@pevik>
References: <20221004182040.1859774-1-edliaw@google.com>
 <Yz1c8XAKPmNkaFYn@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yz1c8XAKPmNkaFYn@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 0/9] mmapstress01: refactor to ltp framework
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
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Hi!
> The code is heading into the right direction but there are couple of
> things to do (can be done in an incremental manner too):

> * Most of the remaning tst_brk(TFAIL, "..") should actually be
>   tst_brk(TBROK, "..") at least all the cases where we call
>   a syscall and it fails. And we should include the TERRNO flag
>   as well to get the actual error printed.

> * The test should make use of runtime instead of the alarm()
>   for test duration. That would mean getting rid of the -t option and
>   using the -I option instead. Also the test should set up some
>   .test_runtime for a default run duration in the tst_test structure.

> * The top level comment has to be updated for the changes in the test
>   since the options structure describes the command line parameters
>   quite well I would just remove that part from the comment

I'd also squash at least same changes if not all (update licence, reorder vars,
make check fixes, ...  IMHO does not need to be in a separate commit).

While in it, it'd be worth the test had default parameters. i.e. -p X not having
to pass, and use the default 20. The same applies for -I (which should replaced -t).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
