From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Fri, 20 Aug 2021 12:00:11 +0300
Subject: [LTP] [PATCH] lib/tst_test.sh: fix ROD_SILENT command return
 status check
In-Reply-To: <YR6Ax7TXsa5tipei@pevik>
References: <20210819152154.16185-1-aleksei.kodanev@bell-sw.com>
 <YR6Ax7TXsa5tipei@pevik>
Message-ID: <bc8fc318-f396-0d45-69f9-814e750311a8@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 19.08.2021 19:03, Petr Vorel wrote:
> Hi Alexey,
> 
>> "local tst_out=$(some_command)" always returns status 0, i.e.
>> not the return status of the command in the assignment, but the
>> status for 'local' builtin command, which creates a new local
>> variable inside the function.
> 
>> As a result, the library calls and tests that invoke ROD_SILENT
>> don't actually check the return status of commands passed to it.
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Very good catch, thanks!
> 
> Tested-by: Petr Vorel <pvorel@suse.cz>
> Working the same in: bash, dash, busybox sh, mksh (android).
> 
>> The old API library function is also fixed.
> +1
> 

Applied. Thanks Petr!


