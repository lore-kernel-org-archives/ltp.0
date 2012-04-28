Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1SO0YZ-0000Je-A9
	for ltp-list@lists.sourceforge.net; Sat, 28 Apr 2012 05:50:55 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SO0YY-0004C5-0y
	for ltp-list@lists.sourceforge.net; Sat, 28 Apr 2012 05:50:55 +0000
Date: Sat, 28 Apr 2012 01:50:43 -0400 (EDT)
From: Zhouping Liu <zliu@redhat.com>
Message-ID: <438a0d13-6bc5-4a0e-9d35-c475e6c54ede@zmail13.collab.prod.int.phx2.redhat.com>
In-Reply-To: <4F98DAC5.8020708@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [BUG] I'm reporting a bug about file
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
Cc: LTP List <ltp-list@lists.sourceforge.net>, file@mx.gw.com

> 
> Resend! The file command mail list kicked my mail out since I'm not
> in the list.
> Now, I'm in.
> 
> > Hi folks,
> > 
> > Here, I'm reporting a bug, maybe it is solved upstream,
> > but it's already on Fedora 16. Below shows the bug,

hi, Wanlong

I checked the issue one weeks ago, downloaded different version
from ftp://ftp.astron.com/pub/file/, then I found the issue just occurred
in 5.07, 5.08, 5.09, 5.10 upstream version, and fixed
in 5.11, and I'm sure fedora 17 Beta(file version is 5.10) have fixed the issue.

--
Thanks,
Zhouping

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
