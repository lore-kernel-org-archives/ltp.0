From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 20 Nov 2020 08:59:01 +0300
Subject: [LTP] [PATCH 1/1] net/traceroute01: Check also -T flag
In-Reply-To: <20201119195618.GA3181@pevik>
References: <20201112173609.4123-1-petr.vorel@suse.com>
 <20201119152300.05ef03b0@kmaincent-XPS-13-7390>
 <20201119154132.GA16438@pevik>
 <cf76949d-32a7-7b2d-4d5b-6117676ecea6@oracle.com>
 <20201119195618.GA3181@pevik>
Message-ID: <1d451c4a-6599-ac95-2b51-509fdd4c277a@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 19.11.2020 22:56, Petr Vorel wrote:
> Hi Alexey,
> 
>> On 19.11.2020 18:41, Petr Vorel wrote:
>>> Hi Kory, Alexey,
> 
>>>> Hello Petr,
> 
>>>> Just find out you didn't merge your patch which makes the code cleaner. :)
>>> Waiting for Alexey's review.
>>> Also hesitate about tracepath6 symlink to traceroute being always installed
> I meant here traceroute6 symlink to traceroute.
>>> on all distros (hopefully yes).
> 
>> Hi Petr,
> 
>> From the subject it seems you are adding a new check for -T flag
>> but it is actually for -I option?
> Good catch, thanks!
> 
>> I think it's ok using symlink or -4/-6,
> If nobody complains I'd keep symlink version as it can check
> traceroute from iputils. -4/-6 is more portable. If anybody complains and we
> revert it back, I'd also put back iputils related warning.
> 
>> it is also adding an extra
>> check for ipv6 that $(tst_ipaddr rhost) is indeed ipv6.
> Sorry, I didn't get this.
> 

Hi Petr,

traceroute6 127.0.0.1
traceroute6: 127.0.0.1: Address family for hostname not supported

And both ::1 and 127.0.0.1 are ok for traceroute without the address
family option.

> BTW ack this change?
> 

Acked-by: Alexey Kodanev <alexey.kodanev@oracle.com>
