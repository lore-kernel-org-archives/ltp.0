Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1UYIFE-00012D-BM
	for ltp-list@lists.sourceforge.net; Fri, 03 May 2013 15:50:00 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UYIFD-00028T-68
	for ltp-list@lists.sourceforge.net; Fri, 03 May 2013 15:50:00 +0000
Date: Fri, 3 May 2013 11:49:52 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <556984977.6647527.1367596192280.JavaMail.root@redhat.com>
In-Reply-To: <1367588717-18162-1-git-send-email-riku.voipio@linaro.org>
References: <1367588717-18162-1-git-send-email-riku.voipio@linaro.org>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 0/3] Add Aarch64 support to ltp
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
To: riku voipio <riku.voipio@linaro.org>
Cc: ltp-list@lists.sourceforge.net



----- Original Message -----
> From: "riku voipio" <riku.voipio@linaro.org>
> To: ltp-list@lists.sourceforge.net
> Sent: Friday, 3 May, 2013 3:45:14 PM
> Subject: [LTP] [PATCH 0/3] Add Aarch64 support to ltp
> 
> From: Riku Voipio <riku.voipio@linaro.org>
> 
> Hi,
> 
> The following patches add support for Aarch64 in LTP.

Hi,

please also run regen.sh and add linux_syscall_numbers.h to your
patch as it is still part of tree. Other than that the series
looks good to me.

Regards,
Jan

> 
> Riku Voipio (3):
>   Add aarch64 support
>   Set invalid syscall as -1 instead of 0
>   set 16kb incrediment for Aarch64
> 
>  testcases/kernel/include/aarch64.in |  257
>  +++++++++++++++++++++++++++++++++++
>  testcases/kernel/include/order      |    1 +
>  testcases/kernel/include/regen.sh   |    5 +-
>  testcases/kernel/mem/shmt/shmt09.c  |    4 +-
>  4 files changed, 263 insertions(+), 4 deletions(-)
>  create mode 100644 testcases/kernel/include/aarch64.in
> 
> --
> 1.7.10.4

------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite
It's a free troubleshooting tool designed for production
Get down to code-level detail for bottlenecks, with <2% overhead.
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
