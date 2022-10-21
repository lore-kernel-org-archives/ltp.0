Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 988A2C43217
	for <ltp@archiver.kernel.org>; Fri, 21 Oct 2022 09:10:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0E9323CB1AB
	for <ltp@archiver.kernel.org>; Fri, 21 Oct 2022 11:09:59 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 78E4B3CAE70
 for <ltp@lists.linux.it>; Fri, 21 Oct 2022 11:09:49 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B370D1A005FF
 for <ltp@lists.linux.it>; Fri, 21 Oct 2022 11:09:48 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A492321908;
 Fri, 21 Oct 2022 09:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1666343387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XkYZPsQH1uTaarSK0kjQIn5LYzzK9eBe7hH1vNPh4Wg=;
 b=bA+Bnac/raR1cQWpSWNODFZKYfQ1fu5cxpOmGYO/o52VSEiwe97KKPNPiAH3+sml3NOHhC
 Dm2jk77FToYltQe1+fncoFrJbRAPyIsU1CGbZkaaJUgttE2hCDcIe0LEGa1DgvPY8CmxSs
 CsBMVhdqJmu/aGPTdN1iLjtSjWv8DCo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1666343387;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XkYZPsQH1uTaarSK0kjQIn5LYzzK9eBe7hH1vNPh4Wg=;
 b=/k8THiED19FeRxXAYz/JMgUcDDrQYS7vveLVe8RpEZHgUUdbVeiqGUQFAhlnULlsC40irs
 s7lXn1fuYGzVdfDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 850411331A;
 Fri, 21 Oct 2022 09:09:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id X5e7H9thUmOnbQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 21 Oct 2022 09:09:47 +0000
Date: Fri, 21 Oct 2022 11:11:29 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Y1JiQSWlxVSkhuoq@yuki>
References: <20221020133715.256521-1-akihiko.odaki@daynix.com>
 <Y1GFvU/ixieqDSq6@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y1GFvU/ixieqDSq6@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] tst_test.sh: Normalize the locale
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
Cc: Yan Vugenfirer <yan@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> > index 28b7d12ba..5ebbe1d25 100644
> > --- a/testcases/lib/tst_test.sh
> > +++ b/testcases/lib/tst_test.sh
> > @@ -831,3 +831,5 @@ if [ -z "$TST_NO_DEFAULT_RUN" ]; then
> >  		fi
> >  	fi
> >  fi
> > +
> > +export LC_ALL=C
> 
> Thinking about it twice this might have impact on other tests.
> Li, Cyril, any idea about it?

Actually I think that we should have put this into the tst_test.sh from
the start. We do have this as a workaround in du01.sh and telnet01.sh
already.

The plus side is that all possible bugreports from users will have all
messages in english which would make debugging easier.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
