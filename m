Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7383BC48BC3
	for <ltp@archiver.kernel.org>; Wed, 21 Feb 2024 09:37:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B708F3D0353
	for <ltp@archiver.kernel.org>; Wed, 21 Feb 2024 10:37:42 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5B3AB3CC92D
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 10:37:26 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 09DE420119B
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 10:37:23 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4AC9C1FB4A;
 Wed, 21 Feb 2024 09:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708508242;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5Qv6yfPXEdzAQIdJyEPjN0dQTaFxMDgsy98hbybjgzM=;
 b=vEFqjJm6XR2dDobZIYdYYRvcv7QEfGH8HFf+FcZAEp5hqb7UzIw0+DiAlCKw2k8ulqUl0O
 G+uG8QwX+ajV14YEWDdSFcQe+IWxUzzE8A1AnV66itePZn/YWffCqG64BcHS2zJQbtK5Ov
 743Xrahf0efmScfPmZLnxHroHiyLS6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708508242;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5Qv6yfPXEdzAQIdJyEPjN0dQTaFxMDgsy98hbybjgzM=;
 b=JsMgA1o7wtYliKL72h+nlWAjxBcLfXMjtO48iabrS7/j94Bhi2bwdHae80HfmktWGzJ2Nx
 xf4NAL+Ci/FVbAAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708508242;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5Qv6yfPXEdzAQIdJyEPjN0dQTaFxMDgsy98hbybjgzM=;
 b=vEFqjJm6XR2dDobZIYdYYRvcv7QEfGH8HFf+FcZAEp5hqb7UzIw0+DiAlCKw2k8ulqUl0O
 G+uG8QwX+ajV14YEWDdSFcQe+IWxUzzE8A1AnV66itePZn/YWffCqG64BcHS2zJQbtK5Ov
 743Xrahf0efmScfPmZLnxHroHiyLS6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708508242;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5Qv6yfPXEdzAQIdJyEPjN0dQTaFxMDgsy98hbybjgzM=;
 b=JsMgA1o7wtYliKL72h+nlWAjxBcLfXMjtO48iabrS7/j94Bhi2bwdHae80HfmktWGzJ2Nx
 xf4NAL+Ci/FVbAAA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 347F213A25;
 Wed, 21 Feb 2024 09:37:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id ojg2C1LE1WW1CQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Wed, 21 Feb 2024 09:37:22 +0000
Date: Wed, 21 Feb 2024 10:37:20 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20240221093720.GB1213466@pevik>
References: <20240220074218.13487-1-xuyang2018.jy@fujitsu.com>
 <20240220074218.13487-3-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240220074218.13487-3-xuyang2018.jy@fujitsu.com>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vEFqjJm6;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=JsMgA1o7
X-Spamd-Result: default: False [-2.51 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[]; DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4AC9C1FB4A
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 3/7] syscalls/swapon03: use tst_max_swapfiles()
 and GET_USED_SWAPFILES() api
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

Hi Xu,

I see swapon03 failures on aarch64 and ppc64le on SLES and openSUSE after this commit.

Here is timeout after 31s:

# ./swapon03
...
tst_test.c:1701: TINFO: === Testing on ext2 ===
tst_test.c:1117: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
mke2fs 1.47.0 (5-Feb-2023)
tst_test.c:1131: TINFO: Mounting /dev/loop0 to /tmp/LTP_swaVqwa6f/mntpoint fstyp=ext2 flags=0
tst_ioctl.c:26: TINFO: FIBMAP ioctl is supported
tst_kconfig.c:87: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:87: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:87: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:87: TINFO: Parsing kernel config '/proc/config.gz'
Test timeouted, sending SIGKILL!
tst_test.c:1679: TINFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
tst_test.c:1681: TBROK: Test killed! (timeout?)

Summary:
passed   0
failed   0
broken   1
skipped  0
warnings 0
### TEST swapon03 COMPLETE >>> 2.

I tried to run with .max_runtime = 60, but even then it fails after 1m 30s:
...
tst_supported_fs_types.c:97: TINFO: Kernel supports tmpfs
tst_supported_fs_types.c:49: TINFO: mkfs is not needed for tmpfs
tst_test.c:1701: TINFO: === Testing on ext2 ===
tst_test.c:1117: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
mke2fs 1.47.0 (5-Feb-2023)
tst_test.c:1131: TINFO: Mounting /dev/loop0 to /tmp/LTP_swaQsjhAp/mntpoint fstyp=ext2 flags=0
tst_ioctl.c:26: TINFO: FIBMAP ioctl is supported
tst_kconfig.c:87: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:87: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:87: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:87: TINFO: Parsing kernel config '/proc/config.gz'
Test timeouted, sending SIGKILL!
tst_test.c:1679: TINFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
tst_test.c:1681: TBROK: Test killed! (timeout?)

Summary:
passed   0
failed   0
broken   1
skipped  0
warnings 0

I'm trying with LTP_TIMEOUT_MUL=3.

BTW there is still broken swapoff01 on master on ppc64le which I reported [1]:
libswap.c:153: TBROK: Failed to create swapfile
(obviously no change in this patchset)

But I'll ping Li separately.

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/20240131190122.GB30901@pevik/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
