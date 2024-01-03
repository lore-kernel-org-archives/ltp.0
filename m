Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28191C3DA6E
	for <ltp@archiver.kernel.org>; Wed,  3 Jan 2024 19:20:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A74F53CE781
	for <ltp@archiver.kernel.org>; Wed,  3 Jan 2024 20:20:13 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 17BB33C8BA4
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 20:20:02 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 66EDB600FB0
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 20:20:01 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5FDF91F7C1;
 Wed,  3 Jan 2024 19:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704309601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dxkzl8UxTLvWbGW5E03ARlF6Y5GyWbT866AfkUtid44=;
 b=ZyaHNxb5W2rqWoJ1b+tJVoTDIgbwUvk8Zt/wN0yVnrBAqqQYq7OQ/lOaTHJBx/yjfoh2MF
 JSi8AYmCWgE+8d4neXtR96xbZfyoSk3tTmm+zieLdTgS7tmW5UYU/VCnNk2jN+2WNqdU9M
 g1W+M2r/Wo45GJ3HtJr2vL7/6hByNrg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704309601;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dxkzl8UxTLvWbGW5E03ARlF6Y5GyWbT866AfkUtid44=;
 b=j+zlzlhmMeO+sDITjhiVijCuHezJxijsJaPSpHYWaTuOxIr5Ho9rWhUS0nRHc+MzUJ7rRf
 OFWGDMpZY2dGv6BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704309601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dxkzl8UxTLvWbGW5E03ARlF6Y5GyWbT866AfkUtid44=;
 b=ZyaHNxb5W2rqWoJ1b+tJVoTDIgbwUvk8Zt/wN0yVnrBAqqQYq7OQ/lOaTHJBx/yjfoh2MF
 JSi8AYmCWgE+8d4neXtR96xbZfyoSk3tTmm+zieLdTgS7tmW5UYU/VCnNk2jN+2WNqdU9M
 g1W+M2r/Wo45GJ3HtJr2vL7/6hByNrg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704309601;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dxkzl8UxTLvWbGW5E03ARlF6Y5GyWbT866AfkUtid44=;
 b=j+zlzlhmMeO+sDITjhiVijCuHezJxijsJaPSpHYWaTuOxIr5Ho9rWhUS0nRHc+MzUJ7rRf
 OFWGDMpZY2dGv6BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 43F3A1398A;
 Wed,  3 Jan 2024 19:20:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZBjWD2GzlWW2GAAAD6G6ig
 (envelope-from <akumar@suse.de>); Wed, 03 Jan 2024 19:20:01 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Wed, 03 Jan 2024 20:20:00 +0100
Message-ID: <1713164.MvtWXe7T2W@localhost>
Organization: SUSE
In-Reply-To: <20240103125516.GF1073466@pevik>
References: <20240103112023.32355-1-akumar@suse.de>
 <20240103112536.1925-1-akumar@suse.de> <20240103125516.GF1073466@pevik>
