Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3677C5479D
	for <ltp@archiver.kernel.org>; Thu, 12 Jan 2023 00:39:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 56EE33CDCD2
	for <ltp@archiver.kernel.org>; Thu, 12 Jan 2023 01:39:54 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 483F93CB55B
 for <ltp@lists.linux.it>; Thu, 12 Jan 2023 01:39:44 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AF98B100092B
 for <ltp@lists.linux.it>; Thu, 12 Jan 2023 01:39:43 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BC3C3373B9;
 Thu, 12 Jan 2023 00:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1673483982;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/vwYvI9eqdxGH7plu5kvO6peWN6u/WGVEZ1YNiyMJXQ=;
 b=yGW0eq54T0Rz4oPpub5GOiZMir185W8on16zs/i7sipjwcK+M8Ez+rAvsaXx1jh/llV1CG
 e5zgwtOAYfAMHQcDHY5MLnEcXAyAwcO1iJZtrv9gJ6B9416XOLP7S3Xbv2s0K/gMcKDrQX
 S/sWKkhQQX6lqZVvkjRLTTB6JXK1mcM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1673483982;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/vwYvI9eqdxGH7plu5kvO6peWN6u/WGVEZ1YNiyMJXQ=;
 b=/+bUkx0tIjhw1TuFMyGOlfsKNPgas+qOHh7PownAVuREEjkLD0Uw7j/agbBTr1TZESfaD0
 C8g9EAjztQw46cDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8B9A91358A;
 Thu, 12 Jan 2023 00:39:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id M8PhIM5Wv2OwMgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 12 Jan 2023 00:39:42 +0000
Date: Thu, 12 Jan 2023 01:39:36 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Nikolaus Voss <nikolaus.voss@haag-streit.com>
Message-ID: <Y79WyOooDNfPojIA@pevik>
References: <20230111142316.A0DBECA25@mail.steuer-voss.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230111142316.A0DBECA25@mail.steuer-voss.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/keyctl/keyctl09.c: fix test encrypted
 key
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
Cc: ltp@lists.linux.it, Yael Tzur <yaelt@google.com>, nv@vosn.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Nikolaus,

thank you for this update.


I pushed your patch through mailing list, because you posted unsubscribed.

> Link: https://lore.kernel.org/ltp/20221006081709.92303897@mail.steuer-voss.de/

From a link above you were able to send patch to kernel mailing list, thus you
managed to subscribed. Why do you expect LTP would work for unsubscribed mails
addresses?

I also dared to enable this mail for posting to LTP mailing list,
but better would be if you subscribed before sending patches.

v1 is not in patchwork, but it's in lore:
https://lore.kernel.org/ltp/d2d2afa4-b031-3455-38dd-c099715319e4@vosn.de/


Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
