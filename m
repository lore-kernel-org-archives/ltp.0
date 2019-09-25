From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 25 Sep 2019 15:56:34 +0200
Subject: [LTP] [PATCH] syscalls/acct02: Check read size.
In-Reply-To: <20190925094721.18932-1-chrubis@suse.cz>
References: <20190925094721.18932-1-chrubis@suse.cz>
Message-ID: <20190925135634.GA32581@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> This is just a minor adjustements that checks that we get correct size
> from read before we attempt to validate the data we read in order to
> print more meaningful failure message.

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

>  testcases/kernel/syscalls/acct/acct02.c | 16 ++++++++++++++--
...
>  	do {
> -		tst_res(TINFO, "== entry %d ==", ++i);
> -
>  		read_bytes = SAFE_READ(0, fd, &acct_struct, acct_size);

> +		if (i == 0 && read_bytes == 0) {
> +			tst_res(TFAIL, "acct file is empty");
> +			goto exit;
> +		}
> +
> +		if (read_bytes != acct_size) {
> +			tst_res(TFAIL, "incomplete read %i bytes, expected %i",
> +			        read_bytes, acct_size);
> +			goto exit;
> +		}
> +
> +		tst_res(TINFO, "== entry %d ==", ++i);
> +
>  		if (v3)
>  			ret = verify_acct(&acct_struct.v3, acct_struct.v3.ac_etime);
>  		else
> @@ -192,6 +203,7 @@ static void run(void)
>  	else
>  		tst_res(TPASS, "acct() wrote correct file contents!");

> +exit:
>  	SAFE_CLOSE(fd);
>  }

OK, on s390 where it's failing it actually catches "incomplete read":

tst_kconfig.c:62: INFO: Parsing kernel config '/proc/config.gz'
tst_test.c:1118: INFO: Timeout per run is 0h 05m 00s
tst_kconfig.c:62: INFO: Parsing kernel config '/proc/config.gz'
acct02.c:234: INFO: Verifying using 'struct acct_v3'
acct02.c:187: INFO: == entry 1 ==
acct02.c:147: INFO: ac_version != 3 (131)
acct02.c:187: INFO: == entry 2 ==
acct02.c:82: INFO: ac_comm != 'acct02_helper' ('acct02')
acct02.c:133: INFO: ac_exitcode != 32768 (0)
acct02.c:141: INFO: ac_ppid != 54783 (54781)
acct02.c:147: INFO: ac_version != 3 (131)
acct02.c:183: FAIL: incomplete read 0 bytes, expected 64

Kind regards,
Petr
