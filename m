Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NMATO-00035t-7G
	for ltp-list@lists.sourceforge.net; Sun, 20 Dec 2009 01:20:38 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NMATJ-0005uu-7I
	for ltp-list@lists.sourceforge.net; Sun, 20 Dec 2009 01:20:38 +0000
Received: by pwj11 with SMTP id 11so2826688pwj.2
	for <ltp-list@lists.sourceforge.net>;
	Sat, 19 Dec 2009 17:20:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <op.u47eely5u2flwt@debian>
References: <4b2c37e0.6344f10a.4097.4c88SMTPIN_ADDED@mx.google.com>
	<364299f40912182002o417158c3lef65a301d721f1a0@mail.gmail.com>
	<op.u47eely5u2flwt@debian>
Date: Sat, 19 Dec 2009 17:20:27 -0800
Message-ID: <364299f40912191720x1806c16pae27daa6f99dac34@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] Fixes of the sendfile01 test
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: =?ISO-8859-2?B?Smn47SBQYWxl6GVr?= <jpalecek@web.de>
Cc: ltp-list@lists.sourceforge.net

2009/12/19 Ji=F8=ED Pale=E8ek <jpalecek@web.de>:
> On Sat, 19 Dec 2009 05:02:45 +0100, Garrett Cooper <yanegomi@gmail.com>
> wrote:
>
>> On Fri, Dec 18, 2009 at 6:16 PM, Jiri Palecek <jpalecek@web.de> wrote:
>>>
>>> Hello,
>>>
>>> I've found some problems with the sendfile01 testcase (the one under
>>> network/tcp_cmds). This patch fixes them:
>>>
>>> =A0Pass the -6 parameter to gethost if we are to use ipv6 and run the
>>> =A0ipv6 server in that case. Also, fix the awk code for getting the PID:
>>> =A0The PID is the second column, which is $2, not $1.
>>>
>>> Also:
>>>
>>> =A0- initialize addrlen for accept syscall in the server (=3D> avoid EI=
NVAL)
>>>
>>> =A0- use tst_resm in the client instead of tst_res, to avoid an error
>>> message interpreted as a filename
>>>
>>> Regards
>>> =A0 =A0Jiri Palecek
>>>
>>> Signed-off-by: Jiri Palecek <jpalecek@web.de>
>>> ---
>>> =A0testcases/network/tcp_cmds/sendfile/SF_Server =A0| =A0 =A02 +-
>>> =A0testcases/network/tcp_cmds/sendfile/sendfile01 | =A0 10 +++++-----
>>> =A0testcases/network/tcp_cmds/sendfile/testsf_c.c | =A0 =A02 +-
>>> =A0testcases/network/tcp_cmds/sendfile/testsf_s.c | =A0 =A02 +-
>>> =A04 files changed, 8 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/testcases/network/tcp_cmds/sendfile/SF_Server
>>> b/testcases/network/tcp_cmds/sendfile/SF_Server
>>> index 2383ce4..9933db4 100755
>>> --- a/testcases/network/tcp_cmds/sendfile/SF_Server
>>> +++ b/testcases/network/tcp_cmds/sendfile/SF_Server
>>> @@ -3,4 +3,4 @@
>>> =A0cd $3
>>> =A0exec 1< /dev/null =A0 =A0 =A0 # open descriptor 1
>>> =A0exec 2< /dev/null =A0 =A0 =A0 # open descriptor 1
>>> -nohup ./testsf_s $1 $2 &
>>> +nohup ./$4 $1 $2 &
>>> diff --git a/testcases/network/tcp_cmds/sendfile/sendfile01
>>> b/testcases/network/tcp_cmds/sendfile/sendfile01
>>> index 4e93447..7dd4fee 100755
>>> --- a/testcases/network/tcp_cmds/sendfile/sendfile01
>>> +++ b/testcases/network/tcp_cmds/sendfile/sendfile01
>>> @@ -61,7 +61,7 @@ do_setup()
>>>
>>> =A0 =A0 exists awk diff gethost grep rsh stat
>>>
>>> - =A0 =A0IPADDR=3D$(gethost $RHOST | awk '/addresses:/ {print $2}')
>>> + =A0 =A0IPADDR=3D$(gethost ${EXEC_SUFFIX:+-6} $RHOST | awk '/addresses=
:/
>>> {print $2}')
>>>
>>> =A0}
>>>
>>> @@ -81,17 +81,17 @@ do_test()
>>>
>>> =A0 =A0 mkdir -p $TCtmp
>>> =A0 =A0 PORT=3D$$
>>> - =A0 =A0if ! rsh -l root $IPADDR "$LTPROOT/testcases/bin/SF_Server $IP=
ADDR
>>> $PORT $LTPROOT/testcases/bin"; then
>>> + =A0 =A0if ! rsh -l root $IPADDR "$LTPROOT/testcases/bin/SF_Server $IP=
ADDR
>>> $PORT $LTPROOT/testcases/bin $SERVER"; then
>>> =A0 =A0 =A0 =A0 end_testcase "rsh failed to $IPADDR as root failed"
>>> =A0 =A0 fi
>>> =A0 =A0 sleep 10
>>> - =A0 =A0PID=3D$(rsh -l root $IPADDR "ps -ef" | awk "\$0 !~ /awk/ && /$=
SERVER/
>>> && /$PORT/ {print \$1}")
>>> + =A0 =A0PID=3D$(rsh -l root $IPADDR "ps -ef" | awk "\$0 !~ /awk/ && /$=
SERVER/
>>> && /$PORT/ {print \$2}")
>>> =A0 =A0 [ -n "$PID" ] || end_testcase "Could not start server"
>>>
>>> =A0 =A0 for clnt_fname in $FILES; do
>>> =A0 =A0 =A0 =A0 serv_fname=3D$TCdat/$clnt_fname
>>> =A0 =A0 =A0 =A0 SIZE=3D`stat -c '%s' $serv_fname`
>>> - =A0 =A0 =A0 =A0tst_resm TINFO "Starting $SERVER $IPADDR Client_filena=
me
>>> Server_filename Size "
>>> + =A0 =A0 =A0 =A0tst_resm TINFO "Starting $CLIENT $IPADDR Client_filena=
me
>>> Server_filename Size "
>>>
>>> =A0 =A0 =A0 =A0 $CLIENT $IPADDR $PORT "$TCtmp/$clnt_fname" $serv_fname =
$SIZE
>>> =A0 =A0 =A0 =A0 RetVal=3D$?
>>> @@ -118,7 +118,7 @@ do_test()
>>>
>>> =A0do_cleanup()
>>> =A0{
>>> - =A0 =A0 =A0PID=3D$(rsh -n -l root $RHOST "ps -ef" | awk "\$0 !~ /awk/=
 &&
>>> /$SERVER/ && /$PORT/ {print \$1}")
>>> + =A0 =A0 =A0PID=3D$(rsh -n -l root $RHOST "ps -ef" | awk "\$0 !~ /awk/=
 &&
>>> /$SERVER/ && /$PORT/ {print \$2}")
>>> =A0 =A0 =A0 [ -n "$PID" ] && rsh -n -l root $RHOST kill -9 $PID
>>> =A0 =A0 =A0 tst_cleanup
>>> =A0}
>>> diff --git a/testcases/network/tcp_cmds/sendfile/testsf_c.c
>>> b/testcases/network/tcp_cmds/sendfile/testsf_c.c
>>> index 52b9ecf..7683927 100644
>>> --- a/testcases/network/tcp_cmds/sendfile/testsf_c.c
>>> +++ b/testcases/network/tcp_cmds/sendfile/testsf_c.c
>>> @@ -120,7 +120,7 @@ main (int argc, char *argv[])
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>> =A0 =A0 =A0 =A0}
>>>
>>> - =A0 =A0 =A0 tst_res(TINFO, "Asking for remote file: %s", serv_fname);
>>> + =A0 =A0 =A0 tst_resm(TINFO, "Asking for remote file: %s", serv_fname);
>>>
>>> =A0 =A0 =A0 =A0tst_resm(TINFO, "File %s received\n", argv[4]);
>>>
>>> diff --git a/testcases/network/tcp_cmds/sendfile/testsf_s.c
>>> b/testcases/network/tcp_cmds/sendfile/testsf_s.c
>>> index bc77712..38baf8c 100644
>>> --- a/testcases/network/tcp_cmds/sendfile/testsf_s.c
>>> +++ b/testcases/network/tcp_cmds/sendfile/testsf_s.c
>>> @@ -92,7 +92,7 @@ main(int argc, char *argv[])
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_exit();
>>> =A0 =A0 =A0 =A0}
>>>
>>> - =A0 =A0 =A0 socklen_t fromlen;
>>> + =A0 =A0 =A0 socklen_t fromlen =3D sizeof(from);
>>>
>>> =A0 =A0 =A0 =A0/* process connections */
>>> =A0 =A0 =A0 =A0while (1) {
>>
>> Hi Jiri,
>> =A0 =A0I agree with you on all points, but the ps column:
>>
>> gcooper@orangebox ~ $ ps ef
>> =A0PID TTY =A0 =A0 =A0STAT =A0 TIME COMMAND
>> =A04631 tty1 =A0 =A0 S =A0 =A0 =A00:00 -bash TERM=3Dlinux HOME=3D/home/g=
cooper
>> SHELL=3D/bin/bash U
>> =A04636 tty1 =A0 =A0 S+ =A0 =A0 0:00 =A0\_ /bin/sh /usr/bin/startx
>> MANPATH=3D/etc/java-config-
>> =A04652 tty1 =A0 =A0 S+ =A0 =A0 0:00 =A0 =A0 =A0\_ xinit /etc/X11/xinit/=
xinitrc --
>> -nolisten tcp
>> =A04667 tty1 =A0 =A0 S =A0 =A0 =A00:00 =A0 =A0 =A0 =A0 =A0\_ /bin/sh /et=
c/X11/xinit/xinitrc
>> DISPLAY=3D:0
>> =A04682 tty1 =A0 =A0 S =A0 =A0 =A00:00 =A0 =A0 =A0 =A0 =A0 =A0 =A0\_ /bi=
n/sh /etc/xdg/xfce4/xinitrc
>> MANPAT
>> =A04699 tty1 =A0 =A0 S =A0 =A0 =A00:00 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0\_ /usr/bin/xfce4-session
>> MANPATH=3D/e
>> =A04705 tty1 =A0 =A0 S =A0 =A0 =A00:02 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0\_ xfwm4 --sm-client-id
>> 2d6757e3
>> =A04707 tty1 =A0 =A0 Sl =A0 =A0 0:03 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0\_ Thunar --sm-client-id
>> 276f4b6
>> =A04711 tty1 =A0 =A0 S =A0 =A0 =A00:06 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0\_ xfce4-panel -r
>> --sm-client-id
>> =A04716 tty1 =A0 =A0 Sl =A0 =A0 0:00 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| =A0 \_
>> /usr/libexec/xfce4/panel-
>> =A04724 tty1 =A0 =A0 Sl =A0 =A0 0:00 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| =A0 \_
>> /usr/libexec/xfce4/panel-
>> =A04712 tty1 =A0 =A0 S =A0 =A0 =A00:01 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0\_ xfdesktop
>> --sm-client-id 293b
>> 21073 tty1 =A0 =A0 S =A0 =A0 =A00:00 /usr/bin/xterm
>> MANPATH=3D/etc/java-config-2/current-sys
>> 21075 pts/1 =A0 =A0Ss =A0 =A0 0:00 =A0\_ bash
>> MANPATH=3D/etc/java-config-2/current-system-vm
>> 21080 pts/1 =A0 =A0R+ =A0 =A0 0:00 =A0 =A0 =A0\_ ps ef
>> MANPATH=3D/etc/java-config-2/current-syst
>> =A03396 tty1 =A0 =A0 S =A0 =A0 =A00:00 /usr/bin/xterm
>> MANPATH=3D/etc/java-config-2/current-sys
>> =A03398 pts/0 =A0 =A0Ss =A0 =A0 0:00 =A0\_ bash
>> MANPATH=3D/etc/java-config-2/current-system-vm
>> 21065 pts/0 =A0 =A0S+ =A0 =A0 0:00 =A0 =A0 =A0\_ vim sendfile01
>> MANPATH=3D/etc/java-config-2/cur
>> =A03350 tty1 =A0 =A0 Sl =A0 =A0 1:02 /usr/bin/firefox
>> MANPATH=3D/etc/java-config-2/current-s
>> 30806 tty1 =A0 =A0 Sl =A0 =A0 5:26 /usr/lib/jvm/sun-jdk-1.6/bin/java -cl=
asspath
>> /usr/sha
>> =A04791 tty1 =A0 =A0 S =A0 =A0 =A00:00 /usr/libexec/uim-helper-server
>> MANPATH=3D/etc/java-conf
>> =A04714 tty1 =A0 =A0 S =A0 =A0 =A00:00 xfce4-settings-helper --display :=
0.0
>> --sm-client-id 2
>> =A04706 tty1 =A0 =A0 S =A0 =A0 =A00:00 xfsettingsd
>> MANPATH=3D/etc/java-config-2/current-system
>> =A04696 tty1 =A0 =A0 S =A0 =A0 =A00:00 /usr/bin/dbus-launch --sh-syntax
>> --exit-with-session
>> gcooper@orangebox ~ $ ps --version
>> procps version 3.2.8
>>
>> So to bypass this issue I used ps eopid,cmd:
>>
>> =A0400 [crypto/2]
>> =A0401 [crypto/3]
>> =A0587 [iscsi_eh]
>> =A0593 [scsi_eh_0]
>> =A0596 [scsi_eh_1]
>> =A0599 [scsi_eh_2]
>> =A0602 [scsi_eh_3]
>> =A0605 [scsi_eh_4]
>> =A0608 [scsi_eh_5]
>> =A0692 [kpsmoused]
>> =A0700 [kstriped]
>> =A0703 [kondemand/0]
>> =A0704 [kondemand/1]
>> =A0705 [kondemand/2]
>> =A0706 [kondemand/3]
>> =A0729 [usbhid_resumer]
>> =A0809 [reiserfs/0]
>> =A0810 [reiserfs/1]
>> =A0811 [reiserfs/2]
>> =A0812 [reiserfs/3]
>> =A01906 /sbin/udevd --daemon
>> =A02303 /usr/sbin/acpid
>> =A03350 /usr/bin/firefox
>> =A03396 /usr/bin/xterm
>> =A03398 bash
>> =A03535 supervising syslog-ng
>> =A03536 /usr/sbin/syslog-ng
>> =A03596 /usr/bin/dbus-daemon --system
>> =A03653 /usr/sbin/crond
>> =A03707 /usr/sbin/gpm -m /dev/input/mice -t ps2
>> =A03768 /usr/sbin/hald --use-syslog --verbose=3Dno
>> =A03771 hald-runner
>> =A03774 hald-addon-input: Listening on /dev/input/event4 /dev/input/even=
t3
>> /dev/in
>> =A03787 hald-addon-storage: polling /dev/sr0 (every 2 sec)
>> =A03790 /usr/libexec/hald-addon-cpufreq
>> =A03791 hald-addon-acpi: listening on acpid socket /var/run/acpid.socket
>> =A04250 /sbin/dhcpcd -h orangebox eth0
>> =A04339 /sbin/portmap
>> =A04400 /sbin/rpc.statd --no-notify
>> =A04512 /usr/sbin/sshd
>> =A04580 /sbin/agetty 38400 tty2 linux
>> =A04581 /sbin/agetty 38400 tty3 linux
>> =A04582 /sbin/agetty 38400 tty4 linux
>> =A04583 /sbin/agetty 38400 tty5 linux
>> =A04584 /sbin/agetty 38400 tty6 linux
>> =A04613 [rpciod/0]
>> =A04614 [rpciod/1]
>> =A04615 [rpciod/2]
>> =A04616 [rpciod/3]
>> =A04622 [nfsiod]
>> =A04627 [lockd]
>> =A04629 /bin/login --
>> =A04631 -bash
>> =A04636 /bin/sh /usr/bin/startx
>> =A04652 xinit /etc/X11/xinit/xinitrc -- -nolisten tcp -br -auth
>> /home/gcooper/.ser
>> =A04653 X :0 -nolisten tcp -br -auth /home/gcooper/.serverauth.4636
>> -deferglyphs 1
>> =A04667 /bin/sh /etc/X11/xinit/xinitrc
>> =A04682 /bin/sh /etc/xdg/xfce4/xinitrc
>> =A04691 /usr/bin/ssh-agent -s
>> =A04696 /usr/bin/dbus-launch --sh-syntax --exit-with-session
>> =A04697 /usr/bin/dbus-daemon --fork --print-pid 5 --print-address 7
>> --session
>> =A04699 /usr/bin/xfce4-session
>> =A04701 /usr/libexec/xfconfd
>> =A04705 xfwm4 --sm-client-id 2d6757e33-4d33-453a-ba49-da83d783acde --dis=
play
>> :0.0
>> =A04706 xfsettingsd
>> =A04707 Thunar --sm-client-id 276f4b61e-2bba-4207-8e5e-feed55cbe9b4 --da=
emon
>> =A04709 /usr/libexec/gam_server
>> =A04711 xfce4-panel -r --sm-client-id 260365c00-2a57-4640-9170-8e74ce91b=
f1e
>> =A04712 xfdesktop --sm-client-id 293b54ac0-804e-45e2-9ae9-2b9adbaeddde
>> --display :
>> =A04714 xfce4-settings-helper --display :0.0 --sm-client-id
>> 20a17a11f-321d-40f4-87
>> =A04716 /usr/libexec/xfce4/panel-plugins/xfce4-menu-plugin socket_id
>> 18874394 name
>> =A04723 /usr/libexec/gvfsd
>> =A04724 /usr/libexec/xfce4/panel-plugins/xfce4-mixer-plugin socket_id
>> 18874431 nam
>> =A04791 /usr/libexec/uim-helper-server
>> 21065 vim sendfile01
>> 21073 /usr/bin/xterm
>> 21075 bash
>> 21113 ps -eopid,cmd
>> 28404 /usr/libexec/gvfs-hal-volume-monitor
>> 28689 /sbin/udevd --daemon
>> 28690 /sbin/udevd --daemon
>> 30806 /usr/lib/jvm/sun-jdk-1.6/bin/java -classpath
>> /usr/share/bcprov/lib/bcprov.
>> 30860 xchat
>> 31904 /usr/libexec/gconfd-2
>> gcooper@orangebox ~ $ ps -eopid,cmd
>>
>> =A0 =A0Do you agree that this is an ok choice?
>
> Yes, it is arguably more robust and readable (although I don't think your
> example shows the need for it).
>
> Note that there are differences between ps -ef, ps ef and ps -e f:
>
> jirka@debian:~$ ps -ef | head -10
> UID =A0 =A0 =A0 =A0PID =A0PPID =A0C STIME TTY =A0 =A0 =A0 =A0 =A0TIME CMD
> root =A0 =A0 =A0 =A0 1 =A0 =A0 0 =A00 21:15 ? =A0 =A0 =A0 =A000:00:00 ini=
t [2]
> root =A0 =A0 =A0 =A0 2 =A0 =A0 0 =A00 21:15 ? =A0 =A0 =A0 =A000:00:00 [kt=
hreadd]
> root =A0 =A0 =A0 =A0 3 =A0 =A0 2 =A00 21:15 ? =A0 =A0 =A0 =A000:00:00 [mi=
gration/0]
> root =A0 =A0 =A0 =A0 4 =A0 =A0 2 =A00 21:15 ? =A0 =A0 =A0 =A000:00:00 [ks=
oftirqd/0]
> root =A0 =A0 =A0 =A0 5 =A0 =A0 2 =A00 21:15 ? =A0 =A0 =A0 =A000:00:00 [ev=
ents/0]
> root =A0 =A0 =A0 =A0 6 =A0 =A0 2 =A00 21:15 ? =A0 =A0 =A0 =A000:00:00 [kh=
elper]
> root =A0 =A0 =A0 =A035 =A0 =A0 2 =A00 21:15 ? =A0 =A0 =A0 =A000:00:00 [kb=
lockd/0]
> root =A0 =A0 =A0 =A036 =A0 =A0 2 =A00 21:15 ? =A0 =A0 =A0 =A000:00:00 [ka=
cpid]
> root =A0 =A0 =A0 =A037 =A0 =A0 2 =A00 21:15 ? =A0 =A0 =A0 =A000:00:00 [ka=
cpi_notify]
> jirka@debian:~$ ps ef | head -10
> =A0PID TTY =A0 =A0 =A0STAT =A0 TIME COMMAND
> =A07465 pts/12 =A0 Ss =A0 =A0 0:00 /bin/bash --noediting -i PWD=3D/home/j=
irka
> TERM=3Ddumb TERMCAP=3D COLUMNS=3D136 EMACS=3Dt INSIDE_EMACS=3D22.3.1,comi=
nt GT
> =A07498 pts/12 =A0 R+ =A0 =A0 0:00 =A0\_ ps ef KDE_MULTIHEAD=3Dfalse
> KDEWM=3D/usr/bin/openbox SHELL=3D/bin/bash TERM=3Ddumb
> XDG_SESSION_COOKIE=3De07c53451a9
> =A07499 pts/12 =A0 D+ =A0 =A0 0:00 =A0\_ head -10 KDE_MULTIHEAD=3Dfalse
> KDEWM=3D/usr/bin/openbox SHELL=3D/bin/bash TERM=3Ddumb XDG_SESSION_COOKIE=
=3De07c5345
> =A06355 pts/10 =A0 Ss+ =A0 =A00:00 /bin/bash GDM_XSERVER_LOCATION=3Dlocal
> GDM_LANG=3Dcs_CZ LANGUAGE=3D KDE_MULTIHEAD=3Dfalse KDE_SESSION_VERSION=3D=
4 KONSO
> =A06343 pts/9 =A0 =A0Ss+ =A0 =A00:00 /bin/bash GDM_XSERVER_LOCATION=3Dloc=
al
> GDM_LANG=3Dcs_CZ LANGUAGE=3D KDE_MULTIHEAD=3Dfalse KDE_SESSION_VERSION=3D=
4 KONSO
> =A06337 pts/8 =A0 =A0Ss+ =A0 =A00:00 /bin/bash GDM_XSERVER_LOCATION=3Dloc=
al
> GDM_LANG=3Dcs_CZ LANGUAGE=3D KDE_MULTIHEAD=3Dfalse KDE_SESSION_VERSION=3D=
4 KONSO
> =A06325 pts/7 =A0 =A0Ss+ =A0 =A00:00 /bin/bash GDM_XSERVER_LOCATION=3Dloc=
al
> GDM_LANG=3Dcs_CZ LANGUAGE=3D KDE_MULTIHEAD=3Dfalse KDE_SESSION_VERSION=3D=
4 KONSO
> =A06315 pts/6 =A0 =A0Ss+ =A0 =A00:00 /bin/bash GDM_XSERVER_LOCATION=3Dloc=
al
> GDM_LANG=3Dcs_CZ LANGUAGE=3D KDE_MULTIHEAD=3Dfalse KDE_SESSION_VERSION=3D=
4 KONSO
> =A06300 pts/5 =A0 =A0Ss+ =A0 =A00:00 /bin/bash GDM_XSERVER_LOCATION=3Dloc=
al
> GDM_LANG=3Dcs_CZ LANGUAGE=3D KDE_MULTIHEAD=3Dfalse KDE_SESSION_VERSION=3D=
4 KONSO
> jirka@debian:~$ ps -e f | head -10
> =A0PID TTY =A0 =A0 =A0STAT =A0 TIME COMMAND
> =A0 =A02 ? =A0 =A0 =A0 =A0S< =A0 =A0 0:00 [kthreadd]
> =A0 =A03 ? =A0 =A0 =A0 =A0S< =A0 =A0 0:00 =A0\_ [migration/0]
> =A0 =A04 ? =A0 =A0 =A0 =A0S< =A0 =A0 0:00 =A0\_ [ksoftirqd/0]
> =A0 =A05 ? =A0 =A0 =A0 =A0S< =A0 =A0 0:00 =A0\_ [events/0]
> =A0 =A06 ? =A0 =A0 =A0 =A0S< =A0 =A0 0:00 =A0\_ [khelper]
> =A0 35 ? =A0 =A0 =A0 =A0S< =A0 =A0 0:00 =A0\_ [kblockd/0]
> =A0 36 ? =A0 =A0 =A0 =A0S< =A0 =A0 0:00 =A0\_ [kacpid]
> =A0 37 ? =A0 =A0 =A0 =A0S< =A0 =A0 0:00 =A0\_ [kacpi_notify]
> =A0100 ? =A0 =A0 =A0 =A0S< =A0 =A0 0:00 =A0\_ [kseriod]
> jirka@debian:~$
>
> So you actually used a different command than the one that's used in the
> testcase. (the first listing is consistent with POSIX specification)

Interesting -- didn't know that!

How about this instead:

gcooper@orangebox ~ $ ps -eo pid,cmd | head -n 10
  PID CMD
    1 init [3]
    2 [kthreadd]
    3 [migration/0]
    4 [ksoftirqd/0]
    5 [migration/1]
    6 [ksoftirqd/1]
    7 [migration/2]
    8 [ksoftirqd/2]
    9 [migration/3]

I'm just proposing this because if --columns is set on the target
system, it's more likely to truncate output and give false positives.

Sound good :)?

Thanks,
-Garrett


Thanks,
-Garrett

---------------------------------------------------------------------------=
---
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
