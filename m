Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YlFuq-0007zV-Lz
	for ltp-list@lists.sourceforge.net; Thu, 23 Apr 2015 12:07:36 +0000
Date: Thu, 23 Apr 2015 14:07:10 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150423120710.GB20520@rei.suse.de>
References: <1426496710-11712-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<1426496710-11712-3-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1426496710-11712-3-git-send-email-gux.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v4 3/9] power_management: split runpwtests.sh into
 separate testcases
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
To: Xing Gu <gux.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> --- a/runtest/power_management_tests_exclusive
> +++ b/runtest/power_management_tests_exclusive
> @@ -1 +1,12 @@
> -POWER_MANAGEMENT runpwtests.sh -exclusive
> +#POWER_MANAGEMENT exclusive
> +runpwtests01 runpwtests01.sh
> +runpwtests02 runpwtests02.sh
> +runpwtests03 runpwtests03.sh
> +runpwtests04 runpwtests04.sh
> +#runpwtests05 runpwtests05.sh
> +runpwtests06 runpwtests06.sh
> +#runpwtests_exclusive01 runpwtests_exclusive01.sh
> +#runpwtests_exclusive02 runpwtests_exclusive02.sh
> +#runpwtests_exclusive03 runpwtests_exclusive03.sh
> +#runpwtests_exclusive04 runpwtests_exclusive04.sh
> +#runpwtests_exclusive05 runpwtests_exclusive05.sh

Why does the runpwtests0{1-6} repeat in the exclusive runtest file?

What about leaving only exclusive tests here (uncommented) and adding
only power_management_tests to the default scenario?

The rest is OK.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
BPM Camp - Free Virtual Workshop May 6th at 10am PDT/1PM EDT
Develop your own process in accordance with the BPMN 2 standard
Learn Process modeling best practices with Bonita BPM through live exercises
http://www.bonitasoft.com/be-part-of-it/events/bpm-camp-virtual- event?utm_
source=Sourceforge_BPM_Camp_5_6_15&utm_medium=email&utm_campaign=VA_SF
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
