Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1T7GnM-0007c4-0Y
	for ltp-list@lists.sourceforge.net; Fri, 31 Aug 2012 02:17:16 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1T7GnL-0001G9-12
	for ltp-list@lists.sourceforge.net; Fri, 31 Aug 2012 02:17:15 +0000
Date: Thu, 30 Aug 2012 22:17:06 -0400 (EDT)
From: Zhouping Liu <zliu@redhat.com>
Message-ID: <2010845654.62702417.1346379426384.JavaMail.root@redhat.com>
In-Reply-To: <50401D36.3090305@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 3/3] tunable/min_free_kbytes: add 32-bit system
 limit
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
Cc: LTP list <ltp-list@lists.sourceforge.net>



----- Original Message -----
> From: "Wanlong Gao" <gaowanlong@cn.fujitsu.com>
> To: "Zhouping Liu" <zliu@redhat.com>
> Cc: "LTP list" <ltp-list@lists.sourceforge.net>, "Caspar Zhang" <caspar@casparzhang.com>
> Sent: Friday, August 31, 2012 10:11:02 AM
> Subject: Re: [LTP] [PATCH 3/3] tunable/min_free_kbytes: add 32-bit system limit
> 
> On 08/31/2012 10:07 AM, Zhouping Liu wrote:
> > 
> > ----- Original Message -----
> >> > From: "Zhouping Liu" <zliu@redhat.com>
> >> > To: "LTP list" <ltp-list@lists.sourceforge.net>
> >> > Sent: Wednesday, August 29, 2012 8:43:59 PM
> >> > Subject: [LTP] [PATCH 3/3] tunable/min_free_kbytes: add 32-bit
> >> > system limit
> >> > 
> >> > in 32-bit system, one process only allocate 3Gb memory at
> >> > least, even though there are enough memory and setting
> > I'm sorry that the above sentences has a typo, 'at least' should be
> > changed as 'at most', so maintainers, please correct it if you
> > apply the patch.
> > please let me know if you need me send a V2.
> 
> This typo is harmless, no need. I wanna know if Caspar like to review
> this set.

Okay, Thank you for quickly replying :)

> 
> Thanks,
> Wanlong Gao
> 
> > 
> > Thanks,
> > Zhouping
> > 
> 
> 

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
