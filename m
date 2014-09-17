Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XUDlm-0003vq-SB
	for ltp-list@lists.sourceforge.net; Wed, 17 Sep 2014 11:51:34 +0000
Received: from mx6-phx2.redhat.com ([209.132.183.39])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XUDll-0006mo-Fs
	for ltp-list@lists.sourceforge.net; Wed, 17 Sep 2014 11:51:34 +0000
Date: Wed, 17 Sep 2014 07:51:23 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <717375298.24303522.1410954683925.JavaMail.zimbra@redhat.com>
In-Reply-To: <1410503722.8011.2.camel@G08JYZSD130126>
References: <1405145148.3386.3.camel@G08JYZSD130126>
	<20140904122455.GA9603@rei.suse.cz>
	<1409895039.17311.20.camel@G08JYZSD130126>
	<20140909101813.GA32553@rei>
	<1410503722.8011.2.camel@G08JYZSD130126>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] p9auth: remove this test
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>





----- Original Message -----
> From: "Zeng Linggang" <zenglg.jy@cn.fujitsu.com>
> To: "ltp-list" <ltp-list@lists.sourceforge.net>
> Sent: Friday, 12 September, 2014 8:35:22 AM
> Subject: [LTP] [PATCH] p9auth: remove this test
> 
> p9auth module was just included in staging for a while.
> It had been removed from kernel due to lack of interest.
> Remove it from LTP.
> 
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> ---

Pushed with modified commit message (added commit # that 
removed p9auth from kernel)

Regards,
Jan

------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
