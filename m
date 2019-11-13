From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 13 Nov 2019 13:55:02 +0300
Subject: [LTP] [PATCH 2/2] network/netstress: set default options value
 after arg parsing
In-Reply-To: <20191113010201.GB21042@x230>
References: <20191112151131.5740-1-alexey.kodanev@oracle.com>
 <20191112151131.5740-2-alexey.kodanev@oracle.com>
 <20191113010201.GB21042@x230>
Message-ID: <8e948e74-fb5a-5e1b-ec52-28276d2b030f@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 13.11.2019 04:02, Petr Vorel wrote:
> Hi Alexey,
> 
>> It fixes misleading warnings about multiple options being set:
> 
>> $ netstress -H 127.0.0.1
>> tst_test.c:500: WARN: Option -H passed multiple times
>> tst_test.c:1217: INFO: Timeout per run is 0h 05m 00s
>> ...
> 
>> But for the result path 'rpath', don't create a file if the option
>> is not set.
> 
>> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Tested-by: Petr Vorel <pvorel@suse.cz>
> 
> Good catch :).
> 

Thanks for review Petr, both patches applied.
