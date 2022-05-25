Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D649FC433F5
	for <ltp@archiver.kernel.org>; Wed, 25 May 2022 08:19:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 201383CAC67
	for <ltp@archiver.kernel.org>; Wed, 25 May 2022 10:19:25 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 66A1B3C0895
 for <ltp@lists.linux.it>; Wed, 25 May 2022 10:19:14 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 775EB600848
 for <ltp@lists.linux.it>; Wed, 25 May 2022 10:19:13 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 579DB1F905;
 Wed, 25 May 2022 08:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1653466752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PyCiD4u2QModbE8Dc9AKdgrk6e6Q6ROYftCu4pH6pxg=;
 b=oqjpP49yG0/4+UEzvRML6FVOg4KJC+e4L/XyqQnc/XljKPtZdAxjN5mPru913kbe7XMevE
 H3XTBqTjLjsOcgrbq/PQTa5hUp1eROrIQtg+1yhxpN8IcX9Iu40i+eMjHo34wdS52t7w/g
 m5OxxmJ9gJcizWIPX5fPtOxJ5P+Qozw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1653466752;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PyCiD4u2QModbE8Dc9AKdgrk6e6Q6ROYftCu4pH6pxg=;
 b=ohq+v6vPEVhCthMI+BgsdidkfFDtWsg8L7MvWm0tVo/eiZnZtf1AQJHl3FENFdqp+mKcUv
 t4RgpDJMb7ri2TAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4544B13ADF;
 Wed, 25 May 2022 08:19:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id x0RWEIDmjWK2MAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 25 May 2022 08:19:12 +0000
Date: Wed, 25 May 2022 10:21:20 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Yo3nAGS+R3IwYYy9@yuki>
References: <YozXG/f0HHSrhm9E@yuki>
 <20220525065124.2665801-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220525065124.2665801-1-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] preadv203: set max_runtime to 270s
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Before the runtime patchset preadv203 use 5min as default timeout
> per fs, that's really long enough for prepare_device(). But after
> that, its now only has 30s which might be short for a slower system
> to do preparation work.
> 
> Let's set max_runtime to 270s to make the timeout at least equal
> to previously.

Isn't the main reason why the test fails that the verify_preadv2()
function spins for at most 60 seconds?

I guess that the proper solution should be:

diff --git a/testcases/kernel/syscalls/preadv2/preadv203.c b/testcases/kernel/syscalls/preadv2/preadv203.c
index 01622ad15..e9377071e 100644
--- a/testcases/kernel/syscalls/preadv2/preadv203.c
+++ b/testcases/kernel/syscalls/preadv2/preadv203.c
@@ -199,7 +199,6 @@ static void *cache_dropper(void *unused)
 static void verify_preadv2(void)
 {
        pthread_t reader, dropper, writer;
-       unsigned int max_runtime = 600;
        void *eagains;

        stop = 0;
@@ -210,7 +209,7 @@ static void verify_preadv2(void)
        SAFE_PTHREAD_CREATE(&reader, NULL, nowait_reader, NULL);
        SAFE_PTHREAD_CREATE(&writer, NULL, writer_thread, NULL);

-       while (!stop && max_runtime-- > 0)
+       while (!stop && tst_remaining_runtime())
                usleep(100000);

        stop = 1;
@@ -280,4 +279,5 @@ static struct tst_test test = {
        .mount_device = 1,
        .all_filesystems = 1,
        .needs_root = 1,
+       .max_runtime = 60,
 };

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
