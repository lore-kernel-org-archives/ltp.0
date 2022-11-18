Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52BE4C4332F
	for <ltp@archiver.kernel.org>; Fri, 18 Nov 2022 14:47:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 92A4B3CCEBC
	for <ltp@archiver.kernel.org>; Fri, 18 Nov 2022 15:47:00 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A83C3CCE39
 for <ltp@lists.linux.it>; Fri, 18 Nov 2022 15:46:51 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 64C9A2230FE
 for <ltp@lists.linux.it>; Fri, 18 Nov 2022 15:46:50 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4B6BB1FB03;
 Fri, 18 Nov 2022 14:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1668782810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6GH5P+tSj/cHmxDq9dzo2vf7tabxEea8hjOsf6PtxMM=;
 b=KCYv2CQGxQXq008nutDNC5dsEAyZhaI7CJjD6DszaXY94TrQsgv3SV4Jvl/a+inf5ofQWc
 5mAPpYL6DXHzwzouf0AUdd0N7LHnTE7KQPr4HKHLPPaxB3oj759RQNJHKE/hBh5CDSfOuf
 HlTnDA63eM+FkVulcC3XzOPa11GXNu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1668782810;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6GH5P+tSj/cHmxDq9dzo2vf7tabxEea8hjOsf6PtxMM=;
 b=5hT9iLGbp56BpDeY5EXEQ2T4cjPUGLzao0Bz4zKxxfKfiME5empDoeLm3EX21Pi05RzZdW
 Gndm1BkVdGSyY8Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 391351345B;
 Fri, 18 Nov 2022 14:46:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id fl2KDNqad2MgUwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 18 Nov 2022 14:46:50 +0000
Date: Fri, 18 Nov 2022 15:48:13 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Tarun Sahu <tsahu@linux.ibm.com>
Message-ID: <Y3ebLYv5EzkOV/cZ@yuki>
References: <20221116112516.261535-1-tsahu@linux.ibm.com>
 <20221116112516.261535-3-tsahu@linux.ibm.com>
 <Y3UDxqM8qvnqRfeT@yuki> <20221116162630.fhjoksvrdel5rlzs@tarunpc>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221116162630.fhjoksvrdel5rlzs@tarunpc>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/7] Hugetlb: Migrating libhugetlbfs counters
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
Cc: sbhat@linux.ibm.com, aneesh.kumar@linux.ibm.com, geetika@linux.ibm.com,
 vaibhav@linux.ibm.com, ltp@lists.linux.it, mike.kravetz@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > > +static long hpage_size;
> > > +
> > > +	if (t != et) {
> > > +		tst_res(TFAIL, "At Line %i:While %s: Bad "MEMINFO_HPAGE_TOTAL
> > > +				" expected %li, actual %li", line, desc, et, t);
> > 
> > We do have tst_res_() that can be called as:
> > 
> > 	tst_res_(__FILE__, line,
> >                  "%s bad " MEMINFO_HPAGE_TOTAL " = %li expected %li",
> > 		 desc, et, t);
> Ok. Will update it.
> > 
> > > +out:
> > > +	return verify_counters(line, desc, et, ef, er, es);
> > > +}
> > > +#define set_nr_hugepages(c, d) CHECK_(set_nr_hugepages_(c, d, __LINE__))
> > 
> > The macro name should be uppercase so that it's clear that it's a macro
> > and not a simple function. With that we can also drop the underscore
> > from the actual function name too.
> > 
> I avoided it deliberately knowing that these macros are being called too
> often, keeping them in uppercase would have made the code look too messy.
> Then, I looked that there was tst_res and similiar macros too which were
> kept in smallcase too (which is wrapper to tst_res_ function), That is why
> I kept them smallcase.

The whole point why we are going in circles around how to structure this
piece of code is code readibility. Source code is more often read than
written, which means that it's more important to invest into writing
code that is easily understandable since that will save effort in the
long term. That is true especially for kernel tests, where there is
enough complexity in the kernel itself and writing tests that are not
easy to understand does actually harm.

There is a key difference between tst_res() defined to tst_res_() that
adds a few parameters and macros that change the codeflow. If there are
macros that change code flow, and perhaps checkpatch is right here that
it's wiser to avoid them at all, they should at least scream in upper
case letters that this is not a regular function.

This all boils down to a principle of a least surprise.

Perhaps the best solution would be to get back to a drawing board and
figure out how to better structure the test so that the code flow is
easier to follow.

> > Maybe it would be a bit nicer to have actually two different macros so
> > that we don't have to resort to this do {} while (0) trickery e.g.
> > 
> > #define CHECK_BREAK(cond) if (cond) break;
> > #define CHECK_RETURN(cond) if (cond) return -1;
> > 
> > #define MAP_BREAK(s, h, f, d) CHECK_BREAK(map(s, h, f, d, __LINE__))
> > #define MAP_RETURN(s, h, f, d) CHECK_RETURN(map(s, h, f, d, __LINE__))
> > 
> > Then the check counters would look much better.
> > 
> > Or we can just stick to the RETURN variants and put the body of the loop
> > in the runtest() function into do_interation() function.
> > 
> I like the second idea, as it will only have one macro. which will keep the
> code less messy. But anyway, I had tried this already, if (cond) return; is
> not allowed. "make check" throws warning saying, "Macros with flow control
> statements should be avoided". Only way I could see is to use break.

Again, let's not work around the tooling we have, the tooling is
supposed to help, once you start bending the code so that the tooling is
happy you are on a wrong path.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
