Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A734C433EF
	for <ltp@archiver.kernel.org>; Wed,  5 Jan 2022 15:03:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 80EE03C91BF
	for <ltp@archiver.kernel.org>; Wed,  5 Jan 2022 16:03:41 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B583D3C58DA
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 16:03:31 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 870992009B2
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 16:03:28 +0100 (CET)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 55C2FB81BA4;
 Wed,  5 Jan 2022 15:03:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA166C36AE3;
 Wed,  5 Jan 2022 15:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1641395006;
 bh=Zz7dh/oULjRAdyFY/UkMqMsOTG1+bA+s3LIQszfvG90=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mGuUYBgHYU5NnQecH9MLpKhzhkzl1KFM2Yb9W2feOfPGq/MvHsS6bQJ7tlLpLsRzC
 8BJ1/Xnk9UviKgg3g6oCjbB6pqEkKEBgWYlhvKuBHzDJBFXcFwkZbItmdwBk6rPEQT
 ORjSFonBIx3aSLNPDvOjKPqPhVSJvDsXprdYqrxKKV+VvhRYOE3sNDPx0mfc+vjU0u
 599a8nN6qQPulJfpXCgQuXwrByG5XyXue7j36IyMPjKT2Vj+pBGASyKD4iWrqARvyF
 iymNW3GmvBWtyREw2pkeLLmWjkeMOW6z/uxVcCNGRsv4db0YSQSbdL+gqBC+qfjlYi
 9kaAhg4ZpOhLg==
Date: Wed, 5 Jan 2022 07:03:24 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YdWzPMp1IiF/jiBw@sol.localdomain>
References: <20211222192604.16839-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211222192604.16839-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] tst_af_alg: Moving tst_res(TCONF) to
 tst_have_alg()
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

On Wed, Dec 22, 2021 at 08:26:03PM +0100, Petr Vorel wrote:
> + introduce tst_try_alg() for cases where tst_res(TCONF) cannot be used.
> 
> It reduces duplicity for tst_have_alg() use.
> 
> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
