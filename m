Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8576C77B75
	for <ltp@archiver.kernel.org>; Fri, 21 Apr 2023 08:04:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 19A293CB7A9
	for <ltp@archiver.kernel.org>; Fri, 21 Apr 2023 10:04:02 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E4DEF3CB7A9
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 10:03:51 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EDF911000A48
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 10:03:50 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D857521A2F;
 Fri, 21 Apr 2023 08:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1682064229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EBcAJXhSJ4/LS+aVxyTMXZKwhnqreyiwmpfhC8WB3+I=;
 b=AWDu32R3zCWfTM3SOdo/bA6mZCshYa+0qjysQGKK2dwvjDaAFeOpNLCkQduIZuMiUIPkIL
 BspNleUH8DQKrK1KsDRJacnX6/+8uCFXiH0+Ca4Uh76sx5TsOtYLfOqV5VA4SYL3+cj/wl
 QYvzApNBFpEIj5qZMywx2lHaUkvQ6ko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1682064229;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EBcAJXhSJ4/LS+aVxyTMXZKwhnqreyiwmpfhC8WB3+I=;
 b=L68ISGhZVtENUvgKxsQVzre0SHANkuLwukjSgIpYS4rQhC9W4qu5xjXyBVrivn4TdSEHL2
 cVs9aKngEfdvpTCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C4DFA1390E;
 Fri, 21 Apr 2023 08:03:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id xIGvL2VDQmRrIwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 21 Apr 2023 08:03:49 +0000
Date: Fri, 21 Apr 2023 10:04:53 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <ZEJDpYc01jMYWrV5@yuki>
References: <20230420160910.809091-1-teo.coupriediaz@arm.com>
 <20230420160910.809091-2-teo.coupriediaz@arm.com>
 <CAEemH2dCDPni4vtXhog3FcE8RkQ677NcUBAOR4BvGgyfSFwgtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dCDPni4vtXhog3FcE8RkQ677NcUBAOR4BvGgyfSFwgtQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] setpgid02: Use pid_max as PGID for EPERM
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
> I guess the '\n' is a typo added by accident,
> after removing it then:

Actually it shouldn't matter, most of the sysfs files have newline at
the end so that you can just cat them and see the value in terminal
nicely.

$ cat /proc/sys/kernel/pid_max |xxd
00000000: 3332 3736 380a                           32768.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
