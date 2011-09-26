Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <michal.simek@petalogix.com>) id 1R88em-0006wC-Qh
	for ltp-list@lists.sourceforge.net; Mon, 26 Sep 2011 10:43:28 +0000
Received: from mail-ey0-f175.google.com ([209.85.215.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1R88em-0005m2-1x
	for ltp-list@lists.sourceforge.net; Mon, 26 Sep 2011 10:43:28 +0000
Received: by eya25 with SMTP id 25so4449375eya.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 26 Sep 2011 03:43:21 -0700 (PDT)
Message-ID: <4E805746.4080503@petalogix.com>
Date: Mon, 26 Sep 2011 12:43:18 +0200
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
References: <4E6DF14F.8030800@linux.vnet.ibm.com>
In-Reply-To: <4E6DF14F.8030800@linux.vnet.ibm.com>
Subject: Re: [LTP] [Patch v2] readlink03 test case fix
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
> In readlink03 testcase,
> When 'Symlink Pathname is empty' the return value was 'ENOENT' but with 
> newer kernels the return value is 'EINVAL'. The following patch will fix 
> this.
> 
> readlink03:
> Before patch:
> ...
> readlink03    9  TFAIL  :  readlink() failed, Symlink Pathname is empty, 
> errno=22, expected errno=2
> ...
> 
> After patch:
> ...
> readlink03    9  TPASS  :  readlink(), Symlink Pathname is empty, 
> returned errno 22
> readlink03   10  TPASS  :  readlink(), Symlink Pathname is empty, 
> returned errno 22
> ...
> 
> Signed-off-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>

Please add it to mainline.

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
