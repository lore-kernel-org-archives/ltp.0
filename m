From: Li Wang <liwang@redhat.com>
Date: Mon, 1 Jun 2020 18:58:47 +0800
Subject: [LTP] [PATCH v2 1/4] lib: add new cgroup test API
In-Reply-To: <20200601100459.32511-1-liwang@redhat.com>
References: <20200601100459.32511-1-liwang@redhat.com>
Message-ID: <CAEemH2e_pzdJj5jDxCB_=SiTweP_RoWXitJdSiYa8-hAR9yjBQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Li Wang <liwang@redhat.com> wrote:

...
>
> +#define PATH_SYS_CGROUP                "/sys/fs/cgroup"
> +#define PATH_TMP_CG1_MEM       "/tmp/cg1_mem"
> +#define PATH_TMP_CG1_CST       "/tmp/cg1_cst"
> +#define PATH_TMP_CGROUP2       "/tmp/cgroup2" /* cgroup v2 has only
> single hierarchy */
> +
>

Seems there is no need to distinguish CG1 and CG2 mount directory
in tst_cgroup.h, because we have introduced the 'tst_cgroup_mnt_path'
to mount cgroup unified, it will choose cgroup versions automatically.

So maybe we can change these above definitions to:

-#define PATH_SYS_CGROUP                "/sys/fs/cgroup"
-#define PATH_TMP_CG1_MEM       "/tmp/cg1_mem"
-#define PATH_TMP_CG1_CST       "/tmp/cg1_cst"
-#define PATH_TMP_CGROUP2       "/tmp/cgroup2" /* cgroup v2 has only single
hierarchy */
+#define PATH_TMP_CGROUP_MEM    "/tmp/cgroup_mem"
+#define PATH_TMP_CGROUP_CST    "/tmp/cgroup_cst"

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200601/8375be37/attachment.htm>
