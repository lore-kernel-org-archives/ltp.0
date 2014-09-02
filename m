Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XOlca-0002y6-CG
	for ltp-list@lists.sourceforge.net; Tue, 02 Sep 2014 10:47:32 +0000
Date: Tue, 2 Sep 2014 12:47:18 +0200
From: chrubis@suse.cz
Message-ID: <20140902104718.GA7478@rei.suse.cz>
References: <1409569423-15376-1-git-send-email-mmarhefk@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1409569423-15376-1-git-send-email-mmarhefk@redhat.com>
Subject: Re: [LTP] [PATCH] containers: added netns/netns_isolation.sh
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
To: Matus Marhefka <mmarhefk@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> +# SETUP
> +tst_require_root
> +which ip &>/dev/null || tst_brkm TCONF "ip utility is required for this test"
> +which ifconfig &>/dev/null ||
> +	tst_brkm TCONF "ifconfig utility is required for this test"

We have tst_check_cmds in test.sh exactly for this purpose. And looking
at the code below we only need ifconfig for test case #1, there is no
need to skip the whole test if it's no present.

The rest of the code looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
