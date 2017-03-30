From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 30 Mar 2017 15:37:43 +0200
Subject: [LTP] mc_cmds01 needs change from netstat command to ip maddr
 show dev
In-Reply-To: <OFEAC1E085.E5C67116-ON862580F3.00105817-862580F3.00110BF2@notes.na.collabserv.com>
References: <OFEAC1E085.E5C67116-ON862580F3.00105817-862580F3.00110BF2@notes.na.collabserv.com>
Message-ID: <20170330133743.vvtdzu662t755b6u@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alton,

> Have you tested with "ip maddr" instead?  For example, in your script,

>   netstat -gn | grep $IFNAME | grep -q 224.0.0.1

> would become:

>   ip maddr show dev $IFNAME | grep -q 224.0.0.1

> The extra benefit here is one less subshell and grep command to look for 
> the target multicast group.

Which version of LTP do you use? netstat and ifconfig was replaced with ip a while ago in
commit 491423d9f695480a18abc2ad4167aad51b06be96 [1], released in LTP 20150420.

Can you test it with recent release?


Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/commit/491423d9f695480a18abc2ad4167aad51b06be96
