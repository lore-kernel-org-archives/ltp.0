Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1SU8Hu-0005WP-VV
	for ltp-list@lists.sourceforge.net; Tue, 15 May 2012 03:19:02 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SU8Ht-0002bE-TY
	for ltp-list@lists.sourceforge.net; Tue, 15 May 2012 03:19:02 +0000
Date: Mon, 14 May 2012 23:18:50 -0400 (EDT)
From: Zhouping Liu <zliu@redhat.com>
Message-ID: <659b63f6-b191-4e73-84f7-37e33d4c9873@zmail13.collab.prod.int.phx2.redhat.com>
In-Reply-To: <4FB1C5E5.10407@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] ksm03
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
Cc: LTP List <ltp-list@lists.sourceforge.net>



----- Original Message -----
> From: "Wanlong Gao" <gaowanlong@cn.fujitsu.com>
> To: "ZhoupingLiu" <zliu@redhat.com>
> Cc: "Caspar Zhang" <caspar@casparzhang.com>, "LTP List" <ltp-list@lists.sourceforge.net>
> Sent: Tuesday, May 15, 2012 10:56:37 AM
> Subject: Re: [LTP] ksm03
> 
> On 04/05/2012 01:21 PM, ZhoupingLiu wrote:
> 
> > On 04/05/2012 01:04 PM, Wanlong Gao wrote:
> >> On 04/05/2012 01:00 PM, ZhoupingLiu wrote:
> >>
> >>> On 04/02/2012 02:56 PM, Wanlong Gao wrote:
> >>>> Hi Caspar,
> >>>>
> >>>> Have you ever seen like below? It happens on ksm03,
> >>>> the page_sharing numbers is always incorrect, it
> >>>> occurs on RHEL7-Alpha, any ides?
> >>> hi, Wanlong
> >>>
> >>> I caught this error, but it just only occurred in s390x,
> >>> and not 100% occurred, I will check the reason.
> >>> could you tell me which arches do you met the issue?
> >>
> >> Not fortunately, I met on x86_64 :(
> >> and the case can't finish then.
> > 
> > Okay, I'll dig it deeper, thanks for your info.
> 
> 
> Got any idea? :-)

Wanlong, as the case is not always occurred in my testing boxes,
I'm sorry I don't find the real reason now, but I'll speed up
to find the murderer, if you have any info, please let me know :)

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
