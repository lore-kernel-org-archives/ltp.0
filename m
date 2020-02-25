From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 25 Feb 2020 15:25:05 +0100
Subject: [LTP] [PATCH V3 10/10] syscalls/open_tree: New tests
In-Reply-To: <04fc7b57299c4b7f30551840f782c5fb8a424bcd.1582612624.git.viresh.kumar@linaro.org>
References: <cover.1582612624.git.viresh.kumar@linaro.org>
 <04fc7b57299c4b7f30551840f782c5fb8a424bcd.1582612624.git.viresh.kumar@linaro.org>
Message-ID: <20200225142505.GE62318@gacrux.arch.suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> +++ b/testcases/kernel/syscalls/open_tree/open_tree01.c
...
> +static void cleanup(void)
> +{
> +	if (dir_created)
> +		SAFE_RMDIR(OT_MNTPOINT);
> +}
BTW: This might not be needed (whole tmp directory gets deleted after test exits by
the library).

Kind regards,
Petr
