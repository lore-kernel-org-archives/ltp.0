From: Li Wang <liwang@redhat.com>
Date: Sat, 7 Mar 2020 20:42:47 +0800
Subject: [LTP] [PATCH V5 01/10] tst_device: Add tst_is_mounted() helper
In-Reply-To: <20200306124546.GA3375@rei.lan>
References: <cover.1582779464.git.viresh.kumar@linaro.org>
 <2071e47d7d8cb3e7f8bc6558e86999eddd9c3762.1582779464.git.viresh.kumar@linaro.org>
 <20200306124546.GA3375@rei.lan>
Message-ID: <CAEemH2drJyp5kU21jS7Ej+-q6hTysb5oDNM+3KiWsmPoLAbMQA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Mar 6, 2020 at 8:45 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> ...
> >
> > +int tst_is_mounted(const char *path)
> > +{
> > +     char cmd[PATH_MAX];
> > +     int ret;
> > +
> > +     snprintf(cmd, sizeof(cmd), "mountpoint -q %s", path);
> > +     ret = tst_system(cmd);
>
> I'm not sure that depending on mountpoint command is right choice, there
> are all kinds of embedded systems out there that may be missing it.


Good point, we'd better avoid involving other packages as the dependence of
LTP.


> Also this does not even handle the case that the command is missing.
>
> Looking at the v4 version, all we need is to correctly parse each line
> from from /proc/mounts. I would just use strsep() with space as a
> delimited and took first token that starts with a slash i.e. '/', then
> we can just strcmp() it against the path. Or do I miss something?
>

I'm afraid strcmp() can not satisfy the requirement for us. As you know LTP
creates the MNTPOINT in temp dir that means it could not accurately match
the string path which extracts from /proc/mounts with a slash.

e.g
#define MNTPOINT "fallocate"
...
/dev/loop4 on /tmp/FPp7kh/fallocate type xfs
(rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
...
strcmp("/tmp/FPp7kh/fallocate", MNTPOINT) will never ruturn 0 to us.

What I can think of is to use strrchr() to cut the string after last '/',
but that can only work for test mount fs in LTP ways. Other situations
might not satisfy.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200307/02bcfb77/attachment.htm>
