Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1SHu49-0006j3-4k
	for ltp-list@lists.sourceforge.net; Wed, 11 Apr 2012 09:42:17 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SHu43-0006gu-GB
	for ltp-list@lists.sourceforge.net; Wed, 11 Apr 2012 09:42:17 +0000
Received: by pbcum15 with SMTP id um15so1090901pbc.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 11 Apr 2012 02:42:05 -0700 (PDT)
References: <alpine.BSF.2.00.1204041738350.25027@toaster.local>
	<4F7CF7DB.2080802@cn.fujitsu.com>
	<CAGH67wRSAKEkn=MNn2HHivnPNjuP_tqE8+S1-ND_Z69VrBm9Ow@mail.gmail.com>
	<4F84F212.9070408@cn.fujitsu.com>
In-Reply-To: <4F84F212.9070408@cn.fujitsu.com>
Mime-Version: 1.0 (1.0)
Message-Id: <8DB64E3B-1B6D-4C27-85E8-11817A41F879@gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Date: Wed, 11 Apr 2012 02:18:51 -0700
Subject: Re: [LTP] [PATCH 2/2] Replace struct event_t with struct
	inotify_event
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
To: "gaowanlong@cn.fujitsu.com" <gaowanlong@cn.fujitsu.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

On Apr 10, 2012, at 7:53 PM, Wanlong Gao <gaowanlong@cn.fujitsu.com> wrote:

> On 04/05/2012 10:10 AM, Garrett Cooper wrote:
> 
>> On Wed, Apr 4, 2012 at 6:39 PM, Wanlong Gao <gaowanlong@cn.fujitsu.com> wrote:
>>> On 04/05/2012 08:42 AM, Garrett Cooper wrote:
>>> 
>>>> Replace struct event_t with struct inotify_event
>>>> 
>>>> Also do some minor whitespace cleanup while I'm
>>>> in the neighborhood.
>>> 
>>> there's something wrong with this patch, please take a look at the ".name".
>> 
>> Yeah... let me get back to you on that...
> 
> 
> Any update on this?

I'm moving from CA to WA, but I'll try to get back to you sometime mid next week once I get settled in.

Thanks!
-Garrett
------------------------------------------------------------------------------
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second 
resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
