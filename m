From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 6 Apr 2021 15:30:57 +0200
Subject: [LTP] [PATCH] syscalls/getdtablesize01: Add abnormal handling
In-Reply-To: <20210330122041.19700-1-zhaogongyi@huawei.com>
References: <20210330122041.19700-1-zhaogongyi@huawei.com>
Message-ID: <YGxikZJsqr7Knlc8@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> When /etc/hosts is not exist, test would fail, actually, we chould skip the
> the problem to improve maintainability.

...
> +++ b/testcases/kernel/syscalls/getdtablesize/getdtablesize01.c
> @@ -100,6 +100,8 @@ int main(void)
>  		tst_resm(TPASS, "%d = %d", count, (max_val_opfiles - 1));
>  	else if (fd < 0 && errno == ENFILE)
>  		tst_brkm(TCONF, cleanup, "Reached maximum number of open files for the system");
> +	else if (fd == 0)
> +		tst_brkm(TCONF, cleanup, "Maybe /etc/hosts is not exist");
>  	else
>  		tst_resm(TFAIL, "%d != %d", count, (max_val_opfiles - 1));

Why not to test for existence of the file in main(), where is file being opened?

	fd = open("/etc/hosts", O_RDONLY);

Also current patch does not work when I test on system without /etc/hosts:

./getdtablesize01
getdtablesize01    0  TINFO  :  Maximum number of files a process can have opened is 1024
getdtablesize01    0  TINFO  :  Checking with the value returned by getrlimit...RLIMIT_NOFILE
getdtablesize01    1  TPASS  :  got correct dtablesize, value is 1024
getdtablesize01    0  TINFO  :  Checking Max num of files that can be opened by a process.Should be: RLIMIT_NOFILE - 1
getdtablesize01    2  TFAIL  :  getdtablesize01.c:106: 0 != 1023

Besides, it'd help to also rewrite the test to the new API.

Kind regards,
Petr
