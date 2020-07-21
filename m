From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 21 Jul 2020 10:35:09 +0800
Subject: [LTP] [PATCH v2 4/7] net: Update README.md
In-Reply-To: <20200720141547.GB21201@dell5510>
References: <20200710172044.21592-1-pvorel@suse.cz>
 <20200710172044.21592-5-pvorel@suse.cz> <5F15686A.1070605@cn.fujitsu.com>
 <20200720141547.GB21201@dell5510>
Message-ID: <5F16545D.4090103@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2020/7/20 22:15, Petr Vorel wrote:
> Hi,
>
> ...
>>> +++ b/testcases/network/README.md
> ...
>>>    ## Server Services Configuration
>>>    Verify that the below daemon services are running. If not, please install
>>>    and start them:
>>> -rsh-server, telnet-server, finger-server, rdist, rsync, dhcp-server, http-server.
>>> +
>>> +dhcp-server, dnsmasq, http-server, nfs-kernel-server, rpcbind, rsync,
>>> +telnet-server, vsftpd
>> Hi Petr,
>> These package names are from Debian/Ubuntu, do we need to mention it?
> All these packages are at least in Debian/Ubuntu and openSUSE. IMHO other
> distros have similar names. Exception is nfs-kernel-server, which is at least on
> Fedora/RHEL nfs-server. Thus something like:
>
> dhcp-server, dnsmasq, http-server, nfs-kernel-server or nfs-server, rpcbind,
> rsync,telnet-server, vsftpd
Hi Petr,

If these name represent pakcage name, there are some differnets between 
Debian/Ubuntu/openSUSE and Fedora/RHEL:
Debian/Ubuntu/openSUSE: isc-dhcp-server, dnsmasq?apache2, 
nfs-kernel-server, rpcbind?rsync, telnetd + xinetd, vsftpd
RHEL/Fedora: dhcp, dnsmasq?httpd, nfs-utils?rpcbind?rsync, 
telnet-server, vsftpd

Could we just represent service name:
dhcpd(or isc-dhcp-server), dnsmasq, httpd(or apache2), nfs-server, 
rpcbind, telnet.socket(or xinetd), vsftpd

BTW: I cannot find which test use rsync, did I miss something?

>>>    Note: If any of the above daemon is not running on server, the test related to
>>>    that service running from client will fail.
>>> -### FTP setup
>>> -* In ?/etc/ftpusers? [or vi /etc/vsftpd.ftpusers], comment the line containing
>>> -?root? string. This file lists all those users who are not given access to do ftp
>>> +### FTP and telnet setup
>>> +Both tests require environment variables `RHOST` (remote machine), `RUSER`
>>> +(remote user) and `PASSWD` (remote password). NOTE: `RHOST` will imply two host
>>> +configuratioe for other tests.
>>> +
>>> +If `RHOST` is set to `root`, either of these steps is required:
>>> +
>>> +* In `/etc/ftpusers` (or `/etc/vsftpd.ftpusers`), comment the line containing
>>> +"root" string. This file lists all those users who are not given access to do ftp
>>>    on the current system.
>> Are this file from Debian/Ubuntu as well?
> Again, /etc/ftpusers is at least for openSUSE and Debian/Ubuntu.
> Fedora/RHEL has /etc/vsftpd/ftpusers and /etc/vsftpd/user_list
> /etc/vsftpd.ftpusers looks like to be on RHEL 4/ some old Fedora.
>
> Thus:
> * In `/etc/ftpusers` (or `/etc/vsftpd/ftpusers` or `/etc/vsftpd.ftpusers`),
> * comment the line containing
> ...

This change looks good. :-)

> I also wondered if setup should mention something related to single test,
> but it didn't harm. I was thinking whether ftp test is worth to keep (and thus
> need to be rewritten), but understand it's useful as a high level smoke test.
1) It seems better to mention something related to single test.
2) Perfer to keep and rewrite ftp test.

Thanks,
Xiao Yang
> OK with these changes?
>
> Kind regards,
> Petr
>
>> Other than this, it is good to me. :-)
>> Acked-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>> Thanks,
>> Xiao Yang
>
> .
>



