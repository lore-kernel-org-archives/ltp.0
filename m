Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08009C4332F
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 15:31:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD7853CC830
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 16:31:31 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B43213CAA14
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 16:31:19 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AF84B1BB9C3B
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 16:31:17 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CE14F21870;
 Fri,  3 Nov 2023 15:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1699025476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QjQDcM+ONcL3qtwhZL8fYHqnJ49uHQ00Q2zgslFVyq4=;
 b=UxedYSQKCIJNiUD4kKdjzVhS3HkvsQJL8VxNyyKake0TcymW8Pvow0HdlBxRwOoizlbLS6
 sPvHkDViYdm8nGouRO/zQepyaCm02xVEDyXBC+wejXAYp0uKZtsNNTjb1IYI6rsB0LGRp/
 5Gpvh6NzMjMjP0Dbs9xU+urWQ9fmiUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1699025476;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QjQDcM+ONcL3qtwhZL8fYHqnJ49uHQ00Q2zgslFVyq4=;
 b=/KZC47d8Z04sIU1kISLOTG/IdGH6I4BYTV+cobAOjhJsOIxf96YpHxsmKj877FKDQxdtZp
 EVXKhmLatP1srhCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B781D1348C;
 Fri,  3 Nov 2023 15:31:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id G72xK0QSRWXILwAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 03 Nov 2023 15:31:16 +0000
