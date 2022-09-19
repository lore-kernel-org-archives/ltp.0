Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E760EC54EE9
	for <ltp@archiver.kernel.org>; Mon, 19 Sep 2022 15:32:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 42FD73CACF0
	for <ltp@archiver.kernel.org>; Mon, 19 Sep 2022 17:32:03 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9313C3C8D45
 for <ltp@lists.linux.it>; Mon, 19 Sep 2022 17:31:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BDB866002BF
 for <ltp@lists.linux.it>; Mon, 19 Sep 2022 17:31:52 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DB3D122098;
 Mon, 19 Sep 2022 15:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663601511;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AQD0QXILR4o6QkC/dPak9H1CGjcqaK6QNVWx46R14d4=;
 b=ty0bm9Nj5SI/gQ5dBOEqmHUw7SE7Cf2JyiaPhC8Rp4kArkB/k9n83gAWYr0DRFqL87rFiQ
 E86AYMRMmlkoK5TUnWUFWvUbfWIYQPG1q9/+0ZzPvF72p/wdPoDSLDtZmOnh/kt3VQOZwr
 1YTpUsNpsxiq7RkHXc5buOl1CZwZg+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663601511;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AQD0QXILR4o6QkC/dPak9H1CGjcqaK6QNVWx46R14d4=;
 b=KrgWJLLgOJMxIkPdKlWJOgShqf019dxxWCmi1CNBkXiWs5gNTULjgqL23weTTqLz3AGlmL
 GuNFFOdesboUlRAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C18FA13A96;
 Mon, 19 Sep 2022 15:31:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id FFB5LmeLKGOpegAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 19 Sep 2022 15:31:51 +0000
Date: Mon, 19 Sep 2022 17:31:50 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YyiLZoSRWPgs8Cfh@pevik>
References: <Yxr+EpKTnKQbKXTb@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yxr+EpKTnKQbKXTb@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] September LTP release
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

Hi all,

FYI my patchset "v6 shell: df01.sh: $TST_ALL_FILESYSTEMS]" introduced a
regression in ima_keys.sh and follow-up IMA/EVM related tests.
I'm sorry, I'll fix it ASAP, hopefully this week.

ima_keys 1 TINFO: $TMPDIR is on tmpfs => run on loop device
ima_keys 1 TINFO: Formatting ext3 with opts='/dev/loop0'
ima_keys 1 TINFO: Mounting device: mount -t ext3 /dev/loop0 /tmp/LTP_ima_keys.YArl935DCg/mntpoint
ima_keys 1 TCONF: IMA policy does not specify '^measure.*func=KEY_CHECK'
tst_device.c:255: TWARN: ioctl(/dev/loop0, LOOP_CLR_FD, 0) no ENXIO for too long

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/list/?series=318458&state=*


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
