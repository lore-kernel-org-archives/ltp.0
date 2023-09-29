Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE2FAE80A98
	for <ltp@archiver.kernel.org>; Fri, 29 Sep 2023 11:26:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A2C13CE124
	for <ltp@archiver.kernel.org>; Fri, 29 Sep 2023 13:26:30 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 210563CBA26
 for <ltp@lists.linux.it>; Fri, 29 Sep 2023 13:26:18 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9BE941A05C9C
 for <ltp@lists.linux.it>; Fri, 29 Sep 2023 13:26:16 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7A136218E8;
 Fri, 29 Sep 2023 11:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695986776;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0vw59bnk/Wrqb8vYCk/WCQsYBAd/HBqU1BvDPB688GI=;
 b=ILbLmxJzJMDsSDJlWv/DlRQXLUtMrhZC6FixwS1mvIdDie7MO2JXL8UFrTeoMpEiz/3Y4Y
 BfZc3A9n1fWjAOCadTHzFYwbfoyU2xwalZMcMVSIyaI1TBfecVucDmNMVkag4mFPTMXUEh
 Mj70XYn6J8m6iC5eSbqH4ZnqpBlGipQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695986776;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0vw59bnk/Wrqb8vYCk/WCQsYBAd/HBqU1BvDPB688GI=;
 b=c7/fKrT0p3sp0HQBwFwNj3BPgMzEQ/EFg7G2yPK38k15X0mhUQqK7yO6Jomz2PRIGltmSL
 oPgOkXpY5+tTEnBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CB61A13434;
 Fri, 29 Sep 2023 11:26:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id FKZRLVe0FmWuQwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 29 Sep 2023 11:26:15 +0000
Date: Fri, 29 Sep 2023 13:26:13 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20230929112613.GA379979@pevik>
References: <20230721123852.1420080-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230721123852.1420080-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] nfs_lib.sh: Set NFS 4.2 on TCP as the default
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
Cc: Olga Kornievskaia <olga.kornievskaia@gmail.com>,
 Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Chuck Lever <chuck.lever@oracle.com>,
 Anna Schumaker <Anna.Schumaker@netapp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Previously NFS 3 on UDP was the default, which leaded to test being
> skipped when tests run without parameters:

> TCONF: UDP support disabled on NFS server

> This does not have an effect when tests run properly via
> runtest/net.nfs, which specify parameters. It just safes typing
> -t tcp (and optionally -v 4.2) when one runs single test manually.

FYI patch merged.

Kind regards,
Petr

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi,

> I'm pretty sure, we don't want to have UDP as the default (besides
> skipped with TCONF it was acked by Jeff [1]). But I wonder if NFS 4.2 is
> the best as the default version. Maybe just 4 or 4.1?

> Kind regards,
> Petr

> [1] https://lore.kernel.org/ltp/e4d22ae6cefb34463ed7d04287ca9e81cd0949d8.camel@kernel.org/

>  testcases/network/nfs/nfs_stress/nfs_lib.sh | 4 ++--
...
> -VERSION=${VERSION:=3}
> +VERSION=${VERSION:=4.2}
>  NFILES=${NFILES:=1000}
> -SOCKET_TYPE="${SOCKET_TYPE:-udp}"
> +SOCKET_TYPE="${SOCKET_TYPE:-tcp}"

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
