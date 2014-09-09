Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XRKMH-0007Li-CP
	for ltp-list@lists.sourceforge.net; Tue, 09 Sep 2014 12:17:17 +0000
Date: Tue, 9 Sep 2014 14:17:01 +0200
From: chrubis@suse.cz
Message-ID: <20140909121701.GA3891@rei>
References: <1406553022-3436-1-git-send-email-alexey.kodanev@oracle.com>
	<1406553022-3436-2-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1406553022-3436-2-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH 2/2] network/stress/broken_ip: move common code to
 library
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
> +tst_set_ipv4_addr()
> +{
> +	# Initialize test interfaces
> +	# The number of the test link where tests run
> +	LINK_NUM=${LINK_NUM:-0}
> +
> +	initialize_if lhost ${LINK_NUM}
> +	initialize_if rhost ${LINK_NUM}
> +
> +	# Netmask of the IPv4 network
> +	network_mask=24
> +
> +	tst_resm TINFO "set remote ipv4 addr '$IPV4_NETWORK $RHOST_IPV4_HOST'"
> +	# Set IPv4 addresses to the interfaces
> +	set_ipv4addr rhost $LINK_NUM $IPV4_NETWORK $RHOST_IPV4_HOST
> +	if [ $? -ne 0 ]; then
> +		tst_brkm TBROK "Failed to add any IP address at the remote host"
> +	fi
> +
> +	tst_resm TINFO "set local ipv4 addr '$IPV4_NETWORK $LHOST_IPV4_HOST'"
> +	set_ipv4addr lhost $LINK_NUM $IPV4_NETWORK $LHOST_IPV4_HOST
> +	if [ $? -ne 0 ]; then
> +		tst_brkm TBROK "Failed to add any IP address at the local host"
> +	fi
> +}

I would love to get the code from initialize_if and set_ipv4addr to be
cleaned and moved here to the test_net.sh but that would require
changing all the stress testcases first.

The changes looks good to me, acked.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce.
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
