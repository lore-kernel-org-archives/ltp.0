From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 4 Jul 2018 20:06:03 +0300
Subject: [LTP] [PATCH 2/2] network/route: Rewrite route-change-gw into
 new API
In-Reply-To: <20180704153540.l2edpiia2k6yce7p@dell5510>
References: <20180517103527.23542-1-pvorel@suse.cz>
 <20180517103527.23542-2-pvorel@suse.cz>
 <cfa4f035-9052-147b-4d6d-2b6ecfe4cf31@oracle.com>
 <20180518110110.zeabusjbiq2lq263@dell5510>
 <20180625140158.rvjasl7jq2m4blbc@dell5510>
 <20180704153540.l2edpiia2k6yce7p@dell5510>
Message-ID: <2e4544fc-3d49-90d8-4510-94b053f1647f@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 04.07.2018 18:35, Petr Vorel wrote:
...
>>
>> It would be good to have this helper in order to extend the tests.
>> Not sure if it can be used other than here...
> Yes, I expect it to be suitable just for these 3 route tests.
> 
>> The other option is to configure a host on the other end as well,
>> so that we get responses, and use the standard tools.
> Sorry, don't understand this idea. Which tools do you mean? Some helper from
> tst_net.sh?
> Thanks for info.

Hi Petr,

if we want UDP - use netstress, or just ping...


Thanks,
Alexey
