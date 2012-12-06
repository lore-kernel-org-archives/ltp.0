Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1TgXnS-00075j-Hv
	for ltp-list@lists.sourceforge.net; Thu, 06 Dec 2012 09:31:10 +0000
Date: Thu, 6 Dec 2012 10:30:58 +0100
From: chrubis@suse.cz
Message-ID: <20121206093057.GA2340@rei.nue.novell.com>
References: <8fbb13b857a614a0daf5dffdfb385871fce2e990.1354708056.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8fbb13b857a614a0daf5dffdfb385871fce2e990.1354708056.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] open_posix_testsuite/.../aio_red/7-1.c: fix race
 at exit
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
Cc: ltp-list@lists.sourceforge.net

Hi!
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  .../conformance/interfaces/aio_read/7-1.c          |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/7-1.c
> index 2d13565..1227db4 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/7-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/7-1.c
> @@ -70,6 +70,9 @@ int main()
>  		exit(PTS_FAIL);
>  	}
>  
> +	while (aio_error(&aiocb) == EINPROGRESS)
> +		;
> +

That creates unnecessary bussy-loop here, I usually add reasonally small
usleep to such loop to avoid that. Something like usleep(10000) would
do.

-- 
Cyril Hrubis
chrubis@suse.cz

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
