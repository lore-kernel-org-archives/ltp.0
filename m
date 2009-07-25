Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michal.simek@petalogix.com>) id 1MUaXx-0003cj-6Q
	for ltp-list@lists.sourceforge.net; Sat, 25 Jul 2009 06:15:53 +0000
Received: from fg-out-1718.google.com ([72.14.220.158])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MUaXr-0000Xg-4U
	for ltp-list@lists.sourceforge.net; Sat, 25 Jul 2009 06:15:53 +0000
Received: by fg-out-1718.google.com with SMTP id e12so214245fga.9
	for <ltp-list@lists.sourceforge.net>;
	Fri, 24 Jul 2009 23:15:40 -0700 (PDT)
Message-ID: <4A6AA306.3060107@petalogix.com>
Date: Sat, 25 Jul 2009 08:15:34 +0200
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
References: <20090724110008.GA11878@linux.vnet.ibm.com>
In-Reply-To: <20090724110008.GA11878@linux.vnet.ibm.com>
Subject: Re: [LTP] Submitting patch
Reply-To: michal.simek@petalogix.com
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
To: Jyoti <jyotiv@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

Please fix coding style. Use tab instead of space for indentation.

Thanks,
Michal
> PATCH IS CREATED FOR ltp-full-20090630.
>
> I am submitting a patch to kernel/fs/fs_di
>
> In this file data integity is performed by creating the file at
> different directory depth and then by comparing with original file.
>
> To this I have added one more approach to perform integrity test.
> 1. Creating two fragmented files each of size DiskSize/2.
> 2. Then comapring against the original file.
> 3. If not equal test case fails.
>
> My ultimate goal in creating fragmented files is that,
> 1. It creates many extents (fragments for each file)
> 2. FS code may behave wrong at corner cases which may come into picture
>    after many extents gets added to the file.
> 3. Data corruption chances are there 
>      i. when file metadata updation is not proper (corner cases when fragments are more)
>      ii.If write and read is not matching (write operation might have updated the block 
>         number some where and read may skip that block in some corner cases)
> 4. In reality fragments can occur only after much usage of the disk(create/delete file)
> 5. This is good test case for bigger size disk.(it can create more extents)
>
>
> To: ltp-list@lists.sourceforge.net
> Cc: subrata@linux.vnet.ibm.com
> Bcc: Jyoti <jyotiv@linux.vnet.ibm.com>
> Subject: Submitting patch 
> Reply-To: Jyoti <jyotiv@linux.vnet.ibm.com>
>
>   
> ------------------------------------------------------------------------
>
> ------------------------------------------------------------------------------
> ------------------------------------------------------------------------
>
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
