From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 19 Aug 2016 18:31:31 +0300
Subject: [LTP] [PATCH v2] network/nfs05_make_tree: Define _GNU_SOURCE to
 enable O_DIRECTORY
In-Reply-To: <1471606223-28776-1-git-send-email-yuriy.kolerov@synopsys.com>
References: <1471606223-28776-1-git-send-email-yuriy.kolerov@synopsys.com>
Message-ID: <57B72653.4000907@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 08/19/2016 02:30 PM, Yuriy Kolerov wrote:
> This test uses O_DIRECTORY macro and in some standard libraries it
> may be defined only if _GNU_SOURCE is enabled.

Removed redundant #ifdef and applied. Thanks!
