Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF40C07545
	for <ltp@archiver.kernel.org>; Tue, 24 Oct 2023 15:54:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 94DA73CF4E5
	for <ltp@archiver.kernel.org>; Tue, 24 Oct 2023 17:54:41 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9C0463CEC81
 for <ltp@lists.linux.it>; Tue, 24 Oct 2023 17:54:30 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 364D3602F93
 for <ltp@lists.linux.it>; Tue, 24 Oct 2023 17:54:28 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8349121BF9;
 Tue, 24 Oct 2023 15:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698162867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zuClMtVxvNOeZnrG2oESuV10+3EDXLwsU0pG1BPyQMA=;
 b=N1ERXv0QmQ83oagy2Iu5iIWgDySM28Jiym8iyE4GxXN6LfmAsmEvch2b6+RvLlSuwUmpr2
 xnb3e6VwbxF8v0n117IiqsBZXySSDJAn8TarkiLIj4oSMbv6Mmzh1YmDfMQHAEVQiv4b/g
 xBMue/nswvfrsbJWdR3fZeWRpZCzItA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698162867;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zuClMtVxvNOeZnrG2oESuV10+3EDXLwsU0pG1BPyQMA=;
 b=+dMGYq8iSDNfM+FPYv6JFMcSQ9Vk3seNvmBs3ZIovH9ZJlUyTlTAWqphtvYVhCirPQ2MSk
 moy+P2cKWR4WTXCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7067E1391C;
 Tue, 24 Oct 2023 15:54:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Gpp8GrPoN2U/WgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Tue, 24 Oct 2023 15:54:27 +0000
Message-ID: <bddbae90-13a5-0947-a55a-089de6530d99@suse.cz>
Date: Tue, 24 Oct 2023 17:54:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To: Marius Kittler <mkittler@suse.de>, ltp@lists.linux.it
References: <20231023160242.3605-1-mkittler@suse.de>
 <20231023160242.3605-6-mkittler@suse.de>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20231023160242.3605-6-mkittler@suse.de>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-11.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 5/5] Extend ioctl02 to test termio and termios
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,
I'd strongly recommend merging this patch with the previous one. There's 
no point switching everything to termios only to add termio back in the 
next commit.

On 23. 10. 23 18:02, Marius Kittler wrote:
> Signed-off-by: Marius Kittler <mkittler@suse.de>
> ---
>   testcases/kernel/syscalls/ioctl/ioctl02.c | 170 +++++++++++++++++++---
>   1 file changed, 147 insertions(+), 23 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl02.c b/testcases/kernel/syscalls/ioctl/ioctl02.c
> index 5111d7178..00d51b367 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl02.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl02.c
> @@ -8,22 +8,24 @@
>   /*\
>    * [Description]
>    *
> - * Testcase to test the TCGETS, and TCSETS ioctl implementations for
> - * the tty driver
> + * Testcase to test the TCGETA/TCGETS, and TCSETA/TCSETS ioctl
> + * implementations for the tty driver
>    *
>    * In this test, the parent and child open the parentty and the childtty
>    * respectively.  After opening the childtty the child flushes the stream
>    * and wakes the parent (thereby asking it to continue its testing). The
> - * parent, then starts the testing. It issues a TCGETS ioctl to get all
> - * the tty parameters. It then changes them to known values by issuing a
> - * TCSETS ioctl. Then the parent issues a TCGETS ioctl again and compares
> - * the received values with what it had set earlier. The test fails if
> - * TCGETS or TCSETS fails, or if the received values don't match those
> - * that were set. The parent does all the testing, the requirement of the
> - * child process is to moniter the testing done by the parent, and hence
> - * the child just waits for the parent.
> + * parent, then starts the testing. It issues a TCGETA/TCGETS ioctl to
> + * get all the tty parameters. It then changes them to known values by
> + * issuing a TCSETA/TCSETS ioctl. Then the parent issues a TCSETA/TCGETS
> + * ioctl again and compares the received values with what it had set
> + * earlier. The test fails if TCGETA/TCGETS or TCSETA/TCSETS fails, or if
> + * the received values don't match those that were set. The parent does
> + * all the testing, the requirement of the child process is to moniter
> + * the testing done by the parent, and hence the child just waits for the
> + * parent.
>    */
>   
> +#include <asm-generic/ioctls.h>

#including <asm/*> or <asm-generic/*> directly is generally a bad 
practice. You should #include <sys/ioctl.h> instead.

