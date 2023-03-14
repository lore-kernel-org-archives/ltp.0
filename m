Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B58C6FD1D
	for <ltp@archiver.kernel.org>; Tue, 14 Mar 2023 23:46:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5CE293CD514
	for <ltp@archiver.kernel.org>; Wed, 15 Mar 2023 00:46:16 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D82B93CAD34
 for <ltp@lists.linux.it>; Wed, 15 Mar 2023 00:46:05 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 46C1A200B39
 for <ltp@lists.linux.it>; Wed, 15 Mar 2023 00:46:04 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8A04021BD1;
 Tue, 14 Mar 2023 23:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1678837564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aMjjwvcql2JO8WoufFH0xsOhTryF5qiFpIIZGW6RO4w=;
 b=cj6vbZ29VwKsG7+wCil0JXLvE2iYouPVdyxYJ3M2U0yPQaFzJVccvddgWg5x1SgMAdOl5o
 UUMw8F/3VRlpXBLSoCGErR+JAecUyWZeOHv1fw06eajXQV47DyYpTs+vWkrxXxNc3tK+bC
 unpHNWjyKuudzDyVVzLi3CttLTdJK40=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D9A3313A1B;
 Tue, 14 Mar 2023 23:46:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id s8NeLDsHEWQEMwAAMHmgww
 (envelope-from <wegao@suse.com>); Tue, 14 Mar 2023 23:46:03 +0000
Date: Tue, 14 Mar 2023 19:46:01 -0400
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20230314234601.GA7800@localhost>
References: <20230308132335.29621-1-andrea.cervesato@suse.de>
 <20230308132335.29621-3-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230308132335.29621-3-andrea.cervesato@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 2/3] Rewrite eventfd2_02 test using new LTP API
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Mar 08, 2023 at 02:23:34PM +0100, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  .../kernel/syscalls/eventfd2/eventfd2_02.c    | 147 ++++--------------
>  1 file changed, 33 insertions(+), 114 deletions(-)
> 
Tested-by: Wei Gao wegao@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
