From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 23 Dec 2016 09:46:22 +0100
Subject: [LTP] [PATCH 1/1] network: handle ping6 vs. ping -6
	compatibility
In-Reply-To: <ba1b4a08-b1bb-ca51-96d8-280b4fd92b39@oracle.com>
References: <20161221173148.25925-1-pvorel@suse.cz>
 <ba1b4a08-b1bb-ca51-96d8-280b4fd92b39@oracle.com>
Message-ID: <20161223084622.adoxnmdeh3ojxlwz@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> Didn't get the idea of the patch, is it a fix for the newer iputils
> packages?
> Do you have a symlink to ping in the newer packages?

> In OL7.3:
> # ll $(which ping6)
> lrwxrwxrwx. 1 root root 4 Nov  7 02:00 /usr/bin/ping6 -> ping

> # rpm -q iputils
> iputils-20160308-8.el7.x86_64

It's a problem since version s20150815.
Upstream does not provide these links, it's up to distribution package maintainers to
provide it.
https://github.com/iputils/iputils/commit/ebad35fee3de851b809c7b72ccc654a72b6af61d

Current openSUSE Tumbleweed doesn't provide it (in fact it looks like they never did). I
consider this as a bug in openSUSE (broken backwards compatibility) and report it, but
there might be more distros with this problem. It might be worth adding a note in
testcases/network/README.md or INSTALL.


Kind regards,
Petr
