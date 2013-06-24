Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1Ur9EN-0004JM-Sw
	for ltp-list@lists.sourceforge.net; Mon, 24 Jun 2013 16:03:03 +0000
Received: from mail-pb0-f48.google.com ([209.85.160.48])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Ur9EL-0005cj-Te
	for ltp-list@lists.sourceforge.net; Mon, 24 Jun 2013 16:03:03 +0000
Received: by mail-pb0-f48.google.com with SMTP id ma3so11099209pbc.7
	for <ltp-list@lists.sourceforge.net>;
	Mon, 24 Jun 2013 09:02:56 -0700 (PDT)
Message-ID: <51C86DBD.7060205@casparzhang.com>
Date: Tue, 25 Jun 2013 00:03:09 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1372086727-27722-1-git-send-email-eguan@redhat.com>
	<1372088983-29843-1-git-send-email-eguan@redhat.com>
In-Reply-To: <1372088983-29843-1-git-send-email-eguan@redhat.com>
Subject: Re: [LTP] [PATCH v2] dup2/dup205: close all fds before tst_rmdir()
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Eryu Guan <eguan@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On 06/24/2013 11:49 PM, Eryu Guan wrote:
> Close all open fds before calling tst_rmdir() to avoid TWARN caused by
> NFS silly rename when removing temp dir.
>
> dup205      0  TWARN  :  tst_rmdir: rmobj(/mnt/nfs/dupbA5J5i) failed: unlink(/mnt/nfs/dupbA5J5i/.nfs0000000000f4805b00000005) failed; errno=16: Device or resource busy
>
> Signed-off-by: Eryu Guan <eguan@redhat.com>

Looks good to me.

Acked-by: Caspar Zhang <caspar@casparzhang.com>

> ---
> v2: Correct commit message.
>
>   testcases/kernel/syscalls/dup2/dup205.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/dup2/dup205.c b/testcases/kernel/syscalls/dup2/dup205.c
> index c728fcc..0528beb 100644
> --- a/testcases/kernel/syscalls/dup2/dup205.c
> +++ b/testcases/kernel/syscalls/dup2/dup205.c
> @@ -112,8 +112,8 @@ int main(int ac, char *av[])
>   			}
>   		}
>   		unlink(pfilname);
> -		if (ifile > 0)
> -			close(fildes[ifile - 1]);
> +		for (ifile = fildes[0]; ifile < min + 10; ifile++)
> +			close(fildes[ifile]);
>   		if (local_flag == PASSED) {
>   			tst_resm(TPASS, "Test passed.");
>   		} else {
>


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
