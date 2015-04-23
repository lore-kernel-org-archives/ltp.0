Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YlEru-0006bD-4q
	for ltp-list@lists.sourceforge.net; Thu, 23 Apr 2015 11:00:30 +0000
Date: Thu, 23 Apr 2015 13:00:04 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150423110004.GB18237@rei.suse.de>
References: <1427269167-25299-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1427269167-25299-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH] device-drivers/zram: new zram test
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> +zram_compress_alg()
> +{
> +	tst_resm TINFO "test that we can set compression algorithm"
> +	local algs=$(cat /sys/block/zram0/comp_algorithm)
> +	tst_resm TINFO "supported algs: $algs"
> +	local i=0
> +	for alg in $zram_algs; do
> +		local sys_path="/sys/block/zram${i}/comp_algorithm"
> +		echo "$alg" >  $sys_path || \
> +			tst_brkm TFAIL "can't set 'lzo' to $sys_path"
                                                   ^
					Shouldn't this be $alg ?
> +		i=$(($i + 1))
> +		tst_resm TINFO "$sys_path = 'lzo' ($i/$dev_num)"
                                             ^
				      Here as well.
> +	done
> +
> +	tst_resm TPASS "test succeeded"
> +}
> +

Otherwise it looks good, acked.

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
