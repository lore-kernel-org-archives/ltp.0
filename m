Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94173C433FE
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 12:51:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B6B293C9229
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 13:51:30 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5FF123C9207
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 13:51:21 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C7EA3140126A
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 13:51:20 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D5A1F212CA;
 Tue, 21 Dec 2021 12:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1640091079;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z5cGZqc32iYgDSTgHUGzMRlHVmdmwYvboHAdE8vuS88=;
 b=0Dg4xVVzsDsQQdbI4oHC3ph2i0ntDVjuOZOXTo9vpb0lb39Cp5yzsfmhhAlGR6AhOtqIhx
 AlM8e4DhMvjXoXRwUDrK2hOAuWEBB24AB8AB0spqSEhJHoc8OGs468hwC9h1lErihBjWih
 FGj/2k01kojRSfnlZP7ZlybQC3zkzBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1640091079;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z5cGZqc32iYgDSTgHUGzMRlHVmdmwYvboHAdE8vuS88=;
 b=f9tIEH+x1HuFLJ/aZn06oJo3Xb3ZVsPJcHlit2y98mUQ82dcfq7jgoWJ95lmSZZdFcZ+vM
 CYvwnZ3u4Yvnm8CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A718713A6A;
 Tue, 21 Dec 2021 12:51:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id F7TnJsfNwWEQIQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 21 Dec 2021 12:51:19 +0000
Date: Tue, 21 Dec 2021 13:51:17 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YcHNxTUWY3eBHzTu@pevik>
References: <20211220195111.24580-1-pvorel@suse.cz>
 <YcHFGga1tl8OS+xw@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YcHFGga1tl8OS+xw@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] tst_test_macros.h: Print also returned value
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

Hi Cyril,

> > +			TST_MSGP2_(TFAIL | TTERRNO, " retval not %ld (%ld)",          \
>                                                           ^
> 					Should probably be " retval %ld != %ld", TST_RET, (long)VAL, ...

+1, merged this version with your ack.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
