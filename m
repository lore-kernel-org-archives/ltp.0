From: Li Wang <liwang@redhat.com>
Date: Thu, 20 Feb 2020 15:06:33 +0800
Subject: [LTP] [PATCH V2 01/10] tst_device: Add tst_ismount() helper
In-Reply-To: <199f58740e42bbdbcba0c847c194f62d2b3bb37b.1582104018.git.viresh.kumar@linaro.org>
References: <cover.1582104018.git.viresh.kumar@linaro.org>
 <199f58740e42bbdbcba0c847c194f62d2b3bb37b.1582104018.git.viresh.kumar@linaro.org>
Message-ID: <CAEemH2e9fhUVU3DbpXCEimL0k8eGLuuSRcicq4NYOk_zELLqMw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> +int tst_ismount(const char *path)
> +{
> +       char line[256];
> +       FILE *file;
> +       int ret = -1;

+
> +       file = SAFE_FOPEN(NULL, "/proc/mounts", "r");
> +
> +       while (fgets(line, sizeof(line), file)) {
> +               if (strstr(line, path) != NULL) {
> +                       ret = 0;
> +                       break;
> +               }
> +       }
> +
> +       SAFE_FCLOSE(NULL, file);
> +
> +       if (ret) {
> +               errno = ENOENT;
> +               tst_resm(TWARN, "No device is mounted at %s", path);
> +       }
> +
> +       return ret;
>

Sorry, I think the return value should be '1' if it has been mounted
already.

e.g
These codes will make people confused about whether it's
mounted successfully or not.

if (tst_ismount(MNTPOINT))
        tst_brk(TBROK | TERRNO, "device not mounted");


+}
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200220/98197515/attachment.htm>
