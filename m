From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 20 Jul 2020 11:03:05 +0200
Subject: [LTP] [PATCH v2 2/7] tst_net.sh: Use ssh in LTP_RSH
In-Reply-To: <5F15551D.5050703@cn.fujitsu.com>
References: <20200710172044.21592-1-pvorel@suse.cz>
 <20200710172044.21592-3-pvorel@suse.cz>
 <5F155335.8080901@cn.fujitsu.com> <5F15551D.5050703@cn.fujitsu.com>
Message-ID: <20200720090305.GF11397@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> testscripts/exportfs.sh, tcp_cmds/ftp/ftp01.sh and nfsv4/acl/runtest also
> use rsh command directly.

That's a sign of legacy code with questionable usability.

Although runltp-ng [1] has not been merged yet, I'm going to sent RFC patch to remove
exportfs.sh. I'll also send RFC to drop network/nfsv4 (NFS maintainers use their
own pynfs [2] anyway).

[1] https://github.com/metan-ucw/runltp-ng
[2] http://git.linux-nfs.org/?p=bfields/pynfs.git;a=summary

Kind regards,
Petr
