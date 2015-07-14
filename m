Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZEwjL-0008K6-LZ
	for ltp-list@lists.sourceforge.net; Tue, 14 Jul 2015 09:42:27 +0000
Date: Tue, 14 Jul 2015 11:40:52 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150714094052.GC3729@rei.suse.de>
References: <1435895009-18134-1-git-send-email-sunyuan3@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1435895009-18134-1-git-send-email-sunyuan3@huawei.com>
Subject: Re: [LTP] [PATCH] Add check_simple_capset in filecapstest.sh.
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
To: Yuan Sun <sunyuan3@huawei.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> +echo "testing for simple capset"
> +check_simple_capset
> +tmp=$?
> +if [ $tmp -ne 0 ]; then
> +	exit_code=$tmp
> +fi

Rather than adding to the script, can we split it so that each of the
binaries can be run separately and that we have one entry per test in
the runtest file?

It would also be good idea to prefix the test binaris with capset_ or
something similar (in a separate patch please).

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
