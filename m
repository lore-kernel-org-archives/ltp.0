From: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date: Mon, 2 Mar 2020 15:12:18 +0800
Subject: [LTP] [PATCHv2 1/3] zram/zram_lib.sh: fix variable name and
 algorithm retrieval
In-Reply-To: <20200221055936.GA13261@dell5510>
References: <20190710072305.25806-1-po-hsu.lin@canonical.com>
 <20190710072305.25806-2-po-hsu.lin@canonical.com>
 <20200221055936.GA13261@dell5510>
Message-ID: <CAMy_GT9VC5KvgCL68fVXVfKwErwKqiNab0s8SwPw9BZxMuLReg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Petr,

thanks for the reply, and sorry for the late response too, need some
time to throw myself back in time.

To my understanding, the zram_algs="lzo lzo lzo lzo" in zram01.sh is a
dummy mapping (placeholder?) for 4 compression algorithms with 4
different setup, one for (zram_sizes=26214400, zram_mem_limits=25M,
zram_filesystems=ext3), and one for (zram_sizes=26214400,
zram_mem_limits=25M, zram_filesystems=ext4) and so on.

With this patch the test will be more comprehensive, as it's not
trying to set the algorithm to "lzo" 4 times (as defined in zram_algs
from zram01.sh), but try to switch to all supported algorithm reported
back from  /sys/block/zram0/comp_algorithm

So yes, this zram_algs in zram01.sh will not be used at all after
applying my patch here, maybe it can be removed but I am not sure if
we should keep it there as a placeholder.

Cheers


On Fri, Feb 21, 2020 at 1:59 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi,
>
> > The compression algorithm was stored into a local variable "algs",
> > however the variable name zram_algs was used in the for loop later.
>
> > Unify them with algs so the default zram_algs defined in zram01 won't
> > be altered.
>
> > Also, use sed to get rid of the square brackets that indicates the
> > compression algorithm currently in use.
> >     $ cat /sys/block/zram0/comp_algorithm
> >     [lzo] lz4 lz4hc 842 zstd
>
> > Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
> > ---
> >  testcases/kernel/device-drivers/zram/zram_lib.sh | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> > diff --git a/testcases/kernel/device-drivers/zram/zram_lib.sh b/testcases/kernel/device-drivers/zram/zram_lib.sh
> > index d0e7704a8..599e5f0f3 100755
> > --- a/testcases/kernel/device-drivers/zram/zram_lib.sh
> > +++ b/testcases/kernel/device-drivers/zram/zram_lib.sh
> > @@ -98,10 +98,10 @@ zram_compress_alg()
>
> >       tst_resm TINFO "test that we can set compression algorithm"
>
> > -     local algs="$(cat /sys/block/zram0/comp_algorithm)"
> > +     local algs="$(sed 's/[][]//g' /sys/block/zram0/comp_algorithm)"
> >       tst_resm TINFO "supported algs: $algs"
> >       local i=0
> > -     for alg in $zram_algs; do
> > +     for alg in $algs; do
> >               local sys_path="/sys/block/zram${i}/comp_algorithm"
> >               echo "$alg" >  $sys_path || \
> >                       tst_brkm TFAIL "can't set '$alg' to $sys_path"
>
> Sorry for a late reply.
>
> What is the purpose of zram_algs="lzo lzo lzo lzo in zram01.sh?
> It should be removed now, right? (as you decided not to set the algorithms to the ones defined in the zram01.sh
> test at the end of this function as Cyril suggested at [1]
>
> Kind regards,
> Petr
>
> [1] http://lists.linux.it/pipermail/ltp/2019-July/012674.html
