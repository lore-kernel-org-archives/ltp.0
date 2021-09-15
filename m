Return-Path: <SRS0=JaEE=OF=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F80EC433EF
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 22:40:45 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F13160F70
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 22:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4F13160F70
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 17AA43C920B
	for <ltp@archiver.kernel.org>; Thu, 16 Sep 2021 00:40:42 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 098043C1D49
 for <ltp@lists.linux.it>; Thu, 16 Sep 2021 00:40:32 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8C40110005FD
 for <ltp@lists.linux.it>; Thu, 16 Sep 2021 00:40:31 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5240E22323;
 Wed, 15 Sep 2021 22:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631745630;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/+Yi28huOnM54qoTcGoYIQaVqTvaVv0nbl5XXEnPqls=;
 b=0f+2IyrxH4eUegmbhj/bVBq4XywA/L0TvDvBKBJ/8EPw8M2JhiwhYP8CVJ1pmtFI9yYCMY
 Qos2t82zDxgQ98ujAgLw41Mh6NjgCtK3wY7dmiJjLItWpgETVU2kZMU71ZU+cNsw62R7iV
 1mB1/oFuQz+iUlmbdMfm1XaKUEX04TU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631745630;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/+Yi28huOnM54qoTcGoYIQaVqTvaVv0nbl5XXEnPqls=;
 b=FzxKAvqYKWRLQtJ4I/H/YXAGUlgWD5dQ9K9ouheHTFOv3qu94waPUBecpELq4scymtXlsr
 6i9BhdQENDUYovAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1BB1713C77;
 Wed, 15 Sep 2021 22:40:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Q8wqBV52QmHiUwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 15 Sep 2021 22:40:30 +0000
Date: Thu, 16 Sep 2021 00:40:28 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YUJ2XA7W3JPODyNC@pevik>
References: <20210519085812.27263-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210519085812.27263-1-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] tst_test: using SIGTERM to terminate process
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Joerg Vehlow <joerg.vehlow@aox-tech.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210915224028.e7Hg2EhWcb30WVi-ssCojx-K_1IDMqUI18KJBoZ-ag8@z>

Hi Li, all,

> We'd better avoid using SIGINT for process terminating becuasue,
> it has different behavoir on kind of shell.

> From Joerg Vehlow's test:

>  - bash does not seem to care about SIGINT delivery to background
>    processes, but can be blocked using trap

>  - zsh ignores SIGINT for background processes by default, but can be
>    allowed using trap

>  - dash and busybox sh ignore the signal to background processes, and
>    this cannot be changed with trap

> This patch cover the below situations:

>  1. SIGINT (Ctrl^C) for terminating the main process and do cleanup
>     correctly before a timeout

>  2. Test finish normally and retrieves the _tst_timeout_process in the
>     background via SIGTERM(sending by _tst_cleanup_timer)

>  3. Test timed out occurs and _tst_kill_test sending SIGTERM to
>     terminating all process, and the main process do cleanup work

>  4. Test timed out occurs but still have process alive after _tst_kill_test
>     sending SIGTERM, then sending SIGKILL to the whole group

>  5. Test terminated by SIGTERM unexpectly (e.g. system shutdown or process
>     manager) and do cleanup work as well

> Co-authored-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
> Signed-off-by: Li Wang <liwang@redhat.com>
> Reviewed-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
...

> +++ b/testcases/lib/tst_test.sh
> @@ -21,7 +21,8 @@ export TST_LIB_LOADED=1
>  . tst_security.sh

>  # default trap function
> -trap "tst_brk TBROK 'test interrupted or timed out'" INT
> +trap "tst_brk TBROK 'test interrupted'" INT
> +trap "unset _tst_setup_timer_pid; tst_brk TBROK 'test terminated'" TERM

FYI this commit (merged as 4a6b8a697 ("tst_test: using SIGTERM to terminate process"))
broke net_stress_interface tests, particularly tst_require_cmds() call (which
calls tst_brk TCONF:

# ./if-addr-adddel.sh -c ifconfig
if-addr-adddel 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
if-addr-adddel 1 TINFO: add local addr 10.0.0.2/24
if-addr-adddel 1 TINFO: add local addr fd00:1:1:1::2/64
if-addr-adddel 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface
if-addr-adddel 1 TINFO: add remote addr 10.0.0.1/24
if-addr-adddel 1 TINFO: add remote addr fd00:1:1:1::1/64
if-addr-adddel 1 TINFO: Network config (local -- remote):
if-addr-adddel 1 TINFO: ltp_ns_veth2 -- ltp_ns_veth1
if-addr-adddel 1 TINFO: 10.0.0.2/24 -- 10.0.0.1/24
if-addr-adddel 1 TINFO: fd00:1:1:1::2/64 -- fd00:1:1:1::1/64
if-addr-adddel 1 TINFO: timeout per run is 0h 5m 0s
if-addr-adddel 1 TCONF: 'ifconfig' not found
=> waits till timeout
if-addr-adddel 1 TBROK: Test timed out, sending SIGTERM! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
if-addr-adddel 1 TWARN: test terminated

Debugging it hangs in wait in _tst_cleanup_timer():

kill -TERM $_tst_setup_timer_pid 2>/dev/null
wait $_tst_setup_timer_pid 2>/dev/null

because kill does not kill the test.

The problem looks to be that unset actually does not work.
trap "unset _tst_setup_timer_pid; tst_brk TBROK 'test terminated'" TERM

It looks to be something setup specific, because I discovered this on SLES on
both bash and dash. Running it on current Debian testing it works on both bash
and dash. I checked shopt output on both, but don't see anything obvious. It
must be something else.

Kind regards,
Petr

>  _tst_do_exit()
>  {
> @@ -439,9 +440,9 @@ _tst_kill_test()
>  {
>  	local i=10

> -	trap '' INT
> -	tst_res TBROK "Test timeouted, sending SIGINT! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1"
> -	kill -INT -$pid
> +	trap '' TERM
> +	tst_res TBROK "Test timed out, sending SIGTERM! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1"
> +	kill -TERM -$pid
>  	tst_sleep 100ms

>  	while kill -0 $pid >/dev/null 2>&1 && [ $i -gt 0 ]; do

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
