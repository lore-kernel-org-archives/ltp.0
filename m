From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 13 Apr 2017 23:01:14 +0300
Subject: [LTP] [PATCH v2 1/2] dns-stress: fix test and use locally
 defined IP addresses
In-Reply-To: <1491945900-13627-1-git-send-email-alexey.kodanev@oracle.com>
References: <1491945900-13627-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <4e6a79b4-f05f-200f-62a0-5926c999abff@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 12.04.2017 0:24, Alexey Kodanev wrote:
> * define IP addresses, which are used in DNS query/answer,
>   inside the test. It should be safe to use any network
>   as we run 'named' on a non-standard port

Patch-set applied,
Petr, thanks for review!

Best regards,
Alexey

