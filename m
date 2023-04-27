Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD0FBC77B61
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 18:36:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EFFEA3CE4BC
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 20:36:13 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 862F83CB9C3
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 20:36:03 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E34A21000499
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 20:36:02 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1E47D1FE82;
 Thu, 27 Apr 2023 18:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1682620562;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qHhKQ3wGb10DT4NDr7wxDIxYfI8zhVNRQ/NfkI5VRVg=;
 b=U0iFr5bHpJveRer2GFP/xHpSttBi9D1xL2uJ4wuQ//Gw1M2e6eu5u0Kilqc7tEWVVCGB7h
 xkTgzAdle73J33R1Qc3JY1p4ycycanEABRAAVvMEJUrV374IcFljDm65XYKFpF+nyAAiwL
 W4TCO9imW0VycH+WUTFjLTabp9Mt7HI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1682620562;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qHhKQ3wGb10DT4NDr7wxDIxYfI8zhVNRQ/NfkI5VRVg=;
 b=bHMXse0FVj2E/hX/aKkDYwUhm9MXNrjJ+MPJSrLqNsJ8qoSTKuaVhFxWbtYle/nnJw0MVN
 Vl/H+GX1jopUQ6Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D6494138F9;
 Thu, 27 Apr 2023 18:36:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4CEjGpDASmSFFQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 27 Apr 2023 18:36:00 +0000
Date: Thu, 27 Apr 2023 20:36:03 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Edward Liaw <edliaw@google.com>
Message-ID: <20230427183603.GB3146239@pevik>
References: <20230427174309.1479093-1-edliaw@google.com>
 <20230427174309.1479093-3-edliaw@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230427174309.1479093-3-edliaw@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] fcntl{34,
 36}: Use arch dependent types for my_flock64
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
Cc: kernel-team@android.com, rpalethorpe@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Edward,

> On Android arm64, fcntl is not accepting the my_flock64 struct being
> passed (fails with EINVAL).  This modifies the struct type to match the
> flock64 definition in the kernel.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>
(only on x86_64 libc)

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
