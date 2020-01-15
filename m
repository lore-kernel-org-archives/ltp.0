From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 15 Jan 2020 11:39:51 +0100
Subject: [LTP] [PATCH] tst_device: Scan /sys/block/* for stat file
In-Reply-To: <20200109140853.GB27225@rei.lan>
References: <20200108134807.27001-1-chrubis@suse.cz>
 <278a5c21-348e-5fd8-f33f-82e267028710@cn.fujitsu.com>
 <20200109140853.GB27225@rei.lan>
Message-ID: <20200115103951.GA24851@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

...
> > > +int find_stat_file(const char *dev, char *path, size_t path_len)
> > > +{
> > > +	const char *devname = strrchr(dev, '/') + 1;
> > > +
> > > +	snprintf(path, path_len, "/sys/block/%s/stat", devname);
> > > +
> > > +	if (!access(path, F_OK))
> > > +		return 1;
> > > +
> > > +	DIR *dir = SAFE_OPENDIR(NULL, "/sys/block/");
> > > +	struct dirent *ent;
> > > +
> > > +	while ((ent = readdir(dir))) {
> > > +		snprintf(path, path_len, "/sys/block/%s/%s/stat", ent->d_name, devname);
> > > +
> > > +		fprintf(stderr, "%s\n", path);
> > > +
> > It will make many noise when using .all_filesystem and we can remove it. 
> > Other than, it looks good to me.

> That's forgotten debug print, I should have removed that before sending.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
