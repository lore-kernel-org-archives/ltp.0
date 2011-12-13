Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1RaLTb-0004DK-RY
	for ltp-list@lists.sourceforge.net; Tue, 13 Dec 2011 06:04:31 +0000
Received: from mail-gx0-f175.google.com ([209.85.161.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1RaLTb-0003cg-4p
	for ltp-list@lists.sourceforge.net; Tue, 13 Dec 2011 06:04:31 +0000
Received: by ggnh1 with SMTP id h1so8031970ggn.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 12 Dec 2011 22:04:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1323419326-13172-2-git-send-email-kai.kang@windriver.com>
References: <1323419326-13172-1-git-send-email-kai.kang@windriver.com>
	<1323419326-13172-2-git-send-email-kai.kang@windriver.com>
Date: Mon, 12 Dec 2011 22:04:25 -0800
Message-ID: <CAGH67wQAGSzb0eF+jH60h9m9zqoZ=oGQRE+pxBnNuXkP2YDsPQ@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 1/2] pthread_mutex_lock/3-1: make sure install
 signal hanldler first
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Kang Kai <kai.kang@windriver.com>
Cc: ltp-list@lists.sourceforge.net

On Fri, Dec 9, 2011 at 12:28 AM, Kang Kai <kai.kang@windriver.com> wrote:
> Test case failed for linux in some platform. Make parent thread
> sleep for a while to make sure that signal handlers are installed
> before send signal USR1 and USR2.
>
> Signed-off-by: Kang Kai <kai.kang@windriver.com>
> ---
> =A0.../interfaces/pthread_mutex_lock/3-1.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
=A04 +++-
> =A01 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthrea=
d_mutex_lock/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/=
pthread_mutex_lock/3-1.c
> index 771851d..a648c96 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex=
_lock/3-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex=
_lock/3-1.c
> @@ -307,6 +307,8 @@ int main (int argc, char * argv[])
> =A0 =A0 =A0 =A0if ((ret =3D pthread_create(&th_work, NULL, threaded, NULL=
)))
> =A0 =A0 =A0 =A0{ UNRESOLVED(ret, "Worker thread creation failed"); }
>
> + =A0 =A0 =A0 sleep(1);
> +
> =A0 =A0 =A0 =A0arg1.thr =3D &th_work;
> =A0 =A0 =A0 =A0arg2.thr =3D &th_work;
> =A0 =A0 =A0 =A0arg1.sig =3D SIGUSR1;
> @@ -359,4 +361,4 @@ int main (int argc, char * argv[])
> =A0 =A0 =A0 =A0#endif
> =A0 =A0 =A0 =A0#endif
> =A0 =A0 =A0 =A0PASSED;
> -}
> \ No newline at end of file
> +}
> --
> 1.7.5.4

It's better than status quo, but it's still kind of race prone (highly
unlikely, but you never know). It seems like a pthread_mutex would
make more sense in this case.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Systems Optimization Self Assessment
Improve efficiency and utilization of IT resources. Drive out cost and =

improve service delivery. Take 5 minutes to use this Systems Optimization =

Self Assessment. http://www.accelacomm.com/jaw/sdnl/114/51450054/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
