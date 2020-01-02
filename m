From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 2 Jan 2020 09:59:10 +0800
Subject: [LTP] ./runltp always stop in restarting syslog daemon
In-Reply-To: <tencent_89CAA885596D056C7E2299802BF6D3E62B08@qq.com>
References: <tencent_89CAA885596D056C7E2299802BF6D3E62B08@qq.com>
Message-ID: <ca2b9208-17eb-a6f2-eefb-73bedbf6af9b@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hi> Hi,
> I use ltp-full-20190930.tar.bz2? run in Ubuntu 16.04.6 LTS , the kernel 
> version is?4.4.0-170-generic. My linux is using Vagrant in macOs.
> It always stop in [syslog01? ? 0? TINFO? :? restarting syslog daemon].
> I don't know how to troubleshoot this cause. Thanks for your help.
> 
> 
> 
Months ago, I met the same issue. This polkit patch(pkttyagent: 
polkit-agent-helper-1 timeout leaves tty echo disable) leads service 
actions(such as restart) don't stop if controlling terminal can not be 
found. The service action has been executed successfully, but process 
still also hangs.
polkit related issue url:
https://gitlab.freedesktop.org/polkit/polkit/issues/85

fix patch url:
https://gitlab.freedesktop.org/polkit/polkit/commit/75c8b8afaa8e1fba0efb63c3c7b66b5b5f713a35

Best Regards
Yang Xu


