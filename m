From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 26 Aug 2016 15:08:06 +0300
Subject: [LTP] [PATCH] syscalls/fallocate04: Fix on Btrfs
In-Reply-To: <57C02561.8000608@oracle.com>
References: <20160825165354.GA13281@rei> <57C02561.8000608@oracle.com>
Message-ID: <57C03126.1020609@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 08/26/2016 02:17 PM, Stanislav Kholmanskikh wrote:
> Hi,
>
> On 08/25/2016 07:53 PM, Cyril Hrubis wrote:
>> The size of a file can double on Btrfs temporarily even when we write
>> into a preallocated space because of internal Btrfs caches, at least
>> that is what I've been told by Btrfs devs. The internal caches are then
>> freed after some time, or can be force freed by syncing the file, which
>> is what this patch does.

So if we have available free space x Mb,  we can't allocate more than x 
/ 2 Mb and it's not a bug?

Best regards,
Alexey

