Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF73CCA47C
	for <ltp@archiver.kernel.org>; Tue,  7 Jun 2022 15:04:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5EF973C90D9
	for <ltp@archiver.kernel.org>; Tue,  7 Jun 2022 17:04:55 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E0FCA3C0162
 for <ltp@lists.linux.it>; Tue,  7 Jun 2022 17:04:44 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5E435200A12
 for <ltp@lists.linux.it>; Tue,  7 Jun 2022 17:04:43 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 204F121A0B;
 Tue,  7 Jun 2022 15:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1654614283;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=erakBnPy8Jo17u0Q38kQpZQ/04QsK1Qfjky4yz5YMo4=;
 b=jhclF8kvIeEeQd2G0ChMfgvWr7B+cntUAQxWww2a2qQkUu36++owYfh4KuecVUovLXFVji
 F3ijTqwuZP4PwVTq2n9DA8eeNGf1tb8YhXxSD9h9vlK6M9a4g6W6nK61yVgi7HEEire2Vt
 HEJ07iLTNgoMJXQTjz0lGdw1wPuTp3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1654614283;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=erakBnPy8Jo17u0Q38kQpZQ/04QsK1Qfjky4yz5YMo4=;
 b=h2aysk7R4om2Yso+fT/nf6KVGuo5H457DfDPlasil3U+F/dRMqbvawYCvVMTZeyzIfv9zS
 z9inB8xQA3XZFuAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E921613A88;
 Tue,  7 Jun 2022 15:04:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id y5jfNQppn2LYVgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 07 Jun 2022 15:04:42 +0000
Date: Tue, 7 Jun 2022 17:04:41 +0200
From: Petr Vorel <pvorel@suse.cz>
To: zhaogongyi <zhaogongyi@huawei.com>
Message-ID: <Yp9pCUtfmmvOduGO@pevik>
References: <3b3bb782eec842579edb890bb7282e80@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3b3bb782eec842579edb890bb7282e80@huawei.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_kvercmp.sh: strip '+' when $(EXTRAVERSION) is
 blank
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Zhao,

> Hi Petr,

> Yes, if EXTRAVERSION is set to "-*", it has been stripped, but EXTRAVERSION also can be set to blank and sources were modified without commit, In this case,
> we run 'make clean' or 'make' would report error like:

> ./scripts/tst_kvercmp.sh: line 16: 5 * 65536 + 10 * 256 + 0+: syntax error: operand expected (error token is "+")
> ./scripts/tst_kvercmp.sh: line 17: [: -ge: unary operator expected

Thanks for info, merged.

For removing trailing + just single % would be enough, but two should not harm,
therefore I merged it without modification.

Kind regards,
Petr

> Best wishes,
> Gongyi

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
