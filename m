Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BFB3C77B73
	for <ltp@archiver.kernel.org>; Tue,  2 May 2023 14:32:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D7CB53CB8EA
	for <ltp@archiver.kernel.org>; Tue,  2 May 2023 16:32:05 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 480F33C288D
 for <ltp@lists.linux.it>; Tue,  2 May 2023 16:31:56 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A538E1400069
 for <ltp@lists.linux.it>; Tue,  2 May 2023 16:31:55 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D5CD721DB6;
 Tue,  2 May 2023 14:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1683037914;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZrMZF2WJRLM5IM92aEI8+E6p6CMvabxhYw7QwvuOFR8=;
 b=iakxnvgZj5EkXiJkotTQxR/k0E+Kej5J8CUDcKhhnjZSKCA4oye/W6JzasrdFQtZGE46JS
 Gcam1j4hJNot7Byfom+7uudYON11muFhqjI4u1jaORjgyjjoCpgkCSNDXh/IWF6AWeQe6C
 lT9hc40q0mebvadl5BCsgXDxSHbIusE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1683037914;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZrMZF2WJRLM5IM92aEI8+E6p6CMvabxhYw7QwvuOFR8=;
 b=b5KlUdk6RGwKX1pHlUeiEGtIssFtDB0CmdIc9hVjStQP2qy4oTiUCBW8yROKX2U3RV/SSW
 ATpkCYSJo3Wo5KAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8616F139C3;
 Tue,  2 May 2023 14:31:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id I1vTHdoeUWR7AgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 02 May 2023 14:31:54 +0000
Date: Tue, 2 May 2023 16:32:07 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20230502143207.GE3666374@pevik>
References: <20230421145746.5704-1-mdoucha@suse.cz>
 <20230421145746.5704-5-mdoucha@suse.cz>
 <422cfce1-3ca7-3aca-ee98-ebfe96e60bec@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <422cfce1-3ca7-3aca-ee98-ebfe96e60bec@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/5] Add test for CVE 2021-3653
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

Hi Martin,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Sorry, I forgot to update .gitignore and add the test to the KVM runfile.
> I'll send a v2 for the last patch either when the first four patches get
> merged or together with any other fixes.
+1, please anybody who merges this don't forget to add 2 two changes.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
