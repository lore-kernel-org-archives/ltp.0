Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RdmNg-0000Mr-OO
	for ltp-list@lists.sourceforge.net; Thu, 22 Dec 2011 17:24:36 +0000
Date: Thu, 22 Dec 2011 18:34:21 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111222173421.GB5233@saboteur.suse.cz>
References: <1321609032-16026-1-git-send-email-caspar@casparzhang.com>
	<1321609032-16026-7-git-send-email-caspar@casparzhang.com>
	<20111222165119.GB3466@saboteur.suse.cz>
	<4EF3661F.6050802@casparzhang.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4EF3661F.6050802@casparzhang.com>
Subject: Re: [LTP] [PATCH v5 6/7] mm/zram01: verify content written to zram
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> > 
> > Hmm, I would make sure here, that I haven't read more than SIZE
> > characters. Eg. I wouldn't expect that device you are testing is null
> > terminated, even if you wrote the terminating zero there.
> 
> How about:
> 
> while (s[i] && i < SIZE-1) {
>   if (s[i] != 'a')
>     fail++;
>   i++;
> }
> 
> if (i != SIZE-1)
>   tst_resm(TFAIL, "expect size: %d, actual size: %d.", SIZE-1, i);
> else if (s[i] != '\0')
>   tst_resm(TFAIL, "zram device seems not null terminated");
> 

Looks OK.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
