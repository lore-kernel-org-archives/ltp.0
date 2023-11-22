Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92AD5C61D9B
	for <ltp@archiver.kernel.org>; Wed, 22 Nov 2023 12:16:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5AB303CE087
	for <ltp@archiver.kernel.org>; Wed, 22 Nov 2023 13:16:56 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E7D543C86A1
 for <ltp@lists.linux.it>; Wed, 22 Nov 2023 13:16:45 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 368F11A0196B
 for <ltp@lists.linux.it>; Wed, 22 Nov 2023 13:16:44 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id EEFCD21907;
 Wed, 22 Nov 2023 12:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1700655403;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5o7UA5UwNkz4+RFmGXM4IbeH/xjUb4QM1C9SMlU7jxk=;
 b=aC0bHO6FUHnI9z8JB92qKEYGNniBxYqlFUahingi9kASeF2GSvmfn/f4PS5TZPvsDAVAY5
 1UumdQ8XhRT11h7aAT/0ujv8bTzHOGDXSf6yHCw/VGBlCL90GPFEqVp/uBJziBZyq0ZO/u
 D76D/t+duxpRGLFmKx+4CieLt58rO5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1700655403;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5o7UA5UwNkz4+RFmGXM4IbeH/xjUb4QM1C9SMlU7jxk=;
 b=tdpJCH8IczWXqNItwqVP9wZeca4jGoMri1qi8ct+6gspJD+RS3k0p7BUVfHdQgdbUmUYoy
 zUSEbMhzlSi/liCg==
