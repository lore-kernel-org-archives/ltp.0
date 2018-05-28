From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 28 May 2018 17:03:02 +0300
Subject: [LTP] [PATCH 4/4] net/macsec0{1,
	2}.sh: Use TST_NET_SKIP_PARSE_ARGS=1
In-Reply-To: <20180526111545.20521-4-pvorel@suse.cz>
References: <20180526111545.20521-1-pvorel@suse.cz>
 <20180526111545.20521-4-pvorel@suse.cz>
Message-ID: <e8c0ca78-e854-c160-f3c6-87241a259cfd@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 05/26/2018 02:15 PM, Petr Vorel wrote:
> These tests load ipsec_lib.sh and virt_lib.sh.
> Currently tst_net.sh doesn't support being used by more libraries, so
> when handling getopts the later one wins.
> Disabling variables as they aren't used in the runtest file.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Alexey, do you use library variables for debugging?
> Or would you prefer to be without this and to have at least one
> libraries getopts?
> 


I'm for keeping the IPsec options in macsec test, some of them are not
explicitly defined in the test, therefore can be changed.

For virt_lib.sh library the better fix would be to define the options
only for vxlan/geneve tests, because only those tests are currently
using them.
