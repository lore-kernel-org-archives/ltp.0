Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F3FCD4F35
	for <ltp@archiver.kernel.org>; Fri, 22 Sep 2023 08:56:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 81FBD3CBDFD
	for <ltp@archiver.kernel.org>; Fri, 22 Sep 2023 10:56:37 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 065533C65F4
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 10:56:26 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 70FEA208DF1
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 10:56:25 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6488B210E3;
 Fri, 22 Sep 2023 08:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695372985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9wLTgP0LgNKgwRFudA7F6mye+TjDfC86XaJlb7Aq1gM=;
 b=nDxmLcAklejJ4LrfFvF6OSxvMZ64g7DByWWDJNdENmFv13DH5KX/Y/G1C4Wkon/hDn+4WW
 dC+7APMVcbN121DeMQJVDvniJiwHSHrN3vR/CSKM3GqfMLcBpumjMkjQ8z1yPAktpVy5FG
 EzdwjTlYx1gmxANxilmsMx7rO2649wo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695372985;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9wLTgP0LgNKgwRFudA7F6mye+TjDfC86XaJlb7Aq1gM=;
 b=2rX8K5su7Czc89or7/OcnY8k7igrocQpG5bU9+e7Ajqt3oEE2AZvCkmoJZ+fx3tjHHaV48
 U7KA6JqlG5mE5JCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 04AF113597;
 Fri, 22 Sep 2023 08:56:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id dNaBO7hWDWVzSwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 22 Sep 2023 08:56:24 +0000
Date: Fri, 22 Sep 2023 10:57:09 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <ZQ1W5RYojFVpTrdr@yuki>
References: <20230921140721.11382-1-chrubis@suse.cz>
 <CAEemH2fir0Ta6=BnpXGhJD8o4CrPUTMnjNG0JKW1C2S-M4SVZw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fir0Ta6=BnpXGhJD8o4CrPUTMnjNG0JKW1C2S-M4SVZw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] lib: tst_test: Fix lockdown detection on
 missing sysfs
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
> Should we fix the detection of additional those too?
>   finit_module02.c, init_module02.c, madvise11.c
> 
> Otherwise, this method looks good.
> Reviewed-by: Li Wang <liwang@redhat.com>

Pushed as well as patches from martin the fixed the rest.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
