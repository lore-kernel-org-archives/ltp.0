Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A52C07E9D
	for <ltp@archiver.kernel.org>; Mon, 26 Sep 2022 07:48:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4054C3CADE2
	for <ltp@archiver.kernel.org>; Mon, 26 Sep 2022 09:48:20 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2E7B23CACD6
 for <ltp@lists.linux.it>; Mon, 26 Sep 2022 09:48:09 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5B8021A0090D
 for <ltp@lists.linux.it>; Mon, 26 Sep 2022 09:48:08 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B4AC321BEC;
 Mon, 26 Sep 2022 07:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1664178487;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hhHnkS0erxtG3NfajEqq89TZNLsRmB12GWGb49ostJk=;
 b=QE5I/vDeBGd6kjpOdm8sMWh15pe6hCWgYaCozD3Ip+oRfDPc+P8ehOI6i9EbOAubsqBZBm
 5BdJB+uOvoYnAoclQ4OIiiUtEPU4PeJKpbzfN7hTeZYJBQm5OjKpyyZWnnl4y606PImOBJ
 CBvzYeIZWAk+dgXtvfvTM9EyCoPJAtU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1664178487;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hhHnkS0erxtG3NfajEqq89TZNLsRmB12GWGb49ostJk=;
 b=JwscpWv7USVqdV454nfhyPImpQD3RBJKQhGX8enpqmaGbKH9GshzpOLZLZYgSLCZqHLGqI
 qxGeq53OM20hAnBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 873A0139BD;
 Mon, 26 Sep 2022 07:48:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KCffHjdZMWMhQwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 26 Sep 2022 07:48:07 +0000
Date: Mon, 26 Sep 2022 09:48:05 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>, ltp@lists.linux.it
Message-ID: <YzFZNTMeKy9FaYLt@pevik>
References: <20220921155006.13360-1-mdoucha@suse.cz> <Yy2DsPHqapfu649o@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yy2DsPHqapfu649o@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_supported_fs: Implement checking paths
 against skiplist
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

merged this one with 2 tiny fixes (sort getopts string, remove blank line).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
