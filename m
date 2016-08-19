From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 19 Aug 2016 14:22:32 +0300
Subject: [LTP] [PATCH] network/nfs05_make_tree: Pass -D_GNU_SOURCE to
 enable O_DIRECTORY
In-Reply-To: <1471542167-5118-1-git-send-email-yuriy.kolerov@synopsys.com>
References: <1471542167-5118-1-git-send-email-yuriy.kolerov@synopsys.com>
Message-ID: <57B6EBF8.1060407@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 08/18/2016 08:42 PM, Yuriy Kolerov wrote:
> This test uses O_DIRECTORY macro and in some standard libraries it
> may be defined only if _GNU_SOURCE is enabled.
>
> Signed-off-by: Yuriy Kolerov <yuriy.kolerov@synopsys.com>
> ---
>   testcases/network/nfs/nfs_stress/Makefile | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/testcases/network/nfs/nfs_stress/Makefile b/testcases/network/nfs/nfs_stress/Makefile
> index 3162cea..2fde4cb 100644
> --- a/testcases/network/nfs/nfs_stress/Makefile
> +++ b/testcases/network/nfs/nfs_stress/Makefile
> @@ -20,6 +20,7 @@ include $(top_srcdir)/include/mk/testcases.mk
>   
>   nfs04_create_file: CPPFLAGS += -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE
>   nfs05_make_tree: LDLIBS += -lpthread
> +nfs05_make_tree: CPPFLAGS += -D_GNU_SOURCE

Right, but the preferred way is to define this macro in the source file, 
before any #include.
Could you make a new patch with the fix in nfs05_make_tree.c?

Thanks,
Alexey

