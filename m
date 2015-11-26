From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 26 Nov 2015 11:47:40 +0300
Subject: [LTP] [PATCH v2] hugetlb: checking if hugepage is supported on
 target system
In-Reply-To: <1448506629-12150-1-git-send-email-liwang@redhat.com>
References: <1448506629-12150-1-git-send-email-liwang@redhat.com>
Message-ID: <5656C72C.4090203@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 11/26/2015 05:57 AM, Li Wang wrote:
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
...
> -	if (write(fd, nr_hugepages,
> +	if ((unsigned int)write(fd, nr_hugepages,
>   		  strlen(nr_hugepages)) != strlen(nr_hugepages))
>   		tst_resm(TWARN | TERRNO, "write");
>   	close(fd);
> @@ -271,7 +270,7 @@ static void cleanup(void)
>   		tst_resm(TWARN | TERRNO, "open");
>   	tst_resm(TINFO, "restore nr_overcommit_hugepages to %s.",
>   		 nr_overcommit_hugepages);
> -	if (write(fd, nr_overcommit_hugepages, strlen(nr_overcommit_hugepages))
> +	if ((unsigned int)write(fd, nr_overcommit_hugepages, strlen(nr_overcommit_hugepages))
>   	    != strlen(nr_overcommit_hugepages))

It would be better to use ssize_t, that way you won't exceed 80c per 
line as well.

if (write(fd, nr_overcommit_hugepages, strlen(nr_overcommit_hugepages))
  	    != (ssize_t)strlen(nr_overcommit_hugepages))


>   		tst_resm(TWARN | TERRNO, "write");
>   	close(fd);
> @@ -287,7 +286,7 @@ static void cleanup(void)
>   	tst_rmdir();
>   }
>   
> -static void setup(void)
> +void setup(void)

forgot "static"?

...
>   
> diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
> index 215c052..84af3ce 100644
> --- a/testcases/kernel/mem/lib/mem.c
> +++ b/testcases/kernel/mem/lib/mem.c
> @@ -314,6 +314,12 @@ static void verify(char **memory, char value, int proc,
>   	free(s);
>   }
>   
...
> +	if (access(PATH_HUGEPAGES, F_OK) == -1)
Could be
if (access(PATH_HUGEPAGES, F_OK))
        tss_brkm(...);

> +		tst_brkm(TCONF, NULL, "Huge page is not supported.");
> +
>   	tst_tmpdir();
>   
>   	SAFE_FILE_SCANF(NULL, PATH_NR_HUGEPAGES, "%ld", &orig_hugepages);

Thanks,
Alexey
