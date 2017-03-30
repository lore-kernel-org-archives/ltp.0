From: Alton L Pundt <apundt@us.ibm.com>
Date: Thu, 30 Mar 2017 08:15:49 -0600
Subject: [LTP] mc_cmds01 needs change from netstat command to ip maddr
	show dev
In-Reply-To: <20170330133743.vvtdzu662t755b6u@dell5510>
References: <OFEAC1E085.E5C67116-ON862580F3.00105817-862580F3.00110BF2@notes.na.collabserv.com>
 <20170330133743.vvtdzu662t755b6u@dell5510>
Message-ID: <OFE5AA8B6F.73052B3F-ON862580F3.004E361A-862580F3.004E5BC2@notes.na.collabserv.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The last email I have from the guy that maintains our testcase repository 
said:

LTP testcase updated to 20170116 for ubuntu17.04



Thanks,
A.P. Pundt
sametime:apundt@us.ibm.com
office:512-286-8093
office: 45/3A-97
IBM-Austin, Texas



From:   Petr Vorel <pvorel@suse.cz>
To:     Alton L Pundt/Austin/IBM@IBMUS
Cc:     ltp@lists.linux.it
Date:   03/30/2017 08:37 AM
Subject:        Re: [LTP] mc_cmds01 needs change from netstat command to 
ip maddr show dev



Hi Alton,

> Have you tested with "ip maddr" instead?  For example, in your script,

>   netstat -gn | grep $IFNAME | grep -q 224.0.0.1

> would become:

>   ip maddr show dev $IFNAME | grep -q 224.0.0.1

> The extra benefit here is one less subshell and grep command to look for 

> the target multicast group.

Which version of LTP do you use? netstat and ifconfig was replaced with ip 
a while ago in
commit 491423d9f695480a18abc2ad4167aad51b06be96 [1], released in LTP 
20150420.

Can you test it with recent release?


Kind regards,
Petr

[1] 
https://github.com/linux-test-project/ltp/commit/491423d9f695480a18abc2ad4167aad51b06be96






-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170330/9ef424b6/attachment.html>
