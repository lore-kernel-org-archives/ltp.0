Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XRK5l-00087X-9u
	for ltp-list@lists.sourceforge.net; Tue, 09 Sep 2014 12:00:13 +0000
Date: Tue, 9 Sep 2014 13:59:57 +0200
From: chrubis@suse.cz
Message-ID: <20140909115957.GA2617@rei>
References: <1407245680-4715-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1407245680-4715-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH v2 1/2] testscripts/network: uniform network
 parameters
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
> --- a/testscripts/networkstress.sh
> +++ b/testscripts/networkstress.sh
> @@ -12,32 +12,10 @@ if [ $? -eq 0 ]; then
>   export LTPROOT=${PWD}
>  fi
>  
> -export TMPDIR=/tmp/netst-$$
> -mkdir $TMPDIR
> -VERBOSE="no"
> -INTERFACE="eth0"
> -
> -#===========================================================================
> -# Network parameters
> -export RHOST=
> -export RHOST_HWADDRS=
> -export HTTP_DOWNLOAD_DIR=
> -export FTP_DOWNLOAD_DIR=
> -export FTP_UPLOAD_DIR=
> -export FTP_UPLOAD_URLDIR=
> -
> -# Set firt three octets of the network address, by default 10.0.0
> -export IPV4_NETWORK=
> -# Set local host last octet, by default 2
> -export LHOST_IPV4_HOST=
> -# Set remote host last octet, by default 1
> -export RHOST_IPV4_HOST=
> -# Set the reverse of IPV4_NETWORK, by default 0.0.10
> -export IPV4_NETWORK_REVERSE=
> +. $LTPROOT/testscripts/network.sh $0

Is the $0 parameter actually used? I couldn't find line in the
network.sh where script parameters are parsed.

Otherwise it looks fine to me. And sorry that the review took so long.

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
