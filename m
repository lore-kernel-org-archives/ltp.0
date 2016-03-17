From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 17 Mar 2016 12:18:17 +0300
Subject: [LTP] [PATCH v2] syscalls/fstatat01: fix test on x86_64 arch
In-Reply-To: <1457521336-31979-1-git-send-email-alexey.kodanev@oracle.com>
References: <1457521336-31979-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <56EA7659.9080002@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 03/09/2016 02:02 PM, Alexey Kodanev wrote:
> Test returns TCONF for x86_64 arch as it tries to invoke a syscall
> with __NR_fstatat64 which the arch doesn't have. Test macro checks
> that it != 0, then proceed inside the if block. But it skips the
> case when it's defined as a stub (-1) for x86_64.

Patch applied.

Best regards,
Alexey

