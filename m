From: Li Wang <liwang@redhat.com>
Date: Wed, 24 Jan 2018 18:20:30 +0800
Subject: [LTP] [PATCH] lapi/aarch64.in: Fix incorrect syscall number for
	copy_file_range
In-Reply-To: <1516777447-24314-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1516777447-24314-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <CAEemH2cyuFiu_UvDQ2t2PpWzHiRk9L0Qmw=Z=HByT++08R7xyg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

On Wed, Jan 24, 2018 at 3:04 PM, Xiao Yang <yangx.jy@cn.fujitsu.com> wrote:

> 64-bit ARM should use the generic syscall number which is 285.
>

ACK. I have checked this on an aarch64 platform and confirmed.=E2=80=8B



>
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  include/lapi/syscalls/aarch64.in | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/lapi/syscalls/aarch64.in b/include/lapi/syscalls/
> aarch64.in
> index 8b725e3..1f45839 100644
> --- a/include/lapi/syscalls/aarch64.in
> +++ b/include/lapi/syscalls/aarch64.in
> @@ -256,4 +256,4 @@ sendmmsg 269
>  kcmp 272
>  getrandom 278
>  memfd_create 279
> -copy_file_range 391
> +copy_file_range 285
> --
> 1.8.3.1
>
>
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>



--=20
Li Wang
liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180124/b5869a49/att=
achment.html>
