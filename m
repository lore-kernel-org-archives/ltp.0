From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 21 Jul 2020 08:11:13 +0200
Subject: [LTP] [PATCH v2 4/7] net: Update README.md
In-Reply-To: <5F16545D.4090103@cn.fujitsu.com>
References: <20200710172044.21592-1-pvorel@suse.cz>
 <20200710172044.21592-5-pvorel@suse.cz>
 <5F15686A.1070605@cn.fujitsu.com> <20200720141547.GB21201@dell5510>
 <5F16545D.4090103@cn.fujitsu.com>
Message-ID: <20200721061113.GA4088@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yang,

> If these name represent pakcage name, there are some differnets between
> Debian/Ubuntu/openSUSE and Fedora/RHEL:
> Debian/Ubuntu/openSUSE: isc-dhcp-server, dnsmasq?apache2,
> nfs-kernel-server, rpcbind?rsync, telnetd + xinetd, vsftpd
> RHEL/Fedora: dhcp, dnsmasq?httpd, nfs-utils?rpcbind?rsync, telnet-server,
> vsftpd

> Could we just represent service name:
> dhcpd(or isc-dhcp-server), dnsmasq, httpd(or apache2), nfs-server, rpcbind,
> telnet.socket(or xinetd), vsftpd
I'd either wrote software names (people would have to find the package name for
the distro) or find package names for all distros (Debian / Ubuntu, OpenSUSE / SLES,
Fedora / CentOS / RHEL as it's in INSTALL).

And there are xinetd tests, so xinetd are always needed.

+ There is some other packages needed. But instead of writing it here it'd be
good to add it to metadata. We're working with Cyril on docparse project, which
will autogenerate this metadata.

> BTW: I cannot find which test use rsync, did I miss something?
Correct, this looks like a leftover from the past. Thanks!

> > > >    Note: If any of the above daemon is not running on server, the test related to
> > > >    that service running from client will fail.
> > > > -### FTP setup
> > > > -* In ?/etc/ftpusers? [or vi /etc/vsftpd.ftpusers], comment the line containing
> > > > -?root? string. This file lists all those users who are not given access to do ftp
> > > > +### FTP and telnet setup
> > > > +Both tests require environment variables `RHOST` (remote machine), `RUSER`
> > > > +(remote user) and `PASSWD` (remote password). NOTE: `RHOST` will imply two host
> > > > +configuratioe for other tests.
> > > > +
> > > > +If `RHOST` is set to `root`, either of these steps is required:
> > > > +
> > > > +* In `/etc/ftpusers` (or `/etc/vsftpd.ftpusers`), comment the line containing
> > > > +"root" string. This file lists all those users who are not given access to do ftp
> > > >    on the current system.
> > > Are this file from Debian/Ubuntu as well?
> > Again, /etc/ftpusers is at least for openSUSE and Debian/Ubuntu.
> > Fedora/RHEL has /etc/vsftpd/ftpusers and /etc/vsftpd/user_list
> > /etc/vsftpd.ftpusers looks like to be on RHEL 4/ some old Fedora.

> > Thus:
> > * In `/etc/ftpusers` (or `/etc/vsftpd/ftpusers` or `/etc/vsftpd.ftpusers`),
> > * comment the line containing
> > ...

> This change looks good. :-)
ok.

> > I also wondered if setup should mention something related to single test,
> > but it didn't harm. I was thinking whether ftp test is worth to keep (and thus
> > need to be rewritten), but understand it's useful as a high level smoke test.
> 1) It seems better to mention something related to single test.
> 2) Perfer to keep and rewrite ftp test.
ok.

Kind regards,
Petr
