From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 24 May 2018 12:51:24 +0300
Subject: [LTP] [PATCH] network/gre01: fix device type setting
In-Reply-To: <20180523153843.2fnu46er7p7jzekr@dell5510>
References: <1527090044-11443-1-git-send-email-alexey.kodanev@oracle.com>
 <20180523153843.2fnu46er7p7jzekr@dell5510>
Message-ID: <724a12cc-5498-4dd3-ab28-9ff00909f261@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 05/23/2018 06:38 PM, Petr Vorel wrote:
> Hi Alexey,
> 
>> Since the include of tst_net.sh moved to virt_lib.sh, setting
>> correct GRE device type should be moved there too, i.e. after
>> sourcing tst_net.sh and before virt_lib.sh. Otherwise IPv6
>> test-case won't work.
> 
>> Fixes: ce920a5a430c ("network/virt_lib.sh: Process getopts parameters with TST_OPTS and TST_PARSE_ARGS")
>> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> Acked-by: Petr Vorel <pvorel@suse.cz>

Applied.


> Sorry for breaking it, thanks for the fix!
> 
> 
> Kind regards,
> Petr
> 

