Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1TXj9H-0008Bf-Bv
	for ltp-list@lists.sourceforge.net; Mon, 12 Nov 2012 01:49:15 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TXj9F-00006W-As
	for ltp-list@lists.sourceforge.net; Mon, 12 Nov 2012 01:49:15 +0000
Message-ID: <50A04DFC.3010100@cn.fujitsu.com>
Date: Mon, 12 Nov 2012 09:16:44 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <5097893B.7060105@asianux.com>
In-Reply-To: <5097893B.7060105@asianux.com>
Subject: Re: [LTP] [Issue Report] the stress test which includes nfs test
 with client and server under same machine
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
To: Chen Gang <gang.chen@asianux.com>
Cc: ltp-list@lists.sourceforge.net

On 11/05/2012 05:39 PM, Chen Gang wrote:
> Hello ltp-list@lists.sorceforge.net 
> 
> 1) Firstly:
> 
>    A) LTP is a very useful tools for Asianux to test Linux kernel.
>    B) Thank LTP very much.
>    C) During test, Asianux find an issue about LTP
>       Asianux think maybe it will be better to let LTP know about it.
> 
> 
> 2) Description:
> 
>    A) with default configuration for /opt/ltp/testscripts/ltpstress.sh
>    B) it tests the nfs with client and server under the same machine
>    C) it is an known issue about it.
> 
> 3) Reference
> 
>    A) Red Hat Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=858978
>    B) LKVM Mailing list: https://lkml.org/lkml/2012/10/16/1  (at tail)
> 
>> Running the client and server on the same machine is likely to deadlock
>> due to memory pressure issues. The client needs to be able to _increase_
>> memory pressure on the server in order to reduce its own pressure. That
>> doesn't work well when client == server.
> 
> 
> 
>   At last, hope these information are useful for LTP,  thanks.


Thank you very much for reporting this issue, we will take care of this.
And if you like, bug-fix-patches are very welcome.

Thanks,
Wanlong Gao

> 


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_nov
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
