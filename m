Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Xvqky-0003Br-Mc
	for ltp-list@lists.sourceforge.net; Tue, 02 Dec 2014 16:56:56 +0000
Date: Tue, 2 Dec 2014 17:56:45 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141202165645.GD22135@rei.suse.de>
References: <1413978094-10616-1-git-send-email-alexey.kodanev@oracle.com>
	<5448D65C.90308@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5448D65C.90308@oracle.com>
Subject: Re: [LTP] [PATCH v2 1/3] network/test_net: add support for -6
 option (IPv6 tests)
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
> > +# Blank for an IPV4 test; 6 for an IPV6 test.
> > +TST_IPV6=
> > +
> > +tst_read_opts()
> > +{
> > +	OPTIND=0
> > +	while getopts ":6" opt; do
> > +		case "$opt" in
> > +		6)
> > +			TST_IPV6=6;;
> > +		esac
> > +	done
> > +	OPTIND=0
> > +}
> 
> Maybe we can run the function inside test_net.sh as well. Any suggestions?

It makes sense in case that all the testcases that include the file will
run it anyway.

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
