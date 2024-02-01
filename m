Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B33C47DDB
	for <ltp@archiver.kernel.org>; Thu,  1 Feb 2024 10:16:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 240A23CF8DC
	for <ltp@archiver.kernel.org>; Thu,  1 Feb 2024 11:16:22 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9BF013CE0A9
 for <ltp@lists.linux.it>; Thu,  1 Feb 2024 11:16:08 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0D5EC2003BA
 for <ltp@lists.linux.it>; Thu,  1 Feb 2024 11:16:07 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1FEA91FB9D;
 Thu,  1 Feb 2024 10:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706782565;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=F8R2lYBEN8Lyi+4nd7ng+K6QyU3XHKsrewrbSYUpsEU=;
 b=AtvwvqEz8wLnDLiJ42ynegw5zdc4UHkcuWphmncK9frC7fKZTIikb//aDKrKiGsNZLNgIX
 mr7h2o6BIt9VhOrJ5ZNyhnCugH1A/2KMxrpLvo5VFaWE5UIuWazohHzBpUnQwFoQTTfPjj
 W69Y3OnP3s+IY3MzQPuAXyUZIgwxqOU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706782565;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=F8R2lYBEN8Lyi+4nd7ng+K6QyU3XHKsrewrbSYUpsEU=;
 b=eUYwf+dnaXE4RDAgbNA3IYSy/WjVAUPww0HIIuamNDQuhfJ9lggWqlfCmUd0w3P4Tr1RG7
 CA+Uki5sLBWQgXDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706782565;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=F8R2lYBEN8Lyi+4nd7ng+K6QyU3XHKsrewrbSYUpsEU=;
 b=AtvwvqEz8wLnDLiJ42ynegw5zdc4UHkcuWphmncK9frC7fKZTIikb//aDKrKiGsNZLNgIX
 mr7h2o6BIt9VhOrJ5ZNyhnCugH1A/2KMxrpLvo5VFaWE5UIuWazohHzBpUnQwFoQTTfPjj
 W69Y3OnP3s+IY3MzQPuAXyUZIgwxqOU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706782565;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=F8R2lYBEN8Lyi+4nd7ng+K6QyU3XHKsrewrbSYUpsEU=;
 b=eUYwf+dnaXE4RDAgbNA3IYSy/WjVAUPww0HIIuamNDQuhfJ9lggWqlfCmUd0w3P4Tr1RG7
 CA+Uki5sLBWQgXDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B25931329F;
 Thu,  1 Feb 2024 10:16:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id DEvYKWRvu2XCXQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 01 Feb 2024 10:16:04 +0000
Date: Thu, 1 Feb 2024 11:16:03 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20240201101603.GA78772@pevik>
MIME-Version: 1.0
Content-Disposition: inline
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.70 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[22.90%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] TMPDIR minimal size requirement
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
Cc: Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

recent LTP change 3626124a4 ("fallocate06: Increase test loop device size to
1GB") [1] increased requirement on TMPDIR size for syscalls. That hits the size
of tmpfs we use in openSUSE Tumbleweed on /tmp. While we can workaround easily
this in openQA framework we use for LTP testing (use TMPDIR=/var/tmp for
fallocate06 or even for whole runtest syscalls), I wonder if we should have some
LTP upstream fix.

What comes to mi mind, we could use as TMPDIR default /var/tmp (only if it does
not exists, we would fallback to /tmp). We could also warn against tmpfs use.
Or at least document on README that although many tests need 300 MB for a block
device, some tests require more and suggest to use /var/tmp.

Also, Cyril asked for a patch with minimal device size per filesystem (IMHO
still would be done). At least for Btrfs and XFS some people complains 300
MB is not a real testing scenario, therefore if we implement it and use 1 GB
e.g. for Btrfs and XFS we will hit limits on "low resource" devices.

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/commit/3626124a42adfe536af2abff63213fa1ccc63795

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
