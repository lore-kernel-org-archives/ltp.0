Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YxBdv-0007Ym-6e
	for ltp-list@lists.sourceforge.net; Tue, 26 May 2015 09:59:27 +0000
Date: Tue, 26 May 2015 11:58:37 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150526095837.GE2940@rei.suse.de>
References: <20150526084019.GA2940@rei.suse.de>
	<1432631777-22549-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1432631777-22549-2-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1432631777-22549-2-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH 2/2] Unmap the futexes backend file in tst_rmdir
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> As of now, test cases utilizing tst_checkpoint framework fail on NFS
> with similar errors:
> 
> creat07     0  TWARN  :  tst_tmpdir.c:206: tst_rmdir: rmobj(/tmpdir/ltp-0IVQPP0NK6/creigi0kV) failed: remove(/tmpdir/ltp-0IVQPP0NK6/creigi0kV) failed; errno=66: Directory not empty
> 
> This happens because we keep the futex page mapped while tst_rmdir() is running.
> 
> Let's unmap it before the actual delete procedure.
> 
> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
> ---
>  lib/tst_checkpoint.c |    2 +-
>  lib/tst_tmpdir.c     |   11 +++++++++++
>  2 files changed, 12 insertions(+), 1 deletions(-)
> 
> diff --git a/lib/tst_checkpoint.c b/lib/tst_checkpoint.c
> index 0e2c402..36eeff2 100644
> --- a/lib/tst_checkpoint.c
> +++ b/lib/tst_checkpoint.c
> @@ -33,7 +33,7 @@
>  
>  #define DEFAULT_MSEC_TIMEOUT 10000
>  
> -static futex_t *futexes;
> +futex_t *futexes;
>  static int page_size;

Now that futexes is a global symbol we should prefix it with tst_ to
avoid clashes with testcase defined symbols.

Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
