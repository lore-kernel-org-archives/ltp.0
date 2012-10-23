Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <omprakash.pal@stericsson.com>) id 1TQbMb-0007ly-5I
	for ltp-list@lists.sourceforge.net; Tue, 23 Oct 2012 10:05:33 +0000
Received: from eu1sys200aog104.obsmtp.com ([207.126.144.117])
	by sog-mx-3.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1TQbMV-000512-F0
	for ltp-list@lists.sourceforge.net; Tue, 23 Oct 2012 10:05:33 +0000
From: Om Prakash PAL <omprakash.pal@stericsson.com>
Date: Tue, 23 Oct 2012 12:05:07 +0200
Message-ID: <3ED83A9DB3B6D94CA68BF7C03F2981D35D01C26723@EXDCVYMBSTM006.EQ1STM.local>
References: <3ED83A9DB3B6D94CA68BF7C03F2981D35D01C266B4@EXDCVYMBSTM006.EQ1STM.local>
	<5086654E.1010303@cn.fujitsu.com>
In-Reply-To: <5086654E.1010303@cn.fujitsu.com>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [LTP] Regarding shmat01 syscall test
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



-----Original Message-----
From: Wanlong Gao [mailto:gaowanlong@cn.fujitsu.com] 
Sent: Tuesday, October 23, 2012 3:07 PM
To: Om Prakash PAL
Cc: ltp-list@lists.sourceforge.net
Subject: Re: [LTP] Regarding shmat01 syscall test

On 10/23/2012 05:24 PM, Om Prakash PAL wrote:
> Hi,
> 
> I am working on syscall test:  shmat01.c
> 
> I have some confusion:
> 
>  
> 
> In setup() : it is  allocating shared memory by shmget() and then attaching by shmat() and after  that detaching the attached address (i.e. shmdt())   
> 
>  
> 
>         if (shmdt((const void *)base_addr) == -1) {
> 
>                 tst_brkm(TBROK, cleanup, "Couldn't detach shared memory");
> 
>         }
> 
>  
> 
> And again in main function it is using same "base_addr" as attaching address,
> 
>  
> 
> addr = shmat(*(TC[i].shmid), base_addr+TC[i].offset,
> 
>                                      TC[i].flags);
> 
> how can we ensure(100%) that base_addr (virtual) will be free till this point for attaching?.

Maybe we can't, but I didn't see any fail on this. Did you see any testing failure here?

Yes, I got some failure and the reason of failure is : the address at which we want to attach is busy.

Best Regards,
Om Prakash Pal  



Thanks,
Wanlong Gao

> 
> there is possibility that this address(base_addr) will be used, so in that case this shmat() will fail.
> 
> Please correct me if I am wrong.
> 
> Thanks in advance.
> 
>  
> 
> Best Regards,
> 
> Om Prakash Pal   
> 
> 
> 
> ------------------------------------------------------------------------------
> Everyone hates slow websites. So do we.
> Make your web apps faster with AppDynamics
> Download AppDynamics Lite for free today:
> http://p.sf.net/sfu/appdyn_sfd2d_oct
> 
> 
> 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_sfd2d_oct
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
