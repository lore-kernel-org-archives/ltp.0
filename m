Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB90C43217
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 22:57:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD93E3CAF3C
	for <ltp@archiver.kernel.org>; Fri, 14 Oct 2022 00:57:08 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C929F3CA91F
 for <ltp@lists.linux.it>; Fri, 14 Oct 2022 00:56:58 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5D38C100099E
 for <ltp@lists.linux.it>; Fri, 14 Oct 2022 00:56:56 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2FE761F8F4;
 Thu, 13 Oct 2022 22:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1665701816;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8R8muxIexCts691o2P7EEq7e72h0Ffpn3SB8KqX9PsA=;
 b=TlKIGnbD/nIlVrgkOGDZIJF42r3YDQjFKhLd32Wvn3+4qkb6Mg5Q7k47yPW9Rdi1s0ct9R
 9uIP8ce1JxpasP8qaGFmKlzSIsJa2ektkEWEzFDm0xeTuiE9EcU7WgZct5lQgFri8en459
 YU7yLqyGbI5l2UZDObldgIKS0Sio2jk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1665701816;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8R8muxIexCts691o2P7EEq7e72h0Ffpn3SB8KqX9PsA=;
 b=zAxBlKx4MJwRqfUdNqRaikJjfOrwfq44dppLXBtf2wqQqI5IN5aJSZI0Vw3F8+nSlXot0N
 xhBbBaoOAP8PeWBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 125ED13AAA;
 Thu, 13 Oct 2022 22:56:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bshKAriXSGM7cgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 13 Oct 2022 22:56:56 +0000
Date: Fri, 14 Oct 2022 00:56:54 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <Y0iXthAQlzOkp2/s@pevik>
References: <20221013082146.14581-1-andrea.cervesato@suse.com>
 <20221013082146.14581-3-andrea.cervesato@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221013082146.14581-3-andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8 1/2] Rewrite aio-stress test using LTP API
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

2 nits below.

very nit: I'd put copyright 2022.

> +++ b/runtest/ltp-aio-stress.part1
...
> - * will open or create each file on the command line, and start a series
> - * of aio to it.
> - *
> - * aio is done in a rotating loop.  first file1 gets 8 requests, then
> - * file2, then file3 etc.  As each file finishes writing, it is switched
> - * to reads
> - *
> - * io buffers are aligned in case you want to do raw io
> - *
> - * compile with gcc -Wall -laio -lpthread -o aio-stress aio-stress.c
> + * Will open or create each file on the command line, and start a series
nit: I'm not a native English speaker but "Will" sound strange to me.
Maybe just:
"Test opens or creates ..."

I'd personally put blank line before starting multiline comment, before opening
if, below } - ending if and return before the end of function (readability). But
you can ignore these.

/* this
=> should be

/*
 * This

+ using comments in style like in include/tst_fuzzy_sync.h (@return etc) would
be nice, but again, you can ignore these comments :).

> + * of AIO to it.
>   *
> - * run aio-stress -h to see the options
> + * AIO is done in a rotating loop. First file1.bin gets 8 requests, then
> + * file2.bin, then file3.bin etc. As each file finishes writing, it is switched
> + * to reads.
>   *
> - * Please mail Chris Mason (mason@suse.com) with bug reports or patches
> + * IO buffers are aligned in case you want to do raw IO.
>   */
> +
>  #define _FILE_OFFSET_BITS 64
> -#define PROG_VERSION "0.21"
>  #define NEW_GETEVENTS
Why this? io_getevents() takes now 4 args, man does not mention when it was
changed. I'd delete this definition and #else.

...
>  /*
>   * latencies during io_submit are measured, these are the
>   * granularities for deviations
>   */
>  #define DEVIATIONS 6
> -int deviations[DEVIATIONS] = { 100, 250, 500, 1000, 5000, 10000 };
> +static int deviations[DEVIATIONS] = { 100, 250, 500, 1000, 5000, 10000 };

How about use ARRAY_SIZE()?

diff --git testcases/kernel/io/ltp-aiodio/aio-stress.c testcases/kernel/io/ltp-aiodio/aio-stress.c
index ca51b3a52..b24ca17eb 100644
--- testcases/kernel/io/ltp-aiodio/aio-stress.c
+++ testcases/kernel/io/ltp-aiodio/aio-stress.c
@@ -103,15 +103,14 @@ static char *unlink_files;
  * latencies during io_submit are measured, these are the
  * granularities for deviations
  */
