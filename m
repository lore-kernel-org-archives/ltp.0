From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 28 Jul 2016 17:29:26 +0300
Subject: [LTP] [PATCH] syscalls/sched_getparam03.c: Fix order of
 included headers
In-Reply-To: <1469616081-517-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1469616081-517-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <579A16C6.70804@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 07/27/2016 01:41 PM, Xiao Yang wrote:
> Compilation failed on RHEL5.11GA and RHEL6.8GA because definition of clone()
> function in sched.h will be replaced by the test.h defined clone(...) macro.

Patch applied, thank you.

Best regards,
Alexey

