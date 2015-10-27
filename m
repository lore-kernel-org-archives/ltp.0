From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 27 Oct 2015 16:16:55 +0300
Subject: [LTP] How about set IPsec with ip xfrm?
In-Reply-To: <CAPwn2JRO0Dx20LzBHrLhMb85EoU9+_WRnRTS5UO2sQ9Ej3y+Cw@mail.gmail.com>
References: <CAPwn2JRO0Dx20LzBHrLhMb85EoU9+_WRnRTS5UO2sQ9Ej3y+Cw@mail.gmail.com>
Message-ID: <562F7947.30501@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 10/27/2015 10:32 AM, Hangbin Liu wrote:
> Hi Cyril and Alexey,
>
> Msst of the network stress tests have IPsec testing, and
> we use setkey for configuration. But setkey[1] hasn't updated
> for a long time. And some distros, RHEL7 for example, even
> don't have ipset-tools package. So how about rewrite IPsec
> config with ip xfrm? or at least make both method works?

This is a good point. IPsec tests are in icmp, tcp and udp directories, 
right? I've not touch these particular tests yet.

In OL6 we have openswan package, RHEL6 as well. And in OL7, libreswan. 
No ipsec-tools there.

Thanks,
Alexey

> [1] http://ipsec-tools.sourceforge.net/
>
> Thanks
> Hangbin Liu

