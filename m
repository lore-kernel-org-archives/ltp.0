Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OcFTY-0001Dw-02
	for ltp-list@lists.sourceforge.net; Fri, 23 Jul 2010 10:27:32 +0000
Received: from e6.ny.us.ibm.com ([32.97.182.146])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OcFTV-0007JU-Pv
	for ltp-list@lists.sourceforge.net; Fri, 23 Jul 2010 10:27:31 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20100711224154.GA496240@medusa.sis.pasteur.fr>
References: <20100711224154.GA496240@medusa.sis.pasteur.fr>
Date: Fri, 23 Jul 2010 15:57:10 +0530
Message-Id: <1279880836.11936.9.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] clock_getres01: remove TERRNO flag for overall test	result
Reply-To: subrata@linux.vnet.ibm.com
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP list <ltp-list@lists.sf.net>

Garret,

This has not been reviewed/Acked !!

Regards--
Subrata

On Mon, 2010-07-12 at 00:41 +0200, Nicolas Joly wrote:
> Hi,
> 
> The attached patch remove the TERRNO flag for the overall
> clock_getres01 test status. It is wrong because, if one of the test
> fails, the reported errno will always be the one from the last case05
> test (even 0 if this one was successful).
> 
> Upon failure, the output will be:
> 
> [...]
> clock_getres01    0  TINFO  :  (case05) START
> EXPECT: return value(ret)=(N >= 0) errno=0 (Success)
> RESULT: return value(ret)=       0 errno=0 (Success)
> clock_getres01    6  TPASS  :  (case05) END
> clock_getres01    7  TFAIL  :  clock_getres01 failed
> 
> But previously:
> 
> [...]
> clock_getres01    0  TINFO  :  (case05) START
> EXPECT: return value(ret)=(N >= 0) errno=0 (Success)
> RESULT: return value(ret)=       0 errno=0 (Success)
> clock_getres01    6  TPASS  :  (case05) END
> clock_getres01    7  TFAIL  :  clock_getres01 failed: errno=???(0): Success
> 
> Signed-off-by: Nicolas Joly <njoly@pasteur.fr>
> 
> Regards.
> 
> ------------------------------------------------------------------------------
> This SF.net email is sponsored by Sprint
> What will you do first with EVO, the first 4G phone?
> Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
> _______________________________________________ Ltp-list mailing list Ltp-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
