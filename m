Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B43DC433FE
	for <ltp@archiver.kernel.org>; Fri, 18 Nov 2022 13:31:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C65B3CCE9E
	for <ltp@archiver.kernel.org>; Fri, 18 Nov 2022 14:31:53 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 18E733CCE37
 for <ltp@lists.linux.it>; Fri, 18 Nov 2022 14:31:45 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A5F1912DE5C6
 for <ltp@lists.linux.it>; Fri, 18 Nov 2022 14:31:44 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D0F27227AE;
 Fri, 18 Nov 2022 13:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1668778303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g3xRXJyn6WJAX6cbfxdYM+EucVPMJgyRI9N2E6j0/EU=;
 b=EyB5DAniurFl304MVHBJL5FTGKV2s8jB+Ns3lFzi5WsZzo9hLKQ0lMQROe7XBABKwYX4iw
 aJxaClJifsEXdHizdX+OpW+U638pcMrWtfhniZ2gwCAmtozzKWjX1EdNwvVibwF6coxCxB
 lkYgaolYWLeVJavyKiDt2DKbiJouRIU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1668778303;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g3xRXJyn6WJAX6cbfxdYM+EucVPMJgyRI9N2E6j0/EU=;
 b=TOi0DuhG4yVqO+KYulxleWWGv6J72UGOpZZun0nF0Je8BJCGirGD6fgMyYSiF6D7evJVdW
 W5ShjNtQBenjq9Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BBDC313A66;
 Fri, 18 Nov 2022 13:31:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id aBPxLD+Jd2OmKgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 18 Nov 2022 13:31:43 +0000
Date: Fri, 18 Nov 2022 14:33:07 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: He Zhe <zhe.he@windriver.com>
Message-ID: <Y3eJk1ugDSv+TC70@yuki>
References: <20221116102334.741189-1-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221116102334.741189-1-zhe.he@windriver.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/prctl04: Fix false positive report when
 SECCOMP_MODE_FILTER is not supported
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
I did reply to the github issue already with:

Looking at the patch, maybe it would be cleaner if we did a test if
SECCOMP_MODE_FILTER is supported in the test setup and set up a global
variable based on that, something as:

diff --git a/testcases/kernel/syscalls/prctl/prctl04.c b/testcases/kernel/syscalls/prctl/prctl04.c
index b9f4c2a10..d4e44cb1b 100644
--- a/testcases/kernel/syscalls/prctl/prctl04.c
+++ b/testcases/kernel/syscalls/prctl/prctl04.c
@@ -61,6 +61,8 @@ static const struct sock_fprog  strict = {
        .filter = (struct sock_filter *)strict_filter
 };

+static int mode_filter_supported;
+
 static void check_strict_mode(int);
 static void check_filter_mode(int);

@@ -219,6 +221,16 @@ static void setup(void)
        TEST(prctl(PR_GET_SECCOMP));
        if (TST_RET == 0) {
                tst_res(TINFO, "kernel support PR_GET/SET_SECCOMP");
+
+               TEST(prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, NULL));
+
+               if (TST_ERR == EFAULT) {
+                       mode_filter_supported = 1;
+                       tst_res(TINFO, "kernel support SECCOMP_MODE_FILTER");
+                       return;
+               }
+
+               tst_res(TINFO, "kernel doesn't support SECCOMP_MODE_FILTER");
                return;
        }

Then we can simply use the mode_filter_supported either not to print the
failure or even to skip the test to begin with.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
