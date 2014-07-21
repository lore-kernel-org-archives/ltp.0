Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1X99pL-0000Y1-KN
	for ltp-list@lists.sourceforge.net; Mon, 21 Jul 2014 09:24:11 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1X99pK-0000se-As
	for ltp-list@lists.sourceforge.net; Mon, 21 Jul 2014 09:24:11 +0000
Message-ID: <53CCDBFA.4060209@cn.fujitsu.com>
Date: Mon, 21 Jul 2014 17:23:06 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
References: <1405419229-4222-1-git-send-email-wangxg.fnst@cn.fujitsu.com>	<1405419229-4222-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<38788431.12648558.1405933467675.JavaMail.zimbra@redhat.com>
	<53CCD8DB.7030703@cn.fujitsu.com>
In-Reply-To: <53CCD8DB.7030703@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 2/2] syscalls/getcwd04.c: regression test for
	getcwd(2)
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
To: gaowanlong@cn.fujitsu.com
Cc: Artem@suse.de, ltp-list@lists.sourceforge.net, Savkov <asavkov@redhat.com>

Hi Jan, Wanlong,

On 07/21/2014 05:09 PM, Wanlong Gao wrote:
> On 07/21/2014 05:04 PM, Jan Stancek wrote:
>>
>> looks good to me.
>>
>>>> I have run this test case in RHEL7.0GA, Fedora19, v3.11-7758-g232d2d6 and 3.16.0-rc4+.
>>>> RHEL7.0GA has this kernel bug, so this test case fails.
>> I can confirm this, with note that I've seen it happen only on systems with 2+ CPUs.
> 
> If this note is truth, we should judge the nr_cpus in this case to make sure it always
> gives the right result.

Thanks Jan for pointing this.
I'll have a look at these three related kernel patches again. If needed, I'll sent a 
v2 version including the judgment about number of cpus, thanks!

Regards,
Xiaoguang Wang
> 
> Thanks,
> Wanlong Gao
>  
> 
> .
> 


------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