Received: from g78 (rpalethorpe.udp.ovpn1.prg.suse.de [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id B41FA2C14F;
 Wed, 22 Nov 2023 12:16:43 +0000 (UTC)
References: <20230803015149.69906-1-iwienand@redhat.com>
 <20230808035641.364676-2-iwienand@redhat.com>
 <ZQuYiFMOSq1tMTBs@fedora19.localdomain>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Ian Wienand <iwienand@redhat.com>
Date: Wed, 22 Nov 2023 11:24:55 +0000
Organization: Linux Private Site
In-reply-to: <ZQuYiFMOSq1tMTBs@fedora19.localdomain>
Message-ID: <87ttpe7zkl.fsf@suse.de>
MIME-Version: 1.0
X-Spamd-Bar: ++++++++++++++
Authentication-Results: smtp-out1.suse.de; dkim=none; dmarc=none;
 spf=softfail (smtp-out1.suse.de: 149.44.160.134 is neither permitted nor
 denied by domain of rpalethorpe@suse.de) smtp.mailfrom=rpalethorpe@suse.de
X-Rspamd-Server: rspamd1
X-Spamd-Result: default: False [14.29 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[rpalethorpe@suse.de]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_SPAM_SHORT(3.00)[1.000]; MIME_GOOD(-0.10)[text/plain];
 REPLYTO_ADDR_EQ_FROM(0.00)[]; DMARC_NA(1.20)[suse.de];
 R_SPF_SOFTFAIL(4.60)[~all:c]; HAS_ORG_HEADER(0.00)[];
 RWL_MAILSPIKE_GOOD(-1.00)[149.44.160.134:from];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 VIOLATED_DIRECT_SPF(3.50)[]; NEURAL_SPAM_LONG(3.50)[1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_NO_TLS_LAST(0.10)[];
 FROM_EQ_ENVFROM(0.00)[]; R_DKIM_NA(2.20)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 MID_RHS_MATCH_FROM(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: EEFCD21907
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] kernel/device-drivers/zram/zram01.sh : fill
 with compressible data
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Ian Wienand <iwienand@redhat.com> writes:

> Hello,
>
> I have a system (virtualized aarch64, 4.18.0 kernel) that is
> consistently failing the zram01.sh test as it tries to divide the
> memory stats by zero.  This has been reported before at [1] without
> resolution.  f045fd1de6420cc6d7db2bda0cd86fb56ff5b1c1 put a retry loop
> around the read of this value; this is essentially reverted here for
> the reasons described below.

This looks like a much better solution except that removing the retry
loop seems to open up the possibility of random failures due to
implementation details of write-backs and counter updates. Meanwhile the
rest of your changes seem perfectly compatible with a retry loop. In the
worst case it just has no effect or slows down failures.

There is no sync in zram_fill_fs and that is nice because we can see
what happens without forcing a sync. OTOH is it not an implementation
detail when the data will be written? Or rather when the same page
counters will be updated.

>
> After some investigation [2] my conclusion is that this zero value
> represents the pages allocated for compressed storage in the zram
> device, and due to same-page deduplication the extant method of
> filling with all-zeros can indeed lead us to not having any compressed
> data to measure.
>
> This is visible with the test being unstable with a divide-by-zero
> error, but in the bigger picture means this test is not exercising the
> compression path as desired.
>
> The approach here is to separate the test into two parts, one that
> keeps the existing behaviour but it now targeted explicitly at testing
> the page de-deuplication path.  For the reasons described above, there
> is no point in asserting the compression ratio of this test, so it is
> modified do a sanity check on the count of de-deuplicated pages.
>
> A second test is added that explicitly writes compressible data.  This
> also adds the sync, as discussed in prior version [3] to increase the
> reliability of testing.  We should not need to wait or re-read this
> value, as we have explicitly made data suitable to be stored
> compressed.
>
> [1] https://lists.linux.it/pipermail/ltp/2019-July/013028.html
> [2] https://lists.linux.it/pipermail/ltp/2023-August/034585.html
> [3] https://lists.linux.it/pipermail/ltp/2023-August/034560.html
>
> Signed-off-by: Ian Wienand <iwienand@redhat.com>
> ---
> V2 -> V3: separate into two distinct tests
>
>  .../kernel/device-drivers/zram/zram01.sh      | 118 +++++++++++++-----
>  1 file changed, 85 insertions(+), 33 deletions(-)
>
> diff --git a/testcases/kernel/device-drivers/zram/zram01.sh b/testcases/kernel/device-drivers/zram/zram01.sh
> index 6bc305f2c..22c5e1927 100755
> --- a/testcases/kernel/device-drivers/zram/zram01.sh
> +++ b/testcases/kernel/device-drivers/zram/zram01.sh
> @@ -4,9 +4,9 @@
>  # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
>  #
>  # Test creates several zram devices with different filesystems on them.
> -# It fills each device with zeros and checks that compression works.
> +# It fills each device and checks that compression works.
>  
> -TST_CNT=7
> +TST_CNT=8
>  TST_TESTFUNC="do_test"
>  TST_NEEDS_CMDS="awk bc dd"
>  TST_SETUP="setup"
> @@ -105,36 +105,77 @@ zram_mount()
>  	tst_res TPASS "mount of zram device(s) succeeded"
>  }
>  
> -read_mem_used_total()
> -{
> -	echo $(awk '{print $3}' $1)
> -}
> -
> -# Reads /sys/block/zram*/mm_stat until mem_used_total is not 0.
> -check_read_mem_used_total()
> +# Fill the filesystem with a file full of zeros.  This is to test the
> +# same-page/deduplication path in the kernel.  After filling the file
> +# with the same value, we should have a lot of pages recorded as
> +# "same_pages"; we arbitrarily test against a small value here to
> +# validate pages were deduplicated.
> +zram_fill_fs()
>  {
> -	local file="$1"
> -	local mem_used_total
> +    local mm_stat same_pages
> +    local b i
> +
> +    for i in $(seq $dev_start $dev_end); do
> +	tst_res TINFO "filling zram$i with zero value"
> +	b=0
> +	while true; do
> +	    dd conv=notrunc if=/dev/zero of=zram${i}/file \
> +	       oflag=append count=1 bs=1024 status=none \
> +	       >/dev/null 2>err.txt || break
> +	    b=$(($b + 1))
> +	done
> +	if [ $b -eq 0 ]; then
> +	    [ -s err.txt ] && tst_res TWARN "dd error: $(cat err.txt)"
> +	    tst_brk TBROK "cannot fill zram with zero value $i"
> +	fi
> +	rm zram${i}/file
> +	tst_res TPASS "zram$i was filled with '$b' KB"
> +
> +	if [ ! -f "/sys/block/zram$i/mm_stat" ]; then
> +	    if [ $i -eq 0 ]; then
> +		tst_res TCONF "zram compression ratio test requires zram mm_stat sysfs file"
> +	    fi
> +	    continue
> +	fi
>  
> -	tst_res TINFO "$file"
> -	cat $file >&2
> +	mm_stat=$(cat "/sys/block/zram$i/mm_stat")
> +	tst_res TINFO "stats for zram$i : $mm_stat"
>  
> -	mem_used_total=$(read_mem_used_total $file)
> -	[ "$mem_used_total" -eq 0 ] && return 1
> +	same_pages=`echo $mm_stat | awk '{print $6}'`
> +	if [ "$same_pages" -lt 10 ]; then
> +	    tst_res TFAIL "insufficient same_pages: $same_pages < 10"

Why 10?

I would think that it should be >= to the number of whole pages we
wrote or else just > the value before we wrote any pages.

The rest looks good.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
