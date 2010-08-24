Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <tosubrata@gmail.com>) id 1Onnii-0001er-Ht
	for ltp-list@lists.sourceforge.net; Tue, 24 Aug 2010 07:14:56 +0000
Received: from mail-pv0-f175.google.com ([74.125.83.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Onnih-0003N1-C0
	for ltp-list@lists.sourceforge.net; Tue, 24 Aug 2010 07:14:56 +0000
Received: by pvg6 with SMTP id 6so2873656pvg.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 24 Aug 2010 00:14:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4C72BC94.1090608@hartkopp.net>
References: <4C72BC94.1090608@hartkopp.net>
Date: Tue, 24 Aug 2010 12:44:49 +0530
Message-ID: <AANLkTikVh2ycuxGh5P0mf4EZFbUirUd7yJZHyfCgWp=Y@mail.gmail.com>
From: Subrata Modak <tosubrata@gmail.com>
Subject: Re: [LTP] New LTP test for CAN packet flow
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5579855101512478680=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: SocketCAN Core Mailing List <socketcan-core@lists.berlios.de>, LTP <ltp-list@lists.sourceforge.net>

--===============5579855101512478680==
Content-Type: multipart/alternative; boundary=001636458afc49937f048e8c858b

--001636458afc49937f048e8c858b
Content-Type: text/plain; charset=UTF-8

Thanks very much. Not sure why it did not reach the actual LTP mailing list
:-(

Regards--
Subrata

On Mon, Aug 23, 2010 at 11:53 PM, Oliver Hartkopp <socketcan@hartkopp.net>wrote:

> Dear Subrata,
>
> long time - no update ;-)
>
> But now i created a test that's able to detect a corrupt CAN frame flow
> inside
> the Kernel. So far the correct IFF_ECHO functionality has been accidentally
> removed by netdev patches two times.
>
> The latest fix was here:
>
>
> http://git.kernel.org/?p=linux/kernel/git/davem/net-2.6.git;a=commitdiff;h=cff0d6e6edac7672b3f915bb4fb59f279243b7f9
>
> To perform the local echo of CAN frames, the reference to the originating
> sock
> struct has to be passed to the netdevice without orphan of the
> socketbuffer.
>
> The new test tool 'tst-rcv-own-msgs' can check the correct packet flow by
> creating two can-raw sockets.
>
> To extend your test-script in
>
>    network/can/filter-tests/run_ltp-can_tests.sh
>
> the modprobe of the vcan driver needs an additional parameter 'echo=1',
> which
> configures the driver to perform the CAN frame echo on driver level.
>
> This 'echo=1' setting does not have any impact to the filtertest performed
> in
> your script.
>
> The new tool 'tst-rcv-own-msgs' can be found in the same directory in the
> SocketCAN SVN where the current 'tst-filter-server' and 'tst-filter-master'
> tools are located too.
>
> I'll send the latest fix (see above) to the stable tree, as 2.6.35.3
> currently
> still *has* this problem.
>
> On 2.6.35.3 you can see 'tst-rcv-own-msgs' ...
>
>   - work correctly when echo=0
>   - will fail when echo=1
>
> On 2.6.36-rc1 'tst-rcv-own-msgs' runs successfully regardless of the 'echo'
> setting of the vcan driver.
>
> Please give me feedback, if there are still open questions.
>
> Many thanks for your work & best regards,
> Oliver
>
>
> ---
>
> Load vcan module with commandline parameter echo=1 :
>
> root@host:~# modprobe vcan echo=1
> root@host:~# ip link add dev vcan0 type vcan
> root@host:~# ip link set vcan0 up
>
> ---
>
> When the test is successful, it looks like this:
>
> user@host:~$ socketcan/trunk/test/tst-rcv-own-msgs vcan0
> Starting PF_CAN frame flow test.
> checking socket default settings ... ok.
> check loopback 0 recv_own_msgs 0 ... ok.
> check loopback 0 recv_own_msgs 1 ... ok.
> check loopback 1 recv_own_msgs 0 ... ok.
> check loopback 1 recv_own_msgs 1 ... ok.
> PF_CAN frame flow test was successful.
> user@host:~$ echo $?
> 0
> user@host:~$
>
> ---
>
> When the test fails, it looks like this:
>
> user@host:~$ socketcan/trunk/test/tst-rcv-own-msgs vcan0
> Starting PF_CAN frame flow test.
> checking socket default settings ... failure!
> user@host:~$ echo $?
> 1
> user@host:~$
>
> ---
>
>
>
> ------------------------------------------------------------------------------
> Sell apps to millions through the Intel(R) Atom(Tm) Developer Program
> Be part of this innovative community and reach millions of netbook users
> worldwide. Take advantage of special opportunities to increase revenue and
> speed time-to-market. Join now, and jumpstart your future.
> http://p.sf.net/sfu/intel-atom-d2d
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>



-- 
Regards & Thanks--
Subrata

--001636458afc49937f048e8c858b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Thanks very much. Not sure why it did not reach the actual LTP mailing list=
 :-(<br><br>Regards--<br>Subrata<br><br><div class=3D"gmail_quote">On Mon, =
Aug 23, 2010 at 11:53 PM, Oliver Hartkopp <span dir=3D"ltr">&lt;<a href=3D"=
mailto:socketcan@hartkopp.net">socketcan@hartkopp.net</a>&gt;</span> wrote:=
<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Dear Subrata,<br>
<br>
long time - no update ;-)<br>
<br>
But now i created a test that&#39;s able to detect a corrupt CAN frame flow=
 inside<br>
the Kernel. So far the correct IFF_ECHO functionality has been accidentally=
<br>
removed by netdev patches two times.<br>
<br>
The latest fix was here:<br>
<br>
<a href=3D"http://git.kernel.org/?p=3Dlinux/kernel/git/davem/net-2.6.git;a=
=3Dcommitdiff;h=3Dcff0d6e6edac7672b3f915bb4fb59f279243b7f9" target=3D"_blan=
k">http://git.kernel.org/?p=3Dlinux/kernel/git/davem/net-2.6.git;a=3Dcommit=
diff;h=3Dcff0d6e6edac7672b3f915bb4fb59f279243b7f9</a><br>

<br>
To perform the local echo of CAN frames, the reference to the originating s=
ock<br>
struct has to be passed to the netdevice without orphan of the socketbuffer=
.<br>
<br>
The new test tool &#39;tst-rcv-own-msgs&#39; can check the correct packet f=
low by<br>
creating two can-raw sockets.<br>
<br>
To extend your test-script in<br>
<br>
 =C2=A0 =C2=A0network/can/filter-tests/run_ltp-can_tests.sh<br>
<br>
the modprobe of the vcan driver needs an additional parameter &#39;echo=3D1=
&#39;, which<br>
configures the driver to perform the CAN frame echo on driver level.<br>
<br>
This &#39;echo=3D1&#39; setting does not have any impact to the filtertest =
performed in<br>
your script.<br>
<br>
The new tool &#39;tst-rcv-own-msgs&#39; can be found in the same directory =
in the<br>
SocketCAN SVN where the current &#39;tst-filter-server&#39; and &#39;tst-fi=
lter-master&#39;<br>
tools are located too.<br>
<br>
I&#39;ll send the latest fix (see above) to the stable tree, as 2.6.35.3 cu=
rrently<br>
still *has* this problem.<br>
<br>
On 2.6.35.3 you can see &#39;tst-rcv-own-msgs&#39; ...<br>
<br>
 =C2=A0 - work correctly when echo=3D0<br>
 =C2=A0 - will fail when echo=3D1<br>
<br>
On 2.6.36-rc1 &#39;tst-rcv-own-msgs&#39; runs successfully regardless of th=
e &#39;echo&#39;<br>
setting of the vcan driver.<br>
<br>
Please give me feedback, if there are still open questions.<br>
<br>
Many thanks for your work &amp; best regards,<br>
Oliver<br>
<br>
<br>
---<br>
<br>
Load vcan module with commandline parameter echo=3D1 :<br>
<br>
root@host:~# modprobe vcan echo=3D1<br>
root@host:~# ip link add dev vcan0 type vcan<br>
root@host:~# ip link set vcan0 up<br>
<br>
---<br>
<br>
When the test is successful, it looks like this:<br>
<br>
user@host:~$ socketcan/trunk/test/tst-rcv-own-msgs vcan0<br>
Starting PF_CAN frame flow test.<br>
checking socket default settings ... ok.<br>
check loopback 0 recv_own_msgs 0 ... ok.<br>
check loopback 0 recv_own_msgs 1 ... ok.<br>
check loopback 1 recv_own_msgs 0 ... ok.<br>
check loopback 1 recv_own_msgs 1 ... ok.<br>
PF_CAN frame flow test was successful.<br>
user@host:~$ echo $?<br>
0<br>
user@host:~$<br>
<br>
---<br>
<br>
When the test fails, it looks like this:<br>
<br>
user@host:~$ socketcan/trunk/test/tst-rcv-own-msgs vcan0<br>
Starting PF_CAN frame flow test.<br>
checking socket default settings ... failure!<br>
user@host:~$ echo $?<br>
1<br>
user@host:~$<br>
<br>
---<br>
<br>
<br>
---------------------------------------------------------------------------=
---<br>
Sell apps to millions through the Intel(R) Atom(Tm) Developer Program<br>
Be part of this innovative community and reach millions of netbook users<br=
>
worldwide. Take advantage of special opportunities to increase revenue and<=
br>
speed time-to-market. Join now, and jumpstart your future.<br>
<a href=3D"http://p.sf.net/sfu/intel-atom-d2d" target=3D"_blank">http://p.s=
f.net/sfu/intel-atom-d2d</a><br>
_______________________________________________<br>
Ltp-list mailing list<br>
<a href=3D"mailto:Ltp-list@lists.sourceforge.net">Ltp-list@lists.sourceforg=
e.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/ltp-list" target=3D=
"_blank">https://lists.sourceforge.net/lists/listinfo/ltp-list</a><br>
</blockquote></div><br><br clear=3D"all"><br>-- <br>Regards &amp; Thanks--<=
br>Subrata<br>

--001636458afc49937f048e8c858b--


--===============5579855101512478680==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Sell apps to millions through the Intel(R) Atom(Tm) Developer Program
Be part of this innovative community and reach millions of netbook users 
worldwide. Take advantage of special opportunities to increase revenue and 
speed time-to-market. Join now, and jumpstart your future.
http://p.sf.net/sfu/intel-atom-d2d
--===============5579855101512478680==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5579855101512478680==--

