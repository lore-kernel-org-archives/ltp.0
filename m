From: Jia Zhang <zhang.jia@linux.alibaba.com>
Date: Mon, 7 Jan 2019 23:59:23 +0800
Subject: [LTP] [PATCH 6/6] ima: Use ima tcb policy files for test
In-Reply-To: <1546827989-43569-7-git-send-email-zhang.jia@linux.alibaba.com>
References: <1546827989-43569-1-git-send-email-zhang.jia@linux.alibaba.com>
 <1546827989-43569-7-git-send-email-zhang.jia@linux.alibaba.com>
Message-ID: <af3c44cd-2296-97e2-573e-b80da216738d@linux.alibaba.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On 2019/1/7 上午10:26, Jia Zhang wrote:
> In order to make all tests running smoothly, the policy files should
> keep up ith the default ima tcb policy. Especially ima_violations.sh
> expects to have a func=FILE_CHECK with mask=MAY_WRITE to trigger open

Oops ... This is not true. mask=MAY_READ is already working well for
open writer and ToMToU violations. So please drop this patch.

Jia

> writer and ToMtoU violations. Unfortunately, if ima_policy.sh
> which would change the system IMA policy ran before ima_violations.sh,
> ima_violations.sh would fail for sure because its prerequisite is broken.
> 
> Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
> ---
>  .../security/integrity/ima/datafiles/measure.policy     | 17 +++++++++++++++--
>  .../integrity/ima/datafiles/measure.policy-invalid      | 17 +++++++++++++++--
>  2 files changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/kernel/security/integrity/ima/datafiles/measure.policy b/testcases/kernel/security/integrity/ima/datafiles/measure.policy
> index 9976ddf..546267c 100644
> --- a/testcases/kernel/security/integrity/ima/datafiles/measure.policy
> +++ b/testcases/kernel/security/integrity/ima/datafiles/measure.policy
> @@ -11,6 +11,19 @@ dont_measure fsmagic=0x64626720
>  dont_measure fsmagic=0x01021994
>  # SECURITYFS_MAGIC
>  dont_measure fsmagic=0x73636673
> -measure func=FILE_MMAP mask=MAY_EXEC
> +# DEVPTS_SUPER_MAGIC
> +dont_measure fsmagic=0x1cd1
> +# BINFMTFS_MAGIC
> +dont_measure fsmagic=0x42494e4d
> +# SELINUX_MAGIC
> +dont_measure fsmagic=0xf97cff8c
> +# CGROUP_SUPER_MAGIC
> +dont_measure fsmagic=0x27e0eb
> +# NSFS_MAGIC
> +dont_measure fsmagic=0x6e736673
> +measure func=MMAP_CHECK mask=MAY_EXEC
>  measure func=BPRM_CHECK mask=MAY_EXEC
> -measure func=FILE_CHECK mask=MAY_READ uid=0
> +measure func=FILE_CHECK euid=0
> +measure func=FILE_CHECK uid=0
> +measure func=MODULE_CHECK
> +measure func=FIRMWARE_CHECK
> diff --git a/testcases/kernel/security/integrity/ima/datafiles/measure.policy-invalid b/testcases/kernel/security/integrity/ima/datafiles/measure.policy-invalid
> index 04dff89..bc72d0c 100644
> --- a/testcases/kernel/security/integrity/ima/datafiles/measure.policy-invalid
> +++ b/testcases/kernel/security/integrity/ima/datafiles/measure.policy-invalid
> @@ -11,6 +11,19 @@ dont_measure fsmagic=0x64626720
>  dont_measure fsmagic=0x01021994
>  # SECURITYFS_MAGIC
>  dnt_measure fsmagic=0x73636673
> -measure func=FILE_MMAP mask=MAY_EXEC
> +# DEVPTS_SUPER_MAGIC
> +dont_measure fsmagic=0x1cd1
> +# BINFMTFS_MAGIC
> +dont_measure fsmagic=0x42494e4d
> +# SELINUX_MAGIC
> +dont_measure fsmagic=0xf97cff8c
> +# CGROUP_SUPER_MAGIC
> +dont_measure fsmagic=0x27e0eb
> +# NSFS_MAGIC
> +dont_measure fsmagic=0x6e736673
> +measure func=MMAP_CHECK mask=MAY_EXEC
>  measure func=BPRM_CHECK mask=MAY_EXEC
> -measure func=FILE_CHECK mask=MAY_READ uid=0
> +measure func=FILE_CHECK euid=0
> +measure func=FILE_CHECK uid=0
> +measure func=MODULE_CHECK
> +measure func=FIRMWARE_CHECK
> 
