Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFBAEC55822
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 06:15:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AFC843E2810
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 08:15:29 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EFF053E196A
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 08:15:14 +0200 (CEST)
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com
 [91.218.175.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4147110009A3
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 08:15:14 +0200 (CEST)
Date: Tue, 4 Aug 2026 14:15:07 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1785824113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=muDs8vwXrwQJ22Y8h2cRsO1X31GeKpcx9LIeCBSFc/k=;
 b=sbY1HQvWHoFjhMtW+p56OzytoICceIdNRs6f4rcbLOkrXP8OZdvXbE7WgW9QQWxdODsJBO
 J9NTbNbSEqsNX3WklEL8+XVIQKCBZPPgRb/9HnGDUMykmiqUOOO56LwvgeHn/flOAnY3rj
 qFbLZ3jWks/a8oss8RgTlmyxMaPggc0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: Petr Vorel <pvorel@suse.cz>,
 Andrea Cervesato <andrea.cervesato@suse.com>, ltp@lists.linux.it,
 Cyril Hrubis <chrubis@suse.cz>, Jan Stancek <jstancek@redhat.com>
Message-ID: <anGDa2dL19wKNtf6@linux.dev>
Mail-Followup-To: Petr Vorel <pvorel@suse.cz>,
 Andrea Cervesato <andrea.cervesato@suse.com>, ltp@lists.linux.it,
 Cyril Hrubis <chrubis@suse.cz>, Jan Stancek <jstancek@redhat.com>
References: <20260731124232.GB196217@pevik>
 <6a6c98c6.3c943127.1c122.1c09@mx.google.com>
 <20260803130645.GA246496@pevik> <anF5lV_yjqn8OuVE@linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <anF5lV_yjqn8OuVE@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] Re: lib: Rename function check_kver() =>
 check_min_kver()
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Aug 04, 2026 at 01:33:09PM +0800, Li Wang wrote:
> Petr Vorel wrote:
> 
> > Hi all,
> > 
> > > > In that case we want to have both in a single commit, right?
> > > > => yet another version.
> > 
> > > Yes, I think so
> > 
> > I'm not sure what's reasonable, therefore RFC please.
> > 
> > We can for sure can have test with both flags, .min_kver < .max_kver:
> > 
> > .min_kver = "6.5"
> > .max_kver = "7.2"
> > 
> > which will be tested on kernels <6.5, 7.2> (including all their stable
> > versions). Here the code works like (using AND):
> > 
> > $(uname -r) >= .min_kver && $(uname -r) <= .max_kver
> 
> This above is no porblem.
> 
> 
> > (BTW although current version prints only the version which is not sufficient.
> > And I think it's better than print the range without specifying which version is
> > not sufficient).
> > 
> > But can we have also a variant when .min_kver > .max_kver (using OR)?
> 
> No, please don't do this :).
> 
> When I see:
> 
> 	.min_kver = "7.2",
> 	.max_kver = "6.10",
> 
> my first assumption would be that the metadata is wrong,
> not that it means:
> 
> 	kver >= 7.2 || kver <= 6.10
> 
> So this could easily hide real mistakes. If somebody accidentally
> swaps the two values, the framework would silently accept it and
> run the test on a different set of kernels instead of reporting
> an invalid range.
> 
> I think .min_kver/.max_kver should keep simple AND semantics only,
> and .min_kver > .max_kver should be rejected, or at least reported
> as broken test metadata.
> 
> If we really need to express "run on old kernels and new kernels,
> but skip a broken middle range", I think it would be better to handle
> that explicitly in the test code. That would be a bit more verbose,
> but much easier to read and review.

Or, we could achive something simply:

    .supported_kvers = {
            "<= 6.10",
            ">= 7.2",
    },

But I don't think there is currently a strong demand for this.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
