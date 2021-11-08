Return-Path: <SRS0=tV2W=P3=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4A8C433F5
	for <ltp@archiver.kernel.org>; Mon,  8 Nov 2021 10:17:52 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2955F60F45
	for <ltp@archiver.kernel.org>; Mon,  8 Nov 2021 10:17:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2955F60F45
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7604D3C7665
	for <ltp@archiver.kernel.org>; Mon,  8 Nov 2021 11:17:50 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 194123C2435
 for <ltp@lists.linux.it>; Mon,  8 Nov 2021 11:17:40 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6980A600940
 for <ltp@lists.linux.it>; Mon,  8 Nov 2021 11:17:40 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AEC2921AFC;
 Mon,  8 Nov 2021 10:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1636366659;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bksp4xWDnTXuzCuajPvYy5hewiTI2Kata6YGDSpxHEI=;
 b=FrWdd0AgEaEXKtuJAaYRd/Yh8ndsMcidWpjzYJTAJpCZw/hSLs3Jno6+NuWwAmJHtXoOUU
 khycIk2MQ2kZFML/UNCHniDVi9WQo3BuYiv4SRjGr5jIhK05IomCS7AQFIpfE+u9u41aZK
 Htg3ec2V9I6BYdLlEh3YQ/GWLXM6cM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1636366659;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bksp4xWDnTXuzCuajPvYy5hewiTI2Kata6YGDSpxHEI=;
 b=PLgx22NuhLIdTXwZjWnZFZgH5CeCPhuHTk+RhA5dum+mXIHNK/3VKyDWN6Bfv/3+oec7/c
 XFvyXX5JuTN7OtBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7DA6613B2C;
 Mon,  8 Nov 2021 10:17:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QNcqHEP5iGEQFwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 08 Nov 2021 10:17:39 +0000
Date: Mon, 8 Nov 2021 11:17:37 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YYj5QSB2pCzgxZtJ@pevik>
References: <20211104164528.29936-1-pvorel@suse.cz>
 <CAEemH2c4rfko1a=V-W04N0QXs9GKhJkc60_WjWFBe+BqbLQ3tA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2c4rfko1a=V-W04N0QXs9GKhJkc60_WjWFBe+BqbLQ3tA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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

Hi Li,

> On Fri, Nov 5, 2021 at 12:45 AM Petr Vorel <pvorel@suse.cz> wrote:

> > Fix running make test-c as non-root.

> > Fixes: 057d6b046 ("lib/tst_hugepage: Fix .request_hugepages = 0 bug")

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > Hi,

> > maybe echo "128" would not have to be checked.


> Agreed, If the system memory is too fragmental to keep
> enough hpages, there won't be an error returned.
OK, wait little longer and then merge with keeping
echo "128" > /proc/sys/vm/nr_hugepages

...
> > -echo "128" > /proc/sys/vm/nr_hugepages
> > +if ! echo "128" > /proc/sys/vm/nr_hugepages; then
> > +       tconf "Failed to write /proc/sys/vm/nr_hugepages"
> > +fi

Thanks for your review!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
