Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7462EC433F5
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 13:00:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA1F83C925A
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 13:59:58 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE28E3C0E02
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 13:59:48 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 881241401277
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 13:59:47 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9F80D21138;
 Tue, 21 Dec 2021 12:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1640091586;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ROBa35Y26BGQTTb4ebSr4AZW0QhwQPzlFyZR/3ITbJc=;
 b=Nmnx0OlfXe6efPvJITpuyAxXlg9w3g8dFgaVaXfLBn1wIakYTuXA+42xEKK0A7zeX6FYu2
 tAX8pEJI7GudQ91aHOlLJKlGj3zFSXdXjsp3XvH3atwGU63hefv6eG/9H0tAi9zTiPNz6G
 WrNRI7GLbuY81crb0tsgpwJJZJc7Jf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1640091586;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ROBa35Y26BGQTTb4ebSr4AZW0QhwQPzlFyZR/3ITbJc=;
 b=kvD4UET0pVKResM8nbo32AZqNZ4JlfLlHIVS3hvTg+Ygwy0+ssKk1A2jwPT0aRKvd/0rFF
 SdF5KP7fiN7DalDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5C7DF13C3D;
 Tue, 21 Dec 2021 12:59:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1ThNFMLPwWFjJQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 21 Dec 2021 12:59:46 +0000
Date: Tue, 21 Dec 2021 13:59:44 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YcHPwLEoZlX2uA+m@pevik>
References: <CAEemH2eZDBODpZwjcCq=M=wT0uiSUSM+iS88F7-OQP-pkYRn=A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2eZDBODpZwjcCq=M=wT0uiSUSM+iS88F7-OQP-pkYRn=A@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Question] Why test C API failed in github CI
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

> Hi Petr and all,

> Firstly, I'm sorry to push the patchset about oom protection cursorily.

> The GitHub CI complained about the following failures, I feel confused
> when I add a bit of debug code in my private branch then. It gets passed
> in access(score_path, R_OK|W_OK) but failed in closing the file and
> give no EACCESS errno, that's wired.

> Did I miss anything?

> https://github.com/wangli5665/ltp/runs/4594473907?check_suite_focus=true

Well, looking at the upstream failure:
https://github.com/linux-test-project/ltp/runs/4594201240?check_suite_focus=true
tst_memutils.c:114: TWARN: Failed to close FILE '/proc/93483/oom_score_adj'
=> FILE_PRINTF(score_path, "%d", value);
tst_memutils.c:120: TWARN: '/proc/93483/oom_score_adj' cannot be set to -1000, are you root?
=> tst_res(TWARN, "'%s' cannot be set to %i, are you root?",

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 2 => non zero exit => test fail.

I meant in my comment in [1] that only when running as root you can adjust for
values < 0. Because we run it for each test in the library, including non-root.
There needs to be test for root on value < 0 at the beginning with return.

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/YcGRST7vAycVk0AA@pevik/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
