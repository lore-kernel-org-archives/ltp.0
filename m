Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E33C25B76
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 14:33:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C24CB3D0998
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 16:33:51 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 012723C8964
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 16:24:22 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linuxfoundation.org (client-ip=2604:1380:4641:c500::1;
 helo=dfw.source.kernel.org; envelope-from=konstantin@linuxfoundation.org;
 receiver=lists.linux.it)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D9C966068ED
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 16:24:21 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 6AF5B61857;
 Wed,  5 Jun 2024 14:24:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED3DC2BD11;
 Wed,  5 Jun 2024 14:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1717597459;
 bh=LpYjaeNBWM5LiiTfhVpgzvG0NOG5j/r+r8aSf/fQm1g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sThIzx+4uyWng9xslMXjafmpyU3FgE9ngIKFz+lvdWbvu4LySurFmFcElmjlSdjjf
 +0wgSenr5Vho7Z2Pz6a249mH1Dj7xBwAP80OtsbV6GwOsgfVyMFiXE5fcoe1OaHPUv
 raHwys9OYo8lVG3KLZN7t2JuAoEinYMqp8LtkjTs=
Date: Wed, 5 Jun 2024 10:24:17 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20240605-faithful-illegal-aardwolf-db2edd@lemur>
References: <20240604-unlink09-v1-1-dfd8e3e1cb2b@suse.com>
 <20240605065755.GB348321@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240605065755.GB348321@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 05 Jun 2024 16:33:35 +0200
Subject: Re: [LTP] [PATCH] Fix unlink09 test
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
Cc: Sebastian Chlad <schlad@suse.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Jun 05, 2024 at 08:57:55AM GMT, Petr Vorel wrote:
> > base-commit: 66517b89141fc455ed807f3b95e5260dcf9fb90f
> I see useful b4 feature :).
> 
> > change-id: 20240604-unlink09-dc4802f872f9
> But I wonder what is this for (what tool use change-id).

This allows you to reliably find all revisions of the same series, for example
to do range-diffs between them.

-K

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
