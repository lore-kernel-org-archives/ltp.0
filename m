Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QwbSO-0003Ul-DB
	for ltp-list@lists.sourceforge.net; Thu, 25 Aug 2011 15:03:00 +0000
Date: Thu, 25 Aug 2011 17:08:11 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110825150811.GA19476@saboteur.suse.cz>
References: <4E4C43C9.2040303@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4E4C43C9.2040303@linux.vnet.ibm.com>
Subject: Re: [LTP] [PATCH 1/1] Two added files for common criteria evaluation
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
To: James Czyzak <czyzak2@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net, debora@linux.vnet.ibm.com

Hi!
> Two files I would like to add for the purpose of running some tests
> that are required for a common criteria evaluation against the ospp
> protection policy that are not currently included in other test
> suites.

Could you please explain more specifically what are these scripts used
for? Seems to be some certification.

> +#                            It has been modified to use the command file
> +#                            cc_commands and only include arguments
> that might
> +#                            be useful for the common criteria
> testing against
> +#                            the ospp in conjunction with the
> audit-test suite.
> +#                            Also includes code to turn off screen in
> +#                            /etc/profile for the test run as
> screen interferes
> +#                            with the su tests (screen is turned on in the
> +#                            in some evaluated configurations for
> purposes of
> +#                            securing display devices)

This part apparently got mangled by your email client.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
EMC VNX: the world's simplest storage, starting under $10K
The only unified storage solution that offers unified management 
Up to 160% more powerful than alternatives and 25% more efficient. 
Guaranteed. http://p.sf.net/sfu/emc-vnx-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
