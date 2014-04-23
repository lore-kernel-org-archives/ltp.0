Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WczXQ-0005OI-PL
	for ltp-list@lists.sourceforge.net; Wed, 23 Apr 2014 15:56:44 +0000
Date: Wed, 23 Apr 2014 17:55:53 +0200
From: chrubis@suse.cz
Message-ID: <20140423155553.GB16286@rei.suse.cz>
References: <1395757480-27424-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1395757480-27424-6-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1395757480-27424-6-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH V2 05/14] rpc-tirpc: enabled building of the test
 binaries
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> +++ b/testcases/network/rpc/rpc-tirpc/tests_pack/Makefile.inc
> @@ -0,0 +1,20 @@
> +#
> +#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
> +
> +LDLIBS		+= $(TIRPC_LIBS) -lpthread
> +CPPFLAGS	+= $(TIRPC_CPPFLAGS)

This should be:

LDLIBS       += $(TIRPC_LIBS)
CPPFLAGS     += $(TIRPC_CPPFLAGS) -pthread

Because othewise preprocessor flags are not set.

See for example:

http://stackoverflow.com/questions/2127797/gcc-significance-of-pthread-flag-when-compiling

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
