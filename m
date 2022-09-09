Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C81BECAAD3
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 07:40:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8BD143CAA76
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 09:40:08 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 85C9B3CA4FF
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 09:39:58 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7FE6D1A002D1
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 09:39:56 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C35CF1F8ED;
 Fri,  9 Sep 2022 07:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662709195;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EXrvO0sJYPJ7wUhBsjOHHhuJKgX0FOr/y+LrLqc5XP0=;
 b=EpyTOhQAopPdUxSuuBK77uvyXKQRHBGquQnfP61cWEeO0bbpWqaf8SyfWa6mObEtNSI33x
 mn/Vkiq/2wckz6H0aOKcMsExecdxXWfYnLkC+LzGnoF9WynzWNtyLFZx2KG3LxSbz8ZOi1
 /rIBbjWpu6sD0NssGKV+BpdAjGxf9O8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662709195;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EXrvO0sJYPJ7wUhBsjOHHhuJKgX0FOr/y+LrLqc5XP0=;
 b=KmFo2u69XGjBRceSIddnf9bKnT0BYl8wfPT7zsRN9sEdn6fyXRMtlJ4tYeRB/eAE3wJ5vz
 rbQ0nhl94kEVFbDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9153A13A93;
 Fri,  9 Sep 2022 07:39:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +avhIcvtGmN8NAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 09 Sep 2022 07:39:55 +0000
Date: Fri, 9 Sep 2022 09:39:54 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Matthew Bobrowski <repnop@google.com>
Message-ID: <Yxrtymx3FLNUhzeA@pevik>
References: <20220907110326.2915779-1-amir73il@gmail.com>
 <YxkyD3AKC5aWFiLg@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YxkyD3AKC5aWFiLg@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/fanotify09: Make test case definitions
 more readable
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> On Wed, Sep 07, 2022 at 02:03:26PM +0300, Amir Goldstein wrote:
> > Use explicit field members to initialize test cases and omit
> > fields initialized to zero to make the definitions more compact
> > and more readable.

Merged, thank you!

> Looks fine. I guess we could adopt the same designated intializer pattern across
> a bunch of other fanotify LTP tests.

+1

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
