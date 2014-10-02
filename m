Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XZfXJ-00029J-Qy
	for ltp-list@lists.sourceforge.net; Thu, 02 Oct 2014 12:31:09 +0000
Date: Thu, 2 Oct 2014 14:30:28 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141002123027.GA2529@rei.suse.cz>
References: <1411381740-31517-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1411381740-31517-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH] network/ip_route: cleanup test,
 use new library functions
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
> +# Function: init
>  #
> -# Description:	- Check if command ip is available.
> +# Description:  - Check if command ip is available.
>  #               - Check if command ifconfig is available.
>  #               - check if command awk is available.
>  #               - alias eth0 to eth0:1 with IP 10.1.1.12
>  #
> -# Return		- zero on success
> +# Return        - zero on success
>  #               - non zero on failure. return value from commands ($RC)

I would be more aggressiove on cleanup these comments. If nothing else
they are incorrect after the patch is applied as the functions does not
return anything anymore.

I would remove all useless and redundant information from there, for
this function the only important information is:

# Alias eth0 to eth0:1 with IP 10.1.1.12

But that seems to be covered by the tst_resm TINFO in the middle of the
init() function.

For the test functions I would keep just short description of what the
test does and remove everything else, the less comments we have the less
incorrect comments we end up with when code is changed.

> -		tst_brk TBROK $LTPTMP/tst_ip.out NULL \
> -			"Test #2: modprobe failed to load dummy.o"
> -		return $RC
> +	modprobe dummy > /dev/null 2>&1

I'm not sure if we should silence commands that does not produce output
if everything goes right. Because when this starts failing you would
have to remove the redirections to actually figure out what exactly went
wrong.


Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
