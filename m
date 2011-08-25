Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QwWrn-0004kU-Fr
	for ltp-list@lists.sourceforge.net; Thu, 25 Aug 2011 10:08:55 +0000
Date: Thu, 25 Aug 2011 12:14:03 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110825101403.GB11006@saboteur.suse.cz>
References: <1313434593-7942-1-git-send-email-lgliang@linux.vnet.ibm.com>
	<1313434593-7942-4-git-send-email-lgliang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1313434593-7942-4-git-send-email-lgliang@linux.vnet.ibm.com>
Subject: Re: [LTP] [PATCH 4/7 ver2 w/attachment] Changes to pounder's build
 scripts
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
To: Lucy Liang <lgliang@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> diff --git a/tools/pounder21/build_scripts/ltp b/tools/pounder21/build_scripts/ltp
> index 68dcdbe..70defe4 100755
> --- a/tools/pounder21/build_scripts/ltp
> +++ b/tools/pounder21/build_scripts/ltp
> @@ -55,23 +55,24 @@ fi
>  
>  # NAK the setregid EPERM -> EINVAL patch, because it's
>  # broken on 2.6!  May be fixed some time after 20050804 release.
> -if [ ! -e "testcases/kernel/syscalls/setregid/setregid02.c.pounder" ]; then
> -	echo "Patching some holes in ltp..."
> -	cp -pRdu testcases/kernel/syscalls/setregid/setregid02.c testcases/kernel/syscalls/setregid/setregid02.c.pounder
> -	patch -p1 < $POUNDER_SRCDIR/ltp-setregid-fix.patch
> -	RESULT=$?
> -	if [ $RESULT -ne 0 ]; then
> -		echo Patching failed.
> -		exit 1
> -	fi
> -fi
> +#if [ ! -e "testcases/kernel/syscalls/setregid/setregid02.c.pounder" ]; then
> +#	echo "Patching some holes in ltp..."
> +#	cp -pRdu testcases/kernel/syscalls/setregid/setregid02.c testcases/kernel/syscalls/setregid/setregid02.c.pounder
> +#	patch -p1 < $POUNDER_SRCDIR/ltp-setregid-fix.patch
> +#	RESULT=$?
> +#	if [ $RESULT -ne 0 ]; then
> +#		echo Patching failed.
> +#		exit 1
> +#	fi
> +#fi

Patching LTP before build from this build script is not really long term
solution. We should get these patches applied to LTP (as it should have
been done long time ago) and drop this logic entrirely.

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
