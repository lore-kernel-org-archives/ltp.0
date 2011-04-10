Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <czhang@redhat.com>) id 1Q8qvr-0007dz-65
	for ltp-list@lists.sourceforge.net; Sun, 10 Apr 2011 09:27:47 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1Q8qvq-0007f4-8t
	for ltp-list@lists.sourceforge.net; Sun, 10 Apr 2011 09:27:47 +0000
Message-ID: <4DA177FE.1000304@redhat.com>
Date: Sun, 10 Apr 2011 17:27:26 +0800
From: Caspar Zhang <czhang@redhat.com>
MIME-Version: 1.0
References: <06e447138f8f007517bb5c09cd96ffd4804a95d5.1302319401.git.czhang@redhat.com>	<BANLkTi=b=n56Ef8HGDF4drXLWm9RXvOH1g@mail.gmail.com>	<4DA13284.3090007@redhat.com>
	<BANLkTim_9bJi==MyPHoeQtjo+wLL-XJ=8A@mail.gmail.com>
In-Reply-To: <BANLkTim_9bJi==MyPHoeQtjo+wLL-XJ=8A@mail.gmail.com>
Subject: Re: [LTP] [PATCH v2 1/2] [mm] mbind01: not working on 32bit systems
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
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 04/10/2011 05:19 PM, Garrett Cooper wrote:
>     I wouldn't worry too much about it. If it fails with ENOSYS, I
> would just fail with tst_brkm(TCONF, ...).

Would something like this be good:

err = mbind(addr+pagesize, pagesize, MPOL_BIND, nmask->maskp,
nmask->size, MPOL_MF_MOVE_ALL);
if (err != 0)
  if (errno == ENOSYS)
    tst_brkm(TCONF,...)
  else
    tst_brkm(TBROK|TERRNO, NULL, "mbind1");

If yes, I'll work out an updated patch soon.

Thanks,
Caspar

------------------------------------------------------------------------------
Xperia(TM) PLAY
It's a major breakthrough. An authentic gaming
smartphone on the nation's most reliable network.
And it wants your games.
http://p.sf.net/sfu/verizon-sfdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
