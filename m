Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA1F8C6FD1D
	for <ltp@archiver.kernel.org>; Mon, 20 Mar 2023 07:51:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E5B5F3CD363
	for <ltp@archiver.kernel.org>; Mon, 20 Mar 2023 08:51:36 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D09403CA84C
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 08:51:25 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DD9E41A00459
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 08:51:24 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B3A0D21ABE;
 Mon, 20 Mar 2023 07:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1679298682;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KS9Bcl51gx/3oKlZOMCVzzl6zQ/gkLE9MNnNDqLZjoQ=;
 b=uvzcCbJeBYFT1NIVFjKlvtwsXWbk8hkjvYryz/5+5mRY0XPFYViaKpql71Mm0xFUBC8UGx
 OCz+1Arq1Hf3Yh2OKd7Vg3xYxOMYg5PPDeeROwGv9imZpvQEkXlf1mWHA0psTqya+Al100
 QuFEVWNQqqYKhA6q1SMTOAg5UJM8pFI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1679298682;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KS9Bcl51gx/3oKlZOMCVzzl6zQ/gkLE9MNnNDqLZjoQ=;
 b=VWEogzhJ3sXRp1zhnxPdf0i/fuMFHXgxeYO+L4a13lXqY6L9sHKoYtm4+tvymwfUqVT77u
 8EZg03EWjK2Q6gBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 84E2213A00;
 Mon, 20 Mar 2023 07:51:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id BMLMHnoQGGREPQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 20 Mar 2023 07:51:22 +0000
Date: Mon, 20 Mar 2023 08:51:20 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrei Gherzan <andrei.gherzan@canonical.com>
Message-ID: <20230320075120.GA179606@pevik>
References: <20230216114745.2389810-1-andrei.gherzan@canonical.com>
 <Y++c8fBZxmUIR3Lb@pevik> <Y/N53BN2yr7WEIzr@qwirkle>
 <20230308165545.GA428998@pevik> <ZAoIT1NunhWyuIUR@qwirkle>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZAoIT1NunhWyuIUR@qwirkle>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fs_fill: Fix test when running on a 256 CPU+
 machine
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

Hi Andrei, Richie,

merged with proposed fixes.
I'm sorry it took me some time to get back to this.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
