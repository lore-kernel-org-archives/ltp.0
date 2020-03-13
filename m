From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 13 Mar 2020 16:50:46 +0300
Subject: [LTP] [PATCH v2 3/3] nfs_lib: Add option to run traffic via lo
 on netns
In-Reply-To: <20200311185638.GA12912@dell5510>
References: <20200311175011.12171-1-pvorel@suse.cz>
 <20200311175011.12171-3-pvorel@suse.cz> <20200311185638.GA12912@dell5510>
Message-ID: <46684b2a-2e35-8750-bddf-62ba199fcc9f@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 11.03.2020 21:56, Petr Vorel wrote:
> Hi Alexey,
> 
> ...
>> diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
> ...
>> +# When set and test is using netns ($TST_USE_NETNS set) NFS traffic will go
>> +# through lo interface instead of ltp_ns_veth* netns interfaces (useful for
>> +# debugging whether test failures are related to veth/netns).
>> +LTP_NFS_NETNS_USE_LO=
> Sorry, this needs to be
> LTP_NFS_NETNS_USE_LO=${LTP_NFS_NETNS_USE_LO:-}
> 
> + suggest different name, if you don't like this.
> 
> Kind regards,
> Petr
> 

Hi Petr, the patch-series LGTM,

Reviewed-by: Alexey Kodanev <alexey.kodanev@oracle.com>
