Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VimCs-0005hO-5g
	for ltp-list@lists.sourceforge.net; Tue, 19 Nov 2013 14:23:10 +0000
Date: Tue, 19 Nov 2013 15:22:44 +0100
From: chrubis@suse.cz
Message-ID: <20131119142244.GA2483@rei.nue.novell.com>
References: <5283773E.5080505@cn.fujitsu.com> <20131113160220.GA28712@rei>
	<52858E29.7090602@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52858E29.7090602@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] fs/ext4-new-features: add ext4-new-features tests
 to the default
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
To: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> >> +# create an ext4 partition
> >> +dd if=/dev/zero of=fs_ext4_new_features_$$.img bs=1M count=$BLOCK_COUNT
> >> +
> >> +if [ $? -ne 0 ];then
> >> +	tst_brkm TCONF ignored "failed to create an ext4 image file"
> >> +	exit 0
> >> +fi
> >> +
> >> +EXT4_DEV=$(losetup --show -f fs_ext4_new_features_$$.img)
> >> +if [ $? -ne 0 ];then
> >> +	tst_brkm TCONF ignored "set loop device failed"
> >> +	exit 0
> >> +fi
> >> +
> >> +echo "EXT4_DEV=$EXT4_DEV" > ./ext4-test-config
> >> +
> > We should use DEVICE passed to the runltp script instead, that way we
> > don't even need this helper (if there is some common code move it to
> > ex4_funcs.sh and use it from the tests) and call the test scripts
> > from runtest file directly.
> 
> The ext4 new features test need a big partition, and the recommended
> size of this partition is between 5G and 10G, so the DEVICE isn't appropriate.
> 
> Whether I should create a big partition in runltp script named BIG_DEVICE to
> run these tests?
> 

Sounds reasonable to me.

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
