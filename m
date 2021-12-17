Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9071FC4332F
	for <ltp@archiver.kernel.org>; Fri, 17 Dec 2021 08:26:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF0D13C8FA0
	for <ltp@archiver.kernel.org>; Fri, 17 Dec 2021 09:26:09 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC6633C0E12
 for <ltp@lists.linux.it>; Fri, 17 Dec 2021 09:25:59 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3160A14088C6
 for <ltp@lists.linux.it>; Fri, 17 Dec 2021 09:25:58 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6F4A321637;
 Fri, 17 Dec 2021 08:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639729558;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XxxpL0p0xyL2pBIRJ0Qc+eFQr+N+FdeGVg1so8dvCrw=;
 b=rUfvmvtqo0uG13uUUlqomzMDtxr4g3+UaMCfKuL51Vz85LZiMKUOzEHWpJof2TeqWKdKSe
 X3Yugch7pBBklThB2DcRp3PJhqget0Jxi/se3zPNy+fCjht20UWjzIwKMwEHsclUDFoItM
 y1ctlgzpdTh8XfIpewMqEaS1w3ccrbs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639729558;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XxxpL0p0xyL2pBIRJ0Qc+eFQr+N+FdeGVg1so8dvCrw=;
 b=d0bfORnpJZdljDdU7NqjtCs0uYf3avJ5Py02j4QgFVsxq1aEw2KKst1az9OnIyUaq67LbN
 MpCJuE8EGdVep5Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4E82813C72;
 Fri, 17 Dec 2021 08:25:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id vTs7EZZJvGEPcwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 17 Dec 2021 08:25:58 +0000
Date: Fri, 17 Dec 2021 09:25:56 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YbxJlGOa59feuZH1@pevik>
References: <CAEemH2d+-rqscLPdn8q0AEkKaCSkCZ-pET_E=eWWN7Z=aB1k0w@mail.gmail.com>
 <20211216034125.255907-1-liwang@redhat.com>
 <YbrvolVYj7io6rOm@pevik>
 <CAEemH2fpXYOADGY9PvcrfnXoGWrEjy+Lv6W2LxJGX--jN+u7LA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fpXYOADGY9PvcrfnXoGWrEjy+Lv6W2LxJGX--jN+u7LA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] lib: add functions to adjust oom score
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

> > BTW deliberately not documenting it as it should not be commonly

> Yes, actually it's not a commendatory API to users, and I think
> we do really avoid using it unless we have no better choice.
> (at least for OOM tests I can tell this)
> The main reason we use it is current kernel OOM is not very
> perfect, we just use it to help get the completed log for LTP.

Understand, thx for info.


> > used in tests? Also although oom_score_adj inheritance should be known to
> > person who will want to add it somewhere, I'd move it from commit message
> > to
> > source code (into header docs or or C API doc).

> Sounds reasonable, will add this in V2.

Thx!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
