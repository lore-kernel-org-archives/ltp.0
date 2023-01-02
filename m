Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A63EFC4167B
	for <ltp@archiver.kernel.org>; Mon,  2 Jan 2023 08:41:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9FB1C3CB6DF
	for <ltp@archiver.kernel.org>; Mon,  2 Jan 2023 09:41:34 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2528E3C5AEA
 for <ltp@lists.linux.it>; Mon,  2 Jan 2023 09:41:26 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A75C014004F9
 for <ltp@lists.linux.it>; Mon,  2 Jan 2023 09:41:25 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 847F320897;
 Mon,  2 Jan 2023 08:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1672648884;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y+MQts2LeV2bkAHBQtVziK5mmoPz4yzzwQThe0Mq7sA=;
 b=1RkK7EHv0pKkHxQ2egnRNF/aA/nEA02wezjpC27jpZBJ6qp9qaZiB7URFYj6ZoJHt3Ie0w
 t9e3P4C+cuZcAEIA2YwLV1o6qA3cCE68+2rknMCZu+gS1SUjHCZCVw8AAyCqt+It2OVZW6
 uXn9d5w9wtdhxij+u+SPI4I2mW3/HUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1672648884;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y+MQts2LeV2bkAHBQtVziK5mmoPz4yzzwQThe0Mq7sA=;
 b=1h3cndAokMMK0vDWtd9UKJNtaOUmWthx4vQQ7ljwzt9ZzBmNuYlr/86SdCTs2BlKTAXdYB
 w9xu8d5cHejn9lCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5FC6913427;
 Mon,  2 Jan 2023 08:41:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id egXoFbSYsmM5KQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 02 Jan 2023 08:41:24 +0000
Date: Mon, 2 Jan 2023 09:41:22 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Y7KYsmc/ymdrbcb+@pevik>
References: <CAEemH2ceBni8N00EhZfqwZk_4mZch7ONMcL1oMKuVH-QtNmU_Q@mail.gmail.com>
 <20221230032102.2748123-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221230032102.2748123-1-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] set_mempolicy01: adjust the maximum runtime
 base on nodes
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

Hi Li,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

LGTM, really better than unlimited time.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
