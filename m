Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <huruomu@gmail.com>) id 1RljiN-0007xY-SV
	for ltp-list@lists.sourceforge.net; Fri, 13 Jan 2012 16:10:51 +0000
Received: from mail-qy0-f195.google.com ([209.85.216.195])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1RljiI-0004RD-HM
	for ltp-list@lists.sourceforge.net; Fri, 13 Jan 2012 16:10:51 +0000
Received: by qcsr22 with SMTP id r22so53043qcs.10
	for <ltp-list@lists.sourceforge.net>;
	Fri, 13 Jan 2012 08:10:41 -0800 (PST)
MIME-Version: 1.0
Date: Sat, 14 Jan 2012 00:04:15 +0800
Message-ID: <CANoG8sUjtP3bMNjKNvwGO+Pb1GXJ6dYNDsYvjui=fd=fsYcQKw@mail.gmail.com>
From: Romu <huruomu@gmail.com>
Subject: [LTP] mbind01 fails on 2.6.32 i386 kernel
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
To: ltp-list@lists.sourceforge.net

Hi,

mbind01 fails on 2.6.32 i386 kernel, see test log below.  I went
through http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg08843.html
but couldn't get any clue.  Any idea?

<<<test_start>>>
tag=mbind01 stime=1326570882
cmdline="mbind01"
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
mbind01     0  TINFO  :  (case00) START
EXPECT: return value(ret)=0 errno=0 (Success)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
mbind01     1  TFAIL  :  (case00) END: errno=???(38): Function not implemented
mbind01     0  TINFO  :  (case01) START
EXPECT: return value(ret)=-1 errno=22 (Invalid argument)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
mbind01     2  TFAIL  :  (case01) END: errno=???(38): Function not implemented
mbind01     0  TINFO  :  (case02) START
EXPECT: return value(ret)=-1 errno=22 (Invalid argument)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
mbind01     3  TFAIL  :  (case02) END: errno=???(38): Function not implemented
mbind01     0  TINFO  :  (case03) START
EXPECT: return value(ret)=0 errno=0 (Success)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
mbind01     4  TFAIL  :  (case03) END: errno=???(38): Function not implemented
mbind01     0  TINFO  :  (case04) START
EXPECT: return value(ret)=-1 errno=22 (Invalid argument)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
mbind01     5  TFAIL  :  (case04) END: errno=???(38): Function not implemented
mbind01     0  TINFO  :  (case05) START
EXPECT: return value(ret)=0 errno=0 (Success)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
mbind01     6  TFAIL  :  (case05) END: errno=???(38): Function not implemented
mbind01     0  TINFO  :  (case06) START
EXPECT: return value(ret)=0 errno=0 (Success)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
mbind01     7  TFAIL  :  (case06) END: errno=???(38): Function not implemented
mbind01     0  TINFO  :  (case07) START
EXPECT: return value(ret)=0 errno=0 (Success)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
mbind01     8  TFAIL  :  (case07) END: errno=???(38): Function not implemented
mbind01     0  TINFO  :  (case08) START
EXPECT: return value(ret)=-1 errno=22 (Invalid argument)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
mbind01     9  TFAIL  :  (case08) END: errno=???(38): Function not implemented
mbind01     0  TINFO  :  (case09) START
EXPECT: return value(ret)=-1 errno=22 (Invalid argument)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
mbind01    10  TFAIL  :  (case09) END: errno=???(38): Function not implemented
mbind01     0  TINFO  :  (case10) START
EXPECT: return value(ret)=-1 errno=14 (Bad address)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
mbind01    11  TFAIL  :  (case10) END: errno=???(38): Function not implemented
mbind01     0  TINFO  :  (case00) START
EXPECT: return value(ret)=0 errno=0 (Success)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
mbind01    12  TFAIL  :  (case00) END: errno=???(38): Function not implemented
mbind01     0  TINFO  :  (case01) START
EXPECT: return value(ret)=-1 errno=22 (Invalid argument)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
mbind01    13  TFAIL  :  (case01) END: errno=???(38): Function not implemented
mbind01     0  TINFO  :  (case02) START
EXPECT: return value(ret)=-1 errno=22 (Invalid argument)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
mbind01    14  TFAIL  :  (case02) END: errno=???(38): Function not implemented
mbind01     0  TINFO  :  (case03) START
EXPECT: return value(ret)=0 errno=0 (Success)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
mbind01    15  TFAIL  :  (case03) END: errno=???(38): Function not implemented
mbind01     0  TINFO  :  (case04) START
EXPECT: return value(ret)=-1 errno=22 (Invalid argument)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
mbind01    16  TFAIL  :  (case04) END: errno=???(38): Function not implemented
mbind01     0  TINFO  :  (case05) START
EXPECT: return value(ret)=0 errno=0 (Success)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
mbind01    17  TFAIL  :  (case05) END: errno=???(38): Function not implemented
mbind01     0  TINFO  :  (case06) START
EXPECT: return value(ret)=0 errno=0 (Success)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
mbind01    18  TFAIL  :  (case06) END: errno=???(38): Function not implemented
mbind01     0  TINFO  :  (case07) START
EXPECT: return value(ret)=0 errno=0 (Success)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
mbind01    19  TFAIL  :  (case07) END: errno=???(38): Function not implemented
mbind01     0  TINFO  :  (case08) START
EXPECT: return value(ret)=-1 errno=22 (Invalid argument)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
mbind01    20  TFAIL  :  (case08) END: errno=???(38): Function not implemented
mbind01     0  TINFO  :  (case09) START
EXPECT: return value(ret)=-1 errno=22 (Invalid argument)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
mbind01    21  TFAIL  :  (case09) END: errno=???(38): Function not implemented
mbind01     0  TINFO  :  (case10) START
EXPECT: return value(ret)=-1 errno=14 (Bad address)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
mbind01    22  TFAIL  :  (case10) END: errno=???(38): Function not implemented
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=0
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: LTP-20120104


Thanks
Romu

------------------------------------------------------------------------------
RSA(R) Conference 2012
Mar 27 - Feb 2
Save $400 by Jan. 27
Register now!
http://p.sf.net/sfu/rsa-sfdev2dev2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
