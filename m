From: Hangbin Liu <liuhangbin@gmail.com>
Date: Wed, 28 Oct 2015 14:52:47 +0800
Subject: [LTP] How about set IPsec with ip xfrm?
In-Reply-To: <562F7947.30501@oracle.com>
References: <CAPwn2JRO0Dx20LzBHrLhMb85EoU9+_WRnRTS5UO2sQ9Ej3y+Cw@mail.gmail.com>
 <562F7947.30501@oracle.com>
Message-ID: <CAPwn2JS9pB39amE4azR9OP8W18SCC8X=8brxdRLv5swEr5kCLg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

2015-10-27 21:16 GMT+08:00 Alexey Kodanev <alexey.kodanev@oracle.com>:
> Hi,
> On 10/27/2015 10:32 AM, Hangbin Liu wrote:
>>
>> Hi Cyril and Alexey,
>>
>> Msst of the network stress tests have IPsec testing, and
>> we use setkey for configuration. But setkey[1] hasn't updated
>> for a long time. And some distros, RHEL7 for example, even
>> don't have ipset-tools package. So how about rewrite IPsec
>> config with ip xfrm? or at least make both method works?
>
>
> This is a good point. IPsec tests are in icmp, tcp and udp directories,

Yes, exactly.

> right? I've not touch these particular tests yet.
>
> In OL6 we have openswan package, RHEL6 as well. And in OL7, libreswan. No
> ipsec-tools there.

Yes, so run stress test on the latest distros is painful. I didn't use
openswan or
libreswan because we need update the config file each time. So I use ip-xfrm to
config the IPsec rules. Here is a draft patch(attached). You can
review it first.

Thanks
Hangbin
>
> Thanks,
> Alexey
>
>
>> [1] http://ipsec-tools.sourceforge.net/
>>
>> Thanks
>> Hangbin Liu
>
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: ipsec.patch
Type: text/x-patch
Size: 12164 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20151028/dafd569a/attachment-0001.bin>
