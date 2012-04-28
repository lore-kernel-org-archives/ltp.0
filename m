Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SO5bN-0000gP-Qr
	for ltp-list@lists.sourceforge.net; Sat, 28 Apr 2012 11:14:09 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SO5bM-0000mr-Bd
	for ltp-list@lists.sourceforge.net; Sat, 28 Apr 2012 11:14:09 +0000
Message-ID: <4F9BD0B3.2000800@cn.fujitsu.com>
Date: Sat, 28 Apr 2012 19:12:51 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <438a0d13-6bc5-4a0e-9d35-c475e6c54ede@zmail13.collab.prod.int.phx2.redhat.com>
In-Reply-To: <438a0d13-6bc5-4a0e-9d35-c475e6c54ede@zmail13.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [BUG] I'm reporting a bug about file
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
To: Zhouping Liu <zliu@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>, file@mx.gw.com

On 04/28/2012 01:50 PM, Zhouping Liu wrote:

>>
>> Resend! The file command mail list kicked my mail out since I'm not
>> in the list.
>> Now, I'm in.
>>
>>> Hi folks,
>>>
>>> Here, I'm reporting a bug, maybe it is solved upstream,
>>> but it's already on Fedora 16. Below shows the bug,
> 
> hi, Wanlong
> 
> I checked the issue one weeks ago, downloaded different version
> from ftp://ftp.astron.com/pub/file/, then I found the issue just occurred
> in 5.07, 5.08, 5.09, 5.10 upstream version, and fixed
> in 5.11, and I'm sure fedora 17 Beta(file version is 5.10) have fixed the issue.



OK, nice, thanks a lot Zhouping.

Regards,
Wanlong Gao

> 
> --
> Thanks,
> Zhouping
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
