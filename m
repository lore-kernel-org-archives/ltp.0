From: Li Wang <liwang@redhat.com>
Date: Wed, 27 Jan 2021 12:41:03 +0800
Subject: [LTP] [PATCH 2/2] syscalls/ioctl: ioctl_sg01.c:TBROK: Test
 killed!
In-Reply-To: <1611570288-23040-2-git-send-email-liuxp11@chinatelecom.cn>
References: <1611570288-23040-1-git-send-email-liuxp11@chinatelecom.cn>
 <1611570288-23040-2-git-send-email-liuxp11@chinatelecom.cn>
Message-ID: <CAEemH2fCwJhSA=B-Km96NfHE4nkjpUH21cW1iQRfWUGe+k-OJw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Jan 27, 2021 at 11:33 AM Xinpeng Liu <liuxp11@chinatelecom.cn>
wrote:

> [root@test ioctl]# ./ioctl_sg01
> tst_test.c:1263: TINFO: Timeout per run is 0h 05m 00s
> ioctl_sg01.c:81: TINFO: Found SCSI device /dev/sg2
> Test timeouted, sending SIGKILL!
> Test timeouted, sending SIGKILL!
> Test timeouted, sending SIGKILL!
> Test timeouted, sending SIGKILL!
> tst_test.c:1308: TINFO: If you are running on slow machine, try exporting
> LTP_TIMEOUT_MUL > 1
> tst_test.c:1309: TBROK: Test killed! (timeout?)
>
> [root@test ioctl]# lscpu |grep Model
> Model:                 85
> Model name:            Intel(R) Xeon(R) Gold 5218 CPU @ 2.30GHz
>
> [root@test ioctl]# free -h
>       total   used    free   shared  buff/cache   available
> Mem:   502G    2.7G    499G    82M      820M        497G
> Swap:  0B      0B      0B
>
> 512G RAM is too common,so add timeout 600 seconds,result is TPASS.
>
> Signed-off-by: Xinpeng Liu <liuxp11@chinatelecom.cn>
> ---
>  testcases/kernel/syscalls/ioctl/ioctl_sg01.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_sg01.c
> b/testcases/kernel/syscalls/ioctl/ioctl_sg01.c
> index 94b30dc..d1f2d3c 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl_sg01.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_sg01.c
> @@ -123,6 +123,7 @@ static void run(void)
>  }
>
>  static struct tst_test test = {
> +       .timeout = 600,
>

It's hard to say 600s is proper for other huge systems.

What about setting .timeout = -1 to disable it like what we did for the
oom0* series test:
https://github.com/linux-test-project/ltp/blob/master/lib/tst_test.c#L1251


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210127/f4afeaf0/attachment.htm>
