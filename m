From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 27 Nov 2015 10:41:01 +0300
Subject: [LTP] [PATCH v3] hugetlb: checking if hugepage is supported on
 target system
In-Reply-To: <1448541356-20580-1-git-send-email-liwang@redhat.com>
References: <1448541356-20580-1-git-send-email-liwang@redhat.com>
Message-ID: <5658090D.6010201@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hi,
On 11/26/2015 03:35 PM, Li Wang wrote:
> Signed-off-by: Li Wang <liwang@redhat.com>
>
> v2 --> v3
> 	1. (unsigned int) ---> (ssize_t)
> 	2. make the check_hugepage() more simply
> ---
>   testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c |  1 +
>   testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c |  2 ++
>   testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c |  1 +
>   

Almost right, we need to include such comments after 3 dash lines ("---").

In case your git version new enough, you can also add them with git 
format-patch --notes, see man git-notes.

Thanks,
Alexey

