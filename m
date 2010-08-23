Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <socketcan@hartkopp.net>) id 1Onc4R-0007WR-Td
	for ltp-list@lists.sourceforge.net; Mon, 23 Aug 2010 18:48:35 +0000
Received: from mo-p00-ob.rzone.de ([81.169.146.161])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Onc4N-00073V-8O
	for ltp-list@lists.sourceforge.net; Mon, 23 Aug 2010 18:48:35 +0000
Message-ID: <4C72BC94.1090608@hartkopp.net>
Date: Mon, 23 Aug 2010 20:23:16 +0200
From: Oliver Hartkopp <socketcan@hartkopp.net>
MIME-Version: 1.0
Subject: [LTP] New LTP test for CAN packet flow
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: SocketCAN Core Mailing List <socketcan-core@lists.berlios.de>, ltp-list <ltp-list@lists.sf.net>

Dear Subrata,

long time - no update ;-)

But now i created a test that's able to detect a corrupt CAN frame flow inside
the Kernel. So far the correct IFF_ECHO functionality has been accidentally
removed by netdev patches two times.

The latest fix was here:

http://git.kernel.org/?p=linux/kernel/git/davem/net-2.6.git;a=commitdiff;h=cff0d6e6edac7672b3f915bb4fb59f279243b7f9

To perform the local echo of CAN frames, the reference to the originating sock
struct has to be passed to the netdevice without orphan of the socketbuffer.

The new test tool 'tst-rcv-own-msgs' can check the correct packet flow by
creating two can-raw sockets.

To extend your test-script in

    network/can/filter-tests/run_ltp-can_tests.sh

the modprobe of the vcan driver needs an additional parameter 'echo=1', which
configures the driver to perform the CAN frame echo on driver level.

This 'echo=1' setting does not have any impact to the filtertest performed in
your script.

The new tool 'tst-rcv-own-msgs' can be found in the same directory in the
SocketCAN SVN where the current 'tst-filter-server' and 'tst-filter-master'
tools are located too.

I'll send the latest fix (see above) to the stable tree, as 2.6.35.3 currently
still *has* this problem.

On 2.6.35.3 you can see 'tst-rcv-own-msgs' ...

   - work correctly when echo=0
   - will fail when echo=1

On 2.6.36-rc1 'tst-rcv-own-msgs' runs successfully regardless of the 'echo'
setting of the vcan driver.

Please give me feedback, if there are still open questions.

Many thanks for your work & best regards,
Oliver


---

Load vcan module with commandline parameter echo=1 :

root@host:~# modprobe vcan echo=1
root@host:~# ip link add dev vcan0 type vcan
root@host:~# ip link set vcan0 up

---

When the test is successful, it looks like this:

user@host:~$ socketcan/trunk/test/tst-rcv-own-msgs vcan0
Starting PF_CAN frame flow test.
checking socket default settings ... ok.
check loopback 0 recv_own_msgs 0 ... ok.
check loopback 0 recv_own_msgs 1 ... ok.
check loopback 1 recv_own_msgs 0 ... ok.
check loopback 1 recv_own_msgs 1 ... ok.
PF_CAN frame flow test was successful.
user@host:~$ echo $?
0
user@host:~$

---

When the test fails, it looks like this:

user@host:~$ socketcan/trunk/test/tst-rcv-own-msgs vcan0
Starting PF_CAN frame flow test.
checking socket default settings ... failure!
user@host:~$ echo $?
1
user@host:~$

---


------------------------------------------------------------------------------
Sell apps to millions through the Intel(R) Atom(Tm) Developer Program
Be part of this innovative community and reach millions of netbook users 
worldwide. Take advantage of special opportunities to increase revenue and 
speed time-to-market. Join now, and jumpstart your future.
http://p.sf.net/sfu/intel-atom-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
