From: Li Wang <liwang@redhat.com>
Date: Thu, 14 Dec 2017 15:02:41 +0800
Subject: [LTP] [PATCH] iocatl: add two receive mode checking for TUN/TAP
	driver
In-Reply-To: <20171214061258.29174-1-liwang@redhat.com>
References: <20171214061258.29174-1-liwang@redhat.com>
Message-ID: <CAEemH2cYSHcaL=1hJAuv=LbEYA-SViaTpPmxOSFb8FSyLtuQmA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Ah, seems IFF_NAPI and IFF_NAPI_FRAGS should also be defined in order
to compile pass on old kernel version.

So please ignore this patch, and I'm going to re-write the case in new
LTP library.


On Thu, Dec 14, 2017 at 2:12 PM, Li Wang <liwang@redhat.com> wrote:
> IFF_NAPI(1) and IFF_NAPI_FRAGS(2) are two new flags for TUN/TAP
> driver, but currently ioctl03 does not hanlde them so it always
> failed on latest kernel-4.15.0-rc2 like:
>
> ioctl03     0  TINFO  :  Available features are: 0x7133
> ioctl03     0  TINFO  :  TUN 0x1
> ioctl03     0  TINFO  :  TAP 0x2
> ioctl03     0  TINFO  :  NO_PI 0x1000
> ioctl03     0  TINFO  :  ONE_QUEUE 0x2000
> ioctl03     0  TINFO  :  VNET_HDR 0x4000
> ioctl03     0  TINFO  :  MULTI_QUEUE 0x100
> ioctl03     1  TFAIL  :  ioctl03.c:114: (UNKNOWN 0x30)
>
> See kernel commit:
> (1) commit 943170998b2 (tun: enable NAPI for TUN/TAP driver)
> (2) commit 90e33d45940 (tun: enable napi_gro_frags() for TUN/TAP driver)
>
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  testcases/kernel/syscalls/ioctl/ioctl03.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl03.c b/testcases/kernel/syscalls/ioctl/ioctl03.c
> index 83433b8..7ed9aa2 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl03.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl03.c
> @@ -84,7 +84,9 @@ static struct {
>         IFF_NO_PI, "NO_PI"}, {
>         IFF_ONE_QUEUE, "ONE_QUEUE"}, {
>         IFF_VNET_HDR, "VNET_HDR"}, {
> -       IFF_MULTI_QUEUE, "MULTI_QUEUE"}
> +       IFF_MULTI_QUEUE, "MULTI_QUEUE"}, {
> +       IFF_NAPI, "IFF_NAPI"}, {
> +       IFF_NAPI_FRAGS, "IFF_NAPI_FRAGS"}
>  };
>
>  int main(void)
> --
> 2.9.3
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp



-- 
Li Wang
liwang@redhat.com
