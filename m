Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 363B0D37E39
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 14:29:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD32A3C9C84
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 15:29:13 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9737F3C9984
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 15:28:55 +0100 (CET)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk
 [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D1FD46002FB
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 15:28:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=MDq7CnLwcVfHk/Yxuues6u7FOlIZmPjkJM3N9g6aVQw=; b=lq358vOqh9ZIA0cr9603vjg572
 cFUKi9fun0XBLnC5oQll+iEFnk/nla13/637NiGoVhV35lUHK5sVVSMyQOMrnpOUSNLlBD99s2DJv
 fRXblW1HaesVIaOVRQNchu0j4R6F5ZbiNt82N6Xz67cbzqyAs40Pdq6/EgnWlDyVi2KAkqbUju+Rw
 BQzygleAw/VBXaYVa4Svm448mCStQrmoSa/9DZM3ulToYHRYiH3LhnhKMGfUs4spJiIIcLCwSGf34
 bH0IkcPDuvTLhkuM2Xbd7PceqC14+9gS9gndcqI/KfmjiYAPcfKevgEIZ2ImZ3Jnmqh43xQKaqd4s
 SatiUeXw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat
 Linux)) id 1vg1t7-0000000HZij-2qV1; Wed, 14 Jan 2026 14:30:21 +0000
Date: Wed, 14 Jan 2026 14:30:21 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260114143021.GU3634291@ZenIV>
References: <20260113194936.GQ3634291@ZenIV>
 <DFO6AXBPYYE4.2BD108FK6ACXE@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DFO6AXBPYYE4.2BD108FK6ACXE@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lack of ENAMETOOLONG testcases for pathnames
 longer than PATH_MAX
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
Cc: linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Jan 14, 2026 at 09:35:48AM +0100, Andrea Cervesato wrote:
> Hi!
> 
> On Tue Jan 13, 2026 at 8:49 PM CET, Al Viro wrote:
> > 	There are different causes of ENAMETOOLONG.  It might come from
> > filesystem rejecting an excessively long pathname component, but there's
> > also "pathname is longer than PATH_MAX bytes, including terminating NUL"
> > and that doesn't get checked anywhere.
> >
> > 	Ran into that when a braino in kernel patch broke that logics
> > (ending up with cutoff too low) and that didn't get caught by LTP run.
> >
> > 	Patch below adds the checks to one of the tests that do deal
> > with the other source of ENAMETOOLONG; it almost certainly not the
> > right use of infrastructure, though.
> 
> The description is not well formatted, spaces at the beginning of the
> phrases should be removed.
> 
> Also, we can make it slightly more clear, by saying that error can be
> caused by a path name that is bigger than NAME_MAX, if relative, or
> bigger than PATH_MAX, if absolute (when we use '/').

Huh?  Absolute pathname is the one that _starts_ with '/'; e.g. "../include"
is relative, not absolute, despite having a '/' in it.

> In this test we only verifies if relative paths are longer than
> NAME_MAX (we give 273 bytes instead of 255 max), but we don't test if
> path name is bigger than PATH_MAX.
> 
> We should correctly distinguish these two cases inside the test with
> proper names as well. Check below..

> https://linux-test-project.readthedocs.io/en/latest/developers/api_c_tests.html#guarded-buffers-introduction
> 
> Many old tests are not using these buffers, but it's better to
> introduce them when a test is refactored or fixed, like in this case.
> 
> You need to define:
> 
> static char *long_rel_path;
> static char *long_abs_path;
> 
> ...
> 
> static void setup(void) {
> 	..
> 	// initialize long_rel_path content
> 	// initialize long_abs_path content
> }
> 
> static struct tst_test test = {
> 	..
> 	.bufs = (struct tst_buffer []) {
> 		{&long_rel_path, .size = NAME_MAX + 10},
> 		{&long_abs_path, .size = PATH_MAX + 10},
> 		{}
> 	}
> };

> > -	TST_EXP_FAIL(chdir(tcases[i].dir), tcases[i].exp_errno, "chdir()");
> > +	if (tcases[i].exp_errno)
> > +		TST_EXP_FAIL(chdir(tcases[i].dir), tcases[i].exp_errno, "chdir()");
> > +	else
> > +		TST_EXP_PASS(chdir(tcases[i].dir), "chdir()");
> 
> In this test we only verify errors, so TST_EXP_PASS is not needed.

Er...  Intent was to verify two things: that anything longer than PATH_MAX triggers
ENAMETOOLONG, but anything up to PATH_MAX does not.  Having a pathname of exactly
4095 '/' (or interleaved . and / in the same amount, etc.) be rejected with ENAMETOOLONG
is just as much of a failure as not triggering ENAMETOOLONG on anything longer...

FWIW, I considered something like
	mkdir("subdirectory", 0700);
concatenating enough copies of "subdirectory/../" to get just under PATH_MAX and appending
"././././././././" to the end, so that truncation to PATH_MAX and to PATH_MAX-1 would
both be otherwise valid paths; decided that it's better to keep it simpler - a pile of
slashes is easier to produce and would resolve to a valid directory if not for the
total length restrictions.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
