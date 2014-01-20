Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1W5HQB-0007IV-M8
	for ltp-list@lists.sourceforge.net; Mon, 20 Jan 2014 16:09:55 +0000
Date: Mon, 20 Jan 2014 17:09:28 +0100
From: chrubis@suse.cz
Message-ID: <20140120160927.GA1280@rei.suse.cz>
References: <1383124058-13133-3-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1386840115-9703-2-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1386840115-9703-2-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH V3 2/2] setpgid03: use tst_checkpoint interface
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> I came accross the following rare issue:
> 
> setpgid03    1  TPASS  :  setpgid SUCCESS to set errno to EPERM
> setpgid03    2  TFAIL  :  setpgid FAILED, expect EACCES got 1
> 
> I suppose it may happen if the test host is under stress.
> 
> To prevent this it would be better to use tst_checkpoint interface
> for parent-child synchronisations.

Pushed.

I've added a follow up patch that removes the alarm() timeout code in
the child and does a few more fixes.

The timeout should better be handled, if handled at all, in the
checkpoint code. I would not care much about this case because when the
parent is dead does not talk to the child the test will fail anyway...

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
