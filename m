Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E997C4167B
	for <ltp@archiver.kernel.org>; Thu,  7 Dec 2023 11:19:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 656B83CF037
	for <ltp@archiver.kernel.org>; Thu,  7 Dec 2023 12:19:04 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B2A463C6A7A
 for <ltp@lists.linux.it>; Thu,  7 Dec 2023 12:18:54 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 09841204703
 for <ltp@lists.linux.it>; Thu,  7 Dec 2023 12:18:53 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3EFDC21E41;
 Thu,  7 Dec 2023 11:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1701947931;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VqYh0FUd9KVHXDDAMOqXTPsAc69YDr9DpSytrlqu+GE=;
 b=KdpO+07qv5jVEPmJtx/xv0evkaNAccGS/FT+E3KR0UeLF1gn/WVrczmssT8t/YEcge6Hw9
 X460k743wD11lL/T/jET9z7VTUUj+TaEivQgHjgBfRE7+4b7OURCnht8A2M0UgQHa4oiAQ
 j7NvSLlQMFGTJyBNNe9o8MzXW0lJT2E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1701947931;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VqYh0FUd9KVHXDDAMOqXTPsAc69YDr9DpSytrlqu+GE=;
 b=ZmMuIwCopldAc57DtQ2HgwlWJvFnj4fdmFSxk05lkJggfwua1chsu6XQYyqRGgID0hoxpM
 /BiiaWQ+ZfhJDsBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A7E613907;
 Thu,  7 Dec 2023 11:18:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id MbPYGxqqcWXaaAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 07 Dec 2023 11:18:50 +0000
Date: Thu, 7 Dec 2023 12:18:44 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20231207111844.GA234785@pevik>
References: <20231207111223.234170-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231207111223.234170-1-pvorel@suse.cz>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.41 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.29)[74.75%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] fsx-linux: Reduce log output
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Log output is very verbose. Given how many times the test tries it's a
> significant time spent for printing output. This change also helps to
> run on slower SUT without need to set LTP_TIMEOUT_MUL environment
> variable.

IMHO output should have been only on error (test run 10000x or 100000x or even
500000x, that's a lot for a regular output). Also logs get huge due logging.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
