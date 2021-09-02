From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Thu, 2 Sep 2021 10:06:54 +0200
Subject: [LTP] [PATCH v5 2/3] controllers/cpuacct: skip cpuacct_100_100
 on small memory systems
In-Reply-To: <YS/Iiy7xWGZJEayN@pevik>
References: <20210901151655.95760-1-krzysztof.kozlowski@canonical.com>
 <20210901151655.95760-2-krzysztof.kozlowski@canonical.com>
 <YS/DGPyHmEHnRSZk@yuki> <YS/Iiy7xWGZJEayN@pevik>
Message-ID: <0e06b0e8-6e6e-6755-60f9-56580f7917a3@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 01/09/2021 20:38, Petr Vorel wrote:
>> Hi!
>>> +check_limits()
>>> +{
>>> +	local tasksneeded=$((max * nbprocess + 100))
> 
>> We allready have some reserve for the system in the tst_get_free_pids()
>> so shouldn't this be just max * nbprocess ?
> 
> Yes:
> lib/tst_pid.c
> 
> /* Leave some available processes for the OS */
> #define PIDS_RESERVE 50
> 
> I suppose 50 is enough, but if 100 is experienced to be needed I'd update PIDS_RESERVE.

Indeed, it's a duplicated reserve now. Let's dtop 100 here and use
existing PIDS_RESERVE.

> 
> Also, because you introduced use of awk, I'd add TST_NEEDS_CMDS="awk". Or is it
> that common even on embedded systems that we don't bother?

Even though most of Busybox installations have awk, it might be still
missing in some specific setup, so TST_NEEDS_CMDS="awk" seems reasonable.

> 
> NOTE: all changes can be done during merge, we just need to agree on it.
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> Kind regards,
> Petr
> 



Best regards,
Krzysztof
