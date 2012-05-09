Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1SS6WW-0004NF-8f
	for ltp-list@lists.sourceforge.net; Wed, 09 May 2012 13:01:44 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SS6WU-0002dz-1g
	for ltp-list@lists.sourceforge.net; Wed, 09 May 2012 13:01:44 +0000
Received: by pbbrq2 with SMTP id rq2so454221pbb.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 09 May 2012 06:01:36 -0700 (PDT)
Message-ID: <4FAA6A83.8010100@casparzhang.com>
Date: Wed, 09 May 2012 21:00:51 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <20120509221644.4d5f1819@Gantu>
In-Reply-To: <20120509221644.4d5f1819@Gantu>
Subject: Re: [LTP] [PATCH] Simple tests for cross memory attach
 (process_vm_[readv|writev] syscalls)
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
To: Christopher Yeoh <cyeoh@au1.ibm.com>
Cc: ltp-list@lists.sourceforge.net

On 05/09/2012 08:46 PM, Christopher Yeoh wrote:
> Hi,
> 
> Here are some patches which add testcases for cross memory attach (CMA)
> functionality which is included in more recent kernels. CMA adds two
> new syscalls, process_vm_readv and process_vm_writev.  Man pages for
> these two syscalls were added in the man-pages-3.40 release.
> 
> The testcases aren't really ready for inclusion as-is, but I thought
> they could do with some review now. One issue is that the syscall
> wrappers were not included in glibc until glibc 2.15 which not all
> distributions have picked up yet. For the testcases to compile I have a
> header file with some hard coded syscall numbers included (just for
> x86/powerpc atm, but more could be added). These numbers won't change
> in the future, but its an obviously ugly workaround.
> 
> Is this a show stopper problem? Do I have to wait until more
> distributions have picked up glibc 2.15 (or at least backported the
> glibc syscall wrappers) before it can be added to LTP? Or should I use
> some other workaround - eg detect if the syscalls are defined on the
> system and just not attempt to build the test if they aren't?
> 
> The testcases are not that extensive yet, just coverage of basic
> functionality.
> 
> Regards,
> 
> Chris
> 

Hi Chris, thanks very much for the patch, I tried to backport your
testcases in http://ozlabs.org/~cyeoh/cma/ to LTP and composed an
unfinished version, then I was busy for other things. I'm happy to see
you can backport it by yourself :) There are some more new cma patches
(aims on testing retcode and errnos) sent by Jan Stancek (cc-ed) [1], I
think we need to discuss the testcase organization..

And I will review the testcases when I get more free time.

Thanks,
Caspar

[1]
http://thread.gmane.org/gmane.linux.ltp/16052
http://thread.gmane.org/gmane.linux.ltp/16053
http://thread.gmane.org/gmane.linux.ltp/16054
http://thread.gmane.org/gmane.linux.ltp/16055

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
