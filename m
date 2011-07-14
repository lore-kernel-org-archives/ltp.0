Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QhImV-0000xr-9S
	for ltp-list@lists.sourceforge.net; Thu, 14 Jul 2011 10:04:31 +0000
Date: Thu, 14 Jul 2011 12:06:02 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110714100602.GA1261@saboteur.suse.cz>
References: <1310608703-4814-1-git-send-email-gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1310608703-4814-1-git-send-email-gaowanlong@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] posix:clock_getcpuclockid:6-1.c:change the
 argument -1 to -2
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
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> ---
>  .../interfaces/clock_getcpuclockid/6-1.c           |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_getcpuclockid/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_getcpuclockid/6-1.c
> index 380e2a4..0371c41 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/clock_getcpuclockid/6-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_getcpuclockid/6-1.c
> @@ -24,7 +24,7 @@ int main(int argc, char *argv[])
>  #else
>  	clockid_t clockid_1;
>  
> -	if (clock_getcpuclockid(-1, &clockid_1) == 0) {
> +	if (clock_getcpuclockid(-2, &clockid_1) == 0) {
>  		printf("clock_getcpuclockid(-1, ..) failed\n");

You forgotten to update the message (it's still -1 there) and I would
change it to something less missleading like:

"clock_getcpuclockid(-2, ..) succeeded unexpectedly\n"

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
AppSumo Presents a FREE Video for the SourceForge Community by Eric 
Ries, the creator of the Lean Startup Methodology on "Lean Startup 
Secrets Revealed." This video shows you how to validate your ideas, 
optimize your ideas and identify your business strategy.
http://p.sf.net/sfu/appsumosfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
