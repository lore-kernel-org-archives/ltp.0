From: Li Wang <liwang@redhat.com>
Date: Fri, 19 Jun 2020 16:33:28 +0800
Subject: [LTP] [PATCH] syscalls/copy_file_range02: Expect EFBIG in
 subcase max length on 32-bit architectures
In-Reply-To: <20200618091827.4143850-1-zhe.he@windriver.com>
References: <20200618091827.4143850-1-zhe.he@windriver.com>
Message-ID: <CAEemH2eCv=rSvbM=G2dr2OxW0CodbXJmasmVUVTCKCofEAOVJQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Jun 18, 2020 at 5:21 PM <zhe.he@windriver.com> wrote:

> From: He Zhe <zhe.he@windriver.com>
>
> For syscall
> ssize_t copy_file_range(int fd_in, loff_t *off_in,
>                                int fd_out, loff_t *off_out,
>                                size_t len, unsigned int flags);
> off_out is loff_t* that is long long, 64 bits on 32-bit architectures,
> while len is size_t that unsigned int, 32 bits on 32-bit architectures.
>
> In subcase "max length", simplified as below,
>
> dst = tst_max_lfs_filesize();
> TEST(sys_copy_file_range(fd_src, 0, *tc->copy_to_fd, &dst, tc->len,
> tc->flags));
>
> where dst is 4K*4G and len is 4G, so (4K+1)*4G is always smaller than
> 4G*4G,
> it can never match the following kernel condition on 32-bit architectures.
>

Thanks for fixing this, pushed.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200619/11fd4ada/attachment.htm>
