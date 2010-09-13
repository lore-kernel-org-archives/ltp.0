Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <ext-hannu.m.heikkinen@nokia.com>) id 1Ov9aT-0003xV-Vk
	for ltp-list@lists.sourceforge.net; Mon, 13 Sep 2010 14:00:49 +0000
Received: from smtp.nokia.com ([192.100.122.233] helo=mgw-mx06.nokia.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Ov9aS-0006hU-7B
	for ltp-list@lists.sourceforge.net; Mon, 13 Sep 2010 14:00:49 +0000
Date: Mon, 13 Sep 2010 16:58:54 +0000
From: Hannu Heikkinen <ext-hannu.m.heikkinen@nokia.com>
Message-ID: <20100913165854.GA28597@hannu-debian.research.nokia.com>
References: <4C8E224C.7060204@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4C8E224C.7060204@suse.de>
Subject: Re: [LTP] no configure file in source
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
To: ext Yi Xu <yxu@suse.de>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

On 13/09/10 15:08 +0200, ext Yi Xu wrote:
> Hi,
> 
> the configure* files are gone in ltp-full-20100831.tgz. What was the
> reason for that? How should I compile the source now?
> 
> thanks for your answer.
> 
> Yi
> -- 
> Yi Xu                           yxu@suse.de
> SUSE LINUX Products GmbH        R&D-OPS-QA
> Maxfeldstr. 5                   +49 (0)911-74053 - 607
> D-90409 Nuernberg               http://www.suse.de
> 
> SUSE LINUX Products GmbH, GF: Markus Rex, HRB 16746 (AG Nuernberg)
> 
> ------------------------------------------------------------------------------
> Start uncovering the many advantages of virtual appliances
> and start using them to simplify application deployment and
> accelerate your shift to cloud computing
> http://p.sf.net/sfu/novell-sfdev2dev
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

Hi,

just run 
> make autotools
after that scripts appears.

br,
Hannu

-- 
Hannu Heikkinen
ext-hannu.m.heikkinen CHANGE_TO_AT nokia.com
http://www.nixu.com

------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
