Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SHnhK-0008Sr-G4
	for ltp-list@lists.sourceforge.net; Wed, 11 Apr 2012 02:54:18 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SHnhJ-0006lB-0I
	for ltp-list@lists.sourceforge.net; Wed, 11 Apr 2012 02:54:18 +0000
Message-ID: <4F84F212.9070408@cn.fujitsu.com>
Date: Wed, 11 Apr 2012 10:53:06 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <alpine.BSF.2.00.1204041738350.25027@toaster.local>
	<4F7CF7DB.2080802@cn.fujitsu.com>
	<CAGH67wRSAKEkn=MNn2HHivnPNjuP_tqE8+S1-ND_Z69VrBm9Ow@mail.gmail.com>
In-Reply-To: <CAGH67wRSAKEkn=MNn2HHivnPNjuP_tqE8+S1-ND_Z69VrBm9Ow@mail.gmail.com>
Subject: Re: [LTP] [PATCH 2/2] Replace struct event_t with struct
	inotify_event
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

On 04/05/2012 10:10 AM, Garrett Cooper wrote:

> On Wed, Apr 4, 2012 at 6:39 PM, Wanlong Gao <gaowanlong@cn.fujitsu.com> wrote:
>> On 04/05/2012 08:42 AM, Garrett Cooper wrote:
>>
>>> Replace struct event_t with struct inotify_event
>>>
>>> Also do some minor whitespace cleanup while I'm
>>> in the neighborhood.
>>
>> there's something wrong with this patch, please take a look at the ".name".
> 
> Yeah... let me get back to you on that...


Any update on this?

Thanks,
Wanlong Gao

> -Garrett
> 



------------------------------------------------------------------------------
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second 
resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
