Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB1BBECAAD4
	for <ltp@archiver.kernel.org>; Wed, 31 Aug 2022 12:36:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A03B33CA705
	for <ltp@archiver.kernel.org>; Wed, 31 Aug 2022 14:36:42 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA5673CA6FC
 for <ltp@lists.linux.it>; Wed, 31 Aug 2022 14:36:32 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F3DF4600826
 for <ltp@lists.linux.it>; Wed, 31 Aug 2022 14:36:31 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 51E8A2215C;
 Wed, 31 Aug 2022 12:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661949391;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e5NwDA7HEHckEjkqXLMCrBjoS7glYLt1bT/7BG//evc=;
 b=PnpaRzxjH1qdZ5UUL95egnC8sFYZ6CMuSBgRU6a4CSEdTc6pm9ko9IdlhEY4ysy29m5uCY
 vetcIzdWrg+NMtxLD4D7OIblZ1sgLC/o4Jxcbxx1qT5LJWgdUFRo3mbjxrFXHMQqkbH0nG
 WbEq10ODePXgmpIxZ7qfJ4PMnpjBdJw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661949391;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e5NwDA7HEHckEjkqXLMCrBjoS7glYLt1bT/7BG//evc=;
 b=RWPwiZOLDBUwDQyp7k3ju1fJjRzjGEMK8yemLPlE2w6ghQfjG0EnlIVlnLh3qjS2mG8eLM
 O7+RsuJu3j+yMYBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 072BF13A7C;
 Wed, 31 Aug 2022 12:36:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id HZUoOs5VD2MJHwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 31 Aug 2022 12:36:30 +0000
Date: Wed, 31 Aug 2022 14:36:28 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Luo xiaoyu <luoxiaoyu9@huawei.com>
Message-ID: <Yw9VzAE1YhkwaR1f@pevik>
References: <20220831112620.54251-1-luoxiaoyu9@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220831112620.54251-1-luoxiaoyu9@huawei.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/open04.c: Rewrite open04.c using new LTP
 API --------------------
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

Hi Luo,

patch cannot be applied, could you please send it again?

I guess wrong subject ("--------------------" in
"syscalls/open04.c: Rewrite open04.c using new LTP API --------------------")
is problematic not only for patchwork where struct tst_test is not part of the
changes but in the commit message) [1]

but even applying in raw patch [2 does not work.

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/patch/20220831112620.54251-1-luoxiaoyu9@huawei.com/
[2] https://lore.kernel.org/ltp/20220831112620.54251-1-luoxiaoyu9@huawei.com/raw

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
