Return-Path: <SRS0=zuCx=QD=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4726CC433EF
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 09:39:20 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98E2761A38
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 09:39:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 98E2761A38
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4AE983C87B6
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 10:39:17 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD7093C0CB4
 for <ltp@lists.linux.it>; Tue, 16 Nov 2021 10:39:08 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2F9BE600669
 for <ltp@lists.linux.it>; Tue, 16 Nov 2021 10:39:07 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D32E7218B5;
 Tue, 16 Nov 2021 09:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1637055546;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CezZgvPKd6a0fiWdap0e7b8v4ujAL7uGRptnSu+aiY4=;
 b=U+zXF8lsfcUWMyYm/OE/wusdtcwuCwXZk6svluSx7H2/0++N6gJMz2MJ+c0sqs6yntGyfI
 HcI8GDAuc73WmZxzOjuYi1dnqPLPQ6EZcE+TAajX/+mDrH5+xXYDUMLl+9Y29OXZE2jIti
 hdN1zw8XMEgaJdiwNOs/fIPv4xY0+0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1637055546;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CezZgvPKd6a0fiWdap0e7b8v4ujAL7uGRptnSu+aiY4=;
 b=/aqNPel9n01A3K6GW+PR6qEoBhLrupH14AKEkWxX4MxuL13M0sus99rwcyCC+yfoftWAPv
 7hMF+E+pVLbk63Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A35B613BFD;
 Tue, 16 Nov 2021 09:39:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bw/sJTp8k2HGEQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 16 Nov 2021 09:39:06 +0000
Date: Tue, 16 Nov 2021 10:39:04 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Matthew Bobrowski <repnop@google.com>
Message-ID: <YZN8OLkeUUBP8yDK@pevik>
References: <cover.1636451496.git.repnop@google.com>
 <0671d89befb5b24fc3bac510c69811668c39cdf5.1636451496.git.repnop@google.com>
 <CAOQ4uxiFsnvA-8y1mJ7uHccd4bqZUYJkK5Y2R1+KtgDK_OH4Sw@mail.gmail.com>
 <YZLPEjJkII1evtEc@pevik> <YZMEMwvdpA/IXz+P@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YZMEMwvdpA/IXz+P@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/3] syscalls/fanotify: Add a helper macro
 which checks for the presence of specific fanotify initialization flag(s)
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
Cc: Jan Kara <jack@suse.cz>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Matthew, Amir,

> On Mon, Nov 15, 2021 at 10:20:18PM +0100, Petr Vorel wrote:
> > Hi Matthew, Amir,

> > Tested on two distro kernels with support (Tumbleweed and Debian unstable)
> > + on various old kernels without support.

> > Merged with very minor fixes, see diff below.

> Noted the changes, they're fine by me. Thanks for the merge!
+1

> > NOTE: we now support basic static analysis + checkpatch formatting check - run
> > make check in fanotify directory or make check-fanotify20.

> Oh, that's great, I had no idea. Quickly running it, looks like
> there's a bunch of clean up required for some of the older tests. Will
> have to get around to doing that at some point.

Thanks a lot, that's really appreciated.
Also, thanks a lot you and Amir for really maintaining fanotify tests.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
