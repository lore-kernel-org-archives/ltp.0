Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9E7C433F5
	for <ltp@archiver.kernel.org>; Wed,  5 Jan 2022 11:35:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD7993C90A4
	for <ltp@archiver.kernel.org>; Wed,  5 Jan 2022 12:35:33 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B32A3C13E9
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 12:35:21 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8BB3260029B
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 12:35:20 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B77C32112B
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 11:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641382519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=dcuZPfNsAD9p72Hb2BcguTZUzl9o5xg99Ulz2t6WQH8=;
 b=SZM5MZhhMBB9XNou05YbMkZlr+6MB94Hdn8XQ1jUqfo9+PAoo+kc48uwtWxeo+5PpyJidA
 58gtk7CwfO4+T0RDQaFHmisP0jay5+mJWvbOoz+py3vGjUjS/F5rNQ8WSpwGM79Pbo1H8/
 GkZy/LFwhtvsvFkAcFfu1ZuaNeQ+WSU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641382519;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=dcuZPfNsAD9p72Hb2BcguTZUzl9o5xg99Ulz2t6WQH8=;
 b=qZZ3wqpmJKJepKLPMFWCsQ4PRqVyD5LJlsspqzkhjs4dD/7J/aLr89cABfUjEzG9EWcPAD
 h/23v0gDWu4eZKBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9A7A713BC6
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 11:35:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id vvCZJHeC1WGNfQAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 05 Jan 2022 11:35:19 +0000
Date: Wed, 5 Jan 2022 12:36:49 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Message-ID: <YdWC0f+70TF6Eluk@yuki>
MIME-Version: 1.0
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] LTP Release preparations
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
As usuall it's time to start preparing for the next release.

Given the amount patches waiting for the review I guess that we should
try to get reviewed and merged as much as possible in the next few days.
I would go for git freeze at 14. 1. as that would give us a week for
pre-release testing and the release would be, as usuall, finalized
around the 21. 1. Feel free to reply if you think that the schedulle
should be different.

Also if there are patches that you think should be merged before the
release let me know ASAP so we can have a look soon enough.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
