From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 20 Feb 2020 12:49:23 +0530
Subject: [LTP] [PATCH V2 01/10] tst_device: Add tst_ismount() helper
In-Reply-To: <CAEemH2e9fhUVU3DbpXCEimL0k8eGLuuSRcicq4NYOk_zELLqMw@mail.gmail.com>
References: <cover.1582104018.git.viresh.kumar@linaro.org>
 <199f58740e42bbdbcba0c847c194f62d2b3bb37b.1582104018.git.viresh.kumar@linaro.org>
 <CAEemH2e9fhUVU3DbpXCEimL0k8eGLuuSRcicq4NYOk_zELLqMw@mail.gmail.com>
Message-ID: <20200220071923.vyr7lpftidkgbi6g@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 20-02-20, 15:06, Li Wang wrote:
> > +int tst_ismount(const char *path)
> > +{
> > +       char line[256];
> > +       FILE *file;
> > +       int ret = -1;
> 
> +
> > +       file = SAFE_FOPEN(NULL, "/proc/mounts", "r");
> > +
> > +       while (fgets(line, sizeof(line), file)) {
> > +               if (strstr(line, path) != NULL) {
> > +                       ret = 0;
> > +                       break;
> > +               }
> > +       }
> > +
> > +       SAFE_FCLOSE(NULL, file);
> > +
> > +       if (ret) {
> > +               errno = ENOENT;
> > +               tst_resm(TWARN, "No device is mounted at %s", path);
> > +       }
> > +
> > +       return ret;
> >
> 
> Sorry, I think the return value should be '1' if it has been mounted
> already.
> 
> e.g
> These codes will make people confused about whether it's
> mounted successfully or not.
> 
> if (tst_ismount(MNTPOINT))
>         tst_brk(TBROK | TERRNO, "device not mounted");

I kept the return 0 on success thing here as well, but maybe yeah, it
should return 1 on success here.

-- 
viresh
