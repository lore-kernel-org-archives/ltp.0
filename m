From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 30 Jul 2020 12:38:22 +0200
Subject: [LTP] [PATCH v3 2/2] syscalls/ioctl_loop05: Using
 LOOP_CONFIGURE to set direct io
In-Reply-To: <8d7cf7a7-1408-877c-05f2-e5566d7717d1@cn.fujitsu.com>
References: <20200722125946.GA22573@yuki.lan>
 <1595556357-29932-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1595556357-29932-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200729113946.GB7152@yuki.lan>
 <924c3fc1-c56c-a752-0720-bb12d6cf8ec0@cn.fujitsu.com>
 <20200730092802.GA3457@yuki.lan>
 <8d7cf7a7-1408-877c-05f2-e5566d7717d1@cn.fujitsu.com>
Message-ID: <20200730103822.GC3457@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> index 8d8bc5b40..bdd93f19e 100644
> --- a/lib/tst_device.c
> +++ b/lib/tst_device.c
> @@ -497,17 +497,30 @@ unsigned long tst_dev_bytes_written(const char *dev)
> 
>   void tst_find_backing_dev(const char *path, char *dev)
>   {
> -       char fmt[1024];
> +       char fmt[20];
>          struct stat buf;
> +       FILE *file;
> +       char line[PATH_MAX];
> +       char *pre = NULL;
> +       char *next = NULL;
> 
>          if (stat(path, &buf) < 0)
>                   tst_brkm(TWARN | TERRNO, NULL, "stat() failed");
> 
> -       snprintf(fmt, sizeof(fmt), "%%*i %%*i %u:%u %%*s %%*s %%*s %%*s 
> %%*s %%*s %%s %%*s",
> -                       major(buf.st_dev), minor(buf.st_dev));
> +       snprintf(fmt, sizeof(fmt), "%u:%u", major(buf.st_dev), 
> minor(buf.st_dev));
> +       file = SAFE_FOPEN(NULL, "/proc/self/mountinfo", "r");
> 
> -       SAFE_FILE_LINES_SCANF(NULL, "/proc/self/mountinfo", fmt, dev);
> +       while (fgets(line, sizeof(line), file)) {
> +               if (strstr(line, fmt) != NULL) {
> +                       pre = strstr(line, " - ");
> +                       pre = strtok_r(pre, " ", &next);
> +                       pre = strtok_r(NULL, " ", &next);
> +                       pre = strtok_r(NULL, " ", &next);
> +                       strcpy(dev, pre);

We should break; here as well, since we already found the result.

> +               }
> +       }
> 
> +       SAFE_FCLOSE(NULL, file);
>          if (stat(dev, &buf) < 0)
>                   tst_brkm(TWARN | TERRNO, NULL, "stat(%s) failed", dev);

Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
