Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC8BBCCF9F0
	for <ltp@archiver.kernel.org>; Thu, 30 Oct 2025 18:24:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 457CA3CC23D
	for <ltp@archiver.kernel.org>; Thu, 30 Oct 2025 19:24:33 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 957D73C6E91
 for <ltp@lists.linux.it>; Thu, 30 Oct 2025 19:24:17 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 32A9C200060
 for <ltp@lists.linux.it>; Thu, 30 Oct 2025 19:24:17 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E489C1FB56;
 Thu, 30 Oct 2025 18:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761848656;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ox8dGAC6OH8EVI96bn5IBgfWP4md+OkylJrr5So4Myo=;
 b=G6iNUOxb3sRUuQ+G0PuZe5CP/fMKRRRoKLAZXXwIWUCUJfGmLVYMdTebaCBtTYwkU2WOtV
 awWWgj+fYzGiSlu/9dN/9ED+8E0Pj09us6UTdfDX/NFKFNUeXsv6f9wjmXG98K65ixi89Y
 RE/81c53Yy6OnkPWCYX0jxugrC3NtFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761848656;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ox8dGAC6OH8EVI96bn5IBgfWP4md+OkylJrr5So4Myo=;
 b=BDndYQOQ956vOy7hLixNtqV1So1IRpJ/rHPO9hnrZP3oEkVTOIV/OfOW0RBT3vcsf8cPzU
 5glcIIn6jVm2HLBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761848655;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ox8dGAC6OH8EVI96bn5IBgfWP4md+OkylJrr5So4Myo=;
 b=YwP9BGeoTUzfHsEGpJu4LPbsJHBluXRoQHF1zFkXwx2u01++AHUUceHp9P/UJsrsDlMypx
 DXomoL1KNOu6WOLFMjmgfAkXsVPJmX3/7h9medBs3Z3ui7enCzDIFNEXAQB4gTnjWk1vFR
 ZfFKmFv8Xs7hZ0qVw7x1KhzJlu/mnJA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761848655;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ox8dGAC6OH8EVI96bn5IBgfWP4md+OkylJrr5So4Myo=;
 b=TaBU0Socn0L8M8mGkTOS7KcN1r7I0WEQjt4NqDXn+urX/vjZGNg4HSJ+6Yi7eXUz58Uf7j
 n8S5ywB99WeZLxCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D40D1396A;
 Thu, 30 Oct 2025 18:24:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vxdSIE+tA2lJCQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 30 Oct 2025 18:24:15 +0000
Date: Thu, 30 Oct 2025 19:24:13 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Dan Carpenter <dan.carpenter@linaro.org>
Message-ID: <20251030182413.GA753947@pevik>
References: <20251024125613.2340799-1-anders.roxell@linaro.org>
 <20251024133035.GA590258@pevik> <aPu2lqXN8G7h4e7D@stanley.mountain>
 <aP85jhbSvlYxeOiQ@rei>
 <CADYN=9JgKUWnqgJMe2KRWmtd=wctWwKKYr=abHO9e2S5u4c1qQ@mail.gmail.com>
 <aP-LmrecdhvHTLAc@yuki.lan> <aP-NgESHEFgnpD_l@stanley.mountain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aP-NgESHEFgnpD_l@stanley.mountain>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] file_attr02: Add XFS kernel config requirement
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
Cc: benjamin.copeland@linaro.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

because Cyril's library fix got merged this should not be needed, right?
https://github.com/linux-test-project/ltp/commit/5e1e0e2d81e564df09542b7caa2a66928c05dd3a

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
