Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FDECC4332F
	for <ltp@archiver.kernel.org>; Thu, 10 Nov 2022 08:19:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DD3A73CD646
	for <ltp@archiver.kernel.org>; Thu, 10 Nov 2022 09:19:20 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 30FC53CD621
 for <ltp@lists.linux.it>; Thu, 10 Nov 2022 09:19:10 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 09E401A005E8
 for <ltp@lists.linux.it>; Thu, 10 Nov 2022 09:19:09 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CF1081FD18;
 Thu, 10 Nov 2022 08:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1668068348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gX0hk9l2ZvNyOpszQD3IyLlrOUN31gQcMkadG6V23rg=;
 b=tqdg6QvkMm/J+5GxwIMyPw4wuKnY5fIHY982hb8ezQq4JAG4F9T7kwvPKAwUUmtaY2n/KZ
 nmOsfJy88LjSXa++Py6uvzyUU6d/YDd8T7oEr+tWrBPHVK58TKX1Up22IglAOFK/UUrGdI
 7Kv6PznsPqA7pq/f6Do1mZSaEg8NdfQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1668068348;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gX0hk9l2ZvNyOpszQD3IyLlrOUN31gQcMkadG6V23rg=;
 b=UkhNw+ZKtLK3jBo+omsYKKCA0T45k9HntaZPkZlNMAN4HiJsVRJLZRTpK+o+jiBdV66R8p
 +wigsdR8ZIwyzqAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A94B11332F;
 Thu, 10 Nov 2022 08:19:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 53Y2J/yzbGMAPAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 10 Nov 2022 08:19:08 +0000
Date: Thu, 10 Nov 2022 09:20:39 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Tarun Sahu <tsahu@linux.ibm.com>
Message-ID: <Y2y0VzfJwFr0wiwC@yuki>
References: <20221108195207.232115-1-tsahu@linux.ibm.com>
 <20221108195207.232115-2-tsahu@linux.ibm.com>
 <Y2unWTTyFK8DS82w@yuki> <20221109212637.haxocrluexxhvktg@tarunpc>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221109212637.haxocrluexxhvktg@tarunpc>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/5] Hugetlb: Migrating libhugetlbfs counters
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
> > > +		prev_total = t;
> > > +		prev_free = f;
> > > +		prev_resv = r;
> > > +		prev_surp = s;
> > > +		return;
> > > +	}
> > > +
> > > +	tst_res(TFAIL, "Failure Line %i: Bad %s expected %li, actual %li",
> >                         ^
> > 			Never print "Fail/Pass" with tst_res() it's
> > 			printed based on the flag passed to it.
> > 
> > The output would contain Fail and Failed at the same time.
> > 
> This doesn't say failed.
> It says failure-line from which the failure originated.
> like, 
> hugemmap10.c:63: FAIL: Failure Line 321, Bad HugePages_Free: expected 5, actual 4

However that is still redundant information, right?

The meaning of "FAIL: line xyz" and "FAIL: failure line xyz" is the
same, the second one is just longer. Let's keep the messages short
and to the point.

> > I think that instead of the __LINE__ it would make more sense to pass
> > the test description as a string as we do with test_counters()
> > 
> That will require each line inside test_counters to have unique string
> description for map, touch, unmap, set_nr_hugepages calls, similiary inside
> for loop. Which will make user hard to find where they have to look for
> origin of issue, unless they search for string match.
> 
> like,
> 
> 	/* untouched, private mmap */
> 	map(SL_TEST, 1, MAP_PRIVATE, "mmap private no touch");
> 	unmap(SL_TEST, 1, MAP_PRIVATE, "unmap memory mmaped private no touched");
> 
> 	/* touched, private mmap */
> 	map(SL_TEST, 1, MAP_PRIVATE, "mmap private followed by touch");
> 	
> 	touch(SL_TEST, 1, MAP_PRIVATE, "touch memory mmaped private");
> 	unmap(SL_TEST, 1, MAP_PRIVATE, "unmap memory touched mmaped private");
> 
> But I agree, a unique description, will give more information on test run
> logs. 
> 
> What do you think?

Sounds good.

> > > +	if (setjmp(buf))
> > > +		goto cleanup;
> > 
> > This is way beyond ugly. I guess that it would be cleaner to actually
> > return a pass/fail from the test_counters() function and break the for()
> > loop based on that value instead of this longjmp trickery.
> > 
> > Also I do not think that the current code is correct anyway, because we
> > skip the unmap() call. So I suppose the correct way would be:
> > 
> > 
> > 	res = test_counters("Untouched, shared", base_nr);
> > 	unmap(SL_SETUP, 1, MAP_SHARED);
> > 
> > 	if (res)
> > 		break;
> > 
> 
> I was thinking same first. But Thought of adding the checks at each line in
> test_counters(...) and inside for loop, will make the code unclean. Hence,
> I chose the setjmp/longjmp mechanism. Only drawback is that mapping was not
> getting cleaned up (unmap), That we can add in per_iteration_cleanup.
> 
> What do you think?

The reason why I do not like the longjmp() is that it obscures the code
flow. If we have explicit if () and break; it's clear what is happening.
With setjmp() you have to search the code for corresponding longjmp()
calls. It's not that bad in this case but I would still stick to
avoiding longjmp() unless really necessary.

> > Or eventually we can make the desing better by unmaping any leftover
> > mappings in the per_iteration_cleanup(). Then we can just do:
> > 
> > 	map()
> > 	if (test_coutners(...)
> > 		break;
> > 	unmap()
> > 
> map and unmap do also require return checks, as they also perform
> verify_counter on expected and original counters.

I guess that we can also put the map() (touch()) test_counters() unamp()
sequence to a do_test() fuction then call it from the for() loop in
run_test(). That would make the code a bit cleaner.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
