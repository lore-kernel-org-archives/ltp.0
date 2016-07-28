From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 28 Jul 2016 17:30:34 +0300
Subject: [LTP] [PATCH] syscalls/*: Fix order of included headers
In-Reply-To: <1469616713-1025-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1469616713-1025-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <579A170A.80209@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 07/27/2016 01:51 PM, Xiao Yang wrote:
> Compilation failed on RHEL5.11GA and RHEL6.8GA because definition of clone()
> function in sched.h will be replaced by the test.h defined clone(...) macro.
This one applied as well. Thanks.

Best regards,
Alexey

