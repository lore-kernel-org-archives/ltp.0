Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50719C433FE
	for <ltp@archiver.kernel.org>; Tue,  1 Nov 2022 10:55:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 11B9E3CAC43
	for <ltp@archiver.kernel.org>; Tue,  1 Nov 2022 11:55:47 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E7B5A3CAC33
 for <ltp@lists.linux.it>; Tue,  1 Nov 2022 11:55:35 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0BF13200062
 for <ltp@lists.linux.it>; Tue,  1 Nov 2022 11:55:34 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 7640033883;
 Tue,  1 Nov 2022 10:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1667300134;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HpQGg/05pC5Fv85vka1yzWlaS6bAe0TBXtAgrXsv3/8=;
 b=xml5KmKMzJVY9yhmRKg+GyC63halZ6dc/PsS+/mWMp9OfcQCNdIeidEgJ8RwEA5v+RNsdf
 UG8hMip4gLi5z0yJ8+TqUqNFTMXFCD6OZjqcfhfjTMjmGJf0z04G4L7LXfvW6hZIIth/0F
 DJj1l7J+tCPjICRZXXDAlWJhSQr8pYE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1667300134;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HpQGg/05pC5Fv85vka1yzWlaS6bAe0TBXtAgrXsv3/8=;
 b=iLnqeqIIUKy9LZo86vPNFTGJxSqTgtWdZerbeZldMo5lVgfrIx/iU2oB+5SHFY40KU/OO8
 MDJpqruo+9dGG9DA==
Received: from UNKNOWN (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id E88652C141;
 Tue,  1 Nov 2022 10:55:33 +0000 (UTC)
References: <20220808141632.10056-1-andrea.cervesato@suse.com>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Date: Tue, 01 Nov 2022 10:54:57 +0000
Organization: Linux Private Site
In-reply-to: <20220808141632.10056-1-andrea.cervesato@suse.com>
Message-ID: <878rkv9c63.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Refactor pidns17 test using new LTP API
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

hello,

> +	if (counter != CHILDREN_NUM) {
> +		tst_res(TFAIL, "%d children didn't end", CHILDREN_NUM - counter);
> +		return 1;
>  	}

Forgot to add, this is another place with can use TST_EXP_EQ

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
