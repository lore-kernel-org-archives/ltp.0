Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD3EBEE49B6
	for <ltp@archiver.kernel.org>; Wed, 11 Sep 2024 14:15:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 942A23C1D1A
	for <ltp@archiver.kernel.org>; Wed, 11 Sep 2024 16:15:49 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 78C913C0359
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 16:15:33 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1D4D260FB2F
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 16:15:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 12FF71F8BA;
 Wed, 11 Sep 2024 14:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1726064132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k9oek3cOgDHxlcb6ob4QVLKrrZ6ViZQxvF8eXGQNkS8=;
 b=aK7MMsic3RqZvf4rr5T9FSpoQnRD0M5V1Mn98McUCP0MKu5SXmd32ehpOmn05spoWwh9lx
 qnhzTDehOewgTYSFmXaYP4HDov+TnaCSr514S+ndqOtWuXWMS5N7p0cf4ORudb3L8tmCYY
 wKHAS8r/I0h3PXXwNXm1VKDWT6m+faI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1726064132;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k9oek3cOgDHxlcb6ob4QVLKrrZ6ViZQxvF8eXGQNkS8=;
 b=S9Rk27r+5HwF3KbCrskatzdaeHLr61R3mleb2MCaGRhFtW3f964dsPPyIBDDA7xBoSOlXh
 P+FLov/Mrt+i3aBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1726064131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k9oek3cOgDHxlcb6ob4QVLKrrZ6ViZQxvF8eXGQNkS8=;
 b=0y9MjNCEmLKoLX2DPsI31VeBQuOH6f79//F+CWk2BkOQS+bB4hwxoKkzu0mUODw0/xtmzl
 gXK7wT1LMlwLar7ZK0n61P2IdOVDhJtvgTzes2qK87sXQsC0PKG5FZsZS8uT0lcmKJ3Ede
 cyCj07Ky7emEQwhOTr1Q2M16sr6L2a0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1726064131;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k9oek3cOgDHxlcb6ob4QVLKrrZ6ViZQxvF8eXGQNkS8=;
 b=TwsdgkquwccDcQpk5e/Yejo+T1WvHCwURyighz6lTCnF61v2mgk8cyOJyTpk62DMJc1gbG
 6o8sQJRFigwTq3AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 039DC13A7C;
 Wed, 11 Sep 2024 14:15:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zpteOwKm4WYaVQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 11 Sep 2024 14:15:30 +0000
Date: Wed, 11 Sep 2024 16:14:21 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: spoorthy s <spoorthy@linux.ibm.com>
Message-ID: <ZuGlvb1I_BXSOtpk@yuki.lan>
References: <3cfc8cf7-a7f4-4ccc-95d9-88bd358abd43@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3cfc8cf7-a7f4-4ccc-95d9-88bd358abd43@linux.ibm.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, imap1.dmz-prg2.suse.org:helo,
 yuki.lan:mid]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Hugetlb: Migrating libhugetlbfs shm-perms
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Test Description: Tests the behavior of shared memory when
>  =A0multiple threads attach to a segment with different permissions.
> =

> At one point, reservation accounting of free hugepages between the parent
> and child processes may become inconsistent during memory operations.
> The parent creates 4 hugepages and a shared memory segment
> (size segment_size, permission 0640), attaches it, and initializes
> four parts with a pattern (0x55), then detaches it. Child processes
> are created in a loop, each reattaching the segment in read-only mode
> with SHM_RDONLY, detaching, and exiting. If attach/detach fails or
> if the reservation accounting of free hugepages doesn't match
> between parent and child, the test fails. If all child processes exit
> successfully and accounting matches, the test passes.
> =

> Tested and verified the success of test case
> =

> Signed-off-by: Spoorthy <spoorthy@linux.ibm.com>

Git complains that this patch is corrupted probably because the
"scissors" i.e. --- is missing after the Signed-off-by.


-- =

Cyril Hrubis
chrubis@suse.cz

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
