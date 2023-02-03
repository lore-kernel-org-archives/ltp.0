Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C727C636D6
	for <ltp@archiver.kernel.org>; Fri,  3 Feb 2023 10:26:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 97B563CC380
	for <ltp@archiver.kernel.org>; Fri,  3 Feb 2023 11:26:03 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B79BB3CB26A
 for <ltp@lists.linux.it>; Fri,  3 Feb 2023 11:25:52 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BFCF1200131
 for <ltp@lists.linux.it>; Fri,  3 Feb 2023 11:25:51 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ABF822103E;
 Fri,  3 Feb 2023 10:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1675419950;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qb0VWRWtOnqLHhC+HcF6dLCTac2EUKdmXyNA7mnfic0=;
 b=Se85m+fehJu0bmepCLe5DcJ8YIJAhjjnvAEKGVY7XpSie1/j25bX4IHM1XjDb5ca7JwSq7
 Mk02PEIgh/hNAr56artSMZCGHY38meyQ4RM7A8YgRoSkiMo7cl4EEywtD07AbnLx8cQcyA
 Fvt/XqmpsVVX93A7P3D4PQIcQt6/6CM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1675419950;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qb0VWRWtOnqLHhC+HcF6dLCTac2EUKdmXyNA7mnfic0=;
 b=KCSCk6G9rhzowA/Z3HX/l5nqUUGKUdmge838ILp0ssqW54eYXLbsl53I5GiNNQLsvRD9jo
 LltoizzAa8NHBSDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 74D971358A;
 Fri,  3 Feb 2023 10:25:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id xz45Gi7h3GOVMAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 03 Feb 2023 10:25:50 +0000
Date: Fri, 3 Feb 2023 11:25:48 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Edward Liaw <edliaw@google.com>, Jan Stancek <jstancek@redhat.com>,
 ltp@lists.linux.it, kernel-team@android.com, Li Wang <liwang@redhat.com>
Message-ID: <Y9zhLO27YMWd6p6n@pevik>
References: <20230131002532.459456-1-edliaw@google.com>
 <Y9paGafh97zKnu/j@pevik>
 <CAG4es9V2773dyVrDwt7fiUq=VkUrn0Tr8icCC=X3xx+RGrbR9A@mail.gmail.com>
 <Y9trG4QnXUEbhBbJ@pevik>
 <CAASaF6xQPu1ZgAFKMLjbLtcP4woq7+uQ_H4phB5TO_6CLsy_kQ@mail.gmail.com>
 <Y9tyNEspOUlHMOGU@pevik>
 <CAG4es9X=_vaE_3oX4JD598BNSX8RmQmAKVJS2kZdE1XzUjRu+A@mail.gmail.com>
 <Y9zfkeF3MdzMeizT@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y9zfkeF3MdzMeizT@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] close_range: check for kernel support below 5.9
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

hm, I was too fast to merge it. Looking at older result, 
It looks like this (merged as 7b5ee03899) was not needed,
because tst_syscall() properly detects missing support:

close_range01.c:134: TINFO: Plain close range
../../../../include/lapi/close_range.h:25: TCONF: syscall(436) __NR_close_range not supported on your arch

@Edward: Before we revert it, did you encounter some problem that it's really
needed? If yes, please share details.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