Message-ID: <5abef64d-a070-45c4-9cfb-44ff996febae@suse.cz>
Date: Fri, 3 Nov 2023 16:31:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Marius Kittler <mkittler@suse.de>, ltp@lists.linux.it
References: <20231103105339.21435-1-mkittler@suse.de>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 xsFNBF1D6M0BEAC5BHC0NuN/v+UBXDYuwuYeAJA4leuKz0H76YBevziJKUtnzMsBA+GT9vdH
 bs60wdsTbBJ1XqmQ/HWDPBV0OIGox195GSZQFblKOY1YoFXV6cv9Kyw4LyYeqozRhGx8NuE8
 +qC62nuV97k7GgiDE8onWfPd7wsLBdavZO7qgxRTqbjnf/hReHCPqcts3QEYaLaL5eCfW9gY
 6m8wGuF3k7xg7z591dkI7Xfu5rB5IhFcZGLIc+Q1RNEYz+OBP+MnNUSrGPdbFOIgd2jyYRFR
 npj+OkrPFaZvteQvj8GCwPv/HIStRM9gW6RTGIVw2fTMGGCQb2Jp7Fq51GkKIECRnlhQVJ11
 CIndtWP8p2NoxcWA0GH1Y1jjWcV+YvbtflFTQAwsJ5wIiZYvaHhN8VQlS5o1wCjSjPSAzlId
 XaN3BqM0w2su/dH9EqVZsGee04U2ZqNfrRmGfUICW6XDZRP2ozlJEKHNO0ZZqRt5bjFaelAf
 X1MgkyDFUikAkstZ6MErt89DlegUNo6GQqAYtk5675HXUbIND0l9foKGvAjuPA+xf3is2Uqj
 XC5+DtswSOh3UV+3I8QEB1nTnq1qq9yswbT0vrnwiRw0F4jNCsbSXkTUeIb+kcJp10Ov4TeM
 4jzV1tNtinI3U9eB4sMj165EAFO4B25/6e7c0jFDHVvwcOZKZQARAQABzR9NYXJ0aW4gRG91
 Y2hhIDxtZG91Y2hhQHN1c2UuY3o+wsGUBBMBCAA+FiEEFQyxgp89HCoFzxM584srZkRBd9kF
 Al1D6M0CGyMFCQlmAYAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQ84srZkRBd9lXJw//
 d/9S4ZYfjqAlZnVVsr6lKxkZ9bpK5HafnPITkNVmAsOTFndUAwyu2TEGCv5yedGfedFOcFy7
 JWdDhqNkPg2xLUhEf37T/rmoWxW7PrLKx+D1ewiSIyfFAQQBJD/6RjTLfRPUQQLCEyZ31Y50
 6xoGMx21YM2jq7RByKzYR01Bs5u96av5kGR5wNqb2jh/E0Fo1jiPvLSn7HKYY0UEjOEafkmj
 mfUnlBKwbHBbHOOegNlGPHMdil4RlaxRufL6OgSdKM0Dk81ctlUK3C2prmEAN9hPpwi/aDfP
 IcfJ6GN3EMaMPmfCr1YavuD3bGfyIU7bjUyPQfADbFFybPJ2BLVc0T9qAQqI7r2nkI99zqTC
 Cd7bZYXvNVgUTKtxhapsZ++1+UI7XJ6rwmS5kmE56bNugIXrB+84ROoqlWp4ZHZ2Bm5b96o8
 uiDcCKfoj+bh9PAdGPqaL3GCAKyP6ApbEIU5FQLawTdVBCeINNplLjePnZ6aY/LTny8fOZpp
 FJwP6+TuEOzXLOKgtfVDWW5mpyxQhSw+hES1o+IqTY8UN1vCSw6EwuFRA3fpMkC5L38sL0EE
 3gAh1+CT1krfE3pdL+pL3LAJc2DJXc14mF1DH2hdz0Dy8yucc76ypHqJAHPgPc+qidYq3b09
 EpWloNx1yZ1YH/UtEx+TtJBo0fvPhrABbG3OwU0EXUPozQEQAL81/TIX7o/+C+8SnyIHm71Z
 e0dDpXXREkQMmrrYbLE7DiFpXK+1JVm39mESmEIIZORyMVGLkG49wXsfTxVkFdk4IRjRNyXz
 wSkzo7CF1ORC4Jo0CtumNDyIU464uDHdK91AOWW2OwlTfcsUgA5PKM3w4HPbc4MBd/u6YX5Q
 8HSBWbLrxNE59BBbyUBFeLiLzr0afnyvPPYc2nMIw8TxcA1UfsQz1uBHq8XE2/XjoSUoThhB
 qGdQlWWRGBI/rElz7IJhwbRx+cw5Lgxc9JRG63gelMGLHHAgRiTrajalJXJQA9oDDUk/Qunc
 2wh2MkUafJfvOR4U1YM+dTCc78+xSuG57/aatdkI1iRuyJbkM1MfvSVnmWr69JytGc/ZlDCm
 CdwV8OCTX7zZL+1xfQXBSmuHkbe68j3Mk41ZWegi95RAu5mCvCeDjv2ki+Snez4p3USkY0R4
 lVDKNnmCy9ZZrR/YHXgj+sDi2hRB05VT27NayMWB8ywMuD1bxV93NhZKx3/JliQyCDg9fUBc
 5aLG51Has+y16AdcN8XYeFAOL8K/36PNeTAS4vlYZPPiIja4fD/VUswO8jns713ZxTWPou+v
 0pV/5jykprWwIy+jNv6Dbor/JKjcG0GxnHb8U0xMIFv4/DIqzOG1pkERR+Hmg7YvpIlVokfo
 Hkvu5qs5xOrzABEBAAHCwXwEGAEIACYWIQQVDLGCnz0cKgXPEznziytmREF32QUCXUPozQIb
 DAUJCWYBgAAKCRDziytmREF32XWvD/0fuW2SC3dOOk1XhHua2JOezT1HQpxyFpCNPESRoL8N
 J1PCMyDWO4l7NhsAGbqCfA6a7XpsYpD3VC8kIZk/P3JOFM11OSUszK/pSUdiKuaURy6TAxFZ
 3FO9OZ016uJuBQ8J9qdpvcGRtNnyL9gOmvSWkUV4mHokJeQ4CFWV5A38vg1EGpR49UOm6RhH
 LDyXxng1uJ58RuaXRAUvM/RG0vg7O2+4TP/IelhKGIYtNc4louyPZEAjaXJ3eNt4Selo5RFe
 uCl8/k6dNvUc3ZWUxd5CISdwn0GsVbCBnpYDhPgoCEbP30Sr+Jdo8asicZ3XUhQ0aPFLb7D0
 IMfRwEkXUK0LvwnBJ2hTtLZRxrqusibeRSj14j0xAuEsDZD3VbMD7fnlTDSyjdY0ghHygq/5
 YchPWWq+T2P32r/hxymkw0EiQptA13TElxj13Pbc2hP+e0SoEKFkHfyb63rik3dlPmxGk5eM
 Rz4zFhW8KQ9+zrae5rL/6vwz3d/MpEeOmDm9uutE6xyzXRl/RxeFZ8P7KlACXWm7VjSyc74E
 eCNL6GOOeqzE77fDcBf4HvNGn8w7IX/FvNzmu78wzT2MDwMi8ug8T4KEKzIYUIRibe7cl0LG
 2dSj02pOT7E5/x4gKQB/OZqnTTQxJ0OL8BJKNFeSYqaMzKFKiYaArwuFkGnCknwh5A==
