Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E11ECAAD5
	for <ltp@archiver.kernel.org>; Tue,  6 Sep 2022 15:38:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD4C73CA971
	for <ltp@archiver.kernel.org>; Tue,  6 Sep 2022 17:38:23 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2731D3C071D
 for <ltp@lists.linux.it>; Tue,  6 Sep 2022 17:38:14 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2748210008F5
 for <ltp@lists.linux.it>; Tue,  6 Sep 2022 17:38:13 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9B1F233946;
 Tue,  6 Sep 2022 15:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662478692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CcgTHFtfr7h7lI6BuN/DCUUij7oa7TmVujGsj3DhWZI=;
 b=NpjAalFnE+3wKWDc+Cb6vQqh3BQnviWtgczp5+c0nz99DCdBjugqnVVKpbNHv4BwHDKZrv
 S164GYaB1TYZq3I6V7wXix65S3FVqFP4kkiO/TtF1lPjJy1QYIE2KxoW6fNeEoAEkj38S+
 8YnM30B+0AVRiYgq9s307l2vioP3v+Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662478692;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CcgTHFtfr7h7lI6BuN/DCUUij7oa7TmVujGsj3DhWZI=;
 b=F9YS1d2V31WTGgIS31GjD2JKcpdQ08OIs8o/lZg5a5VQy6JOvuUeAZVmo8dpLZc6YieqAl
 +0KDQhnzrw5QQaDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8D57513A19;
 Tue,  6 Sep 2022 15:38:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /rZ5ImRpF2OaIAAAMHmgww
 (envelope-from <jack@suse.cz>); Tue, 06 Sep 2022 15:38:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 07D0EA067E; Tue,  6 Sep 2022 17:38:12 +0200 (CEST)
Date: Tue, 6 Sep 2022 17:38:11 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20220906153811.uigc6dfxsyes5fhi@quack3>
References: <20220905154239.2652169-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220905154239.2652169-1-amir73il@gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/9] Fanotify tests for FAN_MARK_IGNORE
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it,
 Matthew Bobrowski <repnop@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Amir!

On Mon 05-09-22 18:42:30, Amir Goldstein wrote:
> FAN_MARK_IGNORE feature was merge in v6.0-rc1.
> A man page draft was posted here [1].
> 
> Following are the tests for the new feature.
> 
> All new test cases are skipped on old kernels.
> 
> Note that fanotify10 will run ALL of its existing test cases
> in two variants:
> 1. Legacy FAN_MARK_IGNORED_MASK
> 2. New FAN_MARK_IGNORE
> 
> On old kernels, only the first variant of the test will run.
> 
> In addition to the new test variant it also has some new test cases
> that only run with new FAN_MARK_IGNORE variant.

Thanks for the tests! They look good to me although I have to admit my head
starts to spin with the number of combinations and variations in fanotify10
testcase so I'm not very confident some subtle bug could not slip in. But
hey, it's just tests and they are easy to fix if some breakage slips in. So
feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
 
> [1] https://lore.kernel.org/linux-man/20220904155113.2623371-1-amir73il@gmail.com/
> 
> Amir Goldstein (9):
>   syscalls/fanotify09: Add test cases for FAN_MARK_IGNORE
>   syscalls/fanotify14: Require FAN_REPORT_FID support for entire test
>   syscalls/fanotify14: Add test cases for FAN_MARK_IGNORE
>   syscalls/fanotify10: Avoid undesired event in test
>   syscalls/fanotify10: Add more verifications and debug info
>   syscalls/fanotify10: Use dedicated mark type for inode mark on parent
>   syscalls/fanotify10: Run tests with two ignore mask variants
>   syscalls/fanotify10: Test FAN_MARK_IGNORE with FAN_EVENT_ON_CHILD
>   syscalls/fanotify10: Test FAN_MARK_IGNORE with FAN_ONDIR
> 
>  testcases/kernel/syscalls/fanotify/fanotify.h |  19 ++
>  .../kernel/syscalls/fanotify/fanotify09.c     | 102 ++++++++--
>  .../kernel/syscalls/fanotify/fanotify10.c     | 186 ++++++++++++++----
>  .../kernel/syscalls/fanotify/fanotify14.c     |  42 +++-
>  4 files changed, 290 insertions(+), 59 deletions(-)
> 
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
