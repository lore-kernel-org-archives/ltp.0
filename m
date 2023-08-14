Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C2EC04A6A
	for <ltp@archiver.kernel.org>; Mon, 14 Aug 2023 14:05:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 72E133CCDF3
	for <ltp@archiver.kernel.org>; Mon, 14 Aug 2023 16:05:04 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A6E363C8946
 for <ltp@lists.linux.it>; Mon, 14 Aug 2023 16:04:54 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F1489200042
 for <ltp@lists.linux.it>; Mon, 14 Aug 2023 16:04:53 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B3E221F383;
 Mon, 14 Aug 2023 14:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1692021890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZbbYWFPOg43Tedeq7OrFf5gQSAXl7ANuO7BP+5Qd88c=;
 b=k6pI4lYbWSvvX/5fqtO4rksjGRmJKiCMHXrYzSB16wPMKw4cU9T1KV1dqnDvrhdLbF7PrK
 pjhLBuwTmABOHSJttnvcJSwEYONvMb5UfVpxg28C87YB3dNFffRQDJIabXR0qFrzHr5J/Y
 jw6D/BHyPx+PnGHw59sjwGocPMihQ7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1692021890;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZbbYWFPOg43Tedeq7OrFf5gQSAXl7ANuO7BP+5Qd88c=;
 b=0dJckBQqZuAk8/AhvouSDOH/KBzZ+cmhCxH7eyfZtii8ks4h9wi6KHIkkqF0UJD+MeU9tS
 /o+jfNp7KHfS+cDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A06EE138EE;
 Mon, 14 Aug 2023 14:04:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 79phJYI02mQVbwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 14 Aug 2023 14:04:50 +0000
Date: Mon, 14 Aug 2023 16:05:49 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <ZNo0vT2TwzqZYmZ3@yuki>
References: <1692012648-1970-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1692012648-1970-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/3] syscalls/setgroups01: Convert to new API
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
The original test used the getgroups syscall to get the list of groups
and its size. I've changed the code to match the behavior and pushed,
thanks.

Diff:
diff --git a/testcases/kernel/syscalls/setgroups/setgroups01.c b/testcases/kernel/syscalls/setgroups/setgroups01.c
index ca01997ae..9a5b77e93 100644
--- a/testcases/kernel/syscalls/setgroups/setgroups01.c
+++ b/testcases/kernel/syscalls/setgroups/setgroups01.c
@@ -27,7 +27,8 @@ static void verify_setgroups(void)
 
 static void setup(void)
 {
-       if (GETGROUPS(len, list) < 0)
+       len = GETGROUPS(NGROUPS, list);
+       if (len < 0)
                tst_brk(TBROK | TERRNO, "getgroups() Failed");
 }

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
