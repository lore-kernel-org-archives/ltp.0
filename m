Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1T7GjP-0002Ca-6Y
	for ltp-list@lists.sourceforge.net; Fri, 31 Aug 2012 02:13:11 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1T7GjO-0000Cc-A6
	for ltp-list@lists.sourceforge.net; Fri, 31 Aug 2012 02:13:11 +0000
Message-ID: <50401D36.3090305@cn.fujitsu.com>
Date: Fri, 31 Aug 2012 10:11:02 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <850600673.62700357.1346378820659.JavaMail.root@redhat.com>
In-Reply-To: <850600673.62700357.1346378820659.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH 3/3] tunable/min_free_kbytes: add 32-bit system
 limit
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
Cc: LTP list <ltp-list@lists.sourceforge.net>

On 08/31/2012 10:07 AM, Zhouping Liu wrote:
> 
> ----- Original Message -----
>> > From: "Zhouping Liu" <zliu@redhat.com>
>> > To: "LTP list" <ltp-list@lists.sourceforge.net>
>> > Sent: Wednesday, August 29, 2012 8:43:59 PM
>> > Subject: [LTP] [PATCH 3/3] tunable/min_free_kbytes: add 32-bit system limit
>> > 
>> > in 32-bit system, one process only allocate 3Gb memory at
>> > least, even though there are enough memory and setting
> I'm sorry that the above sentences has a typo, 'at least' should be
> changed as 'at most', so maintainers, please correct it if you apply the patch.
> please let me know if you need me send a V2.

This typo is harmless, no need. I wanna know if Caspar like to review this set.

Thanks,
Wanlong Gao

> 
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
