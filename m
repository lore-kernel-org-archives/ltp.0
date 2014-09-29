Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XYcfN-0004EV-I7
	for ltp-list@lists.sourceforge.net; Mon, 29 Sep 2014 15:15:09 +0000
Date: Mon, 29 Sep 2014 17:14:46 +0200
From: chrubis@suse.cz
Message-ID: <20140929151446.GA11687@rei>
References: <1412002661-14537-1-git-send-email-zlang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1412002661-14537-1-git-send-email-zlang@redhat.com>
Subject: Re: [LTP] [PATCH] ext4-new-features: modify ext4-delalloc-mballoc
 can not find ffsb-config file
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
To: Zorro Lang <zlang@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> diff --git a/testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/ext4-alloc-test.sh b/testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/ext4-alloc-test.sh
> index 1ffba13..47d9174 100755
> --- a/testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/ext4-alloc-test.sh
> +++ b/testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/ext4-alloc-test.sh
> @@ -40,7 +40,7 @@ ext4_test_remount()
>  		return
>  	fi
>  
> -	ffsb ffsb-config0 > /dev/null
> +	ffsb $LTPROOT/testcases/bin/ffsb-config0 > /dev/null
>  	if [ $? -ne 0 ]; then
>  		tst_resm TFAIL "ffsb returned failure"
>  		umount mnt_point
> @@ -92,7 +92,7 @@ ext4_test_delalloc_mballoc()
>  		return
>  	fi
>  
> -	ffsb ffsb-config$2 > /dev/null
> +	ffsb $LTPROOT/testcases/bin/ffsb-config$2 > /dev/null

These should idealy be treated as a datafiles.

So the ext4-ffsb-config/Makefile should have:

INSTALL_DIR := testcases/data/ext4-ffsb/

then the files would be installed under this path and the
path to the files in the shell script above should then be
$LTPROOT/testcases/data/ext4-ffsb/ffsb-config0

Can you please update the patch?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Slashdot TV.  Videos for Nerds.  Stuff that Matters.
http://pubads.g.doubleclick.net/gampad/clk?id=160591471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
