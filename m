Return-Path: <SRS0=jFKu=PB=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD70AC433EF
	for <ltp@archiver.kernel.org>; Wed, 13 Oct 2021 11:33:57 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6B7A60EE9
	for <ltp@archiver.kernel.org>; Wed, 13 Oct 2021 11:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B6B7A60EE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6CAC33C104E
	for <ltp@archiver.kernel.org>; Wed, 13 Oct 2021 13:33:54 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CBA213C01FA
 for <ltp@lists.linux.it>; Wed, 13 Oct 2021 13:33:45 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 49B4E6010F8
 for <ltp@lists.linux.it>; Wed, 13 Oct 2021 13:33:44 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 6FB2C2011C;
 Wed, 13 Oct 2021 11:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1634124824;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wQKE6qEzzg+VZji60/JV/UVAIjyYI3jAf9YNu6xtygE=;
 b=vYdVBqu9XfWp1nwvJWjt795xJCA+YPmL7nuxtuRgzgdPYZF05dYVVGAjcJN+1eq5sVoiLI
 3S3bvlXQIs4KFL954+37JaXCmhdx9AEJ9erye4TzmojdGlYN1bfSwAcpLb+HhzEW1cYmBQ
 f26fFUrl7wVlkDqVs2ATCA4hZsVWRIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1634124824;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wQKE6qEzzg+VZji60/JV/UVAIjyYI3jAf9YNu6xtygE=;
 b=fPP4RKlRd094AGYoTFZyhBVHWbU02UfMfn6sZvo9zEVz+jusTLUpCWtH0P4rhaxl6c4RZa
 UF0Wzj9noZ7uwfAQ==
Received: from g78 (unknown [10.163.24.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 38C23A3B9D;
 Wed, 13 Oct 2021 11:33:44 +0000 (UTC)
References: <20211012092858.29992-1-rpalethorpe@suse.com>
 <YWavuzI2JrJXLDtO@yuki>
User-agent: mu4e 1.6.5; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 13 Oct 2021 12:32:59 +0100
In-reply-to: <YWavuzI2JrJXLDtO@yuki>
Message-ID: <877deh9n1n.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] msgrcv02: Add negative msgtyp tests
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


Hello,

Thanks, pushed with line removed!

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
