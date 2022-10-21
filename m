Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79440C433FE
	for <ltp@archiver.kernel.org>; Fri, 21 Oct 2022 11:17:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E655E3CB1D3
	for <ltp@archiver.kernel.org>; Fri, 21 Oct 2022 13:17:53 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 12FE33C93AA
 for <ltp@lists.linux.it>; Fri, 21 Oct 2022 13:17:42 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 33E4F60081B
 for <ltp@lists.linux.it>; Fri, 21 Oct 2022 13:17:41 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B464D1F8E6;
 Fri, 21 Oct 2022 11:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1666351060;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pUKwnl1bHmpYq6cKrSZo3DaLM27g74B3hpgusbTOJfQ=;
 b=RFcXi3hZ6NJb43PdZu/BXyGZXySnIg9FizzECflw8SWi6UKieknJUcLIURN/sBIss9ynqm
 KKaejHGIUG7sQENrlSN0UHNInR3GnMZbEcsukqKb+YX18LuOP2Pya6Lu1wiXRcFYMxCK3p
 fi2RaCBJlEJDYtgIl04R63Tb6o4NCLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1666351060;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pUKwnl1bHmpYq6cKrSZo3DaLM27g74B3hpgusbTOJfQ=;
 b=jXZ+L+qZ84CpNUZFN2FLEvyDVuKoMSlEBTLODnLuPdFscpD1S735vc/mZYDnyiwxnyCChK
 Mj8GWQujZAkUO6AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8C5651331A;
 Fri, 21 Oct 2022 11:17:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id GOmwINR/UmOzNwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 21 Oct 2022 11:17:40 +0000
Date: Fri, 21 Oct 2022 13:17:38 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Y1J/0uRjOgZYKIGi@pevik>
References: <20221020034140.3472638-1-liwang@redhat.com>
 <7f283a53-2710-d721-dc11-5ca1c5d1aa06@fujitsu.com>
 <CAEemH2fru9haqdSa++jcMU7U3XwgBsvjHpcTQ3mksnsn7=igwA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fru9haqdSa++jcMU7U3XwgBsvjHpcTQ3mksnsn7=igwA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] kconfig: adding new config path
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
Cc: Brian Grech <bgrech@redhat.com>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

+	/* RHIVOS config path */
+	snprintf(path_buf, path_buf_len, "/lib/modules/%s/config", un.release);

FYI openSUSE Tumbleweed also moved config to this path, I'd remove the comment
and mentioned also openSUSE Tumbleweed. In the end we add also symlinks to /boot
(the usual place) so that Tumbleweed works without this patch, but I guess it's
better to mention that it's not just RHIVOS specific.

Kind regards,
Petr

> > ps: I guess  RHIVOS doesn't have kconfig file in /boot directory, so it
> > can't be parsed. Is it right?


> That's right. And I would leave this patch one more day for others to
> review.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
