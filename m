Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1TbBmG-0005ps-OQ
	for ltp-list@lists.sourceforge.net; Wed, 21 Nov 2012 14:59:48 +0000
Date: Wed, 21 Nov 2012 15:57:06 +0100
From: chrubis@suse.cz
Message-ID: <20121121145706.GB5187@rei.suse.cz>
References: <1353493513-1288-1-git-send-email-penght@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1353493513-1288-1-git-send-email-penght@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] runnetnstest.sh: fix a fail of vsftpd is disabled
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
To: Peng Haitao <penght@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> +flag=0
> +# running under systemd?
> +if command -v systemctl >/dev/null 2>&1; then
> +	HAVE_SYSTEMCTL=1
> +else
> +	HAVE_SYSTEMCTL=0
> +fi
> +
> +if [ $HAVE_SYSTEMCTL -eq 1 ]; then
> +	systemctl status vsftpd.service > /dev/null 2>&1 || flag=$?
> +	if [ $flag -ne 0 ]; then
> +		systemctl start vsftpd.service > /dev/null 2>&1
> +	fi
> +else
> +	service vsftpd status > /dev/null 2>&1 || flag=$?
> +	if [ $flag -ne 0 ]; then
> +		service vsftpd start > /dev/null 2>&1
> +	fi
> +fi

Hmm, what is the reason of using the flag variable instead of $?
directly?

And this snippet of code makes me wonder if it would be better to have a
small shell library to restart the system services by a given name. Do
we have other places with similar pieces of code?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Monitor your physical, virtual and cloud infrastructure from a single
web console. Get in-depth insight into apps, servers, databases, vmware,
SAP, cloud infrastructure, etc. Download 30-day Free Trial.
Pricing starts from $795 for 25 servers or applications!
http://p.sf.net/sfu/zoho_dev2dev_nov
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
