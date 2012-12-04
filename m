Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1Tfv1U-00024x-4N
	for ltp-list@lists.sourceforge.net; Tue, 04 Dec 2012 16:07:04 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Tfv1S-00061D-7J
	for ltp-list@lists.sourceforge.net; Tue, 04 Dec 2012 16:07:04 +0000
Received: by mail-pb0-f47.google.com with SMTP id un1so2728164pbc.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 04 Dec 2012 08:06:56 -0800 (PST)
References: <367be95f8c6b66828ee7930758141ec94c07d409.1354623101.git.jstancek@redhat.com>
Mime-Version: 1.0 (1.0)
In-Reply-To: <367be95f8c6b66828ee7930758141ec94c07d409.1354623101.git.jstancek@redhat.com>
Message-Id: <33B97956-C313-4006-95F8-795342CC7BF9@gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Date: Tue, 4 Dec 2012 08:06:52 -0800
Subject: Re: [LTP] [PATCH] open_posix_testsuite/.../sigset/{6,
	7}-1.c: fix error handling
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
To: Jan Stancek <jstancek@redhat.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

On Dec 4, 2012, at 4:12 AM, Jan Stancek <jstancek@redhat.com> wrote:

> int may not be large enough to hold return value from sigset():
>  typedef void (*sighandler_t)(int);
>  sighandler_t sigset(int sig, sighandler_t disp);
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
> .../conformance/interfaces/sigset/6-1.c            |    5 ++---
> .../conformance/interfaces/sigset/7-1.c            |    5 ++---
> 2 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigset/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigset/6-1.c
> index 16d340c..286ee37 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/sigset/6-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/sigset/6-1.c
> @@ -48,9 +48,8 @@ int main(void)
>        return PTS_UNRESOLVED;
>    }
> 
> -    rc = sigset(SIGCHLD, SIG_HOLD);
> -    if (rc < 0) {
> -        ERR_MSG("sigset()", rc);
> +    if (sigset(SIGCHLD, SIG_HOLD) == SIG_ERR) {
> +        perror("Unexpected error while using sigset()");
>        return PTS_UNRESOLVED;
>    }
> 
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigset/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigset/7-1.c
> index b7230db..18d4bb4 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/sigset/7-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/sigset/7-1.c
> @@ -56,9 +56,8 @@ int main(void)
>        return PTS_UNRESOLVED;
>    }
> 
> -    rc = sigset(SIGCHLD, SIG_HOLD);
> -    if (rc < 0) {
> -        ERR_MSG("sigset()", rc);
> +    if (sigset(SIGCHLD, SIG_HOLD) == SIG_ERR) {
> +        perror("Unexpected error while using sigset()");
>        return PTS_UNRESOLVED;
>    }

Reviewed-by: Garrett Cooper <yanegomi@gmail.com>
------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
