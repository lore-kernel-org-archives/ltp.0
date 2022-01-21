Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA47C433EF
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 10:35:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 714473C96E5
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 11:35:33 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 25D633C9424
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 11:35:24 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AFA93601483
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 11:35:23 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C2A7E210E0;
 Fri, 21 Jan 2022 10:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642761322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NVKDbrRcMVEmp4+C5TNfzf9zevwd0V07MAOLr03jvFw=;
 b=wkX6++FSc/F4Pb6K+5U8xL/GUmrWq4SaTiFTzAKbAW45QcRqUI2aOI+3id+Vo1uDc4j6rq
 FlZqjiRt4m16pqRWoPnTza2FOpl93tQ8N/2y83nL8VmFOG/ukjKPf0quLI7qdJJrPmDKAo
 D1eV1Vyfhi7QF7F5KFID/9Dz/mcndDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642761322;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NVKDbrRcMVEmp4+C5TNfzf9zevwd0V07MAOLr03jvFw=;
 b=tdF/XjdDqLbtKe4bsK5s+LHdhNUTCAQIzIRn7FT+vipHSFbkSC7CrDe8Ms0iuEpN/4om44
 //WiHoRiDZ+bSwDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B0AB213C32;
 Fri, 21 Jan 2022 10:35:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4I6sKWqM6mEAcgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 21 Jan 2022 10:35:22 +0000
Date: Fri, 21 Jan 2022 11:37:07 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YeqM0+0T3lebbXKt@yuki>
References: <20220121100604.1072-1-pvorel@suse.cz>
 <YeqIB+Y4rO2XK57i@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YeqIB+Y4rO2XK57i@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] aiodio: Skip tests on tmpfs
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
> > tmpfs does not support it.
> Verifying with .all_filesystems, that only tmpfs is problematic
> - tested on exfat, ntfs over FUSE, vfat (common linux filesystems obviously work)
> 
> That's why I avoided opening file with O_DIRECT in setup().
> 
> BTW I wonder what is the reason of duplicate entries in ltp-aiodio.part4?
> i.e. dio_sparse, aiodio_append, dio_append, dio_truncate...
> To create bigger load?
> 
> IMHO it'd make sense to run at least one test on .all_filesystems to check more
> filesystems (dio_append seems to be quick), but I wouldn't done it when there
> are duplicate entries.

Historicall mess I guess. We will clean that up in the next development
cycle.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
