Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 008F2C433EF
	for <ltp@archiver.kernel.org>; Tue, 23 Nov 2021 18:27:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B7293C8F0B
	for <ltp@archiver.kernel.org>; Tue, 23 Nov 2021 19:27:08 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5B09E3C8E31
 for <ltp@lists.linux.it>; Tue, 23 Nov 2021 19:26:58 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4B235601C5D
 for <ltp@lists.linux.it>; Tue, 23 Nov 2021 19:26:57 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6E7A421940;
 Tue, 23 Nov 2021 18:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1637692017;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=llXh4JERzalp3qo446aqnooFAIHWOIG1r9ODc+RU1a8=;
 b=ed+vGTRN9o1Yex4Kz8CSb4KEEJd2uAUvni8O1A9brBBOIa2ojXNrrM7ISLqD7eIUD+Os5B
 0ALdAYWmhqYcMBO29EGCurTBVTcSgL451ibKleUnnLpZLvxDTo2DIECvgxEzw1sUdFl/Rr
 HGGR3drNd9NFtiSuIrYH5tJxHmCbsQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1637692017;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=llXh4JERzalp3qo446aqnooFAIHWOIG1r9ODc+RU1a8=;
 b=QiEmAMUGXPJoMHT5b6fAuSCFY8PF5yNIy4Vk3iErJ72U1SNT+HAxGFPFdZAfGVTkgCMPNB
 HIrug024n7s+yBAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E6EC613E54;
 Tue, 23 Nov 2021 18:26:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id LMTDM3AynWE4FAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 23 Nov 2021 18:26:56 +0000
Date: Tue, 23 Nov 2021 19:26:54 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <YZ0ybqlqV/D8fqAJ@pevik>
References: <20211123180711.30274-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211123180711.30274-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] tst_test.sh: Print help ASAP
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
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

[ Cc Alexey ]

> There is no need to run setup before printing help.

This is wrong approach (=> reject status), it should be fixed in tst_net.sh,
which should probably run netns initialization:
[ -n "$TST_USE_NETNS" -a "$TST_INIT_NETNS" != "no" ] && init_ltp_netspace

as part of the setup function (tst_net_setup).

Because 1) running help immediately breaks redefining help in nfs07.sh [1]:

. nfs_lib.sh

TST_USAGE="show_usage"

(yes, having help for tst_net.sh, nfs_lib.sh and for some of the tests
which use it is maybe complicated flow, but it should work).

2) code works as expected for tests which use just tst_test.sh (or other
libraries which does *not* use tst_net.sh).

Sorry for the noise.

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/20211123151537.14913-3-mdoucha@suse.cz/T/#u

> Before this change root was required for network tests also for -h:

>     $ PATH="$lb:$PATH" nfs01 -h
>     nfs01 1 TCONF: Must be super/root for this test!

> And with root setup was run:

> 	# PATH="$lb:$PATH" nfs07.sh -h
> 	nfs07 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
> 	nfs07 1 TINFO: add local addr 10.0.0.2/24
> 	nfs07 1 TINFO: add local addr fd00:1:1:1::2/64
> 	nfs07 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface
> 	nfs07 1 TINFO: add remote addr 10.0.0.1/24
> 	nfs07 1 TINFO: add remote addr fd00:1:1:1::1/64
> 	nfs07 1 TINFO: Network config (local -- remote):
> 	nfs07 1 TINFO: ltp_ns_veth2 -- ltp_ns_veth1
> 	nfs07 1 TINFO: 10.0.0.2/24 -- 10.0.0.1/24
> 	nfs07 1 TINFO: fd00:1:1:1::2/64 -- fd00:1:1:1::1/64
> 	-t x    Socket type, tcp or udp, default is udp
> 	-v x    NFS version, default is '3'
> 	-n x    Create x files and x directories, default is 5000
> 	-h      Prints this help
> 	-i n    Execute test n times

> Now help is simply printed:

>     $ PATH="$lb:$PATH" nfs01 -h
>     -t x    Socket type, tcp or udp, default is udp
>     -v x    NFS version, default is '3'
>     -6      IPv6 tests
>     -h      Prints this help
>     -i n    Execute test n times

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/lib/tst_test.sh | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index 2556b28f5..3cf94adac 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -606,7 +606,6 @@ tst_run()

>  	while getopts ":hi:$TST_OPTS" _tst_name $TST_ARGS; do
>  		case $_tst_name in
> -		'h') tst_usage; exit 0;;
>  		'i') TST_ITERATIONS=$OPTARG;;
>  		'?') tst_usage; exit 2;;
>  		*) $TST_PARSE_ARGS "$_tst_name" "$OPTARG";;
> @@ -789,4 +788,9 @@ if [ -z "$TST_NO_DEFAULT_RUN" ]; then
>  			tst_brk TBROK "Unexpected positional arguments '$@'"
>  		fi
>  	fi
> +
> +	if [ "$TST_PRINT_HELP" = 1 ]; then
> +		tst_usage
> +		exit 0
> +	fi
>  fi

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
