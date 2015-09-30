From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 30 Sep 2015 12:04:27 +0300
Subject: [LTP] [PATCH resend] network/virt/vxlan: add dstport option if
 ip supports it
In-Reply-To: <1442396507-29678-1-git-send-email-alexey.kodanev@oracle.com>
References: <1442396507-29678-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <560BA59B.1080206@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 09/16/2015 12:41 PM, Alexey Kodanev wrote:
> Newer versions of 'iproute' complain about not set VxLAN
> 'dstport' option:
>
>    vxlan: destination port not specified
>    Will use Linux kernel default (non-standard value)
>    Use 'dstport 4789' to get the IANA assigned value
>    Use 'dstport 0' to get default and quiet this message
>
> This message interferes with the actual test output. If 'iproute'
> supports the option, set it when adding new VxLAN devices.

Patch applied.

Thanks,
Alexey

