Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1230AC25B48
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 10:22:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 18DFC3CCB3A
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 12:22:47 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 802933CAB76
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 12:22:36 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AFF8360005C
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 12:22:35 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 41DAA1F86A
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 10:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698315754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3uvpnewMacIG3W0Hf/W3EBJRHuNLnXPAimQRu7b7K4I=;
 b=nDLjA5WLlSno/Fi6foxQ7m9X97exau5CC1iL+mAZ7dWsnmoET6oF3IySFgvpDF2GFezsCA
 ONTQt2KIQcfAhWcmBRaHSR0/FfBPymd2ILVP2KEem1fhuC3+vULG7AnFFfxzGygMZUc9r8
 /gN65TOtWvxz1ivKsm8tpkWBxHL4aWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698315754;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3uvpnewMacIG3W0Hf/W3EBJRHuNLnXPAimQRu7b7K4I=;
 b=28JYpztv7XJJDH6gLB1/kfEUCJHBFdTQMjMYdvKMs5pflHU4y5f11ckUvr7xaD/c3bkc1X
 VOnmwbh+ubyl2rAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 33A841358F
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 10:22:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wCifC+o9OmXBTgAAMHmgww
 (envelope-from <mkittler@suse.de>)
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 10:22:34 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp@lists.linux.it
Date: Thu, 26 Oct 2023 12:22:33 +0200
Message-ID: <3263329.44csPzL39Z@linux-9lzf>
In-Reply-To: <20231026094957.15371-1-rpalethorpe@suse.com>
References: <20231026094957.15371-1-rpalethorpe@suse.com>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-5.83 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-2.73)[98.84%];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-3.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCPT_COUNT_ONE(0.00)[1];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]; CTE_CASE(0.50)[]
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] cgroup: Handle trailing new line in
 cgroup.controllers
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

LGTM (although it is a bit unfortunate that we have to hardcode 
MAX_CGROUP_TYPE_NAMELEN)

Reviewed-by: Marius Kittler <mkittler@suse.de>




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
