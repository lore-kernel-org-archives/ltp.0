From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 9 Jan 2020 15:08:53 +0100
Subject: [LTP] [PATCH] tst_device: Scan /sys/block/* for stat file
In-Reply-To: <278a5c21-348e-5fd8-f33f-82e267028710@cn.fujitsu.com>
References: <20200108134807.27001-1-chrubis@suse.cz>
 <278a5c21-348e-5fd8-f33f-82e267028710@cn.fujitsu.com>
Message-ID: <20200109140853.GB27225@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > The current tst_dev_bytes_written() function works only for simple cases
> > where the block device is not divided into partitions. This patch fixes
> > that scannning the sysfiles for pattern /sys/block/*/devname/stat.
> > 
> > Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> > CC: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> > CC: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >   lib/tst_device.c | 33 ++++++++++++++++++++++++++++-----
> >   1 file changed, 28 insertions(+), 5 deletions(-)
> > 
> > diff --git a/lib/tst_device.c b/lib/tst_device.c
> > index 10f71901d..aca769559 100644
> > --- a/lib/tst_device.c
> > +++ b/lib/tst_device.c
> > @@ -373,16 +373,39 @@ int tst_umount(const char *path)
> >   	return -1;
> >   }
> >   
> > +int find_stat_file(const char *dev, char *path, size_t path_len)
> > +{
> > +	const char *devname = strrchr(dev, '/') + 1;
> > +
> > +	snprintf(path, path_len, "/sys/block/%s/stat", devname);
> > +
> > +	if (!access(path, F_OK))
> > +		return 1;
> > +
> > +	DIR *dir = SAFE_OPENDIR(NULL, "/sys/block/");
> > +	struct dirent *ent;
> > +
> > +	while ((ent = readdir(dir))) {
> > +		snprintf(path, path_len, "/sys/block/%s/%s/stat", ent->d_name, devname);
> > +
> > +		fprintf(stderr, "%s\n", path);
> > +
> It will make many noise when using .all_filesystem and we can remove it. 
> Other than, it looks good to me.

That's forgotten debug print, I should have removed that before sending.

-- 
Cyril Hrubis
chrubis@suse.cz
