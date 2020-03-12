From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 12 Mar 2020 12:35:34 +0100
Subject: [LTP] [PATCH V5 01/10] tst_device: Add tst_is_mounted() helper
In-Reply-To: <20200312110340.y7mcfktrlgyzfui6@vireshk-i7>
References: <cover.1582779464.git.viresh.kumar@linaro.org>
 <2071e47d7d8cb3e7f8bc6558e86999eddd9c3762.1582779464.git.viresh.kumar@linaro.org>
 <20200306124546.GA3375@rei.lan>
 <CAEemH2drJyp5kU21jS7Ej+-q6hTysb5oDNM+3KiWsmPoLAbMQA@mail.gmail.com>
 <20200311102620.GB3802@rei.lan>
 <20200312110340.y7mcfktrlgyzfui6@vireshk-i7>
Message-ID: <20200312113534.GA28962@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Viresh,

> Is everyone fine with this code now :)

> int tst_is_mounted(const char *path)
> {
>         char line[PATH_MAX];
>         FILE *file;
>         int ret = 0;

>         file = SAFE_FOPEN(NULL, "/proc/mounts", "r");

>         while (fgets(line, sizeof(line), file)) {
>                 if (strstr(line, path) != NULL) {
>                         ret = 1;
>                         break;
>                 }
>         }

>         SAFE_FCLOSE(NULL, file);

>         if (!ret)
>                 tst_resm(TINFO, "No device is mounted at %s", path);

>         return ret;
> }

> int tst_is_mounted_at_tmpdir(const char *path)
> {
>         char cdir[PATH_MAX], mpath[PATH_MAX];
>         int ret;

>         if (!getcwd(cdir, PATH_MAX))
>                 return 0;
LGTM. I guess we can ignore this, but maybe tst_res(TWARN | TERRNO, "..."),
could be added here. But maybe it's not important.

>         ret = snprintf(mpath, PATH_MAX, "%s/%s", cdir, path);
>         if (ret < 0 || ret >= PATH_MAX)
>                 return 0;

>         return tst_is_mounted(mpath);
> }

Kind regards,
Petr
