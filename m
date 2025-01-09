Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2597FE77199
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 07:47:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9DBE43C20CA
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 08:47:07 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6CCFE3C1ABD
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 08:46:51 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 924C2200168
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 08:46:50 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D419921133;
 Thu,  9 Jan 2025 07:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736408808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nvVXniB6u5YP3WCyuM0o48dteqCVTHPnRTvWlSSBsPk=;
 b=pQDge4QSlhcR/eLHGKirL/mgo/PAV2JsU5VQAbZeGLdBUf9XcqWLSx6Md+WZyomsSptWWG
 fk+E0ZRXAGhlM3PQGdEYU1BgunYdECQHE4Iv3yRkhW0kvkR6L9tvK5Eh7U7sna1KfPbl1Y
 kDDHPTHn53q76k/PtWbAYZK3z+nfN1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736408808;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nvVXniB6u5YP3WCyuM0o48dteqCVTHPnRTvWlSSBsPk=;
 b=SEIP+tCKV0dyNZCQZHsyIdknP6pzrDzpVWaL/74n9HBy1bMsAVU83jtNeN/GsKYNsNcVlj
 /yWzv8G/uGidkQCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736408808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nvVXniB6u5YP3WCyuM0o48dteqCVTHPnRTvWlSSBsPk=;
 b=pQDge4QSlhcR/eLHGKirL/mgo/PAV2JsU5VQAbZeGLdBUf9XcqWLSx6Md+WZyomsSptWWG
 fk+E0ZRXAGhlM3PQGdEYU1BgunYdECQHE4Iv3yRkhW0kvkR6L9tvK5Eh7U7sna1KfPbl1Y
 kDDHPTHn53q76k/PtWbAYZK3z+nfN1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736408808;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nvVXniB6u5YP3WCyuM0o48dteqCVTHPnRTvWlSSBsPk=;
 b=SEIP+tCKV0dyNZCQZHsyIdknP6pzrDzpVWaL/74n9HBy1bMsAVU83jtNeN/GsKYNsNcVlj
 /yWzv8G/uGidkQCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF7FB13876;
 Thu,  9 Jan 2025 07:46:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id DdTELeh+f2cEXQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 09 Jan 2025 07:46:48 +0000
Date: Thu, 9 Jan 2025 08:50:52 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Z39_3BKj3d3nbfau@rei.lan>
References: <20250108071201.26984-1-liwang@redhat.com>
 <Z35C00m6FwH8P8BI@yuki.lan>
 <CAEemH2dYrPTT3iw69bWwpyS6uVf8wkZQESuUudp274A7hsmRUA@mail.gmail.com>
 <CAEemH2eAoto=mLFeiXG9WtwPgiwzF=NKbXDbE1eWTuo_QBW8Zw@mail.gmail.com>
 <Z35wmODIV_vuYBOA@rei>
 <CAEemH2eHfJDLNhMwomZ5VHBSwqpUZsD9GuaMDRnpY_XdfPjEdA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2eHfJDLNhMwomZ5VHBSwqpUZsD9GuaMDRnpY_XdfPjEdA@mail.gmail.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCh] lib: redefine the overall timeout logic of
 test
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
Cc: ltp@lists.linux.it, Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> I have a different view on the readahead02 test, because the runtime
> resetting is based on pieces of each IO test elapsed time, then reset
> runtime for next time. This applies to any kernels, no matter the faster
> or slower, the elapsed time will be enough for the next tcases[].
> 
> If we put the worst-case runtime into .timeout and reset for the next
> tcases[], which will be multiplied again on debug kernel, actually we
> don't need that since the dynamic runtime comes from a real test.

I do not get why we need to reset anything. The test library does reset
the timeout after each test iteration:

       for (i = 0; i < tst_test->tcnt; i++) {
                saved_results = *results;
                heartbeat();
		^
		this resets the timeout timer so each iteration runs
		with the whole timeout

                tst_test->test(i);

                if (tst_getpid() != main_pid)
                        exit(0);

                tst_reap_children();

                if (results_equal(&saved_results, results))
                        tst_brk(TBROK, "Test %i haven't reported results!", i);
        }

> Maybe I missed something in the test, but we can treat readahead02
> in a separate work. The new patch 4/4 should be modified using .runtime
> instead of .timeout. Feel free to comment your thoughts there.

Why is readahead02 so special that we need to do more than the usuall?

That is:

- measure how long one tests iteration takes on slower hardware
- multiply that by two and set that as a .timeout

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
