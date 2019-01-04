From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 4 Jan 2019 10:38:44 +0800
Subject: [LTP] [PATCH] cpu_hotplug/cpuhotplug03.sh: Accurately select
 command name by -C option
In-Reply-To: <20190103210325.GA23827@dell5510>
References: <1542366655-3891-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20181205211352.GC21236@x230> <5C20BF16.6080903@cn.fujitsu.com>
 <20190103210325.GA23827@dell5510>
Message-ID: <5C2EC734.7060006@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2019/01/04 5:03, Petr Vorel wrote:
> Hi Xiao,
>
> ...
>>>> References:
>>>> procps commit: bb272580a6f3c192c61e307f9e341514d892d06e
>>>> procps commit: 14005a371e5c14289e96a4927ffd1a827d3c9d85
>>>> procps commit: 2cfdbbe897f0d4e41460c7c2b92acfc5804652c8
>>>> kernel commit: 6b59808bfe482642287ddf3fe9d4cccb10756652
> Merged with minor changes: remove references from code and use standard
> references (short has + commit message) in commit message.
>
> Thanks for your patch!.
Hi Petr,

Thanks for your push.
>>>> Note:
>>>> I think the lastest ps(1) manpage for command name length is confused
>>>> because kernel only extend workqueue worker name to 64 characters by
>>>> commit 6b59808 and still truncate normal command name to 16 characters.
>>>> e.g:
>>>> ---------------------------------------------------------------------
>>>> cd /root/ltp/testcases/kernel/hotplug/cpu_hotplug/tools
>>>> PATH=$PATH:$PWD cpuhotplug_do_spin_loop&
>>>> [1] 8732
>>>> cat /proc/8732/stat
>>>> 8732 (cpuhotplug_do_s) ...
>>>> cat /proc/8732/status | grep Name
>>>> Name:   cpuhotplug_do_s
>>>> ---------------------------------------------------------------------
>>> Agree.
>>>> I will try to update ps(1) manpage for command name length.
>>> Good :).
> Out of curiosity: have you reported it to procps upstream?
I have reported and sent a fix patch to procps mail list(i.e. 
procps@freelists.org), but it
seems that nobody reveiws and pushes it.   I am going to ping. :-)

Please see attachment for our fix patch.

Best Regards,
Xiao Yang
>
> Kind regards,
> Petr
>
>
>



-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: 0001-docs-Correct-ps.1-for-command-name-length.patch
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190104/b5db03ce/attachment-0001.ksh>
