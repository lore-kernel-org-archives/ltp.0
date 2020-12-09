From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 9 Dec 2020 12:26:53 +0100
Subject: [LTP] [PATCH v2 3/3] af_alg07: add dynamic bias for ARM
In-Reply-To: <20201204063305.6820-3-liwang@redhat.com>
References: <20201203110616.28302-1-liwang@redhat.com>
 <20201204063305.6820-1-liwang@redhat.com>
 <20201204063305.6820-3-liwang@redhat.com>
Message-ID: <80776321-e6ae-0817-5e9b-d3009922b0cb@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 04. 12. 20 7:33, Li Wang wrote:
> We observed that af_alg07 sporadically failed on hpe-moonshot(aarch64) with
> fixed kernel, but after trying manually we can NOT reproduce it again, one
> possibility is that the FAIL is caused by an unaligned race window between
> two threads, so here add dynamic bias adjustment to see if it helps.
> 
> From Martin Doucha:
> 
> 1) fchownat() returns 0 => fchownat() was called too early or the kernel is vulnerable
> 2) fchwonat() fails with ENOENT => kernel is fixed, print TPASS and exit
> 3) fchownat() fails with EBADF => fchownat() was called too late
> 
> Considering the test does NOT takes too time in 1) so we only adjust
> delay when syscalls return an error state that clearly falls outside
> the race window.
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> CC: Richard Palethorpe <rpalethorpe@suse.com>
> CC: Martin Doucha <mdoucha@suse.cz>
> CC: Joerg Vehlow <lkml@jv-coder.de>
> CC: Chunyu Hu <chuhu@redhat.com>
> CC: Cyril Hrubis <chrubis@suse.cz>

Reviewed-by: Martin Doucha <mdoucha@suse.cz>

> ---
>  testcases/kernel/crypto/af_alg07.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/testcases/kernel/crypto/af_alg07.c b/testcases/kernel/crypto/af_alg07.c
> index 539ebee11..c94bb292f 100644
> --- a/testcases/kernel/crypto/af_alg07.c
> +++ b/testcases/kernel/crypto/af_alg07.c
> @@ -76,6 +76,11 @@ static void run(void)
>  			return;
>  		}
>  
> +		if (TST_RET == -1 && TST_ERR == EBADF) {
> +			tst_fzsync_pair_add_bias(&fzsync_pair, 1);
> +			continue;
> +		}
> +
>  		if (TST_RET == -1 && TST_ERR == ENOENT) {
>  			tst_res(TPASS | TTERRNO,
>  				"fchownat() failed successfully");
> 


-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
