Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0356CC07545
	for <ltp@archiver.kernel.org>; Tue, 24 Oct 2023 09:11:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5F4A83CF4EB
	for <ltp@archiver.kernel.org>; Tue, 24 Oct 2023 11:11:06 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D096A3CCC3D
 for <ltp@lists.linux.it>; Tue, 24 Oct 2023 11:10:56 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 68A5F1A04333
 for <ltp@lists.linux.it>; Tue, 24 Oct 2023 11:10:54 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 698F91F383;
 Tue, 24 Oct 2023 09:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698138654;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aAr/Wj8tIUb0gUN8ae2oLOQP/1HHalxpXNJhoFCGecc=;
 b=mylxDaLkXPHqBGe9TQITH+o7P8UKiVWtXATTUGjupRO+fDRCffNuixdld8/SgnXjWaHOfb
 4i02c07lJrjWqqiQSZSYvCAWBt1A4+wKWrv62teAwr+SU6h6XhDJovADrMifQYuuQsOZwV
 kWkcurfSptmIuMooPIWgn5niFckMd8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698138654;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aAr/Wj8tIUb0gUN8ae2oLOQP/1HHalxpXNJhoFCGecc=;
 b=MpzG1HlM02EqjYRiDcxDDc2DzzmB3Bz2ipVx8byF/FkhL2NmOHYAdxLnPVyVvVFiGYJHpk
 kTOkRCF9D9cnSEBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 402911391C;
 Tue, 24 Oct 2023 09:10:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id b99zDR6KN2WBewAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 24 Oct 2023 09:10:54 +0000
Date: Tue, 24 Oct 2023 11:10:52 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20231024091052.GA219060@pevik>
References: <20231014033104.31424-1-wegao@suse.com>
 <20231017131646.1297-1-wegao@suse.com> <ZTaAUO1-Jr3BbJa9@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZTaAUO1-Jr3BbJa9@yuki>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-10.28 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 NEURAL_HAM_LONG(-3.00)[-1.000]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-2.98)[99.93%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [CI FAILURE] Re:  [PATCH v4] Add test for UI_GET_NAME ioctl
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Hi!
> I've adjusted the FAIL/PASS messages and pushed, thanks.

UI_GET_NAME() from include/uapi/linux/uinput.h is not on the old CentOS 7 we
still support:

https://github.com/linux-test-project/ltp/actions/runs/6614554688/job/17964785134
/__w/ltp/ltp/testcases/kernel/input/input_helper.c:194:2: error: implicit declaration of function 'UI_GET_SYSNAME' [-Werror=implicit-function-declaration]
  SAFE_IOCTL(NULL, fd, UI_GET_SYSNAME(sizeof(sys_name)), sys_name, NULL);
  ^

I'll have look later today for the fix. I suppose we need lapi/uinput.h with
adds a fallback definition. It was added in kernel v3.15 in
e3480a61fca7 ("Input: uinput - add UI_GET_SYSNAME ioctl to retrieve the sysfs path")

Also, there is also an API version change, we could use this if simple ifndef
UI_GET_SYSNAME + fallback will not be enough (e.g. test fails because it
requires newer kernel API).

-#define UINPUT_VERSION         3
+#define UINPUT_VERSION         4

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
