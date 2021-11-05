Return-Path: <SRS0=uAqx=PY=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB684C433EF
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 10:10:38 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF320611EE
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 10:10:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EF320611EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D38173C73D8
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 11:10:35 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3815B3C6D2D
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 11:10:24 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 73E631000464
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 11:10:24 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9E9BB212C0;
 Fri,  5 Nov 2021 10:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1636107023;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5Wqby23pgih4bJELPymWZZdR5S0E6N3dTsc6SakmTbY=;
 b=Qt6VwAECDU5YCDHsziGa5nLocz3jpcEgbcgdHexeAE+xvpdcamQni+28BfF68+so6byldz
 qZBHZoUF5b2p8+pulV2Tn8FHPf9vW0HX6OeFd+oGNjiV8vpAVFntac91DM4FP5ILKi1Z/T
 jwyR/26i6PsdqQFhF/GEY7xGfv8WKp0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1636107023;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5Wqby23pgih4bJELPymWZZdR5S0E6N3dTsc6SakmTbY=;
 b=D2+jMNhnlhfNiG4WVuADOBiJoHNf2AvRtA1hSYPKiZSbONd4Qis0FKJXgSJ57luXq035iI
 6mIqWHgAtgtGb0DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3C54E13B97;
 Fri,  5 Nov 2021 10:10:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6dOmDA8DhWGjewAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 05 Nov 2021 10:10:23 +0000
Date: Fri, 5 Nov 2021 11:10:21 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Gabriel Krisman Bertazi <krisman@collabora.com>
Message-ID: <YYUDDU0A9hLFbM4c@pevik>
References: <20211029211732.386127-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211029211732.386127-1-krisman@collabora.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 0/9] Test the new fanotify FAN_FS_ERROR event
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
Cc: kernel@collabora.com, khazhy@google.com, repnop@google.com, jack@suse.com,
 linux-ext4@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Gabriel, all,

> Hi,

> Now that FAN_FS_ERROR is close to being merged, I'm sending a new
> version of the LTP tests.  This is the v3 of this patchset, and it
> applies the feedback of the previous version, in particular, it solves
> the issue Amir pointed out, that ltp won't gracefully handle a test with
> tcnt==0.  To solve that, I merged the patch that set up the environment
> with a simple test, that only triggers a fs abort and watches the
> event.

> I'm also renaming the testcase from fanotify20 to fanotify21, to leave
> room for the pidfs test that is also in the baking by Matthew Bobrowski.

> One important detail is that, for the tests to succeed, there is a
> dependency on an ext4 fix I sent a few days ago:

> https://lore.kernel.org/linux-ext4/20211026173302.84000-1-krisman@collabora.com/T/#u
It has been merged into Theodore Ts'o ext4 tree into dev branch as c1e2e0350ce3
("ext4: Fix error code saved on super block during file system abort")

We should probably add it as .tags (see fanotify06.c).

Also it'd be nice just to mention relevant commits which added FAN_FS_ERROR in
fanotify21.c (probably "fanotify: Allow users to request FAN_FS_ERROR events" ?)
+ kernel version it added it -suppose 5.16 (although it can be backported; and
these commits should not go to .tags, as we track there only
fixes not new features). I can add it myself (no need to repost).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
