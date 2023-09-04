Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB98DC71153
	for <ltp@archiver.kernel.org>; Mon,  4 Sep 2023 15:18:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 13AE03CB936
	for <ltp@archiver.kernel.org>; Mon,  4 Sep 2023 17:18:13 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 611863CB911
 for <ltp@lists.linux.it>; Mon,  4 Sep 2023 17:18:02 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id ACB1B600826
 for <ltp@lists.linux.it>; Mon,  4 Sep 2023 17:18:01 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2E27E21858
 for <ltp@lists.linux.it>; Mon,  4 Sep 2023 15:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693840681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XXMVDMflCJPI2bQAQr4TmI7+vYr1n/Rlv+cY/b9MtPk=;
 b=cWsbuFkHZKqp85WdNS3jiUmJQCzsrwRNF3/uPJl5gW/HXPWVq+jm9mz9AuBsUqA2+XV5A7
 /0NghRHDpaMC9LHmheGsIY7FZwwvjEHDavfHN9O/9pifS1AxPw8ORTT3RxfDMiR429Hic/
 XPqx+jEvtoH9BfehnX6pn4z29Svdrnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693840681;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XXMVDMflCJPI2bQAQr4TmI7+vYr1n/Rlv+cY/b9MtPk=;
 b=pXms1CL1NonN/5Y5IbVA6GMl2tMWXYRxlbqvz9iPZtL6Gqcud33/tfvDwVDZqAyLi7W4dJ
 YtKo2+rzATFMK4Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D7CD13585
 for <ltp@lists.linux.it>; Mon,  4 Sep 2023 15:18:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id pr0ZBin19WTUSAAAMHmgww
 (envelope-from <mkittler@suse.de>)
 for <ltp@lists.linux.it>; Mon, 04 Sep 2023 15:18:01 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp <ltp@lists.linux.it>
Date: Mon, 04 Sep 2023 17:18:00 +0200
Message-ID: <4508326.LvFx2qVVIh@linux-9lzf>
In-Reply-To: <ZPXyE9O38JHxfiV0@yuki>
References: <20230904145035.22939-1-mkittler@suse.de> <ZPXyE9O38JHxfiV0@yuki>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Use correct ioctl request for termios
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Am Montag, 4. September 2023, 17:04:51 CEST schrieb Cyril Hrubis:
> 
> I guess that it would be cleaner to keep the single request, but define
> the s_tio as a void * here.
> 
> That way we can add test on a separate lines:
> 
> 	{&bfd, TCGETA, &termio, EBADF},
> 	{&bfd, TCGETS, &termios, EBADF},
> 	...
> 

But we have currently 4 tests that are all executed via both termio and 
termios. To keep this kind of coverage we would need to duplicate all of those 
lines. That would be 4 new test lines in total. Is that what you're 
suggesting? I'm just asking twice because I'm not sure whether it is better 
(but don't have a strong opinion).

By the way, how would I submit an amendment here? Just submit the amended 
commit again in the same way (I used `git send-email --
to=ltp@lists.linux.it`)?

And how is this merged? I saw that in another case patchwork was used? How 
does that come into play?



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
