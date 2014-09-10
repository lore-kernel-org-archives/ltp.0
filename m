Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1XRbfg-0000p0-EO
	for ltp-list@lists.sourceforge.net; Wed, 10 Sep 2014 06:46:28 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XRbff-0007P9-Am
	for ltp-list@lists.sourceforge.net; Wed, 10 Sep 2014 06:46:28 +0000
Message-ID: <540FF385.1050903@cn.fujitsu.com>
Date: Wed, 10 Sep 2014 14:45:25 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1410326757.6630.1.camel@G08JYZSD130126>
	<1984956924.20366068.1410331044710.JavaMail.zimbra@redhat.com>
In-Reply-To: <1984956924.20366068.1410331044710.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH] tst_ncpus_conf: Instead of the old tst_ncpus_max
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On 09/10/2014 02:37 PM, Jan Stancek wrote:
> 
> ----- Original Message -----
>> > From: "Zeng Linggang" <zenglg.jy@cn.fujitsu.com>
>> > To: "ltp-list" <ltp-list@lists.sourceforge.net>
>> > Sent: Wednesday, 10 September, 2014 7:25:57 AM
>> > Subject: [LTP] [PATCH] tst_ncpus_conf: Instead of the old tst_ncpus_max
>> > 
>> > In commit 84d608326c59b7177c8ad4228fbcd21569b4f2fd we have updated
>> > tst_ncpus_max
>> > function. But smt_smp_enabled.sh and smt_smp_affinity.sh need the old
>> > tst_ncpus_max, otherwise they will fail. Use tst_ncpus_conf instead of the
>> > old
>> > tst_ncpus_max function.
>> > 
>> > Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> Looks good to me, ACK.
> 

Applied, thank you.

Wanlong Gao

> Regards,
> Jan
> 


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
