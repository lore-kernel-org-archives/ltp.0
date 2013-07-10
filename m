Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UwswS-0005el-UW
	for ltp-list@lists.sourceforge.net; Wed, 10 Jul 2013 11:52:16 +0000
Date: Wed, 10 Jul 2013 13:53:54 +0200
From: chrubis@suse.cz
Message-ID: <20130710115354.GC19178@rei.suse.cz>
References: <1372860236-24667-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1372860236-24667-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH v7] fw_load: new test of device firmware loading
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
> +++ b/testcases/kernel/firmware/fw_load_kernel/Makefile
> @@ -0,0 +1,37 @@
> +# Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License as
> +# published by the Free Software Foundation; either version 2 of
> +# the License, or (at your option) any later version.
> +#
> +# This program is distributed in the hope that it would be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write the Free Software Foundation,
> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +
> +ifneq ($(KERNELRELEASE),)
> +
> +ifdef CONFIG_FW_LOADER
> +obj-m		:= ltp_fw_load.o
> +endif
> +
> +else
> +
> +top_srcdir	?= ../../../..
> +include $(top_srcdir)/include/mk/env_pre.mk
> +
> +MAKE_TARGETS	:= ltp_fw_load.ko
> +ltp_fw_load.ko: ltp_fw_load.c
> +	-$(MAKE) -C $(LINUX_DIR) M=$(abs_srcdir)
> +	-mv ltp_fw_load.ko ltp_fw_load.ko~
> +	-$(MAKE) -C $(LINUX_DIR) M=$(abs_srcdir) clean
> +	-mv ltp_fw_load.ko~ ltp_fw_load.ko

I think this will be better with comment on why we ignore the
return values just as Mike said.

Otherwise I would go with this version of the patch and figure out the
rest of the build system issues (if any) later.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
