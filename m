From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 9 Feb 2021 15:45:20 +0300
Subject: [LTP] [PATCH 2/2] if-mtu-change.sh: Lower CHANGE_INTERVAL for
 netns
In-Reply-To: <YCFhIs/lyRGTh8IR@pevik>
References: <20210205142051.32055-1-pvorel@suse.cz>
 <20210205142051.32055-2-pvorel@suse.cz>
 <c5322d13-c69d-aa4d-193c-7c047a405d9a@oracle.com> <YCFhIs/lyRGTh8IR@pevik>
Message-ID: <45f388a1-4c96-d35c-8c61-879631fcae51@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 08.02.2021 19:04, Petr Vorel wrote:
> How about allow to overwrite CHANGE_INTERVAL even for netns?
> i.e move tst_is_int $CHANGE_INTERVAL && TST_TIMEOUT=$CHANGE_INTERVAL
> after the test (although it's unlikely anybody would use sec value for netns
> and ms value for ssh):
> 
> # CHANGE_INTERVAL: The interval of the mtu change
> TST_TIMEOUT=1
> if tst_net_use_netns; then
>     CHANGE_INTERVAL=${CHANGE_INTERVAL:-100ms}
> else
>     CHANGE_INTERVAL=${CHANGE_INTERVAL:-5}
> fi
> tst_is_int $CHANGE_INTERVAL && TST_TIMEOUT=$CHANGE_INTERVAL
> TST_TIMEOUT=$(((TST_TIMEOUT + 30) * MTU_CHANGE_TIMES))
> 

Yeah, looks good.
