Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SUqYL-0003AD-Jw
	for ltp-list@lists.sourceforge.net; Thu, 17 May 2012 02:34:57 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SUqYK-0005ie-IB
	for ltp-list@lists.sourceforge.net; Thu, 17 May 2012 02:34:57 +0000
Message-ID: <4FB46381.2010400@cn.fujitsu.com>
Date: Thu, 17 May 2012 10:33:37 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <20120516145353.GA12228@saboteur.suse.cz>
	<1337219962-5782-1-git-send-email-penght@cn.fujitsu.com>
	<4FB45E98.3010506@cn.fujitsu.com>
	<CAGH67wSxwhPXQ_j5ryRQe4-en-wYf3iLUgrn9xtcQ54dR1FsaA@mail.gmail.com>
In-Reply-To: <CAGH67wSxwhPXQ_j5ryRQe4-en-wYf3iLUgrn9xtcQ54dR1FsaA@mail.gmail.com>
Subject: Re: [LTP] [PATCH v2] ltp-pan.c: fix error of Total Tests
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On 05/17/2012 10:31 AM, Garrett Cooper wrote:

> On Wed, May 16, 2012 at 7:12 PM, Wanlong Gao <gaowanlong@cn.fujitsu.com> wrote:
>> On 05/17/2012 09:59 AM, Peng Haitao wrote:
>>
>>> When execvp() fails, the testcases is counted in Total Tests, but not
>>> added in logfile. In fact the testcases result should be added in logfile.
>>
>> I prefer adding this for matching the Total Tests amount.
>> So,
>>
>> Acked-by: Wanlong Gao <gaownalong@cn.fujitsu.com>
> 
>     It's nice that this is finally being fixed. This is one issue that
> has been outstanding for several years that needed to be resolved (I
> noticed it during/after I developed the execltp python script).


So, Garrett, you can ACK this?

Thanks,
Wanlong Gao

> Thanks!
> -Garrett
> 



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
