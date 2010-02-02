Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NcAlr-0005sJ-VG
	for ltp-list@lists.sourceforge.net; Tue, 02 Feb 2010 04:53:51 +0000
Received: from mail-px0-f200.google.com ([209.85.216.200])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NcAlq-0007Fr-W0
	for ltp-list@lists.sourceforge.net; Tue, 02 Feb 2010 04:53:51 +0000
Received: by mail-px0-f200.google.com with SMTP id 38so5046676pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Mon, 01 Feb 2010 20:53:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <000601caa3b4$c096ceb0$41c46c10$@co.jp>
References: <000601caa3b4$c096ceb0$41c46c10$@co.jp>
Date: Mon, 1 Feb 2010 20:53:50 -0800
Message-ID: <364299f41002012053v7ed645etac0a321232e22b3d@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] 2010-02-01 cvs "make clean" problem (Rapidly)
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
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net

On Mon, Feb 1, 2010 at 7:06 PM, Mitani <mitani@ryobi.co.jp> wrote:
> Hi,
>
>
> "2010-02-01 cvs" may break system, I think.
>
> If this information was my mistake, please forgive me.
> But I have duty of the report.
>
>
> I tried "make clean" with 2010-02-01 cvs in RHEL5.4 system.
> (Archecture : x86 and ia64)
> But it failed as follows:
> ------------
> [...]
> rm: cannot remove
> `//sys/devices/system/cpu/cpu0/cache/index0/shared_cpu_map': Operation not
> permitted
> rm: cannot remove
> `//sys/devices/system/cpu/cpu0/cache/index0/number_of_sets': Operation not
> permitted
> rm: cannot remove `//sys/devices/system/cpu/cpu0/cache/index0/size':
> Operation not permitted
> rm: cannot remove `//sys/devices/system/cpu/cpu0/cache/index0/attributes':
> Operation not permitted
> rm: cannot remove
> `//sys/devices/system/cpu/cpu0/cache/index0/ways_of_associativity':
> Operation not permitted
> rm: cannot remove
> `//sys/devices/system/cpu/cpu0/cache/index0/coherency_line_size': Operati=
on
> not permitted
> rm: cannot remove `//sys/devices/system/cpu/cpu0/cache/index0/level':
> Operation not permitted
> rm: cannot remove `//sys/devices/system/cpu/cpu0/cache/index0/type':
> Operation not permitted
> rm: cannot remove `//sys/devices/system/cpu/cpu0/online': Operation not
> permitted
> rm: cannot remove `//sys/devices/platform/bluetooth/bus': Operation not
> permitted
> rm: cannot remove `//sys/devices/platform/bluetooth/subsystem': Operation
> not permitted
> rm: cannot remove `//sys/devices/platform/bluetooth/modalias': Operation =
not
> permitted
> rm: cannot remove `//sys/devices/platform/bluetooth/power/wakeup': Operat=
ion
> not permitted
> rm: cannot remove `//sys/devices/platform/bluetooth/power/state': Operati=
on
> not permitted
> rm: cannot remove `//sys/devices/platform/bluetooth/uevent': Operation not
> permitted
> rm: cannot remove `//sys/devices/platform/power/wakeup': Operation not
> permitted
> rm: cannot remove `//sys/devices/platform/power/state': Operation not
> permitted
> rm: cannot remove `//sys/devices/platform/uevent': Operation not permitted
> rm: cannot remove directory `//sys/fs': Operation not permitted
> rm: cannot remove directory `//root': Device or resource busy
> rm: cannot remove `//proc/mpt/ioc1/summary': Operation not permitted
> rm: cannot remove `//proc/mpt/ioc1/info': Operation not permitted
> rm: cannot remove `//proc/mpt/ioc0/summary': Operation not permitted
> rm: cannot remove `//proc/mpt/ioc0/info': Operation not permitted
> rm: cannot remove `//proc/mpt/version': Operation not permitted
> rm: cannot remove `//proc/mpt/summary': Operation not permitted
> rm: cannot remove `//proc/scsi/sg/version': Operation not permitted
> [...]
> rm: cannot remove `//proc/30971/limits': Permission denied
> rm: cannot remove `//proc/30971/coredump_filter': Permission denied
> rm: cannot remove `//proc/30971/io': Permission denied
> rm: cannot remove directory `//dev/shm': Device or resource busy
> rm: cannot remove `//dev/pts/2': Operation not permitted
> rm: cannot remove `//dev/pts/1': Operation not permitted
> rm: cannot remove `//dev/pts/0': Operation not permitted
> rm: cannot remove directory `//boot/efi': Device or resource busy
> rm: cannot remove directory `//home': Device or resource busy
> rm: cannot remove directory `//net': Device or resource busy
> rm: cannot remove directory `//var/lib/nfs/rpc_pipefs/statd': Operation n=
ot
> permitted
> rm: cannot remove directory `//var/lib/nfs/rpc_pipefs/portmap': Operation
> not permitted
> rm: cannot remove directory `//var/lib/nfs/rpc_pipefs/nfs': Operation not
> permitted
> rm: cannot remove directory `//var/lib/nfs/rpc_pipefs/mount': Operation n=
ot
> permitted
> rm: cannot remove directory `//var/lib/nfs/rpc_pipefs/lockd': Operation n=
ot
> permitted
> rm: cannot remove directory `//var/crash': Device or resource busy
> rm: cannot remove directory `//misc': Device or resource busy
> make: *** [clean_install_dir] Error 1
> ------------
>
> After that, I noticed that some commands ("ls", "who", "top" etc.)
> became invalid.
> And the system was not able to reboot.
>
> In above log, "make clean" seems to be going to delete "/proc/..." and
> "/sys/...".
>
>
> I tried once again in VMWare RHEL4.8(x86) system for confirmation.
> "make clean" failed, and "/root" directory disappeared.
> ------------
> [root@RHEL4-8 ltp-2010-02-01]# pwd
> /home/LTP/ltp-2010-02-01
> [root@RHEL4-8 ltp-2010-02-01]# ls -ltr /
> total 170
> drwxr-xr-x =A0 =A02 root root =A04096 Aug 13 =A02004 srv
> drwxr-xr-x =A0 =A02 root root =A04096 Aug 13 =A02004 mnt
> drwxr-xr-x =A0 =A02 root root =A04096 Aug 13 =A02004 initrd
> drwxr-xr-x =A0 =A02 root root =A04096 Apr 10 =A02009 misc
> drwxr-xr-x =A0 =A02 root root =A04096 Oct 21 17:08 selinux
> drwxr-xr-x =A0 =A04 root root =A01024 Oct 21 17:11 boot
> drwxr-xr-x =A0 23 root root =A04096 Oct 21 17:27 var
> drwxr-xr-x =A0 =A03 root root =A04096 Oct 21 17:27 tftpboot
> drwx------ =A0 =A02 root root 16384 Oct 22 02:02 lost+found
> drwxr-xr-x =A0 =A02 root root =A04096 Oct 22 09:43 bin
> drwxr-xr-x =A0 =A02 root root 12288 Dec 18 12:44 sbin
> drwxr-xr-x =A0 15 root root =A04096 Jan 12 19:27 usr
> drwxr-xr-x =A0 12 root root =A04096 Jan 19 10:10 lib
> drwxr-xr-x =A0 =A03 root root =A04096 Feb =A01 10:22 opt
> drwxr-xr-x =A0 =A04 root root =A04096 Feb =A01 11:38 home
> drwxr-xr-x =A0 =A04 root root =A04096 Feb =A02 11:46 media
> drwxr-xr-x =A0 96 root root 12288 Feb =A02 11:46 etc
> drwxr-xr-x =A0 =A08 root root =A06520 Feb =A02 11:46 dev
> drwxr-x--- =A0 14 root root =A04096 Feb =A02 11:48 root
> drwxrwxrwt =A0 10 root root =A04096 Feb =A02 11:48 tmp
> dr-xr-xr-x =A0109 root root =A0 =A0 0 Feb =A02 =A02010 proc
> drwxr-xr-x =A0 =A09 root root =A0 =A0 0 Feb =A02 =A02010 sys
> [root@RHEL4-8 ltp-2010-02-01]# ls -ltr /opt/ltp
> total 2056
> drwxr-xr-x =A03 root root =A0 =A04096 Feb =A01 10:22 share
> drwxr-xr-x =A02 root root =A0 =A04096 Feb =A01 10:22 testscripts
> drwxr-xr-x =A04 root root =A0 =A04096 Feb =A01 10:22 testcases
> -rwxr-xr-x =A01 root root =A0 =A02603 Feb =A01 10:24 ver_linux
> -rwxr-xr-x =A01 root root =A0 10193 Feb =A01 10:24 runltplite.sh
> -rwxr-xr-x =A01 root root =A0 38054 Feb =A01 10:24 runltp
> -rwxr-xr-x =A01 root root =A0 22819 Feb =A01 10:24 runalltests.sh
> drwxr-xr-x =A02 root root =A0 =A04096 Feb =A01 10:24 bin
> -rw-r--r-- =A01 root root =A0 =A0 =A013 Feb =A01 10:24 Version
> -rwxr-xr-x =A01 root root =A0 =A04645 Feb =A01 10:24 IDcheck.sh
> drwxr-xr-x =A02 root root =A0 =A04096 Feb =A01 10:24 results
> drwxr-xr-x =A02 root root =A0 =A04096 Feb =A01 10:24 output
> -rw-r--r-- =A01 root root 1977717 Feb =A01 11:39 cvs0201-20100201.txt
> drwxr-xr-x =A02 root root =A0 =A04096 Feb =A01 17:20 runtest
> [root@RHEL4-8 ltp-2010-02-01]# make clean
> make -C "runtest" \
> =A0 =A0 =A0 =A0 -f "/home/LTP/ltp-2010-02-01/runtest/Makefile" clean
> make[1]: Entering directory `/home/LTP/ltp-2010-02-01/runtest'
> rm -f -f =A0*.o *.pyc
> make[1]: Leaving directory `/home/LTP/ltp-2010-02-01/runtest'
> make -C "testscripts" \
> =A0 =A0 =A0 =A0 -f "/home/LTP/ltp-2010-02-01/testscripts/Makefile" clean
> [...]
> make[1]: Entering directory `/home/LTP/ltp-2010-02-01/lib'
> rm -f -f libltp.a *.o *.pyc
> make[1]: Leaving directory `/home/LTP/ltp-2010-02-01/lib'
> make -C include -f "/home/LTP/ltp-2010-02-01/include/Makefile" clean
> make[1]: Entering directory `/home/LTP/ltp-2010-02-01/include'
> rm -f -f =A0*.o *.pyc
> make[1]: Leaving directory `/home/LTP/ltp-2010-02-01/include'
> rm -f -Rf "/"
> rm: cannot remove `//sys/module/parport_pc/sections/.strtab': Operation n=
ot
> permitted
> rm: cannot remove `//sys/module/parport_pc/sections/.symtab': Operation n=
ot
> permitted
> rm: cannot remove `//sys/module/parport_pc/sections/.module_sig': Operati=
on
> not permitted
> rm: cannot remove `//sys/module/parport_pc/sections/.bss': Operation not
> permitted
> rm: cannot remove
> `//sys/module/parport_pc/sections/.gnu.linkonce.this_module': Operation n=
ot
> permitted
> [...]
> rm: cannot remove `//sys/block/sda/sda1/start': Operation not permitted
> rm: cannot remove `//sys/block/sda/sda1/dev': Operation not permitted
> rm: `//sys/block/sda/device' changed dev/ino: Operation not permitted
> make: *** [clean_install_dir] Error 1
> [root@RHEL4-8 ltp-2010-02-01]# echo $?
> 2
> [root@RHEL4-8 ltp-2010-02-01]# ls -ltr /opt/ltp
> total 2056
> drwxr-xr-x =A03 root root =A0 =A04096 Feb =A01 10:22 share
> drwxr-xr-x =A02 root root =A0 =A04096 Feb =A01 10:22 testscripts
> drwxr-xr-x =A04 root root =A0 =A04096 Feb =A01 10:22 testcases
> -rwxr-xr-x =A01 root root =A0 =A02603 Feb =A01 10:24 ver_linux
> -rwxr-xr-x =A01 root root =A0 10193 Feb =A01 10:24 runltplite.sh
> -rwxr-xr-x =A01 root root =A0 38054 Feb =A01 10:24 runltp
> -rwxr-xr-x =A01 root root =A0 22819 Feb =A01 10:24 runalltests.sh
> drwxr-xr-x =A02 root root =A0 =A04096 Feb =A01 10:24 bin
> -rw-r--r-- =A01 root root =A0 =A0 =A013 Feb =A01 10:24 Version
> -rwxr-xr-x =A01 root root =A0 =A04645 Feb =A01 10:24 IDcheck.sh
> drwxr-xr-x =A02 root root =A0 =A04096 Feb =A01 10:24 results
> drwxr-xr-x =A02 root root =A0 =A04096 Feb =A01 10:24 output
> -rw-r--r-- =A01 root root 1977717 Feb =A01 11:39 cvs0201-20100201.txt
> drwxr-xr-x =A02 root root =A0 =A04096 Feb =A01 17:20 runtest
> [root@RHEL4-8 ltp-2010-02-01]# ls -ltr /
> total 154
> drwxr-xr-x =A0 =A02 root root =A04096 Aug 13 =A02004 srv
> drwxr-xr-x =A0 =A02 root root =A04096 Aug 13 =A02004 mnt
> drwxr-xr-x =A0 =A02 root root =A04096 Aug 13 =A02004 initrd
> drwxr-xr-x =A0 =A02 root root =A04096 Oct 21 17:08 selinux
> drwxr-xr-x =A0 =A04 root root =A01024 Oct 21 17:11 boot
> drwxr-xr-x =A0 23 root root =A04096 Oct 21 17:27 var
> drwxr-xr-x =A0 =A03 root root =A04096 Oct 21 17:27 tftpboot
> drwx------ =A0 =A02 root root 16384 Oct 22 02:02 lost+found
> drwxr-xr-x =A0 =A02 root root =A04096 Oct 22 09:43 bin
> drwxr-xr-x =A0 =A02 root root 12288 Dec 18 12:44 sbin
> drwxr-xr-x =A0 15 root root =A04096 Jan 12 19:27 usr
> drwxr-xr-x =A0 12 root root =A04096 Jan 19 10:10 lib
> drwxr-xr-x =A0 =A03 root root =A04096 Feb =A01 10:22 opt
> drwxr-xr-x =A0 =A04 root root =A04096 Feb =A01 11:38 home
> drwxr-xr-x =A0 =A04 root root =A04096 Feb =A02 11:46 media
> drwxr-xr-x =A0 96 root root 12288 Feb =A02 11:46 etc
> drwxr-xr-x =A0 =A08 root root =A06520 Feb =A02 11:46 dev
> drwxrwxrwt =A0 10 root root =A04096 Feb =A02 11:48 tmp
> dr-xr-xr-x =A0109 root root =A0 =A0 0 Feb =A02 =A02010 proc
> drwxr-xr-x =A0 =A09 root root =A0 =A0 0 Feb =A02 =A02010 sys
> [root@RHEL4-8 ltp-2010-02-01]# uname -a
> Linux RHEL4-8.localdomain 2.6.9-89.ELsmp #1 SMP Mon Apr 20 10:34:33 EDT 2=
009
> i686 i686 i386 GNU/Linux
> [root@RHEL4-8 ltp-2010-02-01]#
> ------------
>
> "make clean" is going to delete a "/" directory obviously.

Ouch. I need more details, like the following:

1. How did you call configure (if at all)?
2. Was the tree clean?
3. What version of make did you use?

Thanks,
-Garrett

---------------------------------------------------------------------------=
---
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the busine=
ss
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
