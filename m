Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F5DC46467
	for <ltp@archiver.kernel.org>; Wed, 11 Jan 2023 09:05:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B963D3CCAE0
	for <ltp@archiver.kernel.org>; Wed, 11 Jan 2023 10:04:59 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D3543CB551
 for <ltp@lists.linux.it>; Wed, 11 Jan 2023 10:04:49 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 942CC1000417
 for <ltp@lists.linux.it>; Wed, 11 Jan 2023 10:04:48 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E7A65768EC;
 Wed, 11 Jan 2023 09:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1673427886;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VpiaL2mVsHOo95RHYAm/49wHQhZXabCJ5D9kSh8uQVo=;
 b=zr3DZdFiKjuSwqwGcRgxbS+AIFvl7fhsLXr+r9eqMCfKB6T03uLxvgrj73zH+X/k0qkW6P
 477l0os3XSXrO58G8KZl6liRw58FQFrLo5JEW8fNaJhIlOBw4BRBp6cObOAFqs/v/9ID7i
 XyyUpYLCIMdoqxtpO1RccmcykHttmQ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1673427886;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VpiaL2mVsHOo95RHYAm/49wHQhZXabCJ5D9kSh8uQVo=;
 b=RVDZzyr6L9ywlqqyqtFktjAO4ju85+BpQAm+3kM7bOxIji3ZLfa8Cu6GIx9BkUxIxc4SJ8
 +YhOE353SCk/XiBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C09C813591;
 Wed, 11 Jan 2023 09:04:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id M3K6La57vmMuWAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 11 Jan 2023 09:04:46 +0000
Date: Wed, 11 Jan 2023 10:04:40 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <Y757qIWOX1nyd7lC@pevik>
References: <20221216114331.28883-1-pvorel@suse.cz> <Y5xaew0XH0mE3DZw@pevik>
 <877cxwj7c2.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <877cxwj7c2.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] aio-stress: TCONF on O_DIRECT on tmpfs
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

Hi Richie,

> I merged this, although I don't think it is quite correct to say tmpfs
> doesn't support O_DIRECT. It's more like it is in O_DIRECT mode by
> default. Either way though we don't need to run the test with O_DIRECT
> and without it.

NOTE: feel free to correct me (amend the message) before merge.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
