Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E2CEF48C5
	for <ltp@archiver.kernel.org>; Sat, 14 Feb 2026 12:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771071873; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=6M7PKYCAuC4eUMEVjDHOW0598bqmShPdyRpZPbWLtv0=;
 b=E7qh6MTka2iIVHT8vLYq05che47ah9xO06nubLj9HaGoaL8sJaKgDe/92RPiE7rWpc/xb
 174gZFgRpwGsIDfy1Z/qpPVSxM1XsEHNgK7w8DnShOL51GNBjIgtIXHKojhUuGuqJ7o+iRv
 tW3whMf7Bdfq0WovmR3OKOtUlirscxs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 129993CFB8E
	for <ltp@archiver.kernel.org>; Sat, 14 Feb 2026 13:24:33 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D5D983CCBC9
 for <ltp@lists.linux.it>; Sat, 14 Feb 2026 13:24:08 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A85891000643
 for <ltp@lists.linux.it>; Sat, 14 Feb 2026 13:24:07 +0100 (CET)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 8A5166011F;
 Sat, 14 Feb 2026 12:24:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE63C16AAE;
 Sat, 14 Feb 2026 12:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771071845;
 bh=30f27v+mHS60nppfktd31AaQvXVA9o6eescZJPxBXZ4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sWMmdqkDhmfOZr3aXjc9BVKN2U14OO46QgfaGYtdndCZlh5NYvxVQI10lZs7vaWUp
 aRRl95KcLhc7Qx1JJXqbsmhc1cYuOt2FCHwi7jkmeOwwDwbOupmohcShLqUQNJfHTL
 pXYKKJkjzX00z3p8JOgvsqMQfnxIofD3Rb9rs3orEYfvPw4XgrysVW9xtyjJ3QUwl6
 EqS6jP5ptpDd2e1Hsn4SnaK5odM0TR2XcH0I/+6XFhPIT90bYJhbXzFLNKDZPun7zC
 So3qZvtY4wLzYRkqJHI2pU2arunRu0zDbT22E9Ai2CeFKMFya3OzpoqOkA1P0lVMKg
 cDZO0imesPO7g==
Date: Sat, 14 Feb 2026 13:24:00 +0100
To: Cyril Hrubis <chrubis@suse.cz>, Mark Brown <broonie@kernel.org>
Message-ID: <20260214-ausformuliert-aufgearbeitet-7b45890e036a@brauner>
References: <202602122354.412c5e65-lkp@intel.com> <aY7wZwHXH2zS_Sj-@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aY7wZwHXH2zS_Sj-@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [linux-next:master] [mount] 4f5ba37ddc: ltp.fsmount02.fail
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
From: Christian Brauner via ltp <ltp@lists.linux.it>
Reply-To: Christian Brauner <brauner@kernel.org>
Cc: lkp@intel.com, linux-kernel@vger.kernel.org, oe-lkp@lists.linux.dev,
 kernel test robot <oliver.sang@intel.com>, linux-fsdevel@vger.kernel.org,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Feb 13, 2026 at 10:35:35AM +0100, Cyril Hrubis wrote:
> Hi!
> > commit: 4f5ba37ddcdf5eaac2408178050183345d56b2d3 ("mount: add FSMOUNT_NAMESPACE")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> The relevant part of the log is:
> 
> fsmount02.c:56: TFAIL: invalid-flags: fsmount() succeeded unexpectedly (index: 1)
> 
> This is another case where new flag was added so the invalid flag value
> is not invalid anymore. The test needs to be adjusted if/once the patch
> hits mainline.

Ah, very good to know. Adding Mark so he's aware that this is an
expected failure.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
