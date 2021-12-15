Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0550C433EF
	for <ltp@archiver.kernel.org>; Wed, 15 Dec 2021 09:29:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 410D33C8E7E
	for <ltp@archiver.kernel.org>; Wed, 15 Dec 2021 10:29:24 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C12D3C8D38
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 10:29:14 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 294622011DC
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 10:29:13 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4A8C021124;
 Wed, 15 Dec 2021 09:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639560553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sSkk5ZwsufVEVOCnLFHHjLmeP89SGy8dlUnQlmjxvJQ=;
 b=ceWKT3X5qvXZP9Nkb04FbVGp5MgjEEcDXc0u+hWTpwf0PgQEL0Z623DpMmGiMmtvimYlxg
 Dhjdu9qrysLMqVuRxCT51QSMYBouEBQsDSeNaAAaY+k/DP18EQxjem8tyP6xZkRa+/VvV9
 qCktGRKXU/+CT7rM9tWHZzQka5s4d74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639560553;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sSkk5ZwsufVEVOCnLFHHjLmeP89SGy8dlUnQlmjxvJQ=;
 b=6XVDDhdqN+9OMLlSsTFQrn8n9g9kJ4RWax1YvFWx4Zs473ND9mYdKkVtBd5riIhriByj9w
 hJ5wM8V31ev8u0Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 33B6213B09;
 Wed, 15 Dec 2021 09:29:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XRVPC2m1uWGjUwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 15 Dec 2021 09:29:13 +0000
Date: Wed, 15 Dec 2021 10:30:38 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Ybm1vgG1OfmTjzzO@yuki>
References: <20211214144309.6704-1-pvorel@suse.cz>
 <20211214144309.6704-4-pvorel@suse.cz> <YbjAOffrWpsMvinQ@yuki>
 <YbjKV7yUJS+njaCY@pevik>
 <CAEemH2eXMWXt5GeY8EXaoPbS66-fju71iY+hJERNKMip+DqxLA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2eXMWXt5GeY8EXaoPbS66-fju71iY+hJERNKMip+DqxLA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] lib: Add support for debugging
 .all_filesystems
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Hmm, I think it also makes sense to people who care about the
> only one filesystem on their product. So this should _NOT_ be limit
> for test/debug, because it can help to reduce testing time for specific
> requirements.

With that line of reasoning it should be just called LTP_FS_TYPES and
user should be able to specify a list...

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
