Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1S2gKC-0008Px-27
	for ltp-list@lists.sourceforge.net; Wed, 29 Feb 2012 09:59:56 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1S2gK6-0007nC-IL
	for ltp-list@lists.sourceforge.net; Wed, 29 Feb 2012 09:59:56 +0000
Received: by pbbrp12 with SMTP id rp12so5680637pbb.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 29 Feb 2012 01:59:44 -0800 (PST)
Message-ID: <4F4DF6DA.1030506@casparzhang.com>
Date: Wed, 29 Feb 2012 17:58:50 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1524114322.122004.1295852492822.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<1803283961.139211.1295922164654.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<AANLkTinamb_Q0MnLp_VuKND=biy0Y168YxQNqNLf=5xS@mail.gmail.com>
In-Reply-To: <AANLkTinamb_Q0MnLp_VuKND=biy0Y168YxQNqNLf=5xS@mail.gmail.com>
Subject: Re: [LTP] [PATCH] fix the -I option and enable a larger numble to I
 option
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

On 01/26/2011 03:32 PM, Garrett Cooper wrote:
> On Mon, Jan 24, 2011 at 6:22 PM, Zhouping Liu <zliu@redhat.com> wrote:
>> Hi,Garrett,
>>
>> could you please review the patch, and give me your comments.
>> any suggestions are welcome.
> 
>     Wow, someone really lacked foresight when producing this API.
>     Yes, there's a problem, but I disagree with your solution (in
> particular because long long isn't necessarily going to remain 64-bit
> in the future). I think that a fixed size type applied to all of these
> affect areas would be better (uint64_t -- the POSIX defined unsigned
> 64-bit integer [1]).
> Thanks,
> -Garrett

/me bringing up with an old topic here...

This problem comes out again (in cpuset01 test). I think we need someone
to fix it.

> 
> 1. http://www.opengroup.org/onlinepubs/000095399/basedefs/stdint.h.html

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
