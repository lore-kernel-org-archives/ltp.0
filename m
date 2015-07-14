Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZEwQd-0008Fu-FJ
	for ltp-list@lists.sourceforge.net; Tue, 14 Jul 2015 09:23:07 +0000
Date: Tue, 14 Jul 2015 11:21:36 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150714092136.GB3137@rei.suse.de>
References: <1435909571-27285-1-git-send-email-liuhangbin@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1435909571-27285-1-git-send-email-liuhangbin@gmail.com>
Subject: Re: [LTP] [PATCHv2 1/2] testcases/lib/test.sh: add tst_retry() to
 ensure cmd exec succeed
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
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  testcases/lib/test.sh | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
> index 1c9b126..4183512 100644
> --- a/testcases/lib/test.sh
> +++ b/testcases/lib/test.sh
> @@ -134,6 +134,26 @@ tst_check_cmds()
>  	done
>  }
>  
> +# tst_retry "command" [times]
> +# try run command for specified times, default is 3.
> +# Function returns 0 if succeed in RETRIES times or the last retcode the cmd
> +# returned
> +tst_retry()
> +{
> +	local cmd="$1"
> +	local RETRIES=${2:-"3"}
> +	while [ $RETRIES -gt 0 ]; do
> +		eval "$cmd"
> +		ret=$?
> +		if [ $ret -eq 0 ]; then
> +			break
> +		fi
> +		let RETRIES--

The let construct is bash specific, we have to do RETRIES=$((RETRIES-1))
to keep the code working in rest of the shells as well.

> +		sleep 1
> +	done
> +	return $ret
> +}

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
