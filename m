Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF1C0C76195
	for <ltp@archiver.kernel.org>; Mon, 27 Mar 2023 09:37:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4268A3CCEB2
	for <ltp@archiver.kernel.org>; Mon, 27 Mar 2023 11:37:04 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C139F3CA4EA
 for <ltp@lists.linux.it>; Mon, 27 Mar 2023 11:36:54 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D393B1A006FE
 for <ltp@lists.linux.it>; Mon, 27 Mar 2023 11:36:53 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E9C9521CC9;
 Mon, 27 Mar 2023 09:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1679909812;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZUlTGc0ltSVXG9B7SZFLBvgEy38kW8YpWd/unUoLo3c=;
 b=Ht9s9ng0qaWx67bfWq4YZ23/RhNepm+HTQ8xKtxffpeiALkZ1DQLhqWZrIiRQrcpBd5HVm
 ojIr8dnmXaGXQrmqEm1jIs9okW2TYayvJtg1SU7eE4uoF09+bZTeVGzNCbQMH/Hd7vataj
 YoqmUaRzuG13DIKuDQbU3KxprhDG4c4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1679909812;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZUlTGc0ltSVXG9B7SZFLBvgEy38kW8YpWd/unUoLo3c=;
 b=W6t2Jok77q+UE60KfHt0xRgbpWGpx0TFbn0BdwVeLsTciihDkrP9NXPd/DJ8Ch/Qz5nPgn
 EwvBJS9ERHoMypBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B3DD813482;
 Mon, 27 Mar 2023 09:36:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4nUzKbRjIWTUaQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 27 Mar 2023 09:36:52 +0000
Date: Mon, 27 Mar 2023 11:36:51 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Edward Liaw <edliaw@google.com>
Message-ID: <20230327093651.GD647372@pevik>
References: <20230324002441.987778-1-edliaw@google.com>
 <20230324002441.987778-5-edliaw@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230324002441.987778-5-edliaw@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 4/4] tst_find_backing_dev: Also check
 /dev/block/ for backing device
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
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Edward,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
> -		if (dev_name[0])
> -			sprintf(dev, "/dev/%s", dev_name);
> +		if (!dev_name[0] || set_dev_path(dev_name, dev, dev_len) != 0)
> +			tst_brkm(TBROK, NULL, "Could not stat backing device %s", dev);
nit: I'd use !set_dev_path()
if (!dev_name[0] || set_dev_path(dev_name, dev, dev_len))
(can be changed be before merge).

Kind regards,
Petr

> +
>  	} else {
>  		tst_brkm(TBROK, NULL, "uevent file (%s) access failed", uevent_path);
>  	}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