>   #include <stdio.h>
>   #include <fcntl.h>
>   #include <errno.h>
> @@ -38,23 +40,54 @@
>   #include "tst_test.h"
>   #include "tst_safe_macros.h"
>   
> -static struct termios termio, save_io;
> +static struct termio termio;
> +static struct termios termios, termios_bak;
>   
>   static char *parenttty, *childtty;
>   static int parentfd = -1, childfd = -1;
>   static int parentpid, childpid;
>   
>   static int do_child_setup(void);
> +static void prepare_termio(void);
> +static void preapre_termios(void);
>   static void run_ptest(void);
>   static void run_ctest(void);
> -static void chk_tty_parms(void);
> +static void chk_tty_parms_termio(void);
> +static void chk_tty_parms_termios(void);
>   static void setup(void);
>   static void cleanup(void);
>   
>   static char *device;
>   
> +static struct variant {
> +	const char *name;
> +	void *termio, *termio_bak;
> +	void (*prepare)(void);
> +	void (*check)(void);
> +	int tcget, tcset;
> +} variants[] = {
> +	{
> +		.name = "termio",
> +		.termio = &termio,
> +		.prepare = &prepare_termio,
> +		.check = &chk_tty_parms_termio,
> +		.tcget = TCGETA,
> +		.tcset = TCSETA,
> +	},
> +	{
> +		.name = "termios",
> +		.termio = &termios,
> +		.prepare = preapre_termios,
> +		.check = &chk_tty_parms_termios,
> +		.tcget = TCGETS,
> +		.tcset = TCSETS,
> +	},
> +};
> +
>   static void verify_ioctl(void)
>   {
> +	tst_res(TINFO, "Testing %s variant", variants[tst_variant].name);
> +
>   	parenttty = device;
>   	childtty = device;
>   
> @@ -80,11 +113,7 @@ static void verify_ioctl(void)
>   	TST_CHECKPOINT_WAKE(0);
>   }
>   
> -/*
> - * run_ptest() - setup the various termio structure values and issue
> - *		 the TCSETS ioctl call with the TEST macro.
> - */
> -static void run_ptest(void)
> +static void prepare_termio(void)
>   {
>   	/* Use "old" line discipline */
>   	termio.c_line = 0;
> @@ -110,12 +139,50 @@ static void run_ptest(void)
>   
>   	/* Set output modes. */
>   	termio.c_oflag = OPOST | OLCUC | ONLCR | ONOCR;
> +}
>   
> -	SAFE_IOCTL(parentfd, TCSETS, &termio);
> +static void preapre_termios(void)
> +{
> +	/* Use "old" line discipline */
> +	termios.c_line = 0;

You don't need to duplicate the whole prepare_termio() function. You can 
either initialize both structures at once:
termio.c_line = termios.c_line = 0;
termio.c_cflag = termios.c_cflag = ...;

of #define an init macro:
#define TERM_INIT_VALUES { .c_line = 0, .c_cflag = ... }
termio = (struct termio)TERM_INIT_VALUES;
termios = (struct termios)TERM_INIT_VALUES;

> +
> +	/* Set control modes */
> +	termios.c_cflag = B50 | CS7 | CREAD | PARENB | PARODD | CLOCAL;
> +
> +	/* Set control chars. */
> +	for (int i = 0; i < NCC; i++) {
> +		if (i == VEOL2)
> +			continue;
> +		termios.c_cc[i] = CSTART;
> +	}
> +
> +	/* Set local modes. */
> +	termios.c_lflag =
> +	    ((unsigned short)(ISIG | ICANON | XCASE | ECHO | ECHOE | NOFLSH));
> +
> +	/* Set input modes. */
> +	termios.c_iflag =
> +	    BRKINT | IGNPAR | INPCK | ISTRIP | ICRNL | IUCLC | IXON | IXANY |
> +	    IXOFF;
> +
> +	/* Set output modes. */
> +	termios.c_oflag = OPOST | OLCUC | ONLCR | ONOCR;
> +}
> +
> +/*
> + * run_ptest() - setup the various termio/termios structure values and issue
> + * the TCSETA/TCSETS ioctl call with the TEST macro.
> + */
> +static void run_ptest(void)
> +{
> +	struct variant *v = &variants[tst_variant];
> +
> +	v->prepare();
> +	SAFE_IOCTL(parentfd, v->tcset, v->termio);
>   
>   	/* Get termio and see if all parameters actually got set */
> -	SAFE_IOCTL(parentfd, TCGETS, &termio);
> -	chk_tty_parms();
> +	SAFE_IOCTL(parentfd, v->tcget, v->termio);
> +	v->check();
>   }
>   
>   static void run_ctest(void)
> @@ -125,7 +192,7 @@ static void run_ctest(void)
>   	SAFE_CLOSE(childfd);
>   }
>   
> -static void chk_tty_parms(void)
> +static void chk_tty_parms_termio(void)
>   {
>   	int i, flag = 0;
>   
> @@ -174,6 +241,62 @@ static void chk_tty_parms(void)
>   		flag++;
>   	}
>   
> +	if (flag != 0)
> +		tst_res(TFAIL, "TCGETA/TCSETA tests FAILED with "
> +				"%d %s", flag, flag > 1 ? "errors" : "error");
> +	else
> +		tst_res(TPASS, "TCGETA/TCSETA tests SUCCEEDED");
> +}
> +
> +static void chk_tty_parms_termios(void)
> +{
> +	int i, flag = 0;
> +
> +	if (termios.c_line != 0) {
> +		tst_res(TINFO, "line discipline has incorrect value %o",
> +			 termios.c_line);
> +		flag++;
> +	}

Some code duplication is unavoidable here but the value validation can 
be simplified:

1) Add another pair of termio+termios variables which will be 
initialized in setup() and passed only to SAFE_IOCTL(TCSETA/TCSETS).

