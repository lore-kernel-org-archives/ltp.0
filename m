Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F644EB64DD
	for <ltp@archiver.kernel.org>; Thu, 13 Jul 2023 08:04:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C6713CB697
	for <ltp@archiver.kernel.org>; Thu, 13 Jul 2023 10:04:31 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0779B3C036A
 for <ltp@lists.linux.it>; Thu, 13 Jul 2023 10:04:20 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 059F8200055
 for <ltp@lists.linux.it>; Thu, 13 Jul 2023 10:04:19 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A80AB1F855;
 Thu, 13 Jul 2023 08:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689235458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RT2T8V03vJjmsqvjvSuyyRfh4tJOyxWfAEycohOsXkU=;
 b=w1rOR7Nc0C+vnrOcj27yYpzMmYPWYXl3gYbhihhXmCaF/57jACfzIATcRHnBlvkxC3a9LM
 DRW+vHJDoyggp4XdKWLVzbSTlU0jKc6o+WMWSTBSN5+0JCTM4b4JIR6UEGmPK5dXp2n2QS
 YVMbJTPxftmx5A8DF30/1Z5HDzG7hZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689235458;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RT2T8V03vJjmsqvjvSuyyRfh4tJOyxWfAEycohOsXkU=;
 b=g8LDC5KGbRQDtMXjWpNbgKr43Gr3O4OD8nl6qyiEy8PnquLPKNjqNx2SbQ6h9GmhzakpLl
 lsfGw+OZUecoFPAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 960A3133D6;
 Thu, 13 Jul 2023 08:04:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kqS+IwKwr2SqIQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 13 Jul 2023 08:04:18 +0000
Date: Thu, 13 Jul 2023 10:05:23 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Message-ID: <ZK-wQ5cj39LnTPp9@yuki>
References: <20230711170335.13142-1-rick.p.edgecombe@intel.com>
 <20230712080936.GA756025@pevik>
 <504874fbc8cac972153d6592815c90af14b7a618.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <504874fbc8cac972153d6592815c90af14b7a618.camel@intel.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] security/stack_clash: Add test for mmap()
 minding gap
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>,
 "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > > ++++++++++++++++++++++++++++++++++++-
> > > =A0 1 file changed, 80 insertions(+), 1 deletion(-)
> > =

> > nit: You might want to add your copyright.
> =

> What do you mean? It's not a new file..

Probably just to add "Copyright (c) 2023 your name" to the top of the C file

-- =

Cyril Hrubis
chrubis@suse.cz

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
