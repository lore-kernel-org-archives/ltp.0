Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1SFc9j-00078j-Jo
	for ltp-list@lists.sourceforge.net; Thu, 05 Apr 2012 02:10:35 +0000
Received: from mail-vx0-f175.google.com ([209.85.220.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SFc9i-0007d7-SZ
	for ltp-list@lists.sourceforge.net; Thu, 05 Apr 2012 02:10:35 +0000
Received: by vcbfl13 with SMTP id fl13so398590vcb.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 04 Apr 2012 19:10:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4F7CF7DB.2080802@cn.fujitsu.com>
References: <alpine.BSF.2.00.1204041738350.25027@toaster.local>
	<4F7CF7DB.2080802@cn.fujitsu.com>
Date: Wed, 4 Apr 2012 19:10:29 -0700
Message-ID: <CAGH67wRSAKEkn=MNn2HHivnPNjuP_tqE8+S1-ND_Z69VrBm9Ow@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
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
To: gaowanlong@cn.fujitsu.com
Cc: ltp-list@lists.sourceforge.net

On Wed, Apr 4, 2012 at 6:39 PM, Wanlong Gao <gaowanlong@cn.fujitsu.com> wrote:
> On 04/05/2012 08:42 AM, Garrett Cooper wrote:
>
>> Replace struct event_t with struct inotify_event
>>
>> Also do some minor whitespace cleanup while I'm
>> in the neighborhood.
>
> there's something wrong with this patch, please take a look at the ".name".

Yeah... let me get back to you on that...
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
