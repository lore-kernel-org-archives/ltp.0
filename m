Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2578BC43334
	for <ltp@archiver.kernel.org>; Mon,  6 Jun 2022 18:53:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 668CB3C8D0C
	for <ltp@archiver.kernel.org>; Mon,  6 Jun 2022 20:53:27 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A12DA3C01AA
 for <ltp@lists.linux.it>; Mon,  6 Jun 2022 20:53:17 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AD704600847
 for <ltp@lists.linux.it>; Mon,  6 Jun 2022 20:53:16 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9B7431FAB3;
 Mon,  6 Jun 2022 18:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1654541595;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=64aos9Kliqt7RQIxN4MXHys2ifXPFJMGeS+e/ljstYk=;
 b=CbjT3Q0TD43nbGARYfah4jwB7xSkSFejORiuVb0KAhTlQGpg3r9sLCoY7AhNsEaD+Q3U99
 DNzBmcAfe9wZ2ZaE1/tal2aUwetZHFEMb7NUeYrKxL+Rn4z1XQODqMy8BE0yxkUJ5glLxC
 mqUqKFSH6EvQhGqShp56SUaqKDoaE6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1654541595;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=64aos9Kliqt7RQIxN4MXHys2ifXPFJMGeS+e/ljstYk=;
 b=6HUIEaLjY6QDF1+96YIA3ukml5zaNhKdG/BljvRKRuC17WbbbHpnihDTjJ0v6PKeSXVw06
 OHYmb+RmkkVaxvBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 78EA113A5F;
 Mon,  6 Jun 2022 18:53:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id NIXZGxtNnmJhNQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 06 Jun 2022 18:53:15 +0000
Date: Mon, 6 Jun 2022 20:53:13 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Zhao Gongyi <zhaogongyi@huawei.com>
Message-ID: <Yp5NGYJpah3d/uBh@pevik>
References: <20220606113649.41600-1-zhaogongyi@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220606113649.41600-1-zhaogongyi@huawei.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_kvercmp.sh: strip '+' when $(EXTRAVERSION) is
 blank
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Zhao,

> $(EXTRAVERSION) defines an even tinier sublevel for pre-patches
> or additional patches. It is usually some non-numeric string
> such as "-pre4", and is often blank. When $(EXTRAVERSION) is blank,
> there may be a extra '+' which shoud be stripped.
...
>  r3=${r3%%-*}
> +r3=${r3%%+*}

Is that '+' on kernel which sources were modified without commit?
This can be on version with non-blank EXTRAVERSION, but in that case it's
already removed by r3=${r3%%-*}, right?

LGTM
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
