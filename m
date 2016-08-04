From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 4 Aug 2016 13:13:51 +0300
Subject: [LTP] [PATCH 0/8] network/nfs: fix/cleanup tests
In-Reply-To: <1466432936-3099-1-git-send-email-alexey.kodanev@oracle.com>
References: <1466432936-3099-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <57A3155F.9030804@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 06/20/2016 05:28 PM, Alexey Kodanev wrote:
> Alexey Kodanev (8):
>    lib: add safe_gethostname()
>    network/nfs05: rewrite the test, make use of new library
>    network/nfs_lib.sh: add options, socket type and NFS ver
>    network/nfs/fsx: cleanup test, use test_net library
>    network/nfs/nfsstat: cleanup test, use test_net.sh library
>    network/nfs/nfsflock: clenaup & use test_net library
>    network/nfs/nfs_fsstress: remove fsstress test
>    network/nfs: remove README

Patch-set applied except first two patches that were sent separately as v2.

Thanks,
Alexey

