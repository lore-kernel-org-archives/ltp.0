From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 22 Aug 2017 15:23:01 +0300
Subject: [LTP] [RFC PATCH v8 10/11] network: Add tools for setup IP
 related environment variables
In-Reply-To: <20170818164437.13556-11-pvorel@suse.cz>
References: <20170818164437.13556-1-pvorel@suse.cz>
 <20170818164437.13556-11-pvorel@suse.cz>
Message-ID: <139abe87-0496-8023-1386-788e289aaf2d@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 08/18/2017 07:44 PM, Petr Vorel wrote:
> New tools:
> * tst_net_ip_prefix
> Strip prefix from IP address and save both
> If no prefix found sets default prefix.
>
> * tst_net_iface_prefix
> tst_net_iface_prefix reads prefix and interface from rtnetlink.
>
> * tst_net_vars takes input of local and remote address and setup most of
> test link (IP related) environment variables.

Here is the thread with minor comments that still applicable to this
version:

http://lists.linux.it/pipermail/ltp/2017-June/004838.html

Thanks,
Alexey

