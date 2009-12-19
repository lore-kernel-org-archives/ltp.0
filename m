Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NLqeJ-0007ly-9t
	for ltp-list@lists.sourceforge.net; Sat, 19 Dec 2009 04:10:35 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NLqeC-0007QJ-Aw
	for ltp-list@lists.sourceforge.net; Sat, 19 Dec 2009 04:10:35 +0000
Received: by pwj11 with SMTP id 11so2485308pwj.2
	for <ltp-list@lists.sourceforge.net>;
	Fri, 18 Dec 2009 20:10:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4b2c37e0.6344f10a.4097.4c88SMTPIN_ADDED@mx.google.com>
References: <4b2c37e0.6344f10a.4097.4c88SMTPIN_ADDED@mx.google.com>
Date: Fri, 18 Dec 2009 20:02:45 -0800
Message-ID: <364299f40912182002o417158c3lef65a301d721f1a0@mail.gmail.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jiri Palecek <jpalecek@web.de>
Cc: ltp-list@lists.sourceforge.net

On Fri, Dec 18, 2009 at 6:16 PM, Jiri Palecek <jpalecek@web.de> wrote:
> Hello,
>
> I've found some problems with the sendfile01 testcase (the one under netw=
ork/tcp_cmds). This patch fixes them:
>
> =A0Pass the -6 parameter to gethost if we are to use ipv6 and run the
> =A0ipv6 server in that case. Also, fix the awk code for getting the PID:
> =A0The PID is the second column, which is $2, not $1.
>
> Also:
>
> =A0- initialize addrlen for accept syscall in the server (=3D> avoid EINV=
AL)
>
> =A0- use tst_resm in the client instead of tst_res, to avoid an error mes=
sage interpreted as a filename
>
> Regards
> =A0 =A0Jiri Palecek
>
> Signed-off-by: Jiri Palecek <jpalecek@web.de>
> ---
> =A0testcases/network/tcp_cmds/sendfile/SF_Server =A0| =A0 =A02 +-
> =A0testcases/network/tcp_cmds/sendfile/sendfile01 | =A0 10 +++++-----
> =A0testcases/network/tcp_cmds/sendfile/testsf_c.c | =A0 =A02 +-
> =A0testcases/network/tcp_cmds/sendfile/testsf_s.c | =A0 =A02 +-
> =A04 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/testcases/network/tcp_cmds/sendfile/SF_Server b/testcases/ne=
twork/tcp_cmds/sendfile/SF_Server
> index 2383ce4..9933db4 100755
> --- a/testcases/network/tcp_cmds/sendfile/SF_Server
> +++ b/testcases/network/tcp_cmds/sendfile/SF_Server
> @@ -3,4 +3,4 @@
> =A0cd $3
> =A0exec 1< /dev/null =A0 =A0 =A0 # open descriptor 1
> =A0exec 2< /dev/null =A0 =A0 =A0 # open descriptor 1
> -nohup ./testsf_s $1 $2 &
> +nohup ./$4 $1 $2 &
> diff --git a/testcases/network/tcp_cmds/sendfile/sendfile01 b/testcases/n=
etwork/tcp_cmds/sendfile/sendfile01
> index 4e93447..7dd4fee 100755
> --- a/testcases/network/tcp_cmds/sendfile/sendfile01
> +++ b/testcases/network/tcp_cmds/sendfile/sendfile01
> @@ -61,7 +61,7 @@ do_setup()
>
> =A0 =A0 exists awk diff gethost grep rsh stat
>
> - =A0 =A0IPADDR=3D$(gethost $RHOST | awk '/addresses:/ {print $2}')
> + =A0 =A0IPADDR=3D$(gethost ${EXEC_SUFFIX:+-6} $RHOST | awk '/addresses:/=
 {print $2}')
>
> =A0}
>
> @@ -81,17 +81,17 @@ do_test()
>
> =A0 =A0 mkdir -p $TCtmp
> =A0 =A0 PORT=3D$$
> - =A0 =A0if ! rsh -l root $IPADDR "$LTPROOT/testcases/bin/SF_Server $IPAD=
DR $PORT $LTPROOT/testcases/bin"; then
> + =A0 =A0if ! rsh -l root $IPADDR "$LTPROOT/testcases/bin/SF_Server $IPAD=
DR $PORT $LTPROOT/testcases/bin $SERVER"; then
> =A0 =A0 =A0 =A0 end_testcase "rsh failed to $IPADDR as root failed"
> =A0 =A0 fi
> =A0 =A0 sleep 10
> - =A0 =A0PID=3D$(rsh -l root $IPADDR "ps -ef" | awk "\$0 !~ /awk/ && /$SE=
RVER/ && /$PORT/ {print \$1}")
> + =A0 =A0PID=3D$(rsh -l root $IPADDR "ps -ef" | awk "\$0 !~ /awk/ && /$SE=
RVER/ && /$PORT/ {print \$2}")
> =A0 =A0 [ -n "$PID" ] || end_testcase "Could not start server"
>
> =A0 =A0 for clnt_fname in $FILES; do
> =A0 =A0 =A0 =A0 serv_fname=3D$TCdat/$clnt_fname
> =A0 =A0 =A0 =A0 SIZE=3D`stat -c '%s' $serv_fname`
> - =A0 =A0 =A0 =A0tst_resm TINFO "Starting $SERVER $IPADDR Client_filename=
 Server_filename Size "
> + =A0 =A0 =A0 =A0tst_resm TINFO "Starting $CLIENT $IPADDR Client_filename=
 Server_filename Size "
>
> =A0 =A0 =A0 =A0 $CLIENT $IPADDR $PORT "$TCtmp/$clnt_fname" $serv_fname $S=
IZE
> =A0 =A0 =A0 =A0 RetVal=3D$?
> @@ -118,7 +118,7 @@ do_test()
>
> =A0do_cleanup()
> =A0{
> - =A0 =A0 =A0PID=3D$(rsh -n -l root $RHOST "ps -ef" | awk "\$0 !~ /awk/ &=
& /$SERVER/ && /$PORT/ {print \$1}")
> + =A0 =A0 =A0PID=3D$(rsh -n -l root $RHOST "ps -ef" | awk "\$0 !~ /awk/ &=
& /$SERVER/ && /$PORT/ {print \$2}")
> =A0 =A0 =A0 [ -n "$PID" ] && rsh -n -l root $RHOST kill -9 $PID
> =A0 =A0 =A0 tst_cleanup
> =A0}
> diff --git a/testcases/network/tcp_cmds/sendfile/testsf_c.c b/testcases/n=
etwork/tcp_cmds/sendfile/testsf_c.c
> index 52b9ecf..7683927 100644
> --- a/testcases/network/tcp_cmds/sendfile/testsf_c.c
> +++ b/testcases/network/tcp_cmds/sendfile/testsf_c.c
> @@ -120,7 +120,7 @@ main (int argc, char *argv[])
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 tst_res(TINFO, "Asking for remote file: %s", serv_fname);
> + =A0 =A0 =A0 tst_resm(TINFO, "Asking for remote file: %s", serv_fname);
>
> =A0 =A0 =A0 =A0tst_resm(TINFO, "File %s received\n", argv[4]);
>
> diff --git a/testcases/network/tcp_cmds/sendfile/testsf_s.c b/testcases/n=
etwork/tcp_cmds/sendfile/testsf_s.c
> index bc77712..38baf8c 100644
> --- a/testcases/network/tcp_cmds/sendfile/testsf_s.c
> +++ b/testcases/network/tcp_cmds/sendfile/testsf_s.c
> @@ -92,7 +92,7 @@ main(int argc, char *argv[])
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_exit();
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 socklen_t fromlen;
> + =A0 =A0 =A0 socklen_t fromlen =3D sizeof(from);
>
> =A0 =A0 =A0 =A0/* process connections */
> =A0 =A0 =A0 =A0while (1) {

Hi Jiri,
    I agree with you on all points, but the ps column:

gcooper@orangebox ~ $ ps ef
  PID TTY      STAT   TIME COMMAND
 4631 tty1     S      0:00 -bash TERM=3Dlinux HOME=3D/home/gcooper SHELL=3D=
/bin/bash U
 4636 tty1     S+     0:00  \_ /bin/sh /usr/bin/startx MANPATH=3D/etc/java-=
config-
 4652 tty1     S+     0:00      \_ xinit /etc/X11/xinit/xinitrc -- -noliste=
n tcp
 4667 tty1     S      0:00          \_ /bin/sh /etc/X11/xinit/xinitrc DISPL=
AY=3D:0
 4682 tty1     S      0:00              \_ /bin/sh /etc/xdg/xfce4/xinitrc M=
ANPAT
 4699 tty1     S      0:00                  \_ /usr/bin/xfce4-session MANPA=
TH=3D/e
 4705 tty1     S      0:02                      \_ xfwm4 --sm-client-id 2d6=
757e3
 4707 tty1     Sl     0:03                      \_ Thunar --sm-client-id 27=
6f4b6
 4711 tty1     S      0:06                      \_ xfce4-panel -r --sm-clie=
nt-id
 4716 tty1     Sl     0:00                      |   \_ /usr/libexec/xfce4/p=
anel-
 4724 tty1     Sl     0:00                      |   \_ /usr/libexec/xfce4/p=
anel-
 4712 tty1     S      0:01                      \_ xfdesktop --sm-client-id=
 293b
21073 tty1     S      0:00 /usr/bin/xterm MANPATH=3D/etc/java-config-2/curr=
ent-sys
21075 pts/1    Ss     0:00  \_ bash MANPATH=3D/etc/java-config-2/current-sy=
stem-vm
21080 pts/1    R+     0:00      \_ ps ef MANPATH=3D/etc/java-config-2/curre=
nt-syst
 3396 tty1     S      0:00 /usr/bin/xterm MANPATH=3D/etc/java-config-2/curr=
ent-sys
 3398 pts/0    Ss     0:00  \_ bash MANPATH=3D/etc/java-config-2/current-sy=
stem-vm
21065 pts/0    S+     0:00      \_ vim sendfile01 MANPATH=3D/etc/java-confi=
g-2/cur
 3350 tty1     Sl     1:02 /usr/bin/firefox MANPATH=3D/etc/java-config-2/cu=
rrent-s
30806 tty1     Sl     5:26 /usr/lib/jvm/sun-jdk-1.6/bin/java -classpath /us=
r/sha
 4791 tty1     S      0:00 /usr/libexec/uim-helper-server MANPATH=3D/etc/ja=
va-conf
 4714 tty1     S      0:00 xfce4-settings-helper --display :0.0 --sm-client=
-id 2
 4706 tty1     S      0:00 xfsettingsd MANPATH=3D/etc/java-config-2/current=
-system
 4696 tty1     S      0:00 /usr/bin/dbus-launch --sh-syntax --exit-with-ses=
sion
gcooper@orangebox ~ $ ps --version
procps version 3.2.8

So to bypass this issue I used ps eopid,cmd:

  400 [crypto/2]
  401 [crypto/3]
  587 [iscsi_eh]
  593 [scsi_eh_0]
  596 [scsi_eh_1]
  599 [scsi_eh_2]
  602 [scsi_eh_3]
  605 [scsi_eh_4]
  608 [scsi_eh_5]
  692 [kpsmoused]
  700 [kstriped]
  703 [kondemand/0]
  704 [kondemand/1]
  705 [kondemand/2]
  706 [kondemand/3]
  729 [usbhid_resumer]
  809 [reiserfs/0]
  810 [reiserfs/1]
  811 [reiserfs/2]
  812 [reiserfs/3]
 1906 /sbin/udevd --daemon
 2303 /usr/sbin/acpid
 3350 /usr/bin/firefox
 3396 /usr/bin/xterm
 3398 bash
 3535 supervising syslog-ng
 3536 /usr/sbin/syslog-ng
 3596 /usr/bin/dbus-daemon --system
 3653 /usr/sbin/crond
 3707 /usr/sbin/gpm -m /dev/input/mice -t ps2
 3768 /usr/sbin/hald --use-syslog --verbose=3Dno
 3771 hald-runner
 3774 hald-addon-input: Listening on /dev/input/event4 /dev/input/event3 /d=
ev/in
 3787 hald-addon-storage: polling /dev/sr0 (every 2 sec)
 3790 /usr/libexec/hald-addon-cpufreq
 3791 hald-addon-acpi: listening on acpid socket /var/run/acpid.socket
 4250 /sbin/dhcpcd -h orangebox eth0
 4339 /sbin/portmap
 4400 /sbin/rpc.statd --no-notify
 4512 /usr/sbin/sshd
 4580 /sbin/agetty 38400 tty2 linux
 4581 /sbin/agetty 38400 tty3 linux
 4582 /sbin/agetty 38400 tty4 linux
 4583 /sbin/agetty 38400 tty5 linux
 4584 /sbin/agetty 38400 tty6 linux
 4613 [rpciod/0]
 4614 [rpciod/1]
 4615 [rpciod/2]
 4616 [rpciod/3]
 4622 [nfsiod]
 4627 [lockd]
 4629 /bin/login --
 4631 -bash
 4636 /bin/sh /usr/bin/startx
 4652 xinit /etc/X11/xinit/xinitrc -- -nolisten tcp -br -auth /home/gcooper=
/.ser
 4653 X :0 -nolisten tcp -br -auth /home/gcooper/.serverauth.4636 -defergly=
phs 1
 4667 /bin/sh /etc/X11/xinit/xinitrc
 4682 /bin/sh /etc/xdg/xfce4/xinitrc
 4691 /usr/bin/ssh-agent -s
 4696 /usr/bin/dbus-launch --sh-syntax --exit-with-session
 4697 /usr/bin/dbus-daemon --fork --print-pid 5 --print-address 7 --session
 4699 /usr/bin/xfce4-session
 4701 /usr/libexec/xfconfd
 4705 xfwm4 --sm-client-id 2d6757e33-4d33-453a-ba49-da83d783acde --display =
:0.0
 4706 xfsettingsd
 4707 Thunar --sm-client-id 276f4b61e-2bba-4207-8e5e-feed55cbe9b4 --daemon
 4709 /usr/libexec/gam_server
 4711 xfce4-panel -r --sm-client-id 260365c00-2a57-4640-9170-8e74ce91bf1e
 4712 xfdesktop --sm-client-id 293b54ac0-804e-45e2-9ae9-2b9adbaeddde --disp=
lay :
 4714 xfce4-settings-helper --display :0.0 --sm-client-id 20a17a11f-321d-40=
f4-87
 4716 /usr/libexec/xfce4/panel-plugins/xfce4-menu-plugin socket_id 18874394=
 name
 4723 /usr/libexec/gvfsd
 4724 /usr/libexec/xfce4/panel-plugins/xfce4-mixer-plugin socket_id 1887443=
1 nam
 4791 /usr/libexec/uim-helper-server
21065 vim sendfile01
21073 /usr/bin/xterm
21075 bash
21113 ps -eopid,cmd
28404 /usr/libexec/gvfs-hal-volume-monitor
28689 /sbin/udevd --daemon
28690 /sbin/udevd --daemon
30806 /usr/lib/jvm/sun-jdk-1.6/bin/java -classpath /usr/share/bcprov/lib/bc=
prov.
30860 xchat
31904 /usr/libexec/gconfd-2
gcooper@orangebox ~ $ ps -eopid,cmd

    Do you agree that this is an ok choice?
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
