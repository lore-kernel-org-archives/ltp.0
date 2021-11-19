Return-Path: <SRS0=7Ptb=QG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC41C433F5
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 19:29:19 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ACC660F4F
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 19:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8ACC660F4F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 67AA83C8BA3
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 20:29:16 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A3FB73C21D9
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 20:29:05 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8D1D3601765
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 20:29:04 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 507BC1FD3D;
 Fri, 19 Nov 2021 19:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1637350143;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vYCqqCmr0eXa8bYDyXX1w6z/yqJGXuqP/p7h+u+GVyc=;
 b=baG/dou2SqzYlj3+hEayGDfiDTRFQFlib70V6H8Nhy9xNv0GIUYal8iObIvoDGtbnzDv21
 1onbkqWhenbuihKGiuX+ntKNoohOrVstlQSdPIt5Ss+lP2pbY+xEYXGCyiPFLcidSGzA9b
 uH1q3Zl9eH4Qaok2OfZcb6CstAb1Aiw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1637350143;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vYCqqCmr0eXa8bYDyXX1w6z/yqJGXuqP/p7h+u+GVyc=;
 b=4V7ZMxVAhigkLFV+Zu9QZKjqjQesmTmNu2B+4eg66NFdTQgHkvbKIEja+RUI7Kgte+l578
 rBOzU4IjFW4HWMDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0A595139F0;
 Fri, 19 Nov 2021 19:29:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /hBNAf/6l2GCeQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 19 Nov 2021 19:29:03 +0000
Date: Fri, 19 Nov 2021 20:29:01 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>, Petr Vorel <pvorel@suse.cz>
Message-ID: <YZf6/YdyOUY8puWq@pevik>
References: <20211118235744.802584-1-krisman@collabora.com>
 <20211118235744.802584-5-krisman@collabora.com>
 <CAOQ4uxjk8J48ASw2yJhd-OR2LVN6kirg7p6xQbX=xEofGYUghw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjk8J48ASw2yJhd-OR2LVN6kirg7p6xQbX=xEofGYUghw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 4/9] syscalls/fanotify22: Validate the generic
 error info
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
Cc: kernel@collabora.com, Khazhismel Kumykov <khazhy@google.com>,
 Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.com>,
 Ext4 <linux-ext4@vger.kernel.org>,
 Gabriel Krisman Bertazi <krisman@collabora.com>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

...
> > -AC_CHECK_TYPES([struct fanotify_event_info_fid, struct fanotify_event_info_header],,,[#include <sys/fanotify.h>])
> > +AC_CHECK_TYPES([struct fanotify_event_info_fid, struct fanotify_event_info_header,
> > +               struct fanotify_event_info_error],[],[],[#include <sys/fanotify.h>])

> Doh! it seems like fanotify_event_info_pidfd was dropped between v2 ->
> v3 in Matthew's patches.

> Petr,

> Can you please fix this.

Hi Amir,

thanks for info, sure I'll fix it on Monday.

Kind regards,
Petr

> Thanks,
> Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
