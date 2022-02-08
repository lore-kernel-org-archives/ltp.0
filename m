Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B46AC433F5
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 18:26:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A8613C9B75
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 19:26:26 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 65D633C071A
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 19:26:17 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BD2A31000D1F
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 19:26:16 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DED0F1F383;
 Tue,  8 Feb 2022 18:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644344775;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IF/8e5fmwnCl9cR9q009eosSx5hUQg+PhZ20SWSnUTo=;
 b=EFhldl9TXpom09yHjxS12EP6H9dQOb92zG2iqNgERNQ3xB1gQJaddPQqXx/BC+zYWDUQWQ
 tZpE8FMld+M7jqWA0R+izv+C0uSWcogtKmbHxb9zNetvmoXOzPqnhsMiNc/T5UnqF1iy4x
 GKPlk+6VJ/FUVF1WDmrgBhM06yxUi2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644344775;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IF/8e5fmwnCl9cR9q009eosSx5hUQg+PhZ20SWSnUTo=;
 b=BRM4mzgIpt5E1huC8I3qJ6Qjp6B2h0+eJdbe1MzRkCVnS14OxEfSbr0ZcahTL09DJqUXtP
 R/LGd1LDaXW/rhBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BCEB013CDC;
 Tue,  8 Feb 2022 18:26:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Of+3LMe1AmJefgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 08 Feb 2022 18:26:15 +0000
Date: Tue, 8 Feb 2022 19:26:14 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YgK1xnIERa7/P+HJ@pevik>
References: <20220126181210.24897-1-pvorel@suse.cz>
 <20220126181210.24897-4-pvorel@suse.cz> <YgJ6dOD7tC+7UQL2@yuki>
 <YgKqKM32COAnmxfo@pevik> <YgKvVsFZZ9I3zBWi@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YgKvVsFZZ9I3zBWi@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/5] tst_test.sh: Add $TST_FORMAT_DEVICE and
 related vars
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

> Hi!
> > Do you mean to swap here? i.e.:
> > tst_mkfs "$TST_FS_TYPE" "$TST_DEV_FS_OPTS" "$TST_DEVICE" "$TST_DEV_EXTRA_OPTS"

> > But in tst_mkfs it has always been the second parameter:
> > local device=${2:-$TST_DEVICE}

> > What am I missing?

> The email that explains why we can't add dev_extra_ops to the tst_mkfs
> the same way we do in C?

Ah, got that, thx :).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
