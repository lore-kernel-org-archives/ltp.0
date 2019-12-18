From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 18 Dec 2019 17:46:30 +0300
Subject: [LTP] [PATCH v2 2/2] network/iptables: add new test for
 iptables-tranlsate and nft
In-Reply-To: <20191218084406.GA10966@dell5510>
References: <20191217171918.10237-1-alexey.kodanev@oracle.com>
 <20191217171918.10237-2-alexey.kodanev@oracle.com>
 <20191218084406.GA10966@dell5510>
Message-ID: <f0aad696-82a5-fb06-0517-a437d95ae2e7@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 18.12.2019 11:44, Petr Vorel wrote:
> Hi Alexey,
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> one more fix below.
> 
...
>> +. iptables_lib.sh
>> +. tst_test.sh
>> +
>> +cleanup_tables=0
> cleanup_table=0
> 
> Otherwise it fails:
> nft01 1 TCONF: 'nft' not found
> /opt/ltp/testcases/bin/nft01.sh: line 37: [: -eq: unary operator expected> 
> + nit (code style comments, feel free to ignore):
> 
> 1) I'd use empty variable instead of 0 (and [ "$cleanup_chain" = 1 ]),
> we discuss it with previous patches.
> 
> 2) I'd move TST_CNT=6 to iptables_lib.sh (if test function adds more tests, all
> iptables_lib.sh uses would have to update it). Maybe all but these could be
> there: TST_SETUP, TST_CLEANUP and use_iptables.
> 
> 3) I'd move cleanup_table and cleanup_chain below use_iptables
> (or use_iptables below, just to have all 3 variables together).

Thanks Petr! Fixed them and applied the patches.

