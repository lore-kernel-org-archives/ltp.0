From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 25 Oct 2019 13:15:03 +0300
Subject: [LTP] [PATCH] syscalls/copy_file_range02: skip new error tests
 if cross-fs isn't supported
In-Reply-To: <20191025083738.GA13022@x230>
References: <1571968780-4810-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20191025083738.GA13022@x230>
Message-ID: <CAOQ4uxiV56cNFXoJp4qYjoCDQ2pFEn8G9mgV_j8pMG2LkC=vfg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Oct 25, 2019 at 11:37 AM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Xu,
>
> > We should not skip the whole error test if cross-fs isn't support because
> > old errors should be tested on all version. Even we use .mount_device = 1
> > and .mntpoint = MNTPOINT, the src and dest file are still in tmp directory
> > instead of mntpoint.
>
> > ps: I doubt whether we should skip new error test because it indeed exposed this
> > unreasonable copy_file_range behavior of the user.
>
> > Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Tested-by: Petr Vorel <pvorel@suse.cz>
>
> LGTM, but I'd like to have Amir's review/ack.
>

ACK. I'm fine with the test code.
If you tested it and it passed on both new and old kernel,
it's fine by me.

Thanks,
Amir.
