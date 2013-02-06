Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1U30cp-0005aN-Ei
	for ltp-list@lists.sourceforge.net; Wed, 06 Feb 2013 08:45:03 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1U30co-0006Jr-K1
	for ltp-list@lists.sourceforge.net; Wed, 06 Feb 2013 08:45:03 +0000
Message-ID: <511217E6.6070309@cn.fujitsu.com>
Date: Wed, 06 Feb 2013 16:44:22 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <cover.1360079418.git.jstancek@redhat.com>
	<fb082801509d79e55b15899e25db819e1710b9d6.1360079418.git.jstancek@redhat.com>
In-Reply-To: <fb082801509d79e55b15899e25db819e1710b9d6.1360079418.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH 1/3] setns: setup directory at
	kernel/syscalls/setns
Reply-To: gaowanlong@cn.fujitsu.com
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On 02/05/2013 11:57 PM, Jan Stancek wrote:
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

Acked-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

> ---
>  testcases/kernel/syscalls/setns/Makefile |   22 ++++++++++++++++++++++
>  1 files changed, 22 insertions(+), 0 deletions(-)
>  create mode 100644 testcases/kernel/syscalls/setns/Makefile
> 
> diff --git a/testcases/kernel/syscalls/setns/Makefile b/testcases/kernel/syscalls/setns/Makefile
> new file mode 100644
> index 0000000..b1179c4
> --- /dev/null
> +++ b/testcases/kernel/syscalls/setns/Makefile
> @@ -0,0 +1,22 @@
> +#
> +#  Copyright (C) 2013 Linux Test Project, Inc.
> +#
> +#  This program is free software;  you can redistribute it and/or modify
> +#  it under the terms of the GNU General Public License as published by
> +#  the Free Software Foundation; either version 2 of the License, or
> +#  (at your option) any later version.
> +#
> +#  This program is distributed in the hope that it will be useful,
> +#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
> +#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> +#  the GNU General Public License for more details.
> +#
> +#  You should have received a copy of the GNU General Public License
> +#  along with this program;  if not, write to the Free Software
> +#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +#
> +
> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> 


------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
