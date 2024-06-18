Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42FB3C2BA18
	for <ltp@archiver.kernel.org>; Tue, 18 Jun 2024 14:20:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7BC733D0D88
	for <ltp@archiver.kernel.org>; Tue, 18 Jun 2024 16:20:06 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2EFDF3D0D3B
 for <ltp@lists.linux.it>; Tue, 18 Jun 2024 16:19:50 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:40e1:4800::1;
 helo=sin.source.kernel.org; envelope-from=brauner@kernel.org;
 receiver=lists.linux.it)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C687D1A0C268
 for <ltp@lists.linux.it>; Tue, 18 Jun 2024 16:19:48 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 12B23CE1B5A;
 Tue, 18 Jun 2024 14:19:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99C9C4AF1C;
 Tue, 18 Jun 2024 14:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1718720383;
 bh=UqZBiwmvQMI5HGnnEhRCGYjgZawaMVa1pp26/ZQFIes=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YAcNWk7eUuOFX2i8PJBf8Z5aTCdu8qAZllU0sTYORAnmCVGUGjFr7SwncOa8wRD2F
 uL6buN28D7/bNMFeDKlFajhBNStOjpkcILIXDgTXLAT5aHSzQ3kPA7jA4D8vi2Mpwq
 +BxohKMW770x5tyoBkRE/1q35/hluYKIf6cs9xJDGIJnCsTbYad9APhTlfKYIOEn7N
 I4x+orNY2WSIcYqprbr2BbEL+H2I9U08otflJKJFJjKfl0OClBqoR8HfhqeqQ71nzF
 9lxXJmqVGHPgByL4X4O287IAnQqS1VZZelUFK//GQPtDIMrOHJwOD3TQpYtwA/6Dfj
 MCbe9NGZcUOFg==
Date: Tue, 18 Jun 2024 16:19:37 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Message-ID: <20240618-wahr-drossel-19297ad2a361@brauner>
References: <171817619547.14261.975798725161704336@noble.neil.brown.name>
 <20240615-fahrrad-bauordnung-a349bacd8c82@brauner>
 <20240617093745.nhnc7e7efdldnjzl@quack3>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240617093745.nhnc7e7efdldnjzl@quack3>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] VFS: generate FS_CREATE before FS_OPEN when
 ->atomic_open used.
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
Cc: linux-nfs@vger.kernel.org, NeilBrown <neilb@suse.de>,
 LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
 ltp@lists.linux.it, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> AFAICT this will have a side-effect that now fsnotify_open() will be
> generated even for O_PATH open. It is true that fsnotify_close() is getting

Thanks! That change seemed sensible because a close() event is
generated.

But I don't agree that generating events for O_PATH fds doesn't make
sense on principle. But I don't care if you drop events for O_PATH now.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
