Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23922EB64D7
	for <ltp@archiver.kernel.org>; Wed, 28 Jun 2023 09:17:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4AAC13CC97E
	for <ltp@archiver.kernel.org>; Wed, 28 Jun 2023 11:17:09 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9CB4F3C876B
 for <ltp@lists.linux.it>; Wed, 28 Jun 2023 11:16:59 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E48CC6008B1
 for <ltp@lists.linux.it>; Wed, 28 Jun 2023 11:16:58 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CA29221862;
 Wed, 28 Jun 2023 09:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687943817;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HJuEIPMNPyUwY6aYG6ivx5NFKHqArhm4WW4HjS0Be2M=;
 b=O0jxBSGzhOHqI/UPur9t/3yevR8yHRjpUz59PE6fh1Z/X1fjIwA0bPXfzp26CYbXnilCHo
 bPmowWsVDZ4wNNsxP0idrueZmVW/T8Mg2aMIEEzZKLOEUHBBA5rIrnHrb/m+pCWUCEEdX4
 eFAdmpBh7NE4KmstnNq7QQLXO6SZa0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687943817;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HJuEIPMNPyUwY6aYG6ivx5NFKHqArhm4WW4HjS0Be2M=;
 b=e3droQfM1gzEBp+JCEx3VYP2ay2LiDE1gXRc1diZVlbNKtKLJZEZ4ECtWxjqzi/0yq98h6
 Joi6jNQg73Ce9YCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A013C138E8;
 Wed, 28 Jun 2023 09:16:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /1U6JYn6m2RVcwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 28 Jun 2023 09:16:57 +0000
Date: Wed, 28 Jun 2023 11:16:55 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Edward Liaw <edliaw@google.com>
Message-ID: <20230628091655.GA130312@pevik>
References: <20230331000747.2294390-1-edliaw@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230331000747.2294390-1-edliaw@google.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] setpgid02: use 1 instead of getpgid(1)
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
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Edward,

> On Android, init does not setpgid, so getpgid(1) returns 0 and the third
> case of setting pgid to a different session's process group does not
> behave as expected: setpgid treats 0 as setting the pgid to the pid.

> Instead, replace SAFE_GETPGID(1) with the expected value of 1.

IMHO this was in the end fixed by 105b0fe17 ("setpgid02: Use pid_max as PGID for
EPERM") therefore I'm closing this in patchwork as Rejected.

Please let me know if there are still some problems on Android.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
