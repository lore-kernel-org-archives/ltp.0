Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <michal.simek@petalogix.com>) id 1R88eA-0001ar-Nk
	for ltp-list@lists.sourceforge.net; Mon, 26 Sep 2011 10:42:50 +0000
Received: from mail-ey0-f175.google.com ([209.85.215.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1R88e9-00085W-Mf
	for ltp-list@lists.sourceforge.net; Mon, 26 Sep 2011 10:42:50 +0000
Received: by eya25 with SMTP id 25so4448960eya.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 26 Sep 2011 03:42:43 -0700 (PDT)
Message-ID: <4E805721.6020709@petalogix.com>
Date: Mon, 26 Sep 2011 12:42:41 +0200
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
References: <4E6DF0E4.1040004@linux.vnet.ibm.com>
In-Reply-To: <4E6DF0E4.1040004@linux.vnet.ibm.com>
Subject: Re: [LTP] [Patch v2] sockioctl01 test case fix
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
To: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

Nageswara R Sastry wrote:
> In sockioctl01 testcase,
> Current 'inappropriate ioctl operation returning EINVAL'
> With the git commit '41c31f318a5209922d051e293c61e4724daad11c' more 
> details at 
> http://permalink.gmane.org/gmane.linux.kernel.commits.head/296060
> 'inappropriate ioctl operation returning ENOTTY'
> 
> The following patch will fix this.
> 
> 
> sockioctl01:
> Before patch:
> ...
> sockioctl01    4  TFAIL  :  ATMARK on UDP ; returned -1 (expected -1), 
> errno 25 (expected 22)
> ...
> 
> After patch:
> ...
> sockioctl01    4  TPASS  :  ATMARK on UDP successful
> ...
> 
> P.S. patch has ran through checkpatch.pl
> 
> Signed-off-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>

Can someone add this patch to git?

Tested-by: Michal Simek <michal.simek@petalogix.com>

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663

------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure contains a
definitive record of customers, application performance, security
threats, fraudulent activity and more. Splunk takes this data and makes
sense of it. Business sense. IT sense. Common sense.
http://p.sf.net/sfu/splunk-d2dcopy1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
