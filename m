Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C6EC433F5
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 06:30:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D9F7E3CAE46
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 08:30:28 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D9B223C3030
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 08:30:18 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id ED6D6600674
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 08:30:17 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4B6E821993;
 Mon, 10 Oct 2022 06:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1665383417;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MS22a8ax6knb4SBTNMiYgFU/CmW2bF3Ojcm98QMr85Y=;
 b=tlXjQywUfrPIuAItCTbcMw/tZxor2RUrM0gw99RIzxt+PRM5iHZirJp+q8y/umoTuGBupZ
 1TMv+HoBbwJOfP3X5ZwknisP7kSLWGQNwsIe5gYoGgimCbDfDySmDGPB9iq27CJeuPCmp5
 lssn8hwyK0h0vlv3BIPU/88BpjeOULM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1665383417;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MS22a8ax6knb4SBTNMiYgFU/CmW2bF3Ojcm98QMr85Y=;
 b=putKYyB8ICpWDjLpDYyHW+V84txnlv949c8MFZqvr5RozzcnoqbomDB46R7WScLr9f0IY2
 OXQiWpHTA0UKyeBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1285113479;
 Mon, 10 Oct 2022 06:30:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id chStAvm7Q2OhPQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 10 Oct 2022 06:30:17 +0000
Date: Mon, 10 Oct 2022 08:30:15 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Y0O794kEPlcUnp85@pevik>
References: <YyI/KU10+zSi7Fpj@pevik>
 <20220915074900.2639623-1-liwang@redhat.com>
 <12066736.O9o76ZdvQC@localhost>
 <CAEemH2dbmnka=4wiib-ZiiHn+1qVNUsm4jY9f2iP5Tqan3zSOQ@mail.gmail.com>
 <CAEemH2cUDVZKR1EefJ=CKdsKk48qKWahLXPREvo23-KX_d34kw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2cUDVZKR1EefJ=CKdsKk48qKWahLXPREvo23-KX_d34kw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] getitimer03.c: convert to new LTP API
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

Hi Avinesh, Li,

FYI missing space in docparse before list causes list not being formatted.
I fixed it in fa9a4c29e ("getitimer02: Fix docparse format").

Kind regards,
Petr

+++ testcases/kernel/syscalls/getitimer/getitimer02.c
@@ -9,6 +9,7 @@
  * [Description]
  *
  * Check that getitimer() call fails:
+ *
  * 1. EFAULT with invalid itimerval pointer
  * 2. EINVAL when called with an invalid first argument
  */


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
