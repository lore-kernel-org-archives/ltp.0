Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SfJxT-0004Fh-CX
	for ltp-list@lists.sourceforge.net; Fri, 15 Jun 2012 00:00:11 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SfJxR-0006Kd-NZ
	for ltp-list@lists.sourceforge.net; Fri, 15 Jun 2012 00:00:11 +0000
Message-ID: <4FDA75C6.2090000@cn.fujitsu.com>
Date: Fri, 15 Jun 2012 07:37:42 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <969F26A8BAB325438E7EB80D3C3134FB16155EEE@IRSMSX102.ger.corp.intel.com>
In-Reply-To: <969F26A8BAB325438E7EB80D3C3134FB16155EEE@IRSMSX102.ger.corp.intel.com>
Subject: Re: [LTP] ltp: Add patch to correct failing build from archive
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
To: "Iorga, Cristian" <cristian.iorga@intel.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

On 06/06/2012 03:29 PM, Iorga, Cristian wrote:
> ltp: Add patch to correct failing build from archive
> 
>  
> 
> Signed-off-by: Cristian Iorga <cristian.iorga@intel.com>

Thanks Cristian, this already fixed in upstream.
refer to, 
https://github.com/linux-test-project/ltp/commit/dbd8b819c293d001b6ee6cb879871833ab23af8b

Wanlong Gao

> 
> 
> fix_building_fom_archive.patch
> 
> 
> ltp: Add patch to correct failing build
>     
>     ltp makefile does not interpret correctly the result of git describe
>     command and assumes that it is working with a git repo, while in fact
>     working with a source code archive.
>     Added a patch to corect makefile system.
>     Tested using dash as shell.
> 
> Signed-off-by: Cristian Iorga <cristian.iorga@intel.com>
> 
> Index: ltp-20120401/Makefile
> ===================================================================
> --- ltp-20120401.orig/Makefile
> +++ ltp-20120401/Makefile
> @@ -173,7 +173,7 @@ SRCDIR_INSTALL_TARGETS	:= $(SRCDIR_INSTA
>  #
>  .PHONY: Version
>  Version:
> -	if git describe &> /dev/null; then \
> +	if git describe > /dev/null 2>&1; then \
>  		git describe > "$@"; \
>  	else \
>  		cp VERSION "$@"; \



------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