MIME-Version: 1.0
X-Spamd-Bar: ++++
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZyaHNxb5;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=j+zlzlhm
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [4.11 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_SPAM_SHORT(2.92)[0.972];
 MIME_GOOD(-0.10)[text/plain]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_ORG_HEADER(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_TWO(0.00)[2];
 NEURAL_SPAM_LONG(3.50)[1.000]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; CTE_CASE(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 5FDF91F7C1
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] lib: Improve doc
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

Hi Petr,

Thank you for the review.

On Wednesday, January 3, 2024 1:55:16 PM CET Petr Vorel wrote:
> Hi Avinesh,
> 
> > Signed-off-by: Avinesh Kumar <akumar@suse.de>
> > ---
> > 
> >  lib/README.md | 33 ++++++++++++++++-----------------
> >  1 file changed, 16 insertions(+), 17 deletions(-)
> > 
> > diff --git a/lib/README.md b/lib/README.md
> > index ccb1cf1da..dd79e70f4 100644
> > --- a/lib/README.md
> > +++ b/lib/README.md
> > @@ -27,16 +27,16 @@
> > 
> >  When a test is executed the very first thing to happen is that we check
> >  for
> >  various test prerequisites. These are described in the tst\_test
> >  structure and> 
> > -range from simple '.require\_root' to a more complicated kernel .config
> > boolean +range from simple '.needs\_root' to a more complicated kernel
> > .config boolean
> Good catch!
> 
> >  expressions such as: "CONFIG\_X86\_INTEL\_UMIP=y | CONFIG\_X86\_UMIP=y".
> > 
> > -If all checks are passed the process carries on with setting up the test
> > +If all checks are passed, the process continues with setting up the test
> > 
> >  environment as requested in the tst\_test structure. There are many
> >  different setup steps that have been put into the test library again
> >  ranging from rather simple creation of a unique test temporary directory
> >  to a bit more complicated ones such as preparing, formatting, and
> >  mounting a block device.
> > 
> > -The test library also intializes shrared memory used for IPC at this
> > step.
> > +The test library also initializes shared memory used for IPC at this
> > step.
> > 
> >  Once all the prerequisites are checked and test environment has been
> >  prepared we can move on executing the testcase itself. The actual test
> >  is executed in a> 
> > @@ -62,12 +62,11 @@ for test_variants:
> >  		fork_testrun()
> >  
> >  ```
> > 
> > -Before we fork() the test process the test library sets up a timeout
> > alarm and -also a heartbeat signal handlers and also sets up an alarm(2)
> > accordingly to -the test timeout. When a test times out the test library
> > gets SIGALRM and the -alarm handler mercilessly kills all forked children
> > by sending SIGKILL to the -whole process group. The heartbeat handler is
> > used by the test process to reset -this timer for example when the test
> > functions run in a loop.
> > +Before we fork() the test process, the test library sets up a timeout
> > alarm and
> nit: "Before we fork " or "Before 'fork() '.
> 
> > +also a heartbeat signal handler. When a test times out, the test library
> > gets
> I'm not sure about this, isn't the original description correct? (1) timeout
> alarm() 2) a heartbeat signal handlers 3) second alarm() accordingly to the
> test timeout?
Sorry, I understood it incorrectly. I reversed it in the updated patch.

> 
> I mean there are 2 alarm() calls in tst_test.c.
> 
> Otherwise LGTM.
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> Kind regards,
> Petr
> 
> > +SIGALRM and the alarm handler mercilessly kills all forked children by
> > sending +SIGKILL to the whole process group. The heartbeat handler is
> > used by the test +process to reset this timer for example when the test
> > functions run in a loop.> 
> >  With that done we finally fork() the test process. The test process
> >  firstly
> >  resets signal handlers and sets its pid to be a process group leader so
> >  that we> 
> > @@ -97,14 +96,14 @@ usually better option than exiting it in the middle.
> > 
> >  The test cleanup() is also called by the tst\_brk() handler in order to
> >  cleanup before exiting the test process, hence it must be able to cope
> >  even with partial test setup. Usually it suffices to make sure to clean
> >  up only> 
> > -resources that already have been set up and to do that in an inverse
> > order that -we did in setup().
> > +resources that already have been set up and to do that in the reverse
> > order +that we did in setup().
> > 
> >  Once the test process exits or leaves the run() or run\_all() function
> >  the test library wakes up from the waitpid() call, and checks if the
> >  test process exited normally.
> > 
> > -Once the testrun is finished the test library does a cleanup() as well to
> > clean +Once the testrun is finished, the test library does a cleanup() as
> > well to clean> 
> >  up resources set up in the test library setup(), reports test results and
> >  finally exits the process.
> > 
> > @@ -126,8 +125,8 @@ This especially means that:
> >  - While the test results are, by the design, propagated to the test
> >  library
> >  
> >    we may still miss a child that gets killed by a signal or exits
> >    unexpectedly.> 
> > -The test writer should, because of this, take care for reaping these
> > proceses -properly, in most cases this could be simply done by calling
> > +The test writer should, because of this, take care of reaping these
> > +processes properly, in most cases this could be simply done by calling
> > 
> >  tst\_reap\_children() to collect and dissect deceased.
> >  
> >  Also note that tst\_brk() does exit only the current process, so if a
> >  child
> > 
> > @@ -136,9 +135,9 @@ exits.
> > 
> >  ### Test library and exec()
> > 
> > -The piece of mapped memory to store the results to is not preserved over
> > +The piece of mapped memory to store the results is not preserved over
> > 
> >  exec(2), hence to use the test library from a binary started by an exec()
> >  it> 
> > -has to be remaped. In this case the process must to call tst\_reinit()
> > before +has to be remapped. In this case, the process must call
> > tst\_reinit() before> 
> >  calling any other library functions. In order to make this happen the
> >  program environment carries LTP\_IPC\_PATH variable with a path to the
> >  backing file on tmpfs. This also allows us to use the test library from
> >  shell testcases.> 
> > @@ -148,5 +147,5 @@ tmpfs. This also allows us to use the test library
> > from shell testcases.> 
> >  The piece of mapped memory is also used as a base for a futex-based
> >  synchronization primitives called checkpoints. And as said previously the
> >  memory can be mapped to any process by calling the tst\_reinit()
> >  function. As a> 
> > -matter of a fact there is even a tst\_checkpoint binary that allows us to
> > use +matter of a fact, there is even a tst\_checkpoint binary that allows
> > us to use> 
> >  the checkpoints from shell code as well.

--
Avinesh



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
