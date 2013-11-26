Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VlJy8-0001UB-KI
	for ltp-list@lists.sourceforge.net; Tue, 26 Nov 2013 14:50:28 +0000
Date: Tue, 26 Nov 2013 15:49:59 +0100
From: chrubis@suse.cz
Message-ID: <20131126144959.GB13652@rei>
References: <20131111141503.GE12164@rei>
	<1384841690-716-1-git-send-email-xu.simon@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1384841690-716-1-git-send-email-xu.simon@oracle.com>
Subject: Re: [LTP] [PATCH V4] rpc01: fix paths and add Makefile for datafiles
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
To: Simon Xu <xu.simon@oracle.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> +include $(top_srcdir)/include/mk/generic_trunk_target.mk
> diff --git a/testcases/network/rpc/basic_tests/rpc01/datafiles/Makefile b/testcases/network/rpc/basic_tests/rpc01/datafiles/Makefile
> new file mode 100644
> index 0000000..92370e6
> --- /dev/null
> +++ b/testcases/network/rpc/basic_tests/rpc01/datafiles/Makefile
> @@ -0,0 +1,29 @@
> +#
> +#    network/rpc/basic_tests/rpc01/datafiles Makefile.
> +#
> +#    This program is free software; you can redistribute it and/or modify
> +#    it under the terms of the GNU General Public License as published by
> +#    the Free Software Foundation; either version 2 of the License, or
> +#    (at your option) any later version.
> +#
> +#    This program is distributed in the hope that it will be useful,
> +#    but WITHOUT ANY WARRANTY; without even the implied warranty of
> +#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +#    GNU General Public License for more details.
> +#
> +#    You should have received a copy of the GNU General Public License along
> +#    with this program; if not, write to the Free Software Foundation, Inc.,
> +#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +#
> +#    Simon Xu <xu.simon@oracle.com> Nov 8 2013
> +#
> +
> +top_srcdir		?= ../../../../../..
> +
> +include $(top_srcdir)/include/mk/env_pre.mk
> +
> +INSTALL_DIR		:= testcases/bin/datafiles

We allready have a testcases/data/ directory that is used by the unzip
testcase, what about using this one instead?

> +INSTALL_TARGETS		:= file*

Can you please also rename the data files so that it's clear that they
are part of the rpc test? Something like rpc01_file1 rpc01_file2 or
similar should do. Or we can start stacking the files into
subdirectories named after the testcase, i.e.
testcases/data/rpc01/file1

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
