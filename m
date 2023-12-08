Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF01C4167B
	for <ltp@archiver.kernel.org>; Fri,  8 Dec 2023 13:53:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4A7253CF980
	for <ltp@archiver.kernel.org>; Fri,  8 Dec 2023 14:53:18 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2459D3C86CA
 for <ltp@lists.linux.it>; Fri,  8 Dec 2023 14:53:08 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 53BA014052F0
 for <ltp@lists.linux.it>; Fri,  8 Dec 2023 14:53:08 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6AB8721C5D;
 Fri,  8 Dec 2023 13:53:07 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E554213A6B;
 Fri,  8 Dec 2023 13:53:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id Jl5VNMIfc2V5CAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 08 Dec 2023 13:53:06 +0000
Date: Fri, 8 Dec 2023 14:53:05 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20231208135305.GA351742@pevik>
References: <20231207212739.302374-1-pvorel@suse.cz>
 <20231207212739.302374-3-pvorel@suse.cz>
 <CAASaF6yheXD4w07K1xUVXrqoS6jdX6PUjG64UXQbE_hQR9cW7w@mail.gmail.com>
 <ZXLRB46ZqzBN6laS@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZXLRB46ZqzBN6laS@yuki>
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1
X-Rspamd-Queue-Id: 6AB8721C5D
Authentication-Results: smtp-out1.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/4] lib: Add support for TDBUG tst_res() flag
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

Hi Cyril, all,

> Hi!
> > My first impression was it's some kind of new BUG type :-)
> > I'd suggest making it TDEBUG or TDBG.

> Naming things is hard, I suppose that the least confusing is probably
> the full spelling, i.e. TDEBUG. I suppose that having it one letter
> longer is not a big deal.

OK, I'll wait for other feedback before sending v3 with
s/TDBUG/TDEBUG/

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
