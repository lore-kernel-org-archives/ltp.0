Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C2FC78830
	for <ltp@archiver.kernel.org>; Fri, 20 Sep 2024 12:24:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1BEC43C3063
	for <ltp@archiver.kernel.org>; Fri, 20 Sep 2024 14:24:15 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 92C3F3C0F4D
 for <ltp@lists.linux.it>; Fri, 20 Sep 2024 14:23:58 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5ABE314098C7
 for <ltp@lists.linux.it>; Fri, 20 Sep 2024 14:23:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A45051F80B;
 Fri, 20 Sep 2024 12:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1726835035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DmRKV+M48OK+CHFKSstoCzMU194oyvynCsMP0AKsfHo=;
 b=TP4eHG/ZQS4RQMuKM7b2VwWuVUOiG75G6ijiv6ybSKwlz2WXg50sHuxkOcDx1T5GlUNph4
 4d+qZkNQrRdIWaiY8VSIzlsjiqQcQC1mQz6OuXsZTJ9uX+R+boGP8JIcXEU/kmoWPuYRFB
 1RJRqgpLaJ0W9toGPlI7sKE97dadWaE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1726835035;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DmRKV+M48OK+CHFKSstoCzMU194oyvynCsMP0AKsfHo=;
 b=giMcwV5Zqm5W0XtccO3UPb93LIJ10KGVaIvEY3l68edEG4JkIJZyEmmpDxlqTkTEEzHWnw
 8rCTdgCxo0J5fcBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1726835035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DmRKV+M48OK+CHFKSstoCzMU194oyvynCsMP0AKsfHo=;
 b=TP4eHG/ZQS4RQMuKM7b2VwWuVUOiG75G6ijiv6ybSKwlz2WXg50sHuxkOcDx1T5GlUNph4
 4d+qZkNQrRdIWaiY8VSIzlsjiqQcQC1mQz6OuXsZTJ9uX+R+boGP8JIcXEU/kmoWPuYRFB
 1RJRqgpLaJ0W9toGPlI7sKE97dadWaE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1726835035;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DmRKV+M48OK+CHFKSstoCzMU194oyvynCsMP0AKsfHo=;
 b=giMcwV5Zqm5W0XtccO3UPb93LIJ10KGVaIvEY3l68edEG4JkIJZyEmmpDxlqTkTEEzHWnw
 8rCTdgCxo0J5fcBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9201E13AA7;
 Fri, 20 Sep 2024 12:23:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hDlbI1tp7WYWKAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 20 Sep 2024 12:23:55 +0000
Date: Fri, 20 Sep 2024 14:22:50 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Haifeng Xu <haifeng.xu@shopee.com>
Message-ID: <Zu1pGq6bklSY3SSZ@yuki.lan>
References: <20240920083036.87291-1-haifeng.xu@shopee.com>
 <Zu05HskauxnYheRd@yuki.lan>
 <82a1294f-f15a-4c1b-aee7-703e4ff84120@shopee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <82a1294f-f15a-4c1b-aee7-703e4ff84120@shopee.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ht_affinity.c: fix ht_affinity test failure
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
> From the kernel source code, the user_mask_ptr is unsigned long.
> 
> SYSCALL_DEFINE3(sched_setaffinity, pid_t, pid, unsigned int, len,
> 		unsigned long __user *, user_mask_ptr)
> 
> so maybe we can keep the type of user_mask_ptr consistent with it.

It's actually accessed as an array. See get_user_cpu_mask() function just
above this syscall definition and userspace is suppose to pass an array
big enough for all the flags of CPUs it cares about.

There are also macros in the libc sched.h header that allows you to
allocate an array big enough for the current machine and manipulate the
bits, see man CPU_ALLOC.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
