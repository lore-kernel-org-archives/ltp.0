Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91AE9C433F5
	for <ltp@archiver.kernel.org>; Wed,  5 Jan 2022 15:58:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6B3F83C92A1
	for <ltp@archiver.kernel.org>; Wed,  5 Jan 2022 16:58:47 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F32F3C1482
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 16:58:37 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 02A341000CE6
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 16:58:36 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 58B6F1F37B;
 Wed,  5 Jan 2022 15:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641398316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M96kWH2fkP1/i0vLvdidfdSRN7lfBMsf+/5XUXVhrn0=;
 b=QpWkB5bG1GM4XavUNLhJxo/CUblJ+vf6krwessL7csWs9XFeUXsTpV0pekCpdWYqZ/jS/Y
 GG4NIohzyM1+QH5h2bqSMNMX256frgAoZ+hK1s9Luoungg208N/XvKKfEkbj1nAVvn1ilp
 Dpn7JEe/7+TfiSo/IQ7SToAZxkQ8OVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641398316;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M96kWH2fkP1/i0vLvdidfdSRN7lfBMsf+/5XUXVhrn0=;
 b=KP1d+9IbThqL6TX1twH3A7MiNtmmOpF27WOGwNEBAEIxtqrZxSeDTSZhVqqbFyGe4fcYqy
 Dg6/TrM5Ge+7glCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 36E9613BF1;
 Wed,  5 Jan 2022 15:58:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id HHxqDCzA1WGqewAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 05 Jan 2022 15:58:36 +0000
Date: Wed, 5 Jan 2022 17:00:06 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.com>
Message-ID: <YdXAhgvstNcDz7WY@yuki>
References: <20211220180748.36A90A3B8E@relay2.suse.de>
 <20211221113042.21357-1-rpalethorpe@suse.com>
 <YdW/0BUm+vBY3PHy@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YdW/0BUm+vBY3PHy@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] API: Allow testing of kernel features in
 development
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> I would be even tempted to add this to the default syscalls runtest file
> but render the test resultless, e.g. replace the tst_res() and tst_brk()
> handlers in tst_res.c so that it will print only INFO messages.

And that would also allow us to have env variable switch that would
enable all tests for unrelased features, something as
LTP_ENABLE_UNRELASED or so. Also with that we can really just TCONF if
that variable is not set which would be much simpler.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
