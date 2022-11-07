Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2780C433FE
	for <ltp@archiver.kernel.org>; Mon,  7 Nov 2022 14:44:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3BA173CDA22
	for <ltp@archiver.kernel.org>; Mon,  7 Nov 2022 15:44:01 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D41A3C01D2
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 15:43:51 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 92A7F600692
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 15:43:50 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7B26221C1A;
 Mon,  7 Nov 2022 14:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1667832230;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=va5diS9NgxLMrUJ7GqVROgDcAOncQ0mJmkqFhymyN4M=;
 b=uFXhRR9B6Gy5vHkYimWZ/1P7FRL63V/0lRr8Xd+lXN7qDQz3klz4//MBNvRqNVCKZzuDG4
 J79qspMdzRQxkKZsFlJRkWDT/CSHrz5VwUYkVaix+5Q0OpqPmED81DuEOiA6xOLtVPCbOj
 dmYIfe54y/UDMQIKcBQjwStyctys3fs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1667832230;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=va5diS9NgxLMrUJ7GqVROgDcAOncQ0mJmkqFhymyN4M=;
 b=X3V0Xh2Wyd7ynKCxi8dgBabQZ96C4UawPJ/bTs5pMkl/jGAaHEBx+HmhEihJyaiAJ0jTab
 8p6i9D8F5z9T1sAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4B1A513AC7;
 Mon,  7 Nov 2022 14:43:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 34kIEKYZaWPrCQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 07 Nov 2022 14:43:50 +0000
Date: Mon, 7 Nov 2022 15:43:48 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <Y2kZpKHCy2mYLAL0@pevik>
References: <20221021115333.13725-1-pvorel@suse.cz>
 <20221021115333.13725-4-pvorel@suse.cz> <87zgd3vunm.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87zgd3vunm.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] doc: Remove
 mini-howto-building-ltp-from-git.txt
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

> Acked-by: Richard Palethorpe <rpalethorpe@suse.com>
Thx, merged this one.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
