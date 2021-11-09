Return-Path: <SRS0=8di7=P4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535EFC433F5
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 09:43:16 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C57F161051
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 09:43:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C57F161051
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AEBB03C07B4
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 10:43:13 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC53F3C0781
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 10:43:04 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E27DF140EC5C
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 10:43:03 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8FA0621B04;
 Tue,  9 Nov 2021 09:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1636450982;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iJAX0lfCHJdFSJhsU/VU1qvaKp3ugSIlfd0VExsOQbU=;
 b=uZb6rjyFOCVVIL6lrV28BiHyvq1oyxb3j9bh6+pzMHizbw+tbupiKahIIof7/EPc9qcEez
 N+c4vOZRXx1vKUENiwA19Hu73e4GJ3Oe2U+QH0sH6uQQ/vLeI/LHVYGlDjCk7CM4kwtGrb
 tW5aEdtoIaWJeU8iEy8X+AtdWsQ0Ymw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1636450982;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iJAX0lfCHJdFSJhsU/VU1qvaKp3ugSIlfd0VExsOQbU=;
 b=wSGlLutMh2MjLjHY0aXcnB0kJw0K37QoZv49mBsxT9GBFsqYxvGQNqDP198yeJz7sekjgv
 QIJ5cbP+3ik9VWDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6603A133D1;
 Tue,  9 Nov 2021 09:43:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Bu5EF6ZCimH4WwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 09 Nov 2021 09:43:02 +0000
Date: Tue, 9 Nov 2021 10:43:00 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <YYpCpKYBbIoxmlBO@pevik>
References: <20211104164528.29936-1-pvorel@suse.cz>
 <CAEemH2c4rfko1a=V-W04N0QXs9GKhJkc60_WjWFBe+BqbLQ3tA@mail.gmail.com>
 <YYj5QSB2pCzgxZtJ@pevik> <YYk1kWh/yKY31YZB@yuki>
 <6189C62B.2060702@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6189C62B.2060702@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] test_zero_hugepage.sh: Detect errors write to
 /proc/sys/vm/nr_hugepages
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Hi Cyril
> > Hi!
> >>> Agreed, If the system memory is too fragmental to keep
> >>> enough hpages, there won't be an error returned.
> >> OK, wait little longer and then merge with keeping
> >> echo "128">  /proc/sys/vm/nr_hugepages

> > Also I wonder why do we request 128? I guess that 4 would be more than
> > enough.
> I don't think about so much when I wrote this script. Using a small 
> number is also ok for me.

Good point! I thought it's needed to have that high value.
I'll send a separate patch for this.

Merged this one.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
