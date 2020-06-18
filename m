From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 18 Jun 2020 16:24:46 +0300
Subject: [LTP] [PATCH] network/nsf_lib.sh: TCONF on mount (udp/udp6)
 failure for Linux v5.6+
In-Reply-To: <20200618093646.GA11962@dell5510>
References: <20200617154926.32588-1-alexey.kodanev@oracle.com>
 <CAEemH2dOxAnaaMXhKyj36FqmYDQ_p_kfi-=pMQhrE3O9oQO8LA@mail.gmail.com>
 <20200618055105.GA42990@x230> <20200618093646.GA11962@dell5510>
Message-ID: <8b5eef18-1c3e-d89c-9af2-b27828f3cb02@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 18.06.2020 12:36, Petr Vorel wrote:
> Hi Li, Alexey, Cyril,
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
>>>> +++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
>>>> @@ -87,11 +87,17 @@ nfs_mount()
> 
>>>>         tst_res TINFO "Mounting NFS: $mnt_cmd"
>>>>         if [ -n "$LTP_NETNS" ] && [ -z "$LTP_NFS_NETNS_USE_LO" ]; then
>>>> -               tst_rhost_run -s -c "$mnt_cmd"
> 
> 
>>> Or, maybe we can have a new function naming as 'tst_kconifg_check' to parse
>>> kernel .config in shell library as well?
>> +1, I was thinking about it for a long time.
> Thinking about the balance between base TCONF decision on kernel version vs.
> require kernel config to be presented I think for cases like this I'd prefer
> kernel version based check (i.e. the original patch).
> 
> Requiring kernel config is ok for traditional distros (and even here is
> sometimes readable only for root, e.g. Debian/Ubuntu), but it's still rare on
> arm (other embedded archs). I guess it'd be nice to have some variable, which
> would turn kernel config based requirement into warning.
> 

Also the option's name can be renamed in new releases, so the decision
should be made only if the option is found (i.e. if we check without the
the kernel version).

tst_check_kconfig - will be really nice to have. Then, we will tconf
earlier in the setup if this option is found.

What about TCONF_IF_KCONFIG, in addition to NEEDS_KCONFIG?

> Kind regards,
> Petr
> 

