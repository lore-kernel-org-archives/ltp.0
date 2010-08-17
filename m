Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <gurudas.pai@oracle.com>) id 1OlDwM-0007qx-2h
	for ltp-list@lists.sourceforge.net; Tue, 17 Aug 2010 04:38:22 +0000
Received: from rcsinet10.oracle.com ([148.87.113.121])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OlDwL-0002fY-9n
	for ltp-list@lists.sourceforge.net; Tue, 17 Aug 2010 04:38:22 +0000
Message-ID: <4C6A0F0C.9030508@oracle.com>
Date: Tue, 17 Aug 2010 09:54:44 +0530
From: Gurudas Pai <gurudas.pai@oracle.com>
MIME-Version: 1.0
References: <4C5666AC.60308@oracle.com>
	<AANLkTinzpQFWKH3chM+2DxPbTCcR-LMrok9kav-y=7e5@mail.gmail.com>
In-Reply-To: <AANLkTinzpQFWKH3chM+2DxPbTCcR-LMrok9kav-y=7e5@mail.gmail.com>
Subject: Re: [LTP] LTP-20100630:quota_remount_test01.sh test fails.
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
To: Garrett Cooper <yanegomi@gmail.com>, subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net



Garrett Cooper wrote:
> On Sun, Aug 1, 2010 at 11:33 PM, Gurudas Pai <gurudas.pai@oracle.com> wrote:
>> Hi,
>>
>> quota_remount_test01.sh test fails.
>>

> What Linux distro and what version of whatever package that quota
> comes with (might be coreutils*, but Linux keeps on playing musical
> chairs with the applications and it varies from distro to distro)?
> 
> From what I see above, maybe your distro should just fix the command
> to be BSD compatible like most other distros have done; -f corresponds
> to:
> 
>      -f path
>              Only display quota information for the file system that contains
>              the specified path.  This can be any file within a mounted file
>              system.
> 
> Otherwise the test is going to become unnecessarily complicated.
> 
> -Garrett
quota "-f" and "-w" are not supported in quota-3.13-1.2.5.el5 which I 
was using, upgraded it to 3.14 and it worked well, test passed !


@ Changes in quota-tools from 3.13 to 3.14
@  ...
@ * quota(1) has -f option to specify filesystem list (Jan Kara)
@ ...
@ * quota(1) has -w option to supress line wrapping for long device 
names (Jan
@ Kara)


Thank you Subrata, Garret for your time and effort.

Best Regards,
-Guru

------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
