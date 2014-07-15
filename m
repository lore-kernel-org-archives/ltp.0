Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1X73tC-0000Np-S6
	for ltp-list@lists.sourceforge.net; Tue, 15 Jul 2014 14:39:30 +0000
Date: Tue, 15 Jul 2014 16:39:02 +0200
From: chrubis@suse.cz
Message-ID: <20140715143901.GA8247@rei>
References: <1401685455.2838.8.camel@G08JYZSD130126>
	<20140612131041.GB20221@rei>
	<1403179593.7741.2.camel@G08JYZSD130126>
	<20140625153950.GA5552@rei>
	<1403866408.2119.28.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1403866408.2119.28.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH v3 1/3] Add autoconf test for CAN.
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> +int main(void)
> +{
> +	printf("The linux/can.h was missing upon compilation.\n");
> +	return 0;
> +}

Ideally this should return non-zero value so that we can return TCONF
from the test script in this case (since we changed the test library
to propagate TCONF into return value).

The rest of looks ok.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
