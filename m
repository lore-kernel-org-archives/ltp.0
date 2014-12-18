Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Y1bAI-0004ho-T6
	for ltp-list@lists.sourceforge.net; Thu, 18 Dec 2014 13:30:50 +0000
Date: Thu, 18 Dec 2014 14:30:28 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141218133028.GA22975@rei>
References: <1417101031-5272-1-git-send-email-mmarhefk@redhat.com>
	<1417691034-6255-1-git-send-email-mmarhefk@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1417691034-6255-1-git-send-email-mmarhefk@redhat.com>
Subject: Re: [LTP] [PATCH v2] testcases/lib/test.sh: added tst_timeout()
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
To: Matus Marhefka <mmarhefk@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> +# tst_timeout "command arg1 arg2 ..." timeout
> +# Runs command for specified timeout (in seconds).
> +# Function returns retcode of command or 1 if arguments are invalid.
> +tst_timeout()
> +{
> +	local command=$1
> +	local timeout=$(echo $2 | grep -o "^[0-9]\+$")
> +
> +	# command must be non-empty string with command to run
> +	if [ -z "$command" ]; then
> +		echo "first argument must be non-empty string"
> +		return 1
> +	fi
> +
> +	# accept only numbers as timeout
> +	if [ -z "$timeout" ]; then
> +		echo "only numbers as second argument"
> +		return 1
> +	fi
> +
> +	setsid sh -c "eval $command" 2>&1 &
> +	local pid=$!
> +	local pgid=$(ps -eo pid,pgid | grep $pid | sed 's/^.* //')

Hmm, wouldn't be the $pid == $pgid in this case? Or is there a scenario
where this would not hold?

Otherwise it looks good to me.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
