From: Hoang Nguyen <the_hoang0709@yahoo.com>
Date: Fri, 3 Mar 2017 01:26:00 +0000 (UTC)
Subject: [LTP] memcg_stress on swap off system.
In-Reply-To: <1992281802.879695.1486602784905@mail.yahoo.com>
References: <1992281802.879695.1486602784905.ref@mail.yahoo.com>
 <1992281802.879695.1486602784905@mail.yahoo.com>
Message-ID: <1326520780.892477.1488504360084@mail.yahoo.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi, 
On the ocassion of my last patch of panic_on_oom, ping this also.
Thanks and regards,
Hoang

      From: Hoang Nguyen <the_hoang0709@yahoo.com>
 To: LTP List <ltp@lists.linux.it> 
 Sent: Thursday, 9 February 2017, 8:13
 Subject: [LTP] memcg_stress on swap off system.
   
Hi LTP team,
I have this testcase run on my swap off system, and seem that the OOM restart it
I'm not sure I understand the entirely purpose of the testcase.But it seems the testcases try to allocate all free memory remain on the system,keep it for a while, then the main process send the signal to kill child process
   mem=$(( $mem_free + $swap_free / 2 ))   mem=$(( mem / 1024 ))
In case we have no swap_free, all memory is allocated, and trigger the OOM.I've still concerned which should be correct appoarch on swap-off system ? (set panic_on_oom=0 to avoid restaring Or the testcase shouldcheck if swap_free = 0, then we margin 10% of the final $mem ?)
(actullay pass/fail metric of this testcase is not so clear with me)
Could anyone give me some hints ?
Thanks a lot in advance
Hoang

   
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170303/f182a485/attachment.html>
