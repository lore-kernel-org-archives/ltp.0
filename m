Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7640FC433EF
	for <ltp@archiver.kernel.org>; Wed, 23 Mar 2022 19:13:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E9DD3C9711
	for <ltp@archiver.kernel.org>; Wed, 23 Mar 2022 20:13:31 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 581B33C94CC
 for <ltp@lists.linux.it>; Wed, 23 Mar 2022 20:13:20 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 676A81000DD8
 for <ltp@lists.linux.it>; Wed, 23 Mar 2022 20:13:19 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9FAC3210F6;
 Wed, 23 Mar 2022 19:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1648062798;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qy5rovrWeH5MKY2iGwrGdNPImDXcDkEinEYbDk9EM7Q=;
 b=oyE8VPCDrif3uIhyiQGPitnXU1UAMzNvT0mTwibCnsvRad+qDLY6qeLjEEqMYAbKffEu7r
 lps2XiY0nxMnR8cahAmaCfyMOtRsgO4S7n3y3YAHluUKurdzq12CVYHRsPQO6+3N351IMi
 rtQ8C9r6GVAegLjCnmQTknA7MR/K1JU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1648062798;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qy5rovrWeH5MKY2iGwrGdNPImDXcDkEinEYbDk9EM7Q=;
 b=8cCIkESw0OyslUBBinNy4d6MdtwhxwU9qzF2BLt3sgGkbM0Y3/HbDcCbvS0vBfIenzIRen
 B6WoT0+b7h0eoxAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6ABF413302;
 Wed, 23 Mar 2022 19:13:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9dkTGE5xO2JuSgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 23 Mar 2022 19:13:18 +0000
Date: Wed, 23 Mar 2022 20:13:16 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yael Tzur <yaelt@google.com>, linux-integrity@vger.kernel.org,
 ltp@lists.linux.it, Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YjtxTJX91bwftEne@pevik>
References: <20220223200731.1859670-1-yaelt@google.com> <Yh+S7JD2q8oalRoM@yuki>
 <YiBcyvtqTX1CerM4@pevik> <YiC4Pj1sH8UIHY7k@yuki>
 <YiDB7wO3Se/vN15+@pevik> <YiDGvzETiI/nxwW/@yuki>
 <YiDLn3GMNFu482XG@pevik>
 <CAKoutNsc-JWQd1MOTFk7Hd_MgsFKj=6qi=uusKez2HgatTNCdQ@mail.gmail.com>
 <YjOcRn1qx0LHlO/j@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YjOcRn1qx0LHlO/j@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] syscalls/keyctl09: test encrypted keys with
 provided decrypted data.
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

Hi all,

> > Hi Petr and Cyril,

> > I wanted to check whether there is pending action left on my end?
> @Yael nothing needed from you.

> @Cyril cd3bc044af48 ("KEYS: encrypted: Instantiate key with user-provided
> decrypted data") is in Mimi Zohar's git tree and in next tree, going to be
> merged in next merge window. Can we merge it now as is?

@Cyril cd3bc044af48 is in the next tree. Are we going to wait till it reaches
Linus' tree (in 5.18-rc1) or can I merge it now?
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20220323&id=cd3bc044af483422cc81a93f23c78c20c978b17c

Kind regards,
Petr

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
