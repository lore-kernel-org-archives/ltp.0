From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 7 Feb 2020 12:19:10 +0100
Subject: [LTP] [PATCH] syscalls/getrandom02: lower bufsize if low on
 entropy
In-Reply-To: <7843cc36a04deb034e9479a139f535e5fa5f3135.1580894017.git.jstancek@redhat.com>
References: <7843cc36a04deb034e9479a139f535e5fa5f3135.1580894017.git.jstancek@redhat.com>
Message-ID: <20200207111910.GB19508@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Some PPC KVM guests accumulate about 1 bit of entropy per second while idle
> and running getrandom02. Which isn't enough and test sporadically fails on
> timeout.
> 
> Adjust the buffer size by looking at entropy_avail. We want to run the test,
> even if all entropy is exhausted, but with smaller buffer we don't set
> as high expectations on how much entropy is generated within default test time.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  testcases/kernel/syscalls/getrandom/getrandom02.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/getrandom/getrandom02.c b/testcases/kernel/syscalls/getrandom/getrandom02.c
> index ee0193df9897..1384fc5f32c0 100644
> --- a/testcases/kernel/syscalls/getrandom/getrandom02.c
> +++ b/testcases/kernel/syscalls/getrandom/getrandom02.c
> @@ -10,6 +10,8 @@
>  #include "lapi/syscalls.h"
>  #include "tst_test.h"
>  
> +#define PROC_ENTROPY_AVAIL "/proc/sys/kernel/random/entropy_avail"
> +
>  static int modes[] = { 0, GRND_RANDOM, GRND_NONBLOCK,
>  		       GRND_RANDOM | GRND_NONBLOCK };
>  
> @@ -37,11 +39,17 @@ static int check_content(unsigned char *buf, int nb)
>  static void verify_getrandom(unsigned int n)
>  {
>  	unsigned char buf[256];
> +	int bufsize = 64, entropy_avail;
>  
> -	memset(buf, 0, sizeof(buf));
> +	if (access(PROC_ENTROPY_AVAIL, F_OK) == 0) {
> +		SAFE_FILE_SCANF(PROC_ENTROPY_AVAIL, "%d", &entropy_avail);
> +		if (entropy_avail > 256)
> +			bufsize = sizeof(buf);
> +	}

Looks good to me, acked.

-- 
Cyril Hrubis
chrubis@suse.cz
