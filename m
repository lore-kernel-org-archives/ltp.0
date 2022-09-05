Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F9CECAAD5
	for <ltp@archiver.kernel.org>; Mon,  5 Sep 2022 10:16:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 56E113CA901
	for <ltp@archiver.kernel.org>; Mon,  5 Sep 2022 12:16:10 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 535433C2FCE
 for <ltp@lists.linux.it>; Mon,  5 Sep 2022 12:15:57 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7AC81140005F
 for <ltp@lists.linux.it>; Mon,  5 Sep 2022 12:15:55 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 57B285F84F;
 Mon,  5 Sep 2022 10:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662372954;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gWtSggFJkNzkrTJxfyKjDX7zdzZoa4BFjVyQPPVRMgo=;
 b=AfTFXAG7h8YSSbAjgBrVz/bKMhU6OnkXfRhB5SAc03EPfW3MtgjNCHK1QKGyg4Tf+JpRzn
 pZzneApppCe1Ah+WocG32cyFzykHkScZYG9FWzCmwGtScMM8Eq+qZuX2baKcPBc506ESu4
 aoo9l4sADdGgelBlDlc4ZRWO+f0UA58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662372954;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gWtSggFJkNzkrTJxfyKjDX7zdzZoa4BFjVyQPPVRMgo=;
 b=kpXQpwf9B8K+hJOE/w6HsH51YQFxe5xrKycxJYBaAZZao4v4Uaw3vq4TbKjWOTdBXTa0B9
 IcGimaCZNCC8seCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C8E813A66;
 Mon,  5 Sep 2022 10:15:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ab8qCVrMFWO8QAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 05 Sep 2022 10:15:54 +0000
Date: Mon, 5 Sep 2022 12:15:52 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Xiao Liang <xiliang@redhat.com>, ltp@lists.linux.it
Message-ID: <YxXMWLOmJWYp2aaX@pevik>
References: <20220905074330.24989-1-xiliang@redhat.com>
 <YxW+Mbb1KEy4qe16@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YxW+Mbb1KEy4qe16@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] zram03: unload zram when it is loaded during
 test run
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xiao,

> Indeed, test does not unload zram on older kernels without zram-control
> interface. Good catch!
I was wrong, for both cases the module was kept even not loaded before.
Anyway merged, thanks for your fix!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