In-Reply-To: <20231103105339.21435-1-mkittler@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Extend ioctl02 to test termio and termios
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
Reviewed-by: Martin Doucha <mdoucha@suse.cz>

On 03. 11. 23 11:53, Marius Kittler wrote:
> Testing the behavior of both sets of ioctl commands at the same time is
> challenging because they use different structures. This change tries to
> minimize the amount of code duplication (it is not fully possible) and to
> minimize the amount of macro code (it is not fully avoidable).
> 
> To ease this, this change simplifies the checks:
> * Create a separate function and macro for checking attributes
> * Remove useless nested condition in loop for checking the control
>    characters
>      * The loop condition is `i < NCC` and the nested condition was
>        `i == VEOL2`. The nested condition is completely useless because it
>        is never reached because `VEOL2 > NCC`.
>      * The same applies to the loop for initializing the structs.
>      * This change introduces use of termios (where `VEOL2 < NCCS`) but
>        extra handling for `VEOL2` can still be avoided.
> * Implement the check for control characters in terms of the normal
>    attribute check
> 
> Signed-off-by: Marius Kittler <mkittler@suse.de>
> ---
>   testcases/kernel/syscalls/ioctl/ioctl02.c | 191 +++++++++++++---------
>   1 file changed, 118 insertions(+), 73 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl02.c b/testcases/kernel/syscalls/ioctl/ioctl02.c
> index 8c6924386..1271a252d 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl02.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl02.c
> @@ -8,26 +8,28 @@
>   /*\
>    * [Description]
>    *
> - * Testcase to test the TCGETA, and TCSETA ioctl implementations for
> - * the tty driver
> + * Testcase to test the TCGETA/TCGETS, and TCSETA/TCSETS ioctl
> + * implementations for the tty driver
>    *
>    * In this test, the parent and child open the parentty and the childtty
>    * respectively.  After opening the childtty the child flushes the stream
>    * and wakes the parent (thereby asking it to continue its testing). The
> - * parent, then starts the testing. It issues a TCGETA ioctl to get all
> - * the tty parameters. It then changes them to known values by issuing a
> - * TCSETA ioctl. Then the parent issues a TCGETA ioctl again and compares
> - * the received values with what it had set earlier. The test fails if
> - * TCGETA or TCSETA fails, or if the received values don't match those
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
>   #include <stdio.h>
>   #include <stdlib.h>
>   #include <fcntl.h>
>   #include <errno.h>
> +#include <sys/ioctl.h>
>   #include <sys/wait.h>
>   #include <sys/types.h>
>   #include <sys/stat.h>
> @@ -39,22 +41,54 @@
>   #include "tst_test.h"
>   #include "tst_safe_macros.h"
>   
> -static struct termio termio, save_io;
> +static struct termio termio, termio_exp;
> +static struct termios termios, termios_exp, termios_bak;
>   
>   static char *parenttty, *childtty;
>   static int parentfd = -1;
>   static int parentpid, childpid;
>   
>   static void do_child(void);
> +static void prepare_termio(void);
>   static void run_ptest(void);
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
> +	void *termio, *termio_exp, *termio_bak;
> +	size_t termio_size;
> +	void (*check)(void);
> +	int tcget, tcset;
> +} variants[] = {
> +	{
> +		.name = "termio",
> +		.termio = &termio,
> +		.termio_exp = &termio_exp,
> +		.termio_size = sizeof(termio),
> +		.check = &chk_tty_parms_termio,
> +		.tcget = TCGETA,
> +		.tcset = TCSETA,
> +	},
> +	{
> +		.name = "termios",
> +		.termio = &termios,
> +		.termio_exp = &termios_exp,
> +		.termio_size = sizeof(termios),
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
> @@ -73,99 +107,107 @@ static void verify_ioctl(void)
>   	run_ptest();
>   
>   	TST_CHECKPOINT_WAKE(0);
> +	SAFE_CLOSE(parentfd);
>   }
>   
> -/*
> - * run_ptest() - setup the various termio structure values and issue
> - *		 the TCSETA ioctl call with the TEST macro.
> - */
> -static void run_ptest(void)
> +static void prepare_termio(void)
>   {
>   	/* Use "old" line discipline */
> -	termio.c_line = 0;
> +	termios_exp.c_line = termio_exp.c_line = 0;
>   
>   	/* Set control modes */
> -	termio.c_cflag = B50 | CS7 | CREAD | PARENB | PARODD | CLOCAL;
> +	termios_exp.c_cflag = termio_exp.c_cflag = B50 | CS7 | CREAD | PARENB | PARODD | CLOCAL;
>   
>   	/* Set control chars. */
> -	for (int i = 0; i < NCC; i++) {
> -		if (i == VEOL2)
> -			continue;
> -		termio.c_cc[i] = CSTART;
> -	}
> +	for (int i = 0; i < NCC; i++)
> +		termio_exp.c_cc[i] = CSTART;
> +	for (int i = 0; i < VEOL2; i++)
> +		termios_exp.c_cc[i] = CSTART;
>   
>   	/* Set local modes. */
> -	termio.c_lflag =
> +	termios_exp.c_lflag = termio_exp.c_lflag =
>   	    ((unsigned short)(ISIG | ICANON | XCASE | ECHO | ECHOE | NOFLSH));
>   
>   	/* Set input modes. */
> -	termio.c_iflag =
> +	termios_exp.c_iflag = termio_exp.c_iflag =
>   	    BRKINT | IGNPAR | INPCK | ISTRIP | ICRNL | IUCLC | IXON | IXANY |
>   	    IXOFF;
>   
>   	/* Set output modes. */
> -	termio.c_oflag = OPOST | OLCUC | ONLCR | ONOCR;
> +	termios_exp.c_oflag = termio_exp.c_oflag = OPOST | OLCUC | ONLCR | ONOCR;
> +}
>   
> -	SAFE_IOCTL(parentfd, TCSETA, &termio);
> +/*
> + * run_ptest() - setup the various termio/termios structure values and issue
> + * the TCSETA/TCSETS ioctl call with the TEST macro.
> + */
> +static void run_ptest(void)
> +{
> +	struct variant *v = &variants[tst_variant];
> +
> +	/* Init termio/termios structures used to check if all params got set */
> +	memset(v->termio, 0, v->termio_size);
> +
> +	SAFE_IOCTL(parentfd, v->tcset, v->termio_exp);
>   
>   	/* Get termio and see if all parameters actually got set */
> -	SAFE_IOCTL(parentfd, TCGETA, &termio);
> -	chk_tty_parms();
> +	SAFE_IOCTL(parentfd, v->tcget, v->termio);
> +	v->check();
>   }
>   
> -static void chk_tty_parms(void)
> +static int cmp_attr(unsigned long long exp, unsigned long long act, const char *attr)
>   {
> -	int i, flag = 0;
> +	if (act == exp)
> +		return 0;
> +	tst_res(TFAIL, "%s has incorrect value %llu, expected %llu",
> +		attr, act, exp);
> +	return 1;
> +}
>   
> -	if (termio.c_line != 0) {
> -		tst_res(TFAIL, "line discipline has incorrect value %o",
> -			 termio.c_line);
> -		flag++;
> -	}
> +static int cmp_c_cc(unsigned char *exp_c_cc, unsigned char *act_c_cc, int ncc)
> +{
> +	int i, fails = 0;
> +	char what[32];
>   
> -	for (i = 0; i < NCC; i++) {
> -		if (i == VEOL2) {
> -			if (!termio.c_cc[i]) {
> -				continue;
> -			} else {
> -				tst_res(TFAIL, "control char %d has "
> -					 "incorrect value %d", i, termio.c_cc[i]);
> -				flag++;
> -				continue;
> -			}
> -		}
> -
> -		if (termio.c_cc[i] != CSTART) {
> -			tst_res(TFAIL, "control char %d has incorrect "
> -				 "value %d.", i, termio.c_cc[i]);
> -			flag++;
> -		}
> +	for (i = 0; i < ncc; ++i) {
> +		sprintf(what, "control char %d", i);
> +		fails += cmp_attr(exp_c_cc[i], act_c_cc[i], what);
>   	}
> +	return fails;
> +}
>   
> -	if (termio.c_lflag != (ISIG | ICANON | XCASE | ECHO | ECHOE
> -		 | NOFLSH)) {
> -		tst_res(TFAIL, "lflag has incorrect value. %o",
> -			 termio.c_lflag);
> -		flag++;
> -	}
> +#define CMP_ATTR(term_exp, term, attr) \
> +	(flag += cmp_attr((term_exp).attr, (term).attr, #attr))
>   
> -	if (termio.c_iflag != (BRKINT | IGNPAR | INPCK | ISTRIP
> -		 | ICRNL | IUCLC | IXON | IXANY | IXOFF)) {
> -		tst_res(TFAIL, "iflag has incorrect value. %o",
> -			 termio.c_iflag);
> -		flag++;
> -	}
> +#define CMP_C_CC(term_exp, term) \
> +	(flag += cmp_c_cc(term_exp.c_cc, term.c_cc, sizeof(term.c_cc)))
>   
> -	if (termio.c_oflag != (OPOST | OLCUC | ONLCR | ONOCR)) {
> -		tst_res(TFAIL, "oflag has incorrect value. %o",
> -			 termio.c_oflag);
> -		flag++;
> -	}
> +static void chk_tty_parms_termio(void)
> +{
> +	int flag = 0;
>   
> +	CMP_ATTR(termio_exp, termio, c_line);
> +	CMP_C_CC(termio_exp, termio);
> +	CMP_ATTR(termio_exp, termio, c_lflag);
> +	CMP_ATTR(termio_exp, termio, c_iflag);
> +	CMP_ATTR(termio_exp, termio, c_oflag);
>   	if (!flag)
>   		tst_res(TPASS, "TCGETA/TCSETA tests");
>   }
>   
> +static void chk_tty_parms_termios(void)
> +{
> +	int flag = 0;
> +
> +	CMP_ATTR(termios_exp, termios, c_line);
> +	CMP_C_CC(termios_exp, termios);
> +	CMP_ATTR(termios_exp, termios, c_lflag);
> +	CMP_ATTR(termios_exp, termios, c_iflag);
> +	CMP_ATTR(termios_exp, termios, c_oflag);
> +	if (!flag)
> +		tst_res(TPASS, "TCGETS/TCSETS tests");
> +}
> +
>   static void do_child(void)
>   {
>   	int cfd = SAFE_OPEN(childtty, O_RDWR, 0777);
> @@ -187,14 +229,16 @@ static void setup(void)
>   
>   	int fd = SAFE_OPEN(device, O_RDWR, 0777);
>   
> -	SAFE_IOCTL(fd, TCGETA, &save_io);
> +	SAFE_IOCTL(fd, TCGETS, &termios_bak);
>   	SAFE_CLOSE(fd);
> +
> +	prepare_termio();
>   }
>   
>   static void cleanup(void)
>   {
>   	if (parentfd >= 0) {
> -		SAFE_IOCTL(parentfd, TCSETA, &save_io);
> +		SAFE_IOCTL(parentfd, TCSETS, &termios_bak);
>   		SAFE_CLOSE(parentfd);
>   	}
>   }
> @@ -206,6 +250,7 @@ static struct tst_test test = {
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
