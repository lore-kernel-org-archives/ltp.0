Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F621C46467
	for <ltp@archiver.kernel.org>; Thu, 19 Jan 2023 14:39:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C4A503CD84E
	for <ltp@archiver.kernel.org>; Thu, 19 Jan 2023 15:39:49 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D10383CB45F
 for <ltp@lists.linux.it>; Thu, 19 Jan 2023 15:39:39 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5C1D31A01184
 for <ltp@lists.linux.it>; Thu, 19 Jan 2023 15:39:38 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7D4235C10B;
 Thu, 19 Jan 2023 14:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1674139178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U8qmIpM3JoykYcICZFsVRwkFc8Pyyy8zMwhL0KFYYkk=;
 b=HP/AWhusQ87nJnR7XR48K4qLeXD8aoJ+rVcBjPzQuKIR093m7WAZ6UdrLjjI6CgPGMzaBf
 LNQ5bItHTwiMWhPZ6XCmwH38weM4Q/RrupZ8MSwHf4XkOF827t4X6Aynik71Pxuj14cVnm
 avBZUeCUYb3Bj+GjdsY8AMPd9EOs4Gk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1674139178;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U8qmIpM3JoykYcICZFsVRwkFc8Pyyy8zMwhL0KFYYkk=;
 b=EvmImDAopEUAGoEXCnYOPlKfDq4J3y3/hdxsjxC/wTehyu65G7rbFQbkXdj13Xv8h1pYBw
 IYR5AZdffpvlHYCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 46ECF139ED;
 Thu, 19 Jan 2023 14:39:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id IKReDipWyWO/LAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 19 Jan 2023 14:39:38 +0000
Date: Thu, 19 Jan 2023 15:41:13 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Y8lWibGsvl1DzkXB@yuki>
References: <20230118133643.11371-1-chrubis@suse.cz>
 <37ee8021-c13b-c4a9-f27b-84f504800169@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <37ee8021-c13b-c4a9-f27b-84f504800169@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/statvfs01: Correcly zero terminate the
 strings
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> >   	memset(valid_fname, 'a', valid_len);
> >   	memset(toolong_fname, 'b', valid_len + 1);
> >   
> > +	valid_fname[valid_len] = 0;
> > +	toolong_fname[valid_len+1] = 0;
> 
> Is there a possibility that valid_len could be equal to PATH_MAX-1?

I do not think so, POSIX explicitly says that PATH_MAX should include
space for terminating null character.

Btw there is NAME_MAX constant that is defined to 256 which is the
usuall maximal lenght + 1.

> I  think toolong_fname[] size should be bumped to at least PATH_MAX+1.

Well we can do that (in a separate patch) to be extra sure, but even
then the PATH_MAX seems to be at least order of magnitude larger than
NAME_MAX.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
