Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03933C433F5
	for <ltp@archiver.kernel.org>; Thu,  5 May 2022 09:46:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 072B43CA8D6
	for <ltp@archiver.kernel.org>; Thu,  5 May 2022 11:46:09 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 69DE23CA3BE
 for <ltp@lists.linux.it>; Thu,  5 May 2022 11:45:58 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 077CB200A1A
 for <ltp@lists.linux.it>; Thu,  5 May 2022 11:45:57 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 360CD1F892;
 Thu,  5 May 2022 09:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651743957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DmfLnOY9/EGHP94q+9QniSo62lYKSX3MPeJpJ3MyHnQ=;
 b=TMEz+wmebmDCXt/mhrBCMbZmD+YIsqiVcRm167Uu5yUv4J7uY1NG/3+9oJpVNW5JpTSFPM
 QvG8y3X7JgvTsDiIRP6HhnxNAsnr79P3Ky5fHIgPxB/TKvgaWHKusFS4E8w6x4TYJoz7sx
 hUuCUWopML14t0DK9bCAlX1K05cnrVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651743957;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DmfLnOY9/EGHP94q+9QniSo62lYKSX3MPeJpJ3MyHnQ=;
 b=+aJhLmr1e3ccT9Rp7+qgL7nS/P5UCzLiHlMvfFuEneUsVCW8dXqguCNkqf7/DHUXmhGBwF
 3ctzEt/+GdcOAqAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1582013A65;
 Thu,  5 May 2022 09:45:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kILEA9Wcc2IKMwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 05 May 2022 09:45:57 +0000
Date: Thu, 5 May 2022 11:48:13 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <YnOdXct59/QFXd1Z@yuki>
References: <20220503174718.21205-1-chrubis@suse.cz>
 <20220503174718.21205-2-chrubis@suse.cz> <87a6bwe7ps.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87a6bwe7ps.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] [PATCH v2 01/30] Introduce a concept
 of max runtime
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
Cc: ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > +	int max_iteration_runtime;
> 
> It's not immediately clear if iteration refers to the inner test loop
> (e.g. Fuzzy Sync) or the outer loop performed by adding '-i N'. Perhaps
> it would be better to call it max_runtime and document that it is scaled
> by '-i N'?

It's not only the -i N paramater, it's carthesian product of:

	-i parameter x all_filesystems x test_variants

And every single instance of that product is limited by the runtime
value, which is the reason I want to have iteration explicitly in the
name. Maybe we should call it instance instead or whatever else that may
be more fitting.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
