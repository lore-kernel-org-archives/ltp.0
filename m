From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 21 Dec 2015 10:20:09 +0300
Subject: [LTP] [PATCH v2] hugetlb: add new testcase hugeshmat05.c
In-Reply-To: <1450234786-12997-1-git-send-email-liwang@redhat.com>
References: <1450234786-12997-1-git-send-email-liwang@redhat.com>
Message-ID: <5677A829.6020804@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 12/16/2015 05:59 AM, Li Wang wrote:
> shmget()/shmat() fails to allocate huge pages shared memory segment
> with EINVAL if its size is not in the range [ N*HUGE_PAGE_SIZE - 4095,
> N*HUGE_PAGE_SIZE ]. This is a problem in the memory segment size round
> up algorithm. The requested size is rounded up to PAGE_SIZE (4096), but
> if this roundup does not match HUGE_PAGE_SIZE (2Mb) boundary - the
> allocation fails.
>
> This bug is present in all RHEL6 versions, but not in RHEL7. It looks
> like this was fixed in mainstream kernel > v3.3 by the following patches:
>
> 091d0d5 shm: fix null pointer deref when userspace specifies invalid hugepage size
> af73e4d hugetlbfs: fix mmap failure in unaligned size request
> 42d7395 mm: support more pagesizes for MAP_HUGETLB/SHM_HUGETLB
> 40716e2 hugetlbfs: fix alignment of huge page requests
>
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>
> Notes:
>      v1 --> v2
>      a.remove the key value from shmget()
>      b.improve the brk messages
>      c.just use one loop in the main function
>
>   runtest/hugetlb                                    |   1 +
>   testcases/kernel/mem/.gitignore                    |   1 +
>   .../kernel/mem/hugetlb/hugeshmat/hugeshmat05.c     | 136 +++++++++++++++++++++
>   3 files changed, 138 insertions(+)
>   create mode 100644 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c
>
> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index 2e9f215..75e6426 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -10,6 +10,7 @@ hugeshmat01 hugeshmat01 -i 5
>   hugeshmat02 hugeshmat02 -i 5
>   hugeshmat03 hugeshmat03 -i 5
>   hugeshmat04 hugeshmat04 -i 5
> +hugeshmat05 hugeshmat05 -i 5

Did you forget to increase iterations here or it is not needed anymore?
In the first patch, if I am not mistaken, was 15 (because of two loops).

>   
>   hugeshmctl01 hugeshmctl01 -i 5
>   hugeshmctl02 hugeshmctl02 -i 5
...
> +
> +int main(int ac, char **av)
> +{
> +	int lc;
> +
> +	tst_parse_opts(ac, av, NULL, NULL);
> +
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		tst_count = 0;
> +
> +		/* N*hpage_size - page_size FAIL */
> +		shm_test(N * hpage_size - page_size);
> +
> +		/* N*hpage_size - page_size - 1 SUCCESS*/
> +		shm_test(N * hpage_size - page_size - 1);
> +
> +		/* N*hpage_size  SUCCESS */
> +		shm_test(N * hpage_size);
> +
> +		/* N*hpage_size + 1 FAIL */

Could you please add more informative comments (may be explaining why it 
is "FAIL"/"SUCCESS")
or remove them completely, they just repeat what is passed to the function.

We could also set sizes in array, defining it before the "for":

const int tst_sizes[] = { N * hpage_size - page_size,
                                             N * hpage_size, ... };

for (lc ...) {
     tst_count = 0;
     for(i = 0; i < ARRAY_SIZE(tst_sizes); ++i)
         shm_test(tst_sizes[i]);
}


Best regards,
Alexey
> +		shm_test(N * hpage_size + 1);
> +
> +		tst_resm(TPASS, "No regression found.");
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}

