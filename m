Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B7EC4332F
	for <ltp@archiver.kernel.org>; Thu,  2 Nov 2023 12:51:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EA8E33CE982
	for <ltp@archiver.kernel.org>; Thu,  2 Nov 2023 13:51:43 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2062C3CC0FC
 for <ltp@lists.linux.it>; Thu,  2 Nov 2023 13:51:33 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 242DA1A00A3A
 for <ltp@lists.linux.it>; Thu,  2 Nov 2023 13:51:32 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CC3171F8C1;
 Thu,  2 Nov 2023 12:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698929491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nhVzrKjQmjqLhyDDMGLShMKYp1TcU1juw6DwPsCaNFA=;
 b=p+HpiCyM8b8KVOvhqXbxsBpHmlDNyxxYsfeu7vvCxdg7ZSD7sYUiSwwwdKxT0HniBTIE8R
 SuJL6c6EycT48c8Dj5HiuLHDNBhz5s5UnCLMoA8vFScHLVO3mccErzT43dCC0MMsRqzwTf
 FD3y3ggM//iATwVrANCbOaoqjz52GVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698929491;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nhVzrKjQmjqLhyDDMGLShMKYp1TcU1juw6DwPsCaNFA=;
 b=4l6zKWNJLsMDPqd7LO0gCWalzf/Pr0x/OhuGsZd3rrn3C68/t4ee/gjm8TBNr++yhIow+t
 m9L2JzRgJOFJgaBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BA2D113584;
 Thu,  2 Nov 2023 12:51:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id a6rgLFObQ2UpVQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 02 Nov 2023 12:51:31 +0000
Date: Thu, 2 Nov 2023 13:52:03 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZUObc261T47VHVJp@yuki>
References: <20230907150538.16772-1-andrea.cervesato@suse.de>
 <ZUJydZgdGTcPQAxt@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZUJydZgdGTcPQAxt@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Refactor fork09 using new LTP API
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
> Honestly I'm struggling to understand the point of this test, the
> description says:
> 
> "Check that child has access to a full set of files"
> 
> What is that supposed to mean? I guess that if we wanted to check that
> the child has inherited the file descriptors ee should open a few files,
> do some changes in the child/parent and check that they are not propagated to
> the other one. I.e. reading from a file in child/parent does not change
> file offset in parent. Closing a file descriptor from a child/parent

And I tend to forget that the file offset is shared between child and
parent in this case. Maybe it's because I want to forget about that
particular detail to begin with.

And the test fork10.c actually checks the offset case, so I have no idea
what to do with fork09.c test. Maybe we should just delete the test and
write new for something that is not currently tested, there is plenty of
Linux-specific behavior listed in fork(2) man page that is not tested at
all...

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
