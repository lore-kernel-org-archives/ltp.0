From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Mon, 30 Apr 2018 09:50:09 +0200
Subject: [LTP] [PATCH RESEND] syscalls/swapon03: do not fail if
	/proc/swaps is absent
In-Reply-To: <20180429220615.1206-1-smuckle.linux@gmail.com>
References: <20180429220615.1206-1-smuckle.linux@gmail.com>
Message-ID: <87efixxhe6.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Steve,

Steve Muckle writes:

> If the /proc/swaps file is absent the test should be skipped due
> to incompatible configuration.
>
> Signed-off-by: Steve Muckle <smuckle.linux@gmail.com>
> ---
>  testcases/kernel/syscalls/swapon/swapon03.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/testcases/kernel/syscalls/swapon/swapon03.c b/testcases/kernel/syscalls/swapon/swapon03.c
> index d3f73b044fe1..955ac247b6a2 100644
> --- a/testcases/kernel/syscalls/swapon/swapon03.c
> +++ b/testcases/kernel/syscalls/swapon/swapon03.c
> @@ -328,6 +328,9 @@ static void setup(void)
>  
>  	tst_require_root();
>  
> +	if (access("/proc/swaps", F_OK))
> +		tst_brkm(TCONF, NULL, "swap not supported by kernel");
> +
>  	tst_tmpdir();
>  
>  	switch ((fs_type = tst_fs_type(cleanup, "."))) {

LGTM

-- 
Thank you,
Richard.
