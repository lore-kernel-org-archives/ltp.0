From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 8 Aug 2018 16:53:17 +0300
Subject: [LTP] [PATCH 2/2] testcases: netns: Handle "Operation not
 supported" error
In-Reply-To: <20180808130512.GD19147@rei>
References: <20180802141251.1571-1-mylene.josserand@bootlin.com>
 <20180802141251.1571-2-mylene.josserand@bootlin.com>
 <1ef13fe5-debb-57ff-422b-b2b5d3460523@oracle.com>
 <20180808130512.GD19147@rei>
Message-ID: <36530f0d-15ed-e9a4-4740-60805f33faf9@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 08/08/2018 04:05 PM, Cyril Hrubis wrote:
> Hi!
>> Not sure if the same should be here. The test-cases with IPsec involve
>> various crypto drivers that are much easier and better to check with
>> ip/netlink, and we also check both: the support in iproute and kernel.
>> I guess, veth and dummy virtual drivers could be checked with:
>>   
>>    modprobe -q veth || tst_brkm TCONF ...
> 
> That will possibly break on embedded systems that have everything
> compiled-in kernel, not sure if there are any out there.

modprobe looks for modules.builtin as well and will just return 0 if
it finds the driver there. But it might not be available for kernels
before 2.6.33: bc081dd6e9f6 ("kbuild: generate modules.builtin").

> 
>> Perhaps, we could add tst_drivers_available() helper to the library.
> 
> That's a good idea, that way it could be at least tweaked in a single
> place.
> 

