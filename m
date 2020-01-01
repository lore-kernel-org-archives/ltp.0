From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 1 Jan 2020 11:15:11 -0500 (EST)
Subject: [LTP] ./runltp always stop in restarting syslog daemon
In-Reply-To: <tencent_89CAA885596D056C7E2299802BF6D3E62B08@qq.com>
References: <tencent_89CAA885596D056C7E2299802BF6D3E62B08@qq.com>
Message-ID: <558596810.144158.1577895311750.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Hi,
> I use ltp-full-20190930.tar.bz2 run in Ubuntu 16.04.6 LTS , the kernel
> version is 4.4.0-170-generic. My linux is using Vagrant in macOs.
> It always stop in [syslog01 0 TINFO : restarting syslog daemon].

There was a polkit bug that manifisted in this way. Have a look
if you're not running into same issue as described here:
  https://bugzilla.redhat.com/show_bug.cgi?id=1711536
  https://bugzilla.redhat.com/show_bug.cgi?id=1724444

