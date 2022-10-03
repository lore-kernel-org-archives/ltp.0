Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E3FC4332F
	for <ltp@archiver.kernel.org>; Mon,  3 Oct 2022 13:58:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C4F03C93F3
	for <ltp@archiver.kernel.org>; Mon,  3 Oct 2022 15:58:37 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1952F3C4F4A
 for <ltp@lists.linux.it>; Mon,  3 Oct 2022 15:58:27 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4B28F6008B5
 for <ltp@lists.linux.it>; Mon,  3 Oct 2022 15:58:25 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 013A4218CE;
 Mon,  3 Oct 2022 13:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1664805505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H10lECbf4OGv8SS8Dhv06c1XI2Ltfq9qgcX5tFc/pWs=;
 b=jCScxhWO80w8cQYxQi+Wjl7HsXYtwNiAh70oqbgU7Z4ns2fpdN+rd8XrdXCSoHPGUKPEM5
 Jmh9QIDPjDDgAwE5RpbnNN+cDghZth8Mw+OeQysjDSnUa3hYfeJyAtQ3TJgSJ0nc00xFfL
 aYdXzgbKsDig+5FvwQ9GKnkUBx5AH9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1664805505;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H10lECbf4OGv8SS8Dhv06c1XI2Ltfq9qgcX5tFc/pWs=;
 b=sbJlK4mXk3AOOuL1xiOC4Gqkj11tCNMzrKHJjlyJkf1/iDdusgqpzKHGGDpkLdTSgbcpOu
 d51lWPQ/IJw0znDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D7E3D1332F;
 Mon,  3 Oct 2022 13:58:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 40T9M4DqOmPaXQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 03 Oct 2022 13:58:24 +0000
Date: Mon, 3 Oct 2022 16:00:15 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <Yzrq7x+pMCnupUJ8@yuki>
References: <43d65409eb3290b09e1c3a21cb0dc079c5f4849c.1664801307.git.jstancek@redhat.com>
 <YzrguY3J3YLJhU//@yuki>
 <CAASaF6wmVVjattUS=XpAjs03692R8BLU+GE4ao+VpVz29eO2Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6wmVVjattUS=XpAjs03692R8BLU+GE4ao+VpVz29eO2Pw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] lib: introduce safe_write_fully()
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
> I do find those names little confusing. What do you think about:
> 
> SAFE_WRITE_ANY = 0 // no strictness
> SAFE_WRITE_ALL = 1 // all strict
> SAFE_WRITE_RETRY = 2 // retry

+1 for making them shorter and more descriptive.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
