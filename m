Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13807C433F5
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 07:32:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D6BBA3CA610
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 09:32:03 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A61A53CA26E
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 09:31:53 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AE888600D6C
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 09:31:52 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D3FF01F37F;
 Thu, 28 Apr 2022 07:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651131111;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M6rbPBit3OWmWu0onbr3qMbOHW3clJj3YDmVI44Anhw=;
 b=U7wxg1NiB7G+y5rKT86vdh/WP7+kN/WZ+hThMZ0S4ZgKOl0bsLNabFl7kV2ByLmNZKITMW
 JKbGrXeIXDj+t8T57T+UY+qfpIaqS75zCels6UEm8tVBOSBFg1piNFwyIhXj6K8nJR+ota
 GwU9pjeGIxyx8IOsuyV3Ya66dX2CC1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651131111;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M6rbPBit3OWmWu0onbr3qMbOHW3clJj3YDmVI44Anhw=;
 b=XUhP+IfhsBn5FkcpzNXlLrOeAPpWSVK6ktCC5VvxCvYRaj/bmIDBvskiKSTsFGHzFXizr+
 FjDZL4XpKm7esqDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 931FF13AF8;
 Thu, 28 Apr 2022 07:31:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id TXDsIedCamJPEQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 28 Apr 2022 07:31:51 +0000
Date: Thu, 28 Apr 2022 09:31:49 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YmpC5Q3oMdiy79o1@pevik>
References: <20220427125003.20815-1-pvorel@suse.cz>
 <20220427125003.20815-2-pvorel@suse.cz>
 <12b407ae-c5c9-8d80-9feb-3daf6d116528@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <12b407ae-c5c9-8d80-9feb-3daf6d116528@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/5] busy_poll_lib.sh: Mention setup/cleanup
 defined in tests
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

Hi all,

FYI replaced by

https://patchwork.ozlabs.org/project/ltp/patch/20220428065657.32046-1-pvorel@suse.cz/

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
