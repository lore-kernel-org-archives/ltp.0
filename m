Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47881C433EF
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 14:50:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5276F3C9536
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 15:50:29 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 51F663C94F9
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 15:50:19 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5E6781A01495
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 15:50:18 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8CD881F3D4;
 Fri, 14 Jan 2022 14:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642171818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jgs84D36bqjdfjqUMTcQOKebiYFzVPyqVYQxGaW9xHg=;
 b=rrMMmkhULeKxRbpdba7rFsqpMmGutvOuBFjjQAOJYfvZRM2ae+rt5zFFSRI8P9oUfGpSLD
 ABzLDFhg2QnqsOJA57PVaxfn7PtG1+9enypI4uOtP1kQ9ujZc9Qv68qTbUpBd3fFbGH9u3
 FxRRgPZKDbl5LPQTjIkL3QJA7Vvfb5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642171818;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jgs84D36bqjdfjqUMTcQOKebiYFzVPyqVYQxGaW9xHg=;
 b=JMOCI3kNZDiFU4hX06yIohDBi0yfp2c3y2rg+SDeQWFqkedIpzRN04mJOnO/yeJrno2t4s
 xF/mFLcyYEViNSBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 77D0813C27;
 Fri, 14 Jan 2022 14:50:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id pLYPHKqN4WG7PQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 14 Jan 2022 14:50:18 +0000
Date: Fri, 14 Jan 2022 15:51:57 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Joerg Vehlow <lkml@jv-coder.de>
Message-ID: <YeGODW9wG+w1rsO0@yuki>
References: <20220114125513.895-1-pvorel@suse.cz> <YeGEunEuwPvNFxyS@yuki>
 <95394feb-6474-d1ca-13d8-3d1c35e781b9@jv-coder.de>
 <YeGHV+Gnmo59SXeL@yuki>
 <f516568b-fa33-091c-3442-0316a78d96b1@jv-coder.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f516568b-fa33-091c-3442-0316a78d96b1@jv-coder.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] configure.ac: Fix summary for disabled
 metadata
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > The JSON metadata file is going to replace the runtest files some day,
> > at least that is the longterm plan. Also the parser that extracts the
> > metadata from the sources is rather fast, compared to the LTP build and
> > it's self contained. There is really no reason to have a switch to
> > disable the metadat extraction step.
> > 
> > The documentation build, on the other hand, is rather slow and requires
> > asciidoc, which is the reason why there is a switch that can be used to
> > disable that. The only problem here is that the name is a bit confusing
> > now.
> > 
> Actually there is, that is where my interest in this flag comes from. We
> don't use runtest files (at least not for execution), so we don't need
> it and we had problems in out cross build environment, that were not
> easily fixed. From looking at the source I am not sure what the problem
> was and cannot spot it from looking at the source. But I know, that it
> wasn't just fixed by setting the correct HOSTCC and HOST_CFLAGS. I have
> a missing library in my head, but I can't see any.

That is really strange, there are practically no dependencies for the
metadata extractor. All that you have to have is a C compiler and libc.

> All I know is that I gave up fixing the build and I don't give up easily
> normally (a little easier if the functionality is not needed at all) :)

You should have reported that on the list. It's going to be really
cornerstone of the way how tests are executed so the build should get
fixed anyways.

I guess that we can add a flag that disables the metadata extraction
step, with a big red warning that describes the consequencies of the
choice.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