2) memset() the existing termio+termios variables before passing them to 
SAFE_IOCTL(TCGETA/TCGETS). As is, the test can pass even if 
TCGETA/TCGETS does nothing because they store data into a structure that 
already contains the exact same values.

3) Define a macro to compare the "set" and "get" variables:
#define CMP_ATTR(tcexp, tcval, attr) \
	if ((tcval).attr != (tcexp).attr) { \
		tst_res(TINFO, #attr " has incorrect value %o", \
			 (tcval).attr); \
		flag++; \
	}

Then all attribtute checks except the loop can be reduced to one line.

> +
> +	for (i = 0; i < NCC; i++) {
> +		if (i == VEOL2) {
> +			if (!termios.c_cc[i]) {
> +				continue;
> +			} else {
> +				tst_res(TINFO, "control char %d has "
> +					 "incorrect value %d", i, termios.c_cc[i]);
> +				flag++;
> +				continue;
> +			}
> +		}
> +
> +		if (termios.c_cc[i] != CSTART) {
> +			tst_res(TINFO, "control char %d has incorrect "
> +				 "value %d.", i, termios.c_cc[i]);
> +			flag++;
> +		}
> +	}
> +
> +	if (termios.c_lflag != (ISIG | ICANON | XCASE | ECHO | ECHOE
> +		 | NOFLSH)) {
> +		tst_res(TINFO, "lflag has incorrect value. %o",
> +			 termios.c_lflag);
> +		flag++;
> +	}
> +
> +	if (termios.c_iflag != (BRKINT | IGNPAR | INPCK | ISTRIP
> +		 | ICRNL | IUCLC | IXON | IXANY | IXOFF)) {
> +		tst_res(TINFO, "iflag has incorrect value. %o",
> +			 termios.c_iflag);
> +		flag++;
> +	}
> +
> +	if (termios.c_oflag != (OPOST | OLCUC | ONLCR | ONOCR)) {
> +		tst_res(TINFO, "oflag has incorrect value. %o",
> +			 termios.c_oflag);
> +		flag++;
> +	}
> +
>   	if (flag != 0)
>   		tst_res(TFAIL, "TCGETS/TCSETS tests FAILED with "
>   				"%d %s", flag, flag > 1 ? "errors" : "error");
> @@ -202,7 +325,7 @@ static void setup(void)
>   	int fd = SAFE_OPEN(device, O_RDWR, 0777);
>   
>   	/* Save the current device information - to be restored in cleanup() */
> -	SAFE_IOCTL(fd, TCGETS, &save_io);
> +	SAFE_IOCTL(fd, TCGETS, &termios_bak);
>   
>   	/* Close the device */
>   	SAFE_CLOSE(fd);
> @@ -211,7 +334,7 @@ static void setup(void)
>   static void cleanup(void)
>   {
>   	if (parentfd >= 0) {
> -		SAFE_IOCTL(parentfd, TCSETS, &save_io);
> +		SAFE_IOCTL(parentfd, TCSETS, &termios_bak);
>   		SAFE_CLOSE(parentfd);
>   	}
>   }
> @@ -223,6 +346,7 @@ static struct tst_test test = {
>   	.setup = setup,
>   	.cleanup = cleanup,
>   	.test_all = verify_ioctl,
> +	.test_variants = 2,
>   	.options = (struct tst_option[]) {
>   		{"D:", &device, "Tty device. For example, /dev/tty[0-9]"},
>   		{}

-- 
Martin Doucha   mdoucha@suse.cz
SW Quality Engineer
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