-#define DEVIATIONS 6
-static int deviations[DEVIATIONS] = { 100, 250, 500, 1000, 5000, 10000 };
+static int deviations[] = { 100, 250, 500, 1000, 5000, 10000 };
 
 struct io_latency {
 	double max;
 	double min;
 	double total_io;
 	double total_lat;
-	double deviations[DEVIATIONS];
+	double deviations[ARRAY_SIZE(deviations)];
 };
 
 /* container for a series of operations to a file */
@@ -278,7 +277,7 @@ static void calc_latency(struct timeval *start_tv, struct timeval *stop_tv,
 			 struct io_latency *lat)
 {
 	double delta;
-	int i;
+	size_t i;
 
 	delta = time_since(start_tv, stop_tv);
 	delta = delta * 1000;
@@ -289,7 +288,7 @@ static void calc_latency(struct timeval *start_tv, struct timeval *stop_tv,
 		lat->min = delta;
 	lat->total_io++;
 	lat->total_lat += delta;
-	for (i = 0; i < DEVIATIONS; i++) {
+	for (i = 0; i < ARRAY_SIZE(deviations); i++) {
 		if (delta < deviations[i]) {
 			lat->deviations[i]++;
 			break;
@@ -416,12 +415,12 @@ static void print_lat(char *str, struct io_latency *lat)
 	char out[4 * 1024];
 	char *ptr = out;
 	double avg = lat->total_lat / lat->total_io;
-	int i;
+	size_t i;
 	double total_counted = 0;
 
 	tst_res(TINFO, "%s min %.2f avg %.2f max %.2f", str, lat->min, avg, lat->max);
 
-	for (i = 0; i < DEVIATIONS; i++) {
+	for (i = 0; i < ARRAY_SIZE(deviations); i++) {
 		ptr += sprintf(ptr, "%.0f < %d", lat->deviations[i], deviations[i]);
 		total_counted += lat->deviations[i];
 	}

Again, you can ignore this.

> +		{ "f:", &str_num_files, "Number of files to generate" },
nit: this is not sorted alphabetically.
> +		{ "b:", &str_max_io_submit, "Max number of iocbs to give io_submit at once" },
> +		{ "c:", &str_num_contexts, "Number of io contexts per file" },
> +		{ "g:", &str_context_offset, "Offset between contexts (default 2M)" },
> +		{ "s:", &str_file_size, "Size in MB of the test file(s) (default 1024M)" },
> +		{ "r:", &str_rec_len, "Record size in KB used for each io (default 64K)" },
> +		{ "d:", &str_depth, "Number of pending aio requests for each file (default 64)" },
> +		{ "e:", &str_io_iter, "Number of I/O per file sent before switching to the next file (default 8)" },
> +		{ "a:", &str_iterations, "Total number of ayncs I/O the program will run, default is run until Cntl-C (default 500)" },
This should be without ", default is run until Cntl-C".
OT: Cntl looks trange to me, I'd use ^C or <ctrl> + C (irrelevant now)

I also see RUN_FOREVER, do we really need it? No other LTP test runs forever.

> +		{ "O", &str_o_flag, "Use O_DIRECT" },
> +		{ "o:", &str_stages, "Add an operation to the list: write=0, read=1, random write=2, random read=3" },
> +		{ "m", &str_use_shm, "SHM use ipc shared memory for io buffers instead of malloc" },
> +		{ "n", &no_fsync_stages, "No fsyncs between write stage and read stage" },
> +		{ "l", &latency_stats, "Print io_submit latencies after each stage" },
> +		{ "L", &completion_latency_stats, "Print io completion latencies after each stage" },
Also this is not sorted.
> +		{ "t:", &str_num_threads, "Number of threads to run" },
> +		{ "u", &unlink_files, "Unlink files after completion" },
> +		{ "v", &verify, "Verification of bytes written" },
> +		{ "x", &no_stonewall, "Turn off thread stonewalling" },
> +		{},
> +	},
> +};
>  #else
> -int main(void)
> -{
> -	fprintf(stderr, "test requires libaio and it's development packages\n");
> -	return TCONF;
> -}
> +TST_TEST_TCONF("test requires libaio and its development packages");
>  #endif

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
